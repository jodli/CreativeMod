-- This file contains variables or functions that are related to the Duplicator in this mod.
if not duplicator then duplicator = {} end

-- The position shift for duplicating items or fluids for each direction.
local duplicator_shift =
{
	[defines.direction.north] = {x = 0, y = 1},
	[defines.direction.east] = {x = -1, y = 0},
	[defines.direction.south] = {x = 0, y = -1},
	[defines.direction.west] = {x = 1, y = 0},
}

-- Processes the table of duplicator_data in global.
function duplicator.tick()
	-- Loop through the table of duplicator data to duplicate items.
	for index, duplicator_data in ipairs(global.creative_mode.duplicator_data) do
		local duplicator = duplicator_data.entity
		-- Work only if the entity is valid.
		if duplicator.valid then
			-- Check if it is active and also not marked for deconstruction.
			if duplicator.active and not duplicator.to_be_deconstructed(duplicator.force) then
				-- Give the item-source free energy.
				duplicator.energy = 100000 -- It seems not working?
				-- Check if it is enabled according to its circuit network state and logistic network state.
				if util.is_inserter_enabled(duplicator) then
					-- Get the duplicator's surface, position and shift for item/fluid duplication.
					local surf = duplicator.surface
					local pos = duplicator.position
					local dir = duplicator.direction
					local shift = duplicator_shift[dir]
					local filter = duplicator.get_filter(1)
					-- Duplicate the items in front of it.
					item_providers_util.output_or_remove_item(surf, pos, shift.x, shift.y, util.oppositedirection(dir), filter, output_or_remove_item_operation_mode.duplicate_mode, nil, duplicator_data)
				end
			end
		else
			-- Remove invalid entity.
			table.remove(global.creative_mode.duplicator_data, index)
		end
	end
end

-- Returns the entity data for the given matter duplicator entity.
function duplicator.get_data_for_entity(entity)
	for _, data in ipairs(global.creative_mode.duplicator_data) do
		if data.entity == entity then
			return data
		end
	end
	return nil
end

-- Copies the additional configurations from the source entity to the destination entity.
function duplicator.on_entity_copied_pasted(source, destination)
	local source_data = duplicator.get_data_for_entity(source)
	local destination_data = duplicator.get_data_for_entity(destination)
	if not source_data then
		return
	end
	if not destination_data then
		return
	end
	destination_data.can_duplicate_in_vehicle = source_data.can_duplicate_in_vehicle
	destination_data.can_duplicate_in_player = source_data.can_duplicate_in_player
end