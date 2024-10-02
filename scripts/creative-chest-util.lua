-- This file contains variables or functions that are related to the Creative Chest family in this mod.
if not creative_chest_util then
	creative_chest_util = {}
end

-- All possible inventory display mode for creative chests.
creative_chest_util.inventory_display_modes = {
	original_mode = 1,
	compact_mode = 2
}

-- Returns the total number of items to be contained according to whether the container should also contain hidden items.
local function get_total_item_count(contain_hidden_items)
	local count =
		#storage.non_hidden_item_list + #creative_mode_defines.values.creative_provider_chest_additional_content_names +
		#storage.hidden_creative_enemy_item_list
	if contain_hidden_items then
		count = count + #storage.non_creative_hidden_item_list
	end
	return count
end

-- Returns the item prototype at given index according to whether the container should contain hidden items.
function creative_chest_util.get_item_at(item_index, contain_hidden_items)
	local current_item_count = #storage.non_hidden_item_list
	if item_index <= current_item_count then
		return storage.non_hidden_item_list[item_index]
	end
	item_index = item_index - current_item_count
	if contain_hidden_items then
		current_item_count = #storage.non_creative_hidden_item_list
		if item_index <= current_item_count then
			return storage.non_creative_hidden_item_list[item_index]
		end
		item_index = item_index - current_item_count
	end
	local creative_item_count = #creative_mode_defines.values.creative_provider_chest_additional_content_names
	if item_index <= creative_item_count then
		return prototypes.item[creative_mode_defines.values.creative_provider_chest_additional_content_names[item_index]]
	end
	item_index = item_index - creative_item_count
	return storage.hidden_creative_enemy_item_list[item_index]
end

-------------------------------------------------------------------------

-- Some of the variables are under the namespace of Creative Provider Chest because it was implemented before Creative Chest.

-- Returns the usable inventory size (except the extra slot for voiding items) for creative chest and creative provider chest.
function creative_chest_util.get_creative_provider_chest_usable_inventory_size()
	return prototypes.entity[creative_mode_defines.names.entities.creative_chest].get_inventory_size(1) - 1
end

-- Returns the total number of items to be container by each creative chest or creative provider chest.
function creative_chest_util.get_creative_provider_chest_total_item_count()
	return get_total_item_count(
		settings.global[creative_mode_defines.names.settings.creative_chest_contains_hidden_items].value
	)
end

--------

-- Returns the usable inventory size (except the extra slot for voiding items) for creative cargo wagon.
function creative_chest_util.get_creative_cargo_wagon_usable_inventory_size()
	return prototypes.entity[creative_mode_defines.names.entities.creative_cargo_wagon].get_inventory_size(1) - 1
end

-- Returns the total number of items to be container by each creative cargo wagon.
function creative_chest_util.get_creative_cargo_wagon_total_item_count()
	return get_total_item_count(
		settings.global[creative_mode_defines.names.settings.creative_cargo_wagon_contains_hidden_items].value
	)
end

-------------------------------------------------------------------------

