-- This file contains variables or functions that are related to the Creative Chest in this mod.
if not creative_chest then
	creative_chest = {}
end

-- Processes the tables related to Creative Chests in storage.
function creative_chest.tick()
	-- Refill creative-chests.
	storage.creative_mode.creative_chest_next_update_group, storage.creative_mode.creative_chest_next_update_group_subindex =
		creative_chest_util.refill_chests(
		storage.creative_mode.creative_chest_data_groups,
		storage.creative_mode.creative_chest_next_update_group,
		storage.creative_mode.creative_chest_next_update_group_subindex,
		storage.creative_mode.last_creative_provider_chest_contain_hidden_items
	)
end
