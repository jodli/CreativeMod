-- This file contains variables or functions that are related to the Matter Void in this mod.
if not item_void then item_void = {} end

-- The position shift for item removal for each direction.
local item_void_shift =
{
	[defines.direction.north] = {x = 0, y = -0.9},
	[defines.direction.east] = {x = 0.9, y = 0},
	[defines.direction.south] = {x = 0, y = 0.9},
	[defines.direction.west] = {x = -0.9, y = 0}
}

-- Processes the item_void table in global.
function item_void.tick()
	-- Loop through the table of matter-void to nullify items.
	for index, item_void_data in ipairs(global.creative_mode.item_void_data) do
		-- Get the actual matter-void entity.
		local item_void = item_void_data.entity
		if item_void.valid then
			-- Check if it is active and also not marked for deconstruction.
			if item_void.active and not item_void.to_be_deconstructed(item_void.force) then
				-- Give the matter-void free energy.
				item_void.energy = 100000 -- It seems not working?
				-- Check if it is enabled according to its circuit network state and logistic network state.
				if util.is_inserter_enabled(item_void) then
					-- Get the matter-void's surface, position and shift for item removal.
					local surf = item_void.surface
					local pos = item_void.position
					local dir = item_void.direction
					local shift = item_void_shift[dir]
					local filter = item_void.get_filter(1)
					-- Remove the items in front of it.
					item_providers_util.output_or_remove_item(surf, pos, shift.x, shift.y, util.oppositedirection(dir), filter, output_or_remove_item_operation_mode.remove_mode, nil, item_void_data)
				end
			end
		else
			table.remove(global.creative_mode.item_void_data, index)
		end
	end
end

-- Returns the entity data for the given matter void entity.
function item_void.get_data_for_entity(entity)
	for _, data in ipairs(global.creative_mode.item_void_data) do
		if data.entity == entity then
			return data
		end
	end
	return nil
end

-- Copies the additional configurations from the source entity to the destination entity.
function item_void.on_entity_copied_pasted(source, destination)
	local source_data = item_void.get_data_for_entity(source)
	local destination_data = item_void.get_data_for_entity(destination)
	if not source_data then
		return
	end
	if not destination_data then
		return
	end
	destination_data.can_remove_from_vehicle = source_data.can_remove_from_vehicle
	destination_data.can_remove_from_player = source_data.can_remove_from_player
	destination_data.can_remove_from_ground = source_data.can_remove_from_ground
end