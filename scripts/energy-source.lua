-- This file contains variables or functions that are related to the Active Energy Source in this mod.
if not energy_source then
	energy_source = {}
end

-- Processes the table of energy_source in global.
function energy_source.tick()
	-- Loop through the table of energy-source to give free energy.
	for index, energy_source in ipairs(global.creative_mode.energy_source) do
		if energy_source.valid then
			if not energy_source.to_be_deconstructed(energy_source.force) then
				energy_source.energy = 1000000000000000
			end
		else
			table.remove(global.creative_mode.energy_source, index)
		end
	end
end
