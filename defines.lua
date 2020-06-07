-- Here are the values that are shared across different files.
creative_mode_defines = {}

-- Mod ID.
creative_mode_defines.mod_id = "creative-mod"
-- Path to the mod's directory.
creative_mode_defines.mod_directory = "__creative-mod__"
-- Prefix of the entity names and item names.
creative_mode_defines.name_prefix = "creative-mod_"
-- String pattern of the prefix.
creative_mode_defines.name_prefix_pattern = "creative%-mod%_"

-- Dictionary about the empty.png
creative_mode_defines.empty_png = {}
-- Path to the empty.png
creative_mode_defines.empty_png.path = "__core__/graphics/empty.png"
-- Data about the empty.png
creative_mode_defines.empty_png.data = {
	filename = creative_mode_defines.empty_png.path,
	priority = "extra-high",
	width = 1,
	height = 1
}
creative_mode_defines.empty_animation = {
	filename = creative_mode_defines.empty_png.path,
	priority = "extra-high",
	width = 1,
	height = 1,
	frame_count = 1
}
-- Data about the energy source for creative tools that doesn't require electricity.
creative_mode_defines.non_electric_energy_source = {type = "burner", effectivity = 1, fuel_inventory_size = 0}

-- Names and values
creative_mode_defines.names = {}
creative_mode_defines.values = {}

-- Setting names
creative_mode_defines.names.settings = {
	default_initial_action = creative_mode_defines.name_prefix .. "default-initial-action",
	unhide_items = creative_mode_defines.name_prefix .. "unhide-items",
	creative_chest_size = creative_mode_defines.name_prefix .. "creative-chest-size",
	creative_chest_contains_hidden_items = creative_mode_defines.name_prefix .. "creative-chest-contains-hidden-items",
	autofill_requester_chest_size = creative_mode_defines.name_prefix .. "autofill-requester-chest-size",
	duplicating_chest_size = creative_mode_defines.name_prefix .. "duplicating-chest-size",
	void_requester_chest_size = creative_mode_defines.name_prefix .. "void-requester-chest-size",
	void_chest_size = creative_mode_defines.name_prefix .. "void-chest-size",
	void_storage_chest_size = creative_mode_defines.name_prefix .. "void-storage-chest-size",
	time_for_void_technology = creative_mode_defines.name_prefix .. "time-for-void-technology",
	creative_cargo_wagon_size = creative_mode_defines.name_prefix .. "creative-cargo-wagon-size",
	creative_cargo_wagon_contains_hidden_items = creative_mode_defines.name_prefix ..
		"creative-cargo-wagon-contains-hidden-items",
	duplicating_cargo_wagon_size = creative_mode_defines.name_prefix .. "duplicating-cargo-wagon-size",
	void_cargo_wagon_size = creative_mode_defines.name_prefix .. "void-cargo-wagon-size",
	enemy_structures_add_name_suffix = creative_mode_defines.name_prefix .. "enemy-structures-add-name-suffix",
	enable_invincible_player_by_default = creative_mode_defines.name_prefix .. "enable-invincible-player-by-default",
	enable_instant_blueprint_by_default = creative_mode_defines.name_prefix .. "enable-instant-blueprint-by-default",
	enable_instant_deconstruction_by_default = creative_mode_defines.name_prefix ..
		"enable-instant-deconstruction-by-default",
	enable_personal_long_reach_by_default = creative_mode_defines.name_prefix .. "enable-personal-long-reach-by-default",
	enable_personal_fast_run_by_default = creative_mode_defines.name_prefix .. "enable-personal-fast-run-by-default",
	default_technology_research_cheat_type = creative_mode_defines.name_prefix .. "default-technology-research-cheat-type",
	override_evolution_factor_by_default = creative_mode_defines.name_prefix .. "override-evolution-factor-by-default",
	default_evolution_factor = creative_mode_defines.name_prefix .. "default-evolution-factor"
}
-- Setting - default action values
creative_mode_defines.values.default_initial_actions = {
	show_popup = "Show popup",
	enable = "Enable",
	enable_all = "Enable all",
	disable = "Disable",
	disable_permanently = "Disable permanently"
}
-- Setting - default technology research cheat types
creative_mode_defines.values.default_technology_research_cheat_types = {
	research_all = "Research all",
	instant_research = "Instant research",
	nothing = "Nothing"
}

