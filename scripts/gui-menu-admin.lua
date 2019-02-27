require("scripts.rights")

-- This file contains variables and functions related to Creative Mode menu - admin GUI.
if not gui_menu_admin then gui_menu_admin = {} end

-- Gets the name of the admin menu container.
function gui_menu_admin.get_container_name()
	return creative_mode_defines.names.gui.admin_menus_container
end

------

-- GUI data about access right to different features.
local access_rights_gui_data =
{
	personal_cheat =
	{
		is_overall = false,
		container_name = creative_mode_defines.names.gui.access_personal_cheat_container,
		label_name = creative_mode_defines.names.gui.access_personal_cheat_label,
		label_caption = {"gui.creative-mode_personal-cheats"},
		inner_container_name = creative_mode_defines.names.gui.access_personal_cheat_inner_container,
		access_right_code = rights.access_personal_cheats_code,
		options =
		{
			admin_only =
			{
				button_name = creative_mode_defines.names.gui.access_personal_cheat_admin_only_button,
				button_caption = {"gui.creative-mode_access-right-admin-only"},
				button_tooltip = {"gui.creative-mode_access-right-personal-cheat-admin-only-tooltip"},
				value = rights.access_personal_cheats_level.admin_only,
				message_key = "message.creative-mode_access-right-personal-cheat-admin-only"
			},
			free =
			{
				button_name = creative_mode_defines.names.gui.access_personal_cheat_free_button,
				button_caption = {"gui.creative-mode_access-right-personal-cheat-free"},
				button_tooltip = {"gui.creative-mode_access-right-personal-cheat-free-tooltip"},
				value = rights.access_personal_cheats_level.free,
				message_key = "message.creative-mode_access-right-personal-cheat-free"
			}
		},
		get_value_function = function()
			return global.creative_mode.player_rights.access_personal_cheats
		end,
		set_value_function = function(value)
			global.creative_mode.player_rights.access_personal_cheats = value
		end
	},
	team_cheat =
	{
		is_overall = false,
		container_name = creative_mode_defines.names.gui.access_team_cheat_container,
		label_name = creative_mode_defines.names.gui.access_team_cheat_label,
		label_caption = {"gui.creative-mode_team-cheats"},
		inner_container_name = creative_mode_defines.names.gui.access_team_cheat_inner_container,
		access_right_code = rights.access_team_cheats_code,
		options =
		{
			admin_only =
			{
				button_name = creative_mode_defines.names.gui.access_team_cheat_admin_only_button,
				button_caption = {"gui.creative-mode_access-right-admin-only"},
				button_tooltip = {"gui.creative-mode_access-right-team-cheat-admin-only-tooltip"},
				value = rights.access_team_cheats_level.admin_only,
				message_key = "message.creative-mode_access-right-team-cheat-admin-only"
			},
			own_team =
			{
				button_name = creative_mode_defines.names.gui.access_team_cheat_own_team_button,
				button_caption = {"gui.creative-mode_access-right-team-cheat-free-own-team"},
				button_tooltip = {"gui.creative-mode_access-right-team-cheat-free-own-team-tooltip"},
				value = rights.access_team_cheats_level.own_team_only,
				message_key = "message.creative-mode_access-right-team-cheat-free-own-team"
			},
			free =
			{
				button_name = creative_mode_defines.names.gui.access_team_cheat_free_button,
				button_caption = {"gui.creative-mode_access-right-team-cheat-free-all-teams"},
				button_tooltip = {"gui.creative-mode_access-right-team-cheat-free-all-teams-tooltip"},
				value = rights.access_team_cheats_level.free,
				message_key = "message.creative-mode_access-right-team-cheat-free-all-teams"
			}
		},
		get_value_function = function()
			return global.creative_mode.player_rights.access_team_cheats
		end,
		set_value_function = function(value)
			global.creative_mode.player_rights.access_team_cheats = value
		end
	},
	surface_cheat =
	{
		is_overall = false,
		container_name = creative_mode_defines.names.gui.access_surface_cheat_container,
		label_name = creative_mode_defines.names.gui.access_surface_cheat_label,
		label_caption = {"gui.creative-mode_surface-cheats"},
		inner_container_name = creative_mode_defines.names.gui.access_surface_cheat_inner_container,
		access_right_code = rights.access_surface_cheats_code,
		options =
		{
			admin_only =
			{
				button_name = creative_mode_defines.names.gui.access_surface_cheat_admin_only_button,
				button_caption = {"gui.creative-mode_access-right-admin-only"},
				button_tooltip = {"gui.creative-mode_access-right-surface-cheat-admin-only-tooltip"},
				value = rights.access_surface_cheats_level.admin_only,
				message_key = "message.creative-mode_access-right-surface-cheat-admin-only"
			},
			current_surface =
			{
				button_name = creative_mode_defines.names.gui.access_surface_cheat_current_surface_button,
				button_caption = {"gui.creative-mode_access-right-surface-cheat-free-own-surface"},
				button_tooltip = {"gui.creative-mode_access-right-surface-cheat-free-own-surface-tooltip"},
				value = rights.access_surface_cheats_level.current_surface_only,
				message_key = "message.creative-mode_access-right-surface-cheat-free-own-surface"
			},
			free =
			{
				button_name = creative_mode_defines.names.gui.access_surface_cheat_free_button,
				button_caption = {"gui.creative-mode_access-right-surface-cheat-free-all-surfaces"},
				button_tooltip = {"gui.creative-mode_access-right-surface-cheat-free-all-surfaces-tooltip"},
				value = rights.access_surface_cheats_level.free,
				message_key = "message.creative-mode_access-right-surface-cheat-free-all-surfaces"
			}
		},
		get_value_function = function()
			return global.creative_mode.player_rights.access_surface_cheats
		end,
		set_value_function = function(value)
			global.creative_mode.player_rights.access_surface_cheats = value
		end
	},
	global_cheat =
	{
		is_overall = false,
		container_name = creative_mode_defines.names.gui.access_global_cheat_container,
		label_name = creative_mode_defines.names.gui.access_global_cheat_label,
		label_caption = {"gui.creative-mode_global-cheats"},
		inner_container_name = creative_mode_defines.names.gui.access_global_cheat_inner_container,
		access_right_code = rights.access_global_cheats_code,
		options =
		{
			admin_only =
			{
				button_name = creative_mode_defines.names.gui.access_global_cheat_admin_only_button,
				button_caption = {"gui.creative-mode_access-right-admin-only"},
				button_tooltip = {"gui.creative-mode_access-right-global-cheat-admin-only-tooltip"},
				value = rights.access_global_cheats_level.admin_only,
				message_key = "message.creative-mode_access-right-global-cheat-admin-only"
			},
			free =
			{
				button_name = creative_mode_defines.names.gui.access_global_cheat_free_button,
				button_caption = {"gui.creative-mode_access-right-global-cheat-free"},
				button_tooltip = {"gui.creative-mode_access-right-global-cheat-free-tooltip"},
				value = rights.access_global_cheats_level.free,
				message_key = "message.creative-mode_access-right-global-cheat-free"
			}
		},
		get_value_function = function()
			return global.creative_mode.player_rights.access_global_cheats
		end,
		set_value_function = function(value)
			global.creative_mode.player_rights.access_global_cheats = value
		end
	},
	build_options =
	{
		is_overall = false,
		container_name = creative_mode_defines.names.gui.access_build_options_container,
		label_name = creative_mode_defines.names.gui.access_build_options_label,
		label_caption = {"gui.creative-mode_build-options"},
		inner_container_name = creative_mode_defines.names.gui.access_build_options_inner_container,
		access_right_code = rights.access_build_options_code,
		options =
		{
			admin_only =
			{
				button_name = creative_mode_defines.names.gui.access_build_options_admin_only_button,
				button_caption = {"gui.creative-mode_access-right-admin-only"},
				button_tooltip = {"gui.creative-mode_access-right-build-options-admin-only-tooltip"},
				value = rights.access_build_options_level.admin_only,
				message_key = "message.creative-mode_access-right-build-options-admin-only"
			},
			no_team =
			{
				button_name = creative_mode_defines.names.gui.access_build_options_no_team_button,
				button_caption = {"gui.creative-mode_access-right-build-options-no-team-options"},
				button_tooltip = {"gui.creative-mode_access-right-build-options-no-team-options-tooltip"},
				value = rights.access_build_options_level.no_team_options,
				message_key = "message.creative-mode_access-right-build-options-no-team-options"
			},
			free =
			{
				button_name = creative_mode_defines.names.gui.access_build_options_free_button,
				button_caption = {"gui.creative-mode_access-right-build-options-free"},
				button_tooltip = {"gui.creative-mode_access-right-build-options-free-tooltip"},
				value = rights.access_build_options_level.free,
				message_key = "message.creative-mode_access-right-build-options-free"
			}
		},
		get_value_function = function()
			return global.creative_mode.player_rights.access_build_options
		end,
		set_value_function = function(value)
			global.creative_mode.player_rights.access_build_options = value
		end
	},
	creator_magic_wand =
	{
		is_overall = false,
		container_name = creative_mode_defines.names.gui.access_creator_magic_wand_container,
		label_name = creative_mode_defines.names.gui.access_creator_magic_wand_label,
		label_caption = {"gui.creative-mode_access-right-creator-magic-wand"},
		inner_container_name = creative_mode_defines.names.gui.access_creator_magic_wand_inner_container,
		access_right_code = rights.use_creator_magic_wand_code,
		options =
		{
			admin_only =
			{
				button_name = creative_mode_defines.names.gui.access_creator_magic_wand_admin_only_button,
				button_caption = {"gui.creative-mode_access-right-admin-only"},
				button_tooltip = {"gui.creative-mode_access-right-creator-magic-wand-admin-only-tooltip"},
				value = false,
				message_key = "message.creative-mode_access-right-creator-magic-wand-admin-only"
			},
			free =
			{
				button_name = creative_mode_defines.names.gui.access_creator_magic_wand_free_button,
				button_caption = {"gui.creative-mode_access-right-creator-magic-wand-free"},
				button_tooltip = {"gui.creative-mode_access-right-creator-magic-wand-free-tooltip"},
				value = true,
				message_key = "message.creative-mode_access-right-creator-magic-wand-free"
			}
		},
		get_value_function = function()
			return global.creative_mode.player_rights.use_creator_magic_wand
		end,
		set_value_function = function(value)
			global.creative_mode.player_rights.use_creator_magic_wand = value
		end
	},
	healer_magic_wand =
	{
		is_overall = false,
		container_name = creative_mode_defines.names.gui.access_healer_magic_wand_container,
		label_name = creative_mode_defines.names.gui.access_healer_magic_wand_label,
		label_caption = {"gui.creative-mode_access-right-healer-magic-wand"},
		inner_container_name = creative_mode_defines.names.gui.access_healer_magic_wand_inner_container,
		access_right_code = rights.use_healer_magic_wand_code,
		options =
		{
			admin_only =
			{
				button_name = creative_mode_defines.names.gui.access_healer_magic_wand_admin_only_button,
				button_caption = {"gui.creative-mode_access-right-admin-only"},
				button_tooltip = {"gui.creative-mode_access-right-healer-magic-wand-admin-only-tooltip"},
				value = false,
				message_key = "message.creative-mode_access-right-healer-magic-wand-admin-only"
			},
			free =
			{
				button_name = creative_mode_defines.names.gui.access_healer_magic_wand_free_button,
				button_caption = {"gui.creative-mode_access-right-healer-magic-wand-free"},
				button_tooltip = {"gui.creative-mode_access-right-healer-magic-wand-free-tooltip"},
				value = true,
				message_key = "message.creative-mode_access-right-healer-magic-wand-free"
			}
		},
		get_value_function = function()
			return global.creative_mode.player_rights.use_healer_magic_wand
		end,
		set_value_function = function(value)
			global.creative_mode.player_rights.use_healer_magic_wand = value
		end
	},
	modifier_magic_wand =
	{
		is_overall = false,
		container_name = creative_mode_defines.names.gui.access_modifier_magic_wand_container,
		label_name = creative_mode_defines.names.gui.access_modifier_magic_wand_label,
		label_caption = {"gui.creative-mode_access-right-modifier-magic-wand"},
		inner_container_name = creative_mode_defines.names.gui.access_modifier_magic_wand_inner_container,
		access_right_code = rights.use_modifier_magic_wand_code,
		options =
		{
			admin_only =
			{
				button_name = creative_mode_defines.names.gui.access_modifier_magic_wand_admin_only_button,
				button_caption = {"gui.creative-mode_access-right-admin-only"},
				button_tooltip = {"gui.creative-mode_access-right-modifier-magic-wand-admin-only-tooltip"},
				value = false,
				message_key = "message.creative-mode_access-right-modifier-magic-wand-admin-only"
			},
			free =
			{
				button_name = creative_mode_defines.names.gui.access_modifier_magic_wand_free_button,
				button_caption = {"gui.creative-mode_access-right-modifier-magic-wand-free"},
				button_tooltip = {"gui.creative-mode_access-right-modifier-magic-wand-free-tooltip"},
				value = true,
				message_key = "message.creative-mode_access-right-modifier-magic-wand-free"
			}
		},
		get_value_function = function()
			return global.creative_mode.player_rights.use_modifier_magic_wand
		end,
		set_value_function = function(value)
			global.creative_mode.player_rights.use_modifier_magic_wand = value
		end
	},
	modding_menu =
	{
		is_overall = false,
		container_name = creative_mode_defines.names.gui.access_modding_menu_container,
		label_name = creative_mode_defines.names.gui.access_modding_menu_label,
		label_caption = {"gui.creative-mode_modding"},
		inner_container_name = creative_mode_defines.names.gui.access_modding_menu_inner_container,
		access_right_code = rights.access_modding_menu_code,
		options =
		{
			admin_only =
			{
				button_name = creative_mode_defines.names.gui.access_modding_menu_admin_only_button,
				button_caption = {"gui.creative-mode_access-right-admin-only"},
				button_tooltip = {"gui.creative-mode_access-right-modding-admin-only-tooltip"},
				value = false,
				message_key = "message.creative-mode_access-right-modding-admin-only"
			},
			free =
			{
				button_name = creative_mode_defines.names.gui.access_modding_menu_free_button,
				button_caption = {"gui.creative-mode_access-right-modding-free"},
				button_tooltip = {"gui.creative-mode_access-right-modding-free-tooltip"},
				value = true,
				message_key = "message.creative-mode_access-right-modding-free"
			}
		},
		get_value_function = function()
			return global.creative_mode.player_rights.access_modding_menu
		end,
		set_value_function = function(value)
			global.creative_mode.player_rights.access_modding_menu = value
		end
	},
	
	overall_access_rights =
	{
		is_overall = true,
		container_name = creative_mode_defines.names.gui.overall_access_rights_container,
		label_name = creative_mode_defines.names.gui.overall_access_rights_label,
		label_caption = {"gui.creative-mode_overall-access-rights"},
		inner_container_name = creative_mode_defines.names.gui.overall_access_rights_inner_container,
		access_right_code = nil,
		options =
		{
			admin_only =
			{
				button_name = creative_mode_defines.names.gui.overall_access_rights_admin_only_button,
				button_caption = {"gui.creative-mode_overall-access-rights-admin-only"},
				button_tooltip = nil,
				value = false,	-- Admin-only = false
				message_key = "message.creative-mode_overall-access-rights-admin-only"
			},
			default =
			{
				button_name = creative_mode_defines.names.gui.overall_access_rights_default_button,
				button_caption = {"gui.creative-mode_overall-access-rights-default"},
				button_tooltip = nil,
				value = true,	-- Default = true
				message_key = "message.creative-mode_overall-access-rights-default"
			}
		},
		get_value_function = nil,
		set_value_function = nil
	}
}

