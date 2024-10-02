-- This file contains variables or functions that are related to the Duplicating Chest in this mod.
if not duplicating_chest then
	duplicating_chest = {}
end

-- Processes the tables related to Duplicating Chest in storage.
function duplicating_chest.tick()
	storage.creative_mode.duplicating_chest_next_update_index =
		duplicating_chest_util.duplicate_contents(
		storage.creative_mode.duplicating_chest_data,
		storage.creative_mode.duplicating_chest_next_update_index
	)
end
