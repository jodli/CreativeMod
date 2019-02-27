-- This file contains variables or functions that are related to the Super Beacon in this mod.
if not super_beacon then super_beacon = {} end

-- Processes the table of super_beacon in global.
function super_beacon.tick()
	-- Loop through the table of super_beacon to give free energy.
	for index, super_beacon in ipairs(global.creative_mode.super_beacon) do
		if super_beacon.valid then
			if not super_beacon.to_be_deconstructed(super_beacon.force) then
				super_beacon.energy = 1000000000000000000000000000000
			end
		else
			table.remove(global.creative_mode.super_beacon, index)
		end
	end
end