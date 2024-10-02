-- This file contains variables or functions that are related to the Creative Provider Chest in this mod.
if not creative_provider_chest then
	creative_provider_chest = {}
end

-- Processes the tables related to Creative Provider Chests in storage.
function creative_provider_chest.tick()
	-- Refill creative-provider-chests.
	storage.creative_mode.creative_provider_chest_next_update_group,
		storage.creative_mode.creative_provider_chest_next_update_group_subindex =
		creative_chest_util.refill_chests(
		storage.creative_mode.creative_provider_chest_data_groups,
		storage.creative_mode.creative_provider_chest_next_update_group,
		storage.creative_mode.creative_provider_chest_next_update_group_subindex,
		storage.creative_mode.last_creative_provider_chest_contain_hidden_items
	)
end
