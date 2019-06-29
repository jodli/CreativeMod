-- This file contains variables or functions that are related to the Matter Source in this mod.
if not item_source then
	item_source = {}
end

-- The position shift for item output for each direction.
local item_source_shift = {
	-- The values are shifted from the original mod so surface.can_place_entity can work properly.
	[defines.direction.north] = {x1 = 0.3, y1 = 0.9, x2 = -0.3, y2 = 0.9, x0 = 0, y0 = 0.9},
	[defines.direction.east] = {x1 = -0.9, y1 = 0.3, x2 = -0.9, y2 = -0.3, x0 = -0.9, y0 = 0},
	[defines.direction.south] = {x1 = -0.3, y1 = -0.9, x2 = 0.3, y2 = -0.9, x0 = 0, y0 = -0.9},
	[defines.direction.west] = {x1 = 0.9, y1 = -0.3, x2 = 0.9, y2 = 0.3, x0 = 0.9, y0 = 0}
}

-- Processes the item_source_data table in global.
function item_source.tick()
	-- Loop through the table of matter-source data to output items.
	for index, item_source_data in ipairs(global.creative_mode.item_source_data) do
		-- Get the actual matter-source entity.
		local item_source = item_source_data.entity
		-- Work only if the entity is valid.
		if item_source.valid then
			-- Check if it is active and also not marked for deconstruction.
			if item_source.active and not item_source.to_be_deconstructed(item_source.force) then
				-- Give the matter-source free energy.
				item_source.energy = 100000 -- It seems not working?
				-- Check if it is enabled according to its circuit network state and logistic network state.
				if util.is_inserter_enabled(item_source) then
					-- Get the item names in the 2 filter slots of the matter-source.
					local slot1 = item_source.get_filter(1)
					local slot2 = item_source.get_filter(2)
					-- Get the matter-source's surface, position and shift for output, so we can drop items accordingly.
					local surf = item_source.surface
					local pos = item_source.position
					local dir = item_source.direction
					local shift = item_source_shift[dir]
					local opposite_dir = util.oppositedirection(dir)
					-- Output for slot1.
					if slot1 == nil then
						item_source_data.slot1_inserted_players = nil
						item_source_data.slot1_last_item_position_on_belt = nil
					else
						item_providers_util.output_or_remove_item(
							surf,
							pos,
							shift.x1,
							shift.y1,
							opposite_dir,
							slot1,
							output_or_remove_item_operation_mode.output_mode,
							1,
							item_source_data
						)
					end
					-- Output for slot2.
					if slot2 == nil then
						item_source_data.slot2_inserted_players = nil
						item_source_data.slot2_last_item_position_on_belt = nil
						-- Output to crafting machine if no filter is set.
						if slot1 == nil then
							item_providers_util.output_or_remove_item(
								surf,
								pos,
								shift.x0,
								shift.y0,
								opposite_dir,
								nil,
								output_or_remove_item_operation_mode.output_mode,
								0,
								item_source_data
							)
						end
					else
						item_providers_util.output_or_remove_item(
							surf,
							pos,
							shift.x2,
							shift.y2,
							opposite_dir,
							slot2,
							output_or_remove_item_operation_mode.output_mode,
							2,
							item_source_data
						)
					end
				end
			end
		else
			-- Remove invalid entity.
			table.remove(global.creative_mode.item_source_data, index)
		end
	end
end

-- Returns the entity data for the given matter source entity.
function item_source.get_data_for_entity(entity)
	for _, data in ipairs(global.creative_mode.item_source_data) do
		if data.entity == entity then
			return data
		end
	end
	return nil
end

-- Copies the additional configurations from the source entity to the destination entity.
function item_source.on_entity_copied_pasted(source, destination)
	local source_data = item_source.get_data_for_entity(source)
	local destination_data = item_source.get_data_for_entity(destination)
	if not source_data then
		return
	end
	if not destination_data then
		return
	end
	destination_data.can_insert_to_vehicle = source_data.can_insert_to_vehicle
	destination_data.can_insert_to_player = source_data.can_insert_to_player
	destination_data.insert_only_once_to_player = source_data.insert_only_once_to_player
	destination_data.insert_to_player_amount = source_data.insert_to_player_amount
	destination_data.insert_to_player_by_stack = source_data.insert_to_player_by_stack
	destination_data.can_drop_on_ground = source_data.can_drop_on_ground
end
