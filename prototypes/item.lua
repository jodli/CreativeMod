local flags_quickbar = {}
local flags_main_inventory = {}
if not settings.startup[creative_mode_defines.names.settings.unhide_items].value then
	table.insert(flags_quickbar, "hidden")
	table.insert(flags_main_inventory, "hidden")
end

data:extend(
	{
		-- The items are hidden so they are not shown on the logistic slots when Creative Mode is not enabled.
		-- Currently there is no way to unhide them.
		{
			-- Creative chest
			type = "item",
			name = creative_mode_defines.names.items.creative_chest,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/creative-chest.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.items,
			order = "a",
			place_result = creative_mode_defines.names.entities.creative_chest,
			stack_size = 50
		},
		{
			-- Creative provider chest
			type = "item",
			name = creative_mode_defines.names.items.creative_provider_chest,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/creative-provider-chest.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.items,
			order = "b",
			place_result = creative_mode_defines.names.entities.creative_provider_chest,
			stack_size = 50
		},
		{
			-- Autofill requester chest
			type = "item",
			name = creative_mode_defines.names.items.autofill_requester_chest,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/autofill-requester-chest.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.items,
			order = "c",
			place_result = creative_mode_defines.names.entities.autofill_requester_chest,
			stack_size = 50
		},
		{
			-- Duplicating chest
			type = "item",
			name = creative_mode_defines.names.items.duplicating_chest,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/duplicating-chest.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.items,
			order = "d",
			place_result = creative_mode_defines.names.entities.duplicating_chest,
			stack_size = 50
		},
		{
			-- Duplicating provider chest
			type = "item",
			name = creative_mode_defines.names.items.duplicating_provider_chest,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/duplicating-provider-chest.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.items,
			order = "e",
			place_result = creative_mode_defines.names.entities.duplicating_provider_chest,
			stack_size = 50
		},
		{
			-- Void chest
			type = "item",
			name = creative_mode_defines.names.items.void_chest,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/void-chest.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.items,
			order = "f",
			place_result = creative_mode_defines.names.entities.void_chest,
			stack_size = 50
		},
		{
			-- Void requester chest
			type = "item",
			name = creative_mode_defines.names.items.void_requester_chest,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/void-requester-chest.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.items,
			order = "g",
			place_result = creative_mode_defines.names.entities.void_requester_chest,
			stack_size = 50
		},
		{
			-- Void storage chest
			type = "item",
			name = creative_mode_defines.names.items.void_storage_chest,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/void-storage-chest.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.items,
			order = "h",
			place_result = creative_mode_defines.names.entities.void_storage_chest,
			stack_size = 50
		},
		{
			-- Super loader
			type = "item",
			name = creative_mode_defines.names.items.super_loader,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-loader.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.items,
			order = "i",
			place_result = creative_mode_defines.names.entities.super_loader,
			stack_size = 50
		},
		-----------------------------------------------------------------------------

		{
			-- Creative cargo wagon
			type = "item",
			name = creative_mode_defines.names.items.creative_cargo_wagon,
			icon_size = 64,
			icon_mipmaps = 4,
			icons = {
				{
					icon = "__base__/graphics/icons/cargo-wagon.png",
					tint = {r = 1, g = 0.3, b = 0.3}
				}
			},
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.vehicles,
			order = "a",
			place_result = creative_mode_defines.names.entities.creative_cargo_wagon,
			stack_size = 50
		},
		{
			-- Duplicating cargo wagon
			type = "item",
			name = creative_mode_defines.names.items.duplicating_cargo_wagon,
			icon_size = 64,
			icon_mipmaps = 4,
			icons = {
				{
					icon = "__base__/graphics/icons/cargo-wagon.png",
					tint = {r = 0.35, g = 0.3, b = 1}
				}
			},
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.vehicles,
			order = "b",
			place_result = creative_mode_defines.names.entities.duplicating_cargo_wagon,
			stack_size = 50
		},
		{
			-- Void cargo wagon
			type = "item",
			name = creative_mode_defines.names.items.void_cargo_wagon,
			icon_size = 64,
			icon_mipmaps = 4,
			icons = {
				{
					icon = "__base__/graphics/icons/cargo-wagon.png",
					tint = {r = 0.4, g = 0.4, b = 0.4}
				}
			},
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.vehicles,
			order = "c",
			place_result = creative_mode_defines.names.entities.void_cargo_wagon,
			stack_size = 50
		},
		{
			-- Super logistic robot.
			type = "item",
			name = creative_mode_defines.names.items.super_logistic_robot,
			icon_size = 64,
			icon_mipmaps = 4,
			icons = {
				{
					icon = "__base__/graphics/icons/logistic-robot.png",
					tint = {r = 1, g = 0.3, b = 0.3}
				}
			},
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.vehicles,
			order = "d",
			place_result = creative_mode_defines.names.entities.super_logistic_robot,
			stack_size = 1000
		},
		{
			-- Super construction robot.
			type = "item",
			name = creative_mode_defines.names.items.super_construction_robot,
			icon_size = 64,
			icon_mipmaps = 4,
			icons = {
				{
					icon = "__base__/graphics/icons/construction-robot.png",
					tint = {r = 0.3, g = 0.3, b = 1}
				}
			},
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.vehicles,
			order = "e",
			place_result = creative_mode_defines.names.entities.super_construction_robot,
			stack_size = 1000
		},
		{
			-- Super roboport
			type = "item",
			name = creative_mode_defines.names.items.super_roboport,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-roboport.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.vehicles,
			order = "f",
			place_result = creative_mode_defines.names.entities.super_roboport,
			stack_size = 50
		},
		-----------------------------------------------------------------------------

		{
			-- Fluid source
			type = "item",
			name = creative_mode_defines.names.items.fluid_source,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/fluid-source.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.fluids,
			order = "a",
			place_result = creative_mode_defines.names.entities.fluid_source,
			stack_size = 50
		},
		{
			-- Fluid void
			type = "item",
			name = creative_mode_defines.names.items.fluid_void,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/fluid-void.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.fluids,
			order = "b",
			place_result = creative_mode_defines.names.entities.fluid_void,
			stack_size = 50
		},
		{
			-- Super boiler
			type = "item",
			name = creative_mode_defines.names.items.super_boiler,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-boiler.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.fluids,
			order = "c",
			place_result = creative_mode_defines.names.entities.super_boiler,
			stack_size = 50
		},
		{
			-- Super cooler
			type = "item",
			name = creative_mode_defines.names.items.super_cooler,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-cooler.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.fluids,
			order = "d",
			place_result = creative_mode_defines.names.entities.super_cooler,
			stack_size = 50
		},
		{
			-- Configurable super boiler
			type = "item",
			name = creative_mode_defines.names.items.configurable_super_boiler,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/configurable-super-boiler.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.fluids,
			order = "e",
			place_result = creative_mode_defines.names.entities.configurable_super_boiler,
			stack_size = 50
		},
		{
			-- Heat source
			type = "item",
			name = creative_mode_defines.names.items.heat_source,
			icon_size = 64,
			icon_mipmaps = 4,
			icons = {
				{
					icon = "__base__/graphics/icons/heat-pipe.png",
					tint = {r = 1, g = 0.3, b = 0.3}
				}
			},
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.fluids,
			order = "f",
			place_result = creative_mode_defines.names.entities.heat_source,
			stack_size = 50
		},
		{
			-- Heat void
			type = "item",
			name = creative_mode_defines.names.items.heat_void,
			icon_size = 64,
			icon_mipmaps = 4,
			icons = {
				{
					icon = "__base__/graphics/icons/heat-pipe.png",
					tint = {r = 0.2, g = 0.2, b = 0.2}
				}
			},
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.fluids,
			order = "g",
			place_result = creative_mode_defines.names.entities.heat_void,
			stack_size = 50
		},
		-----------------------------------------------------------------------------

		{
			-- Matter source
			type = "item",
			name = creative_mode_defines.names.items.item_source,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/item-source.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.advanced,
			order = "a",
			place_result = creative_mode_defines.names.entities.item_source,
			stack_size = 50
		},
		{
			-- Matter duplicator
			type = "item",
			name = creative_mode_defines.names.items.duplicator,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/duplicator.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.advanced,
			order = "b",
			place_result = creative_mode_defines.names.entities.duplicator,
			stack_size = 50
		},
		{
			-- Matter void
			type = "item",
			name = creative_mode_defines.names.items.item_void,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/item-void.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.advanced,
			order = "c",
			place_result = creative_mode_defines.names.entities.item_void,
			stack_size = 50
		},
		{
			-- Random item source
			type = "item",
			name = creative_mode_defines.names.items.random_item_source,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/random-item-source.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.advanced,
			order = "d",
			place_result = creative_mode_defines.names.entities.random_item_source,
			stack_size = 50
		},
		{
			-- Creative lab
			type = "item",
			name = creative_mode_defines.names.items.creative_lab,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/creative-lab.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.advanced,
			order = "e",
			place_result = creative_mode_defines.names.entities.creative_lab,
			stack_size = 50
		},
		-----------------------------------------------------------------------------

		{
			-- Active electric energy interface (output)
			type = "item",
			name = creative_mode_defines.names.items.active_electric_energy_interface_output,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/active-electric-energy-interface-output.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.energy,
			order = "a",
			place_result = creative_mode_defines.names.entities.active_electric_energy_interface_output,
			stack_size = 50
		},
		{
			-- Passive electric energy interface
			type = "item",
			name = creative_mode_defines.names.items.passive_electric_energy_interface,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/passive-electric-energy-interface.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.energy,
			order = "b",
			place_result = creative_mode_defines.names.entities.passive_electric_energy_interface,
			stack_size = 50
		},
		{
			-- Active electric energy interface (input)
			type = "item",
			name = creative_mode_defines.names.items.active_electric_energy_interface_input,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/active-electric-energy-interface-input.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.energy,
			order = "c",
			place_result = creative_mode_defines.names.entities.active_electric_energy_interface_input,
			stack_size = 50
		},
		{
			-- Active energy source
			type = "item",
			name = creative_mode_defines.names.items.energy_source,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/energy-source.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.energy,
			order = "d",
			place_result = creative_mode_defines.names.entities.energy_source,
			stack_size = 50
		},
		{
			-- Passive energy source
			type = "item",
			name = creative_mode_defines.names.items.passive_energy_source,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/passive-energy-source.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.energy,
			order = "e",
			place_result = creative_mode_defines.names.entities.passive_energy_source,
			stack_size = 50
		},
		{
			-- Active energy void
			type = "item",
			name = creative_mode_defines.names.items.energy_void,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/energy-void.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.energy,
			order = "f",
			place_result = creative_mode_defines.names.entities.energy_void,
			stack_size = 50
		},
		{
			-- Dummy item for energy void to absorb energy.
			type = "item",
			name = creative_mode_defines.names.items.energy_absorption,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/energy-absorption.png",
			flags = {},
			subgroup = creative_mode_defines.names.item_subgroups.energy,
			order = "z",
			stack_size = 50
		},
		{
			-- Passive energy void
			type = "item",
			name = creative_mode_defines.names.items.passive_energy_void,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/passive-energy-void.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.energy,
			order = "g",
			place_result = creative_mode_defines.names.entities.passive_energy_void,
			stack_size = 50
		},
		{
			-- Super electric pole
			type = "item",
			name = creative_mode_defines.names.items.super_electric_pole,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-electric-pole.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.energy,
			order = "h",
			place_result = creative_mode_defines.names.entities.super_electric_pole,
			stack_size = 50
		},
		{
			-- Super substation
			type = "item",
			name = creative_mode_defines.names.items.super_substation,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-substation.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.energy,
			order = "i",
			place_result = creative_mode_defines.names.entities.super_substation,
			stack_size = 50
		},
		-----------------------------------------------------------------------------

		{
			-- Magic wand - creator
			type = "selection-tool",
			name = creative_mode_defines.names.items.magic_wand_creator,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/magic-wand-creator.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.magic_wands,
			order = "a",
			stack_size = 1,
			selection_color = {r = 0, g = 1, b = 0},
			selection_mode = {"any-tile"},
			selection_cursor_box_type = "entity",
			alt_selection_color = {r = 1, g = 0, b = 0},
			alt_selection_mode = {"any-entity", "deconstruct"},
			alt_selection_cursor_box_type = "not-allowed",
			always_include_tiles = true
		},
		{
			-- Magic wand - healer
			type = "selection-tool",
			name = creative_mode_defines.names.items.magic_wand_healer,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/magic-wand-healer.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.magic_wands,
			order = "b",
			stack_size = 1,
			selection_color = {r = 0, g = 1, b = 0},
			selection_mode = {"any-entity"},
			selection_cursor_box_type = "copy",
			alt_selection_color = {r = 1, g = 0.5, b = 0},
			alt_selection_mode = {"any-entity"},
			alt_selection_cursor_box_type = "not-allowed"
		},
		{
			-- Magic wand - modifier
			type = "selection-tool",
			name = creative_mode_defines.names.items.magic_wand_modifier,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/magic-wand-modifier.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.magic_wands,
			order = "c",
			stack_size = 1,
			selection_color = {r = 0.5, g = 0, b = 1},
			selection_mode = {"any-entity"},
			selection_cursor_box_type = "electricity",
			alt_selection_color = {r = 0.5, g = 1, b = 1},
			alt_selection_mode = {"any-entity"},
			alt_selection_cursor_box_type = "electricity"
		},
		-----------------------------------------------------------------------------

		{
			-- Super radar
			type = "item",
			name = creative_mode_defines.names.items.super_radar,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-radar.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.enemies,
			order = "za",
			place_result = creative_mode_defines.names.entities.super_radar,
			stack_size = 50
		},
		{
			-- Super radar MK2
			type = "item",
			name = creative_mode_defines.names.items.super_radar_2,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-radar-2.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.enemies,
			order = "zb",
			place_result = creative_mode_defines.names.entities.super_radar_2,
			stack_size = 50
		},
		{
			-- Alien attractor - small
			type = "item",
			name = creative_mode_defines.names.items.alien_attractor_small,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/alien-attractor-small.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.enemies,
			order = "zc",
			place_result = creative_mode_defines.names.entities.alien_attractor_proxy_small,
			stack_size = 100
		},
		{
			-- Alien attractor - medium
			type = "item",
			name = creative_mode_defines.names.items.alien_attractor_medium,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/alien-attractor-medium.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.enemies,
			order = "zd",
			place_result = creative_mode_defines.names.entities.alien_attractor_proxy_medium,
			stack_size = 100
		},
		{
			-- Alien attractor - large
			type = "item",
			name = creative_mode_defines.names.items.alien_attractor_large,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/alien-attractor-large.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.enemies,
			order = "ze",
			place_result = creative_mode_defines.names.entities.alien_attractor_proxy_large,
			stack_size = 100
		},
		-----------------------------------------------------------------------------

		{
			-- Super beacon
			type = "item",
			name = creative_mode_defines.names.items.super_beacon,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-beacon.png",
			flags = flags_quickbar,
			subgroup = creative_mode_defines.names.item_subgroups.modules,
			order = "a",
			place_result = creative_mode_defines.names.entities.super_beacon,
			stack_size = 50
		},
		{
			-- Super speed module.
			type = "module",
			name = creative_mode_defines.names.recipes.super_speed_module,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-speed-module.png",
			flags = flags_main_inventory,
			subgroup = creative_mode_defines.names.item_subgroups.modules,
			category = "speed",
			tier = 50,
			order = "b",
			stack_size = 50,
			effect = {speed = {bonus = 2.5}}
		},
		{
			-- Super effectivity module.
			type = "module",
			name = creative_mode_defines.names.recipes.super_effectivity_module,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-effectivity-module.png",
			flags = flags_main_inventory,
			subgroup = creative_mode_defines.names.item_subgroups.modules,
			category = "effectivity",
			tier = 50,
			order = "c",
			stack_size = 50,
			effect = {consumption = {bonus = -2.5}} -- 80% limit
		},
		{
			-- Super productivity module
			type = "module",
			name = creative_mode_defines.names.recipes.super_productivity_module,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-productivity-module.png",
			flags = flags_main_inventory,
			subgroup = creative_mode_defines.names.item_subgroups.modules,
			category = "productivity",
			tier = 50,
			order = "d",
			stack_size = 50,
			effect = {productivity = {bonus = 2.5}}
		},
		{
			-- Super clean module
			type = "module",
			name = creative_mode_defines.names.recipes.super_clean_module,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-clean-module.png",
			flags = flags_main_inventory,
			subgroup = creative_mode_defines.names.item_subgroups.modules,
			category = "effectivity",
			tier = 50,
			order = "e",
			stack_size = 50,
			effect = {pollution = {bonus = -2.5}} -- 80% limit
		},
		{
			-- Super slow module.
			type = "module",
			name = creative_mode_defines.names.recipes.super_slow_module,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-slow-module.png",
			flags = flags_main_inventory,
			subgroup = creative_mode_defines.names.item_subgroups.modules,
			category = "speed",
			tier = 50,
			order = "f",
			stack_size = 50,
			effect = {speed = {bonus = -2.5}} -- 80% limit
		},
		{
			-- Super consumption module.
			type = "module",
			name = creative_mode_defines.names.recipes.super_consumption_module,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-consumption-module.png",
			flags = flags_main_inventory,
			subgroup = creative_mode_defines.names.item_subgroups.modules,
			category = "effectivity",
			tier = 50,
			order = "g",
			stack_size = 50,
			effect = {consumption = {bonus = 2.5}}
		},
		{
			-- Super pollution module
			type = "module",
			name = creative_mode_defines.names.recipes.super_pollution_module,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-pollution-module.png",
			flags = flags_main_inventory,
			subgroup = creative_mode_defines.names.item_subgroups.modules,
			category = "effectivity",
			tier = 50,
			order = "h",
			stack_size = 50,
			effect = {pollution = {bonus = 2.5}}
		},
		-----------------------------------------------------------------------------

		{
			-- Super fusion reactor equipment
			type = "item",
			name = creative_mode_defines.names.items.super_fusion_reactor_equipment,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-fusion-reactor-equipment.png",
			flags = flags_main_inventory,
			subgroup = creative_mode_defines.names.item_subgroups.equipments,
			order = "b",
			placed_as_equipment_result = creative_mode_defines.names.equipments.super_fusion_reactor_equipment,
			stack_size = 50
		},
		{
			-- Super personal roboport
			type = "item",
			name = creative_mode_defines.names.items.super_personal_roboport_equipment,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-personal-roboport-equipment.png",
			flags = flags_main_inventory,
			subgroup = creative_mode_defines.names.item_subgroups.equipments,
			order = "c",
			placed_as_equipment_result = creative_mode_defines.names.equipments.super_personal_roboport_equipment,
			stack_size = 50
		}
	}
)