-- Updates the data used by the Creative Chest family according to the in-game item list in storage.
function creative_chest_util.update_item_lists_data()
	-- Creative chest and creative provider chest:
	-- There may be more items than the usable inventory size of each creative chest. We need to find out how many chests are needed for one cycle first.
	-- It is also the total number of item groups.
	local usable_inventory_size = creative_chest_util.get_creative_provider_chest_usable_inventory_size()
	storage.creative_mode.creative_provider_chest_num_in_cycle =
		math.ceil(creative_chest_util.get_creative_provider_chest_total_item_count() / usable_inventory_size)
	-- Chests in the same cycle are divided into groups. Let's say we have 251 items, so the first group will contain the first 250 items, and the last group will contain the last item.
	storage.creative_mode.creative_provider_chest_next_place_group = 1
	storage.creative_mode.creative_chest_next_place_group = 1
	-- For performance reason, we don't update all groups in the same tick.
	storage.creative_mode.creative_provider_chest_next_update_group = 1
	storage.creative_mode.creative_chest_next_update_group = 1
	-- And we don't update all chests in the same group.
	storage.creative_mode.creative_provider_chest_next_update_group_subindex = 1
	storage.creative_mode.creative_chest_next_update_group_subindex = 1

	-- Store the settings that can affect the number of chests per item cycle when we have calculated the above maths, so that we know we will need to calculate again if change is detected.
	storage.creative_mode.last_creative_provider_chest_size = usable_inventory_size
	storage.creative_mode.last_creative_provider_chest_contain_hidden_items =
		settings.global[creative_mode_defines.names.settings.creative_chest_contains_hidden_items].value

	-- Creative cargo wagon:
	-- Do the same as above.
	usable_inventory_size = creative_chest_util.get_creative_cargo_wagon_usable_inventory_size()
	storage.creative_mode.creative_cargo_wagon_num_in_cycle =
		math.ceil(creative_chest_util.get_creative_cargo_wagon_total_item_count() / usable_inventory_size)
	storage.creative_mode.creative_cargo_wagon_next_place_group = 1
	storage.creative_mode.creative_cargo_wagon_next_update_group = 1
	storage.creative_mode.creative_cargo_wagon_next_update_group_subindex = 1
	storage.creative_mode.last_creative_cargo_wagon_size = usable_inventory_size
	storage.creative_mode.last_creative_cargo_wagon_contain_hidden_items =
		settings.global[creative_mode_defines.names.settings.creative_cargo_wagon_contains_hidden_items].value
end

-- Validates the data used by the Creative Chest family. If needed, updates the data.
-- Returns whether the data is updated.
local function validate_or_update_data()
	if
		(storage.creative_mode.last_creative_provider_chest_size == nil or
			storage.creative_mode.last_creative_provider_chest_size ~=
				creative_chest_util.get_creative_provider_chest_usable_inventory_size() or
			storage.creative_mode.last_creative_provider_chest_contain_hidden_items == nil or
			storage.creative_mode.last_creative_provider_chest_contain_hidden_items ~=
				settings.global[creative_mode_defines.names.settings.creative_chest_contains_hidden_items].value or
			storage.creative_mode.last_creative_cargo_wagon_size == nil or
			storage.creative_mode.last_creative_cargo_wagon_size ~=
				creative_chest_util.get_creative_cargo_wagon_usable_inventory_size() or
			storage.creative_mode.last_creative_cargo_wagon_contain_hidden_items == nil or
			storage.creative_mode.last_creative_cargo_wagon_contain_hidden_items ~=
				settings.global[creative_mode_defines.names.settings.creative_cargo_wagon_contains_hidden_items].value)
	 then
		creative_chest_util.update_item_lists_data()
		return true
	end
	return false
end

-- Whether data validation has been done.
local has_validated_data = false
-- Processes the tables related to the Creative Chest family in storage.
function creative_chest_util.tick()
	-- Check whether the user has changed the settings that can affect the number of chests per item cycle. If so, update the item list and regroup the items.
	if not has_validated_data and game.tick >= 1 then
		if validate_or_update_data() then
			game.print {"message.creative-mode_creative-chest-item-group-updated"}
		end
		has_validated_data = true
	end
end

-------------------------------------------------------------------------

-- Returns the start and end item indexes among the item lists for the group of given group number.
function creative_chest_util.get_start_end_item_index_for_group(
	group_number,
	usable_inventory_size,
	contain_hidden_items)
	local start_item_index = (group_number - 1) * usable_inventory_size + 1
	local end_item_index = math.min(group_number * usable_inventory_size, get_total_item_count(contain_hidden_items))
	return start_item_index, end_item_index
end

-- Returns the inventory of the given chest.
function creative_chest_util.get_inventory(chest)
	local inventory = chest.get_output_inventory()
	if not inventory then
		inventory = chest.get_inventory(defines.inventory.cargo_wagon)
	end
	return inventory
