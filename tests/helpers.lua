-- Shared test helpers for CreativeMod tests
local helpers = {}

-- Get a clean surface for testing
function helpers.get_surface()
  return game.surfaces[1]
end

-- Clear the test surface of all entities except the player character
function helpers.clear_surface()
  local surface = helpers.get_surface()
  for _, entity in pairs(surface.find_entities()) do
    if entity.type ~= "character" then
      entity.destroy()
    end
  end
end

-- Get or create the first player
function helpers.get_player()
  return game.players[1]
end

-- Enable Creative Mode programmatically
function helpers.enable_creative_mode()
  local player = helpers.get_player()
  if not storage.creative_mode.enabled then
    cheats.enable_or_disable_creative_mode(player, true, false, false, true)
  end
end

-- Disable Creative Mode programmatically
function helpers.disable_creative_mode()
  local player = helpers.get_player()
  if storage.creative_mode.enabled then
    cheats.enable_or_disable_creative_mode(player, false, false, false, true)
  end
end

-- Place an entity on the test surface
function helpers.place_entity(name, position, force)
  local surface = helpers.get_surface()
  local entity = surface.create_entity({
    name = name,
    position = position or { 0, 0 },
    force = force or "player",
    raise_built = true,
  })
  assert(entity and entity.valid, "Failed to place entity: " .. name)
  return entity
end

-- Place an entity without raising the built event
function helpers.place_entity_silent(name, position, force)
  local surface = helpers.get_surface()
  local entity = surface.create_entity({
    name = name,
    position = position or { 0, 0 },
    force = force or "player",
  })
  assert(entity and entity.valid, "Failed to place entity: " .. name)
  return entity
end

return helpers
