-- This file contains variables or functions that are related to the Super Cooler in this mod.
if not super_cooler then
	super_cooler = {}
end

-- Processes the table of super_cooler in global.
function super_cooler.tick()
	-- Loop through the table of super-cooler to give free energy.
	for index, super_cooler in ipairs(global.creative_mode.super_cooler) do
		if super_cooler.valid then
			if not super_cooler.to_be_deconstructed(super_cooler.force) then
				super_cooler.energy = 1000000000000000
				fluid_providers_util.cool_all_fluids_down_to_default_temperature(super_cooler)
			end
		else
			table.remove(global.creative_mode.super_cooler, index)
		end
	end
end