------

-- Creates the GUI elements in the given container for the access right of given GUI data.
local function create_access_right_elements_from_data(access_rights_container, access_right_gui_data)
	-- Container.
	local container = access_rights_container.add{type = "flow", name = access_right_gui_data.container_name, style = creative_mode_defines.names.gui_styles.no_vertical_spacing_resize_row_flow, direction = "vertical"}
	-- Label.
	local label = container.add{type = "label", name = access_right_gui_data.label_name, caption = access_right_gui_data.label_caption}
	if access_right_gui_data.is_overall then
		label.style = "caption_label"
	end
	-- Inner container.
	local inner_container = container.add{type = "table", name = access_right_gui_data.inner_container_name, column_count = 1}
	inner_container.style.vertical_spacing = 0
	inner_container.style.left_padding = 16
	-- Options.
	local current_value
	if not access_right_gui_data.is_overall then
		current_value = access_right_gui_data.get_value_function()
	end
	for _, option in pairs(access_right_gui_data.options) do
		local style
		if not access_right_gui_data.is_overall and current_value == option.value then
			style = creative_mode_defines.names.gui_styles.access_right_on_off_button_on
		else
			style = creative_mode_defines.names.gui_styles.access_right_on_off_button_off
		end
		inner_container.add{type = "button", name = option.button_name, style = style, caption = option.button_caption, tooltip = option.button_tooltip}
	end
