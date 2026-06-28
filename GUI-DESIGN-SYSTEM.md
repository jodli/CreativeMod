# GUI Design System

Conventions for building menus in this mod so new tabs/menus look and behave like the
existing ones. Follow this when adding a submenu, a sub-sub-menu, or a backend action behind
a menu. File:line references point at the canonical examples to copy from.

## Menu hierarchy

Three nesting levels, all hosted in `mod_gui.get_frame_flow(player)` → `main_menu_container`:

```
Main menu ("Creative Mode")         button column of submenu buttons
  └─ Submenu ("Cheats", "Surface")  button column of section buttons
       └─ Sub-sub-menu              content frame opened beside the column
```

- **Main menu**: one vertical `frame` (caption "Creative Mode") of `main_menu_button`s, one per
  submenu. Built in `gui-menu.lua` `create_or_hide_main_menu_for_player` from the
  `submenus_gui_data` registry (`gui-menu.lua:47`).
- **Submenu**: its own horizontal `flow` container (e.g. `surface_menus_container`) holding a
  captioned vertical `frame` of `main_menu_button`s — the **button column**. Each button opens a
  sub-sub-menu *beside* the column inside the same container.
- **Sub-sub-menu**: a captioned vertical `frame` added next to the button column, holding the
  actual controls. Toggled open/closed; opening one closes the siblings.

Canonical examples: the **Cheats** submenu (`gui-menu-cheats.lua`) and the **Surface** submenu
(`gui-menu-surface.lua`), which deliberately mirror each other.

## Adding a new submenu

1. **New module** `scripts/gui-menu-<name>.lua` defining `gui_menu_<name>` with:
   - `get_container_name()` → a unique container name from `defines.lua`.
   - `create_or_destroy_menu_for_player(player)` — toggles the submenu container; when building,
     adds a captioned `frame` (the button column) + one `main_menu_button` per section.
   - `on_gui_click(element, element_name, player, button, alt, control, shift)` returning whether
     the event was consumed.
   - `on_gui_selection_state_changed(...)` if it has drop-downs.
2. **Register** in `submenus_gui_data` (`gui-menu.lua:47`): `button_name`, `button_caption`,
   `get_player_can_access_function` (e.g. `function(player) return player.admin end` for
   admin-only), `get_submenu_container_name_function`, `open_submenu_for_player_function`,
   `update_accessibility_for_player_function` (or `nil`).
3. **Wire the click fan-out**: add `gui_menu_<name>.on_gui_click` to the `on_gui_click` dispatch in
   `gui-menu.lua`, and `on_gui_selection_state_changed` to that fan-out if needed.
4. **`control.lua`**: `require("scripts.gui-menu-<name>")` **before** `require("scripts.gui-menu")`
   — `gui-menu.lua` references submenu globals at load time when building `submenus_gui_data`.
5. **`defines.lua`**: add element-name constants. **`locale/en/base.cfg`**: captions/messages.
6. **`.luacheckrc`**: register the new module global.

## Section pattern within a submenu (the three-column nav)

Drive the button column from a `section_data` table + an explicit `section_order` array (because
`pairs()` is unordered). See `gui-menu-surface.lua` `section_data` / `section_order`. Each section:

- `button_name`, `button_caption`, plus either:
  - `build_content = function(frame) ... end` — fills a content frame the helper creates for you, **or**
  - `create_or_destroy = function(player, destroy_only) ... end` — delegate open/close to another
    module (used to host the Surface Cheats menu, whose content is built by the cheats machinery).
- Optional `get_player_can_access_function` to gate the button's visibility.
- Optional gating flag (e.g. `space_age_only`, checked via `script.feature_flags["space_travel"]`).

`create_or_destroy_section_for_player(player, data, destroy_only)` toggles the section's content
frame inside the submenu container; the click handler closes the other sections first, then toggles
the clicked one — mirroring `create_or_destroy_cheats_menu_for_player` (`gui-menu-cheats.lua:2560`)
and its fan-out (`gui-menu-cheats.lua:3761`).

## Shared style vocabulary

Reuse these styles (defined in `prototypes/style.lua`, named in `defines.lua` under `gui_styles`)
so new menus match the rest of the UI:

| Element | Style |
|---|---|
| Submenu / section column button | `main_menu_button` |
| Selection list scroll-pane | `cheat_scroll_pane` |
| Selection list frame | `cheat_target_selection_container_frame` |
| Selectable list button (active / inactive) | `cheat_target_selected_button` / `cheat_target_unselected_button` |
| Form row table | `cheat_table` |
| Form label | `cheat_name_label` |
| Text input | `cheat_numeric_textfield` |
| Spacer between input and button | `cheat_textfield_and_button_separate_flow` |
| Apply / action button (short caption) | `cheat_apply_button` |
| Action button (longer caption, auto-sized) | `small_default_bold_button` |

A captioned `frame` renders its `caption` as a title bar — that is how submenus/sub-sub-menus get
their heading; no separate title-bar helper exists.

**Gotcha:** `cheat_apply_button` has a *fixed* width sized for short captions (e.g. "Apply") and
clips longer ones like "Create" → "Cre...". A runtime `minimal_width` cannot grow past a fixed
width, so for a longer caption use its parent style `small_default_bold_button` instead — same bold
apply-button look, but auto-sizes to the caption.

## Event wiring

Engine events are forwarded down a fixed chain, mirroring existing handlers:

`scripts/events.lua` (local forwarder, registered in `event_handlers_look_up`) → `gui.on_<event>`
→ `gui_menu.on_<event>` → the relevant `gui_menu_<name>.on_<event>`.

The generic dispatcher in `control.lua` loops over all `defines.events`, so a new handler needs
only the forwarder + `event_handlers_look_up` entry, not a new explicit `script.on_event`
registration. `on_surface_created` (Phase 1 of the surface tool) is the worked example. Note the
engine payload carries `surface_index`, not `surface` — resolve via `game.surfaces[event.surface_index]`.

**Live list refresh:** to make a newly created/removed target appear without reopening the menu,
route through `add_or_remove_target_in_cheats_menu_for_all_players(surface, <menu_gui_data>, true)`;
each target descriptor's `verify_target_for_insert_function` enforces per-player access for free.

## Backend actions behind a menu

- **Put logic in a backend module** (e.g. `scripts/surface-creation.lua`), not the GUI. Return a
  structured result — `true, <value>` on success or `false, <localised-error>` — so both the GUI
  and the remote interface can report without re-validating.
- **Take a `force`, not a `player`,** where possible, so the action is callable headless. The GUI
  passes `player.force`; the remote wrapper resolves a force from an optional `player_index` and
  falls back to `game.forces["player"]` (which always exists, even headless). See `resolve_force`
  in `scripts/remote-interface.lua`.
- **Feature-gate Space Age paths** on `script.feature_flags["space_travel"]` in *both* the backend
  (refuse with an error key) and the UI (don't build the control).
- **Expose every action through the remote interface** (`scripts/remote-interface.lua`
  `remote_functions`) returning a boolean/structured result, so `verify.py behavior` can assert it
  via `remote.call` in the headless sandbox (which has Space Age enabled).

## Verification

Every user-facing change runs `uv run verify.py static | load | behavior` (see `DEBUG.md`), and
adds a `changelog.txt` entry. GUI layout/behavior that the headless suite can't exercise is
checked manually via `uv run verify.py debug --gui`. Only one Factorio instance can hold the
`.debug` sandbox lock at a time — close a running `debug --gui` session before running
`load`/`behavior`.
