# verify.py — Verification Pipeline Reference

`verify.py` is the canonical way to check the mod. It is a single bounded tool
that loads creative-mod in the local Factorio install, runs assertions, and
exits `0`/non-zero with a stable, greppable `RESULT:` line so an agent can
edit → verify → read result → iterate without a human. **Local only** (not CI).

Run it via `uv` (it has a PEP 723 inline header; stdlib only, `rcon.py` and
`sandbox.py` imported as local modules):

```bash
uv run verify.py <subcommand> [flags]
```

## The RESULT / exit-code contract

Every subcommand prints **exactly one** line of the form:

```
RESULT: <name>=PASS
RESULT: <name>=FAIL (reason)
```

and exits `0` on PASS, non-zero on FAIL. To drive it programmatically, grep for
`^RESULT:` and/or check `$?`. The `reason` names the failing tool / assertion /
phase, e.g.:

```
RESULT: static=FAIL (luacheck=PASS stylua=FAIL)
RESULT: load=FAIL (control stage incomplete)
RESULT: behavior=FAIL (assert storage_initialized)
RESULT: all=FAIL (static=PASS load=PASS behavior=FAIL)
```

Layered subcommands also print their per-step lines (e.g. `assert
storage_initialized=PASS (...)`) before the final `RESULT:` line, so partial
progress is visible.

## Subcommands

| Subcommand | What it does | Layer |
|---|---|---|
| `doctor` | Preflight: Factorio binary + `--version`, `uv`, `jq` on PATH. Distinguishes "install problem" from "mod problem". | preflight |
| `static` | Wraps `luacheck .` + `stylua --check .` (same invocations as `lint.yml`); excludes the gitignored `.debug/` sandbox from luacheck so the local result matches a clean checkout. | static |
| `load` | Bootstraps the `.debug/` sandbox, runs the bounded `--create` data+control stage, scans the log for `^Error`, and asserts the control-stage sentinel `CREATIVE_MOD_CONTROL_OK` is present (guards the silent control-crash case). | load |
| `behavior` | Boots the headless server, polls RCON until it answers, runs a read-only assertion batch, then terminates + reaps under a watchdog. | behavior |
| `all` | Runs `static` → `load` → `behavior` in sequence and aggregates into one `RESULT: all=…` line. | all |
| `debug` | Bounded, scriptable headless session: boot server, poll RCON, optional one-shot `--command`, reap under a watchdog. `--gui` is the manual-only graphical escape hatch. | tooling |
| `shell` | Bounded RCON pass-through: one-shot command argument, or stdin REPL (auto-prefixes `/c`). Attaches to a running server or starts a bounded one. | tooling |

### Flags

- `static` — no flags.
- `load` — `--clean` (recreate the debug save from scratch; default reuses for a
  fast loop), `--timeout <s>` (hard timeout for `--create`, default `180`).
- `behavior` / `all` / `debug` / `shell` — `--clean`, `--timeout <s>`, and
  `--ready-timeout <s>` (hard timeout to wait for the server to answer RCON,
  default `120`).
- `debug` additionally — `--command '<rcon cmd>'` (one-shot, run once ready) and
  `--gui` (manual-only full graphical client; blocks, needs a display).
- `shell` additionally — a positional `command` argument (one-shot); omit it to
  read commands from stdin.

### Examples

```bash
uv run verify.py doctor
uv run verify.py static
uv run verify.py load
uv run verify.py load --clean
uv run verify.py behavior
uv run verify.py all
uv run verify.py shell '/c rcon.print(game.tick)'
uv run verify.py debug --command '/c rcon.print(tostring(remote.call("creative-mode", "is_enabled")))'
uv run verify.py debug --gui      # manual escape hatch
```

## The behavior assertion batch (read-only)

Assertions run in the **mod's** context via the remote interface — a bare `/c`
runs in the *scenario* script context, where `storage` is the scenario's
storage, not creative-mod's. So the batch drives the mod's own interface:

- `storage_initialized` — `remote.call("creative-mode", "is_enabled")` succeeds
  (`on_init` ran to completion → runtime confirmation of the silent-crash guard).
- `default_disabled` — that same call returns `false` (creative mode off by
  default).

The batch is fully read-only for now; the GUI-driven "enable all cheats" path is
out of scope (no connected player on a headless server).

## Replicable local install setup

The verifier assumes a working local Factorio install is present; it does not
install Factorio. `verify.py doctor` is the runnable companion that confirms the
prerequisites below. To reproduce the environment on a new machine:

### Factorio binary

- **Factorio 2.1.7** (full install — the base mods `base`, `elevated-rails`,
  `quality`, `space-age` ship with it, so no mod provisioning step is needed).
- The binary path is **fixed and self-located** relative to the mod:
  `../../bin/x64/factorio` (resolved from `verify.py`'s own location, exactly as
  the old shell launcher derived it from `SCRIPT_DIR`). Nothing is read from
  environment variables.

### Tooling on PATH

- **`uv`** — runs `verify.py` via its PEP 723 inline header.
- **`jq`** — used in the toolchain (and checked by `doctor`).
- **`stylua`** — Lua formatter; `static` runs `stylua --check .`. It skips
  gitignored paths automatically.
- **`luacheck`** — Lua linter; `static` runs `luacheck .`. **It must be built
  against Lua 5.3** — it crashes under the system Lua 5.5. Install it via
  luarocks pinned to Lua 5.3, into the per-user tree:

  ```bash
  luarocks --lua-version=5.3 install luacheck --local
  ```

  This puts the `luacheck` binary under `~/.luarocks/bin`, which **must be on
  `PATH`** for `verify.py static` (and `doctor`'s assumptions) to find it:

  ```bash
  export PATH="$HOME/.luarocks/bin:$PATH"
  ```

### Sandbox paths (created by `sandbox.py`)

`verify.py` stands up an isolated `.debug/` sandbox next to the mod (gitignored,
absent in CI):

```
.debug/
├── config/config.ini      # read-data → factorio/data, write-data → .debug/
├── mods/
│   ├── creative-mod_<version> → ../../   (symlink to the live working tree)
│   ├── mod-list.json          # copied from mods_dev/
│   └── mod-settings.dat       # copied from mods_dev/ (if present)
├── saves/debug-save.zip       # the live debug save
├── factorio-current.log       # game + Lua log
├── console.log                # server console / RCON command log
└── script-output/             # helpers.write_file() output
```

The live-tree symlink means edits are instant (no packaging step). The symlink is
re-pointed each run to the current version, and stale differently-versioned
symlinks are pruned. RCON runs on port `27015` with password `factorio-debug`.
