---
name: factorio-mod-dev
description: Develop and debug the creative-mod Factorio mod. Use when working on mod scripts, prototypes, GUI, events, or porting to a new Factorio version. Covers repo layout, mod structure, key internals, and the debug toolchain.
---

# Factorio Mod Dev

## Repo layout

```
creative-mod/
├── info.json              # mod metadata (name, version, factorio_version, deps)
├── settings.lua           # startup/runtime settings (data stage)
├── data.lua               # data stage entry — loads prototypes/
├── data-final-fixes.lua   # data stage post-processing (runs after all mods)
├── control.lua            # runtime entry — requires scripts/, registers events
├── defines.lua            # all name/prefix constants → creative_mode_defines
├── scripts/               # runtime modules (one feature per file)
├── prototypes/            # entity, item, recipe, technology definitions
├── migrations/            # version migration scripts
└── locale/                # translations
```

## Debug toolchain

```bash
./debug.sh                           # start headless server
./debug.sh gui --window-size 1920x1080  # start with full GUI (windowed)
./debug.sh log                       # tail factorio-current.log
./debug.sh reset                     # wipe save → re-triggers on_init
./rcon.sh '/c rcon.print(...)'       # one-shot RCON command
./rcon-shell.sh                      # interactive REPL
```

Output channels:

| Goal | Use | Where |
|---|---|---|
| Inspect a value | `rcon.print(v)` | echoed back to terminal |
| Trace code | `log("msg")` | `factorio-current.log` |
| Dump large table | `helpers.write_file("f", d)` | `.debug/script-output/f` |

→ See `DEBUG.md` for full tool reference.
→ See `DEBUGGING.md` (this skill folder) for debugging methodology and porting guide.

## Key internals

- `creative_mode_defines` — single source of truth for all names/prefixes (`defines.lua`)
- `storage.creative_mode` — mod runtime state, initialised in `scripts/global-util.lua`
- `events` — all event callbacks (`scripts/events.lua`), registered in `control.lua`
- `remote_interface` — public API for other mods (`scripts/remote-interface.lua`)
- Prototype names: always use `creative_mode_defines.names.*`, never hardcode strings
- Data stage only: `data.raw`, `data:extend()`, prototype tables
- Runtime only: `game`, `storage`, `script`, `defines`, `helpers`
