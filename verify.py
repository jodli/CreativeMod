# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///
"""
verify.py — Local agent-driven verification pipeline for creative-mod.

A single bounded tool that loads the mod in the maintainer's local Factorio
install, runs assertions, and exits 0/non-zero with a stable, greppable
``RESULT:`` summary so an autonomous agent can edit -> verify -> read result ->
iterate without a human.

Run it via uv:

    uv run verify.py doctor
    uv run verify.py static
    uv run verify.py --help

This is local-only tooling (not CI). Paths are derived from this file's own
location exactly like debug.sh derives them from SCRIPT_DIR; nothing is read
from environment variables.

Subcommands:
    doctor    Preflight: Factorio binary + version, uv, jq on PATH.
    static    Wrap luacheck . and stylua --check . (same invocations as lint.yml).
    load      (Phase 2) data + control load gate.
    behavior  (Phase 3) headless server + RCON assertion batch.
    all       (Phase 3) static -> load -> behavior in sequence.
    debug     (Phase 4) bounded scriptable successor to debug.sh.
    shell     (Phase 4) bounded RCON pass-through (successor to rcon-shell.sh).

Result contract:
    Every subcommand prints exactly one ``RESULT: <name>=PASS`` or
    ``RESULT: <name>=FAIL (reason)`` line and exits 0 on success / non-zero on
    failure.
"""

import argparse
import json
import re
import shutil
import subprocess
import sys
from pathlib import Path

import sandbox

# ---------------------------------------------------------------------------
# Self-locating paths (mirrors debug.sh's SCRIPT_DIR-derived layout)
# ---------------------------------------------------------------------------
ROOT = Path(__file__).resolve().parent
FACTORIO_BIN = (ROOT / ".." / ".." / "bin" / "x64" / "factorio").resolve()
MODS_DEV_DIR = (ROOT / "..").resolve()
INFO = json.loads((ROOT / "info.json").read_text())
VERSIONED_NAME = f"{INFO['name']}_{INFO['version']}"


# ---------------------------------------------------------------------------
# Result / exit-code contract
# ---------------------------------------------------------------------------
def result(name: str, ok: bool, detail: str = "") -> int:
    """Print the stable, greppable RESULT line and return the exit code.

    Success prints ``RESULT: <name>=PASS`` and returns 0.
    Failure prints ``RESULT: <name>=FAIL (detail)`` and returns 1.
    """
    if ok:
        print(f"RESULT: {name}=PASS")
        return 0
    suffix = f" ({detail})" if detail else ""
    print(f"RESULT: {name}=FAIL{suffix}")
    return 1


# ---------------------------------------------------------------------------
# doctor — preflight: distinguish "install problem" from "mod problem"
# ---------------------------------------------------------------------------
def cmd_doctor(args: argparse.Namespace) -> int:
    problems: list[str] = []

    # Factorio binary present + executable, and reports a version.
    factorio_version: str | None = None
    if not FACTORIO_BIN.exists():
        problems.append(f"factorio binary missing at {FACTORIO_BIN}")
    elif not FACTORIO_BIN.is_file():
        problems.append(f"factorio binary not a file: {FACTORIO_BIN}")
    else:
        try:
            proc = subprocess.run(
                [str(FACTORIO_BIN), "--version"],
                capture_output=True,
                text=True,
                timeout=30,
            )
        except PermissionError:
            problems.append(f"factorio binary not executable: {FACTORIO_BIN}")
        except (OSError, subprocess.TimeoutExpired) as exc:
            problems.append(f"factorio --version failed: {exc}")
        else:
            if proc.returncode != 0:
                problems.append(f"factorio --version exited {proc.returncode}")
            else:
                # First line looks like: "Version: 2.1.7 (build ..., linux64, full)"
                first = proc.stdout.strip().splitlines()[0] if proc.stdout.strip() else ""
                factorio_version = first.split("Version:", 1)[-1].strip() if "Version:" in first else first
                print(f"factorio: {factorio_version or '(version unknown)'}  [{FACTORIO_BIN}]")

    # uv and jq must be on PATH.
    for tool in ("uv", "jq"):
        path = shutil.which(tool)
        if path is None:
            problems.append(f"{tool} not on PATH")
        else:
            print(f"{tool}: {path}")

    if problems:
        return result("doctor", False, "; ".join(problems))
    return result("doctor", True)