-- Entity names
creative_mode_defines.names.entities = {
	creative_chest = creative_mode_defines.name_prefix .. "creative-chest",
	creative_provider_chest = creative_mode_defines.name_prefix .. "creative-provider-chest",
	autofill_requester_chest = creative_mode_defines.name_prefix .. "autofill-requester-chest",
	duplicating_chest = creative_mode_defines.name_prefix .. "duplicating-chest",
	duplicating_provider_chest = creative_mode_defines.name_prefix .. "duplicating-provider-chest",
	void_requester_chest = creative_mode_defines.name_prefix .. "void-requester-chest",
	void_chest = creative_mode_defines.name_prefix .. "void-chest",
	void_storage_chest = creative_mode_defines.name_prefix .. "void-storage-chest",
	super_loader = creative_mode_defines.name_prefix .. "super-loader",
	creative_cargo_wagon = creative_mode_defines.name_prefix .. "creative-cargo-wagon",
	duplicating_cargo_wagon = creative_mode_defines.name_prefix .. "duplicating-cargo-wagon",
	void_cargo_wagon = creative_mode_defines.name_prefix .. "void-cargo-wagon",
	super_logistic_robot = creative_mode_defines.name_prefix .. "super-logistic-robot",
	super_construction_robot = creative_mode_defines.name_prefix .. "super-construction-robot",
	super_roboport = creative_mode_defines.name_prefix .. "super-roboport",
	fluid_source = creative_mode_defines.name_prefix .. "fluid-source",
	fluid_void = creative_mode_defines.name_prefix .. "fluid-void",
	super_boiler = creative_mode_defines.name_prefix .. "super-boiler",
	super_cooler = creative_mode_defines.name_prefix .. "super-cooler",
	configurable_super_boiler = creative_mode_defines.name_prefix .. "configurable-super-boiler",
	heat_source = creative_mode_defines.name_prefix .. "heat-source",
	heat_void = creative_mode_defines.name_prefix .. "heat-void",
	item_source = creative_mode_defines.name_prefix .. "item-source",
	duplicator = creative_mode_defines.name_prefix .. "duplicator",
	item_void = creative_mode_defines.name_prefix .. "item-void",
	random_item_source = creative_mode_defines.name_prefix .. "random-item-source",
	creative_lab = creative_mode_defines.name_prefix .. "creative-lab",
	void_lab = creative_mode_defines.name_prefix .. "void-lab",
	active_electric_energy_interface_output = creative_mode_defines.name_prefix ..
		"active-electric-energy-interface-output",
	active_electric_energy_interface_input = creative_mode_defines.name_prefix .. "active-electric-energy-interface-input",
	passive_electric_energy_interface = creative_mode_defines.name_prefix .. "passive-electric-energy-interface",
	energy_source = creative_mode_defines.name_prefix .. "energy-source",
	passive_energy_source = creative_mode_defines.name_prefix .. "passive-energy-source",
	energy_void = creative_mode_defines.name_prefix .. "energy-void",
	passive_energy_void = creative_mode_defines.name_prefix .. "passive-energy-void",
	super_electric_pole = creative_mode_defines.name_prefix .. "super-electric-pole",
	super_substation = creative_mode_defines.name_prefix .. "super-substation",
	magic_wand_smoke_creator = creative_mode_defines.name_prefix .. "magic-wand-smoke-creator",
	magic_wand_smoke_healer = creative_mode_defines.name_prefix .. "magic-wand-smoke-healer",
	magic_wand_smoke_modifier = creative_mode_defines.name_prefix .. "magic-wand-smoke-modifier",
	super_radar = creative_mode_defines.name_prefix .. "super-radar",
	super_radar_2 = creative_mode_defines.name_prefix .. "super-radar-2",
	alien_attractor_proxy_small = creative_mode_defines.name_prefix .. "alien-attractor-proxy-small",
	alien_attractor_proxy_medium = creative_mode_defines.name_prefix .. "alien-attractor-proxy-medium",
	alien_attractor_proxy_large = creative_mode_defines.name_prefix .. "alien-attractor-proxy-large",
	super_beacon = creative_mode_defines.name_prefix .. "super-beacon"
}
-- Technology names
creative_mode_defines.names.technology = {
	void_technology = creative_mode_defines.name_prefix .. "void-technology",
}
-- Equipment names
creative_mode_defines.names.equipments = {
	super_fusion_reactor_equipment = creative_mode_defines.name_prefix .. "super-fusion-reactor-equipment",
	super_personal_roboport_equipment = creative_mode_defines.name_prefix .. "super-personal-roboport-equipment"
}
-- Item names
creative_mode_defines.names.items = {
	creative_chest = creative_mode_defines.name_prefix .. "creative-chest",
	creative_provider_chest = creative_mode_defines.name_prefix .. "creative-provider-chest",
	autofill_requester_chest = creative_mode_defines.name_prefix .. "autofill-requester-chest",
	duplicating_chest = creative_mode_defines.name_prefix .. "duplicating-chest",
	duplicating_provider_chest = creative_mode_defines.name_prefix .. "duplicating-provider-chest",
	void_requester_chest = creative_mode_defines.name_prefix .. "void-requester-chest",
	void_chest = creative_mode_defines.name_prefix .. "void-chest",
	void_storage_chest = creative_mode_defines.name_prefix .. "void-storage-chest",
	super_loader = creative_mode_defines.name_prefix .. "super-loader",
	creative_cargo_wagon = creative_mode_defines.name_prefix .. "creative-cargo-wagon",
	duplicating_cargo_wagon = creative_mode_defines.name_prefix .. "duplicating-cargo-wagon",
	void_cargo_wagon = creative_mode_defines.name_prefix .. "void-cargo-wagon",
	super_logistic_robot = creative_mode_defines.name_prefix .. "super-logistic-robot",
	super_construction_robot = creative_mode_defines.name_prefix .. "super-construction-robot",
	super_roboport = creative_mode_defines.name_prefix .. "super-roboport",
	fluid_source = creative_mode_defines.name_prefix .. "fluid-source",
	fluid_void = creative_mode_defines.name_prefix .. "fluid-void",
	super_boiler = creative_mode_defines.name_prefix .. "super-boiler",
	super_cooler = creative_mode_defines.name_prefix .. "super-cooler",
	configurable_super_boiler = creative_mode_defines.name_prefix .. "configurable-super-boiler",
	heat_source = creative_mode_defines.name_prefix .. "heat-source",
	heat_void = creative_mode_defines.name_prefix .. "heat-void",
	item_source = creative_mode_defines.name_prefix .. "item-source",
	duplicator = creative_mode_defines.name_prefix .. "duplicator",
	item_void = creative_mode_defines.name_prefix .. "item-void",
	random_item_source = creative_mode_defines.name_prefix .. "random-item-source",
	creative_lab = creative_mode_defines.name_prefix .. "creative-lab",
	void_lab = creative_mode_defines.name_prefix .. "void-lab",
	active_electric_energy_interface_output = creative_mode_defines.name_prefix ..
		"active-electric-energy-interface-output",
	active_electric_energy_interface_input = creative_mode_defines.name_prefix .. "active-electric-energy-interface-input",
	passive_electric_energy_interface = creative_mode_defines.name_prefix .. "passive-electric-energy-interface",
	energy_source = creative_mode_defines.name_prefix .. "energy-source",
	passive_energy_source = creative_mode_defines.name_prefix .. "passive-energy-source",
	energy_void = creative_mode_defines.name_prefix .. "energy-void",
	energy_absorption = creative_mode_defines.name_prefix .. "energy-absorption",
	passive_energy_void = creative_mode_defines.name_prefix .. "passive-energy-void",
	super_electric_pole = creative_mode_defines.name_prefix .. "super-electric-pole",
	super_substation = creative_mode_defines.name_prefix .. "super-substation",
	magic_wand_creator = creative_mode_defines.name_prefix .. "magic-wand-creator",
	magic_wand_healer = creative_mode_defines.name_prefix .. "magic-wand-healer",
	magic_wand_modifier = creative_mode_defines.name_prefix .. "magic-wand-modifier",
	super_radar = creative_mode_defines.name_prefix .. "super-radar",
	super_radar_2 = creative_mode_defines.name_prefix .. "super-radar-2",
	alien_attractor_small = creative_mode_defines.name_prefix .. "alien-attractor-small",
	alien_attractor_medium = creative_mode_defines.name_prefix .. "alien-attractor-medium",
	alien_attractor_large = creative_mode_defines.name_prefix .. "alien-attractor-large",
	super_beacon = creative_mode_defines.name_prefix .. "super-beacon",
	super_speed_module = creative_mode_defines.name_prefix .. "super-speed-module",
	super_effectivity_module = creative_mode_defines.name_prefix .. "super-effectivity-module",
	super_productivity_module = creative_mode_defines.name_prefix .. "super-productivity-module",
	super_clean_module = creative_mode_defines.name_prefix .. "super-clean-module",
	super_slow_module = creative_mode_defines.name_prefix .. "super-slow-module",
	super_consumption_module = creative_mode_defines.name_prefix .. "super-consumption-module",
	super_pollution_module = creative_mode_defines.name_prefix .. "super-pollution-module",
	belt_immunity_equipment = "belt-immunity-equipment",
	super_fusion_reactor_equipment = creative_mode_defines.name_prefix .. "super-fusion-reactor-equipment",
	super_personal_roboport_equipment = creative_mode_defines.name_prefix .. "super-personal-roboport-equipment"
}
-- Item group names
creative_mode_defines.names.item_groups = {
	creative_tools = creative_mode_defines.name_prefix .. "creative-tools"
}
-- Item subgroup names
creative_mode_defines.names.item_subgroups = {
	items = creative_mode_defines.name_prefix .. "items",
	vehicles = creative_mode_defines.name_prefix .. "vehicles",
	fluids = creative_mode_defines.name_prefix .. "fluids",
	advanced = creative_mode_defines.name_prefix .. "advanced",
	energy = creative_mode_defines.name_prefix .. "energy",
	magic_wands = creative_mode_defines.name_prefix .. "magic-wands",
	enemies = creative_mode_defines.name_prefix .. "enemies",
	modules = creative_mode_defines.name_prefix .. "modules",
	equipments = creative_mode_defines.name_prefix .. "equipments",
	free_fluids = creative_mode_defines.name_prefix .. "free-fluids"
}
-- Recipe names
creative_mode_defines.names.recipes = {
	creative_chest = creative_mode_defines.name_prefix .. "creative-chest",
	creative_provider_chest = creative_mode_defines.name_prefix .. "creative-provider-chest",
	autofill_requester_chest = creative_mode_defines.name_prefix .. "autofill-requester-chest",
	duplicating_chest = creative_mode_defines.name_prefix .. "duplicating-chest",
	duplicating_provider_chest = creative_mode_defines.name_prefix .. "duplicating-provider-chest",
	void_requester_chest = creative_mode_defines.name_prefix .. "void-requester-chest",
	void_chest = creative_mode_defines.name_prefix .. "void-chest",
	void_storage_chest = creative_mode_defines.name_prefix .. "void-storage-chest",
	super_loader = creative_mode_defines.name_prefix .. "super-loader",
	creative_cargo_wagon = creative_mode_defines.name_prefix .. "creative-cargo-wagon",
	duplicating_cargo_wagon = creative_mode_defines.name_prefix .. "duplicating-cargo-wagon",
	void_cargo_wagon = creative_mode_defines.name_prefix .. "void-cargo-wagon",
	super_logistic_robot = creative_mode_defines.name_prefix .. "super-logistic-robot",
	super_construction_robot = creative_mode_defines.name_prefix .. "super-construction-robot",
	super_roboport = creative_mode_defines.name_prefix .. "super-roboport",
	fluid_source = creative_mode_defines.name_prefix .. "fluid-source",
	fluid_void = creative_mode_defines.name_prefix .. "fluid-void",
	super_boiler = creative_mode_defines.name_prefix .. "super-boiler",
	super_cooler = creative_mode_defines.name_prefix .. "super-cooler",
	configurable_super_boiler = creative_mode_defines.name_prefix .. "configurable-super-boiler",
	heat_source = creative_mode_defines.name_prefix .. "heat-source",
	heat_void = creative_mode_defines.name_prefix .. "heat-void",
	item_source = creative_mode_defines.name_prefix .. "item-source",
	duplicator = creative_mode_defines.name_prefix .. "duplicator",
	item_void = creative_mode_defines.name_prefix .. "item-void",
	random_item_source = creative_mode_defines.name_prefix .. "random-item-source",
	creative_lab = creative_mode_defines.name_prefix .. "creative-lab",
	void_lab = creative_mode_defines.name_prefix .. "void-lab",
	active_electric_energy_interface_output = creative_mode_defines.name_prefix ..
		"active-electric-energy-interface-output",
	active_electric_energy_interface_input = creative_mode_defines.name_prefix .. "active-electric-energy-interface-input",
	passive_electric_energy_interface = creative_mode_defines.name_prefix .. "passive-electric-energy-interface",
	energy_source = creative_mode_defines.name_prefix .. "energy-source",
	passive_energy_source = creative_mode_defines.name_prefix .. "passive-energy-source",
	energy_void = creative_mode_defines.name_prefix .. "energy-void",
	energy_absorption = creative_mode_defines.name_prefix .. "energy-absorption",
	passive_energy_void = creative_mode_defines.name_prefix .. "passive-energy-void",
	super_electric_pole = creative_mode_defines.name_prefix .. "super-electric-pole",
	super_substation = creative_mode_defines.name_prefix .. "super-substation",
	magic_wand_creator = creative_mode_defines.name_prefix .. "magic-wand-creator",
	magic_wand_healer = creative_mode_defines.name_prefix .. "magic-wand-healer",
	magic_wand_modifier = creative_mode_defines.name_prefix .. "magic-wand-modifier",
	super_radar = creative_mode_defines.name_prefix .. "super-radar",
	super_radar_2 = creative_mode_defines.name_prefix .. "super-radar-2",
	alien_attractor_small = creative_mode_defines.name_prefix .. "alien-attractor-small",
	alien_attractor_medium = creative_mode_defines.name_prefix .. "alien-attractor-medium",
	alien_attractor_large = creative_mode_defines.name_prefix .. "alien-attractor-large",
	super_beacon = creative_mode_defines.name_prefix .. "super-beacon",
	super_speed_module = creative_mode_defines.name_prefix .. "super-speed-module",
	super_effectivity_module = creative_mode_defines.name_prefix .. "super-effectivity-module",
	super_productivity_module = creative_mode_defines.name_prefix .. "super-productivity-module",
	super_clean_module = creative_mode_defines.name_prefix .. "super-clean-module",
	super_slow_module = creative_mode_defines.name_prefix .. "super-slow-module",
	super_consumption_module = creative_mode_defines.name_prefix .. "super-consumption-module",
	super_pollution_module = creative_mode_defines.name_prefix .. "super-pollution-module",
	belt_immunity_equipment = creative_mode_defines.name_prefix .. "belt-immunity-equipment",
	super_fusion_reactor_equipment = creative_mode_defines.name_prefix .. "super-fusion-reactor-equipment",
	super_personal_roboport_equipment = creative_mode_defines.name_prefix .. "super-personal-roboport-equipment"
}
-- Recipe category names
creative_mode_defines.names.recipe_categories = {
	free_fluids = creative_mode_defines.name_prefix .. "free-fluids",
	energy_absorption = creative_mode_defines.name_prefix .. "energy-absorption"
}
-- Entity fast replaceable group names
creative_mode_defines.names.fast_replaceable_groups = {
	creative_chest = creative_mode_defines.name_prefix .. "creative-chest",
	fluid_source_void = creative_mode_defines.name_prefix .. "fluid-source-void",
	heat_source_void = creative_mode_defines.name_prefix .. "heat-source-void",
	item_source_void_duplicator = creative_mode_defines.name_prefix .. "item-source-void-duplicator",
	energy_source_void = creative_mode_defines.name_prefix .. "energy-source-void",
	electric_energy_interface = creative_mode_defines.name_prefix .. "electric-energy-interface"
}
-- Interface name
creative_mode_defines.names.interface = "creative-mode"
-- GUI element names
creative_mode_defines.names.gui = {
	popup = creative_mode_defines.name_prefix .. "popup",
	popup_label = creative_mode_defines.name_prefix .. "popup-label",
	popup_label2 = creative_mode_defines.name_prefix .. "popup-label2",
	popup_buttons_container = creative_mode_defines.name_prefix .. "popup-buttons-container",
	enable_creative_mode_yes = creative_mode_defines.name_prefix .. "enable-creative-mode_yes",
	enable_creative_mode_yes_with_cheats = creative_mode_defines.name_prefix .. "enable-creative-mode_yes-with-cheats",
	enable_creative_mode_no = creative_mode_defines.name_prefix .. "enable-creative-mode_no",
	enable_creative_mode_no_permanently = creative_mode_defines.name_prefix .. "enable-creative-mode_no-permanently",
	disable_creative_mode_yes = creative_mode_defines.name_prefix .. "disable-creative-mode_yes",
	disable_creative_mode_no = creative_mode_defines.name_prefix .. "disable-creative-mode_no",
	permanent_disable_creative_mode_yes = creative_mode_defines.name_prefix .. "permanent-disable-creative-mode_yes",
	permanent_disable_creative_mode_no = creative_mode_defines.name_prefix .. "permanent-disable-creative-mode_no",
	main_menu_open_button = creative_mode_defines.name_prefix .. "main-menu-open-button",
	main_menu_container = creative_mode_defines.name_prefix .. "main-menu-container",
	main_menu_frame = creative_mode_defines.name_prefix .. "main-menu-frame",
	main_menu_open_cheats_button = creative_mode_defines.name_prefix .. "main-menu-open-cheats-button",
	main_menu_open_build_options_button = creative_mode_defines.name_prefix .. "main-menu-open-build-options-button",
	main_menu_open_magic_wand_button = creative_mode_defines.name_prefix .. "main-menu-open-magic-wand-button",
	main_menu_open_modding_button = creative_mode_defines.name_prefix .. "main-menu-open-modding-button",
	main_menu_open_admin_button = creative_mode_defines.name_prefix .. "main-menu-open-admin-button",
	cheats_menus_container = creative_mode_defines.name_prefix .. "cheats-menus-container",
	cheats_menu_frame = creative_mode_defines.name_prefix .. "cheats-menu-frame",
	personal_cheats_menu_button = creative_mode_defines.name_prefix .. "personal-cheats-menu-button",
	team_cheats_menu_button = creative_mode_defines.name_prefix .. "team-cheats-menu-button",
	surface_cheats_menu_button = creative_mode_defines.name_prefix .. "surface-cheats-menu-button",
	global_cheats_menu_button = creative_mode_defines.name_prefix .. "global-cheats-menu-button",
	personal_cheats_menu_frame = creative_mode_defines.name_prefix .. "personal-cheats-menu-frame",
	personal_cheats_outer_container = creative_mode_defines.name_prefix .. "personal-cheats-outer-container",
	personal_cheats_targets_scroll_pane = creative_mode_defines.name_prefix .. "personal-cheats-targets-scroll-pane",
	personal_cheats_targets_container = creative_mode_defines.name_prefix .. "personal-cheats-targets-container",
	personal_cheats_targets_inner_container = creative_mode_defines.name_prefix ..
		"personal-cheats-targets-inner-container",
	personal_cheats_target_index_button_prefix = creative_mode_defines.name_prefix ..
		"personal-cheats-target-index-button-",
	personal_cheats_targets_select_all_button = creative_mode_defines.name_prefix ..
		"personal-cheats-targets-select-all-button",
	personal_cheats_cheats_scroll_pane = creative_mode_defines.name_prefix .. "personal-cheats-cheats-scroll-pane",
	personal_cheats_cheats_container = creative_mode_defines.name_prefix .. "personal-cheats-cheats-container",
	cheat_mode_container = creative_mode_defines.name_prefix .. "cheat-mode-container",
	cheat_mode_label = creative_mode_defines.name_prefix .. "cheat-mode-label",
	cheat_mode_on_button = creative_mode_defines.name_prefix .. "cheat-mode-on-button",
	cheat_mode_off_button = creative_mode_defines.name_prefix .. "cheat-mode-off-button",
	invincible_player_container = creative_mode_defines.name_prefix .. "invincible-player-container",
	invincible_player_label = creative_mode_defines.name_prefix .. "invincible-player-label",
	invincible_player_on_button = creative_mode_defines.name_prefix .. "invincible-player-on-button",
	invincible_player_off_button = creative_mode_defines.name_prefix .. "invincible-player-off-button",
	keep_last_item_container = creative_mode_defines.name_prefix .. "keep-last-item-container",
	keep_last_item_label = creative_mode_defines.name_prefix .. "keep-last-item-label",
	keep_last_item_on_button = creative_mode_defines.name_prefix .. "keep-last-item-on-button",
	keep_last_item_off_button = creative_mode_defines.name_prefix .. "keep-last-item-off-button",
	repair_mined_item_container = creative_mode_defines.name_prefix .. "repair-mined-item-container",
	repair_mined_item_label = creative_mode_defines.name_prefix .. "repair-mined-item-label",
	repair_mined_item_on_button = creative_mode_defines.name_prefix .. "repair-mined-item-on-button",
	repair_mined_item_off_button = creative_mode_defines.name_prefix .. "repair-mined-item-off-button",
	instant_request_container = creative_mode_defines.name_prefix .. "instant-request-container",
	instant_request_label = creative_mode_defines.name_prefix .. "instant-request-label",
	instant_request_on_button = creative_mode_defines.name_prefix .. "instant-request-on-button",
	instant_request_off_button = creative_mode_defines.name_prefix .. "instant-request-off-button",
	instant_trash_container = creative_mode_defines.name_prefix .. "instant-trash-container",
	instant_trash_label = creative_mode_defines.name_prefix .. "instant-trash-label",
	instant_trash_on_button = creative_mode_defines.name_prefix .. "instant-trash-on-button",
	instant_trash_off_button = creative_mode_defines.name_prefix .. "instant-trash-off-button",
	instant_blueprint_container = creative_mode_defines.name_prefix .. "instant-blueprint-container",
	instant_blueprint_label = creative_mode_defines.name_prefix .. "instant-blueprint-label",
	instant_blueprint_on_button = creative_mode_defines.name_prefix .. "instant-blueprint-on-button",
	instant_blueprint_off_button = creative_mode_defines.name_prefix .. "instant-blueprint-off-button",
	instant_deconstruction_container = creative_mode_defines.name_prefix .. "instant_deconstruction-container",
	instant_deconstruction_label = creative_mode_defines.name_prefix .. "instant_deconstruction-label",
	instant_deconstruction_on_button = creative_mode_defines.name_prefix .. "instant_deconstruction-on-button",
	instant_deconstruction_off_button = creative_mode_defines.name_prefix .. "instant_deconstruction-off-button",
	reach_distance_container = creative_mode_defines.name_prefix .. "reach-distance-container",
	reach_distance_label = creative_mode_defines.name_prefix .. "reach-distance-label",
	reach_distance_textfield = creative_mode_defines.name_prefix .. "reach-distance-textfield",
	reach_distance_separator = creative_mode_defines.name_prefix .. "reach-distance-separator",
	reach_distance_apply_button = creative_mode_defines.name_prefix .. "reach-distance-apply-button",
	build_distance_container = creative_mode_defines.name_prefix .. "build-distance-container",
	build_distance_label = creative_mode_defines.name_prefix .. "build-distance-label",
	build_distance_textfield = creative_mode_defines.name_prefix .. "build-distance-textfield",
	build_distance_separator = creative_mode_defines.name_prefix .. "build-distance-separator",
	build_distance_apply_button = creative_mode_defines.name_prefix .. "build-distance-apply-button",
	resource_reach_distance_container = creative_mode_defines.name_prefix .. "resource-reach-distance-container",
	resource_reach_distance_label = creative_mode_defines.name_prefix .. "resource-reach-distance-label",
	resource_reach_distance_textfield = creative_mode_defines.name_prefix .. "resource-reach-distance-textfield",
	resource_reach_distance_separator = creative_mode_defines.name_prefix .. "resource-reach-distance-separator",
	resource_reach_distance_apply_button = creative_mode_defines.name_prefix .. "resource-reach-distance-apply-button",
	item_drop_distance_container = creative_mode_defines.name_prefix .. "item-drop-distance-container",
	item_drop_distance_label = creative_mode_defines.name_prefix .. "item-drop-distance-label",
	item_drop_distance_textfield = creative_mode_defines.name_prefix .. "item-drop-distance-textfield",
	item_drop_distance_separator = creative_mode_defines.name_prefix .. "item-drop-distance-separator",
	item_drop_distance_apply_button = creative_mode_defines.name_prefix .. "item-drop-distance-apply-button",
	item_pickup_distance_container = creative_mode_defines.name_prefix .. "item-pickup-distance-container",
	item_pickup_distance_label = creative_mode_defines.name_prefix .. "item-pickup-distance-label",
	item_pickup_distance_textfield = creative_mode_defines.name_prefix .. "item-pickup-distance-textfield",
	item_pickup_distance_separator = creative_mode_defines.name_prefix .. "item-pickup-distance-separator",
	item_pickup_distance_apply_button = creative_mode_defines.name_prefix .. "item-pickup-distance-apply-button",
	loot_pickup_distance_container = creative_mode_defines.name_prefix .. "loot-pickup-distance-container",
	loot_pickup_distance_label = creative_mode_defines.name_prefix .. "loot-pickup-distance-label",
	loot_pickup_distance_textfield = creative_mode_defines.name_prefix .. "loot-pickup-distance-textfield",
	loot_pickup_distance_separator = creative_mode_defines.name_prefix .. "loot-pickup-distance-separator",
	loot_pickup_distance_apply_button = creative_mode_defines.name_prefix .. "loot-pickup-distance-apply-button",
	mining_speed_container = creative_mode_defines.name_prefix .. "mining-speed-container",
	mining_speed_label = creative_mode_defines.name_prefix .. "mining-speed-label",
	mining_speed_textfield = creative_mode_defines.name_prefix .. "mining-speed-textfield",
	mining_speed_separator = creative_mode_defines.name_prefix .. "mining-speed-separator",
	mining_speed_apply_button = creative_mode_defines.name_prefix .. "mining-speed-apply-button",
	running_speed_container = creative_mode_defines.name_prefix .. "running-speed-container",
	running_speed_label = creative_mode_defines.name_prefix .. "running-speed-label",
	running_speed_textfield = creative_mode_defines.name_prefix .. "running-speed-textfield",
	running_speed_separator = creative_mode_defines.name_prefix .. "running-speed-separator",
	running_speed_apply_button = creative_mode_defines.name_prefix .. "running-speed-apply-button",
	crafting_speed_container = creative_mode_defines.name_prefix .. "crafting-speed-container",
	crafting_speed_label = creative_mode_defines.name_prefix .. "crafting-speed-label",
	crafting_speed_textfield = creative_mode_defines.name_prefix .. "crafting-speed-textfield",
	crafting_speed_separator = creative_mode_defines.name_prefix .. "crafting-speed-separator",
	crafting_speed_apply_button = creative_mode_defines.name_prefix .. "crafting-speed-apply-button",
	inventory_bonus_container = creative_mode_defines.name_prefix .. "inventory-bonus-container",
	inventory_bonus_label = creative_mode_defines.name_prefix .. "inventory-bonus-label",
	inventory_bonus_textfield = creative_mode_defines.name_prefix .. "inventory-bonus-textfield",
	inventory_bonus_separator = creative_mode_defines.name_prefix .. "inventory-bonus-separator",
	inventory_bonus_apply_button = creative_mode_defines.name_prefix .. "inventory-bonus-apply-button",
	quickbar_bonus_container = creative_mode_defines.name_prefix .. "quickbar-bonus-container",
	quickbar_bonus_label = creative_mode_defines.name_prefix .. "quickbar-bonus-label",
	quickbar_bonus_textfield = creative_mode_defines.name_prefix .. "quickbar-bonus-textfield",
	quickbar_bonus_separator = creative_mode_defines.name_prefix .. "quickbar-bonus-separator",
	quickbar_bonus_apply_button = creative_mode_defines.name_prefix .. "quickbar-bonus-apply-button",
	health_bonus_container = creative_mode_defines.name_prefix .. "health-bonus-container",
	health_bonus_label = creative_mode_defines.name_prefix .. "health-bonus-label",
	health_bonus_textfield = creative_mode_defines.name_prefix .. "health-bonus-textfield",
	health_bonus_separator = creative_mode_defines.name_prefix .. "health-bonus-separator",
	health_bonus_apply_button = creative_mode_defines.name_prefix .. "health-bonus-apply-button",
	god_mode_container = creative_mode_defines.name_prefix .. "god-mode-container",
	god_mode_label = creative_mode_defines.name_prefix .. "god-mode-label",
	god_mode_on_button = creative_mode_defines.name_prefix .. "god-mode-on-button",
	god_mode_off_button = creative_mode_defines.name_prefix .. "god-mode-off-button",
	personal_cheats_all_button_container = creative_mode_defines.name_prefix .. "personal-cheats-all-button-container",
	personal_cheats_enable_all_button = creative_mode_defines.name_prefix .. "personal-cheats-enable-all-button",
	personal_cheats_disable_all_button = creative_mode_defines.name_prefix .. "personal-cheats-disable-all-button",
	personal_cheats_not_included_in_enable_all_note = creative_mode_defines.name_prefix ..
		"personal-cheats-not-included-in-enable-all-note",
	team_cheats_menu_frame = creative_mode_defines.name_prefix .. "team-cheats-menu-frame",
	team_cheats_outer_container = creative_mode_defines.name_prefix .. "team-cheats-outer-container",
	team_cheats_targets_scroll_pane = creative_mode_defines.name_prefix .. "team-cheats-targets-scroll-pane",
	team_cheats_targets_container = creative_mode_defines.name_prefix .. "team-cheats-targets-container",
	team_cheats_targets_inner_container = creative_mode_defines.name_prefix .. "team-cheats-targets-inner-container",
	team_cheats_target_name_button_prefix = creative_mode_defines.name_prefix .. "team-cheats-target-name-button-",
	team_cheats_targets_select_all_button = creative_mode_defines.name_prefix .. "team-cheats-targets-select-all-button",
	team_cheats_cheats_scroll_pane = creative_mode_defines.name_prefix .. "team-cheats-cheats-scroll-pane",
	team_cheats_cheats_container = creative_mode_defines.name_prefix .. "team-cheats-cheats-container",
	creative_tools_recipes_container = creative_mode_defines.name_prefix .. "creative-tools-recipes-container",
	creative_tools_recipes_label = creative_mode_defines.name_prefix .. "creative-tools-recipes-label",
	creative_tools_recipes_on_button = creative_mode_defines.name_prefix .. "creative-tools-recipes-on-button",
	creative_tools_recipes_off_button = creative_mode_defines.name_prefix .. "creative-tools-recipes-off-button",
	loaders_recipes_container = creative_mode_defines.name_prefix .. "loaders-recipes-container",
	loaders_recipes_label = creative_mode_defines.name_prefix .. "loaders-recipes-label",
	loaders_recipes_on_button = creative_mode_defines.name_prefix .. "loaders-recipes-on-button",
	loaders_recipes_off_button = creative_mode_defines.name_prefix .. "loaders-recipes-off-button",
	railgun_recipes_container = creative_mode_defines.name_prefix .. "railgun-recipes-container",
	railgun_recipes_label = creative_mode_defines.name_prefix .. "railgun-recipes-label",
	railgun_recipes_on_button = creative_mode_defines.name_prefix .. "railgun-recipes-on-button",
	railgun_recipes_off_button = creative_mode_defines.name_prefix .. "railgun-recipes-off-button",
	player_port_recipe_container = creative_mode_defines.name_prefix .. "player-port-recipe-container",
	player_port_recipe_label = creative_mode_defines.name_prefix .. "player-port-recipe-label",
	player_port_recipe_on_button = creative_mode_defines.name_prefix .. "player-port-recipe-on-button",
	player_port_recipe_off_button = creative_mode_defines.name_prefix .. "player-port-recipe-off-button",
	all_technologies_container = creative_mode_defines.name_prefix .. "all-technologies-container",
	all_technologies_label = creative_mode_defines.name_prefix .. "all-technologies-label",
	all_technologies_unlock_button = creative_mode_defines.name_prefix .. "all-technologies-unlock-button",
	all_technologies_reset_button = creative_mode_defines.name_prefix .. "all-technologies-reset-button",
	instant_research_container = creative_mode_defines.name_prefix .. "instant-research-container",
	instant_research_label = creative_mode_defines.name_prefix .. "instant-research-label",
	instant_research_on_button = creative_mode_defines.name_prefix .. "instant-research-on-button",
	instant_research_off_button = creative_mode_defines.name_prefix .. "instant-research-off-button",
	team_reach_distance_container = creative_mode_defines.name_prefix .. "team-reach-distance-container",
	team_reach_distance_label = creative_mode_defines.name_prefix .. "team-reach-distance-label",
	team_reach_distance_textfield = creative_mode_defines.name_prefix .. "team-reach-distance-textfield",
	team_reach_distance_separator = creative_mode_defines.name_prefix .. "team-reach-distance-separator",
	team_reach_distance_apply_button = creative_mode_defines.name_prefix .. "team-reach-distance-apply-button",
	team_build_distance_container = creative_mode_defines.name_prefix .. "team-build-distance-container",
	team_build_distance_label = creative_mode_defines.name_prefix .. "team-build-distance-label",
	team_build_distance_textfield = creative_mode_defines.name_prefix .. "team-build-distance-textfield",
	team_build_distance_separator = creative_mode_defines.name_prefix .. "team-build-distance-separator",
	team_build_distance_apply_button = creative_mode_defines.name_prefix .. "team-build-distance-apply-button",
	team_resource_reach_distance_container = creative_mode_defines.name_prefix .. "team-resource-reach-distance-container",
	team_resource_reach_distance_label = creative_mode_defines.name_prefix .. "team-resource-distance-label",
	team_resource_reach_distance_textfield = creative_mode_defines.name_prefix .. "team-resource-distance-textfield",
	team_resource_reach_distance_separator = creative_mode_defines.name_prefix .. "team-resource-distance-separator",
	team_resource_reach_distance_apply_button = creative_mode_defines.name_prefix .. "team-resource-distance-apply-button",
	team_item_drop_distance_container = creative_mode_defines.name_prefix .. "team-item-drop-distance-container",
	team_item_drop_distance_label = creative_mode_defines.name_prefix .. "team-item-drop-distance-label",
	team_item_drop_distance_textfield = creative_mode_defines.name_prefix .. "team-item-drop-distance-textfield",
	team_item_drop_distance_separator = creative_mode_defines.name_prefix .. "team-item-drop-distance-separator",
	team_item_drop_distance_apply_button = creative_mode_defines.name_prefix .. "team-item-drop-distance-apply-button",
	team_item_pickup_distance_container = creative_mode_defines.name_prefix .. "team-item-pickup-distance-container",
	team_item_pickup_distance_label = creative_mode_defines.name_prefix .. "team-item-pickup-distance-label",
	team_item_pickup_distance_textfield = creative_mode_defines.name_prefix .. "team-item-pickup-distance-textfield",
	team_item_pickup_distance_separator = creative_mode_defines.name_prefix .. "team-item-pickup-distance-separator",
	team_item_pickup_distance_apply_button = creative_mode_defines.name_prefix .. "team-item-pickup-distance-apply-button",
	team_loot_pickup_distance_container = creative_mode_defines.name_prefix .. "team-loot-pickup-distance-container",
	team_loot_pickup_distance_label = creative_mode_defines.name_prefix .. "team-loot-pickup-distance-label",
	team_loot_pickup_distance_textfield = creative_mode_defines.name_prefix .. "team-loot-pickup-distance-textfield",
	team_loot_pickup_distance_separator = creative_mode_defines.name_prefix .. "team-loot-pickup-distance-separator",
	team_loot_pickup_distance_apply_button = creative_mode_defines.name_prefix .. "team-loot-pickup-distance-apply-button",
	team_mining_speed_container = creative_mode_defines.name_prefix .. "team-mining-speed-container",
	team_mining_speed_label = creative_mode_defines.name_prefix .. "team-mining-speed-label",
	team_mining_speed_textfield = creative_mode_defines.name_prefix .. "team-mining-speed-textfield",
	team_mining_speed_separator = creative_mode_defines.name_prefix .. "team-mining-speed-separator",
	team_mining_speed_apply_button = creative_mode_defines.name_prefix .. "team-mining-speed-apply-button",
	team_running_speed_container = creative_mode_defines.name_prefix .. "team-running-speed-container",
	team_running_speed_label = creative_mode_defines.name_prefix .. "team-running-speed-label",
	team_running_speed_textfield = creative_mode_defines.name_prefix .. "team-running-speed-textfield",
	team_running_speed_separator = creative_mode_defines.name_prefix .. "team-running-speed-separator",
	team_running_speed_apply_button = creative_mode_defines.name_prefix .. "team-running-speed-apply-button",
	team_crafting_speed_container = creative_mode_defines.name_prefix .. "team-crafting-speed-container",
	team_crafting_speed_label = creative_mode_defines.name_prefix .. "team-crafting-speed-label",
	team_crafting_speed_textfield = creative_mode_defines.name_prefix .. "team-crafting-speed-textfield",
	team_crafting_speed_separator = creative_mode_defines.name_prefix .. "team-crafting-speed-separator",
	team_crafting_speed_apply_button = creative_mode_defines.name_prefix .. "team-crafting-speed-apply-button",
	character_inventory_bonus_container = creative_mode_defines.name_prefix .. "character-inventory-bonus-container",
	character_inventory_bonus_label = creative_mode_defines.name_prefix .. "character-inventory-bonus-label",
	character_inventory_bonus_textfield = creative_mode_defines.name_prefix .. "character-inventory-bonus-textfield",
	character_inventory_bonus_separator = creative_mode_defines.name_prefix .. "character-inventory-bonus-separator",
	character_inventory_bonus_apply_button = creative_mode_defines.name_prefix .. "character-inventory-bonus-apply-button",
	quickbar_count_container = creative_mode_defines.name_prefix .. "quickbar-count-container",
	quickbar_count_label = creative_mode_defines.name_prefix .. "quickbar-count-label",
	quickbar_count_textfield = creative_mode_defines.name_prefix .. "quickbar-count-textfield",
	quickbar_count_separator = creative_mode_defines.name_prefix .. "quickbar-count-separator",
	quickbar_count_apply_button = creative_mode_defines.name_prefix .. "quickbar-count-apply-button",
	character_health_bonus_container = creative_mode_defines.name_prefix .. "character-health-bonus-container",
	character_health_bonus_label = creative_mode_defines.name_prefix .. "character-health-bonus-label",
	character_health_bonus_textfield = creative_mode_defines.name_prefix .. "character-health-bonus-textfield",
	character_health_bonus_separator = creative_mode_defines.name_prefix .. "character-health-bonus-separator",
	character_health_bonus_apply_button = creative_mode_defines.name_prefix .. "character-health-bonus-apply-button",
	inserter_capacity_bonus_container = creative_mode_defines.name_prefix .. "inserter-capacity-bonus-container",
	inserter_capacity_bonus_label = creative_mode_defines.name_prefix .. "inserter-capacity-bonus-label",
	inserter_capacity_bonus_textfield = creative_mode_defines.name_prefix .. "inserter-capacity-bonus-textfield",
	inserter_capacity_bonus_separator = creative_mode_defines.name_prefix .. "inserter-capacity-bonus-separator",
	inserter_capacity_bonus_apply_button = creative_mode_defines.name_prefix .. "inserter-capacity-bonus-apply-button",
	stack_inserter_capacity_bonus_container = creative_mode_defines.name_prefix ..
		"stack-inserter-capacity-bonus-container",
	stack_inserter_capacity_bonus_label = creative_mode_defines.name_prefix .. "stack-inserter-capacity-bonus-label",
	stack_inserter_capacity_bonus_textfield = creative_mode_defines.name_prefix ..
		"stack-inserter-capacity-bonus-textfield",
	stack_inserter_capacity_bonus_separator = creative_mode_defines.name_prefix ..
		"stack-inserter-capacity-bonus-separator",
	stack_inserter_capacity_bonus_apply_button = creative_mode_defines.name_prefix ..
		"stack-inserter-capacity-bonus-apply-button",
	evolution_factor_container = creative_mode_defines.name_prefix .. "evolution-factor-container",
	evolution_factor_label = creative_mode_defines.name_prefix .. "evolution-factor-label",
	evolution_factor_textfield = creative_mode_defines.name_prefix .. "evolution-factor-textfield",
	evolution_factor_separator = creative_mode_defines.name_prefix .. "evolution-factor-separator",
	evolution_factor_apply_button = creative_mode_defines.name_prefix .. "evolution-factor-apply-button",
	chart_all_container = creative_mode_defines.name_prefix .. "chart-all-container",
	chart_all_label = creative_mode_defines.name_prefix .. "chart-all-label",
	chart_all_apply_button = creative_mode_defines.name_prefix .. "chart-all-apply-button",
	kill_all_units_container = creative_mode_defines.name_prefix .. "kill-all-units-container",
	kill_all_units_label = creative_mode_defines.name_prefix .. "kill-all-units-label",
	kill_all_units_apply_button = creative_mode_defines.name_prefix .. "kill-all-units-apply-button",
	team_cheats_all_button_container = creative_mode_defines.name_prefix .. "team-cheats-all-button-container",
	team_cheats_enable_all_button = creative_mode_defines.name_prefix .. "team-cheats-enable-all-button",
	team_cheats_disable_all_button = creative_mode_defines.name_prefix .. "team-cheats-disable-all-button",
	team_cheats_not_included_in_enable_all_note = creative_mode_defines.name_prefix ..
		"team-cheats-not-included-in-enable-all-note",
	surface_cheats_menu_frame = creative_mode_defines.name_prefix .. "surface-cheats-menu-frame",
	surface_cheats_outer_container = creative_mode_defines.name_prefix .. "surface-cheats-outer-container",
	surface_cheats_targets_scroll_pane = creative_mode_defines.name_prefix .. "surface-cheats-targets-scroll-pane",
	surface_cheats_targets_container = creative_mode_defines.name_prefix .. "surface-cheats-targets-container",
	surface_cheats_targets_inner_container = creative_mode_defines.name_prefix .. "surface-cheats-targets-inner-container",
	surface_cheats_target_name_button_prefix = creative_mode_defines.name_prefix .. "surface-cheats-target-name-button-",
	surface_cheats_targets_select_all_button = creative_mode_defines.name_prefix ..
		"surface-cheats-targets-select-all-button",
	surface_cheats_cheats_scroll_pane = creative_mode_defines.name_prefix .. "surface-cheats-cheats-scroll-pane",
	surface_cheats_cheats_container = creative_mode_defines.name_prefix .. "surface-cheats-cheats-container",
	freeze_daytime_container = creative_mode_defines.name_prefix .. "freeze-daytime-container",
	freeze_daytime_label = creative_mode_defines.name_prefix .. "freeze-daytime-label",
	freeze_daytime_on_button = creative_mode_defines.name_prefix .. "freeze-daytime-on-button",
	freeze_daytime_off_button = creative_mode_defines.name_prefix .. "freeze-daytime-off-button",
	daytime_container = creative_mode_defines.name_prefix .. "daytime-container",
	daytime_label = creative_mode_defines.name_prefix .. "daytime-label",
	daytime_textfield = creative_mode_defines.name_prefix .. "daytime-textfield",
	daytime_separator = creative_mode_defines.name_prefix .. "daytime-separator",
	daytime_apply_button = creative_mode_defines.name_prefix .. "daytime-apply-button",
	daytime_selection_container = creative_mode_defines.name_prefix .. "daytime-selection-container",
	daytime_selection_label = creative_mode_defines.name_prefix .. "daytime-selection-label",
	daytime_selection_midday_button = creative_mode_defines.name_prefix .. "daytime-selection-midday-button",
	daytime_selection_midnight_button = creative_mode_defines.name_prefix .. "daytime-selection-midnight-button",
	peaceful_mode_container = creative_mode_defines.name_prefix .. "peaceful-mode-container",
	peaceful_mode_label = creative_mode_defines.name_prefix .. "peaceful-mode-label",
	peaceful_mode_on_button = creative_mode_defines.name_prefix .. "peaceful-mode-on-button",
	peaceful_mode_off_button = creative_mode_defines.name_prefix .. "peaceful-mode-off-button",
	destroy_all_enemies_container = creative_mode_defines.name_prefix .. "destroy-all-enemies-container",
	destroy_all_enemies_label = creative_mode_defines.name_prefix .. "destroy-all-enemies-label",
	destroy_all_enemies_apply_button = creative_mode_defines.name_prefix .. "destroy-all-enemies-apply-button",
	remove_all_enemies_container = creative_mode_defines.name_prefix .. "remove-all-enemies-container",
	remove_all_enemies_label = creative_mode_defines.name_prefix .. "remove-all-enemies-label",
	remove_all_enemies_apply_button = creative_mode_defines.name_prefix .. "remove-all-enemies-apply-button",
	dont_generate_enemy_container = creative_mode_defines.name_prefix .. "dont-generate-enemy-container",
	dont_generate_enemy_label = creative_mode_defines.name_prefix .. "dont-generate-enemy-label",
	dont_generate_enemy_on_button = creative_mode_defines.name_prefix .. "dont-generate-enemy-on-button",
	dont_generate_enemy_off_button = creative_mode_defines.name_prefix .. "dont-generate-enemy-off-button",
	global_cheats_menu_frame = creative_mode_defines.name_prefix .. "global-cheats-menu-frame",
	global_cheats_table = creative_mode_defines.name_prefix .. "global-cheats-table",
	global_cheats_cheats_scroll_pane = creative_mode_defines.name_prefix .. "global-cheats-cheats-scroll-pane",
	global_cheats_cheats_container = creative_mode_defines.name_prefix .. "global-cheats-cheats-container",
	pollution_container = creative_mode_defines.name_prefix .. "pollution-container",
	pollution_label = creative_mode_defines.name_prefix .. "pollution-label",
	pollution_on_button = creative_mode_defines.name_prefix .. "pollution-on-button",
	pollution_off_button = creative_mode_defines.name_prefix .. "pollution-off-button",
	enemy_evolution_container = creative_mode_defines.name_prefix .. "enemy-evolution-container",
	enemy_evolution_label = creative_mode_defines.name_prefix .. "enemy-evolution-label",
	enemy_evolution_on_button = creative_mode_defines.name_prefix .. "enemy-evolution-on-button",
	enemy_evolution_off_button = creative_mode_defines.name_prefix .. "enemy-evolution-off-button",
	evolution_time_factor_container = creative_mode_defines.name_prefix .. "evolution-time-factor-container",
	evolution_time_factor_label = creative_mode_defines.name_prefix .. "evolution-time-factor-label",
	evolution_time_factor_textfield = creative_mode_defines.name_prefix .. "evolution-time-factor-textfield",
	evolution_time_factor_separator = creative_mode_defines.name_prefix .. "evolution-time-factor-separator",
	evolution_time_factor_apply_button = creative_mode_defines.name_prefix .. "evolution-time-factor-apply-button",
	evolution_destroy_factor_container = creative_mode_defines.name_prefix .. "evolution-destroy-factor-container",
	evolution_destroy_factor_label = creative_mode_defines.name_prefix .. "evolution-destroy-factor-label",
	evolution_destroy_factor_textfield = creative_mode_defines.name_prefix .. "evolution-destroy-factor-textfield",
	evolution_destroy_factor_separator = creative_mode_defines.name_prefix .. "evolution-destroy-factor-separator",
	evolution_destroy_factor_apply_button = creative_mode_defines.name_prefix .. "evolution-destroy-factor-apply-button",
	evolution_pollution_factor_container = creative_mode_defines.name_prefix .. "evolution-pollution-factor-container",
	evolution_pollution_factor_label = creative_mode_defines.name_prefix .. "evolution-pollution-factor-label",
	evolution_pollution_factor_textfield = creative_mode_defines.name_prefix .. "evolution-pollution-factor-textfield",
	evolution_pollution_factor_separator = creative_mode_defines.name_prefix .. "evolution-pollution-factor-separator",
	evolution_pollution_factor_apply_button = creative_mode_defines.name_prefix ..
		"evolution-pollution-factor-apply-button",
	enemy_expansion_container = creative_mode_defines.name_prefix .. "enemy-expansion-container",
	enemy_expansion_label = creative_mode_defines.name_prefix .. "enemy-expansion-label",
	enemy_expansion_on_button = creative_mode_defines.name_prefix .. "enemy-expansion-on-button",
	enemy_expansion_off_button = creative_mode_defines.name_prefix .. "enemy-expansion-off-button",
	enemy_expansion_min_cooldown_container = creative_mode_defines.name_prefix .. "enemy-expansion-min-cooldown-container",
	enemy_expansion_min_cooldown_label = creative_mode_defines.name_prefix .. "enemy-expansion-min-cooldown-label",
	enemy_expansion_min_cooldown_textfield = creative_mode_defines.name_prefix .. "enemy-expansion-min-cooldown-textfield",
	enemy_expansion_min_cooldown_separator = creative_mode_defines.name_prefix .. "enemy-expansion-min-cooldown-separator",
	enemy_expansion_min_cooldown_apply_button = creative_mode_defines.name_prefix ..
		"enemy-expansion-min-cooldown-apply-button",
	enemy_expansion_max_cooldown_container = creative_mode_defines.name_prefix .. "enemy-expansion-max-cooldown-container",
	enemy_expansion_max_cooldown_label = creative_mode_defines.name_prefix .. "enemy-expansion-max-cooldown-label",
	enemy_expansion_max_cooldown_textfield = creative_mode_defines.name_prefix .. "enemy-expansion-max-cooldown-textfield",
	enemy_expansion_max_cooldown_separator = creative_mode_defines.name_prefix .. "enemy-expansion-max-cooldown-separator",
	enemy_expansion_max_cooldown_apply_button = creative_mode_defines.name_prefix ..
		"enemy-expansion-max-cooldown-apply-button",
	game_speed_container = creative_mode_defines.name_prefix .. "game-speed-container",
	game_speed_label = creative_mode_defines.name_prefix .. "game-speed-label",
	game_speed_textfield = creative_mode_defines.name_prefix .. "game-speed-textfield",
	game_speed_separator = creative_mode_defines.name_prefix .. "game-speed-separator",
	game_speed_apply_button = creative_mode_defines.name_prefix .. "game-speed-apply-button",
	build_options_menus_container = creative_mode_defines.name_prefix .. "build-options-menus_container",
	build_options_frame = creative_mode_defines.name_prefix .. "build-options-frame",
	build_options_outer_contianer = creative_mode_defines.name_prefix .. "build-options-outer-container",
	build_options_targets_scroll_pane = creative_mode_defines.name_prefix .. "build-options-targets-scroll-pane",
	build_options_targets_container = creative_mode_defines.name_prefix .. "build-options-targets-container",
	build_options_targets_inner_container = creative_mode_defines.name_prefix .. "build-options-targets-inner-container",
	build_options_target_index_button_prefix = creative_mode_defines.name_prefix .. "build-options-target-index-button-",
	build_options_targets_select_all_button = creative_mode_defines.name_prefix ..
		"build-options-targets-select-all-button",
	build_options_cheats_scroll_pane = creative_mode_defines.name_prefix .. "build-options-cheats-scroll-pane",
	build_options_cheats_container = creative_mode_defines.name_prefix .. "build-options-cheats-container",
	build_active_container = creative_mode_defines.name_prefix .. "build-active-container",
	build_active_label = creative_mode_defines.name_prefix .. "build-active-label",
	build_active_on_button = creative_mode_defines.name_prefix .. "build-active-on-button",
	build_active_off_button = creative_mode_defines.name_prefix .. "build-active-off-button",
	build_destructible_container = creative_mode_defines.name_prefix .. "build-destructible-container",
	build_destructible_label = creative_mode_defines.name_prefix .. "build-destructible-label",
	build_destructible_on_button = creative_mode_defines.name_prefix .. "build-destructible-on-button",
	build_destructible_off_button = creative_mode_defines.name_prefix .. "build-destructible-off-button",
	build_minable_container = creative_mode_defines.name_prefix .. "build-minable-container",
	build_minable_label = creative_mode_defines.name_prefix .. "build-minable-label",
	build_minable_on_button = creative_mode_defines.name_prefix .. "build-minable-on-button",
	build_minable_off_button = creative_mode_defines.name_prefix .. "build-minable-off-button",
	build_rotatable_container = creative_mode_defines.name_prefix .. "build-rotatable-container",
	build_rotatable_label = creative_mode_defines.name_prefix .. "build-rotatable-label",
	build_rotatable_on_button = creative_mode_defines.name_prefix .. "build-rotatable-on-button",
	build_rotatable_off_button = creative_mode_defines.name_prefix .. "build-rotatable-off-button",
	build_operable_container = creative_mode_defines.name_prefix .. "build-operable-container",
	build_operable_label = creative_mode_defines.name_prefix .. "build-operable-label",
	build_operable_on_button = creative_mode_defines.name_prefix .. "build-operable-on-button",
	build_operable_off_button = creative_mode_defines.name_prefix .. "build-operable-off-button",
	build_full_health_container = creative_mode_defines.name_prefix .. "build-full-health-container",
	build_full_health_label = creative_mode_defines.name_prefix .. "build-full-health-label",
	build_full_health_on_button = creative_mode_defines.name_prefix .. "build-full-health-on-button",
	build_full_health_off_button = creative_mode_defines.name_prefix .. "build-full-health-off-button",
	build_team_container = creative_mode_defines.name_prefix .. "build-team-container",
	build_team_label = creative_mode_defines.name_prefix .. "build-team-label",
	build_team_targets_drop_down_container = creative_mode_defines.name_prefix .. "build-team-targets-drop-down-container",
	build_team_current_button = creative_mode_defines.name_prefix .. "build-team-current-button",
	build_team_targets_scroll_pane = creative_mode_defines.name_prefix .. "build-team-targets-scroll-pane",
	build_team_targets_container = creative_mode_defines.name_prefix .. "build-team-targets-container",
	build_team_targets_inner_container = creative_mode_defines.name_prefix .. "build-team-targets-inner-container",
	build_team_target_name_button_prefix = creative_mode_defines.name_prefix .. "build-team-target-name-button-",
	magic_wand_menus_container = creative_mode_defines.name_prefix .. "magic-wand-menus-container",
	magic_wand_frame = creative_mode_defines.name_prefix .. "magic-wand-frame",
	magic_wand_creator_menu_button = creative_mode_defines.name_prefix .. "magic-wand-creator-menu-button",
	magic_wand_healer_menu_button = creative_mode_defines.name_prefix .. "magic-wand-healer-menu-button",
	magic_wand_modifier_menu_button = creative_mode_defines.name_prefix .. "magic-wand-modifier-menu-button",
	magic_wand_creator_frame = creative_mode_defines.name_prefix .. "magic-wand-creator-frame",
	magic_wand_creator_frame_title_container = creative_mode_defines.name_prefix ..
		"magic-wand-creator-frame-title-container",
	magic_wand_creator_frame_title = creative_mode_defines.name_prefix .. "magic-wand-creator-frame-title",
	magic_wand_creator_get_item_button = creative_mode_defines.name_prefix .. "magic-wand-creator-get-item-button",
	magic_wand_creator_scroll_pane = creative_mode_defines.name_prefix .. "magic-wand-creator-scroll-pane",
	magic_wand_creator_container = creative_mode_defines.name_prefix .. "magic-wand-creator-container",
	magic_wand_creator_select_mode_container = creative_mode_defines.name_prefix ..
		"magic-wand-creator-select-mode-container",
	magic_wand_creator_select_mode_label = creative_mode_defines.name_prefix .. "magic-wand-creator-select-mode-label",
	magic_wand_creator_alt_select_mode_container = creative_mode_defines.name_prefix ..
		"magic-wand-creator-alt-select-mode-container",
	magic_wand_creator_alt_select_mode_label = creative_mode_defines.name_prefix ..
		"magic-wand-creator-alt-select-mode-label",
	magic_wand_creator_correct_tiles_checkbox = creative_mode_defines.name_prefix ..
		"magic-wand-creator-correct-tiles-checkbox",
	magic_wand_creator_dont_kill_by_tiles_checkbox = creative_mode_defines.name_prefix ..
		"magic-wand-creator-dont-kill-by-tiles-checkbox",
	magic_wand_creator_tiles_table = creative_mode_defines.name_prefix .. "magic-wand-creator-tiles-table",
	magic_wand_creator_tile_name_button_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-creator-tile-name-button-",
	magic_wand_creator_resources_table = creative_mode_defines.name_prefix .. "magic-wand-creator-resources-table",
	magic_wand_creator_resource_name_button_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-creator-resource-name-button-",
	magic_wand_creator_rsc_amt_slider_container = creative_mode_defines.name_prefix ..
		"magic-wand-creator-resource-amount-slider-container",
	magic_wand_creator_rsc_amt_slider_label = creative_mode_defines.name_prefix ..
		"magic-wand-creator-resource-amount-slider-label",
	magic_wand_creator_rsc_amt_slider_spacing_1 = creative_mode_defines.name_prefix ..
		"magic-wand-creator-resource-amount-slider-spacing-1",
	magic_wand_creator_rsc_amt_slider_button_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-creator-resource-amount-slider-button-",
	magic_wand_creator_rsc_amt_slider_spacing_2 = creative_mode_defines.name_prefix ..
		"magic-wand-creator-resource-amount-slider-spacing-2",
	magic_wand_creator_rsc_amt_slider_textfield = creative_mode_defines.name_prefix ..
		"magic-wand-creator-resource-amount-slider-textfield",
	magic_wand_creator_use_pattern_container = creative_mode_defines.name_prefix ..
		"magic-wand-creator-use-pattern-container",
	magic_wand_creator_use_pattern_label = creative_mode_defines.name_prefix .. "magic-wand-creator-use-pattern-label",
	magic_wand_creator_use_pattern_drop_down = creative_mode_defines.name_prefix ..
		"magic-wand-creator-use-pattern-drop-down",
	magic_wand_creator_tile_or_resource_2_container = creative_mode_defines.name_prefix ..
		"magic-wand-creator-tile-or-resource-2-container",
	magic_wand_creator_tiles_table_2 = creative_mode_defines.name_prefix .. "magic-wand-creator-tiles-table-2",
	magic_wand_creator_tile_name_button_2_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-creator-tile-name-button-2-",
	magic_wand_creator_resources_table_2 = creative_mode_defines.name_prefix .. "magic-wand-creator-resources-table-2",
	magic_wand_creator_resource_name_button_2_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-creator-resource-name-button-2-",
	magic_wand_creator_rsc_amt_slider_container_2 = creative_mode_defines.name_prefix ..
		"magic-wand-creator-resource-amount-slider-container-2",
	magic_wand_creator_rsc_amt_slider_label_2 = creative_mode_defines.name_prefix ..
		"magic-wand-creator-resource-amount-slider-label-2",
	magic_wand_creator_rsc_amt_slider_spacing_1_2 = creative_mode_defines.name_prefix ..
		"magic-wand-creator-resource-amount-slider-spacing-1-2",
	magic_wand_creator_rsc_amt_slider_button_2_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-creator-resource-amount-slider-button-2-",
	magic_wand_creator_rsc_amt_slider_spacing_2_2 = creative_mode_defines.name_prefix ..
		"magic-wand-creator-resource-amount-slider-spacing-2-2",
	magic_wand_creator_rsc_amt_slider_textfield_2 = creative_mode_defines.name_prefix ..
		"magic-wand-creator-resource-amount-slider-textfield-2",
	magic_wand_creator_also_remove_decoratives_checkbox = creative_mode_defines.name_prefix ..
		"magic-wand-creator-also-remove-decoratives-checkbox",
	magic_wand_creator_dont_remove_characters_checkbox = creative_mode_defines.name_prefix ..
		"magic-wand-creator-dont-remove-characters-checkbox",
	magic_wand_creator_dont_remove_tiles_with_entities_checkbox = creative_mode_defines.name_prefix ..
		"magic-wand-creator-dont-remove-tiles-with-entities-checkbox",
	magic_wand_creator_dont_kill_by_removing_tiles_checkbox = creative_mode_defines.name_prefix ..
		"magic-wand-creator-dont-kill-by-removing-tiles-checkbox",
	magic_wand_creator_alt_forces_label = creative_mode_defines.name_prefix .. "magic-wand-creator-alt-forces-label",
	magic_wand_creator_alt_forces_table = creative_mode_defines.name_prefix .. "magic-wand-creator-alt-forces-table",
	magic_wand_creator_alt_force_name_checkbox_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-creator-alt-force-name-checkbox-",
	magic_wand_creator_alt_forces_select_all_button = creative_mode_defines.name_prefix ..
		"magic-wand-creator-alt-forces-select-all-button",
	magic_wand_healer_frame = creative_mode_defines.name_prefix .. "magic-wand-healer-frame",
	magic_wand_healer_frame_title_container = creative_mode_defines.name_prefix ..
		"magic-wand-healer-frame-title-container",
	magic_wand_healer_frame_title = creative_mode_defines.name_prefix .. "magic-wand-healer-frame-title",
	magic_wand_healer_get_item_button = creative_mode_defines.name_prefix .. "magic-wand-healer-get-item-button",
	magic_wand_healer_scroll_pane = creative_mode_defines.name_prefix .. "magic-wand-healer-scroll-pane",
	magic_wand_healer_container = creative_mode_defines.name_prefix .. "magic-wand-healer-container",
	magic_wand_healer_select_mode_container = creative_mode_defines.name_prefix ..
		"magic-wand-healer-select-mode-container",
	magic_wand_healer_select_mode_label = creative_mode_defines.name_prefix .. "magic-wand-healer-select-mode-label",
	magic_wand_healer_alt_select_mode_container = creative_mode_defines.name_prefix ..
		"magic-wand-healer-alt-select-mode-container",
	magic_wand_healer_alt_select_mode_label = creative_mode_defines.name_prefix ..
		"magic-wand-healer-alt-select-mode-label",
	magic_wand_healer_revive_ghosts_checkbox = creative_mode_defines.name_prefix ..
		"magic-wand-healer-revive-ghosts-checkbox",
	magic_wand_healer_heal_forces_label = creative_mode_defines.name_prefix .. "magic-wand-healer-heal-forces-label",
	magic_wand_healer_heal_forces_table = creative_mode_defines.name_prefix .. "magic-wand-healer-heal-forces-table",
	magic_wand_healer_heal_force_name_checkbox_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-healer-heal-force-name-checkbox-",
	magic_wand_healer_heal_forces_select_all_button = creative_mode_defines.name_prefix ..
		"magic-wand-healer-heal-forces-select-all-button",
	magic_wand_healer_alt_actions_container = creative_mode_defines.name_prefix ..
		"magic-wand-healer-alt-actions-container",
	magic_wand_healer_alt_set_hp_radiobutton = creative_mode_defines.name_prefix ..
		"magic-wand-healer-alt-set-hp-radiobutton",
	magic_wand_healer_alt_kill_radiobutton = creative_mode_defines.name_prefix .. "magic-wand-healer-alt-kill-radiobutton",
	magic_wand_healer_alt_dont_affect_characters_checkbox = creative_mode_defines.name_prefix ..
		"magic-wand-healer-alt-dont-affect-characters-checkbox",
	magic_wand_healer_alt_dont_affect_indestructible_checkbox = creative_mode_defines.name_prefix ..
		"magic-wand-healer-alt-dont-affect-indestructible-checkbox",
	magic_wand_healer_alt_forces_label = creative_mode_defines.name_prefix .. "magic-wand-healer-alt-forces-label",
	magic_wand_healer_alt_forces_table = creative_mode_defines.name_prefix .. "magic-wand-healer-alt-forces-table",
	magic_wand_healer_alt_force_name_checkbox_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-healer-alt-force-name-checkbox-",
	magic_wand_healer_alt_forces_select_all_button = creative_mode_defines.name_prefix ..
		"magic-wand-healer-alt-forces-select-all-button",
	magic_wand_modifier_frame = creative_mode_defines.name_prefix .. "magic-wand-modifier-frame",
	magic_wand_modifier_frame_title_container = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-frame-title-container",
	magic_wand_modifier_frame_title = creative_mode_defines.name_prefix .. "magic-wand-modifier-frame-title",
	magic_wand_modifier_get_item_button = creative_mode_defines.name_prefix .. "magic-wand-modifier-get-item-button",
	magic_wand_modifier_scroll_pane = creative_mode_defines.name_prefix .. "magic-wand-modifier-scroll-pane",
	magic_wand_modifier_container = creative_mode_defines.name_prefix .. "magic-wand-modifier-container",
	magic_wand_modifier_select_mode_container = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-select-mode-container",
	magic_wand_modifier_select_mode_label = creative_mode_defines.name_prefix .. "magic-wand-modifier-select-mode-label",
	magic_wand_modifier_alt_select_mode_container = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-alt-select-mode-container",
	magic_wand_modifier_alt_select_mode_label = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-alt-select-mode-label",
	magic_wand_modifier_std_ignore_characters_checkbox = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-std-ignore-characters-checkbox",
	magic_wand_modifier_std_ignore_healthless_checkbox = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-std-ignore-healthless-checkbox",
	magic_wand_modifier_std_ignore_indestructible_checkbox = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-std-ignore-indestructible-checkbox",
	magic_wand_modifier_std_forces_label = creative_mode_defines.name_prefix .. "magic-wand-modifier-std-forces-label",
	magic_wand_modifier_std_forces_table = creative_mode_defines.name_prefix .. "magic-wand-modifier-std-forces-table",
	magic_wand_modifier_std_force_name_checkbox_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-std-force-name-checkbox-",
	magic_wand_modifier_std_forces_select_all_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-std-forces-select-all-button",
	magic_wand_modifier_alt_ignore_characters_checkbox = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-alt-ignore-characters-checkbox",
	magic_wand_modifier_alt_ignore_healthless_checkbox = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-alt-ignore-healthless-checkbox",
	magic_wand_modifier_alt_ignore_indestructible_checkbox = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-alt-ignore-indestructible-checkbox",
	magic_wand_modifier_alt_forces_label = creative_mode_defines.name_prefix .. "magic-wand-modifier-alt-forces-label",
	magic_wand_modifier_alt_forces_table = creative_mode_defines.name_prefix .. "magic-wand-modifier-alt-forces-table",
	magic_wand_modifier_alt_force_name_checkbox_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-alt-force-name-checkbox-",
	magic_wand_modifier_alt_forces_select_all_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-alt-forces-select-all-button",
	magic_wand_modifier_quick_actions_label = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-quick-actions-label",
	magic_wand_modifier_quick_actions_container = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-quick-actions-container",
	magic_wand_modifier_quick_action_container_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-quick-action-container-",
	magic_wand_modifier_quick_action_remove_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-quick-action-remove-button",
	magic_wand_modifier_quick_action_separator = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-quick-action-separator",
	magic_wand_modifier_quick_action_name_label = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-quick-action-name-label",
	magic_wand_modifier_quick_action_colon_label = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-quick-action-colon-label",
	magic_wand_modifier_quick_action_value_label = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-quick-action-value-label",
	magic_wand_modifier_remove_all_quick_actions_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-remove-all-quick-actions-button",
	magic_wand_modifier_popup_container = creative_mode_defines.name_prefix .. "magic-wand-modifier-popup-container",
	magic_wand_modifier_popup_entities_frame = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-entities-frame",
	magic_wand_modifier_popup_entities_frame_title_container = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-entities-frame-title-container",
	magic_wand_modifier_popup_entities_frame_title_label = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-entities-frame-title-label",
	magic_wand_modifier_popup_entities_frame_refresh_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-entities-frame-refresh-button",
	magic_wand_modifier_popup_entities_sroll_pane = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-entities-scroll-pane",
	magic_wand_modifier_popup_entities_table = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-entities-table",
	magic_wand_modifier_popup_entity_name_slot_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-entity-slot-",
	magic_wand_modifier_popup_item_on_ground_name_slot_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-item-on-ground-slot-",
	magic_wand_modifier_popup_ghost_entity_name_slot_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-ghost-entity-slot-",
	magic_wand_modifier_popup_ghost_tile_name_slot_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-ghost-tile-slot-",
	magic_wand_modifier_popup_entity_count_label_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-entity-count-label-",
	magic_wand_modifier_popup_item_on_ground_count_label_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-item-on-ground-count-label-",
	magic_wand_modifier_popup_ghost_entity_count_label_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-ghost-entity-count-label-",
	magic_wand_modifier_popup_ghost_tile_count_label_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-ghost-tile-count-label-",
	magic_wand_modifier_popup_actions_frame = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-actions-frame",
	magic_wand_modifier_popup_actions_frame_title_container = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-actions-frame-title-container",
	magic_wand_modifier_popup_actions_frame_title_label = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-actions-frame-title-label",
	magic_wand_modifier_popup_actions_frame_close_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-popup-actions-frame-close-button",
	magic_wand_modifier_active_container = creative_mode_defines.name_prefix .. "magic-wand-modifier-active-container",
	magic_wand_modifier_active_label = creative_mode_defines.name_prefix .. "magic-wand-modifier-active-label",
	magic_wand_modifier_active_on_button = creative_mode_defines.name_prefix .. "magic-wand-modifier-active-on-button",
	magic_wand_modifier_active_off_button = creative_mode_defines.name_prefix .. "magic-wand-modifier-active-off-button",
	magic_wand_modifier_destructible_container = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-destructible-container",
	magic_wand_modifier_destructible_label = creative_mode_defines.name_prefix .. "magic-wand-modifier-destructible-label",
	magic_wand_modifier_destructible_on_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-destructible-on-button",
	magic_wand_modifier_destructible_off_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-destructible-off-button",
	magic_wand_modifier_minable_container = creative_mode_defines.name_prefix .. "magic-wand-modifier-minable-container",
	magic_wand_modifier_minable_label = creative_mode_defines.name_prefix .. "magic-wand-modifier-minable-label",
	magic_wand_modifier_minable_on_button = creative_mode_defines.name_prefix .. "magic-wand-modifier-minable-on-button",
	magic_wand_modifier_minable_off_button = creative_mode_defines.name_prefix .. "magic-wand-modifier-minable-off-button",
	magic_wand_modifier_rotatable_container = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-rotatable-container",
	magic_wand_modifier_rotatable_label = creative_mode_defines.name_prefix .. "magic-wand-modifier-rotatable-label",
	magic_wand_modifier_rotatable_on_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-rotatable-on-button",
	magic_wand_modifier_rotatable_off_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-rotatable-off-button",
	magic_wand_modifier_operable_container = creative_mode_defines.name_prefix .. "magic-wand-modifier-operable-container",
	magic_wand_modifier_operable_label = creative_mode_defines.name_prefix .. "magic-wand-modifier-operable-label",
	magic_wand_modifier_operable_on_button = creative_mode_defines.name_prefix .. "magic-wand-modifier-operable-on-button",
	magic_wand_modifier_operable_off_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-operable-off-button",
	magic_wand_modifier_full_health_container = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-full-health-container",
	magic_wand_modifier_full_health_label = creative_mode_defines.name_prefix .. "magic-wand-modifier-full-health-label",
	magic_wand_modifier_full_health_on_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-full-health-on-button",
	magic_wand_modifier_full_health_off_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-full-health-off-button",
	magic_wand_modifier_backer_name_container = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-backer-name-container",
	magic_wand_modifier_backer_name_label = creative_mode_defines.name_prefix .. "magic-wand-modifier-backer-name-label",
	magic_wand_modifier_backer_name_textfield = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-backer-name-textfield",
	magic_wand_modifier_backer_name_separator = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-backer-name-separator",
	magic_wand_modifier_backer_name_apply_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-backer-name-apply-button",
	magic_wand_modifier_to_be_looted_container = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-to-be-looted-container",
	magic_wand_modifier_to_be_looted_label = creative_mode_defines.name_prefix .. "magic-wand-modifier-to-be-looted-label",
	magic_wand_modifier_to_be_looted_on_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-to-be-looted-on-button",
	magic_wand_modifier_to_be_looted_off_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-to-be-looted-off-button",
	magic_wand_modifier_revive_container = creative_mode_defines.name_prefix .. "magic-wand-modifier-revive-container",
	magic_wand_modifier_revive_label = creative_mode_defines.name_prefix .. "magic-wand-modifier-revive-label",
	magic_wand_modifier_revive_apply_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-revive-apply-button",
	magic_wand_modifier_kill_container = creative_mode_defines.name_prefix .. "magic-wand-modifier-kill-container",
	magic_wand_modifier_kill_label = creative_mode_defines.name_prefix .. "magic-wand-modifier-kill-label",
	magic_wand_modifier_kill_apply_button = creative_mode_defines.name_prefix .. "magic-wand-modifier-kill-apply-button",
	magic_wand_modifier_destroy_container = creative_mode_defines.name_prefix .. "magic-wand-modifier-destroy-container",
	magic_wand_modifier_destroy_label = creative_mode_defines.name_prefix .. "magic-wand-modifier-destroy-label",
	magic_wand_modifier_destroy_apply_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-destroy-apply-button",
	magic_wand_modifier_team_container = creative_mode_defines.name_prefix .. "magic-wand-modifier-team-container",
	magic_wand_modifier_team_label = creative_mode_defines.name_prefix .. "magic-wand-modifier-team-label",
	magic_wand_modifier_team_targets_drop_down_container = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-team-targets-drop-down-container",
	magic_wand_modifier_team_current_button = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-team-current-button",
	magic_wand_modifier_team_targets_scroll_pane = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-team-targets-scroll-pane",
	magic_wand_modifier_team_targets_container = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-team-targets-container",
	magic_wand_modifier_team_targets_inner_container = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-team-targets-inner-container",
	magic_wand_modifier_team_target_name_button_prefix = creative_mode_defines.name_prefix ..
		"magic-wand-modifier-team-target-name-button-",
	modding_menus_container = creative_mode_defines.name_prefix .. "modding-menu-container",
	modding_menus_frame = creative_mode_defines.name_prefix .. "modding-menu-frame",
	events_menu_button = creative_mode_defines.name_prefix .. "events-menu-button",
	interfaces_menu_button = creative_mode_defines.name_prefix .. "interfaces-menu-button",
	events_menu_frame = creative_mode_defines.name_prefix .. "events-menu-frame",
	events_menu_title_container = creative_mode_defines.name_prefix .. "events-menu-title-container",
	events_menu_title_label = creative_mode_defines.name_prefix .. "events-menu-title-label",
	events_menu_title_separator_1 = creative_mode_defines.name_prefix .. "events-menu-title-separator_1",
	events_menu_search_textfield = creative_mode_defines.name_prefix .. "events-menu-search-textfield",
	events_menu_search_textfield_placeholder_flow = creative_mode_defines.name_prefix ..
		"events-menu-search-textfield-placeholder-flow",
	events_menu_title_separator_2 = creative_mode_defines.name_prefix .. "events-menu-title-separator_2",
	events_menu_search_button = creative_mode_defines.name_prefix .. "events-menu-search-button",
	events_menu_label = creative_mode_defines.name_prefix .. "events-menu-label",
	events_scroll_pane = creative_mode_defines.name_prefix .. "events-scroll-pane",
	events_inner_container = creative_mode_defines.name_prefix .. "events-inner-container",
	event_container_prefix = creative_mode_defines.name_prefix .. "event-container-",
	event_toggle_checkbox_prefix = creative_mode_defines.name_prefix .. "event-toggle-checkbox-",
	events_all_button_container = creative_mode_defines.name_prefix .. "eventa-all-button-container",
	events_enable_all_button = creative_mode_defines.name_prefix .. "events-enable-all-button",
	events_disable_all_button = creative_mode_defines.name_prefix .. "events-disable-all-button",
	event_categories_and_options_container = creative_mode_defines.name_prefix .. "event-categories-and-options-container",
	event_categories_frame = creative_mode_defines.name_prefix .. "event-categories-frame",
	event_category_item_container = creative_mode_defines.name_prefix .. "event-category-item-container",
	event_category_item_label = creative_mode_defines.name_prefix .. "event-category-item-label",
	event_category_item_show_button = creative_mode_defines.name_prefix .. "event-category-item-show-button",
	event_category_item_hide_button = creative_mode_defines.name_prefix .. "event-category-item-hide-button",
	event_category_entity_container = creative_mode_defines.name_prefix .. "event-category-entity-container",
	event_category_entity_label = creative_mode_defines.name_prefix .. "event-category-entity-label",
	event_category_entity_show_button = creative_mode_defines.name_prefix .. "event-category-entity-show-button",
	event_category_entity_hide_button = creative_mode_defines.name_prefix .. "event-category-entity-hide-button",
	event_category_tile_container = creative_mode_defines.name_prefix .. "event-category-tile-container",
	event_category_tile_label = creative_mode_defines.name_prefix .. "event-category-tile-label",
	event_category_tile_show_button = creative_mode_defines.name_prefix .. "event-category-tile-show-button",
	event_category_tile_hide_button = creative_mode_defines.name_prefix .. "event-category-tile-hide-button",
	event_category_technology_container = creative_mode_defines.name_prefix .. "event-category-technology-container",
	event_category_technology_label = creative_mode_defines.name_prefix .. "event-category-technology-label",
	event_category_technology_show_button = creative_mode_defines.name_prefix .. "event-category-technology-show-button",
	event_category_technology_hide_button = creative_mode_defines.name_prefix .. "event-category-technology-hide-button",
	event_category_player_container = creative_mode_defines.name_prefix .. "event-category-player-container",
	event_category_player_label = creative_mode_defines.name_prefix .. "event-category-player-label",
	event_category_player_show_button = creative_mode_defines.name_prefix .. "event-category-player-show-button",
	event_category_player_hide_button = creative_mode_defines.name_prefix .. "event-category-player-hide-button",
	event_category_force_container = creative_mode_defines.name_prefix .. "event-category-force-container",
	event_category_force_label = creative_mode_defines.name_prefix .. "event-category-force-label",
	event_category_force_show_button = creative_mode_defines.name_prefix .. "event-category-force-show-button",
	event_category_force_hide_button = creative_mode_defines.name_prefix .. "event-category-force-hide-button",
	event_category_surface_container = creative_mode_defines.name_prefix .. "event-category-surface-container",
	event_category_surface_label = creative_mode_defines.name_prefix .. "event-category-surface-label",
	event_category_surface_show_button = creative_mode_defines.name_prefix .. "event-category-surface-show-button",
	event_category_surface_hide_button = creative_mode_defines.name_prefix .. "event-category-surface-hide-button",
	event_category_position_container = creative_mode_defines.name_prefix .. "event-category-position-container",
	event_category_position_label = creative_mode_defines.name_prefix .. "event-category-position-label",
	event_category_position_show_button = creative_mode_defines.name_prefix .. "event-category-position-show-button",
	event_category_position_hide_button = creative_mode_defines.name_prefix .. "event-category-position-hide-button",
	event_category_gui_container = creative_mode_defines.name_prefix .. "event-category-gui-container",
	event_category_gui_label = creative_mode_defines.name_prefix .. "event-category-gui-label",
	event_category_gui_show_button = creative_mode_defines.name_prefix .. "event-category-gui-show-button",
	event_category_gui_hide_button = creative_mode_defines.name_prefix .. "event-category-gui-hide-button",
	event_category_settings_container = creative_mode_defines.name_prefix .. "event-category-settings-container",
	event_category_settings_label = creative_mode_defines.name_prefix .. "event-category-settings-label",
	event_category_settings_show_button = creative_mode_defines.name_prefix .. "event-category-settings-show-button",
	event_category_settings_hide_button = creative_mode_defines.name_prefix .. "event-category-settings-hide-button",
	event_category_all_container = creative_mode_defines.name_prefix .. "event-category-all-container",
	event_category_all_label = creative_mode_defines.name_prefix .. "event-category-all-label",
	event_category_all_show_button = creative_mode_defines.name_prefix .. "event-category-all-show-button",
	event_category_all_hide_button = creative_mode_defines.name_prefix .. "event-category-all-hide-button",
	event_options_frame = creative_mode_defines.name_prefix .. "event-options-frame",
	event_options_container = creative_mode_defines.name_prefix .. "event-options-container",
	event_option_print_events_checkbox = creative_mode_defines.name_prefix .. "event-option-print-events-checkbox",
	event_option_print_parameters_checkbox = creative_mode_defines.name_prefix .. "event-option-print-parameters-checkbox",
	event_option_write_events_checkbox = creative_mode_defines.name_prefix .. "event-option-write-events-checkbox",
	event_option_write_parameters_checkbox = creative_mode_defines.name_prefix .. "event-option-write-parameters-checkbox",
	event_option_log_events_checkbox = creative_mode_defines.name_prefix .. "event-option-log-events-checkbox",
	event_option_log_parameters_checkbox = creative_mode_defines.name_prefix .. "event-option-log-parameters-checkbox",
	interfaces_menu_frame = creative_mode_defines.name_prefix .. "interfaces-menu-frame",
	interfaces_menu_label = creative_mode_defines.name_prefix .. "interfaces-menu-label",
	interfaces_scroll_pane = creative_mode_defines.name_prefix .. "interfaces-scroll-pane",
	interfaces_inner_container = creative_mode_defines.name_prefix .. "interfaces-inner-container",
	interface_button_prefix = creative_mode_defines.name_prefix .. "interface-button-",
	interface_contents_and_hints_container = creative_mode_defines.name_prefix .. "interface-contents-and-hints-container",
	interface_contents_frame = creative_mode_defines.name_prefix .. "interface-contents-frame",
	interface_contents_scroll_pane = creative_mode_defines.name_prefix .. "interface-contents-scroll-pane",
	interface_contents_container = creative_mode_defines.name_prefix .. "interface-contents-container",
	interface_contents_label_prefix = creative_mode_defines.name_prefix .. "interface-contents-label-",
	interface_contents_button_prefix = creative_mode_defines.name_prefix .. "interface-contents-button-",
	interface_hints_frame = creative_mode_defines.name_prefix .. "interface-hints-frame",
	interface_can_register_remote_function_label = creative_mode_defines.name_prefix ..
		"interface-can-register-remote-function-label",
	admin_menus_container = creative_mode_defines.name_prefix .. "admin-menus-container",
	access_right_frame = creative_mode_defines.name_prefix .. "access-right-frame",
	access_right_label = creative_mode_defines.name_prefix .. "access-right-label",
	access_rights_scroll_pane = creative_mode_defines.name_prefix .. "access-rights-scroll-pane",
	access_rights_container = creative_mode_defines.name_prefix .. "access-rights-container",
	disable_mode_frame = creative_mode_defines.name_prefix .. "disable-mode-frame",
	access_personal_cheat_container = creative_mode_defines.name_prefix .. "access-personal-cheat-container",
	access_personal_cheat_label = creative_mode_defines.name_prefix .. "access-personal-cheat-label",
	access_personal_cheat_inner_container = creative_mode_defines.name_prefix .. "access-personal-cheat-inner-container",
	access_personal_cheat_admin_only_button = creative_mode_defines.name_prefix ..
		"access-personal-cheat-admin-only-button",
	access_personal_cheat_free_button = creative_mode_defines.name_prefix .. "access-personal-cheat-free-button",
	access_team_cheat_container = creative_mode_defines.name_prefix .. "access-team-cheat-container",
	access_team_cheat_label = creative_mode_defines.name_prefix .. "access-team-cheat-label",
	access_team_cheat_inner_container = creative_mode_defines.name_prefix .. "access-team-cheat-inner-container",
	access_team_cheat_admin_only_button = creative_mode_defines.name_prefix .. "access-team-cheat-admin-only-button",
	access_team_cheat_own_team_button = creative_mode_defines.name_prefix .. "access-team-cheat-own-team-button",
	access_team_cheat_free_button = creative_mode_defines.name_prefix .. "access-team-cheat-free-button",
	access_surface_cheat_container = creative_mode_defines.name_prefix .. "access-surface-cheat-container",
	access_surface_cheat_label = creative_mode_defines.name_prefix .. "access-surface-cheat-label",
	access_surface_cheat_inner_container = creative_mode_defines.name_prefix .. "access-surface-cheat-inner-container",
	access_surface_cheat_admin_only_button = creative_mode_defines.name_prefix .. "access-surface-cheat-admin-only-button",
	access_surface_cheat_current_surface_button = creative_mode_defines.name_prefix ..
		"access-surface-cheat-current-surface-button",
	access_surface_cheat_free_button = creative_mode_defines.name_prefix .. "access-surface-cheat-free-button",
	access_global_cheat_container = creative_mode_defines.name_prefix .. "access-global-cheat-container",
	access_global_cheat_label = creative_mode_defines.name_prefix .. "access-global-cheat-label",
	access_global_cheat_inner_container = creative_mode_defines.name_prefix .. "access-global-cheat-inner-container",
	access_global_cheat_admin_only_button = creative_mode_defines.name_prefix .. "access-global-cheat-admin-only-button",
	access_global_cheat_free_button = creative_mode_defines.name_prefix .. "access-global-cheat-free-button",
	access_build_options_container = creative_mode_defines.name_prefix .. "access-build-options-container",
	access_build_options_label = creative_mode_defines.name_prefix .. "access-build-options-label",
	access_build_options_inner_container = creative_mode_defines.name_prefix .. "access-build-options-inner-container",
	access_build_options_admin_only_button = creative_mode_defines.name_prefix .. "access-build-options-admin-only-button",
	access_build_options_no_team_button = creative_mode_defines.name_prefix .. "access-build-options-no-team-button",
	access_build_options_free_button = creative_mode_defines.name_prefix .. "access-build-options-free-button",
	access_creator_magic_wand_container = creative_mode_defines.name_prefix .. "access-creator-magic-wand-container",
	access_creator_magic_wand_label = creative_mode_defines.name_prefix .. "access-creator-magic-wand-label",
	access_creator_magic_wand_inner_container = creative_mode_defines.name_prefix ..
		"access-creator-magic-wand-inner-container",
	access_creator_magic_wand_admin_only_button = creative_mode_defines.name_prefix ..
		"access-creator-magic-wand-admin-only-button",
	access_creator_magic_wand_free_button = creative_mode_defines.name_prefix .. "access-creator-magic-wand-free-button",
	access_healer_magic_wand_container = creative_mode_defines.name_prefix .. "access-healer-magic-wand-container",
	access_healer_magic_wand_label = creative_mode_defines.name_prefix .. "access-healer_magic_wand-label",
	access_healer_magic_wand_inner_container = creative_mode_defines.name_prefix ..
		"access-healer-magic-wand-inner-container",
	access_healer_magic_wand_admin_only_button = creative_mode_defines.name_prefix ..
		"access-healer-magic-wand-admin-only-button",
	access_healer_magic_wand_free_button = creative_mode_defines.name_prefix .. "access-healer-magic-wand-free-button",
	access_modifier_magic_wand_container = creative_mode_defines.name_prefix .. "access-modifier-magic-wand-container",
	access_modifier_magic_wand_label = creative_mode_defines.name_prefix .. "access-modifier-magic-wand-label",
	access_modifier_magic_wand_inner_container = creative_mode_defines.name_prefix ..
		"access-modifier-magic-wand-inner-container",
	access_modifier_magic_wand_admin_only_button = creative_mode_defines.name_prefix ..
		"access-modifier-magic-wand-admin-only-button",
	access_modifier_magic_wand_free_button = creative_mode_defines.name_prefix .. "access-modifier-magic-wand-free-button",
	access_modding_menu_container = creative_mode_defines.name_prefix .. "access-modding-menu-container",
	access_modding_menu_label = creative_mode_defines.name_prefix .. "access-modding-menu-label",
	access_modding_menu_inner_container = creative_mode_defines.name_prefix .. "access-modding-menu-inner-container",
	access_modding_menu_admin_only_button = creative_mode_defines.name_prefix .. "access-modding-menu-admin-only-button",
	access_modding_menu_free_button = creative_mode_defines.name_prefix .. "access-modding-menu-free-button",
	overall_access_rights_container = creative_mode_defines.name_prefix .. "overall-access-rights-container",
	overall_access_rights_label = creative_mode_defines.name_prefix .. "overall-access-rights-label",
	overall_access_rights_inner_container = creative_mode_defines.name_prefix .. "overall-access-rights-inner-container",
	overall_access_rights_admin_only_button = creative_mode_defines.name_prefix ..
		"overall-access-rights-admin-only-button",
	overall_access_rights_default_button = creative_mode_defines.name_prefix .. "overall-access-rights-default-button",
	disable_creative_mode_frame = creative_mode_defines.name_prefix .. "disable-creative-mode-frame",
	disable_creative_mode_button = creative_mode_defines.name_prefix .. "disable-creative-mode-button",
	disable_creative_mode_permanently_button = creative_mode_defines.name_prefix ..
		"disable-creative-mode-permanently-button",
	entity_gui_container = creative_mode_defines.name_prefix .. "entity-gui-container",
	entity_gui_button_container = creative_mode_defines.name_prefix .. "entity-gui-button-container",
	entity_gui_frame_container = creative_mode_defines.name_prefix .. "entity-gui-frame-container",
	entity_gui_frame = creative_mode_defines.name_prefix .. "entity-gui-frame",
	creative_chest_open_button = creative_mode_defines.name_prefix .. "creative-chest-open-button",
	creative_chest_item_group_container = creative_mode_defines.name_prefix .. "creative-chest-item-group-container",
	creative_chest_item_group_label = creative_mode_defines.name_prefix .. "creative-chest-item-group-label",
	creative_chest_item_group_number_label = creative_mode_defines.name_prefix .. "creative-chest-item-group-number-label",
	creative_chest_item_group_left_button = creative_mode_defines.name_prefix .. "creative-chest-item-group-left-button",
	creative_chest_item_group_right_button = creative_mode_defines.name_prefix .. "creative-chest-item-group-right-button",
	creative_chest_filter_container = creative_mode_defines.name_prefix .. "creative-chest-filter-container",
	creative_chest_filter_label = creative_mode_defines.name_prefix .. "creative-chest-filter-label",
	creative_chest_display_mode_button = creative_mode_defines.name_prefix .. "creative-chest-display-mode-button",
	creative_chest_toggle_all_button = creative_mode_defines.name_prefix .. "creative-chest-toggle-all-button",
	creative_chest_filter_scroll_pane = creative_mode_defines.name_prefix .. "creative-chest-filter-scroll-pane",
	creative_chest_filter_table = creative_mode_defines.name_prefix .. "creative-chest-filter-table",
	creative_chest_filter_slot_prefix = creative_mode_defines.name_prefix .. "creative-chest-filter-slot-",
	duplicating_chest_open_button = creative_mode_defines.name_prefix .. "duplicating-chest-open-button",
	duplicating_chest_lock_item_checkbox = creative_mode_defines.name_prefix .. "duplicating-chest-lock-item-checkbox",
	configurable_super_boiler_open_button = creative_mode_defines.name_prefix .. "configurable-super-boiler-open-button",
	configurable_super_boiler_set_temp_container = creative_mode_defines.name_prefix ..
		"configurable-super-boiler-set-temp-container",
	configurable_super_boiler_set_temp_label = creative_mode_defines.name_prefix ..
		"configurable-super-boiler-set-temp-label",
	configurable_super_boiler_set_temp_textfield = creative_mode_defines.name_prefix ..
		"configurable-super-boiler-set-temp-textfield",
	configurable_super_boiler_set_temp_button = creative_mode_defines.name_prefix ..
		"configurable-super-boiler-set-temp-button",
	item_source_open_button = creative_mode_defines.name_prefix .. "item-source-open-button",
	item_source_options_container = creative_mode_defines.name_prefix .. "item-source-options-container",
	item_source_can_insert_to_vehicle_checkbox = creative_mode_defines.name_prefix ..
		"item-source-can-insert-to-vehicle-checkbox",
	item_source_can_insert_to_player_checkbox = creative_mode_defines.name_prefix ..
		"item-source-can-insert-to-player-checkbox",
	item_source_can_drop_on_ground_checkbox = creative_mode_defines.name_prefix ..
		"item-source-can-drop-on-ground-checkbox",
	item_source_insert_to_player_frame = creative_mode_defines.name_prefix .. "item-source-insert-to-player-frame",
	item_source_insert_only_once_to_player_checkbox = creative_mode_defines.name_prefix ..
		"item-source-insert-only-once-to-player-checkbox",
	item_source_insert_once_to_player_frame = creative_mode_defines.name_prefix ..
		"item-source-insert-once-to-player-frame",
	item_source_insert_once_to_player_container = creative_mode_defines.name_prefix ..
		"item-source-insert-once-to-player-container",
	item_source_insert_once_to_player_amount_container = creative_mode_defines.name_prefix ..
		"item-source-insert-once-to-player-amount-container",
	item_source_insert_once_to_player_amount_label = creative_mode_defines.name_prefix ..
		"item-source-insert-once-to-player-amount-label",
	item_source_insert_once_to_player_amount_field = creative_mode_defines.name_prefix ..
		"item-source-insert-once-to-player-amount-field",
	item_source_insert_once_to_player_by_stack_checkbox = creative_mode_defines.name_prefix ..
		"item-source-insert-once-to-player-by-stack-checkbox",
	duplicator_open_button = creative_mode_defines.name_prefix .. "duplicator-open-button",
	duplicator_options_container = creative_mode_defines.name_prefix .. "duplicator-options_container",
	duplicator_can_duplicate_in_vehicle_checkbox = creative_mode_defines.name_prefix ..
		"duplicator-can-duplicate-in-vehicle-checkbox",
	duplicator_can_duplicate_in_player_checkbox = creative_mode_defines.name_prefix ..
		"duplicator-can-duplicate-in-player-checkbox",
	item_void_open_button = creative_mode_defines.name_prefix .. "item-void-open-button",
	item_void_options_container = creative_mode_defines.name_prefix .. "item-void-options-container",
	item_void_can_remove_from_vehicle_checkbox = creative_mode_defines.name_prefix ..
		"item-void-can-remove-from-vehicle-checkbox",
	item_void_can_remove_from_player_checkbox = creative_mode_defines.name_prefix ..
		"item-void-can-remove-from-player-checkbox",
	item_void_can_remove_from_ground_checkbox = creative_mode_defines.name_prefix ..
		"item-void-can-remove-from-ground-checkbox",
	-- Legacy GUI. Used for finding and destroying the legacy "more cheats" popup.
	cheats_table = creative_mode_defines.name_prefix .. "cheats-table"
}
-- GUI element captions.
creative_mode_defines.names.gui_captions = {
	yes = {"gui.creative-mode_yes"},
	no = {"gui.creative-mode_no"},
	on = {"gui.creative-mode_on"},
	off = {"gui.creative-mode_off"},
	ok = {"gui.creative-mode_ok"},
	unlock = {"gui.creative-mode_unlock"},
	reset = {"gui.reset"},
	show = {"gui.creative-mode_show"},
	hide = {"gui.creative-mode_hide"},
	enable_all = {"gui.creative-mode_enable-all"},
	disable_all = {"gui.creative-mode_disable-all"},
	select_all = {"gui.creative-mode_select-all"},
	remove_all = {"gui.creative-mode_remove-all"},
	creative_chest_display_mode_original = {
		"gui.creative-mode_switch-inventory-display-mode",
		{"gui.creative-mode_inventory-display-mode-original"}
	},
	creative_chest_display_mode_compact = {
		"gui.creative-mode_switch-inventory-display-mode",
		{"gui.creative-mode_inventory-display-mode-compact"}
	}
}
-- GUI element styles.
creative_mode_defines.names.gui_styles = {
	resize_col_flow = "creative_mode_resize_col_flow_style",
	no_horizontal_spacing_flow = "creative_mode_no_horizontal_spacing_flow_style",
	no_horizontal_spacing_resize_col_flow = "creative_mode_no_horizontal_spacing_resize_col_flow_style",
	no_vertical_spacing_resize_row_flow = "creative_mode_no_vertical_spacing_resize_row_flow_style",
	frame_caption_label = "frame_caption_label",
	long_dialog_button = "creative_mode_long_dialog_button_style",
	small_default_bold_button = "creative_mode_small_default_bold_button_style",
	frame_caption_button = "frame_action_button",
	frame_search_textfield = "creative_mode_frame_search_textfield_style",
	frame_search_textfield_placeholder_flow = "creative_mode_frame_search_textfield_placeholder_flow_style",
	main_menu_open_button = "creative_mode_main_menu_open_button_style",
	main_menu_button = "creative_mode_main_menu_button_style",
	naked_small_orange_title_frame = "creative_mode_naked_small_orange_title_frame_style",
	small_orange_title_with_right_border_frame = "creative_mode_small_orange_title_with_right_border_frame_style",
	unscalable_no_spacing_table = "creative_mode_unscalable_no_spacing_table_style",
	slot_table = "slot_table",
	slot_button_label = "creative_mode_slot_button_label_style",
	slider_button_on = "creative_mode_slider_button_on_style",
	slider_button_off = "creative_mode_slider_button_off_style",
	slider_textfield = "creative_mode_slider_textfield_style",
	cheat_scroll_pane = "creative_mode_cheat_scroll_pane_style",
	cheat_target_selection_container_frame = "creative_mode_cheat_target_selection_container_frame_style",
	cheat_target_selected_button = "creative_mode_cheat_target_selected_button_style",
	cheat_target_unselected_button = "creative_mode_cheat_target_unselected_button_style",
	cheat_target_self_selected_button = "creative_mode_cheat_target_selected_self_button_style",
	cheat_target_self_unselected_button = "creative_mode_cheat_target_unselected_self_button_style",
	cheat_select_all_targets_button = "creative_mode_cheat_select_all_targets_button_style",
	cheat_table = "creative_mode_cheat_table_style",
	cheat_flow = "creative_mode_cheat_flow_style",
	cheat_name_label = "creative_mode_cheat_name_label_style",
	cheat_on_off_button_on = "creative_mode_cheat_on_off_button_on_style",
	cheat_on_off_button_off = "creative_mode_cheat_on_off_button_off_style",
	cheat_numeric_textfield = "creative_mode_cheat_numeric_textfield_style",
	cheat_textfield_and_button_separate_flow = "creative_mode_cheat_textfield_and_button_separate_flow_style",
	cheat_apply_button = "creative_mode_cheat_apply_button_style",
	cheat_with_one_button_name_label = "creative_mode_cheat_one_button_name_label_style",
	cheat_enable_disable_all_table = "creative_mode_cheat_enable_disable_all_table_style",
	cheat_enable_disable_all_button = "creative_mode_cheat_enable_disable_all_button_style",
	cheat_note_label = "creative_mode_cheat_note_label_style",
	cheat_value_drop_down_current_target_button = "creative_mode_cheat_value_drop_down_current_target_button_style",
	cheat_value_drop_down_scroll_pane = "creative_mode_cheat_value_drop_down_scroll_pane_style",
	cheat_value_drop_down_container_frame = "creative_mode_cheat_value_drop_down_container_frame_style",
	cheat_value_drop_down_selection_button = "creative_mode_cheat_value_drop_down_selection_button_style",
	magic_wand_frame_caption_label = "creative_mode_magic_wand_frame_caption_label_style",
	magic_wand_scroll_pane = "creative_mode_magic_wand_scroll_pane_style",
	magic_wand_select_mode_frame = "creative_mode_magic_wand_select_mode_frame_style",
	magic_wand_alt_select_mode_frame = "creative_mode_magic_wand_alt_select_mode_frame_style",
	magic_wand_label = "creative_mode_magic_wand_label_style",
	magic_wand_checkbox = "creative_mode_magic_wand_checkbox_style",
	magic_wand_radiobutton = "creative_mode_magic_wand_radiobutton_style",
	tile_slot_selected = "creative_mode_tile_slot_selected_style",
	tile_slot_deselected = "creative_mode_tile_slot_deselected_style",
	magic_wand_slider_label = "creative_mode_magic_wand_slider_label_style",
	magic_wand_drop_down_label = "creative_mode_magic_wand_drop_down_label",
	magic_wand_drop_down = "creative_mode_magic_wand_drop_down",
	magic_wand_select_all_button = "creative_mode_magic_wand_select_all_button_style",
	magic_wand_quick_action_remove_button = "creative_mode_magic_wand_quick_action_remove_button_style",
	magic_wand_popup_left_frame_caption_label = "creative_mode_magic_wand_popup_left_frame_caption_label_style",
	magic_wand_popup_right_frame_caption_label = "creative_mode_magic_wand_popup_right_frame_caption_label_style",
	magic_wand_popup_slot_scroll_pane = "creative_mode_magic_wand_popup_slot_scroll_pane_style",
	magic_wand_popup_slot_table = "creative_mode_magic_wand_popup_slot_table_style",
	magic_wand_popup_item_on_ground_slot_button = "creative_mode_magic_wand_popup_item_on_ground_slot_button_style",
	magic_wand_popup_ghost_slot_button = "creative_mode_magic_wand_popup_ghost_slot_button_style",
	events_menu_frame_caption_label = "creative_mode_events_menu_frame_caption_label_style",
	interfaces_scroll_pane = "creative_mode_interfaces_scroll_pane_style",
	interface_button = "creative_mode_interface_button_style",
	interface_contents_scroll_pane = "creative_mode_interface_scroll_pane_style",
	interface_content_button = "creative_mode_interface_content_button_style",
	access_right_on_off_button_on = "creative_mode_access_right_on_off_button_on_style",
	access_right_on_off_button_off = "creative_mode_access_right_on_off_button_off_style",
	disable_creative_mode_button = "creative_mode_disable_creative_mode_button_style",
	entity_open_button = "creative_mode_entity_open_button_style",
	creative_chest_item_group_label = "creative_mode_creative_chest_item_group_label_style",
	creative_chest_item_group_number_label = "creative_mode_creative_chest_item_group_number_label_style",
	creative_chest_item_group_left_right_button = "creative_mode_creative_chest_item_group_left_right_button_style",
	creative_chest_select_slot_label = "creative_mode_creative_chest_select_slot_label_style",
	creative_chest_display_mode_button_original = "creative_mode_creative_chest_original_display_mode_button_style",
	creative_chest_display_mode_button_compact = "creative_mode_creative_chest_compact_display_mode_button_style",
	inventory_toggle_all_button = "creative_mode_inventory_toggle_all_button_style",
	creative_chest_filter_slot_on = "creative_mode_filter_slot_on_style",
	creative_chest_filter_slot_off = "creative_mode_filter_slot_off_style",
	item_count_textfield = "creative_mode_item_count_textfield_style"
}
-- Sprites.
creative_mode_defines.names.sprites = {
	reset = creative_mode_defines.name_prefix .. "reset",
	cancel = creative_mode_defines.name_prefix .. "cancel",
	search = creative_mode_defines.name_prefix .. "search"
}