end

-- Returns the inventory of the chest of the given chest data.
function creative_chest_util.get_inventory_from_data(chest_data)
	local chest = chest_data.entity
	local inventory = chest.get_output_inventory()
	if not inventory then
		if chest_data.is_cargo_wagon then
			inventory = chest.get_inventory(defines.inventory.cargo_wagon)
		end
	end
	return inventory
end

-- Refills the inventories of some Creative Chests according to the given chest groups, group index to be updated, and the subindex of chest to be updated.
-- Returns the updated group index and subindex.
function creative_chest_util.refill_chests(
	chest_data_groups,
	next_update_group,
	next_update_group_subindex,
	contain_hidden_items)
	-- Looping through the huge item list can be a heavy task, therefore we divided the task by groups and chests.
	-- Only the group of the current group number has to be updated.
	if chest_data_groups[next_update_group] then
		local start_item_index = nil
		local end_item_index = nil
		-- Not even that, we also update only one chest in each tick.
		local data = chest_data_groups[next_update_group][next_update_group_subindex]
		if data then
			local chest = data.entity
			if chest.valid then
				if not chest.to_be_deconstructed(chest.force) then
					local inventory = creative_chest_util.get_inventory_from_data(data)
					local slot = 1
					local displayed_slot = 1
					local display_mode = data.inventory_display_mode
					local inventory_size = #inventory
					local filtered_slots = data.filtered_slots
					local filtered_slots_count = #filtered_slots
					local next_filtered_slot_to_check = 1
					if filtered_slots_count <= 0 then
						next_filtered_slot_to_check = 0
					end
					if start_item_index == nil or end_item_index == nil then
						start_item_index, end_item_index =
							creative_chest_util.get_start_end_item_index_for_group(
							next_update_group,
							inventory_size - 1,
							contain_hidden_items
						)
					end
					-- Refill its inventory with items.
					for i = start_item_index, end_item_index, 1 do
						-- Fill the slot only if it is not filtered out.
						if next_filtered_slot_to_check <= 0 or filtered_slots[next_filtered_slot_to_check] ~= slot then
							local item = creative_chest_util.get_item_at(i, contain_hidden_items)
							inventory[displayed_slot].set_stack {name = item.name, count = item.stack_size}
							displayed_slot = displayed_slot + 1
						else
							-- Clear the slot. Only Original Display Mode will create holes in between.
							if display_mode == creative_chest_util.inventory_display_modes.original_mode then
								inventory[displayed_slot].clear()
								displayed_slot = displayed_slot + 1
							end
							-- Check for the next index of filtered slot if possible.
							if filtered_slots_count >= next_filtered_slot_to_check + 1 then
								next_filtered_slot_to_check = next_filtered_slot_to_check + 1
							else
								next_filtered_slot_to_check = 0
							end
						end
						-- Next slot.
						slot = slot + 1
						-- Though it is unlikely to happen... (caused by mod version change?) Break the loop if slot exceeds.
						if slot > inventory_size then
							break
						end
					end
					-- Clear the remaining slots.
					for i = displayed_slot, inventory_size, 1 do
						inventory[i].clear()
					end
				end
			else
				table.remove(chest_data_groups[next_update_group], next_update_group_subindex)
			end
		else
			table.remove(chest_data_groups[next_update_group], next_update_group_subindex)
		end
	end
	-- Prepare the subindex for the next chest in the same group.
	if chest_data_groups[next_update_group] and next_update_group_subindex < #chest_data_groups[next_update_group] then
		next_update_group_subindex = next_update_group_subindex + 1
	else
		-- Next group.
		next_update_group_subindex = 1
		if next_update_group < #chest_data_groups then
			next_update_group = next_update_group + 1
		else
			next_update_group = 1
		end
	end

	return next_update_group, next_update_group_subindex
end

