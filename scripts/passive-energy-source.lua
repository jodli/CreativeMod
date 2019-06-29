-- This file contains variables or functions that are related to the Passive Energy Source in this mod.
if not passive_energy_source then
	passive_energy_source = {}
end

-- Processes the table of passive_energy in global.
function passive_energy_source.tick()
	-- Loop through the table of passive_energy-source to give free energy.
	for index, passive_energy_source in ipairs(global.creative_mode.passive_energy_source) do
		if passive_energy_source.valid then
			if not passive_energy_source.to_be_deconstructed(passive_energy_source.force) then
				passive_energy_source.energy = 1000000000000000
			end
		else
			table.remove(global.creative_mode.passive_energy_source, index)
		end
	end
end
