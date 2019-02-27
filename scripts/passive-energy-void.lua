-- This file contains variables or functions that are related to the Passive Energy Void in this mod.
if not passive_energy_void then passive_energy_void = {} end

-- Processes the table of passive_energy_void in global.
function passive_energy_void.tick()
	-- Loop through the table of passive-energy-void to nullify the energy.
	for index, passive_energy_void in ipairs(global.creative_mode.passive_energy_void) do
		if passive_energy_void.valid then
			if not passive_energy_void.to_be_deconstructed(passive_energy_void.force) then
				passive_energy_void.energy = 0
			end
		else
			table.remove(global.creative_mode.passive_energy_void, index)
		end
	end
end