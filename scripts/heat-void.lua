-- This file contains variables or functions that are related to the Heat Void in this mod.
if not heat_void then
	heat_void = {}
end

-- Processes the table of heat_void in global.
function heat_void.tick()
	-- Loop through the table of heat_void to give free heat.
	for index, heat_void in ipairs(global.creative_mode.heat_void) do
		if heat_void.valid then
			if not heat_void.to_be_deconstructed(heat_void.force) then
				heat_void.temperature = 0
			end
		else
			table.remove(global.creative_mode.heat_void, index)
		end
	end
end
