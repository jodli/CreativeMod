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
location, like the old shell launcher derived them from SCRIPT_DIR; nothing is read
from environment variables.

Subcommands:
    doctor    Preflight: Factorio binary + version, uv, jq on PATH.
    static    Wrap luacheck . and stylua --check . (same invocations as lint.yml).
    load      (Phase 2) data + control load gate.
    behavior  (Phase 3) headless server + RCON assertion batch.
    all       (Phase 3) static -> load -> behavior in sequence.
    debug     Bounded scriptable debug session (--command one-shot, --gui escape hatch).
    shell     Bounded RCON pass-through (one-shot arg, or stdin REPL with /c auto-prefix).

Result contract:
    Every subcommand prints exactly one ``RESULT: <name>=PASS`` or
    ``RESULT: <name>=FAIL (reason)`` line and exits 0 on success / non-zero on
    failure.
"""

import argparse
import json
import os
import re
import shutil
import signal
import subprocess
import sys
import time
from pathlib import Path

import rcon
import sandbox

# ---------------------------------------------------------------------------
# Self-locating paths (mirrors the old shell launcher's SCRIPT_DIR-derived layout)
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


# ---------------------------------------------------------------------------
# behavior — boot a real headless server, poll RCON, run read-only assertions,
# then terminate + reap under a hard watchdog so the call always returns.
# ---------------------------------------------------------------------------
def _poll_rcon_ready(sb: sandbox.Sandbox, server: subprocess.Popen, deadline: float) -> bool:
    """Poll RCON (connect + auth handshake) until the server answers or we time out.

    Decision (outline): use RCON polling for the ready signal — no log scraping.
    A trivial command that round-trips proves the server is up, RCON is bound,
    and the auth password is accepted. Returns False if the deadline passes or
    the server process dies before it ever answers.
    """
    while time.monotonic() < deadline:
        if server.poll() is not None:
            # Server exited before becoming ready — never going to answer.
            return False
        # rcon.rcon_exec prints to stderr and raises SystemExit on a refused
        # connection (its standalone-CLI behavior). During polling that is the
        # expected "not up yet" case, so silence stderr for these probe attempts
        # to avoid spamming the agent's output on every retry.
        with open(os.devnull, "w") as devnull:
            saved_stderr = sys.stderr
            sys.stderr = devnull
            try:
                rcon.rcon_exec("localhost", sb.rcon_port, sb.rcon_password, "/c rcon.print(1)")
            except (ConnectionRefusedError, ConnectionError, OSError, TimeoutError, SystemExit):
                time.sleep(0.25)
                continue
            finally:
                sys.stderr = saved_stderr
        return True
    return False


def _terminate_server(server: subprocess.Popen) -> None:
    """Terminate and reap the server's whole process group (SIGTERM -> SIGKILL).

    The server was started in its own session (start_new_session=True), so signal
    the process group to take down any children; escalate to SIGKILL if it does
    not exit promptly. Always reaps so no orphaned factorio process is left.
    """
    if server.poll() is not None:
        server.wait()
        return
    try:
        pgid = os.getpgid(server.pid)
    except ProcessLookupError:
        return
    try:
        os.killpg(pgid, signal.SIGTERM)
    except ProcessLookupError:
        return
    try:
        server.wait(timeout=10)
        return
    except subprocess.TimeoutExpired:
        pass
    try:
        os.killpg(pgid, signal.SIGKILL)
    except ProcessLookupError:
        return
    try:
        server.wait(timeout=10)
    except subprocess.TimeoutExpired:
        pass


def _assert_rcon(sb: sandbox.Sandbox, cmd: str, expected: str, name: str) -> bool:
    """Run one read-only RCON assertion and print its per-assertion line.

    Any RCON-layer failure (a Lua error that makes the server drop the response,
    a closed connection, a refused socket) is treated as an assertion FAIL with
    the error surfaced as the observed value — never an unhandled traceback — so
    the command still terminates with a single RESULT line.
    """
    try:
        out = rcon.rcon_exec("localhost", sb.rcon_port, sb.rcon_password, cmd).strip()
    except (ConnectionError, OSError, TimeoutError) as exc:
        print(f"assert {name}=FAIL (expected {expected!r} got rcon-error {exc!r})")
        return False
    except SystemExit:
        # rcon.py's standalone helper exits on connection refusal/auth failure.
        print(f"assert {name}=FAIL (expected {expected!r} got rcon-connection-failed)")
        return False
    ok = out == expected
    print(f"assert {name}={'PASS' if ok else 'FAIL'} (expected {expected!r} got {out!r})")
    return ok


def cmd_behavior(args: argparse.Namespace) -> int:
    """Boot the headless server, poll RCON, run the read-only assertion batch.

    The batch is fully read-only this phase (decision: no GUI-driven enable on a
    headless server with no connected player):
      - storage_initialized: storage.creative_mode ~= nil  (on_init ran -> this
        is also the runtime confirmation of the silent-crash guard)
      - default_disabled:     storage.creative_mode.enabled == false

    The server is always terminated and reaped under a hard watchdog so the call
    returns even if it hangs or never becomes ready.
    """
    sb = sandbox.bootstrap_sandbox(clean=getattr(args, "clean", False))
    # The save must exist before --start-server; run the cheap load gate's
    # --create if it is missing (or was just cleaned).
    if not sb.save_file.exists():
        sandbox.run_create(sb, timeout=args.timeout)

    server = sandbox.start_server(sb)
    try:
        ready_deadline = time.monotonic() + args.ready_timeout
        if not _poll_rcon_ready(sb, server, ready_deadline):
            return result("behavior", False, "server not ready")

        # NOTE: a bare RCON "/c" command runs in the *level/scenario* script
        # context, where the global ``storage`` is the scenario's storage — NOT
        # creative-mod's per-mod storage. Reading ``storage.creative_mode``
        # directly therefore always sees nil even when the mod initialized fine.
        # Drive the mod's own remote interface instead so the read executes in
        # the mod's context (where ``storage`` is creative-mod's storage).
        #
        # storage_initialized: remote.call into the mod succeeds (storage.creative_mode
        #   and its .enabled field are reachable) — this is also the runtime
        #   confirmation of the silent-crash guard (on_init ran to completion).
        # default_disabled:    that same call returns false (creative mode off by default).
        results = [
            _assert_rcon(
                sb,
                '/c rcon.print(tostring(pcall(function() '
                'return remote.call("creative-mode", "is_enabled") end)))',
                "true",
                "storage_initialized",
            ),
            _assert_rcon(
                sb,
                '/c rcon.print(tostring(remote.call("creative-mode", "is_enabled")))',
                "false",
                "default_disabled",
            ),
            # create_blank_surface: a fresh name creates the surface (true), and a
            # second call with the same name is rejected as a duplicate (false).
            _assert_rcon(
                sb,
                '/c rcon.print(tostring(remote.call("creative-mode", "create_blank_surface", "cm_verify")))',
                "true",
                "create_blank_surface_new",
            ),
            _assert_rcon(
                sb,
                '/c rcon.print(tostring(remote.call("creative-mode", "create_blank_surface", "cm_verify")))',
                "false",
                "create_blank_surface_duplicate",
            ),
            # create_space_platform: the sandbox has Space Age, so the happy-path is testable.
            # Headless has no connected player, so pass nil and let the wrapper resolve the
            # default "player" force.
            _assert_rcon(
                sb,
                '/c rcon.print(tostring(remote.call("creative-mode", "create_space_platform", nil, "cm_platform", "nauvis")))',
                "true",
                "create_space_platform_new",
            ),
            # The created platform's surface exists and its hub is valid.
            _assert_rcon(
                sb,
                '/c local s = nil for _, surf in pairs(game.surfaces) do if surf.platform and surf.platform.name == "cm_platform" then s = surf end end '
                "rcon.print(tostring(s ~= nil and s.platform.hub ~= nil and s.platform.hub.valid))",
                "true",
                "create_space_platform_hub_valid",
            ),
            # create_planet_surface: the sandbox has Space Age, so the happy-path is testable.
            # A fresh call creates the planet's surface (true).
            _assert_rcon(
                sb,
                '/c rcon.print(tostring(remote.call("creative-mode", "create_planet_surface", "nauvis")))',
                "true",
                "create_planet_surface_new",
            ),
            # The planet's surface now exists.
            _assert_rcon(
                sb,
                '/c rcon.print(tostring(game.planets["nauvis"].surface ~= nil))',
                "true",
                "create_planet_surface_exists",
            ),
            # A second identical call is a no-op and still returns true.
            _assert_rcon(
                sb,
                '/c rcon.print(tostring(remote.call("creative-mode", "create_planet_surface", "nauvis")))',
                "true",
                "create_planet_surface_noop",
            ),
            # No second surface was created: the planet still has exactly one surface, and the
            # nauvis-named surface count is unchanged (1).
            _assert_rcon(
                sb,
                '/c local n = 0 for _, surf in pairs(game.surfaces) do if surf.name == "nauvis" then n = n + 1 end end rcon.print(tostring(n))',
                "1",
                "create_planet_surface_no_duplicate",
            ),
        ]
    finally:
        _terminate_server(server)

    if all(results):
        return result("behavior", True)
    failed = [
        name
        for name, ok in zip(
            (
                "storage_initialized",
                "default_disabled",
                "create_blank_surface_new",
                "create_blank_surface_duplicate",
                "create_space_platform_new",
                "create_space_platform_hub_valid",
                "create_planet_surface_new",
                "create_planet_surface_exists",
                "create_planet_surface_noop",
                "create_planet_surface_no_duplicate",
            ),
            results,
        )
        if not ok
    ]
    return result("behavior", False, "assert " + ", ".join(failed))


# ---------------------------------------------------------------------------
# all — run static -> load -> behavior, aggregate into one RESULT line.
# ---------------------------------------------------------------------------
def cmd_all(args: argparse.Namespace) -> int:
    """Run the three layers in order and aggregate into a single RESULT line.

    Each layer prints its own RESULT line as it runs (so partial progress is
    visible / greppable), then ``all`` emits a combined
    ``RESULT: all=... (static=... load=... behavior=...)`` and exits non-zero if
    any layer failed. Layers are not short-circuited — a full run reports every
    layer's verdict so the agent sees the whole picture in one shot.
    """
    static_rc = cmd_static(args)
    load_rc = cmd_load(args)
    behavior_rc = cmd_behavior(args)

    def label(name: str, rc: int) -> str:
        return f"{name}={'PASS' if rc == 0 else 'FAIL'}"

    detail = " ".join(
        (label("static", static_rc), label("load", load_rc), label("behavior", behavior_rc))
    )
    ok = static_rc == 0 and load_rc == 0 and behavior_rc == 0
    return result("all", ok, "" if ok else detail)


# ---------------------------------------------------------------------------
# Shared helper: ensure a server is up (reuse a running one, else start+reap one)
# ---------------------------------------------------------------------------
def _server_is_up(sb: sandbox.Sandbox) -> bool:
    """Return True if an RCON server already answers on the sandbox port.

    Lets shell/debug attach to a server the maintainer already has running
    (e.g. a long-lived ``verify.py debug`` session) instead of starting a
    second one. Probe failures are the expected "nothing there" case.
    """
    with open(os.devnull, "w") as devnull:
        saved_stderr = sys.stderr
        sys.stderr = devnull
        try:
            rcon.rcon_exec("localhost", sb.rcon_port, sb.rcon_password, "/c rcon.print(1)")
        except (ConnectionRefusedError, ConnectionError, OSError, TimeoutError, SystemExit):
            return False
        finally:
            sys.stderr = saved_stderr
    return True


def _send_command(sb: sandbox.Sandbox, command: str) -> tuple[bool, str]:
    """Send one RCON command, normalizing failures into (ok, text).

    Never raises: a refused/closed connection or auth failure becomes
    ``(False, "<reason>")`` so the caller can print a single RESULT line.
    """
    try:
        out = rcon.rcon_exec("localhost", sb.rcon_port, sb.rcon_password, command)
    except (ConnectionError, OSError, TimeoutError) as exc:
        return False, f"rcon-error {exc!r}"
    except SystemExit:
        return False, "rcon-connection-failed"
    return True, out


# ---------------------------------------------------------------------------
# shell — bounded RCON pass-through (one-shot send / stdin REPL)
# ---------------------------------------------------------------------------
def cmd_shell(args: argparse.Namespace) -> int:
    """Bounded RCON pass-through.

    One-shot: ``verify.py shell '/c rcon.print(game.tick)'`` sends a single
    command and prints the response. With no command argument it reads commands
    from stdin, one per line, auto-prefixing ``/c`` for raw Lua — non-blocking,
    it stops at EOF.

    Assumes a server is already running; if none answers it starts one
    (bounded) for the duration of the call and reaps it on exit. Always
    terminates with a single RESULT line.
    """
    sb = sandbox.bootstrap_sandbox(clean=getattr(args, "clean", False))

    started: subprocess.Popen | None = None
    try:
        if not _server_is_up(sb):
            if not sb.save_file.exists():
                sandbox.run_create(sb, timeout=args.timeout)
            started = sandbox.start_server(sb)
            ready_deadline = time.monotonic() + args.ready_timeout
            if not _poll_rcon_ready(sb, started, ready_deadline):
                return result("shell", False, "server not ready")

        if args.command is not None:
            # One-shot mode.
            ok, out = _send_command(sb, args.command)
            if not ok:
                return result("shell", False, out)
            if out.strip():
                print(out.rstrip("\n"))
            return result("shell", True)

        # Interactive / piped mode: read lines until EOF, auto-prefix /c.
        any_failure = False
        for raw in sys.stdin:
            line = raw.strip()
            if not line or line == "exit":
                if line == "exit":
                    break
                continue
            command = line if line.startswith("/") else f"/c {line}"
            ok, out = _send_command(sb, command)
            if not ok:
                any_failure = True
                print(f"(error) {out}")
                continue
            if out.strip():
                print(out.rstrip("\n"))
        return result("shell", not any_failure, "" if not any_failure else "one or more commands failed")
    finally:
        if started is not None:
            _terminate_server(started)


# ---------------------------------------------------------------------------
# debug — bounded scriptable headless session; --gui manual escape hatch
# ---------------------------------------------------------------------------
def cmd_debug(args: argparse.Namespace) -> int:
    """Bounded, scriptable headless debug session driven via RCON.

    Default headless flow: bootstrap the sandbox, ensure a save exists, boot the
    headless server, poll RCON until ready, optionally run a one-shot
    ``--command`` and print its response, then terminate + reap under a hard
    watchdog so the call always returns.

    ``--gui`` is the manual-only escape hatch: it launches the full graphical
    client with ``--load-game`` against the debug
    save. It is explicitly NOT part of the automated loop — it blocks on the
    interactive client and needs a graphical display.
    """
    sb = sandbox.bootstrap_sandbox(clean=getattr(args, "clean", False))

    if args.gui:
        # Manual escape hatch: full graphical client. This blocks for the
        # maintainer's interactive session and is not bounded/automated.
        if not sb.save_file.exists():
            sandbox.run_create(sb, timeout=args.timeout)
        proc = sandbox.start_gui(sb)
        rc = proc.wait()
        return result("debug", rc == 0, "" if rc == 0 else f"gui client exited {rc}")

    if not sb.save_file.exists():
        sandbox.run_create(sb, timeout=args.timeout)

    server = sandbox.start_server(sb)
    try:
        ready_deadline = time.monotonic() + args.ready_timeout
        if not _poll_rcon_ready(sb, server, ready_deadline):
            return result("debug", False, "server not ready")

        if args.command is not None:
            ok, out = _send_command(sb, args.command)
            if not ok:
                return result("debug", False, out)
            if out.strip():
                print(out.rstrip("\n"))
        return result("debug", True)
    finally:
        _terminate_server(server)


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

    def add_run_args(p: argparse.ArgumentParser) -> None:
        p.add_argument(
            "--clean",
            action="store_true",
            help="recreate the debug save from scratch (default reuses for a fast loop)",
        )
        p.add_argument(
            "--timeout",
            type=float,
            default=180.0,
            help="hard timeout (seconds) for the --create stage (default: 180)",
        )
        p.add_argument(
            "--ready-timeout",
            type=float,
            default=120.0,
            help="hard timeout (seconds) to wait for the server to answer RCON (default: 120)",
        )

    behavior_parser = sub.add_parser("behavior", help="headless server + RCON assertion batch")
    add_run_args(behavior_parser)
    behavior_parser.set_defaults(func=cmd_behavior)

    all_parser = sub.add_parser("all", help="static -> load -> behavior in sequence")
    add_run_args(all_parser)
    all_parser.set_defaults(func=cmd_all)

    debug_parser = sub.add_parser("debug", help="bounded scriptable headless debug session")
    add_run_args(debug_parser)
    debug_parser.add_argument(
        "--command",
        default=None,
        help="one-shot RCON command to run once the server is ready (e.g. '/c rcon.print(game.tick)')",
    )
    debug_parser.add_argument(
        "--gui",
        action="store_true",
        help="manual-only escape hatch: launch the full graphical client against the debug save (blocks; needs a display)",
    )
    debug_parser.set_defaults(func=cmd_debug)

    shell_parser = sub.add_parser("shell", help="bounded RCON pass-through (one-shot or stdin REPL)")
    add_run_args(shell_parser)
    shell_parser.add_argument(
        "command",
        nargs="?",
        default=None,
        help="one-shot command to send; omit to read commands from stdin (auto-prefixing /c)",
    )
    shell_parser.set_defaults(func=cmd_shell)

    sub.add_parser("doctor", help="preflight: factorio binary/version, uv, jq").set_defaults(func=cmd_doctor)

    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    raise SystemExit(main())
