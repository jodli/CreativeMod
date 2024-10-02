-- This file contains variables or functions that are common for our item provider entities and specific for this mod.
if not item_providers_util then
    item_providers_util = {}
end

-- Possible operation modes. Used by the ouput_or_remove_item functions.
output_or_remove_item_operation_mode = {
    output_mode = 1,
    remove_mode = 2,
    duplicate_mode = 3
}

-- Possible types of item containers.
static_item_container_type = {
    unknown = 1,
    crafting_machine = 2,
    lab = 3
}

-- Possible transport belt type to work on. Used by the ouput_or_remove_item functions.
local output_or_remove_item_transport_belt_type = {
    transport_belt = 0,
    underground_belt_input = 1,
    underground_belt_output = 2,
    splitter = 3
}

-- Non-movable entity types with at least one inventory that matter source, matter void and duplicator can work on.
local static_item_containers = {
    ["container"] = true,
    ["logistic-container"] = true,
    ["assembling-machine"] = true,
    ["lab"] = true,
    ["boiler"] = true,
    ["furnace"] = true,
    ["roboport"] = true,
    ["rocket-silo"] = true,
    ["turret"] = true,
    ["ammo-turret"] = true,
    ["electric-turret"] = true,
    ["fluid-turret"] = true,
    ["beacon"] = true,
    ["reactor"] = true
}
-- Non-movable entity types with output slots that matter void should only work on their output slots when it has no filter.
local static_item_containers_with_output_slots = {
    ["assembling-machine"] = defines.inventory.assembling_machine_output,
    ["furnace"] = defines.inventory.furnace_result,
    ["reactor"] = defines.inventory.burnt_result
}

-- Non-movable entity types with at least one fluidbox that matter void and duplicator can work on.
-- Known issue: assembling machine and mining drill have inventory. Our current logic does not support inventory + fluidbox at the same time.
local static_fluidboxes = {
    ["pipe"] = true,
    ["storage-tank"] = true,
    ["assembling-machine"] = true,
    ["boiler"] = true,
    ["furnace"] = true,
    ["generator"] = true,
    ["fluid-turret"] = true,
    ["pump"] = true,
    ["mining-drill"] = true
}

-- List of module inventories that matter source, duplicator and void shouldn't work on.
local module_inventories = {
    [defines.inventory.furnace_modules] = true,
    [defines.inventory.assembling_machine_modules] = true,
    [defines.inventory.lab_modules] = true,
    [defines.inventory.mining_drill_modules] = true,
    [defines.inventory.beacon_modules] = true
}

-- Duplicates the first itme in the given inventory.
local function duplicate_first_item_in_inventory(inventory, filter_item_name)
    if inventory.is_empty() then
        return
    end

    local item_name = nil
    -- If filter is set, there must be at least one of that item in the inventory.
    if filter_item_name then
        if inventory.get_item_count(filter_item_name) > 0 then
            item_name = filter_item_name
        end
    else
        item_name = next(inventory.get_contents())
    end
    if item_name then
        local stack = {
            name = item_name,
            count = 1
        }
        inventory.insert(stack)
    end
end

-- Duplicates the first item in each inventory of the given entity.
-- Returns the table of inventories that the given entity has if required, also returns the container type of the entity.
local function duplicate_first_item_in_each_inventory(entity, filter_item_name, entity_inventories,
    should_return_entity_inventories)
    -- If the entity has nothing inside, do nothing.
    if not entity.has_items_inside() then
        return entity_inventories
    end

    -- If we have already known the inventories, just loop through it.
    if entity_inventories then
        for _, inv in ipairs(entity_inventories) do
            local inventory = entity.get_inventory(inv)
            if inventory then
                duplicate_first_item_in_inventory(inventory, filter_item_name)
            end
        end
        return entity_inventories
    end

    -- We have not known the inventories yet. Find the inventories while removing items.
    if should_return_entity_inventories then
        entity_inventories = {}
    end
    for _, inv in pairs(defines.inventory) do
        local inventory = entity.get_inventory(inv)
        if inventory then
            if should_return_entity_inventories then
                table.insert(entity_inventories, inv)
            end
            duplicate_first_item_in_inventory(inventory, filter_item_name)
        end
    end
    return entity_inventories
end

-- Removes one item from the given inventory.
local function remove_one_item_from_inventory(inventory, filter_item_name)
    if inventory.is_empty() then
        return
    end

    local item_name = nil
    -- If filter is set, there must be at least one of that item in the inventory.
    if filter_item_name then
        if inventory.get_item_count(filter_item_name) > 0 then
            item_name = filter_item_name
        end
    else
        item_name = next(inventory.get_contents())
    end
    if item_name then
        local stack = {
            name = item_name,
            count = 1
        }
        inventory.remove(stack)
    end
end

-- Removes one item from an inventory of the given entity.
-- Returns the table of inventories that the given entity has if required.
local function remove_one_item_in_entity(entity, filter_item_name, entity_inventories, should_return_entity_inventories)
    -- If the entity has nothing inside, do nothing.
    if not entity.has_items_inside() then
        return entity_inventories
    end

    -- If we have already known the inventories, just loop through it.
    if entity_inventories then
        for _, inv in ipairs(entity_inventories) do
            local inventory = entity.get_inventory(inv)
            if inventory then
                remove_one_item_from_inventory(inventory, filter_item_name)
            end
        end
        return entity_inventories
    end

    -- We have not known the inventories yet. Find the inventories while removing items.
    if should_return_entity_inventories then
        entity_inventories = {}
    end
    for _, inv in pairs(defines.inventory) do
        local inventory = entity.get_inventory(inv)
        if inventory then
            if should_return_entity_inventories then
                table.insert(entity_inventories, inv)
            end
            remove_one_item_from_inventory(inventory, filter_item_name)
        end
    end
    return entity_inventories
