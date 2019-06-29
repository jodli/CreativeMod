-- This file contains variables and functions related to generic GUI (e.g. popups) and GUI events.
local mod_gui = require("mod-gui")
if not gui then
	gui = {}
end

-- Possible main popup content types. Used in show_main_popup function.
gui.main_popup_content_type = {
	enable_creative_mode = 1,
	disable_creative_mode = -1,
	permanent_disable_creative_mode = -2
}

function gui.on_gui_closed(event)
	local gui_type = event.gui_type
	local element = event.element
	local player = game.players[event.player_index]
	if (gui_type == defines.gui_type.custom) and element then
		local element_name = string.match(element.name, creative_mode_defines.match_patterns.gui.all)
		if element_name then
			element.visible = false
			player.play_sound {path = "utility/gui_click"}
		end
	end
end

-- Destroys the more cheats popup for all players.
-- It is a legacy GUI that we don't support anymore.
-- This function is still here for destroying such GUI in case some players are still opening it in old saves.
function gui.destroy_more_cheats_popup()
	for _, player in pairs(game.players) do
		local center = player.gui.center
		local popup = center[creative_mode_defines.names.gui.popup]
		if popup then
			local cheats_table = popup[creative_mode_defines.names.gui.cheats_table]
			if cheats_table then
				popup.destroy()
			end
		end
	end
end

-- Shows a generic yes/no popup with elements of given names for the given player.
local function show_yes_no_popup(
	player,
	frame_name,
	frame_caption,
	btn_container_name,
	yes_btn_name,
	no_btn_name,
	label_1_data,
	label_2_data)
	local center = player.gui.center
	local popup = center.add {type = "frame", name = frame_name, direction = "vertical", caption = frame_caption}

	if label_1_data then
		local label =
			popup.add {type = "label", name = creative_mode_defines.names.gui.popup_label, caption = label_1_data.caption}
		label.style.font_color = label_1_data.font_color
	end

	if label_2_data then
		local label =
			popup.add {type = "label", name = creative_mode_defines.names.gui.popup_label2, caption = label_2_data.caption}
		label.style.font_color = label_2_data.font_color
	end

	local buttons_container = popup.add {type = "flow", name = btn_container_name, direction = "horizontal"}

	if yes_btn_name then
		buttons_container.add {
			type = "button",
			name = yes_btn_name,
			style = "dialog_button",
			caption = creative_mode_defines.names.gui_captions.yes
		}
	end
	if no_btn_name then
		buttons_container.add {
			type = "button",
			name = no_btn_name,
			style = "dialog_button",
			caption = creative_mode_defines.names.gui_captions.no
		}
	end
end

