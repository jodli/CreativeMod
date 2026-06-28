-- This file contains variables and functions related to creating new surfaces on demand.
if not surface_creation then
  surface_creation = {}
end

-- Creates a new blank surface with the given name.
-- The name is trimmed; empty and duplicate names are rejected (game.create_surface errors on a duplicate name).
-- Returns:
--   on success: true, surface
--   on failure: false, localised-string error message
function surface_creation.create_blank_surface(name)
  -- Trim leading/trailing whitespace.
  local trimmed_name
  if type(name) == "string" then
    trimmed_name = name:match("^%s*(.-)%s*$")
  end

  -- Reject empty names.
  if not trimmed_name or trimmed_name == "" then
    return false, { "message.creative-mode_surface-creation-blank-empty-name" }
  end

  -- Reject duplicate names (game.create_surface would error otherwise).
  if game.surfaces[trimmed_name] then
    return false, { "message.creative-mode_surface-creation-blank-duplicate-name", trimmed_name }
  end

  local surface = game.create_surface(trimmed_name)
  if not surface then
    return false, { "message.creative-mode_surface-creation-blank-failed", trimmed_name }
  end

  return true, surface
end

-- Creates a new space platform for the given force, orbiting the given planet, initialized with a hub.
-- Space-Age-only: refuses on configurations without the "space_travel" feature flag.
-- The name is trimmed; an empty name is allowed (the engine assigns a default platform name).
-- Returns:
--   on success: true, surface (the platform's surface)
--   on failure: false, localised-string error message
function surface_creation.create_space_platform(force, name, planet_id)
  -- Feature-gate: space platforms only exist with Space Age.
  if not script.feature_flags["space_travel"] then
    return false, { "message.creative-mode_surface-creation-not-available-without-space-age" }
  end

  if not (force and force.valid) then
    return false, { "message.creative-mode_surface-creation-platform-failed" }
  end

  if not (planet_id and game.planets[planet_id]) then
    return false, { "message.creative-mode_surface-creation-platform-invalid-planet" }
  end

  -- Trim the optional name; an empty name lets the engine assign its default.
  local trimmed_name
  if type(name) == "string" then
    trimmed_name = name:match("^%s*(.-)%s*$")
  end
  if trimmed_name == "" then
    trimmed_name = nil
  end

  local platform = force.create_space_platform({
    name = trimmed_name,
    planet = planet_id,
    starter_pack = "space-platform-starter-pack",
  })
  if not platform then
    return false, { "message.creative-mode_surface-creation-platform-failed" }
  end

  -- Place the hub immediately so the platform comes up ready.
  platform.apply_starter_pack()

  return true, platform.surface
end