end

-- Outputs item stacks according to the filters in the given inventory.
local function output_item_stack_according_to_inventory_slot_filters(inventory)
    for i = 1, #inventory, 1 do
        -- Check if the slot can set filter. If it cannot set filter, get_filter will cause error.
        if inventory.can_set_filter(i, "iron-plate") then
            local filter = inventory.get_filter(i)
            if filter then
                inventory[i].set_stack {
                    name = filter,
                    count = prototypes.item[filter].stack_size
                }
            end
        end
    end
end

-- Outputs item stacks according to the filters on the slots of the given entity.
-- Returns the table of inventories that the given entity has if required.
local function output_item_stack_according_to_inventories_slot_filters(entity, entity_inventories,
    should_return_entity_inventories)
    -- If we have already known the inventories, just loop through it.
    if entity_inventories then
        for _, inv in ipairs(entity_inventories) do
            local inventory = entity.get_inventory(inv)
            if inventory then
                output_item_stack_according_to_inventory_slot_filters(inventory)
            end
        end
        return entity_inventories
    end

    -- We have not known the inventories yet. Find the inventories while outputing items.
    if should_return_entity_inventories then
        entity_inventories = {}
    end
    for _, inv in pairs(defines.inventory) do
        if not module_inventories[inv] then
            local inventory = entity.get_inventory(inv)
            if inventory then
                if should_return_entity_inventories then
                    table.insert(entity_inventories, inv)
                end
                output_item_stack_according_to_inventory_slot_filters(inventory)
            end
        end
    end
    return entity_inventories
end

-- Inserts the given item stack on the given transport line of given transport belt entity according to the current position of the last inserted item.
local function insert_itemstack_on_transport_line_compressed(transport_line, item_stack, belt_speed, last_item_position)
    local insert_position
    repeat
        if last_item_position then
            insert_position = last_item_position + transport_belt_item_distance
            if insert_position > 1 then
                -- It is outside the belt, of course the item cannot be inserted.
                -- Wait until the last item is moved far enough.
                return last_item_position - belt_speed
            end
        else
            insert_position = 1 - transport_belt_item_distance * 0.5
        end
        -- Try to insert the item at the given position.
        if transport_line.insert_at(insert_position, item_stack) then
            -- Succeeded. Remember the item position, and maybe we can insert more items at the current tick?
            last_item_position = insert_position
        else
            -- Failed to insert the item in this tick. Just wait for the next tick.
            if last_item_position then
                if last_item_position < 1 - transport_belt_item_distance then
                    -- But it doesn't make sense that we can't insert a new item even if the last item has been moved beyond item distance.
                    -- The only answer is: the belt is full!
                    return nil
                else
                    -- The last item will be moved by belt speed.
                    return last_item_position - belt_speed
                end
            else
                -- It can't even insert the item at 1. Maybe the line is stopped.
                return nil
            end
        end
    until false
end

-- Removes the first item on the given transport line.
local function remove_first_item_on_transport_line(line, filter_item_name)
    -- Only do action if the line is full at the end (position = 0).
    if line.can_insert_at(0) and line.can_insert_at(0.1) then
        return
    end
    -- And only if there is item.
    if #line <= 0 then
        return
    end
    -- Check the first item.
    local item_name = line[1].name
    -- If filter is set, but the item mismatch, stop working.
    if filter_item_name and filter_item_name ~= item_name then
        return
    end
    -- Remove the item.
    local stack = {
        name = item_name,
        count = 1
    }
    line.remove_item(stack)
end

-- Outputs the given item stack or remove items on the given transport line.
-- Returns the position of the last item inserted to the line.
local function output_or_remove_item_on_transport_line(transport_line, belt_speed, operation_mode, output_stack,
    filter_item_name, should_use_insert_at_back, output_last_item_position_on_belt)
    if operation_mode == output_or_remove_item_operation_mode.output_mode then
        -- matter-source
        if should_use_insert_at_back then
            -- If only insert_at_back can be used, simply use it!
            transport_line.insert_at_back(output_stack)
            return nil
        else
            if belt_speed > transport_belt_item_distance * 0.5 then
                -- The belt is too fast that it needs our custom implementation to guarantee compressed belt.
                -- Try to insert the item as near as the last item.
                return insert_itemstack_on_transport_line_compressed(transport_line, output_stack, belt_speed,
                           output_last_item_position_on_belt)
            else
                -- The belt is not fast. It is OK to simply use insert_at(position, items) because it supports minimal shifting on the position in case that position is occupied.
                transport_line.insert_at(1 - transport_belt_item_distance * 0.5, output_stack)
                return nil
            end
        end
    elseif operation_mode == output_or_remove_item_operation_mode.remove_mode then
        -- matter-void
        remove_first_item_on_transport_line(transport_line, filter_item_name)
        return nil
    else
        -- matter-duplicator
        local item
        if filter_item_name then
            if transport_line.get_item_count(filter_item_name) > 0 then
                item = filter_item_name
            end
        else
            item = next(transport_line.get_contents())
        end
        if item == nil then
            return nil
        else
            local stack = {
                name = item,
                count = 1
            }
            if should_use_insert_at_back then
                -- If only insert_at_back can be used, simply use it!
                transport_line.insert_at_back(stack)
                return nil
            else
                return insert_itemstack_on_transport_line_compressed(transport_line, stack, belt_speed,
                           output_last_item_position_on_belt)
            end
        end
    end