-- Shows the main popup for the given player.
function gui.show_main_popup(player, main_popup_content_type)
	if main_popup_content_type == gui.main_popup_content_type.enable_creative_mode then
		-- Enable Creative Mode?
		global.creative_mode.has_asked_for_enable = true

		local center = player.gui.center
		local popup =
			center.add {
			type = "frame",
			name = creative_mode_defines.names.gui.popup,
			direction = "vertical",
			caption = {"gui.creative-mode_ask-enable-creative-mode"}
		}
		local buttons_container =
			popup.add {type = "table", name = creative_mode_defines.names.gui.popup_buttons_container, column_count = 2}

		local button_style = creative_mode_defines.names.gui_styles.long_dialog_button
		-- Yes.
		buttons_container.add {
			type = "button",
			name = creative_mode_defines.names.gui.enable_creative_mode_yes,
			style = button_style,
			caption = creative_mode_defines.names.gui_captions.yes
		}
		-- Yes with cheats.
		buttons_container.add {
			type = "button",
			name = creative_mode_defines.names.gui.enable_creative_mode_yes_with_cheats,
			style = button_style,
			caption = {"gui.creative-mode_enable-creative-mode-with-cheats-button"},
			tooltip = {"gui.creative-mode_enable-creative-mode-with-cheats-button-tooltip"}
		}
		-- No.
		buttons_container.add {
			type = "button",
			name = creative_mode_defines.names.gui.enable_creative_mode_no,
			style = button_style,
			caption = {"gui.creative-mode_dont-enable-creative-mode-button"},
			tooltip = {"gui.creative-mode_dont-enable-creative-mode-button-tooltip"}
		}
		-- No permanently.
		buttons_container.add {
			type = "button",
			name = creative_mode_defines.names.gui.enable_creative_mode_no_permanently,
			style = button_style,
			caption = {"gui.creative-mode_dont-enable-creative-mode-permanently-button"},
			tooltip = {"gui.creative-mode_dont-enable-creative-mode-permanently-button-tooltip"}
		}
	elseif main_popup_content_type == gui.main_popup_content_type.disable_creative_mode then
		-- Disable Creative Mode?
		show_yes_no_popup(
			player,
			creative_mode_defines.names.gui.popup,
			{"gui.creative-mode_ask-disable-creative-mode"},
			creative_mode_defines.names.gui.popup_buttons_container,
			creative_mode_defines.names.gui.disable_creative_mode_yes,
			creative_mode_defines.names.gui.disable_creative_mode_no,
			{
				caption = {"gui.creative-mode_disable-creative-mode-info"},
				font_color = {r = 1, g = 1, b = 1}
			},
			{
				caption = remote_interface.command_enable,
				font_color = {r = 1, g = 1, b = 1}
			}
		)
	elseif main_popup_content_type == gui.main_popup_content_type.permanent_disable_creative_mode then
		-- Permanently disable Creative Mode?
		show_yes_no_popup(
			player,
			creative_mode_defines.names.gui.popup,
			{"gui.creative-mode_ask-permanently-disable-creative-mode"},
			creative_mode_defines.names.gui.popup_buttons_container,
			creative_mode_defines.names.gui.permanent_disable_creative_mode_yes,
			creative_mode_defines.names.gui.permanent_disable_creative_mode_no,
			{
				caption = {"gui.creative-mode_permanently-disable-creative-mode-info"},
				font_color = {r = 0.98, g = 0.66, b = 0.22}
			},
			nil
		)
	end
end

-- Destroys the main popup for the given player.
local function destroy_main_popup_for_player(player)
	local popup = player.gui.center[creative_mode_defines.names.gui.popup]
	if popup then
		popup.destroy()
	end
end

-- Destroys the main popup for all players.
local function destroy_main_popup_for_all_players()
	for _, player in pairs(game.players) do
		destroy_main_popup_for_player(player)
	end
end

--------------------------------------------------------------------

-- Updates GUI when a player joined the game.
function gui.on_player_joined_game(event)
	gui_menu.on_player_joined_game(event)
end

-- Updates GUI when a player left the game.
function gui.on_player_left_game(event)
	gui_menu.on_player_left_game(event)
end

-- Updates GUI when a player went to another surface.
function gui.on_player_changed_surface(event)
	gui_menu.on_player_changed_surface(event)
end

function gui.on_player_cursor_stack_changed(event)
	gui_menu.on_player_cursor_stack_changed(event)
end

-- Records the entity each player is openeing in every tick.
-- Creates or destroys entity GUI accordingly.
function gui.tick()
	for _, player in pairs(game.players) do
		if player.connected then
			local current_opened_entity = player.opened
			local last_opened_entity = global.creative_mode.player_opened_entities[player.index]
			-- Different entities.
			if current_opened_entity ~= last_opened_entity then
				-- Destroy the opened GUI for the last entity.
				gui_entity.create_or_destroy_gui_of_entity(player, last_opened_entity, false)
				-- Create GUI for the currently opened entity if there is any.
				if current_opened_entity ~= nil then
					gui_entity.create_or_destroy_gui_of_entity(player, current_opened_entity, true)
				end
			end
		else
			global.creative_mode.player_opened_entities[player.index] = nil
		end
	end
