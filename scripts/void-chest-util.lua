-- This file contains variables or functions that are related to the Void Chest family in this mod.
if not void_chest_util then void_chest_util = {} end

-- Returns the inventory of the given chest.
function void_chest_util.get_inventory(chest)
	local inventory = chest.get_output_inventory()
	if not inventory then
		inventory = chest.get_inventory(defines.inventory.cargo_wagon)
	end
	return inventory
end

-- Removes the chest contents among the given array of chests according to the given index of the next chest to update.
-- Returns the index of the next chest to update in the next tick.
function void_chest_util.remove_contents(chests, next_chest_to_update)
	if #chests <= 0 then
		return 1
	end
	
	local chest_index = next_chest_to_update
	for i = 1, 10, 1 do
		local chest = chests[chest_index]
		if chest.valid then
			if not chest.to_be_deconstructed(chest.force) then
				-- Clear its inventory.
				local inventory = void_chest_util.get_inventory(chest)
				inventory.clear()
			end
			
			-- Prepare for the next chest.
			chest_index = chest_index + 1
			-- No more next chest. Return to the first chest.
			if chest_index > #chests then
				return 1
			end
		else
			table.remove(chests, chest_index)
			if chest_index > #chests then
				return 1
			end
		end		
	end
	-- Return the index of the next chest to update.
	return chest_index
end