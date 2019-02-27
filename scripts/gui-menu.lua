local mod_gui = require("mod-gui")

-- This file contains variables and functions related to Creative Mode menu GUI.
if not gui_menu then gui_menu = {} end

-- Creates or destroys the Creative Mode main menu button for the given player according to the current state of Creative Mode and also the player's access rights.
-- Returns whether the button exists. If false is returned, it means the whole Creative Menu is removed for such player.
function gui_menu.create_or_destroy_main_menu_open_button_for_player(player)
	local top = mod_gui.get_button_flow(player)
	if global.creative_mode.enabled and rights.can_player_access_creative_mode_menu(player) then
		if not top[creative_mode_defines.names.gui.main_menu_open_button] then
			top.add{type = "button", name = creative_mode_defines.names.gui.main_menu_open_button, style = creative_mode_defines.names.gui_styles.main_menu_open_button, tooltip = {"gui.creative-mode_main-menu-open-button-tooltip"}}
		end
		return true
	else
		local button = top[creative_mode_defines.names.gui.main_menu_open_button]
		if button then
			button.destroy()
		end
		-- Also destroy the contents.
		local left = mod_gui.get_frame_flow(player)
		local container = left[creative_mode_defines.names.gui.main_menu_container]
		if container then
			container.destroy()
		end
		return false
	end
end

-- Creates or destroys the Creative Mode main menu button for all players according to the current state of Creative Mode.
function gui_menu.create_or_destroy_main_menu_open_button_for_all_players()
	for _, player in pairs(game.players) do
		gui_menu.create_or_destroy_main_menu_open_button_for_player(player)
	end
end

--------------------------------------------------------------------

-- GUI data about the submenu buttons.
local submenus_gui_data =
{
	cheats =
	{
		button_name = creative_mode_defines.names.gui.main_menu_open_cheats_button,
		button_caption = {"gui.creative-mode_cheats"},
		get_player_can_access_function = rights.can_player_access_cheats_menu,
		get_submenu_container_name_function = gui_menu_cheats.get_container_name,
		open_submenu_for_player_function = gui_menu_cheats.create_or_destroy_menu_for_player,
		update_accessibility_for_player_function = gui_menu_cheats.update_menu_accessibility_according_to_access_right_for_player
	},
	build_options =
	{
		button_name = creative_mode_defines.names.gui.main_menu_open_build_options_button,
		button_caption = {"gui.creative-mode_build-options"},
		get_player_can_access_function = rights.can_player_access_build_options_menu,
		get_submenu_container_name_function = gui_menu_buildoptions.get_container_name,
		open_submenu_for_player_function = gui_menu_buildoptions.create_or_destroy_menu_for_player,
		update_accessibility_for_player_function = gui_menu_buildoptions.update_menu_accessibility_according_to_access_right_for_player
	},
	magic_wand =
	{
		button_name = creative_mode_defines.names.gui.main_menu_open_magic_wand_button,
		button_caption = {"gui.creative-mode_magic-wand"},
		get_player_can_access_function = rights.can_player_access_magic_wand_menu,
		get_submenu_container_name_function = gui_menu_magicwand.get_container_name,
		open_submenu_for_player_function = gui_menu_magicwand.create_or_destroy_menu_for_player,
		update_accessibility_for_player_function = gui_menu_magicwand.update_menu_accessibility_according_to_access_right_for_player
	},
	modding =
	{
		button_name = creative_mode_defines.names.gui.main_menu_open_modding_button,
		button_caption = {"gui.creative-mode_modding"},
		get_player_can_access_function = rights.can_player_access_modding_menu,
		get_submenu_container_name_function = gui_menu_modding.get_container_name,
		open_submenu_for_player_function = gui_menu_modding.create_or_destroy_menu_for_player,
		update_accessibility_for_player_function = nil
	},
	admin =
	{
		button_name = creative_mode_defines.names.gui.main_menu_open_admin_button,
		button_caption = {"gui.creative-mode_admin"},
		get_player_can_access_function = function(player) return player.admin end,
		get_submenu_container_name_function = gui_menu_admin.get_container_name,
		open_submenu_for_player_function = gui_menu_admin.create_or_destroy_menu_for_player,
		update_accessibility_for_player_function = nil
	}
}

-- Destroys the Creative Mode main menu for the given player if it is already opened.
function gui_menu.destroy_main_menu_for_player(player)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		container.destroy()
	end
end

-- Closes the submenu of given name for the given player if the menu is opened.
local function close_submenu_for_player(player, submenu_container_name)
	local left = mod_gui.get_frame_flow(player)
	-- Container.
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		local submenu_container = container[submenu_container_name]
		if submenu_container then
			submenu_container.destroy()
		end
	end
end

