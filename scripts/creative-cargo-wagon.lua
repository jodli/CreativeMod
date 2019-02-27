-- This file contains variables or functions that are related to the Creative Cargo Wagon in this mod.
if not creative_cargo_wagon then creative_cargo_wagon = {} end

-- Processes the tables related to Creative Cargo Wagon in global.
function creative_cargo_wagon.tick()
	-- Refill creative-cargo-wagons.
	global.creative_mode.creative_cargo_wagon_next_update_group, global.creative_mode.creative_cargo_wagon_next_update_group_subindex = creative_chest_util.refill_chests(
		global.creative_mode.creative_cargo_wagon_data_groups,
		global.creative_mode.creative_cargo_wagon_next_update_group,
		global.creative_mode.creative_cargo_wagon_next_update_group_subindex,
		global.creative_mode.last_creative_cargo_wagon_contain_hidden_items)
end