data:extend(
	{
		{
			-- Creative tools
			type = "item-group",
			name = creative_mode_defines.names.item_groups.creative_tools,
			order = "zzz",
			icon = creative_mode_defines.mod_directory .. "/graphics/item-group/creative-tools.png",
			icon_size = 64
		},
		{
			-- Creative tools / Items
			type = "item-subgroup",
			name = creative_mode_defines.names.item_subgroups.items,
			group = creative_mode_defines.names.item_groups.creative_tools,
			order = "a"
		},
		{
			-- Creative tools / Vehicles
			type = "item-subgroup",
			name = creative_mode_defines.names.item_subgroups.vehicles,
			group = creative_mode_defines.names.item_groups.creative_tools,
			order = "b"
		},
		{
			-- Creative tools / Fluids
			type = "item-subgroup",
			name = creative_mode_defines.names.item_subgroups.fluids,
			group = creative_mode_defines.names.item_groups.creative_tools,
			order = "c"
		},
		{
			-- Creative tools / Advanced
			type = "item-subgroup",
			name = creative_mode_defines.names.item_subgroups.advanced,
			group = creative_mode_defines.names.item_groups.creative_tools,
			order = "d"
		},
		{
			-- Creative tools / Energy
			type = "item-subgroup",
			name = creative_mode_defines.names.item_subgroups.energy,
			group = creative_mode_defines.names.item_groups.creative_tools,
			order = "e"
		},
		{
			-- Creative tools / Magic wands
			type = "item-subgroup",
			name = creative_mode_defines.names.item_subgroups.magic_wands,
			group = creative_mode_defines.names.item_groups.creative_tools,
			order = "f"
		},
		{
			-- Creative tools / Enemies
			type = "item-subgroup",
			name = creative_mode_defines.names.item_subgroups.enemies,
			group = creative_mode_defines.names.item_groups.creative_tools,
			order = "g"
		},
		{
			-- Creative tools / Modules
			type = "item-subgroup",
			name = creative_mode_defines.names.item_subgroups.modules,
			group = creative_mode_defines.names.item_groups.creative_tools,
			order = "h"
		},
		{
			-- Creative tools / Equipments
			type = "item-subgroup",
			name = creative_mode_defines.names.item_subgroups.equipments,
			group = creative_mode_defines.names.item_groups.creative_tools,
			order = "i"
		},
		{
			-- Creative tools / Free fluids
			type = "item-subgroup",
			name = creative_mode_defines.names.item_subgroups.free_fluids,
			group = creative_mode_defines.names.item_groups.creative_tools,
			order = "j"
		}
	}
)