-- Opens the given magic wand menu for the given player. Other submenus will be closed.
-- Returns whether the given menu has not been opened yet and is now opened.
local function show_magic_wand_menu_for_player(player, magic_wand_menu_gui_data)
	local magic_wand_submenu_gui_data = submenus_gui_data.magic_wand
	-- Close other submenus.
	for _, data in pairs(submenus_gui_data) do
		if data ~= magic_wand_submenu_gui_data then
			close_submenu_for_player(player, data.get_submenu_container_name_function())
		end
	end
	-- Open the menu and close other magic wand menus.
	magic_wand_submenu_gui_data.open_submenu_for_player_function(player, false)
	return gui_menu_magicwand.open_magic_wand_menu_for_player_and_close_others(player, magic_wand_menu_gui_data)
end

-- If the given player is holding a magic wand, opens the corresponding page for it immediately and closes other submenus.
-- Returns whether the magic wand menu is opened because player is holding the magic wand and such menu has not been opened yet.
local function show_magic_wand_menu_for_player_by_cursor_stack(player)
	local cursor_stack = player.cursor_stack
	if cursor_stack and cursor_stack.valid_for_read then -- cursor_stack is nil if player is respawning.
		local cursor_stack_name = cursor_stack.name
		if cursor_stack_name == creative_mode_defines.names.items.magic_wand_creator then
			return show_magic_wand_menu_for_player(player, gui_menu_magicwand.magic_wand_menus_gui_data.creator)
			
		elseif cursor_stack_name == creative_mode_defines.names.items.magic_wand_healer then
			return show_magic_wand_menu_for_player(player, gui_menu_magicwand.magic_wand_menus_gui_data.healer)
			
		elseif cursor_stack_name == creative_mode_defines.names.items.magic_wand_modifier then
			return show_magic_wand_menu_for_player(player, gui_menu_magicwand.magic_wand_menus_gui_data.modifier)
		end
	end
	return false
end

-- Creates the Creative Mode main menu for the given player. If the menu already exists and is visible, it will be hidden instead.
local function create_or_hide_main_menu_for_player(player)
	local left = mod_gui.get_frame_flow(player)
	
	-- Container.
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		if container.visible ~= false then
			-- The container is visible. If the player is holding a magic wand and its menu is not opened, open it.
			if not show_magic_wand_menu_for_player_by_cursor_stack(player) then
				-- The menu is already opened. Hide the whole main menu.
				container.visible = false
			end
		else
            -- This works, but has the side-effect of the menu closing when the player tries to open inventory.
            --player.opened = container
			-- The container is invisible. Show it.
			container.visible = true
			-- Magic wand menu.
			show_magic_wand_menu_for_player_by_cursor_stack(player)
		end
	else
		container = left.add{type = "flow", name = creative_mode_defines.names.gui.main_menu_container, style = creative_mode_defines.names.gui_styles.no_horizontal_spacing_flow, direction = "horizontal"}
        -- This works, but has the side-effect of the menu closing when the player tries to open inventory.
        --player.opened = container
		-- Frame.
		local frame = container.add{type = "frame", name = creative_mode_defines.names.gui.main_menu_frame, direction = "vertical", caption = {"gui.creative-mode"}}
		-- Buttons.
		for _, data in pairs(submenus_gui_data) do
			local button = frame.add
			{
				type = "button",
				name = data.button_name,
				style = creative_mode_defines.names.gui_styles.main_menu_button,
				caption = data.button_caption
			}
			button.visible = data.get_player_can_access_function(player)
		end
		
		-- Magic wand menu.
		show_magic_wand_menu_for_player_by_cursor_stack(player)
	end
end

--------------------------------------------------------------------

-- Updates the menu accessibility according to the newest access right for all players after the access rights of the given codes have changed.
function gui_menu.update_menu_accessibility_according_to_access_right_for_all_players(updated_access_right_codes)
	for _, player in pairs(game.players) do	
		if gui_menu.create_or_destroy_main_menu_open_button_for_player(player) then
			-- The Creative Menu is still available for the player.
			-- Update submenus.
			local container = mod_gui.get_frame_flow(player)[creative_mode_defines.names.gui.main_menu_container]
			if container then
				local frame = container[creative_mode_defines.names.gui.main_menu_frame]
				if frame then
					for _, data in pairs(submenus_gui_data) do
						if data.get_player_can_access_function(player) then
							-- The player can access the menu.
							-- Make sure the button is available for him/her.
							local button = frame[data.button_name]
							if button then
								button.visible = true
							end
							-- Update the accessibility of its contents if necessary.
							local submenu_container = container[data.get_submenu_container_name_function()]
							if submenu_container then
								if data.update_accessibility_for_player_function then
									data.update_accessibility_for_player_function(player, updated_access_right_codes)
								end
							end
						else
							-- It should be destroyed.
							-- Hide menu button.
							local button = frame[data.button_name]
							if button then
								button.visible = false
							end
							-- Destroy menu.
							close_submenu_for_player(player, data.get_submenu_container_name_function())
						end
					end
				end
			end
		end
	end
