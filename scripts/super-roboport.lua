-- This file contains variables or functions that are related to the Super Roboport in this mod.
if not super_roboport then
	super_roboport = {}
end

-- Processes the table of super_roboport in global.
function super_roboport.tick()
	-- Loop through the table of super_roboport to give free energy.
	for index, super_roboport in ipairs(global.creative_mode.super_roboport) do
		if super_roboport.valid then
			if not super_roboport.to_be_deconstructed(super_roboport.force) then
				super_roboport.energy = 1000000000000000000000000000000
			end
		else
			table.remove(global.creative_mode.super_roboport, index)
		end
	end
end
