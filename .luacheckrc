-- .luacheckrc for CreativeMod (Factorio 2.0)
-- Based on Nexela/Factorio-luacheckrc, adapted for Factorio 2.0 API

-- Ignore patterns:
-- 111/__ : setting non-standard global with __ prefix
-- 21./%w+_$ : mutating/accessing variable ending in _
-- 21./^_[_%w]+$ : mutating/accessing variable starting with _
-- 213/^%a$ : single-character variable in a loop
-- 213/index : loop variable named "index"
-- 213/key : loop variable named "key"
local IGNORE = {
  "111/__",        -- setting non-standard global with __ prefix
  "21.",           -- unused variable/argument/loop variable (legacy codebase, very noisy)
  "231",           -- variable never accessed (legacy codebase)
  "311",           -- value assigned to variable but unused (common in GUI building)
  "411",           -- variable previously defined (legacy codebase)
  "421",           -- shadowing definition of variable (legacy codebase)
  "431",           -- shadowing upvalue (common in nested scopes)
  "542",           -- empty if branch
  "6..",           -- whitespace warnings (stylua will handle formatting)
}
local NOT_GLOBALS = { "coroutine", "io", "socket", "dofile", "loadfile" }

local LINE_LENGTH = false

-----------------------------------------------------------
-- Factorio 2.0 std definitions
-----------------------------------------------------------

-- Globals available in both data and control stages
stds.factorio = {
  read_globals = {
    "serpent", "log", "__DebugAdapter",
    table = { fields = { "deepcopy", "compare" } },
    string = { fields = { "trim", "split" } },
    math = { fields = { "round" } },
  },
}

-- Factorio 2.0 control stage globals
stds.factorio_control = {
  read_globals = {
    game = { other_fields = true, read_only = false },
    "script",
    "remote",
    "rendering",
    "commands",
    "settings",
    "rcon",
    "helpers",       -- Factorio 2.0: new utility global
    "prototypes",    -- Factorio 2.0: replaces game.*_prototypes
    storage = { other_fields = true, read_only = false },
    defines = {
      other_fields = true,
    },
  },
  globals = {
    "global",        -- Factorio 2.0: deprecated alias for storage
  },
}

-- Factorio 2.0 data stage globals
stds.factorio_data = {
  globals = {
    data = {
      other_fields = true,
    },
  },
  read_globals = {
    "mods",
    "settings",
    defines = {
      other_fields = true,
    },
  },
}

-- Factorio base mod globals available during data stage
stds.factorio_base_data = {
  globals = {
    "circuit_connector_definitions", -- base mod global, sometimes modified
  },
  read_globals = {
    "basic_belt_animation_set",
    "crash_trigger",
    "default_orange_color",
    "ending_patch_prototype",
    "pipecoverspictures",
    "sound_variations",
    "standard_train_wheels",
    "universal_connector_template",
    "volume_multiplier",
  },
}

-- CreativeMod's own globals (all the module tables defined in scripts/)
stds.creative_mod = {
  globals = {
    "autofill_requester_chest",
    "cheats",
    "configurable_super_boiler",
    "creative_cargo_wagon",
    "creative_chest",
    "creative_chest_util",
    "creative_lab",
    "creative_mode_defines",
    "creative_provider_chest",
    "duplicating_cargo_wagon",
    "duplicating_chest",
    "duplicating_chest_util",
    "duplicating_provider_chest",
    "duplicator",
    "equipments",
    "events",
    "fluid_providers_util",
    "fluid_void",
    "global_util",
    "gui",
    "gui_entity",
    "gui_menu",
    "gui_menu_admin",
    "gui_menu_buildoptions",
    "gui_menu_cheats",
    "gui_menu_magicwand",
    "gui_menu_modding",
    "item_providers_util",
    "item_source",
    "item_void",
    "magic_wand_creator",
    "magic_wand_healer",
    "magic_wand_modifier",
    "mod_compatibler",
    "output_or_remove_item_operation_mode",
    "random_item_source",
    "remote_interface",
    "rights",
    "static_item_container_type",
    "super_boiler",
    "super_cooler",
    "transport_belt_item_distance",
    "util",
    "void_cargo_wagon",
    "void_chest_util",
    "void_lab",
    -- Functions defined as globals in instant_cheats.lua
    "is_player_valid_for_instant_request",
    "is_player_valid_for_instant_trash",
    "handle_entity_logistic_slot_changed",
    "handle_player_main_inventory_changed",
    "handle_player_trash_inventory_changed",
    -- Functions defined as globals in events.lua
    "full_store_or_log_message",
    "get_character_request_slot_count",
    -- Variables used as globals in data-final-fixes.lua
    "additional_pastable_entities",
    "chest_data",
    -- Variables used as globals in data-stage files
    "fixed_icons",
    "hidden",
    "regpipe",
    "visible",
  },
}

-----------------------------------------------------------
-- Default configuration
-----------------------------------------------------------

std = "lua52+factorio+factorio_control+creative_mod"
not_globals = NOT_GLOBALS
ignore = IGNORE
quiet = 1
codes = true
max_cyclomatic_complexity = false
max_line_length = LINE_LENGTH
max_code_line_length = LINE_LENGTH
max_string_line_length = LINE_LENGTH
max_comment_line_length = LINE_LENGTH

exclude_files = {
  "**/.trash/",
  "**/.history/",
  "**/.vscode/",
  "**/comparison-report.html",
}

-----------------------------------------------------------
-- Per-file overrides
-----------------------------------------------------------

-- Data stage files
files["data.lua"].std = "lua52+factorio+factorio_data+factorio_base_data+creative_mod"
files["data-final-fixes.lua"].std = "lua52+factorio+factorio_data+factorio_base_data+creative_mod"
files["settings.lua"].std = "lua52+factorio+factorio_data+creative_mod"
files["prototypes/"].std = "lua52+factorio+factorio_data+factorio_base_data+creative_mod"

-- defines.lua is loaded in both stages
files["defines.lua"] = {
  std = "lua52+factorio+creative_mod",
}

-- Test files (factorio-test globals)
stds.factorio_test = {
  read_globals = {
    "test", "it", "describe", "before_each", "after_each",
    "before_all", "after_all", "after_test", "after_ticks",
    "async", "done", "on_tick", "ticks_between_tests", "tags",
  },
  globals = {
    assert = { other_fields = true },
  },
}
files["tests/"] = {
  std = "lua52+factorio+factorio_control+creative_mod+factorio_test",
}
