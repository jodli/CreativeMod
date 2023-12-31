require("defines")

data:extend{{
    -- Default initial action.
    type = "string-setting",
    name = creative_mode_defines.names.settings.default_initial_action,
    setting_type = "runtime-global",
    default_value = creative_mode_defines.values.default_initial_actions.show_popup,
    allowed_values = creative_mode_defines.values.default_initial_actions,
    order = "a-a"
}, {
    -- Unhide items.
    type = "bool-setting",
    name = creative_mode_defines.names.settings.unhide_items,
    setting_type = "startup",
    default_value = false,
    order = "a-b"
}, {
    -- Creative chest size.
    type = "int-setting",
    name = creative_mode_defines.names.settings.creative_chest_size,
    setting_type = "startup",
    default_value = 150,
    minimum_value = 1,
    maximum_value = 254,
    order = "b-a"
}, {
    -- Creative chest contains hidden items.
    type = "bool-setting",
    name = creative_mode_defines.names.settings.creative_chest_contains_hidden_items,
    setting_type = "runtime-global",
    default_value = false,
    order = "b-b"
}, {
    -- Autofill requester chest size.
    type = "int-setting",
    name = creative_mode_defines.names.settings.autofill_requester_chest_size,
    setting_type = "startup",
    default_value = 48,
    minimum_value = 1,
    maximum_value = 255,
    order = "c"
}, {
    -- Duplicating chest size.
    type = "int-setting",
    name = creative_mode_defines.names.settings.duplicating_chest_size,
    setting_type = "startup",
    default_value = 48,
    minimum_value = 1,
    maximum_value = 255,
    order = "d"
}, {
    -- Void chest size.
    type = "int-setting",
    name = creative_mode_defines.names.settings.void_chest_size,
    setting_type = "startup",
    default_value = 48,
    minimum_value = 1,
    maximum_value = 255,
    order = "e"
}, {
    -- Void requester chest size.
    type = "int-setting",
    name = creative_mode_defines.names.settings.void_requester_chest_size,
    setting_type = "startup",
    default_value = 48,
    minimum_value = 1,
    maximum_value = 255,
    order = "f"
}, {
    -- Void storage chest size.
    type = "int-setting",
    name = creative_mode_defines.names.settings.void_storage_chest_size,
    setting_type = "startup",
    default_value = 48,
    minimum_value = 1,
    maximum_value = 255,
    order = "g"
}, {
    -- Creative cargo wagon size.
    type = "int-setting",
    name = creative_mode_defines.names.settings.creative_cargo_wagon_size,
    setting_type = "startup",
    default_value = 200,
    minimum_value = 1,
    maximum_value = 254,
    order = "g-a"
}, {
    -- Creative cargo wagon contains hidden items.
    type = "bool-setting",
    name = creative_mode_defines.names.settings.creative_cargo_wagon_contains_hidden_items,
    setting_type = "runtime-global",
    default_value = true,
    order = "g-b"
}, {
    -- Duplicating cargo wagon size.
    type = "int-setting",
    name = creative_mode_defines.names.settings.duplicating_cargo_wagon_size,
    setting_type = "startup",
    default_value = 40,
    minimum_value = 1,
    maximum_value = 255,
    order = "h"
}, {
    -- Void cargo wagon size.
    type = "int-setting",
    name = creative_mode_defines.names.settings.void_cargo_wagon_size,
    setting_type = "startup",
    default_value = 40,
    minimum_value = 1,
    maximum_value = 255,
    order = "i"
}, {
    -- Time setting for void technology.
    type = "int-setting",
    name = creative_mode_defines.names.settings.time_for_void_technology,
    setting_type = "startup",
    default_value = 30,
    minimum_value = 1,
    maximum_value = 4294967296,
    order = "j"
}, {
    -- Add suffix to enemy structures' names.
    type = "bool-setting",
    name = creative_mode_defines.names.settings.enemy_structures_add_name_suffix,
    setting_type = "startup",
    default_value = true,
    order = "k"
}, {
    -- Change who can set infinity chest settings.
    type = "string-setting",
    name = creative_mode_defines.names.settings.infinity_chest_control,
    setting_type = "startup",
    default_value = "admins",
    order = "l",
    allowed_values = {"admins","all"}
}, {
    -- Enable invincible player by default.
    type = "bool-setting",
    name = creative_mode_defines.names.settings.enable_invincible_player_by_default,
    setting_type = "runtime-per-user",
    default_value = true,
    order = "l[personal-cheat]-a[invincible-player]"
}, {
    -- Enable instant blueprint by default.
    type = "bool-setting",
    name = creative_mode_defines.names.settings.enable_instant_blueprint_by_default,
    setting_type = "runtime-per-user",
    default_value = true,
    order = "l[personal-cheat]-b[instant-blueprint]"
}, {
    -- Enable instant deconstruction by default.
    type = "bool-setting",
    name = creative_mode_defines.names.settings.enable_instant_deconstruction_by_default,
    setting_type = "runtime-per-user",
    default_value = true,
    order = "l[personal-cheat]-c[instant-deconstruction]"
}, {
    -- Enable personal long reach by default.
    type = "bool-setting",
    name = creative_mode_defines.names.settings.enable_personal_long_reach_by_default,
    setting_type = "runtime-per-user",
    default_value = true,
    order = "l[personal-cheat]-d[long-reach]"
}, {
    -- Enable personal fast run by default.
    type = "bool-setting",
    name = creative_mode_defines.names.settings.enable_personal_fast_run_by_default,
    setting_type = "runtime-per-user",
    default_value = true,
    order = "l[personal-cheat]-e[fast-run]"
}, {
    -- Default technology research cheat type.
    type = "string-setting",
    name = creative_mode_defines.names.settings.default_technology_research_cheat_type,
    setting_type = "runtime-per-user",
    default_value = creative_mode_defines.values.default_technology_research_cheat_types.research_all,
    allowed_values = creative_mode_defines.values.default_technology_research_cheat_types,
    order = "m[force-cheat]-a[technology-research-cheat-type]"
}, {
    -- Override evolution factor by default.
    type = "bool-setting",
    name = creative_mode_defines.names.settings.override_evolution_factor_by_default,
    setting_type = "runtime-per-user",
    default_value = false,
    order = "m[force-cheat]-b[override-evolution]"
}, {
    -- Default evolution factor.
    type = "double-setting",
    name = creative_mode_defines.names.settings.default_evolution_factor,
    setting_type = "runtime-per-user",
    default_value = 1,
    minimum_value = 0,
    maximum_value = 1,
    order = "m[force-cheat]-c[default-evolution]"
}}
