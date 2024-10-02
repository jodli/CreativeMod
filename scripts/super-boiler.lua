-- This file contains variables or functions that are related to the Super Boiler in this mod.
if not super_boiler then
	super_boiler = {}
end

-- Processes the table of super_boiler in storage.
function super_boiler.tick()
	-- Loop through the table of super-boiler to give free energy and heat up fluid inside.
	for index, super_boiler in ipairs(storage.creative_mode.super_boiler) do
		if super_boiler.valid then
			if not super_boiler.to_be_deconstructed(super_boiler.force) then
				super_boiler.energy = 1000000000000000
				fluid_providers_util.heat_all_fluids_up_to_max_temperature(super_boiler)
			end
		else
			table.remove(storage.creative_mode.super_boiler, index)
		end
	end
end
