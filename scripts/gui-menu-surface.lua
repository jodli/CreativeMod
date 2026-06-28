local mod_gui = require("mod-gui")

require("scripts.surface-creation")

-- This file contains variables and functions related to Creative Mode menu - surface creation GUI.
if not gui_menu_surface then
  gui_menu_surface = {}
end

-- Gets the name of the surface menu container.
function gui_menu_surface.get_container_name()
  return creative_mode_defines.names.gui.surface_menus_container
end

------

-- Creates the surface creation menu for the given player. If the menu already exists, it will be destroyed instead.
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

      -- Blank surface frame.
      local blank_frame = surface_menus_container.add({
        type = "frame",
        name = creative_mode_defines.names.gui.surface_blank_frame,
        direction = "vertical",
        caption = { "gui.creative-mode_surface-creation-blank-title" },
      })
      -- Row: label | textfield | create-button.
      local blank_container = blank_frame.add({
        type = "table",
        name = creative_mode_defines.names.gui.surface_blank_container,
        column_count = 3,
      })
      -- Label.
      blank_container.add({
        type = "label",
        name = creative_mode_defines.names.gui.surface_blank_name_label,
        caption = { "gui.creative-mode_surface-creation-blank-name-label" },
      })
      -- Name textfield.
      blank_container.add({
        type = "textfield",
        name = creative_mode_defines.names.gui.surface_blank_name_textfield,
        style = creative_mode_defines.names.gui_styles.cheat_numeric_textfield,
      })
      -- Create button.
      blank_container.add({
        type = "button",
        name = creative_mode_defines.names.gui.surface_blank_create_button,
        style = creative_mode_defines.names.gui_styles.cheat_apply_button,
        caption = { "gui.creative-mode_surface-creation-blank-create-button" },
      })
    end
  end
end

--------------------------------------------------------------------

-- Callback of the on_gui_click event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_surface.on_gui_click(element, element_name, player, button, alt, control, shift)
  if element_name == creative_mode_defines.names.gui.surface_blank_create_button then
    -- Create blank surface button.
    local left = mod_gui.get_frame_flow(player)
    local container = left[creative_mode_defines.names.gui.main_menu_container]
    if container then
      local surface_menus_container = container[gui_menu_surface.get_container_name()]
      if surface_menus_container then
        local blank_frame = surface_menus_container[creative_mode_defines.names.gui.surface_blank_frame]
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
    end
    return true
  end
  return false
end
