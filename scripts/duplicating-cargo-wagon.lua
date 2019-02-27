-- This file contains variables or functions that are related to the Duplicating Cargo Wagon in this mod.
if not duplicating_cargo_wagon then duplicating_cargo_wagon = {} end

-- Processes the tables related to Duplicating Provider Chest in global.
function duplicating_cargo_wagon.tick()
	global.creative_mode.duplicating_cargo_wagon_next_update_index = duplicating_chest_util.duplicate_contents(global.creative_mode.duplicating_cargo_wagon_data, global.creative_mode.duplicating_cargo_wagon_next_update_index)
end