end

-- Creates the admin menu for the given player. If the menu already exists, it will be destroyed instead.
function gui_menu_admin.create_or_destroy_menu_for_player(player)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		-- Admin container.
		local admin_menus_container = container[gui_menu_admin.get_container_name()]
		if admin_menus_container then
			admin_menus_container.destroy()
		else
			admin_menus_container = container.add{type = "flow", name = gui_menu_admin.get_container_name(), style = creative_mode_defines.names.gui_styles.no_horizontal_spacing_flow, direction = "horizontal"}
			
			-- Access right frame.
			local access_right_frame = admin_menus_container.add{type = "frame", name = creative_mode_defines.names.gui.access_right_frame, direction = "vertical", caption = {"gui.creative-mode_access-right"}}
			-- Label.
			access_right_frame.add{type = "label", name = creative_mode_defines.names.gui.access_right_label, caption = {"gui.creative-mode_select-non-admin-player-access-right"}}
			-- Scroll-pane.
			local access_rights_scorll_pane = access_right_frame.add{type = "scroll-pane", name = creative_mode_defines.names.gui.access_rights_scroll_pane, style = creative_mode_defines.names.gui_styles.cheat_scroll_pane}
			-- Container.
			local access_rights_container = access_rights_scorll_pane.add{type = "table", name = creative_mode_defines.names.gui.access_rights_container, column_count = 2}
			access_rights_container.style.horizontal_spacing = 18
			access_rights_container.style.vertical_spacing = 18
			-- Rights.
			for _, data in pairs(access_rights_gui_data) do
				create_access_right_elements_from_data(access_rights_container, data)
			end
			
			-- Disable Creative Mode frame.
			local disable_creative_mode_frame = admin_menus_container.add{type = "frame", name = creative_mode_defines.names.gui.disable_creative_mode_frame, direction = "vertical", caption = {"gui.creative-mode_disable-creative-mode-title"}, tooltip = {"gui.creative-mode_disable-creative-mode-tooltip"}}
			-- Disable button.
			disable_creative_mode_frame.add{type = "button", name = creative_mode_defines.names.gui.disable_creative_mode_button, style = creative_mode_defines.names.gui_styles.disable_creative_mode_button, caption = {"gui.creative-mode_disable-creative-mode"}}
			-- Disable permanently button.
			disable_creative_mode_frame.add{type = "button", name = creative_mode_defines.names.gui.disable_creative_mode_permanently_button, style = creative_mode_defines.names.gui_styles.disable_creative_mode_button, caption = {"gui.creative-mode_disable-creative-mode-permanently"}}
		end
	end
