# Factorio Mod Debug Guide

Headless debug setup for **creative-mod**. No GUI, no Steam, isolated from `~/.factorio`.

All debugging now goes through `verify.py` (run via `uv`). It replaces the old
standalone shell wrappers with one bounded tool.
→ See `.pi/skills/factorio-mod-dev/VERIFY.md` for the full reference.

## Quick Start

```bash
# Verify the mod loads and behaves (bounded — always returns)
uv run verify.py load
uv run verify.py behavior
uv run verify.py all

# Inspect values via a one-shot RCON command
uv run verify.py shell '/c rcon.print(game.tick)'
uv run verify.py shell '/c rcon.print(serpent.block(storage))'

# Watch the game log
tail -f .debug/factorio-current.log
```

## Tools

| Tool | Purpose |
|---|---|
| `uv run verify.py shell '<cmd>'` | Send one RCON command, print response (omit arg for a stdin REPL) |
| `uv run verify.py debug` | Bounded headless session; `--command` one-shot, `--gui` graphical escape hatch |
| `uv run verify.py load --clean` | Recreate the debug save from scratch (wipes state) |
| `rcon.py` | Python RCON client (imported as a module by `verify.py`; also a standalone CLI) |

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

> Note: a bare `/c` runs in the **scenario** script context, where `storage` is
> the scenario's storage — not creative-mod's per-mod storage. To read the mod's
> own state, drive its remote interface, e.g.
> `remote.call("creative-mode", "is_enabled")`.

### Inspect the global storage table
```bash
uv run verify.py shell '/c rcon.print(serpent.block(storage))'
uv run verify.py shell '/c rcon.print(serpent.block(storage.creative_mode))'
```

### Check if an entity exists in a surface
```bash
uv run verify.py shell '/c
  local e = game.surfaces[1].find_entities_filtered{name="creative-chest"}
  rcon.print("#entities: " .. #e)
'
```

### Trigger a mod event manually
```bash
uv run verify.py shell '/c script.raise_event(defines.events.on_player_created, {player_index=1})'
```

### Check a player's state (after joining via multiplayer)
```bash
uv run verify.py shell '/c rcon.print(serpent.block(game.players[1]))'
```

### Dump all mod settings
```bash
uv run verify.py shell '/c rcon.print(serpent.block(settings.startup))'
uv run verify.py shell '/c rcon.print(serpent.block(settings.global))'
```

### Watch for Lua errors
```bash
tail -f .debug/factorio-current.log   # errors appear as: "Error while running event ..."
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
- Use `uv run verify.py load --clean` to recreate the save from scratch (clears all `storage`).

## First-Run Achievement Warning

The first `/c` command in a fresh game triggers:
> "Using Lua console commands will disable achievements. Please repeat the command to proceed."

`rcon.py` handles this automatically — it detects the warning and resends the command transparently. You never need to worry about it.

## Requirements

`uv run verify.py doctor` checks these. See
`.pi/skills/factorio-mod-dev/VERIFY.md` for the full replicable install setup.

- **Factorio 2.1.7** binary at `../../bin/x64/factorio` relative to the mod (full
  install — base mods ship with it).
- **`uv`** — runs `verify.py`.
- **`jq`** — reads `info.json` for mod name/version.
- **`stylua`** — Lua formatter (`verify.py static`).
- **`luacheck`** — Lua linter (`verify.py static`); **must be built against Lua
  5.3** (it crashes under Lua 5.5). Install via
  `luarocks --lua-version=5.3 install luacheck --local` and add `~/.luarocks/bin`
  to `PATH`.
