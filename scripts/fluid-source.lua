-- This files contains variables and functions that are related to the Fluid Source in this mod.
if not fluid_source then
	fluid_source = {}
end

-- Processes the fluid_source table in global.
function fluid_source.tick()
	-- Loop through the table of fluid-source to give free energy.
	for index, fluid_source in ipairs(global.creative_mode.fluid_source) do
		if fluid_source.valid then
			if not fluid_source.to_be_deconstructed(fluid_source.force) then
				fluid_source.energy = 100000
			end
		else
			table.remove(global.creative_mode.fluid_source, index)
		end
	end
end