-- Returns true if the entity is one of the new style of creative chest, which are handled differently.
function creative_chest_util.is_new_creative(entity)
    if entity.name == creative_mode_defines.names.entities.new_creative_chest or
        entity.name == creative_mode_defines.names.entities.new_creative_provider_chest then
        return true
    end
    return false
end

-- Sets the infinity chest filters to the appropriate items based on the chests group.
function creative_chest_util.set_chest_filter(data)
    if data then
        local chest = data.entity
        if chest.valid then
            if not chest.to_be_deconstructed(chest.force) then
                local inventory = creative_chest_util.get_inventory_from_data(data)
                local slot = 1
                local displayed_slot = 1
                local display_mode = data.inventory_display_mode
                local inventory_size = #inventory
                local filtered_slots = data.filtered_slots
                local filtered_slots_count = #filtered_slots
                local next_filtered_slot_to_check = 1
                local contain_hidden_items = storage.creative_mode.last_creative_provider_chest_contain_hidden_items
                if filtered_slots_count <= 0 then
                    next_filtered_slot_to_check = 0
                end
                local start_item_index, end_item_index =
                        creative_chest_util.get_start_end_item_index_for_group(
                        data.group,
                        inventory_size - 1,
                        contain_hidden_items
                    )
                -- Clear the current filters so we can set them
                chest.infinity_container_filters = {}
                for i = start_item_index, end_item_index, 1 do
                    -- Fill the slot only if it is not filtered out.
                    if next_filtered_slot_to_check <= 0 or filtered_slots[next_filtered_slot_to_check] ~= slot then
                        local item = creative_chest_util.get_item_at(i, contain_hidden_items)
                        -- Set the infinity container's filter slot to be the given item
                        chest.set_infinity_container_filter(displayed_slot,{name = item.name, count = item.stack_size, mode = "exactly"})
                        displayed_slot = displayed_slot + 1
                    else
                        -- Skip the filter slot if using original mode - leaves a hole in the filters to make it obvious an item was skipped.
                        if display_mode == creative_chest_util.inventory_display_modes.original_mode then
                            displayed_slot = displayed_slot + 1
                        end
                        -- Check for the next index of filtered slot if possible.
                        if filtered_slots_count >= next_filtered_slot_to_check + 1 then
                            next_filtered_slot_to_check = next_filtered_slot_to_check + 1
                        else
                            next_filtered_slot_to_check = 0
                        end
                    end
                    -- Next slot.
                    slot = slot + 1
                    -- Though it is unlikely to happen... (caused by mod version change?) Break the loop if slot exceeds.
                    if slot > inventory_size then
                        break
                    end
                end
            end
        else
            -- This shouldn't happen anymore as this only fires when the chest is placed or the GUI is changed, neither of which should be able to happen on a chest that isn't valid.
        end
    end
end

-- Returns the responsible creative chest data groups for the given entity.
-- Also returns the number of chests for each item cycle (i.e. max group number) and whether the entity should contain hidden items.
function creative_chest_util.get_creative_chest_data_groups(entity)
	if entity.name == creative_mode_defines.names.entities.creative_chest then
		return storage.creative_mode.creative_chest_data_groups, storage.creative_mode.creative_provider_chest_num_in_cycle, storage.creative_mode.last_creative_provider_chest_contain_hidden_items
	elseif entity.name == creative_mode_defines.names.entities.creative_provider_chest then
		return storage.creative_mode.creative_provider_chest_data_groups, storage.creative_mode.creative_provider_chest_num_in_cycle, storage.creative_mode.last_creative_provider_chest_contain_hidden_items
	elseif entity.name == creative_mode_defines.names.entities.new_creative_chest then
		return storage.creative_mode.new_creative_chests, storage.creative_mode.creative_provider_chest_num_in_cycle, storage.creative_mode.last_creative_provider_chest_contain_hidden_items
	elseif entity.name == creative_mode_defines.names.entities.new_creative_provider_chest then
		return storage.creative_mode.new_creative_provider_chests, storage.creative_mode.creative_provider_chest_num_in_cycle, storage.creative_mode.last_creative_provider_chest_contain_hidden_items
	elseif entity.name == creative_mode_defines.names.entities.creative_cargo_wagon then
		return storage.creative_mode.creative_cargo_wagon_data_groups, storage.creative_mode.creative_cargo_wagon_num_in_cycle, storage.creative_mode.last_creative_cargo_wagon_contain_hidden_items
	end
	return nil, 0, false
