-- This file contains variables or functions that are related to the Creative Cargo Wagon in this mod.
if not creative_cargo_wagon then
	creative_cargo_wagon = {}
end

-- Processes the tables related to Creative Cargo Wagon in storage.
function creative_cargo_wagon.tick()
	-- Refill creative-cargo-wagons.
	storage.creative_mode.creative_cargo_wagon_next_update_group,
		storage.creative_mode.creative_cargo_wagon_next_update_group_subindex =
		creative_chest_util.refill_chests(
		storage.creative_mode.creative_cargo_wagon_data_groups,
		storage.creative_mode.creative_cargo_wagon_next_update_group,
		storage.creative_mode.creative_cargo_wagon_next_update_group_subindex,
		storage.creative_mode.last_creative_cargo_wagon_contain_hidden_items
	)
end