end

--------------------------------------------------------------------

-- Updates the status of options in the data of given access right GUI data in the given container for the given player.
local function update_access_right_options_status_in_container_for_player(player, access_rights_container, access_right_gui_data)
	if not access_right_gui_data.get_value_function then
		return
	end
	
	-- Container.
	local gui_container = access_rights_container[access_right_gui_data.container_name]
	-- Inner container.
	local gui_inner_container = gui_container[access_right_gui_data.inner_container_name]
	-- Options.
	local current_value = access_right_gui_data.get_value_function()
	for _, option in pairs(access_right_gui_data.options) do
		local style
		if current_value == option.value then
			style = creative_mode_defines.names.gui_styles.access_right_on_off_button_on
		else
			style = creative_mode_defines.names.gui_styles.access_right_on_off_button_off
		end
		gui_inner_container[option.button_name].style = style
	end
end

-- Updates the status of options in the data of given access right GUI data for all players.
local function update_access_right_options_status_in_gui_data_for_all_players(access_right_gui_data)
	if access_right_gui_data.is_overall then
		return
	end
	
	for _, player in pairs(game.players) do
		local left = mod_gui.get_frame_flow(player)
		local container = left[creative_mode_defines.names.gui.main_menu_container]
		if container then
			local admin_menus_container = container[gui_menu_admin.get_container_name()]
			if admin_menus_container then
				-- Access right frame.
				local access_right_frame = admin_menus_container[creative_mode_defines.names.gui.access_right_frame]
				-- Scroll-pane.
				local access_rights_scorll_pane = access_right_frame[creative_mode_defines.names.gui.access_rights_scroll_pane]
				-- Container.
				local access_rights_container = access_rights_scorll_pane[creative_mode_defines.names.gui.access_rights_container]
				update_access_right_options_status_in_container_for_player(player, access_rights_container, access_right_gui_data)
			end
		end
	end
