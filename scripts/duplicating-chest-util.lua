-- This file contains variables or functions that are related to the Duplicating Chest family in this mod.
if not duplicating_chest_util then
	duplicating_chest_util = {}
end

-- Returns the inventory of the given chest.
function duplicating_chest_util.get_inventory(chest)
	local inventory = chest.get_output_inventory()
	if not inventory then
		inventory = chest.get_inventory(defines.inventory.cargo_wagon)
	end
	return inventory
end

-- Fills the inventory of the given chest with the given item prototype.
local function fill_chest_with_item(chest, item_prototype)
	local inventory = duplicating_chest_util.get_inventory(chest)
	for i = 1, #inventory, 1 do
		inventory[i].set_stack {name = item_prototype.name, count = item_prototype.stack_size}
	end
end

-- Refills some chests among the given array of chests according to the given index of the next chest to update.
-- Returns the index of the next chest to update in the next tick.
function duplicating_chest_util.duplicate_contents(chest_datas, next_chest_to_update)
	if #chest_datas <= 0 then
		return 1
	end

	local chest_index = next_chest_to_update
	for i = 1, 10, 1 do
		local chest_data = chest_datas[chest_index]
		local chest = chest_data.entity
		local lock_item = chest_data.lock_item
		local locked_item_name = chest_data.locked_item_name

		if chest.valid then
			if not chest.to_be_deconstructed(chest.force) then
				-- Get the item to be duplicated.
				local item_to_be_duplicated = nil
				if lock_item and locked_item_name then
					item_to_be_duplicated = game.item_prototypes[locked_item_name]
				end
				if item_to_be_duplicated then
					-- The locked item is valid. Fill the chest with such item.
					fill_chest_with_item(chest, item_to_be_duplicated)
				else
					local inventory = duplicating_chest_util.get_inventory(chest)
					local item = inventory[1]
					-- item.valid is true as long as the entity is valid. So it cannot be used for checking whether there is actually an item stack.
					-- We have to use valid_for_read instead.
					if item ~= nil and item.valid_for_read then
						-- Fill the whole chest immediately.
						inventory.insert {name = item.name, count = item.prototype.stack_size * #inventory}

						-- Lock the item if it should be locked.
						if lock_item then
							chest_data.locked_item_name = item.name
						end
					end
				end
			end

			-- Prepare for the next chest.
			chest_index = chest_index + 1
			-- No more next chest. Return to the first chest.
			if chest_index > #chest_datas then
				return 1
			end
		else
			table.remove(chest_datas, chest_index)
			if chest_index > #chest_datas then
				return 1
			end
		end
	end
	-- Return the index of the next chest to update.
	return chest_index
end

--------------------------------------------------------------

-- Look up table for mapping the entity name to duplicating chest data list.
local entity_name_to_data_list_look_up = {
	[creative_mode_defines.names.entities.duplicating_chest] = function()
		return global.creative_mode.duplicating_chest_data
	end,
	[creative_mode_defines.names.entities.duplicating_provider_chest] = function()
		return global.creative_mode.duplicating_provider_chest_data
	end,
	[creative_mode_defines.names.entities.duplicating_cargo_wagon] = function()
		return global.creative_mode.duplicating_cargo_wagon_data
	end
}

-- Returns the duplicating chest data according to the given entity.
-- If no data is found, nil will be returned.
function duplicating_chest_util.get_data_for_entity(entity)
	local look_up_function = entity_name_to_data_list_look_up[entity.name]
	if look_up_function then
		local data_list = look_up_function()
		if data_list then
			for _, data in ipairs(data_list) do
				if data.entity == entity then
					return data
				end
			end
		end
	end
	return nil
end

--------------------------------------------------------------

-- Copies the contents from the source chest to the destination chest when copy-paste is done on the Duplicating Chest family.
function duplicating_chest_util.on_entity_copied_pasted(source_chest, destination_chest)
	local source_inventory = duplicating_chest_util.get_inventory(source_chest)
	local source_data = duplicating_chest_util.get_data_for_entity(source_chest)
	local destination_inventory = duplicating_chest_util.get_inventory(destination_chest)
	local destination_data = duplicating_chest_util.get_data_for_entity(destination_chest)

	destination_inventory.clear()

	local source_item = source_inventory[1]
	if source_item ~= nil and source_item.valid_for_read then
		destination_inventory.insert {
			name = source_item.name,
			count = source_item.prototype.stack_size * #destination_inventory
		}
	end

	if source_data and destination_data then
		destination_data.lock_item = source_data.lock_item
		destination_data.locked_item_name = source_data.locked_item_name
	end
end
