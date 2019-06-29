-- This file contains variables or functions that are related to the Duplicating Chest in this mod.
if not duplicating_chest then
	duplicating_chest = {}
end

-- Processes the tables related to Duplicating Chest in global.
function duplicating_chest.tick()
	global.creative_mode.duplicating_chest_next_update_index =
		duplicating_chest_util.duplicate_contents(
		global.creative_mode.duplicating_chest_data,
		global.creative_mode.duplicating_chest_next_update_index
	)
end
