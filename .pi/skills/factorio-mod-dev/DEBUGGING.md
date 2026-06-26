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
- `defines.*` entries moved or merged (`furnace_modules` → `crafter_modules`)
- Empty string rejected where `nil` is required (`next_upgrade = ""` → `nil`)
- Flags that previously implied others no longer do (`deconstruct` + tile selection)
