---
name: factorio-mod-dev
description: Develop and debug the creative-mod Factorio mod. Use when working on mod scripts, prototypes, GUI, events, or porting to a new Factorio version. Covers repo layout, mod structure, key internals, and the verify.py verification pipeline.
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

## Verification loop

`verify.py` is the canonical way to check the mod. It loads creative-mod in the
local Factorio install, runs assertions, and exits `0`/non-zero with a stable,
greppable `RESULT:` line, so you can edit → verify → read result → iterate.
Run it via `uv`:

```bash
uv run verify.py doctor    # preflight: factorio binary + version, uv, jq
uv run verify.py static    # luacheck . + stylua --check .
uv run verify.py load      # data + control load gate (incl. silent-crash guard)
uv run verify.py behavior  # headless server + RCON assertion batch
uv run verify.py all       # static → load → behavior, aggregated
uv run verify.py --help
```

The layered model is **static → load → behavior** (cheapest to deepest); `all`
runs the three in sequence. Read the result by grepping `^RESULT:` and/or
checking `$?`:

```
RESULT: load=PASS                              # exit 0
RESULT: load=FAIL (control stage incomplete)   # exit non-zero, reason names the failure
```

For investigation, use the bounded tooling modes (successors to the removed
standalone shell wrappers):

```bash
uv run verify.py shell '/c rcon.print(game.tick)'   # one-shot RCON; omit arg for a stdin REPL
uv run verify.py debug --command '/c ...'           # bounded headless session
uv run verify.py debug --gui                        # manual-only graphical escape hatch
uv run verify.py load --clean                       # recreate the debug save from scratch
```

Output channels for the values you inspect:

| Goal | Use | Where |
|---|---|---|
| Inspect a value | `rcon.print(v)` | echoed back to terminal |
| Trace code | `log("msg")` | `factorio-current.log` |
| Dump large table | `helpers.write_file("f", d)` | `.debug/script-output/f` |

→ See `VERIFY.md` (this skill folder) for the full subcommand reference, the
`RESULT:`/exit-code contract, and the replicable local install setup.
→ See `DEBUG.md` for the output-channel reference.
→ See `DEBUGGING.md` (this skill folder) for debugging methodology and porting guide.
→ See `RELEASE.md` (this skill folder) for release checklist and GitHub Actions workflow reference.

## Base game as a reference

The full Factorio base mod ships with the install and is readable on disk:

```
/mnt/quickstuff/git/factorio_linux/data/base/
├── prototypes/        # all vanilla entity, item, recipe, technology definitions
├── changelog.txt      # machine-readable API change log (every version)
└── ...
```

When something breaks or behaves unexpectedly, **read the base game source first**:
- Want to know the correct fields for a prototype type? Find a vanilla example in `data/base/prototypes/`.
- Want to know what changed between versions? `grep` `data/base/../changelog.txt` for the symbol.
- Want to know what a `defines.*` value actually is? It's defined in the engine, but usages are visible throughout the base mod.

This is the ground truth for the running version — always prefer it over external docs.

## Key internals

- `creative_mode_defines` — single source of truth for all names/prefixes (`defines.lua`)
- `storage.creative_mode` — mod runtime state, initialised in `scripts/global-util.lua`
- `events` — all event callbacks (`scripts/events.lua`), registered in `control.lua`
- `remote_interface` — public API for other mods (`scripts/remote-interface.lua`)
- Prototype names: always use `creative_mode_defines.names.*`, never hardcode strings
- Data stage only: `data.raw`, `data:extend()`, prototype tables
- Runtime only: `game`, `storage`, `script`, `defines`, `helpers`
