-- This file contains variables or functions that are related to the Energy Void in this mod.
if not energy_void then
	energy_void = {}
end

-- Processes the table of energy_void in global.
function energy_void.tick()
	-- Loop through the table of energy-void to nullify the energy.
	for index, energy_void in ipairs(global.creative_mode.energy_void) do
		if energy_void.valid then
			if not energy_void.to_be_deconstructed(energy_void.force) then
				energy_void.energy = 0
				-- Also clear its output inventory, though it is unlikely to finish crafting.
				energy_void.get_output_inventory().clear()
				-- Fix its recipe. Somehow player can copy and paste other recipes from another assembling machine.
				energy_void.set_recipe(energy_void.force.recipes[creative_mode_defines.names.recipes.energy_absorption])
			end
		else
			table.remove(global.creative_mode.energy_void, index)
		end
	end
end
