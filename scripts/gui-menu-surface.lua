local mod_gui = require("mod-gui")

require("scripts.surface-creation")

-- This file contains variables and functions related to Creative Mode menu - surface creation GUI.
-- The Surface submenu mirrors the Cheats submenu's three-column navigation: the main menu opens a
-- "Surface" frame holding a column of buttons (Blank surface / Space platform), and clicking a
-- button opens that section's content as a sub-sub-menu frame beside the column.
if not gui_menu_surface then
  gui_menu_surface = {}
end

-- Gets the name of the surface menu container.
function gui_menu_surface.get_container_name()
  return creative_mode_defines.names.gui.surface_menus_container
end

-- Enumerates the available planets in a deterministic order, returning two parallel arrays:
--   items     :: array of LocalisedString captions for a drop-down.
--   planet_ids:: array of SpaceLocationID, where planet_ids[i] is the planet for items[i].
-- The same order is used when building the drop-down and when resolving a selected_index back
-- to a planet id, so no per-player index map needs to be stored.
local function get_planet_drop_down_data()
  -- Collect planet ids first, then sort them so the order is identical between the call that
  -- builds the drop-down and the call that resolves a selected_index back to a planet id.
  local planet_ids = {}
  for planet_id in pairs(game.planets) do
    planet_ids[#planet_ids + 1] = planet_id
  end
  table.sort(planet_ids)

  local items = {}
  for i, planet_id in ipairs(planet_ids) do
    local planet = game.planets[planet_id]
    items[i] = (planet and planet.prototype.localised_name) or planet_id
  end
  return items, planet_ids
end

------

-- Builds the Blank-surface section content inside its (already created, captioned) frame.
local function build_blank_section_content(frame)
  -- Label|input row in a cheat_table, then the create button below — consistent with the platform
  -- and planet sections (the button sits under the inputs, not inline to the right).
  local blank_container = frame.add({
    type = "table",
    name = creative_mode_defines.names.gui.surface_blank_container,
    style = creative_mode_defines.names.gui_styles.cheat_table,
    column_count = 2,
  })
  blank_container.add({
    type = "label",
    name = creative_mode_defines.names.gui.surface_blank_name_label,
    style = creative_mode_defines.names.gui_styles.cheat_name_label,
    caption = { "gui.creative-mode_surface-creation-blank-name-label" },
  })
  blank_container.add({
    type = "textfield",
    name = creative_mode_defines.names.gui.surface_blank_name_textfield,
    style = creative_mode_defines.names.gui_styles.cheat_numeric_textfield,
  })
  frame.add({
    type = "button",
    name = creative_mode_defines.names.gui.surface_blank_create_button,
    -- small_default_bold_button auto-sizes to the caption (see the platform/planet sections).
    style = creative_mode_defines.names.gui_styles.small_default_bold_button,
    caption = { "gui.creative-mode_surface-creation-blank-create-button" },
  })
end

-- Builds the Space-platform section content inside its (already created, captioned) frame.
local function build_platform_section_content(frame)
  -- Two label|input rows in a cheat_table, then the create button below.
  local platform_container = frame.add({
    type = "table",
    name = creative_mode_defines.names.gui.surface_platform_container,
    style = creative_mode_defines.names.gui_styles.cheat_table,
    column_count = 2,
  })
  platform_container.add({
    type = "label",
    name = creative_mode_defines.names.gui.surface_platform_name_label,
    style = creative_mode_defines.names.gui_styles.cheat_name_label,
    caption = { "gui.creative-mode_surface-creation-platform-name-label" },
  })
  platform_container.add({
    type = "textfield",
    name = creative_mode_defines.names.gui.surface_platform_name_textfield,
    style = creative_mode_defines.names.gui_styles.cheat_numeric_textfield,
  })
  platform_container.add({
    type = "label",
    name = creative_mode_defines.names.gui.surface_platform_planet_label,
    style = creative_mode_defines.names.gui_styles.cheat_name_label,
    caption = { "gui.creative-mode_surface-creation-platform-planet-label" },
  })
  -- Planet drop-down enumerated from game.planets (so modded planets appear).
  local planet_items, planet_ids = get_planet_drop_down_data()
  -- Default the selection to nauvis when present; otherwise the first planet (or none).
  local default_index = #planet_items > 0 and 1 or 0
  for i, planet_id in ipairs(planet_ids) do
    if planet_id == "nauvis" then
      default_index = i
      break
    end
  end
  platform_container.add({
    type = "drop-down",
    name = creative_mode_defines.names.gui.surface_platform_planet_drop_down,
    items = planet_items,
    selected_index = default_index,
  })
  frame.add({
    type = "button",
    name = creative_mode_defines.names.gui.surface_platform_create_button,
    -- small_default_bold_button auto-sizes to the caption (see the blank-section note above).
    style = creative_mode_defines.names.gui_styles.small_default_bold_button,
    caption = { "gui.creative-mode_surface-creation-platform-create-button" },
  })
end

-- Builds the Planet-surface section content inside its (already created, captioned) frame.
local function build_planet_section_content(frame)
  -- Row: label | drop-down, then the create button below. This planet drop-down is independent
  -- from the platform-orbit picker (its own element name + its own index->planet-id resolution).
  local planet_container = frame.add({
    type = "table",
    name = creative_mode_defines.names.gui.surface_planet_container,
    style = creative_mode_defines.names.gui_styles.cheat_table,
    column_count = 2,
  })
  planet_container.add({
    type = "label",
    name = creative_mode_defines.names.gui.surface_planet_planet_label,
    style = creative_mode_defines.names.gui_styles.cheat_name_label,
    caption = { "gui.creative-mode_surface-creation-planet-planet-label" },
  })
  -- Planet drop-down enumerated from game.planets (so modded planets appear).
  local planet_items, planet_ids = get_planet_drop_down_data()
  -- Default the selection to nauvis when present; otherwise the first planet (or none),
  -- mirroring the platform section.
  local default_index = #planet_items > 0 and 1 or 0
  for i, planet_id in ipairs(planet_ids) do
    if planet_id == "nauvis" then
      default_index = i
      break
    end
  end
  planet_container.add({
    type = "drop-down",
    name = creative_mode_defines.names.gui.surface_planet_planet_drop_down,
    items = planet_items,
    selected_index = default_index,
  })
  frame.add({
    type = "button",
    name = creative_mode_defines.names.gui.surface_planet_create_button,
    -- small_default_bold_button auto-sizes to the caption (see the blank-section note above).
    style = creative_mode_defines.names.gui_styles.small_default_bold_button,
    caption = { "gui.creative-mode_surface-creation-planet-create-button" },
  })
end

-- The sections inside the Surface submenu. Each entry pairs a column button with the content frame
-- it opens (built on demand, like the Cheats sub-sub-menus). The "platform" section is gated on
-- Space Age. (A third "planet" section will join here in Phase 3.) section_order fixes the button
-- order in the column (pairs() is unordered).
local section_data = {
  blank = {
    button_name = creative_mode_defines.names.gui.surface_nav_blank_button,
    button_caption = { "gui.creative-mode_surface-creation-nav-blank" },
    frame_name = creative_mode_defines.names.gui.surface_blank_frame,
    frame_caption = { "gui.creative-mode_surface-creation-blank-title" },
    space_age_only = false,
    build_content = build_blank_section_content,
  },
  platform = {
    button_name = creative_mode_defines.names.gui.surface_nav_platform_button,
    button_caption = { "gui.creative-mode_surface-creation-nav-platform" },
    frame_name = creative_mode_defines.names.gui.surface_platform_frame,
    frame_caption = { "gui.creative-mode_surface-creation-platform-title" },
    space_age_only = true,
    build_content = build_platform_section_content,
  },
  planet = {
    button_name = creative_mode_defines.names.gui.surface_nav_planet_button,
    button_caption = { "gui.creative-mode_surface-creation-nav-planet" },
    frame_name = creative_mode_defines.names.gui.surface_planet_frame,
    frame_caption = { "gui.creative-mode_surface-creation-planet-title" },
    space_age_only = true,
    build_content = build_planet_section_content,
  },
  -- The surface-cheats section reuses the existing Cheats machinery (its content frame is built by
  -- gui_menu_cheats), so instead of a generic build_content it delegates open/close to that module.
  -- Its column button is gated on the surface-cheats access right (see the menu builder below).
  surface_cheats = {
    button_name = creative_mode_defines.names.gui.surface_cheats_menu_button,
    button_caption = { "gui.creative-mode_surface-cheats" },
    space_age_only = false,
    get_player_can_access_function = rights.can_player_access_surface_cheats_menu,
    create_or_destroy = function(player, destroy_only)
      gui_menu_cheats.create_or_destroy_surface_cheats_menu_for_player(player, destroy_only)
    end,
  },
}
local section_order = { "blank", "platform", "planet", "surface_cheats" }

-- Returns whether the given section is currently available (built) for this configuration.
local function is_section_available(data)
  return (not data.space_age_only) or script.feature_flags["space_travel"]
end

------

-- Creates or destroys the given section's content frame (a sub-sub-menu) beside the button column,
-- mirroring the Cheats submenu's create_or_destroy_cheats_menu_for_player toggle. If destroy_only is
-- true, an open frame is only closed (never opened).
local function create_or_destroy_section_for_player(player, data, destroy_only)
  -- Sections may delegate their open/close to a custom function (e.g. the surface-cheats section,
  -- whose content is built by the generic Cheats machinery) instead of the generic frame path.
  if data.create_or_destroy then
    data.create_or_destroy(player, destroy_only)
    return
  end
  local left = mod_gui.get_frame_flow(player)
  local container = left[creative_mode_defines.names.gui.main_menu_container]
  if not container then
    return
  end
  local surface_menus_container = container[gui_menu_surface.get_container_name()]
  if not surface_menus_container then
    return
  end
  local frame = surface_menus_container[data.frame_name]
  if frame then
    -- Already opened.
    frame.destroy()
  elseif not destroy_only then
    -- Not yet opened. Build a captioned content frame and fill it.
    frame = surface_menus_container.add({
      type = "frame",
      name = data.frame_name,
      direction = "vertical",
      caption = data.frame_caption,
    })
    data.build_content(frame)
  end
end

------

-- Creates the surface creation menu (the button column) for the given player. If the menu already
-- exists, it will be destroyed instead.
function gui_menu_surface.create_or_destroy_menu_for_player(player)
  local left = mod_gui.get_frame_flow(player)
  local container = left[creative_mode_defines.names.gui.main_menu_container]
  if container then
    -- Surface container.
    local surface_menus_container = container[gui_menu_surface.get_container_name()]
    if surface_menus_container then
      surface_menus_container.destroy()
    else
      surface_menus_container = container.add({
        type = "flow",
        name = gui_menu_surface.get_container_name(),
        style = creative_mode_defines.names.gui_styles.no_horizontal_spacing_flow,
        direction = "horizontal",
      })

      -- Surface frame: the button column, exactly like the Cheats submenu's button frame.
      local surface_menu_frame = surface_menus_container.add({
        type = "frame",
        name = creative_mode_defines.names.gui.surface_menu_frame,
        direction = "vertical",
        caption = { "gui.creative-mode_surface" },
      })

      -- One button per available section, styled like the Cheats column buttons.
      for _, key in ipairs(section_order) do
        local data = section_data[key]
        if is_section_available(data) then
          local button = surface_menu_frame.add({
            type = "button",
            name = data.button_name,
            style = creative_mode_defines.names.gui_styles.main_menu_button,
            caption = data.button_caption,
          })
          -- Gate visibility by the section's access right when it defines one, mirroring the Cheats
          -- column (button.visible = data.get_player_can_access_function(player)).
          if data.get_player_can_access_function then
            button.visible = data.get_player_can_access_function(player)
          end
        end
      end
    end
  end
end

--------------------------------------------------------------------

-- Resolves the content frame of the given section for the player's open Surface submenu, or nil.
local function get_section_frame(player, frame_name)
  local left = mod_gui.get_frame_flow(player)
  local container = left[creative_mode_defines.names.gui.main_menu_container]
  if not container then
    return nil
  end
  local surface_menus_container = container[gui_menu_surface.get_container_name()]
  if not surface_menus_container then
    return nil
  end
  return surface_menus_container[frame_name]
end

-- Callback of the on_gui_click event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_surface.on_gui_click(element, element_name, player, button, alt, control, shift)
  -- Column navigation: clicking a section button closes the other sections and toggles this one.
  for _, data in pairs(section_data) do
    if element_name == data.button_name then
      for _, data2 in pairs(section_data) do
        if data2 ~= data then
          create_or_destroy_section_for_player(player, data2, true)
        end
      end
      create_or_destroy_section_for_player(player, data, false)
      return true
    end
  end

  if element_name == creative_mode_defines.names.gui.surface_blank_create_button then
    -- Create blank surface button.
    local blank_frame = get_section_frame(player, creative_mode_defines.names.gui.surface_blank_frame)
    if blank_frame then
      local blank_container = blank_frame[creative_mode_defines.names.gui.surface_blank_container]
      local textfield = blank_container[creative_mode_defines.names.gui.surface_blank_name_textfield]
      local name = textfield.text

      local success, result = surface_creation.create_blank_surface(name)
      if success then
        player.print({ "message.creative-mode_surface-creation-blank-success", result.name })
        -- Clear the field for convenience.
        textfield.text = ""
      else
        -- result is a localised error message.
        player.print(result)
      end
    end
    return true
  elseif element_name == creative_mode_defines.names.gui.surface_platform_create_button then
    -- Create space platform button.
    local platform_frame = get_section_frame(player, creative_mode_defines.names.gui.surface_platform_frame)
    if platform_frame then
      local platform_container = platform_frame[creative_mode_defines.names.gui.surface_platform_container]
      local textfield = platform_container[creative_mode_defines.names.gui.surface_platform_name_textfield]
      local drop_down = platform_container[creative_mode_defines.names.gui.surface_platform_planet_drop_down]
      local name = textfield.text

      -- Resolve the selected drop-down index back to a planet id using the same ordering
      -- that built the drop-down.
      local _, planet_ids = get_planet_drop_down_data()
      local planet_id = planet_ids[drop_down.selected_index]

      local success, result = surface_creation.create_space_platform(player.force, name, planet_id)
      if success then
        player.print({ "message.creative-mode_surface-creation-platform-success", result.name })
        -- Clear the name field for convenience.
        textfield.text = ""
      else
        -- result is a localised error message.
        player.print(result)
      end
    end
    return true
  elseif element_name == creative_mode_defines.names.gui.surface_planet_create_button then
    -- Create planet surface button.
    local planet_frame = get_section_frame(player, creative_mode_defines.names.gui.surface_planet_frame)
    if planet_frame then
      local planet_container = planet_frame[creative_mode_defines.names.gui.surface_planet_container]
      local drop_down = planet_container[creative_mode_defines.names.gui.surface_planet_planet_drop_down]

      -- Resolve the selected drop-down index back to a planet id using the same ordering
      -- that built the drop-down. This is the planet section's own independent picker.
      local _, planet_ids = get_planet_drop_down_data()
      local planet_id = planet_ids[drop_down.selected_index]

      local success, result = surface_creation.create_planet_surface(planet_id)
      if success then
        if result.already_existed then
          player.print({ "message.creative-mode_surface-creation-planet-already-existed", result.surface.name })
        else
          player.print({ "message.creative-mode_surface-creation-planet-success", result.surface.name })
        end
      else
        -- result is a localised error message.
        player.print(result)
      end
    end
    return true
  end
  return false
end

--------------------------------------------------------------------

-- Callback of the on_gui_selection_state_changed event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_surface.on_gui_selection_state_changed(element, element_name, player)
  if
    element_name == creative_mode_defines.names.gui.surface_platform_planet_drop_down
    or element_name == creative_mode_defines.names.gui.surface_planet_planet_drop_down
  then
    -- The selected planet is read directly from the drop-down at create time, so nothing to
    -- record here. Consume the event so the chain stops.
    return true
  end
  return false
end