end

-- Returns the data and group number of the given Creative Chest. Also returns the index of the chest in that group as the second parameter.
-- If the given entity is not found in any group (maybe caused by error), 0, 0 will be returned.
function creative_chest_util.get_creative_chest_data_group_number(entity, chest_data_groups)
    -- The new creative chests and new creative provider chests are stored differently.
    if creative_chest_util.is_new_creative(entity) then
        for chest_index_in_group, chest_data_in_group in ipairs(chest_data_groups) do
            if chest_data_in_group.entity == entity then
                return chest_data_in_group, chest_data_in_group.group, chest_index_in_group
            end
        end
        return nil, 0, 0
    end
	if chest_data_groups then
		for group_index = 1, #chest_data_groups, 1 do
			local group = chest_data_groups[group_index]
			if group then
				for chest_index_in_group, chest_data_in_group in ipairs(chest_data_groups[group_index]) do
					if chest_data_in_group.entity == entity then
						return chest_data_in_group, group_index, chest_index_in_group
					end
				end
			end
		end
	end
	return nil, 0, 0
end

-- Moves the destination chest to the group with same group number of the source chest when copy-paste is done on Creative Chest family.
-- Also copies the filtered slots and inventory display mode from the source chest to the destination chest.
function creative_chest_util.on_entity_copied_pasted(source_chest, destination_chest)
	local source_groups = creative_chest_util.get_creative_chest_data_groups(source_chest)
	local destination_groups = creative_chest_util.get_creative_chest_data_groups(destination_chest)

	local source_chest_data, source_group_number =
		creative_chest_util.get_creative_chest_data_group_number(source_chest, source_groups)
	if source_chest_data == nil or source_group_number == 0 then
		return
	end
	local destination_chest_data, destination_group_number, destination_index_in_group =
		creative_chest_util.get_creative_chest_data_group_number(destination_chest, destination_groups)
	if destination_chest_data == nil or destination_group_number == 0 then
		return
	end
	-- Copy the table of filtered slots from the source chest to the destination chest.
	destination_chest_data.filtered_slots = table.deepcopy(source_chest_data.filtered_slots)
	-- Copy inventory display mode.
	destination_chest_data.inventory_display_mode = source_chest_data.inventory_display_mode
	-- Move the destination chest from its original group to the group with the same group number of the source chest.
	if source_group_number ~= destination_group_number then
		table.remove(destination_groups[destination_group_number], destination_index_in_group)
		-- But it should still be inside the original groups table. (One table for non-logistic, one for logistic)
		if not destination_groups[source_group_number] then
			destination_groups[source_group_number] = {}
		end
		table.insert(destination_groups[source_group_number], destination_chest_data)
	end
end

-- Changes the group number of the given creative chest data from the old one to new one.
-- Returns whether it is successfully changed.
function creative_chest_util.change_creative_chest_group_number(
	chest_data,
	chest_groups,
	old_group_number,
	old_index_in_group,
	new_group_number,
    entity)
	if old_group_number ~= new_group_number then
        -- Once again new providers are handled differently
        if creative_chest_util.is_new_creative(entity) then
            chest_data.group = new_group_number
            creative_chest_util.set_chest_filter(chest_data)
            return true
        else
            table.remove(chest_groups[old_group_number], old_index_in_group)
            if not chest_groups[new_group_number] then
                chest_groups[new_group_number] = {}
            end
            table.insert(chest_groups[new_group_number], chest_data)
            return true
        end
	end
	return false
end
