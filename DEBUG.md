# Factorio Mod Debug Guide

Headless debug setup for **creative-mod**. No GUI, no Steam, isolated from `~/.factorio`.

## Quick Start

```bash
# Terminal 1 — start the server (keeps running)
./debug.sh

# Terminal 2 — inspect values
./rcon.sh '/c rcon.print(game.tick)'
./rcon.sh '/c rcon.print(serpent.block(storage))'

# Terminal 3 — watch the game log
./debug.sh log
```

## Scripts

| Script | Purpose |
|---|---|
| `debug.sh` | Start headless Factorio server with RCON |
| `rcon.sh '<cmd>'` | Send one RCON command, print response |
| `rcon-shell.sh` | Interactive REPL (`factorio>` prompt) |
| `rcon.py` | Python RCON client (used by the above) |

### `debug.sh` subcommands

```bash
./debug.sh          # start server (blocks until Ctrl-C)
./debug.sh log      # tail .debug/factorio-current.log
./debug.sh console  # tail .debug/console.log
./debug.sh reset    # delete the save and recreate it (wipes state)
```

## Output Channels

Three places output can go — pick the right one:

### 1. `rcon.print(value)` → echoed back to your terminal

Best for inspecting values interactively. The response comes straight back from RCON.

```lua
/c rcon.print(game.tick)
/c rcon.print(serpent.block(storage))
/c rcon.print(serpent.block(storage.creative_mode))
/c rcon.print(tostring(some_var))
```

### 2. `log("msg")` → `.debug/factorio-current.log`

Best for tracing code paths inside the mod. Same file Factorio writes Lua errors to.

```lua
/c log("player count: " .. #game.players)
/c log(serpent.line({a=1, b=2}))   -- compact single-line
/c log(serpent.block(storage))      -- pretty multi-line
```

Tail it live:
```bash
./debug.sh log
# or
tail -f .debug/factorio-current.log
```

### 3. `helpers.write_file("name", data)` → `.debug/script-output/name`

Best for large dumps (full global table, prototype data). **Note: Factorio 2.0 API** — not `game.write_file`.

```lua
/c helpers.write_file("storage.txt", serpent.block(storage))
/c helpers.write_file("prototypes.txt", serpent.block(data.raw["entity"]["creative-chest"]))
```

Read it back:
```bash
cat .debug/script-output/storage.txt
```

## Common Debug Patterns

### Inspect the global storage table
```bash
./rcon.sh '/c rcon.print(serpent.block(storage))'
./rcon.sh '/c rcon.print(serpent.block(storage.creative_mode))'
```

### Check if an entity exists in a surface
```bash
./rcon.sh '/c
  local e = game.surfaces[1].find_entities_filtered{name="creative-chest"}
  rcon.print("#entities: " .. #e)
'
```

### Trigger a mod event manually
```bash
./rcon.sh '/c script.raise_event(defines.events.on_player_created, {player_index=1})'
```

### Check a player's state (after joining via multiplayer)
```bash
./rcon.sh '/c rcon.print(serpent.block(game.players[1]))'
```

### Dump all mod settings
```bash
./rcon.sh '/c rcon.print(serpent.block(settings.startup))'
./rcon.sh '/c rcon.print(serpent.block(settings.global))'
```

### Watch for Lua errors
```bash
./debug.sh log   # errors appear as: "Error while running event ..."
```

## How the Setup Works

```
.debug/
├── config/config.ini      # points read-data at factorio/data, write-data here
├── mods/
│   ├── creative-mod_2.1.5 → ../../  (symlink to repo root)
│   ├── mod-list.json      # copied from mods_dev/
│   └── mod-settings.dat   # copied from mods_dev/
├── saves/debug-save.zip   # the live debug save
├── factorio-current.log   # game + Lua log
├── console.log            # server console (RCON command log)
└── script-output/         # helpers.write_file() output
```

- The symlink means **live edits are instant** — no packaging step needed.
- The save persists across server restarts (Factorio saves on SIGTERM).
- Use `./debug.sh reset` to recreate the save from scratch (clears all `storage`).

## First-Run Achievement Warning

The first `/c` command in a fresh game triggers:
> "Using Lua console commands will disable achievements. Please repeat the command to proceed."

`rcon.py` handles this automatically — it detects the warning and resends the command transparently. You never need to worry about it.

## Requirements

- `jq` — reads `info.json` for mod name/version
- `python3` — runs the RCON client (`rcon.py`)
- Factorio binary at `../../bin/x64/factorio` relative to repo root