end

-- Updates the status of all access right options for all players.
local function update_all_access_right_options_for_all_players()
	for _, player in pairs(game.players) do
		local left = mod_gui.get_frame_flow(player)
		local container = left[creative_mode_defines.names.gui.main_menu_container]
		if container then
			local admin_menus_container = container[gui_menu_admin.get_container_name()]
			if admin_menus_container then
				-- Access right frame.
				local access_right_frame = admin_menus_container[creative_mode_defines.names.gui.access_right_frame]
				-- Scroll-pane.
				local access_rights_scorll_pane = access_right_frame[creative_mode_defines.names.gui.access_rights_scroll_pane]
				-- Container.
				local access_rights_container = access_rights_scorll_pane[creative_mode_defines.names.gui.access_rights_container]
				for _, access_right_gui_data in pairs(access_rights_gui_data) do
					update_access_right_options_status_in_container_for_player(player, access_rights_container, access_right_gui_data)
				end
			end
		end
	end
end

--------------------------------------------------------------------

-- Callback of the on_gui_click event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_admin.on_gui_click(element, element_name, player, button, alt, control, shift)
	if element_name == creative_mode_defines.names.gui.disable_creative_mode_button then
		-- Disable Creative Mode button.
		gui.show_main_popup(player, gui.main_popup_content_type.disable_creative_mode)
		return true
	elseif element_name == creative_mode_defines.names.gui.disable_creative_mode_permanently_button then
		-- Disable Creative Mode permanently button.
		gui.show_main_popup(player, gui.main_popup_content_type.permanent_disable_creative_mode)
		return true
	end
	
	for _, data in pairs(access_rights_gui_data) do
		for _, option in pairs(data.options) do
			if element_name == option.button_name then
				-- Access right option button.
				if data.is_overall then
					-- Overall access rights button.
					-- Update values.
					if option.value then
						-- Default.
						rights.set_overall_default()
					else
						-- Admin-only.
						rights.set_overall_admin_only()
					end
					
					-- Update GUI and print message.
					update_all_access_right_options_for_all_players()
					-- Get all access right codes.
					local updated_access_right_codes = {}
					for _, data2 in pairs(access_rights_gui_data) do
						if not data2.is_overall then
							updated_access_right_codes[data2.access_right_code] = true
						end
					end
					gui_menu.update_menu_accessibility_according_to_access_right_for_all_players(updated_access_right_codes)
					game.print{option.message_key, player.name}
				else
					-- Single access right button.
					local old_value = data.get_value_function()
					
					-- Update value.
					data.set_value_function(option.value)
					
					-- Update GUI and print message if the value is different.
					if old_value ~= option.value then
						update_access_right_options_status_in_gui_data_for_all_players(data)
						gui_menu.update_menu_accessibility_according_to_access_right_for_all_players{[data.access_right_code] = true }
						game.print{option.message_key, player.name}
					end
				end
				return true
			end
		end
	end
	
	return false
end

-- Callback of the on_gui_text_changed event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_admin.on_gui_text_changed(element, element_name, player)
	return false
end

-- Callback of the on_gui_checked_state_changed event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_admin.on_gui_checked_state_changed(element, element_name, player)
	return false
end