end

-- Verifies the last working transport belt, container or fluidbox entity according to the given matter source data, matter void data or duplicator data.
-- If the entity fails to be verified, it will be set to nil.
-- Returns the belt and belt type if it is valid. If the belt is not valid, the container will be returned as the third output. Otherwise, the fluidbox will be returned as the forth output.
local function verify_and_get_last_working_transport_belt_or_container_or_fluidbox(entity_data)
    local is_entity_direction_same = entity_data.last_direction == entity_data.entity.direction

    -- Is any belt cached?
    if entity_data.last_working_transport_belt ~= nil then
        -- Is the belt valid?
        if entity_data.last_working_transport_belt.valid then
            -- Is the matter source, matter void or matter duplicator still facing the same direction when the belt is cached?
            if is_entity_direction_same then
                -- Congratulations.
                entity_data.last_working_static_container = nil
                entity_data.last_working_static_fluidbox = nil
                return entity_data.last_working_transport_belt, entity_data.last_working_transport_belt_type, nil, nil
            else
                -- Nope.
                entity_data.last_direction = entity_data.entity.direction
                entity_data.last_working_transport_belt = nil
            end
        else
            entity_data.last_working_transport_belt = nil
        end
    end

    -- Is any container cached?
    if entity_data.last_working_static_container ~= nil then
        -- Is the container valid?
        if entity_data.last_working_static_container.valid then
            -- Is the matter source, matter void or matter duplicator still facing the same direction when the container is cached?
            if is_entity_direction_same then
                -- Congratulations.
                entity_data.last_working_static_fluidbox = nil
                return nil, nil, entity_data.last_working_static_container, nil
            else
                -- Nope.
                entity_data.last_direction = entity_data.entity.direction
                entity_data.last_working_static_container = nil
            end
        else
            entity_data.last_working_static_container = nil
        end
    end

    -- Is any fluidbox cached?
    if entity_data.last_working_static_fluidbox ~= nil then
        -- Is the fluidbox valid?
        if entity_data.last_working_static_fluidbox.valid then
            -- Is the matter source, matter void or matter duplicator still facing the same direction when the container is cached?
            if is_entity_direction_same then
                -- Congratulations.
                entity_data.last_working_static_fluidbox = nil
                return nil, nil, nil, entity_data.last_working_static_fluidbox
            else
                -- Nope.
                entity_data.last_direction = entity_data.entity.direction
                entity_data.last_working_static_fluidbox = nil
            end
        else
            entity_data.last_working_static_fluidbox = nil
        end
    end
    return nil, nil, nil, nil
end

