# Factorio Mod Debugging Reference

## The two stages

**Data stage** (`data.lua`, `data-final-fixes.lua`): defines prototypes. Runs at startup.
Errors surface immediately during `--create`. One error per run, full file + line.

**Control stage** (`control.lua`, `scripts/`): runs when loading the world.
Errors appear in `factorio-current.log` just after the script checksum lines.

## Protocol

1. `uv run verify.py load` → data + control load gate. It runs `--create`, scans
   the log for `^Error`, and asserts the control-stage sentinel
   `CREATIVE_MOD_CONTROL_OK` is present. `load=FAIL (data/control error)` →
   data/control-stage error to fix; `load=FAIL (control stage incomplete)` → the
   silent mid-`require` crash (see below).
2. `uv run verify.py behavior` → boots the headless server and asserts `on_init`
   ran (`storage_initialized`) and the default state (`default_disabled`).
3. Use `uv run verify.py shell '<cmd>'` to inspect live state interactively.

## Silent control-stage failure

If `control.lua` crashes mid-`require`, the game still starts and RCON responds —
but all mod globals are `nil` and `on_init` never fires. `verify.py load` catches
this via the missing sentinel (`load=FAIL (control stage incomplete)`). To
diagnose at runtime, drive the mod's own remote interface (a bare `/c` runs in
the scenario context, not the mod's):

```bash
uv run verify.py shell '/c rcon.print(tostring(pcall(function() return remote.call("creative-mode", "is_enabled") end)))'
```

`false` → the call errored / `on_init` never ran; look in `factorio-current.log`
right after the mod's checksum line.

## Save lifecycle gotcha

`--create` with a broken `control.lua` creates the save but skips `on_init`.
After fixing control-stage errors, re-run `uv run verify.py load` (it re-runs
`--create` every time, emitting a fresh sentinel) and `uv run verify.py behavior`
to confirm `on_init` ran; use `--clean` to recreate the save from scratch when a
restart alone is not enough.

## Capturing a bug as a regression test

When you reproduce a bug, **capture the reproduction in the `behavior` pipeline before
fixing it** so the crash can never silently come back. `shell` and `behavior` are the
same transport — both send `/c ...` over the same RCON channel against the same headless
server. `shell` is the throwaway, eyeball-it form; `behavior` is the codified form: a
`_assert_rcon(cmd, expected, name)` that boots a fresh server and emits the
`assert name=PASS/FAIL` + `RESULT:` contract with an exit code. So the workflow is:

1. **Prototype the reproduction in `shell`** until you have a `/c …` string that ends in
   `rcon.print(<x>)` printing a stable value (`"true"`, a count, …).
2. **Promote that exact string into a `_assert_rcon` entry** in `cmd_behavior` (and add its
   `name` to the failure-name tuple, in result-append order).
3. **Prove it catches the bug**: reintroduce the bug, run `uv run verify.py behavior`, and
   confirm the new assertion FAILs. Then restore the fix and confirm it PASSes.

Go through the real runtime path, not the crashing function directly — **mod globals are
not reachable from RCON** (the `/c` scope is the scenario's, not the mod's). Reproduce the
way it happened in play: build the entities with `create_entity{… raise_built=true}` so the
mod registers them into its own handlers/tick loop, drive the mod via `remote.call`, then
observe the *effect* through engine globals (`game`, the entity's inventories, …).

For per-tick bugs, use the two-phase pattern (see `item_source_to_crafter_placed` /
`item_source_feeds_crafter` in `verify.py`): one assertion places the entities, then a
`time.sleep(...)` lets the server tick, then a second assertion reads the effect. If the
tick path crashes, on_tick takes the headless server down and the second assertion fails
with `rcon-connection-failed` — which is exactly the regression signal you want.

## RCON caveats

- `require()` is blocked from RCON (only valid during `control.lua` parsing)
- RCON errors go to `console.log`, not `factorio-current.log` — check both when stuck
- Empty RCON response ≠ success
- Mod globals are sandboxed — not accessible from RCON
- Engine globals are accessible: `serpent`, `helpers`, `storage`, `game`, `rcon`, `defines`

## Porting to a new Factorio version

1. Bump `factorio_version` and `base >=` in `info.json`
2. Fix data-stage errors (`uv run verify.py load`)
3. Fix control-stage errors (`uv run verify.py load` → sentinel present)
4. `uv run verify.py behavior` — confirm `on_init` ran

**Reference:** `data/changelog.txt` in the Factorio install lists every API change by version.

Common breaking change patterns:
- Fields renamed or restructured (`category` → `categories = { ... }`)
- Prototype types merged into another (`tool` → `item` with subgroup filter)
- Global functions removed (`crash_trigger`, `game.write_file`)
- `defines.*` entries moved or merged (`furnace_modules` → `crafter_modules`;
  `assembling_machine_input`/`_output` and `furnace_result` → `crafter_input`/`crafter_output`).
  A removed `defines.*` silently reads as `nil`, so the break only surfaces at the call site
  (e.g. `get_inventory(nil)` → "'inventory index': real number expected got nil").
- Empty string rejected where `nil` is required (`next_upgrade = ""` → `nil`)
- Flags that previously implied others no longer do (`deconstruct` + tile selection)
