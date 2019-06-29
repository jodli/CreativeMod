-- This file contains variables or functions that are related to the Super Radar in this mod.
if not super_radar then
	super_radar = {}
end

-- Processes the table of super_radar in global.
function super_radar.tick()
	-- Loop through the table of super_radar to give free energy.
	for index, super_radar in ipairs(global.creative_mode.super_radar) do
		if super_radar.valid then
			if not super_radar.to_be_deconstructed(super_radar.force) then
				super_radar.energy = 1000000000000000000000000000000
			end
		else
			table.remove(global.creative_mode.super_radar, index)
		end
	end
end
