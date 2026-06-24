---
name: factorio-mod-dev
description: Debug and develop the creative-mod Factorio mod. Use when investigating bugs, inspecting runtime state, running Lua in the live game, reading mod output, or testing changes to mod scripts. Covers the headless debug server, RCON workflow, and all output channels.
---

# Factorio Mod Dev — Debug Workflow

Full human reference: `DEBUG.md` in the repo root. Read it for the complete picture.

## Repo layout (key files)

```
creative-mod/
├── control.lua            # runtime entry point
├── scripts/               # all runtime modules
├── prototypes/            # data-stage entity/item/recipe definitions
├── defines.lua            # all name constants (creative_mode_defines)
├── debug.sh               # start headless server
├── rcon.sh                # send one RCON command
├── rcon-shell.sh          # interactive REPL
├── rcon.py                # Python RCON client (no external deps)
└── DEBUG.md               # full debug reference
```

## Starting the debug server

```bash
./debug.sh          # start (blocks)
./debug.sh log      # tail game log in a second terminal
./debug.sh reset    # wipe save and recreate (clears storage)
```

The server is ready when `Starting RCON interface` appears in `.debug/factorio-current.log`.

## Sending commands via RCON

```bash
./rcon.sh '/c <lua>'          # one-shot
./rcon-shell.sh               # interactive prompt (raw Lua auto-prefixed with /c)
```

`rcon.py` auto-handles the achievements-disable confirmation on first use.

## Output channels — always pick the right one

| What you need | Use | Where output goes |
|---|---|---|
| Inspect a value now | `rcon.print(v)` | echoed back to your terminal |
| Trace code paths | `log("msg")` | `.debug/factorio-current.log` |
| Dump large tables | `helpers.write_file("f", data)` | `.debug/script-output/f` |

**Never use `game.write_file` — that's Factorio 1.x. Use `helpers.write_file` in 2.0.**

## Standard debug patterns

```lua
-- Inspect global state
/c rcon.print(serpent.block(storage))
/c rcon.print(serpent.block(storage.creative_mode))

-- Inspect mod settings
/c rcon.print(serpent.block(settings.startup))

-- Find entities on the surface
/c local e = game.surfaces[1].find_entities_filtered{name="creative-chest"}
   rcon.print("found: " .. #e)

-- Check Lua errors (tail the log)
./debug.sh log

-- Dump a large table to a file
/c helpers.write_file("dump.txt", serpent.block(storage))
-- then: cat .debug/script-output/dump.txt
```

## Reading Lua errors

Errors appear in `.debug/factorio-current.log` as:
```
Error while running event creative-mod::on_tick (ID 0):
__creative-mod__/scripts/foo.lua:42: attempt to index nil value
```

Always tail this log when debugging:
```bash
./debug.sh log
```

## Live editing workflow

The mod is loaded via a symlink — **no packaging step is needed**. Edit any `.lua` file, then either:
- **Soft reload**: use `/c` commands to re-run specific functions
- **Hard reload**: `Ctrl-C` the server, then `./debug.sh` again (save persists)
- **Fresh state**: `./debug.sh reset` then `./debug.sh` (recreates save, clears `storage`)

## Key mod internals

- `storage.creative_mode` — main runtime state table (set up in `scripts/global-util.lua`)
- `creative_mode_defines` — all name constants, loaded from `defines.lua`
- `events` table — all event handlers, registered in `control.lua` via `scripts/events.lua`
- `remote_interface` — remote API functions (`scripts/remote-interface.lua`)
- Prototype names: always use `creative_mode_defines.names.*` — never hardcode strings
