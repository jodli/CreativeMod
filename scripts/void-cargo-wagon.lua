-- This file contains variables or functions that are related to the Void Cargo Wagon in this mod.
if not void_cargo_wagon then
	void_cargo_wagon = {}
end

-- Processes the tables related to Void Cargo Wagon in global.
function void_cargo_wagon.tick()
	global.creative_mode.void_cargo_wagon_next_update_index =
		void_chest_util.remove_contents(
		global.creative_mode.void_cargo_wagon,
		global.creative_mode.void_cargo_wagon_next_update_index
	)
end
