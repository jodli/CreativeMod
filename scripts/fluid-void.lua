-- This files contains variables and functions that are related to the Fluid Void in this mod.
if not fluid_void then
	fluid_void = {}
end

-- Processes the fluid_void table in storage.
function fluid_void.tick()
	-- Loop through the table of fluid-void to nullify the fluid inside its fluid box.
	for index, fluid_void in ipairs(storage.creative_mode.fluid_void) do
		if fluid_void.valid then
			if not fluid_void.to_be_deconstructed(fluid_void.force) then
				for i = 1, #fluid_void.fluidbox do
					fluid_void.fluidbox[i] = nil
				end
			end
		else
			table.remove(storage.creative_mode.fluid_void, index)
		end
	end
end
