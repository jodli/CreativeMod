-- This file contains variables or functions that are related to the Void Requester Chest in this mod.
if not void_requester_chest then
	void_requester_chest = {}
end

-- Processes the tables related to Void Requester Chest in global.
function void_requester_chest.tick()
	global.creative_mode.void_requester_chest_next_update_index =
		void_chest_util.remove_contents(
		global.creative_mode.void_requester_chest,
		global.creative_mode.void_requester_chest_next_update_index
	)
end