-- Prefix for the names of free fluid recipes.
creative_mode_defines.names.free_fluid_recipe_prefix = creative_mode_defines.name_prefix .. "free-fluid-"
-- Prefix for the names of the infinite resources.
creative_mode_defines.names.infinite_resource_prefix = creative_mode_defines.name_prefix .. "infinite-"

-- Prefix for the names of enemy worm and spawner entities.
creative_mode_defines.names.enemy_entity_prefix = creative_mode_defines.name_prefix .. "enemy-object_"
-- Prefix for the names of enemy worm and spawner items.
creative_mode_defines.names.enemy_item_prefix = creative_mode_defines.name_prefix .. "enemy-object_"
-- Prefix for the names of enemy worm and spawner recipes.
creative_mode_defines.names.enemy_recipe_prefix = creative_mode_defines.name_prefix .. "enemy-object_"

-- Patterns for matching strings.
creative_mode_defines.match_patterns = {}
creative_mode_defines.match_patterns.gui = {
	all = creative_mode_defines.name_prefix_pattern .. "(.+)",
	event_toggle_checkbox = creative_mode_defines.name_prefix_pattern .. "event%-toggle%-checkbox%-(%d+)",
	interface_button = creative_mode_defines.name_prefix_pattern .. "interface%-button%-(.+)",
	personal_cheats_target_index_button = creative_mode_defines.name_prefix_pattern ..
		"personal%-cheats%-target%-index%-button%-(%d+)",
	team_cheats_target_name_button = creative_mode_defines.name_prefix_pattern ..
		"team%-cheats%-target%-name%-button%-(.+)",
	surface_cheats_target_name_button = creative_mode_defines.name_prefix_pattern ..
		"surface%-cheats%-target%-name%-button%-(.+)",
	build_options_target_index_button = creative_mode_defines.name_prefix_pattern ..
		"build%-options%-target%-index%-button%-(%d+)",
	build_team_target_name_button = creative_mode_defines.name_prefix_pattern .. "build%-team%-target%-name%-button%-(.+)",
	magic_wand_creator_tile_name_button = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-creator%-tile%-name%-button%-(.+)",
	magic_wand_creator_resource_name_button = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-creator%-resource%-name%-button%-(.+)",
	magic_wand_creator_rsc_amt_slider_button = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-creator%-resource%-amount%-slider%-button%-(%d+)",
	magic_wand_creator_tile_name_button_2 = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-creator%-tile%-name%-button%-2%-(.+)",
	magic_wand_creator_resource_name_button_2 = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-creator%-resource%-name%-button%-2%-(.+)",
	magic_wand_creator_rsc_amt_slider_button_2 = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-creator%-resource%-amount%-slider%-button%-2%-(%d+)",
	magic_wand_creator_alt_force_name_checkbox = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-creator%-alt%-force%-name%-checkbox%-(.+)",
	magic_wand_healer_heal_force_name_checkbox = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-healer%-heal%-force%-name%-checkbox%-(.+)",
	magic_wand_healer_alt_force_name_checkbox = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-healer%-alt%-force%-name%-checkbox%-(.+)",
	magic_wand_modifier_std_force_name_checkbox = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-modifier%-std%-force%-name%-checkbox%-(.+)",
	magic_wand_modifier_alt_force_name_checkbox = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-modifier%-alt%-force%-name%-checkbox%-(.+)",
	magic_wand_modifier_quick_action_container = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-modifier%-quick%-action%-container%-(%d+)",
	magic_wand_modifier_popup_entity_name_slot = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-modifier%-popup%-entity%-slot%-(.+)",
	magic_wand_modifier_popup_item_on_ground_name_slot = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-modifier%-popup%-item%-on%-ground%-slot%-(.+)",
	magic_wand_modifier_popup_ghost_entity_name_slot = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-modifier%-popup%-ghost%-entity%-slot%-(.+)",
	magic_wand_modifier_popup_ghost_tile_name_slot = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-modifier%-popup%-ghost%-tile%-slot%-(.+)",
	magic_wand_modifier_team_target_name_button = creative_mode_defines.name_prefix_pattern ..
		"magic%-wand%-modifier%-team%-target%-name%-button%-(.+)",
	interface_contents_button = creative_mode_defines.name_prefix_pattern .. "interface%-contents%-button%-(.+)",
	creative_chest_filter_slot = creative_mode_defines.name_prefix_pattern .. "creative%-chest%-filter%-slot%-(%d+)"
}

