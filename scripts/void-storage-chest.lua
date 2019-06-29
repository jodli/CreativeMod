-- This file contains variables or functions that are related to the Void Storage Chest in this mod.
if not void_storage_chest then
	void_storage_chest = {}
end

-- Processes the tables related to Void Storage Chest in global.
function void_storage_chest.tick()
	global.creative_mode.void_storage_chest_next_update_index =
		void_chest_util.remove_contents(
		global.creative_mode.void_storage_chest,
		global.creative_mode.void_storage_chest_next_update_index
	)
end
