-- This file contains variables or functions that are related to the Heat Source in this mod.
if not heat_source then heat_source = {} end

-- Processes the table of heat_source in global.
function heat_source.tick()
	-- Loop through the table of heat_source to give free heat.
	for index, heat_source in ipairs(global.creative_mode.heat_source) do
		if heat_source.valid then
			if not heat_source.to_be_deconstructed(heat_source.force) then
				heat_source.temperature = 1000
			end
		else
			table.remove(global.creative_mode.heat_source, index)
		end
	end
end