-- The additional (hidden) items that should be contained in the creative provider chest
creative_mode_defines.values.creative_provider_chest_additional_content_names = {}
table.insert(creative_mode_defines.values.creative_provider_chest_additional_content_names, "loader")
table.insert(creative_mode_defines.values.creative_provider_chest_additional_content_names, "fast-loader")
table.insert(creative_mode_defines.values.creative_provider_chest_additional_content_names, "express-loader")

table.insert(creative_mode_defines.values.creative_provider_chest_additional_content_names, "railgun")
table.insert(creative_mode_defines.values.creative_provider_chest_additional_content_names, "railgun-dart")

table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.creative_chest
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.creative_provider_chest
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.autofill_requester_chest
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.duplicating_chest
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.duplicating_provider_chest
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.void_requester_chest
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.void_chest
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.void_storage_chest
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_loader
)

table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.creative_cargo_wagon
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.duplicating_cargo_wagon
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.void_cargo_wagon
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_logistic_robot
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_construction_robot
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_roboport
)

table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.fluid_source
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.fluid_void
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_boiler
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_cooler
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.configurable_super_boiler
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.heat_source
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.heat_void
)

table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.item_source
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.duplicator
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.item_void
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.random_item_source
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.creative_lab
)

-- table.insert(creative_mode_defines.values.creative_provider_chest_additional_content_names, creative_mode_defines.names.items.active_electric_energy_interface_output)
-- table.insert(creative_mode_defines.values.creative_provider_chest_additional_content_names, creative_mode_defines.names.items.passive_electric_energy_interface)
-- table.insert(creative_mode_defines.values.creative_provider_chest_additional_content_names, creative_mode_defines.names.items.active_electric_energy_interface_input)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.energy_source
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.passive_energy_source
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.energy_void
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.passive_energy_void
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_electric_pole
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_substation
)

table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.magic_wand_creator
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.magic_wand_healer
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.magic_wand_modifier
)

table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_radar
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_radar_2
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.alien_attractor_small
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.alien_attractor_medium
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.alien_attractor_large
)

table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_beacon
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_speed_module
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_effectivity_module
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_productivity_module
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_clean_module
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_slow_module
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_consumption_module
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_pollution_module
)

table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.belt_immunity_equipment
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_fusion_reactor_equipment
)
table.insert(
	creative_mode_defines.values.creative_provider_chest_additional_content_names,
	creative_mode_defines.names.items.super_personal_roboport_equipment
)

-- The names of the loader recipes.
creative_mode_defines.names.loader_recipes = {
	"loader",
	"fast-loader",
	"express-loader"
}

-- The names of the Railgun recipes.
creative_mode_defines.names.railgun_recipes = {
	"railgun",
	"railgun-dart"
}

-- The name of the Player Port recipe.
creative_mode_defines.names.player_port_recipe = "player-port"
