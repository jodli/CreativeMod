-- This file contains variables or functions that are related to the Duplicating Provider Chest in this mod.
if not duplicating_provider_chest then
	duplicating_provider_chest = {}
end

-- Processes the tables related to Duplicating Provider Chest in storage.
function duplicating_provider_chest.tick()
	storage.creative_mode.duplicating_provider_chest_next_update_index =
		duplicating_chest_util.duplicate_contents(
		storage.creative_mode.duplicating_provider_chest_data,
		storage.creative_mode.duplicating_provider_chest_next_update_index
	)
end