end

-- Callback of the on_gui_click event, which is invoked when a GUI element is clicked by any player.
function gui.on_gui_click(event)
	local element = event.element
	local element_name = element.name
	local player = game.players[event.player_index]
	local button = event.button
	local alt = event.alt
	local control = event.control
	local shift = event.shift

	if element_name == creative_mode_defines.names.gui.enable_creative_mode_yes then
		-- Enable Creative Mode? Yes
		destroy_main_popup_for_all_players()
		cheats.enable_or_disable_creative_mode(player, true, false, false, false)
		return
	elseif element_name == creative_mode_defines.names.gui.enable_creative_mode_yes_with_cheats then
		-- Enable Creative Mode? Yes, with cheats
		destroy_main_popup_for_all_players()
		cheats.enable_or_disable_creative_mode(player, true, false, true, false)
		return
	elseif element_name == creative_mode_defines.names.gui.enable_creative_mode_no then
		-- Enable Creative Mode? No
		destroy_main_popup_for_player(player)
		return
	elseif element_name == creative_mode_defines.names.gui.enable_creative_mode_no_permanently then
		-- Enable Creative Mode? No permanently
		destroy_main_popup_for_all_players()
		cheats.enable_or_disable_creative_mode(player, false, true, false, true)
		return
	elseif element_name == creative_mode_defines.names.gui.disable_creative_mode_yes then
		-- Disable Creative Mode? Yes
		destroy_main_popup_for_all_players()
		cheats.enable_or_disable_creative_mode(player, false, false, false, false)
		return
	elseif element_name == creative_mode_defines.names.gui.disable_creative_mode_no then
		-- Disable Creative Mode? No
		destroy_main_popup_for_player(player)
		return
	elseif element_name == creative_mode_defines.names.gui.permanent_disable_creative_mode_yes then
		-- Permanently disable Creative Mode? Yes
		destroy_main_popup_for_all_players()
		cheats.enable_or_disable_creative_mode(player, false, true, false, true)
		return
	elseif element_name == creative_mode_defines.names.gui.permanent_disable_creative_mode_no then
		-- Permanently disable Creative Mode? No
		destroy_main_popup_for_player(player)
		return
	end

	--------------------------------------------------------------------

	-- Extend the event to menu GUI.
	if gui_menu.on_gui_click(element, element_name, player, button, alt, control, shift) then
		return
	end

	--------------------------------------------------------------------

	-- Extend the event to entity GUI.
	gui_entity.on_gui_click(element, element_name, player, button, alt, control, shift)
end

-- Callback of the on_gui_text_changed event, which is invoked when the text of GUI element is changed by any player.
function gui.on_gui_text_changed(event)
	local element = event.element
	local element_name = element.name
	local player = game.players[event.player_index]

	-- Extend the event to menu GUI.
	if gui_menu.on_gui_text_changed(element, element_name, player) then
		return
	end

	--------------------------------------------------------------------

	-- Extend the event to entity GUI.
	gui_entity.on_gui_text_changed(element, element_name, player)
end

-- Callback of the on_gui_checked_state_changed event, which is invoked when the checked state of GUI element is changed by any player.
function gui.on_gui_checked_state_changed(event)
	local element = event.element
	local element_name = element.name
	local player = game.players[event.player_index]

	-- Extend the event to menu GUI.
	if gui_menu.on_gui_checked_state_changed(element, element_name, player) then
		return
	end

	--------------------------------------------------------------------

	-- Extend the event to entity GUI.
	gui_entity.on_gui_checked_state_changed(element, element_name, player)
end

-- Callback of the on_gui_selection_state_changed event, which is invoked when the selection state of GUI element is changed by any player.
function gui.on_gui_selection_state_changed(event)
	local element = event.element
	local element_name = element.name
	local player = game.players[event.player_index]

	-- Extend the event to menu GUI.
	if gui_menu.on_gui_selection_state_changed(element, element_name, player) then
		return
	end
end
