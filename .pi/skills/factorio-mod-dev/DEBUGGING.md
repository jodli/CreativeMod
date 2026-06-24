# Factorio Mod Debugging Reference

## The two stages

**Data stage** (`data.lua`, `data-final-fixes.lua`): defines prototypes. Runs at startup.
Errors surface immediately during `--create`. One error per run, full file + line.

**Control stage** (`control.lua`, `scripts/`): runs when loading the world.
Errors appear in `factorio-current.log` just after the script checksum lines.

## Protocol

1. `./debug.sh reset` + run `--create` → fix data-stage errors to zero
2. `./debug.sh` → fix control-stage errors (check log after checksum lines)
3. `./debug.sh reset` again → verify `on_init` ran (`storage.creative_mode ~= nil`)
4. Use RCON to inspect live state

## Silent control-stage failure

If `control.lua` crashes mid-`require`, the game still starts and RCON responds —
but all mod globals are `nil` and `on_init` never fires. Diagnose:

```bash
./rcon.sh '/c rcon.print(tostring(storage.creative_mode ~= nil))'
```

`false`/`nil` → look in `factorio-current.log` right after the mod's checksum line.

## Save lifecycle gotcha

`--create` with a broken `control.lua` creates the save but skips `on_init`.
After fixing control-stage errors, always `./debug.sh reset` — a server restart alone is not enough.

## RCON caveats

- `require()` is blocked from RCON (only valid during `control.lua` parsing)
- RCON errors go to `console.log`, not `factorio-current.log` — check both when stuck
- Empty RCON response ≠ success
- Mod globals are sandboxed — not accessible from RCON
- Engine globals are accessible: `serpent`, `helpers`, `storage`, `game`, `rcon`, `defines`

## Porting to a new Factorio version

1. Bump `factorio_version` and `base >=` in `info.json`
2. Fix data-stage errors (`--create`)
3. Fix control-stage errors (`--start-server`)
4. `./debug.sh reset` — confirm `on_init` ran

**Reference:** `data/changelog.txt` in the Factorio install lists every API change by version.

Common breaking change patterns:
- Fields renamed or restructured (`category` → `categories = { ... }`)
- Prototype types merged into another (`tool` → `item` with subgroup filter)
- Global functions removed (`crash_trigger`, `game.write_file`)
- `defines.*` entries moved or merged (`furnace_modules` → `crafter_modules`)
- Empty string rejected where `nil` is required (`next_upgrade = ""` → `nil`)
- Flags that previously implied others no longer do (`deconstruct` + tile selection)
