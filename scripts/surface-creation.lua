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