end

--------------------------------------------------------------------

function gui_menu.on_player_cursor_stack_changed(event)
    --[=[
    -- sort-of working way to open the magic wand menu when you pick it up, and close when you put it down, but only works the first time you pick it up
    local player = game.players[event.player_index]
    local left = mod_gui.get_frame_flow(player)
    local container = left[creative_mode_defines.names.gui.main_menu_container]
    if show_magic_wand_menu_for_player_by_cursor_stack(player) then
        if not((container ~= nil) and container.visible) then
            create_or_hide_main_menu_for_player(player)
        end
    else
        if container and container.visible then
            create_or_hide_main_menu_for_player(player)
        end 
    else
    
    end
    --]=]
end

-- Updates GUI when a player joined the game.
function gui_menu.on_player_joined_game(event)
	-- Closes the Creative Mode main menu if it is opened for that player.
	-- He may have opened it before and now comes back to this game.
	-- Many problems can be solved by this. >:D
	local player = game.players[event.player_index]
	gui_menu.destroy_main_menu_for_player(player)
	
	-- Also destroy the modifier popup.
	gui_menu_magicwand.create_or_destroy_modification_popup_for_player(player, false)
	
	gui_menu_cheats.on_player_joined_game(event)
end

-- Updates GUI when a player left the game.
function gui_menu.on_player_left_game(event)
	gui_menu_cheats.on_player_left_game(event)
end

-- Updates GUI when a player went to another surface.
function gui_menu.on_player_changed_surface(event)
	gui_menu_cheats.on_player_changed_surface(event)
end

-- Callback of the on_gui_click event, extended from gui.lua.
-- Returns whether the event is consumed.
function gui_menu.on_gui_click(element, element_name, player, button, alt, control, shift)
	if element_name == creative_mode_defines.names.gui.main_menu_open_button then
		-- Main menu open button.
		create_or_hide_main_menu_for_player(player)
		return true
	end
		
	--------------------------------------------------------------------
	
	for _, data in pairs(submenus_gui_data) do
		if element_name == data.button_name then
			-- Submenu button.
			
			-- Close other submenus.
			for _, data2 in pairs(submenus_gui_data) do
				if data ~= data2 then
					close_submenu_for_player(player, data2.get_submenu_container_name_function())
				end
			end
			-- Open the submenu.
			data.open_submenu_for_player_function(player)
			return true
		end
	end
	
	---------------------------------------------------------------------------------------------------
	
	-- Further extend the event to sub-menus.
	if gui_menu_cheats.on_gui_click(element, element_name, player, button, alt, control, shift) then
		return true
	end
	if gui_menu_magicwand.on_gui_click(element, element_name, player, button, alt, control, shift) then
		return true
	end
	if gui_menu_modding.on_gui_click(element, element_name, player, button, alt, control, shift) then
		return true
	end
	if gui_menu_admin.on_gui_click(element, element_name, player, button, alt, control, shift) then
		return true
	end
	return false
end

-- Callback of the on_gui_text_changed event, extended from gui.lua.
-- Returns whether the event is consumed.
function gui_menu.on_gui_text_changed(element, element_name, player)
	-- Further extend the event to sub-menus.
	if gui_menu_cheats.on_gui_text_changed(element, element_name, player) then
		return true
	end
	if gui_menu_magicwand.on_gui_text_changed(element, element_name, player) then
		return true
	end
	if gui_menu_modding.on_gui_text_changed(element, element_name, player) then
		return true
	end
	if gui_menu_admin.on_gui_text_changed(element, element_name, player) then
		return true
	end
	return false
end

-- Callback of the on_gui_checked_state_changed event, extended from gui.lua.
-- Returns whether the event is consumed.
function gui_menu.on_gui_checked_state_changed(element, element_name, player)
	-- Further extend the event to sub-menus.
	if gui_menu_cheats.on_gui_checked_state_changed(element, element_name, player) then
		return true
	end
	if gui_menu_magicwand.on_gui_checked_state_changed(element, element_name, player) then
		return true
	end
	if gui_menu_modding.on_gui_checked_state_changed(element, element_name, player) then
		return true
	end
	if gui_menu_admin.on_gui_checked_state_changed(element, element_name, player) then
		return true
	end
	return false
end

-- Callback of the on_gui_selection_state_changed event, extended from gui.lua.
-- Returns whether the event is consumed.
function gui_menu.on_gui_selection_state_changed(element, element_name, player)
	-- Further extend the event to sub-menus.
	if gui_menu_magicwand.on_gui_selection_state_changed(element, element_name, player) then
		return true
	end
	return false
end