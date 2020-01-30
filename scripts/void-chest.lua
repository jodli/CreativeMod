-- This file contains variables or functions that are related to the Void Chest in this mod.
if not void_chest then
	void_chest = {}
end

-- Processes the tables related to Void Chest in global.
function void_chest.tick()
	global.creative_mode.void_chest_next_update_index =
		void_chest_util.remove_contents(
		global.creative_mode.void_chest,
		global.creative_mode.void_chest_next_update_index
	)
end
