-- This file contains variables or functions that are related to the Duplicator in this mod.
if not duplicator then
  duplicator = {}
end

-- The position shift for duplicating items or fluids for each direction.
local duplicator_shift = {
  [defines.direction.north] = { x = 0, y = 1 },
  [defines.direction.east] = { x = -1, y = 0 },
  [defines.direction.south] = { x = 0, y = -1 },
  [defines.direction.west] = { x = 1, y = 0 },
}

-- Processes up to 10 duplicators per tick using round-robin scheduling.
function duplicator.tick()
  local data_list = storage.creative_mode.duplicator_data
  if #data_list <= 0 then
    storage.creative_mode.duplicator_next_update_index = 1
    return
  end

  local data_index = storage.creative_mode.duplicator_next_update_index
  if data_index > #data_list then
    data_index = 1
  end

  for _ = 1, 10 do
    local duplicator_data = data_list[data_index]
    local duplicator = duplicator_data.entity
    -- Work only if the entity is valid.
    if duplicator.valid then
      -- Check if it is active and also not marked for deconstruction.
      if duplicator.active and not duplicator.to_be_deconstructed(duplicator.force) then
        -- Give the duplicator free energy.
        duplicator.energy = 100000
        -- Check if it is enabled according to its circuit network state and logistic network state.
        if util.is_inserter_enabled(duplicator) then
          -- Get the duplicator's surface, position and shift for item/fluid duplication.
          local surf = duplicator.surface
          local pos = duplicator.position
          local dir = duplicator.direction
          local shift = duplicator_shift[dir]
          local filter = nil
          if duplicator.use_filters then
            filter = duplicator.get_filter(1)
          end
          if filter then
            filter = filter.name
          end
          -- Duplicate the items in front of it.
          item_providers_util.output_or_remove_item(
            surf,
            pos,
            shift.x,
            shift.y,
            util.oppositedirection(dir),
            filter,
            output_or_remove_item_operation_mode.duplicate_mode,
            nil,
            duplicator_data
          )
        end
      end

      -- Advance to next entity.
      data_index = data_index + 1
      if data_index > #data_list then
        storage.creative_mode.duplicator_next_update_index = 1
        return
      end
    else
      -- Remove invalid entity.
      table.remove(data_list, data_index)
      if data_index > #data_list then
        storage.creative_mode.duplicator_next_update_index = 1
        return
      end
    end
  end
  storage.creative_mode.duplicator_next_update_index = data_index
end

-- Returns the entity data for the given matter duplicator entity.
function duplicator.get_data_for_entity(entity)
  for _, data in ipairs(storage.creative_mode.duplicator_data) do
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