# ---------------------------------------------------------------------------
# static — wrap luacheck + stylua --check (same invocations as lint.yml)
# ---------------------------------------------------------------------------
def _run_tool(tool: str, tool_args: list[str]) -> tuple[bool, str]:
    """Run a static-analysis tool from the repo root.

    Returns (ok, detail). A missing tool is treated as a failure with a clear
    reason so the agent can distinguish "tool not installed" from "lint error".
    """
    exe = shutil.which(tool)
    if exe is None:
        return False, "not found"
    proc = subprocess.run(
        [exe, *tool_args],
        cwd=str(ROOT),
        capture_output=True,
        text=True,
    )
    # Surface the tool's own output so the agent can see what failed.
    if proc.stdout:
        sys.stdout.write(proc.stdout)
    if proc.stderr:
        sys.stderr.write(proc.stderr)
    return proc.returncode == 0, ""


def cmd_static(args: argparse.Namespace) -> int:
    # Same invocations as lint.yml (luacheck . / stylua --check .), but exclude
    # the local .debug/ sandbox: it is gitignored (absent in CI, where these
    # checks pass) and contains the symlinked live tree plus base mods. stylua
    # already skips gitignored paths; luacheck does not, so exclude it explicitly
    # to keep the local result identical to a clean checkout.
    luacheck_ok, luacheck_detail = _run_tool("luacheck", [".", "--exclude-files", ".debug/**"])
    stylua_ok, stylua_detail = _run_tool("stylua", ["--check", "."])

    if luacheck_ok and stylua_ok:
        return result("static", True)

    def label(name: str, ok: bool, detail: str) -> str:
        if ok:
            return f"{name}=PASS"
        return f"{name}=FAIL({detail})" if detail else f"{name}=FAIL"

    detail = f"{label('luacheck', luacheck_ok, luacheck_detail)} {label('stylua', stylua_ok, stylua_detail)}"
    return result("static", False, detail)


# ---------------------------------------------------------------------------
# Stubs for later phases (registered so --help lists every subcommand)
# ---------------------------------------------------------------------------
def _not_implemented(name: str) -> int:
    return result(name, False, "not implemented yet")


def cmd_load(args: argparse.Namespace) -> int:
    """Cheap data + control load gate.

    Bootstraps the .debug/ sandbox, runs the bounded --create data+control stage,
    then evaluates the captured factorio-current.log:
      - any ``^Error`` line  -> data/control error (real load failure)
      - sentinel absent       -> control stage incomplete (silent mid-require crash)
    Otherwise the mod loaded cleanly and the control stage ran to completion.
    """
    sb = sandbox.bootstrap_sandbox(clean=getattr(args, "clean", False))
    log = sandbox.run_create(sb, timeout=args.timeout)

    # Factorio can exit 0 even when a prototype/control error is logged, so scan
    # the log text directly. Lines look like "  12.345 Error ...".
    if re.search(r"^\s*[\d.:]+\s*Error", log, re.M):
        match = re.search(r"^\s*[\d.:]+\s*Error.*$", log, re.M)
        detail = "data/control error"
        if match:
            detail = f"data/control error: {match.group(0).strip()}"
        return result("load", False, detail)

    if "CREATIVE_MOD_CONTROL_OK" not in log:
        return result("load", False, "control stage incomplete")

    return result("load", True)


def cmd_behavior(args: argparse.Namespace) -> int:
    return _not_implemented("behavior")


def cmd_all(args: argparse.Namespace) -> int:
    return _not_implemented("all")


def cmd_debug(args: argparse.Namespace) -> int:
    return _not_implemented("debug")


def cmd_shell(args: argparse.Namespace) -> int:
    return _not_implemented("shell")


# ---------------------------------------------------------------------------
# Dispatcher
# ---------------------------------------------------------------------------
def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="verify.py",
        description="Local agent-driven verification pipeline for creative-mod.",
    )
    sub = parser.add_subparsers(dest="command", required=True, metavar="subcommand")

    sub.add_parser("static", help="luacheck . + stylua --check .").set_defaults(func=cmd_static)

    load_parser = sub.add_parser("load", help="data + control load gate")
    load_parser.add_argument(
        "--clean",
        action="store_true",
        help="recreate the debug save from scratch (default reuses for a fast loop)",
    )
    load_parser.add_argument(
        "--timeout",
        type=float,
        default=180.0,
        help="hard timeout (seconds) for the --create stage (default: 180)",
    )
    load_parser.set_defaults(func=cmd_load)

    sub.add_parser("behavior", help="(phase 3) headless server + RCON assertions").set_defaults(func=cmd_behavior)
    sub.add_parser("all", help="(phase 3) static -> load -> behavior").set_defaults(func=cmd_all)
    sub.add_parser("debug", help="(phase 4) bounded scriptable debug session").set_defaults(func=cmd_debug)
    sub.add_parser("shell", help="(phase 4) bounded RCON pass-through").set_defaults(func=cmd_shell)
    sub.add_parser("doctor", help="preflight: factorio binary/version, uv, jq").set_defaults(func=cmd_doctor)

    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    raise SystemExit(main())