-- Outputs the item of given name at the given position or remove the items there.
-- For matter-source, matter-void and matter-duplicator, because they are inserters, their opposite directions should be given instead.
function item_providers_util.output_or_remove_item(surface, position, shift_x, shift_y, direction, filter_item_name,
    operation_mode, output_item_slot, entity_data)
    -- Create a simple item stack according to the given item name of we are going to output it.
    local output_stack = nil
    if operation_mode == output_or_remove_item_operation_mode.output_mode and filter_item_name then
        output_stack = {
            name = filter_item_name,
            count = 1
        }
    end
    -- Add the offset to the position to get the actual one.
    local actual_position = {
        x = position.x + shift_x,
        y = position.y + shift_y
    }
    -- Store the entities to insert items to or remove items from them with different priorities.
    local other_inventory_entity = nil
    local other_fluidbox_entity = nil
    local train_entity = nil
    local fluid_wagon_entity = nil
    -- There may be multiple cars and players in front of it, so we will use table to store them.
    local car_entities = nil
    local player_entities = nil
    -- Whether the item should be dropped on ground as the last resort.
    local drop_on_ground = operation_mode == output_or_remove_item_operation_mode.output_mode and output_stack and
                               entity_data.can_drop_on_ground
    -- Whether the items on ground should be removed.
    local remove_from_ground = operation_mode == output_or_remove_item_operation_mode.remove_mode and
                                   entity_data.can_remove_from_ground

    -- Reset item_source's table of players being inserted with item.
    local last_player_entities
    if operation_mode == output_or_remove_item_operation_mode.output_mode then
        if output_item_slot == 1 then
            last_player_entities = entity_data.slot1_inserted_players
            entity_data.slot1_inserted_players = nil
        elseif output_item_slot == 2 then
            last_player_entities = entity_data.slot2_inserted_players
            entity_data.slot2_inserted_players = nil
        end
    end

    -- Do we have a valid cache of transport belt that is still working in this tick?
    local transport_belt_entity, transport_belt_type, static_container_entity, static_fluidbox_entity =
        verify_and_get_last_working_transport_belt_or_container_or_fluidbox(entity_data)
    if static_container_entity ~= nil then
        other_inventory_entity = static_container_entity
    elseif static_fluidbox_entity ~= nil then
        other_fluidbox_entity = static_fluidbox_entity
    end

    -- We will need to search for working entity if nothing is cached.
    if transport_belt_entity == nil and other_inventory_entity == nil and other_fluidbox_entity == nil then
        -- Check if there is any entity in the grid at the given position.
        for _, entity in ipairs(surface.find_entities_filtered {
            position = actual_position,
            force = entity_data.entity.force
        }) do
            if entity.type == "transport-belt" then
                -- Transport belt.
                transport_belt_entity = entity
                transport_belt_type = output_or_remove_item_transport_belt_type.transport_belt
                -- No need to check for another entity.
                break
            elseif entity.type == "underground-belt" then
                -- Underground belt.
                transport_belt_entity = entity
                if entity.belt_to_ground_type == "output" then
                    transport_belt_type = output_or_remove_item_transport_belt_type.underground_belt_output
                else
                    transport_belt_type = output_or_remove_item_transport_belt_type.underground_belt_input
                end
                -- No need to check for another entity.
                break
            elseif entity.type == "splitter" then
                -- Splitter.
                transport_belt_entity = entity
                transport_belt_type = output_or_remove_item_transport_belt_type.splitter
                -- No need to check for another entity.
                break
            elseif entity.type == "locomotive" or entity.type == "cargo-wagon" then
                -- The entity is a train.
                train_entity = entity
            elseif entity.type == "fluid-wagon" then
                -- The entity is a fluid wagon.
                fluid_wagon_entity = entity
            elseif entity.type == "car" then
                -- The entity is a car.
                if not car_entities then
                    car_entities = {}
                end
                table.insert(car_entities, entity)
            elseif entity.type == "character" then
                -- The entity is a player.
                if not player_entities then
                    player_entities = {}
                end
                table.insert(player_entities, entity)
            else
                -- For other entity types, we have to check whether they are collidable and have inventory so that unwanted entities like particles are ignored.
                local collision_mask = entity.prototype.collision_mask
                -- Note: known issue - collision_mask is nil for rocket-silo-rocket, even though it contains "not-colliding-with-itself". Hopefully it will be fixed.
                if not collision_mask or not util.array_contains_val(collision_mask, "not-colliding-with-itself") then
                    if util.has_inventory(entity) then
                        -- Ignore construction robots and logistic robots. They are innocent.
                        if entity.type ~= "construction-robot" and entity.type ~= "logistic-robot" and entity.type ~=
                            "rocket-silo-rocket" then
                            other_inventory_entity = entity
                        end
                    else
                        if operation_mode == output_or_remove_item_operation_mode.remove_mode or operation_mode ==
                            output_or_remove_item_operation_mode.duplicate_mode then
                            -- Matter Void can also remove fluids, Matter Duplicator can also duplicate fluids.
                            if util.has_fluidbox(entity) then
                                other_fluidbox_entity = entity
                            end
                        end
                    end
                end
            end
        end
    end

    -- Work on transport belt.
    if transport_belt_entity ~= nil then
        -- Don't work on transport belt if it is matter source and with no filter is set.
        if operation_mode ~= output_or_remove_item_operation_mode.output_mode or output_item_slot ~= 0 then
            -- Cache it first.
            entity_data.last_working_transport_belt = transport_belt_entity
            entity_data.last_working_transport_belt_type = transport_belt_type
            -- Since we have a transport belt now, no container or fluidbox can be worked on.
            entity_data.last_working_static_container = nil
            entity_data.last_working_static_fluidbox = nil

            -- Now we need to check which transport line we should work on.
            -- First, find out what type of belt it is.
            local is_belt = transport_belt_type == output_or_remove_item_transport_belt_type.transport_belt
            local is_underground_belt = transport_belt_type ==
                                            output_or_remove_item_transport_belt_type.underground_belt_input or
                                            transport_belt_type ==
                                            output_or_remove_item_transport_belt_type.underground_belt_output
            local is_output_underground_belt = transport_belt_type ==
                                                   output_or_remove_item_transport_belt_type.underground_belt_output
            local is_splitter = transport_belt_type == output_or_remove_item_transport_belt_type.splitter
            local affected_line_num_1 = nil
            local affected_line_num_2 = nil
            -- Splitters and underground belts only support insert-at-back.
            local should_use_insert_at_back = false
            if transport_belt_entity.direction == direction then
                -- The belt is of opposite direction, i.e. perfect for matter-source, matter-void and matter-duplicator.
                if is_splitter then
                    -- For splitter, the line may be a little bit tricky.
                    should_use_insert_at_back = true
                    if transport_belt_entity.direction == defines.direction.north then
                        -- To north.
                        if transport_belt_entity.position.x < position.x then
                            if operation_mode == output_or_remove_item_operation_mode.output_mode then
                                -- Matter source can only affect one line at a time.
                                if output_item_slot == 1 then
                                    affected_line_num_1 = defines.transport_line.secondary_left_line
                                else
                                    affected_line_num_1 = defines.transport_line.secondary_right_line
                                end
                            elseif operation_mode == output_or_remove_item_operation_mode.remove_mode then
                                affected_line_num_1 = defines.transport_line.secondary_left_split_line
                                affected_line_num_2 = defines.transport_line.secondary_right_split_line
                            else
                                affected_line_num_1 = defines.transport_line.secondary_left_line
                                affected_line_num_2 = defines.transport_line.secondary_right_line
                            end
                        else
                            if operation_mode == output_or_remove_item_operation_mode.output_mode then
                                if output_item_slot == 1 then
                                    affected_line_num_1 = defines.transport_line.left_line
                                else
                                    affected_line_num_1 = defines.transport_line.right_line
                                end
                            elseif operation_mode == output_or_remove_item_operation_mode.remove_mode then
                                affected_line_num_1 = defines.transport_line.left_split_line
                                affected_line_num_2 = defines.transport_line.right_split_line
                            else
                                affected_line_num_1 = defines.transport_line.left_line
                                affected_line_num_2 = defines.transport_line.right_line
                            end
                        end
                    elseif transport_belt_entity.direction == defines.direction.east then
                        -- To east.
                        if transport_belt_entity.position.y < position.y then
                            if operation_mode == output_or_remove_item_operation_mode.output_mode then
                                if output_item_slot == 1 then
                                    affected_line_num_1 = defines.transport_line.secondary_left_line
                                else
                                    affected_line_num_1 = defines.transport_line.secondary_right_line
                                end
                            elseif operation_mode == output_or_remove_item_operation_mode.remove_mode then
                                affected_line_num_1 = defines.transport_line.secondary_left_split_line
                                affected_line_num_2 = defines.transport_line.secondary_right_split_line
                            else
                                affected_line_num_1 = defines.transport_line.secondary_left_line
                                affected_line_num_2 = defines.transport_line.secondary_right_line
                            end
                        else
                            if operation_mode == output_or_remove_item_operation_mode.output_mode then
                                if output_item_slot == 1 then
                                    affected_line_num_1 = defines.transport_line.left_line
                                else
                                    affected_line_num_1 = defines.transport_line.right_line
                                end
                            elseif operation_mode == output_or_remove_item_operation_mode.remove_mode then
                                affected_line_num_1 = defines.transport_line.left_split_line
                                affected_line_num_2 = defines.transport_line.right_split_line
                            else
                                affected_line_num_1 = defines.transport_line.left_line
                                affected_line_num_2 = defines.transport_line.right_line
                            end
                        end
                    elseif transport_belt_entity.direction == defines.direction.south then
                        -- To south.
                        if transport_belt_entity.position.x > position.x then
                            if operation_mode == output_or_remove_item_operation_mode.output_mode then
                                if output_item_slot == 1 then
                                    affected_line_num_1 = defines.transport_line.secondary_left_line
                                else
                                    affected_line_num_1 = defines.transport_line.secondary_right_line
                                end
                            elseif operation_mode == output_or_remove_item_operation_mode.remove_mode then
                                affected_line_num_1 = defines.transport_line.secondary_left_split_line
                                affected_line_num_2 = defines.transport_line.secondary_right_split_line
                            else
                                affected_line_num_1 = defines.transport_line.secondary_left_line
                                affected_line_num_2 = defines.transport_line.secondary_right_line
                            end
                        else
                            if operation_mode == output_or_remove_item_operation_mode.output_mode then
                                if output_item_slot == 1 then
                                    affected_line_num_1 = defines.transport_line.left_line
                                else
                                    affected_line_num_1 = defines.transport_line.right_line
                                end
                            elseif operation_mode == output_or_remove_item_operation_mode.remove_mode then
                                affected_line_num_1 = defines.transport_line.left_split_line
                                affected_line_num_2 = defines.transport_line.right_split_line
                            else
                                affected_line_num_1 = defines.transport_line.left_line
                                affected_line_num_2 = defines.transport_line.right_line
                            end
                        end
                    else
                        -- To west.
                        if transport_belt_entity.position.y > position.y then
                            if operation_mode == output_or_remove_item_operation_mode.output_mode then
                                if output_item_slot == 1 then
                                    affected_line_num_1 = defines.transport_line.secondary_left_line
                                else
                                    affected_line_num_1 = defines.transport_line.secondary_right_line
                                end
                            elseif operation_mode == output_or_remove_item_operation_mode.remove_mode then
                                affected_line_num_1 = defines.transport_line.secondary_left_split_line
                                affected_line_num_2 = defines.transport_line.secondary_right_split_line
                            else
                                affected_line_num_1 = defines.transport_line.secondary_left_line
                                affected_line_num_2 = defines.transport_line.secondary_right_line
                            end
                        else
                            if operation_mode == output_or_remove_item_operation_mode.output_mode then
                                if output_item_slot == 1 then
                                    affected_line_num_1 = defines.transport_line.left_line
                                else
                                    affected_line_num_1 = defines.transport_line.right_line
                                end
                            elseif operation_mode == output_or_remove_item_operation_mode.remove_mode then
                                affected_line_num_1 = defines.transport_line.left_split_line
                                affected_line_num_2 = defines.transport_line.right_split_line
                            else
                                affected_line_num_1 = defines.transport_line.left_line
                                affected_line_num_2 = defines.transport_line.right_line
                            end
                        end
                    end
                elseif is_underground_belt then
                    -- Underground belt.
                    should_use_insert_at_back = true
                    if operation_mode == output_or_remove_item_operation_mode.output_mode then
                        -- matter-source. The belt has to be input.
                        if not is_output_underground_belt then
                            if output_item_slot == 1 then
                                affected_line_num_1 = defines.transport_line.left_line
                            else
                                affected_line_num_1 = defines.transport_line.right_line
                            end
                        end
                    elseif operation_mode == output_or_remove_item_operation_mode.remove_mode then
                        -- matter-void. The belt has to be output.
                        if is_output_underground_belt then
                            affected_line_num_1 = defines.transport_line.left_line
                            affected_line_num_2 = defines.transport_line.right_line
                        end
                    else
                        -- matter-duplicator. The belt has to be input.
                        if not is_output_underground_belt then
                            affected_line_num_1 = defines.transport_line.left_line
                            affected_line_num_2 = defines.transport_line.right_line
                        end
                    end
                else
                    -- Belt.
                    if operation_mode == output_or_remove_item_operation_mode.output_mode then
                        if output_item_slot == 1 then
                            affected_line_num_1 = defines.transport_line.left_line
                        else
                            affected_line_num_1 = defines.transport_line.right_line
                        end
                    else
                        affected_line_num_1 = defines.transport_line.left_line
                        affected_line_num_2 = defines.transport_line.right_line
                    end
                end
            else
                -- Check for other direction.
                -- For matter-void, the direction is opposite.
                if operation_mode == output_or_remove_item_operation_mode.remove_mode then
                    direction = util.oppositedirection(direction)
                end

                -- Since the direction is not perfect, only one line can be affected.
                if direction == defines.direction.north then
                    if transport_belt_entity.direction == defines.direction.east then
                        if is_splitter then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.secondary_right_split_line
                        elseif is_underground_belt then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.right_line
                        else
                            affected_line_num_1 = defines.transport_line.right_line
                        end
                    elseif transport_belt_entity.direction == defines.direction.west then
                        if is_splitter then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.left_split_line
                        elseif is_underground_belt then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.left_line
                        else
                            affected_line_num_1 = defines.transport_line.left_line
                        end
                    end
                elseif direction == defines.direction.east then
                    if transport_belt_entity.direction == defines.direction.north then
                        if is_splitter then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.left_split_line
                        elseif is_underground_belt then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.left_line
                        else
                            affected_line_num_1 = defines.transport_line.left_line
                        end
                    elseif transport_belt_entity.direction == defines.direction.south then
                        if is_splitter then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.secondary_right_split_line
                        elseif is_underground_belt then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.right_line
                        else
                            affected_line_num_1 = defines.transport_line.right_line
                        end
                    end
                elseif direction == defines.direction.south then
                    if transport_belt_entity.direction == defines.direction.east then
                        if is_splitter then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.left_split_line
                        elseif is_underground_belt then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.left_line
                        else
                            affected_line_num_1 = defines.transport_line.left_line
                        end
                    elseif transport_belt_entity.direction == defines.direction.west then
                        if is_splitter then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.secondary_right_split_line
                        elseif is_underground_belt then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.right_line
                        else
                            affected_line_num_1 = defines.transport_line.right_line
                        end
                    end
                elseif direction == defines.direction.west then
                    if transport_belt_entity.direction == defines.direction.north then
                        if is_splitter then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.secondary_right_split_line
                        elseif is_underground_belt then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.right_line
                        else
                            affected_line_num_1 = defines.transport_line.right_line
                        end
                    elseif transport_belt_entity.direction == defines.direction.south then
                        if is_splitter then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.left_split_line
                        elseif is_underground_belt then
                            should_use_insert_at_back = true
                            affected_line_num_1 = defines.transport_line.left_line
                        else
                            affected_line_num_1 = defines.transport_line.left_line
                        end
                    end
                end
            end

            local belt_speed = transport_belt_entity.prototype.belt_speed
            -- Call the functions to actually insert or remove items.
            if affected_line_num_1 then
                if operation_mode == output_or_remove_item_operation_mode.output_mode then
                    if output_item_slot == 1 then
                        entity_data.slot1_last_item_position_on_belt =
                            output_or_remove_item_on_transport_line(
                                transport_belt_entity.get_transport_line(affected_line_num_1), belt_speed,
                                operation_mode, output_stack, filter_item_name, should_use_insert_at_back,
                                entity_data.slot1_last_item_position_on_belt)
                    else
                        entity_data.slot2_last_item_position_on_belt =
                            output_or_remove_item_on_transport_line(
                                transport_belt_entity.get_transport_line(affected_line_num_1), belt_speed,
                                operation_mode, output_stack, filter_item_name, should_use_insert_at_back,
                                entity_data.slot2_last_item_position_on_belt)
                    end
                elseif operation_mode == output_or_remove_item_operation_mode.duplicate_mode then
                    entity_data.line1_last_item_position_on_belt =
                        output_or_remove_item_on_transport_line(
                            transport_belt_entity.get_transport_line(affected_line_num_1), belt_speed, operation_mode,
                            output_stack, filter_item_name, should_use_insert_at_back,
                            entity_data.line1_last_item_position_on_belt)
                else
                    output_or_remove_item_on_transport_line(
                        transport_belt_entity.get_transport_line(affected_line_num_1), belt_speed, operation_mode,
                        output_stack, filter_item_name, should_use_insert_at_back, nil)
                end
            end
            if affected_line_num_2 then
                if operation_mode == output_or_remove_item_operation_mode.output_mode then
                    if output_item_slot == 1 then
                        entity_data.slot1_last_item_position_on_belt =
                            output_or_remove_item_on_transport_line(
                                transport_belt_entity.get_transport_line(affected_line_num_2), belt_speed,
                                operation_mode, output_stack, filter_item_name, should_use_insert_at_back,
                                entity_data.slot1_last_item_position_on_belt)
                    else
                        entity_data.slot2_last_item_position_on_belt =
                            output_or_remove_item_on_transport_line(
                                transport_belt_entity.get_transport_line(affected_line_num_2), belt_speed,
                                operation_mode, output_stack, filter_item_name, should_use_insert_at_back,
                                entity_data.slot2_last_item_position_on_belt)
                    end
                elseif operation_mode == output_or_remove_item_operation_mode.duplicate_mode then
                    entity_data.line2_last_item_position_on_belt =
                        output_or_remove_item_on_transport_line(
                            transport_belt_entity.get_transport_line(affected_line_num_2), belt_speed, operation_mode,
                            output_stack, filter_item_name, should_use_insert_at_back,
                            entity_data.line2_last_item_position_on_belt)
                else
                    output_or_remove_item_on_transport_line(
                        transport_belt_entity.get_transport_line(affected_line_num_2), belt_speed, operation_mode,
                        output_stack, filter_item_name, should_use_insert_at_back, nil)
                end
            end
        end
        return
    end

    if operation_mode == output_or_remove_item_operation_mode.duplicate_mode then
        entity_data.line1_last_item_position_on_belt = nil
        entity_data.line2_last_item_position_on_belt = nil
    end

    -- Work on other entities with different priorities.
    if other_inventory_entity then
        -- Cache it first if valid.
        if entity_data.last_working_static_container ~= other_inventory_entity then
            if static_item_containers[other_inventory_entity.type] then
                entity_data.last_working_static_container = other_inventory_entity
            else
                -- Maybe the entity has fuel slots?
                if other_inventory_entity.get_inventory(defines.inventory.fuel) then
                    entity_data.last_working_static_container = other_inventory_entity
                else
                    -- Unknown type.
                    entity_data.last_working_static_container = nil
                    return
                end
            end
            -- Renew the cached inventories since it is a new entity.
            entity_data.last_working_static_container_inventories = nil
            entity_data.last_working_static_container_type = nil
        end
        -- Since we have a container, not fluidbox can be worked on.
        entity_data.last_working_static_fluidbox = nil

        -- Other entities that are not train, car nor player.
        if operation_mode == output_or_remove_item_operation_mode.output_mode then
            if output_stack then
                other_inventory_entity.insert(output_stack)
            else
                -- No filter is set. Let's see if we are working on a crafting machine or lab.
                if entity_data.last_working_static_container_type == nil then
                    if other_inventory_entity.type == "assembling-machine" or other_inventory_entity.type ==
                        "rocket-silo" then
                        entity_data.last_working_static_container_type = static_item_container_type.crafting_machine
                    elseif other_inventory_entity.type == "lab" then
                        entity_data.last_working_static_container_type = static_item_container_type.lab
                    else
                        entity_data.last_working_static_container_type = static_item_container_type.unknown
                    end
                end

                if entity_data.last_working_static_container_type == static_item_container_type.crafting_machine then
                    -- Crafting machine.
                    if other_inventory_entity.get_recipe() then
                        local inventories = entity_data.last_working_static_container_inventories
                        if inventories == nil then
                            inventories = {other_inventory_entity.get_inventory(
                                defines.inventory.assembling_machine_input)}
                            entity_data.last_working_static_container_inventories = inventories
                        end
                        local input_inventory = inventories[1]
                        local ingredients = other_inventory_entity.get_recipe().ingredients
                        local next_fluid_index = 1
                        for i = 1, #ingredients, 1 do
                            local ingredient = ingredients[i]
                            -- Make sure it is an item. We can't "insert" fluids.
                            if ingredient.type == "item" then
                                if input_inventory then
                                    input_inventory.insert {
                                        name = ingredients[i].name,
                                        count = 1
                                    }
                                end
                            else
                                if next_fluid_index <= #other_inventory_entity.fluidbox then
                                    local fluid = other_inventory_entity.fluidbox[next_fluid_index]
                                    if fluid then
                                        fluid.amount = fluid.amount + 1
                                    else
                                        fluid = {
                                            name = ingredient.name,
                                            amount = 1
                                        }
                                    end
                                    other_inventory_entity.fluidbox[next_fluid_index] = fluid
                                    next_fluid_index = next_fluid_index + 1
                                end
                            end
                        end
                    end
                elseif entity_data.last_working_static_container_type == static_item_container_type.lab then
                    -- Lab.
                    local inventories = entity_data.last_working_static_container_inventories
                    if inventories == nil then
                        inventories = {other_inventory_entity.get_inventory(defines.inventory.lab_input)}
                        entity_data.last_working_static_container_inventories = inventories
                    end
                    local input_inventory = inventories[1]
                    if input_inventory then
                        -- Insert all tools (science packs) into it.
                        for _, item in ipairs(storage.tool_item_list) do
                            input_inventory.insert {
                                name = item.name,
                                count = 1
                            }
                        end
                    end
                else
                    -- Unknown container type.
                    -- We can still output items if the inventory slot has filter. (Although slot filter is only supported in vehicle and player.)
                    entity_data.last_working_static_container_inventories =
                        output_item_stack_according_to_inventories_slot_filters(other_inventory_entity,
                            entity_data.last_working_static_container_inventories, true)
                end
            end
        elseif operation_mode == output_or_remove_item_operation_mode.remove_mode then
            local output_inventory_name = static_item_containers_with_output_slots[other_inventory_entity.type]
            if not filter_item_name and output_inventory_name then
                -- No filter, and the target entity has output slots.
                -- Clear the output slots.
                local inventory = other_inventory_entity.get_inventory(output_inventory_name)
                if inventory then
                    inventory.clear()
                end
            else
                entity_data.last_working_static_container_inventories =
                    remove_one_item_in_entity(other_inventory_entity, filter_item_name,
                        entity_data.last_working_static_container_inventories, true)
            end
        else
            entity_data.last_working_static_container_inventories =
                duplicate_first_item_in_each_inventory(other_inventory_entity, filter_item_name,
                    entity_data.last_working_static_container_inventories, true)
        end
        return
    elseif other_fluidbox_entity then
        -- Cache it first if valid.
        if entity_data.last_working_static_fluidbox ~= other_fluidbox_entity then
            if static_fluidboxes[other_fluidbox_entity.type] then
                entity_data.last_working_static_fluidbox = other_fluidbox_entity
            else
                -- Unknown type.
                entity_data.last_working_static_fluidbox = nil
                return
            end
        end

        -- Doesn't work on fluid if filter is set.
        if filter_item_name == nil then
            if operation_mode == output_or_remove_item_operation_mode.remove_mode then
                fluid_providers_util.remove_all_fluids(other_fluidbox_entity)
            elseif operation_mode == output_or_remove_item_operation_mode.duplicate_mode then
                fluid_providers_util.duplicate_fluid_in_each_fluidbox(other_fluidbox_entity)
            end
        end
        return
    elseif train_entity then
        -- Train.
        if (operation_mode == output_or_remove_item_operation_mode.output_mode and entity_data.can_insert_to_vehicle) or
            (operation_mode == output_or_remove_item_operation_mode.remove_mode and entity_data.can_remove_from_vehicle) or
            (operation_mode == output_or_remove_item_operation_mode.duplicate_mode and
                entity_data.can_duplicate_in_vehicle) then
            -- Output or remove only if the train is stationary.
            if train_entity.train.speed == 0 then
                if operation_mode == output_or_remove_item_operation_mode.output_mode then
                    if output_stack then
                        train_entity.insert(output_stack)
                    else
                        output_item_stack_according_to_inventories_slot_filters(train_entity, nil, false)
                    end
                elseif operation_mode == output_or_remove_item_operation_mode.remove_mode then
                    remove_one_item_in_entity(train_entity, filter_item_name, nil, false)
                else
                    duplicate_first_item_in_each_inventory(train_entity, filter_item_name, nil, false)
                end
            end
        end
        return
    elseif fluid_wagon_entity then
        -- Fluid wagon.
        if (operation_mode == output_or_remove_item_operation_mode.remove_mode and entity_data.can_remove_from_vehicle) or
            (operation_mode == output_or_remove_item_operation_mode.duplicate_mode and
                entity_data.can_duplicate_in_vehicle) then
            -- Output or remove only if the train is stationary.
            if fluid_wagon_entity.train.speed == 0 then
                if operation_mode == output_or_remove_item_operation_mode.remove_mode then
                    fluid_providers_util.remove_all_fluids(fluid_wagon_entity)
                else
                    fluid_providers_util.duplicate_fluid_in_each_fluidbox(fluid_wagon_entity)
                end
            end
        end
        return
    elseif car_entities then
        -- Cars.
        if (operation_mode == output_or_remove_item_operation_mode.output_mode and entity_data.can_insert_to_vehicle) or
            (operation_mode == output_or_remove_item_operation_mode.remove_mode and entity_data.can_remove_from_vehicle) or
            (operation_mode == output_or_remove_item_operation_mode.duplicate_mode and
                entity_data.can_duplicate_in_vehicle) then
            -- Output or remove only if the car is stationary.
            for _, car in ipairs(car_entities) do
                if car.speed == 0 then
                    if operation_mode == output_or_remove_item_operation_mode.output_mode then
                        if output_stack then
                            car.insert(output_stack)
                        else
                            output_item_stack_according_to_inventories_slot_filters(car, nil, false)
                        end
                    elseif operation_mode == output_or_remove_item_operation_mode.remove_mode then
                        remove_one_item_in_entity(car, filter_item_name, nil, false)
                    else
                        duplicate_first_item_in_each_inventory(car, filter_item_name, nil, false)
                    end
                end
            end
        end
        return
    elseif player_entities then
        -- Players.
        if (operation_mode == output_or_remove_item_operation_mode.output_mode and entity_data.can_insert_to_player) or
            (operation_mode == output_or_remove_item_operation_mode.remove_mode and entity_data.can_remove_from_player) or
            (operation_mode == output_or_remove_item_operation_mode.duplicate_mode and
                entity_data.can_duplicate_in_player) then
            if operation_mode == output_or_remove_item_operation_mode.output_mode then
                if output_stack then
                    -- Change the item count if needed.
                    if entity_data.insert_only_once_to_player then
                        if entity_data.insert_to_player_by_stack then
                            output_stack.count = prototypes.item[output_stack.name].stack_size *
                                                     entity_data.insert_to_player_amount
                        else
                            output_stack.count = entity_data.insert_to_player_amount
                        end
                    end
                    for _, player in ipairs(player_entities) do
                        -- Check if the player is restricted to get the item only once so the item cannot be inserted this time.
                        local not_inserted_into_player = not last_player_entities or
                                                             not util.array_contains_val(last_player_entities, player)
                        if not entity_data.insert_only_once_to_player or not_inserted_into_player then
                            player.insert(output_stack)
                        end
                    end
                    -- Set the table of player entities to make sure they are not inserted the item if config doesn't allow to.
                    if output_item_slot == 1 then
                        entity_data.slot1_inserted_players = player_entities
                    else
                        entity_data.slot2_inserted_players = player_entities
                    end
                else
                    for _, player in ipairs(player_entities) do
                        output_item_stack_according_to_inventories_slot_filters(player, nil, false)
                    end
                end
            elseif operation_mode == output_or_remove_item_operation_mode.remove_mode then
                for _, player in ipairs(player_entities) do
                    remove_one_item_in_entity(player, filter_item_name, nil, false)
                end
            else
                for _, player in ipairs(player_entities) do
                    duplicate_first_item_in_each_inventory(player, filter_item_name, nil, false)
                end
            end
        end
        return
    end

    -- The last resort. Drop item on ground or remove items on ground.
    if drop_on_ground then
        local drop_entity = {
            name = "item-on-ground",
            position = actual_position,
            stack = output_stack
        }
        if surface.can_place_entity(drop_entity) then
            surface.create_entity(drop_entity)
        end
    elseif remove_from_ground then
        -- Get tile bounding box if it has not been gotten.
        for _, item in ipairs(surface.find_entities_filtered {
            area = util.get_tile_bb(actual_position),
            name = "item-on-ground"
        }) do
            if filter_item_name == nil or item.stack.name == filter_item_name then
                item.destroy()
            end
        end
    end
end
