local mod_gui = require("mod-gui")

-- This file contains variables and functions related to Creative Mode menu - cheats GUI.
if not gui_menu_cheats then
	gui_menu_cheats = {}
end
-- Because the build options menu share the same logic as the cheats menu, we put them together in this file.
if not gui_menu_buildoptions then
	gui_menu_buildoptions = {}
end

-- Gets the name of the cheats menu container.
function gui_menu_cheats.get_container_name()
	return creative_mode_defines.names.gui.cheats_menus_container
end

-- Gets the name of the build options menu container.
function gui_menu_buildoptions.get_container_name()
	return creative_mode_defines.names.gui.build_options_menus_container
end

-----

-- Possible cheat GUI type.
gui_menu_cheats.cheat_gui_type = {
	-- Cheat with on/off buttons.
	on_off = 0,
	-- Cheat with numeric input and then an apply button.
	numeric_apply = 10,
	-- Cheat with string input and then an apply button.
	string_apply = 15,
	-- Cheat with only a single apply button.
	apply = 20,
	-- Cheat with a drop down of team selection without any apply button.
	team_target_auto_apply = 30,
}

-- GUI data about the whole personal cheats menu.
local personal_cheats_menu_gui_data = {
	-- The cheats menus data this menu data belongs to. It will be set later.
	parent = nil,
	-- Menu structure.
	frame = {
		name = creative_mode_defines.names.gui.personal_cheats_menu_frame,
		caption = { "gui.creative-mode_personal-cheats" },
		outer_container = {
			name = creative_mode_defines.names.gui.personal_cheats_outer_container,
			targets_scroll_pane = {
				name = creative_mode_defines.names.gui.personal_cheats_targets_scroll_pane,
				outer_container = {
					name = creative_mode_defines.names.gui.personal_cheats_targets_container,
					inner_container = {
						name = creative_mode_defines.names.gui.personal_cheats_targets_inner_container,
						target_button = {
							name_prefix = creative_mode_defines.names.gui.personal_cheats_target_index_button_prefix,
						},
						select_all_button = {
							name = creative_mode_defines.names.gui.personal_cheats_targets_select_all_button,
						},
					},
				},
			},
			cheats_scroll_pane = {
				name = creative_mode_defines.names.gui.personal_cheats_cheats_scroll_pane,
				cheats_container = {
					name = creative_mode_defines.names.gui.personal_cheats_cheats_container,
					enable_disable_all_container = { -- Set it to nil if no such buttons.
						name = creative_mode_defines.names.gui.personal_cheats_all_button_container,
						enable_all_button_name = creative_mode_defines.names.gui.personal_cheats_enable_all_button,
						disable_all_button_name = creative_mode_defines.names.gui.personal_cheats_disable_all_button,
					},
					notes = {
						not_included_in_enable_all = {
							name = creative_mode_defines.names.gui.personal_cheats_not_included_in_enable_all_note,
							caption = { "gui.creative-mode_not-included-in-enabled-all" },
						},
					},
				},
			},
		},
	},
	-- GUI data for each of the cheats. No other data except cheat GUI data can be put inside.
	cheats_gui_data = {
		cheat_mode = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.personal_cheats_data.cheats.cheat_mode,
			container_name = creative_mode_defines.names.gui.cheat_mode_container,
			label_name = creative_mode_defines.names.gui.cheat_mode_label,
			label_caption = { "gui.creative-mode_cheat-mode" },
			label_tooltip = {
				"gui.creative-mode_cheat-mode-tooltip",
				{ "gui.creative-mode_cannot-apply-this-cheat-before-respawned" },
			},
			on_button_name = creative_mode_defines.names.gui.cheat_mode_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.cheat_mode_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
			is_character_cheat = true, -- A character cheat = will update its state when player respawn (also when player die, but we don't do that for now), or when player switch between god mode.
		},
		invincible_player = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.personal_cheats_data.cheats.invincible_player,
			container_name = creative_mode_defines.names.gui.invincible_player_container,
			label_name = creative_mode_defines.names.gui.invincible_player_label,
			label_caption = { "gui.creative-mode_invincible-player" },
			label_tooltip = {
				"gui.creative-mode_invincible-player-tooltip",
				{ "gui.creative-mode_cannot-apply-this-cheat-before-respawned" },
				{ "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" },
			},
			on_button_name = creative_mode_defines.names.gui.invincible_player_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.invincible_player_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
			is_character_cheat = true,
		},
		keep_last_item = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.personal_cheats_data.cheats.keep_last_item,
			container_name = creative_mode_defines.names.gui.keep_last_item_container,
			label_name = creative_mode_defines.names.gui.keep_last_item_label,
			label_caption = { "gui.creative-mode_keep-last-item" },
			label_tooltip = {
				"gui.creative-mode_keep-last-item-tooltip",
				{ "gui.creative-mode_keep-last-item-tooltip2" },
			},
			on_button_name = creative_mode_defines.names.gui.keep_last_item_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.keep_last_item_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
			get_player_can_access_function = nil,
		},
		repair_mined_item = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.personal_cheats_data.cheats.repair_mined_item,
			container_name = creative_mode_defines.names.gui.repair_mined_item_container,
			label_name = creative_mode_defines.names.gui.repair_mined_item_label,
			label_caption = { "gui.creative-mode_repair-mined-item" },
			label_tooltip = {
				"gui.creative-mode_repair-mined-item-tooltip",
				{ "gui.creative-mode_repair-mined-item-tooltip2" },
			},
			on_button_name = creative_mode_defines.names.gui.repair_mined_item_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.repair_mined_item_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
			get_player_can_access_function = nil,
		},
		instant_request = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.personal_cheats_data.cheats.instant_request,
			container_name = creative_mode_defines.names.gui.instant_request_container,
			label_name = creative_mode_defines.names.gui.instant_request_label,
			label_caption = { "gui.creative-mode_instant-request" },
			label_tooltip = {
				"gui.creative-mode_instant-request-tooltip",
				{ "gui.creative-mode_no-effect-in-god-mode" },
			},
			on_button_name = creative_mode_defines.names.gui.instant_request_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.instant_request_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		instant_trash = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.personal_cheats_data.cheats.instant_trash,
			container_name = creative_mode_defines.names.gui.instant_trash_container,
			label_name = creative_mode_defines.names.gui.instant_trash_label,
			label_caption = { "gui.creative-mode_instant-trash" },
			label_tooltip = { "gui.creative-mode_instant-trash-tooltip", { "gui.creative-mode_no-effect-in-god-mode" } },
			on_button_name = creative_mode_defines.names.gui.instant_trash_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.instant_trash_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		instant_blueprint = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.personal_cheats_data.cheats.instant_blueprint,
			container_name = creative_mode_defines.names.gui.instant_blueprint_container,
			label_name = creative_mode_defines.names.gui.instant_blueprint_label,
			label_caption = { "gui.creative-mode_instant-blueprint" },
			label_tooltip = { "gui.creative-mode_instant-blueprint-tooltip" },
			on_button_name = creative_mode_defines.names.gui.instant_blueprint_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.instant_blueprint_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		instant_deconstruction = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.personal_cheats_data.cheats.instant_deconstruction,
			container_name = creative_mode_defines.names.gui.instant_deconstruction_container,
			label_name = creative_mode_defines.names.gui.instant_deconstruction_label,
			label_caption = { "gui.creative-mode_instant-deconstruction" },
			label_tooltip = { "gui.creative-mode_instant-deconstruction-tooltip" },
			on_button_name = creative_mode_defines.names.gui.instant_deconstruction_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.instant_deconstruction_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		reach_distance = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.personal_cheats_data.cheats.reach_distance,
			container_name = creative_mode_defines.names.gui.reach_distance_container,
			label_name = creative_mode_defines.names.gui.reach_distance_label,
			label_caption = { "gui.creative-mode_reach-distance" },
			label_tooltip = {
				"gui.creative-mode_reach-distance-tooltip",
				cheats.default_cheat_values.reach_distance,
				{ "gui.creative-mode_cannot-apply-this-cheat-before-respawned" },
				{ "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.reach_distance_textfield,
			separator_name = creative_mode_defines.names.gui.reach_distance_separator,
			apply_button_name = creative_mode_defines.names.gui.reach_distance_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			is_character_cheat = true,
		},
		build_distance = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.personal_cheats_data.cheats.build_distance,
			container_name = creative_mode_defines.names.gui.build_distance_container,
			label_name = creative_mode_defines.names.gui.build_distance_label,
			label_caption = { "gui.creative-mode_build-distance" },
			label_tooltip = {
				"gui.creative-mode_build-distance-tooltip",
				cheats.default_cheat_values.reach_distance,
				{ "gui.creative-mode_cannot-apply-this-cheat-before-respawned" },
				{ "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.build_distance_textfield,
			separator_name = creative_mode_defines.names.gui.build_distance_separator,
			apply_button_name = creative_mode_defines.names.gui.build_distance_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			is_character_cheat = true,
		},
		resource_reach_distance = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.personal_cheats_data.cheats.resource_reach_distance,
			container_name = creative_mode_defines.names.gui.resource_reach_distance_container,
			label_name = creative_mode_defines.names.gui.resource_reach_distance_label,
			label_caption = { "gui.creative-mode_resource-reach-distance" },
			label_tooltip = {
				"gui.creative-mode_resource-reach-distance-tooltip",
				cheats.default_cheat_values.reach_distance,
				{ "gui.creative-mode_cannot-apply-this-cheat-before-respawned" },
				{ "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.resource_reach_distance_textfield,
			separator_name = creative_mode_defines.names.gui.resource_reach_distance_separator,
			apply_button_name = creative_mode_defines.names.gui.resource_reach_distance_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			is_character_cheat = true,
		},
		item_drop_distance = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.personal_cheats_data.cheats.item_drop_distance,
			container_name = creative_mode_defines.names.gui.item_drop_distance_container,
			label_name = creative_mode_defines.names.gui.item_drop_distance_label,
			label_caption = { "gui.creative-mode_item-drop-distance" },
			label_tooltip = {
				"gui.creative-mode_item-drop-distance-tooltip",
				cheats.default_cheat_values.reach_distance,
				{ "gui.creative-mode_cannot-apply-this-cheat-before-respawned" },
				{ "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.item_drop_distance_textfield,
			separator_name = creative_mode_defines.names.gui.item_drop_distance_separator,
			apply_button_name = creative_mode_defines.names.gui.item_drop_distance_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			is_character_cheat = true,
		},
		item_pickup_distance = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.personal_cheats_data.cheats.item_pickup_distance,
			container_name = creative_mode_defines.names.gui.item_pickup_distance_container,
			label_name = creative_mode_defines.names.gui.item_pickup_distance_label,
			label_caption = { "gui.creative-mode_item-pickup-distance" },
			label_tooltip = {
				"gui.creative-mode_item-pickup-distance-tooltip",
				{ "gui.creative-mode_cannot-apply-this-cheat-before-respawned" },
				{ "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.item_pickup_distance_textfield,
			separator_name = creative_mode_defines.names.gui.item_pickup_distance_separator,
			apply_button_name = creative_mode_defines.names.gui.item_pickup_distance_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			is_character_cheat = true,
		},
		loot_pickup_distance = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.personal_cheats_data.cheats.loot_pickup_distance,
			container_name = creative_mode_defines.names.gui.loot_pickup_distance_container,
			label_name = creative_mode_defines.names.gui.loot_pickup_distance_label,
			label_caption = { "gui.creative-mode_loot-pickup-distance" },
			label_tooltip = {
				"gui.creative-mode_loot-pickup-distance-tooltip",
				{ "gui.creative-mode_cannot-apply-this-cheat-before-respawned" },
				{ "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.loot_pickup_distance_textfield,
			separator_name = creative_mode_defines.names.gui.loot_pickup_distance_separator,
			apply_button_name = creative_mode_defines.names.gui.loot_pickup_distance_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			is_character_cheat = true,
		},
		mining_speed = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.personal_cheats_data.cheats.mining_speed,
			container_name = creative_mode_defines.names.gui.mining_speed_container,
			label_name = creative_mode_defines.names.gui.mining_speed_label,
			label_caption = { "gui.creative-mode_mining-speed" },
			label_tooltip = {
				"gui.creative-mode_mining-speed-tooltip",
				cheats.default_cheat_values.mining_speed,
				{ "gui.creative-mode_cannot-apply-this-cheat-before-respawned" },
				{ "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.mining_speed_textfield,
			separator_name = creative_mode_defines.names.gui.mining_speed_separator,
			apply_button_name = creative_mode_defines.names.gui.mining_speed_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			is_character_cheat = true,
		},
		running_speed = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.personal_cheats_data.cheats.running_speed,
			container_name = creative_mode_defines.names.gui.running_speed_container,
			label_name = creative_mode_defines.names.gui.running_speed_label,
			label_caption = { "gui.creative-mode_running-speed" },
			label_tooltip = {
				"gui.creative-mode_running-speed-tooltip",
				cheats.default_cheat_values.running_speed,
				{ "gui.creative-mode_cannot-apply-this-cheat-before-respawned" },
				{ "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.running_speed_textfield,
			separator_name = creative_mode_defines.names.gui.running_speed_separator,
			apply_button_name = creative_mode_defines.names.gui.running_speed_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			is_character_cheat = true,
		},
		crafting_speed = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.personal_cheats_data.cheats.crafting_speed,
			container_name = creative_mode_defines.names.gui.crafting_speed_container,
			label_name = creative_mode_defines.names.gui.crafting_speed_label,
			label_caption = { "gui.creative-mode_crafting-speed" },
			label_tooltip = {
				"gui.creative-mode_crafting-speed-tooltip",
				{ "gui.creative-mode_no-effect-in-cheat-mode" },
				{ "gui.creative-mode_cannot-apply-this-cheat-before-respawned" },
				{ "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.crafting_speed_textfield,
			separator_name = creative_mode_defines.names.gui.crafting_speed_separator,
			apply_button_name = creative_mode_defines.names.gui.crafting_speed_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			is_character_cheat = true,
		},
		inventory_bonus = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.personal_cheats_data.cheats.inventory_bonus,
			container_name = creative_mode_defines.names.gui.inventory_bonus_container,
			label_name = creative_mode_defines.names.gui.inventory_bonus_label,
			label_caption = { "gui.creative-mode_inventory-bonus" },
			label_tooltip = {
				"gui.creative-mode_inventory-bonus-tooltip",
				{ "gui.creative-mode_cannot-apply-this-cheat-before-respawned" },
				{ "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.inventory_bonus_textfield,
			separator_name = creative_mode_defines.names.gui.inventory_bonus_separator,
			apply_button_name = creative_mode_defines.names.gui.inventory_bonus_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			is_character_cheat = true,
		},
		health_bonus = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.personal_cheats_data.cheats.health_bonus,
			container_name = creative_mode_defines.names.gui.health_bonus_container,
			label_name = creative_mode_defines.names.gui.health_bonus_label,
			label_caption = { "gui.creative-mode_health-bonus" },
			label_tooltip = {
				"gui.creative-mode_health-bonus-tooltip",
				{ "gui.creative-mode_cannot-apply-this-cheat-before-respawned" },
				{ "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.health_bonus_textfield,
			separator_name = creative_mode_defines.names.gui.health_bonus_separator,
			apply_button_name = creative_mode_defines.names.gui.health_bonus_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			is_character_cheat = true,
		},
		god_mode = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.personal_cheats_data.cheats.god_mode,
			container_name = creative_mode_defines.names.gui.god_mode_container,
			label_name = creative_mode_defines.names.gui.god_mode_label,
			label_caption = { "gui.creative-mode_god-mode" },
			label_tooltip = {
				"gui.creative-mode_god-mode-tooltip",
				{ "gui.creative-mode_cannot-apply-this-cheat-before-respawned" },
			},
			on_button_name = creative_mode_defines.names.gui.god_mode_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.god_mode_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
	},
	-- All cheat data. It is used for enabling / disabling all.
	cheats_data = cheats.personal_cheats_data,
	-- Function for getting the unverified target list for the given player when constructing the menu.
	get_unverified_targets_function = function(player)
		if rights.can_player_access_other_non_admin_players_cheats(player) then
			return game.connected_players, nil -- 1st param = list. Each candidate will be further verified.
		else
			return nil, player -- 2nd param = single target. It will not be further verified.
		end
	end,
	-- Function for verifying each candidate in the unverified target list. It is called after get_unverified_targets_function, so no need to check the player's access right to that particular target.
	verify_target_function = function(player, target)
		return target.valid and (target == player or not target.admin)
	end,
	-- Function for verifying a single target that is added in the middle of game. The player's access right to that target should be checked here.
	verify_target_for_insert_function = function(player, target)
		if not target.valid then
			return false
		end
		if target == player then
			return true
		end
		if rights.can_player_access_other_non_admin_players_cheats(player) and not target.admin then
			return true
		end
		return false
	end,
	-- Function for getting the postfix for the target button name.
	get_target_button_name_postfix_function = function(player, target)
		return target.index
	end,
	-- Function for getting the caption for the target button.
	get_target_button_caption_function = function(player, target)
		return target.name
	end,
	-- Function for getting the tooltip for the target button.
	get_target_button_tooltip_function = function(player, target)
		return { "gui.creative-mode_player-name-tooltip", target.name }
	end,
	-- Function for detecting if the target should be marked as self (blue font)
	check_is_target_self_function = function(player, target)
		return player == target
	end,
	-- Function to be called after the target button is added to the list.
	post_create_target_button_function = function(player, target, button)
		button.visible = target.connected -- If target is not connected, but he is here before, just hide the button.
	end,
	-- Function for checking whether the target button is a valid option. It will affect whether the target selection scroll pane should be shown or hidden.
	check_is_target_button_valid_function = function(player, target, button)
		return button.visible ~= false
	end,
	-- Function for checking whether the target button is a valid option without knowing the actual target represented by the button.
	check_is_target_button_valid_unknown_target_function = function(player, button)
		return button.visible ~= false
	end,
	-- Function for getting the actual target represented by the given target button.
	get_button_actual_target_function = function(player, button)
		local player_index =
			string.match(button.name, creative_mode_defines.match_patterns.gui.personal_cheats_target_index_button)
		if player_index then
			player_index = tonumber(player_index)
			return game.players[player_index]
		end
		return nil
	end,
	-- Function for removing the target button for the given player. Returns true if the button should be removed from the container.
	remove_target_button_function = function(player, target, button)
		-- Make sure the button is unselected.
		local button_style_name = button.style.name
		if button_style_name == creative_mode_defines.names.gui_styles.cheat_target_selected_button then
			button.style = creative_mode_defines.names.gui_styles.cheat_target_unselected_button
		elseif button_style_name == creative_mode_defines.names.gui_styles.cheat_target_self_selected_button then
			button.style = creative_mode_defines.names.gui_styles.cheat_target_self_unselected_button
		end
		button.visible = false
		-- In case the player will come back, we don't remove the button.
		return false
	end,
}

-- GUI data about the whole team cheats menu.
local team_cheats_menu_gui_data = {
	parent = nil,
	frame = {
		name = creative_mode_defines.names.gui.team_cheats_menu_frame,
		caption = { "gui.creative-mode_team-cheats" },
		outer_container = {
			name = creative_mode_defines.names.gui.team_cheats_outer_container,
			targets_scroll_pane = {
				name = creative_mode_defines.names.gui.team_cheats_targets_scroll_pane,
				outer_container = {
					name = creative_mode_defines.names.gui.team_cheats_targets_container,
					inner_container = {
						name = creative_mode_defines.names.gui.team_cheats_targets_inner_container,
						target_button = {
							name_prefix = creative_mode_defines.names.gui.team_cheats_target_name_button_prefix,
						},
						select_all_button = {
							name = creative_mode_defines.names.gui.team_cheats_targets_select_all_button,
						},
					},
				},
			},
			cheats_scroll_pane = {
				name = creative_mode_defines.names.gui.team_cheats_cheats_scroll_pane,
				cheats_container = {
					name = creative_mode_defines.names.gui.team_cheats_cheats_container,
					enable_disable_all_container = { -- Set it to nil if no such buttons.
						name = creative_mode_defines.names.gui.team_cheats_all_button_container,
						enable_all_button_name = creative_mode_defines.names.gui.team_cheats_enable_all_button,
						disable_all_button_name = creative_mode_defines.names.gui.team_cheats_disable_all_button,
					},
					notes = {
						not_included_in_enable_all = {
							name = creative_mode_defines.names.gui.team_cheats_not_included_in_enable_all_note,
							caption = { "gui.creative-mode_not-included-in-enabled-all" },
						},
					},
				},
			},
		},
	},
	cheats_gui_data = {
		creative_tools_recipes = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.team_cheats_data.cheats.creative_tools_recipes,
			container_name = creative_mode_defines.names.gui.creative_tools_recipes_container,
			label_name = creative_mode_defines.names.gui.creative_tools_recipes_label,
			label_caption = { "gui.creative-mode_creative-tools-recipes" },
			label_tooltip = { "gui.creative-mode_creative-tools-recipes-tooltip" },
			on_button_name = creative_mode_defines.names.gui.creative_tools_recipes_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.creative_tools_recipes_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		loaders_recipes = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.team_cheats_data.cheats.loaders_recipes,
			container_name = creative_mode_defines.names.gui.loaders_recipes_container,
			label_name = creative_mode_defines.names.gui.loaders_recipes_label,
			label_caption = { "gui.creative-mode_loaders-recipes" },
			label_tooltip = { "gui.creative-mode_loaders-recipes-tooltip" },
			on_button_name = creative_mode_defines.names.gui.loaders_recipes_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.loaders_recipes_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		research_all_technologies = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.team_cheats_data.cheats.research_all_technologies,
			container_name = creative_mode_defines.names.gui.all_technologies_container,
			label_name = creative_mode_defines.names.gui.all_technologies_label,
			label_caption = { "gui.creative-mode_all-technologies" },
			label_tooltip = nil,
			on_button_name = creative_mode_defines.names.gui.all_technologies_unlock_button,
			on_button_caption = creative_mode_defines.names.gui_captions.unlock,
			off_button_name = creative_mode_defines.names.gui.all_technologies_reset_button,
			off_button_caption = creative_mode_defines.names.gui_captions.reset,
		},
		instant_research = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.team_cheats_data.cheats.instant_research,
			container_name = creative_mode_defines.names.gui.instant_research_container,
			label_name = creative_mode_defines.names.gui.instant_research_label,
			label_caption = { "gui.creative-mode_instant-research" },
			label_tooltip = { "gui.creative-mode_instant-research-tooltip" },
			on_button_name = creative_mode_defines.names.gui.instant_research_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.instant_research_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		reach_distance = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.team_cheats_data.cheats.reach_distance,
			container_name = creative_mode_defines.names.gui.team_reach_distance_container,
			label_name = creative_mode_defines.names.gui.team_reach_distance_label,
			label_caption = { "gui.creative-mode_team-reach-distance" },
			label_tooltip = {
				"gui.creative-mode_team-reach-distance-tooltip",
				{ "gui.creative-mode_no-effect-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.team_reach_distance_textfield,
			separator_name = creative_mode_defines.names.gui.team_reach_distance_separator,
			apply_button_name = creative_mode_defines.names.gui.team_reach_distance_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		build_distance = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.team_cheats_data.cheats.build_distance,
			container_name = creative_mode_defines.names.gui.team_build_distance_container,
			label_name = creative_mode_defines.names.gui.team_build_distance_label,
			label_caption = { "gui.creative-mode_team-build-distance" },
			label_tooltip = {
				"gui.creative-mode_team-build-distance-tooltip",
				{ "gui.creative-mode_no-effect-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.team_build_distance_textfield,
			separator_name = creative_mode_defines.names.gui.team_build_distance_separator,
			apply_button_name = creative_mode_defines.names.gui.team_build_distance_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		resource_reach_distance = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.team_cheats_data.cheats.resource_reach_distance,
			container_name = creative_mode_defines.names.gui.team_resource_reach_distance_container,
			label_name = creative_mode_defines.names.gui.team_resource_reach_distance_label,
			label_caption = { "gui.creative-mode_team-resource-reach-distance" },
			label_tooltip = {
				"gui.creative-mode_team-resource-reach-distance-tooltip",
				{ "gui.creative-mode_no-effect-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.team_resource_reach_distance_textfield,
			separator_name = creative_mode_defines.names.gui.team_resource_reach_distance_separator,
			apply_button_name = creative_mode_defines.names.gui.team_resource_reach_distance_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		item_drop_distance = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.team_cheats_data.cheats.item_drop_distance,
			container_name = creative_mode_defines.names.gui.team_item_drop_distance_container,
			label_name = creative_mode_defines.names.gui.team_item_drop_distance_label,
			label_caption = { "gui.creative-mode_team-item-drop-distance" },
			label_tooltip = {
				"gui.creative-mode_team-item-drop-distance-tooltip",
				{ "gui.creative-mode_no-effect-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.team_item_drop_distance_textfield,
			separator_name = creative_mode_defines.names.gui.team_item_drop_distance_separator,
			apply_button_name = creative_mode_defines.names.gui.team_item_drop_distance_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		item_pickup_distance = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.team_cheats_data.cheats.item_pickup_distance,
			container_name = creative_mode_defines.names.gui.team_item_pickup_distance_container,
			label_name = creative_mode_defines.names.gui.team_item_pickup_distance_label,
			label_caption = { "gui.creative-mode_team-item-pickup-distance" },
			label_tooltip = {
				"gui.creative-mode_team-item-pickup-distance-tooltip",
				{ "gui.creative-mode_no-effect-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.team_item_pickup_distance_textfield,
			separator_name = creative_mode_defines.names.gui.team_item_pickup_distance_separator,
			apply_button_name = creative_mode_defines.names.gui.team_item_pickup_distance_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		loot_pickup_distance = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.team_cheats_data.cheats.loot_pickup_distance,
			container_name = creative_mode_defines.names.gui.team_loot_pickup_distance_container,
			label_name = creative_mode_defines.names.gui.team_loot_pickup_distance_label,
			label_caption = { "gui.creative-mode_team-loot-pickup-distance" },
			label_tooltip = {
				"gui.creative-mode_team-loot-pickup-distance-tooltip",
				{ "gui.creative-mode_no-effect-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.team_loot_pickup_distance_textfield,
			separator_name = creative_mode_defines.names.gui.team_loot_pickup_distance_separator,
			apply_button_name = creative_mode_defines.names.gui.team_loot_pickup_distance_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		mining_speed = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.team_cheats_data.cheats.mining_speed,
			container_name = creative_mode_defines.names.gui.team_mining_speed_container,
			label_name = creative_mode_defines.names.gui.team_mining_speed_label,
			label_caption = { "gui.creative-mode_team-mining-speed" },
			label_tooltip = { "gui.creative-mode_team-mining-speed-tooltip" },
			textfield_name = creative_mode_defines.names.gui.team_mining_speed_textfield,
			separator_name = creative_mode_defines.names.gui.team_mining_speed_separator,
			apply_button_name = creative_mode_defines.names.gui.team_mining_speed_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		running_speed = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.team_cheats_data.cheats.running_speed,
			container_name = creative_mode_defines.names.gui.team_running_speed_container,
			label_name = creative_mode_defines.names.gui.team_running_speed_label,
			label_caption = { "gui.creative-mode_team-running-speed" },
			label_tooltip = {
				"gui.creative-mode_team-running-speed-tooltip",
				{ "gui.creative-mode_no-effect-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.team_running_speed_textfield,
			separator_name = creative_mode_defines.names.gui.team_running_speed_separator,
			apply_button_name = creative_mode_defines.names.gui.team_running_speed_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		crafting_speed = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.team_cheats_data.cheats.crafting_speed,
			container_name = creative_mode_defines.names.gui.team_crafting_speed_container,
			label_name = creative_mode_defines.names.gui.team_crafting_speed_label,
			label_caption = { "gui.creative-mode_team-crafting-speed" },
			label_tooltip = {
				"gui.creative-mode_team-crafting-speed-tooltip",
				{ "gui.creative-mode_no-effect-in-cheat-mode" },
				{ "gui.creative-mode_no-effect-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.team_crafting_speed_textfield,
			separator_name = creative_mode_defines.names.gui.team_crafting_speed_separator,
			apply_button_name = creative_mode_defines.names.gui.team_crafting_speed_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		character_inventory_bonus = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.team_cheats_data.cheats.character_inventory_bonus,
			container_name = creative_mode_defines.names.gui.character_inventory_bonus_container,
			label_name = creative_mode_defines.names.gui.character_inventory_bonus_label,
			label_caption = { "gui.creative-mode_character-inventory-bonus" },
			label_tooltip = { "gui.creative-mode_character-inventory-bonus-tooltip" },
			textfield_name = creative_mode_defines.names.gui.character_inventory_bonus_textfield,
			separator_name = creative_mode_defines.names.gui.character_inventory_bonus_separator,
			apply_button_name = creative_mode_defines.names.gui.character_inventory_bonus_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		health_bonus = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.team_cheats_data.cheats.health_bonus,
			container_name = creative_mode_defines.names.gui.character_health_bonus_container,
			label_name = creative_mode_defines.names.gui.character_health_bonus_label,
			label_caption = { "gui.creative-mode_character-health-bonus" },
			label_tooltip = {
				"gui.creative-mode_character-health-bonus-tooltip",
				{ "gui.creative-mode_no-effect-in-god-mode" },
			},
			textfield_name = creative_mode_defines.names.gui.character_health_bonus_textfield,
			separator_name = creative_mode_defines.names.gui.character_health_bonus_separator,
			apply_button_name = creative_mode_defines.names.gui.character_health_bonus_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		inserter_capacity_bonus = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.team_cheats_data.cheats.inserter_capacity_bonus,
			container_name = creative_mode_defines.names.gui.inserter_capacity_bonus_container,
			label_name = creative_mode_defines.names.gui.inserter_capacity_bonus_label,
			label_caption = { "gui.creative-mode_inserter-capacity-bonus" },
			label_tooltip = { "gui.creative-mode_inserter-capacity-bonus-tooltip" },
			textfield_name = creative_mode_defines.names.gui.inserter_capacity_bonus_textfield,
			separator_name = creative_mode_defines.names.gui.inserter_capacity_bonus_separator,
			apply_button_name = creative_mode_defines.names.gui.inserter_capacity_bonus_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		bulk_inserter_capacity_bonus = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.team_cheats_data.cheats.bulk_inserter_capacity_bonus,
			container_name = creative_mode_defines.names.gui.bulk_inserter_capacity_bonus_container,
			label_name = creative_mode_defines.names.gui.bulk_inserter_capacity_bonus_label,
			label_caption = { "gui.creative-mode_bulk-inserter-capacity-bonus" },
			label_tooltip = { "gui.creative-mode_bulk-inserter-capacity-bonus-tooltip" },
			textfield_name = creative_mode_defines.names.gui.bulk_inserter_capacity_bonus_textfield,
			separator_name = creative_mode_defines.names.gui.bulk_inserter_capacity_bonus_separator,
			apply_button_name = creative_mode_defines.names.gui.bulk_inserter_capacity_bonus_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		evolution_factor = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.team_cheats_data.cheats.evolution_factor,
			container_name = creative_mode_defines.names.gui.evolution_factor_container,
			label_name = creative_mode_defines.names.gui.evolution_factor_label,
			label_caption = { "gui.creative-mode_evolution-factor" },
			label_tooltip = { "gui.creative-mode_evolution-factor-tooltip", 0, 1 },
			textfield_name = creative_mode_defines.names.gui.evolution_factor_textfield,
			separator_name = creative_mode_defines.names.gui.evolution_factor_separator,
			apply_button_name = creative_mode_defines.names.gui.evolution_factor_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		chart_all = {
			type = gui_menu_cheats.cheat_gui_type.apply,
			cheat_data = cheats.team_cheats_data.cheats.chart_all,
			container_name = creative_mode_defines.names.gui.chart_all_container,
			label_name = creative_mode_defines.names.gui.chart_all_label,
			label_caption = { "gui.creative-mode_chart-all" },
			label_tooltip = { "gui.creative-mode_chart-all-tooltip" },
			apply_button_name = creative_mode_defines.names.gui.chart_all_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		kill_all_units = {
			type = gui_menu_cheats.cheat_gui_type.apply,
			cheat_data = cheats.team_cheats_data.cheats.kill_all_units,
			container_name = creative_mode_defines.names.gui.kill_all_units_container,
			label_name = creative_mode_defines.names.gui.kill_all_units_label,
			label_caption = { "gui.creative-mode_kill-all-units" },
			label_tooltip = { "gui.creative-mode_kill-all-units-tooltip" },
			apply_button_name = creative_mode_defines.names.gui.kill_all_units_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
	},
	cheats_data = cheats.team_cheats_data,
	get_unverified_targets_function = function(player)
		if rights.can_player_access_other_teams_cheats(player) then
			return game.forces, nil
		else
			return nil, player.force
		end
	end,
	verify_target_function = function(player, target)
		return target.valid
	end,
	verify_target_for_insert_function = function(player, target)
		if not target.valid then
			return false
		end
		if target == player.force then
			return true
		end
		if rights.can_player_access_other_teams_cheats(player) then
			return true
		end
		return false
	end,
	get_target_button_name_postfix_function = function(player, target)
		return target.name
	end,
	get_target_button_caption_function = function(player, target)
		return target.name
	end,
	get_target_button_tooltip_function = function(player, target)
		return { "gui.creative-mode_team-name-tooltip", target.name }
	end,
	check_is_target_self_function = function(player, target)
		return player.force == target
	end,
	post_create_target_button_function = function(player, target, button) end,
	check_is_target_button_valid_function = function(player, target, button)
		return button.visible ~= false
	end,
	check_is_target_button_valid_unknown_target_function = function(player, button)
		return button.visible ~= false
	end,
	get_button_actual_target_function = function(player, button)
		local force_name =
			string.match(button.name, creative_mode_defines.match_patterns.gui.team_cheats_target_name_button)
		if force_name then
			force_name = tostring(force_name)
			return game.forces[force_name]
		end
		return nil
	end,
	remove_target_button_function = function(player, target, button)
		return true
	end,
}

-- GUI data about the whole surface cheats menu.
local surface_cheats_menu_gui_data = {
	parent = nil,
	frame = {
		name = creative_mode_defines.names.gui.surface_cheats_menu_frame,
		caption = { "gui.creative-mode_surface-cheats" },
		outer_container = {
			name = creative_mode_defines.names.gui.surface_cheats_outer_container,
			targets_scroll_pane = {
				name = creative_mode_defines.names.gui.surface_cheats_targets_scroll_pane,
				outer_container = {
					name = creative_mode_defines.names.gui.surface_cheats_targets_container,
					inner_container = {
						name = creative_mode_defines.names.gui.surface_cheats_targets_inner_container,
						target_button = {
							name_prefix = creative_mode_defines.names.gui.surface_cheats_target_name_button_prefix,
						},
						select_all_button = {
							name = creative_mode_defines.names.gui.surface_cheats_targets_select_all_button,
						},
					},
				},
			},
			cheats_scroll_pane = {
				name = creative_mode_defines.names.gui.surface_cheats_cheats_scroll_pane,
				cheats_container = {
					name = creative_mode_defines.names.gui.surface_cheats_cheats_container,
					enable_disable_all_container = nil,
					notes = nil,
				},
			},
		},
	},
	cheats_gui_data = {
		freeze_daytime = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.surface_cheats_data.cheats.freeze_daytime,
			container_name = creative_mode_defines.names.gui.freeze_daytime_container,
			label_name = creative_mode_defines.names.gui.freeze_daytime_label,
			label_caption = { "gui.creative-mode_freeze-daytime" },
			label_tooltip = { "gui.creative-mode_freeze-daytime-tooltip" },
			on_button_name = creative_mode_defines.names.gui.freeze_daytime_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.freeze_daytime_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		daytime = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.surface_cheats_data.cheats.daytime,
			container_name = creative_mode_defines.names.gui.daytime_container,
			label_name = creative_mode_defines.names.gui.daytime_label,
			label_caption = { "gui.creative-mode_daytime" },
			label_tooltip = {
				"gui.creative-mode_daytime-tooltip",
				{ "gui.creative-mode_midday" },
				{ "gui.creative-mode_midnight" },
			},
			textfield_name = creative_mode_defines.names.gui.daytime_textfield,
			separator_name = creative_mode_defines.names.gui.daytime_separator,
			apply_button_name = creative_mode_defines.names.gui.daytime_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			is_daytime_cheat = true,
		},
		daytime_selection = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.surface_cheats_data.cheats.daytime_selection,
			container_name = creative_mode_defines.names.gui.daytime_selection_container,
			label_name = creative_mode_defines.names.gui.daytime_selection_label,
			label_caption = "",
			label_tooltip = nil,
			on_button_name = creative_mode_defines.names.gui.daytime_selection_midday_button,
			on_button_caption = { "gui.creative-mode_midday" },
			off_button_name = creative_mode_defines.names.gui.daytime_selection_midnight_button,
			off_button_caption = { "gui.creative-mode_midnight" },
		},
		peaceful_mode = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.surface_cheats_data.cheats.peaceful_mode,
			container_name = creative_mode_defines.names.gui.peaceful_mode_container,
			label_name = creative_mode_defines.names.gui.peaceful_mode_label,
			label_caption = { "gui.creative-mode_peaceful-mode" },
			label_tooltip = { "gui.creative-mode_peaceful-mode-tooltip" },
			on_button_name = creative_mode_defines.names.gui.peaceful_mode_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.peaceful_mode_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		destroy_all_enemies = {
			type = gui_menu_cheats.cheat_gui_type.apply,
			cheat_data = cheats.surface_cheats_data.cheats.destroy_all_enemies,
			container_name = creative_mode_defines.names.gui.destroy_all_enemies_container,
			label_name = creative_mode_defines.names.gui.destroy_all_enemies_label,
			label_caption = { "gui.creative-mode_destroy-all-enemies" },
			label_tooltip = { "gui.creative-mode_destroy-all-enemies-tooltip" },
			apply_button_name = creative_mode_defines.names.gui.destroy_all_enemies_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		remove_all_enemies = {
			type = gui_menu_cheats.cheat_gui_type.apply,
			cheat_data = cheats.surface_cheats_data.cheats.remove_all_enemies,
			container_name = creative_mode_defines.names.gui.remove_all_enemies_container,
			label_name = creative_mode_defines.names.gui.remove_all_enemies_label,
			label_caption = { "gui.creative-mode_remove-all-enemies" },
			label_tooltip = { "gui.creative-mode_remove-all-enemies-tooltip" },
			apply_button_name = creative_mode_defines.names.gui.remove_all_enemies_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		dont_generate_enemy = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.surface_cheats_data.cheats.dont_generate_enemy,
			container_name = creative_mode_defines.names.gui.dont_generate_enemy_container,
			label_name = creative_mode_defines.names.gui.dont_generate_enemy_label,
			label_caption = { "gui.creative-mode_dont-generate-enemy" },
			label_tooltip = { "gui.creative-mode_dont-generate-enemy-tooltip" },
			on_button_name = creative_mode_defines.names.gui.dont_generate_enemy_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.dont_generate_enemy_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		surface_pressure = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.surface_cheats_data.cheats.pressure,
			container_name = creative_mode_defines.names.gui.surface_pressure_container,
			label_name = creative_mode_defines.names.gui.surface_pressure_label,
			label_caption = { "gui.creative-mode_surface-pressure" },
			label_tooltip = { "gui.creative-mode_surface-pressure-tooltip" },
			textfield_name = creative_mode_defines.names.gui.surface_pressure_textfield,
			separator_name = creative_mode_defines.names.gui.surface_pressure_separator,
			apply_button_name = creative_mode_defines.names.gui.surface_pressure_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		surface_magnetic_field = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.surface_cheats_data.cheats.magnetic_field,
			container_name = creative_mode_defines.names.gui.surface_magnetic_field_container,
			label_name = creative_mode_defines.names.gui.surface_magnetic_field_label,
			label_caption = { "gui.creative-mode_surface-magnetic-field" },
			label_tooltip = { "gui.creative-mode_surface-magnetic-field-tooltip" },
			textfield_name = creative_mode_defines.names.gui.surface_magnetic_field_textfield,
			separator_name = creative_mode_defines.names.gui.surface_magnetic_field_separator,
			apply_button_name = creative_mode_defines.names.gui.surface_magnetic_field_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		surface_gravity = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.surface_cheats_data.cheats.gravity,
			container_name = creative_mode_defines.names.gui.surface_gravity_container,
			label_name = creative_mode_defines.names.gui.surface_gravity_label,
			label_caption = { "gui.creative-mode_surface-gravity" },
			label_tooltip = { "gui.creative-mode_surface-gravity-tooltip" },
			textfield_name = creative_mode_defines.names.gui.surface_gravity_textfield,
			separator_name = creative_mode_defines.names.gui.surface_gravity_separator,
			apply_button_name = creative_mode_defines.names.gui.surface_gravity_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
	},
	cheats_data = cheats.surface_cheats_data,
	get_unverified_targets_function = function(player)
		if rights.can_player_access_other_surfaces_cheats(player) then
			return game.surfaces, nil
		else
			return nil, player.surface
		end
	end,
	verify_target_function = function(player, target)
		return target.valid
	end,
	verify_target_for_insert_function = function(player, target)
		if not target.valid then
			return false
		end
		if target == player.surface then
			return true
		end
		if rights.can_player_access_other_surfaces_cheats(player) then
			return true
		end
		return false
	end,
	get_target_button_name_postfix_function = function(player, target)
		return target.name
	end,
	get_target_button_caption_function = function(player, target)
		return target.name
	end,
	get_target_button_tooltip_function = function(player, target)
		return { "gui.creative-mode_surface-name-tooltip", target.name }
	end,
	check_is_target_self_function = function(player, target)
		return player.surface == target
	end,
	post_create_target_button_function = function(player, target, button) end,
	check_is_target_button_valid_function = function(player, target, button)
		return button.visible ~= false
	end,
	check_is_target_button_valid_unknown_target_function = function(player, button)
		return button.visible ~= false
	end,
	get_button_actual_target_function = function(player, button)
		local surface_name =
			string.match(button.name, creative_mode_defines.match_patterns.gui.surface_cheats_target_name_button)
		if surface_name then
			surface_name = tostring(surface_name)
			return game.surfaces[surface_name]
		end
		return nil
	end,
	remove_target_button_function = function(player, target, button)
		return true
	end,
}

-- GUI data about the whole global cheats menu.
local global_cheats_menu_gui_data = {
	parent = nil,
	frame = {
		name = creative_mode_defines.names.gui.global_cheats_menu_frame,
		caption = { "gui.creative-mode_global-cheats" },
		outer_container = {
			name = creative_mode_defines.names.gui.global_cheats_table,
			targets_scroll_pane = nil, -- No targets.
			cheats_scroll_pane = {
				name = creative_mode_defines.names.gui.global_cheats_cheats_scroll_pane,
				cheats_container = {
					name = creative_mode_defines.names.gui.global_cheats_cheats_container,
					enable_disable_all_container = nil,
					notes = nil,
				},
			},
		},
	},
	cheats_gui_data = {
		pollution = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.global_cheats_data.cheats.pollution,
			container_name = creative_mode_defines.names.gui.pollution_container,
			label_name = creative_mode_defines.names.gui.pollution_label,
			label_caption = { "gui.creative-mode_pollution" },
			label_tooltip = { "gui.creative-mode_pollution-tooltip" },
			on_button_name = creative_mode_defines.names.gui.pollution_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.pollution_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		enemy_evolution = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.global_cheats_data.cheats.enemy_evolution,
			container_name = creative_mode_defines.names.gui.enemy_evolution_container,
			label_name = creative_mode_defines.names.gui.enemy_evolution_label,
			label_caption = { "gui.creative-mode_enemy-evolution" },
			label_tooltip = { "gui.creative-mode_enemy-evolution-tooltip" },
			on_button_name = creative_mode_defines.names.gui.enemy_evolution_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.enemy_evolution_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		evolution_time_factor = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.global_cheats_data.cheats.evolution_time_factor,
			container_name = creative_mode_defines.names.gui.evolution_time_factor_container,
			label_name = creative_mode_defines.names.gui.evolution_time_factor_label,
			label_caption = { "gui.creative-mode_evolution-time-factor" },
			label_tooltip = { "gui.creative-mode_evolution-time-factor-tooltip", 0.000004 },
			textfield_name = creative_mode_defines.names.gui.evolution_time_factor_textfield,
			separator_name = creative_mode_defines.names.gui.evolution_time_factor_separator,
			apply_button_name = creative_mode_defines.names.gui.evolution_time_factor_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		evolution_destroy_factor = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.global_cheats_data.cheats.evolution_destroy_factor,
			container_name = creative_mode_defines.names.gui.evolution_destroy_factor_container,
			label_name = creative_mode_defines.names.gui.evolution_destroy_factor_label,
			label_caption = { "gui.creative-mode_evolution-destroy-factor" },
			label_tooltip = { "gui.creative-mode_evolution-destroy-factor-tooltip", 0.002 },
			textfield_name = creative_mode_defines.names.gui.evolution_destroy_factor_textfield,
			separator_name = creative_mode_defines.names.gui.evolution_destroy_factor_separator,
			apply_button_name = creative_mode_defines.names.gui.evolution_destroy_factor_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		evolution_pollution_factor = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.global_cheats_data.cheats.evolution_pollution_factor,
			container_name = creative_mode_defines.names.gui.evolution_pollution_factor_container,
			label_name = creative_mode_defines.names.gui.evolution_pollution_factor_label,
			label_caption = { "gui.creative-mode_evolution-pollution-factor" },
			label_tooltip = { "gui.creative-mode_evolution-pollution-factor-tooltip", 0.000015 },
			textfield_name = creative_mode_defines.names.gui.evolution_pollution_factor_textfield,
			separator_name = creative_mode_defines.names.gui.evolution_pollution_factor_separator,
			apply_button_name = creative_mode_defines.names.gui.evolution_pollution_factor_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		enemy_expansion = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.global_cheats_data.cheats.enemy_expansion,
			container_name = creative_mode_defines.names.gui.enemy_expansion_container,
			label_name = creative_mode_defines.names.gui.enemy_expansion_label,
			label_caption = { "gui.creative-mode_enemy-expansion" },
			label_tooltip = { "gui.creative-mode_enemy-expansion-tooltip" },
			on_button_name = creative_mode_defines.names.gui.enemy_expansion_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.enemy_expansion_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		enemy_expansion_min_cooldown = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.global_cheats_data.cheats.enemy_expansion_min_cooldown,
			container_name = creative_mode_defines.names.gui.enemy_expansion_min_cooldown_container,
			label_name = creative_mode_defines.names.gui.enemy_expansion_min_cooldown_label,
			label_caption = { "gui.creative-mode_enemy-expansion-min-cooldown" },
			label_tooltip = { "gui.creative-mode_enemy-expansion-min-cooldown-tooltip", 4 * 3600 },
			textfield_name = creative_mode_defines.names.gui.enemy_expansion_min_cooldown_textfield,
			separator_name = creative_mode_defines.names.gui.enemy_expansion_min_cooldown_separator,
			apply_button_name = creative_mode_defines.names.gui.enemy_expansion_min_cooldown_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		enemy_expansion_max_cooldown = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.global_cheats_data.cheats.enemy_expansion_max_cooldown,
			container_name = creative_mode_defines.names.gui.enemy_expansion_max_cooldown_container,
			label_name = creative_mode_defines.names.gui.enemy_expansion_max_cooldown_label,
			label_caption = { "gui.creative-mode_enemy-expansion-max-cooldown" },
			label_tooltip = { "gui.creative-mode_enemy-expansion-max-cooldown-tooltip", 60 * 3600 },
			textfield_name = creative_mode_defines.names.gui.enemy_expansion_max_cooldown_textfield,
			separator_name = creative_mode_defines.names.gui.enemy_expansion_max_cooldown_separator,
			apply_button_name = creative_mode_defines.names.gui.enemy_expansion_max_cooldown_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
		game_speed = {
			type = gui_menu_cheats.cheat_gui_type.numeric_apply,
			cheat_data = cheats.global_cheats_data.cheats.game_speed,
			container_name = creative_mode_defines.names.gui.game_speed_container,
			label_name = creative_mode_defines.names.gui.game_speed_label,
			label_caption = { "gui.creative-mode_game-speed" },
			label_tooltip = { "gui.creative-mode_game-speed-tooltip", 0.1, 1 },
			textfield_name = creative_mode_defines.names.gui.game_speed_textfield,
			separator_name = creative_mode_defines.names.gui.game_speed_separator,
			apply_button_name = creative_mode_defines.names.gui.game_speed_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
		},
	},
	cheats_data = cheats.global_cheats_data,
	get_unverified_targets_function = nil,
	verify_target_function = nil,
	verify_target_for_insert_function = nil,
	get_target_button_name_postfix_function = nil,
	get_target_button_caption_function = nil,
	get_target_button_tooltip_function = nil,
	check_is_target_self_function = nil,
	post_create_target_button_function = nil,
	check_is_target_button_valid_function = nil,
	check_is_target_button_valid_unknown_target_function = nil,
	get_button_actual_target_function = nil,
	remove_target_button_function = nil,
}

-- GUI data about all cheats menus.
local cheats_menus_gui_data = {
	get_container_name_function = gui_menu_cheats.get_container_name,
	contents = {
		personal_cheats = {
			button_name = creative_mode_defines.names.gui.personal_cheats_menu_button,
			button_caption = { "gui.creative-mode_personal-cheats" },
			-- The menu needs to be updated only if the access right of this code is changed.
			access_right_code = rights.access_personal_cheats_code,
			get_player_can_access_function = rights.can_player_access_personal_cheats_menu,
			cheats_menu_gui_data = personal_cheats_menu_gui_data,
		},
		team_cheats = {
			button_name = creative_mode_defines.names.gui.team_cheats_menu_button,
			button_caption = { "gui.creative-mode_team-cheats" },
			access_right_code = rights.access_team_cheats_code,
			get_player_can_access_function = rights.can_player_access_team_cheats_menu,
			cheats_menu_gui_data = team_cheats_menu_gui_data,
		},
		surface_cheats = {
			button_name = creative_mode_defines.names.gui.surface_cheats_menu_button,
			button_caption = { "gui.creative-mode_surface-cheats" },
			access_right_code = rights.access_surface_cheats_code,
			get_player_can_access_function = rights.can_player_access_surface_cheats_menu,
			cheats_menu_gui_data = surface_cheats_menu_gui_data,
		},
		global_cheats = {
			button_name = creative_mode_defines.names.gui.global_cheats_menu_button,
			button_caption = { "gui.creative-mode_global-cheats" },
			access_right_code = rights.access_global_cheats_code,
			get_player_can_access_function = rights.can_player_access_global_cheats_menu,
			cheats_menu_gui_data = global_cheats_menu_gui_data,
		},
	},
}
-- Set parent.
for _, data in pairs(cheats_menus_gui_data.contents) do
	data.cheats_menu_gui_data.parent = cheats_menus_gui_data
end

-----

-- GUI data about the whole build options menu.
local build_options_menu_gui_data = {
	parent = nil,
	frame = {
		name = creative_mode_defines.names.gui.build_options_frame,
		caption = { "gui.creative-mode_build-options" },
		outer_container = {
			name = creative_mode_defines.names.gui.build_options_outer_contianer,
			targets_scroll_pane = {
				name = creative_mode_defines.names.gui.build_options_targets_scroll_pane,
				outer_container = {
					name = creative_mode_defines.names.gui.build_options_targets_container,
					inner_container = {
						name = creative_mode_defines.names.gui.build_options_targets_inner_container,
						target_button = {
							name_prefix = creative_mode_defines.names.gui.build_options_target_index_button_prefix,
						},
						select_all_button = {
							name = creative_mode_defines.names.gui.build_options_targets_select_all_button,
						},
					},
				},
			},
			cheats_scroll_pane = {
				name = creative_mode_defines.names.gui.build_options_cheats_scroll_pane,
				cheats_container = {
					name = creative_mode_defines.names.gui.build_options_cheats_container,
					enable_disable_all_container = nil,
					notes = nil,
				},
			},
		},
	},
	-- GUI data for each of the cheats. No other data except cheat GUI data can be put inside.
	cheats_gui_data = {
		active = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.build_options_data.cheats.active,
			container_name = creative_mode_defines.names.gui.build_active_container,
			label_name = creative_mode_defines.names.gui.build_active_label,
			label_caption = { "gui.creative-mode_build-active" },
			label_tooltip = { "gui.creative-mode_build-active-tooltip" },
			on_button_name = creative_mode_defines.names.gui.build_active_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.build_active_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		destructible = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.build_options_data.cheats.destructible,
			container_name = creative_mode_defines.names.gui.build_destructible_container,
			label_name = creative_mode_defines.names.gui.build_destructible_label,
			label_caption = { "gui.creative-mode_build-destructible" },
			label_tooltip = { "gui.creative-mode_build-destructible-tooltip" },
			on_button_name = creative_mode_defines.names.gui.build_destructible_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.build_destructible_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		minable = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.build_options_data.cheats.minable,
			container_name = creative_mode_defines.names.gui.build_minable_container,
			label_name = creative_mode_defines.names.gui.build_minable_label,
			label_caption = { "gui.creative-mode_build-minable" },
			label_tooltip = { "gui.creative-mode_build-minable-tooltip" },
			on_button_name = creative_mode_defines.names.gui.build_minable_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.build_minable_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		rotatable = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.build_options_data.cheats.rotatable,
			container_name = creative_mode_defines.names.gui.build_rotatable_container,
			label_name = creative_mode_defines.names.gui.build_rotatable_label,
			label_caption = { "gui.creative-mode_build-rotatable" },
			label_tooltip = { "gui.creative-mode_build-rotatable-tooltip" },
			on_button_name = creative_mode_defines.names.gui.build_rotatable_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.build_rotatable_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		operable = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.build_options_data.cheats.operable,
			container_name = creative_mode_defines.names.gui.build_operable_container,
			label_name = creative_mode_defines.names.gui.build_operable_label,
			label_caption = { "gui.creative-mode_build-operable" },
			label_tooltip = { "gui.creative-mode_build-operable-tooltip" },
			on_button_name = creative_mode_defines.names.gui.build_operable_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.build_operable_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		full_health = {
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.build_options_data.cheats.full_health,
			container_name = creative_mode_defines.names.gui.build_full_health_container,
			label_name = creative_mode_defines.names.gui.build_full_health_label,
			label_caption = { "gui.creative-mode_build-full-health" },
			label_tooltip = { "gui.creative-mode_build-full-health-tooltip" },
			on_button_name = creative_mode_defines.names.gui.build_full_health_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.build_full_health_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
		},
		team = {
			type = gui_menu_cheats.cheat_gui_type.team_target_auto_apply,
			cheat_data = cheats.build_options_data.cheats.team,
			container_name = creative_mode_defines.names.gui.build_team_container,
			label_name = creative_mode_defines.names.gui.build_team_label,
			label_caption = { "gui.creative-mode_build-team" },
			label_tooltip = { "gui.creative-mode_build-team-tooltip" },
			drop_down_container_name = creative_mode_defines.names.gui.build_team_targets_drop_down_container,
			current_selection_button_name = creative_mode_defines.names.gui.build_team_current_button,
			drop_down_scroll_pane_name = creative_mode_defines.names.gui.build_team_targets_scroll_pane,
			drop_down_inner_frame_name = creative_mode_defines.names.gui.build_team_targets_container,
			drop_down_inner_flow_name = creative_mode_defines.names.gui.build_team_targets_inner_container,
			drop_down_selection_button_name_prefx = creative_mode_defines.names.gui.build_team_target_name_button_prefix,
			drop_down_selection_button_name_pattern = creative_mode_defines.match_patterns.gui.build_team_target_name_button,
		},
	},
	cheats_data = cheats.build_options_data,
	get_unverified_targets_function = function(player)
		if rights.can_player_access_other_non_admin_players_build_options(player) then
			return game.connected_players, nil
		else
			return nil, player
		end
	end,
	verify_target_function = function(player, target)
		return target.valid and (target == player or not target.admin)
	end,
	verify_target_for_insert_function = function(player, target)
		if not target.valid then
			return false
		end
		if target == player then
			return true
		end
		if rights.can_player_access_other_non_admin_players_build_options(player) and not target.admin then
			return true
		end
		return false
	end,
	get_target_button_name_postfix_function = function(player, target)
		return target.index
	end,
	get_target_button_caption_function = function(player, target)
		return target.name
	end,
	get_target_button_tooltip_function = function(player, target)
		return { "gui.creative-mode_player-name-tooltip", target.name }
	end,
	check_is_target_self_function = function(player, target)
		return player == target
	end,
	post_create_target_button_function = function(player, target, button)
		button.visible = target.connected -- If target is not connected, but he is here before, just hide the button.
	end,
	check_is_target_button_valid_function = function(player, target, button)
		return button.visible ~= false
	end,
	check_is_target_button_valid_unknown_target_function = function(player, button)
		return button.visible ~= false
	end,
	get_button_actual_target_function = function(player, button)
		local player_index =
			string.match(button.name, creative_mode_defines.match_patterns.gui.build_options_target_index_button)
		if player_index then
			player_index = tonumber(player_index)
			return game.players[player_index]
		end
		return nil
	end,
	remove_target_button_function = function(player, target, button)
		-- Make sure the button is unselected.
		local button_style_name = button.style.name
		if button_style_name == creative_mode_defines.names.gui_styles.cheat_target_selected_button then
			button.style = creative_mode_defines.names.gui_styles.cheat_target_unselected_button
		elseif button_style_name == creative_mode_defines.names.gui_styles.cheat_target_self_selected_button then
			button.style = creative_mode_defines.names.gui_styles.cheat_target_self_unselected_button
		end
		button.visible = false
		-- In case the player will come back, we don't remove the button.
		return false
	end,
}

-- GUI data about all build options menus.
-- Although we have only 1 build option menu, we still need to set it due to the data structure expected by the functions.
local build_options_menus_gui_data = {
	get_container_name_function = gui_menu_buildoptions.get_container_name,
	contents = {
		build_options = {
			cheats_menu_gui_data = build_options_menu_gui_data,
			access_right_code = rights.access_build_options_code,
		},
	},
}
-- Set parent.
for _, data in pairs(build_options_menus_gui_data.contents) do
	data.cheats_menu_gui_data.parent = build_options_menus_gui_data
end

--------------------------------------------------------------------

-- Creates the cheats menu for the given player. If the menu already exists, it will be destroyed instead.
function gui_menu_cheats.create_or_destroy_menu_for_player(player)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		-- Cheats container.
		local cheats_menus_container = container[gui_menu_cheats.get_container_name()]
		if cheats_menus_container then
			cheats_menus_container.destroy()
		else
			cheats_menus_container = container.add({
				type = "flow",
				name = gui_menu_cheats.get_container_name(),
				style = creative_mode_defines.names.gui_styles.no_horizontal_spacing_flow,
				direction = "horizontal",
			})

			-- Cheats frame.
			local cheats_menu_frame = cheats_menus_container.add({
				type = "frame",
				name = creative_mode_defines.names.gui.cheats_menu_frame,
				direction = "vertical",
				caption = { "gui.creative-mode_cheats" },
			})

			-- Cheats menu butotns.
			for _, data in pairs(cheats_menus_gui_data.contents) do
				local button = cheats_menu_frame.add({
					type = "button",
					name = data.button_name,
					style = creative_mode_defines.names.gui_styles.main_menu_button,
					caption = data.button_caption,
				})
				button.visible = data.get_player_can_access_function(player)
			end
		end
	end
end

--------------------------------------------------------------------

-- Returns the common Boolean result for all the given targets according to the given function for getting Boolean from each target.
-- If any of the targets has different result from the others, nil will be returned.
local function get_common_boolean_result_for_targets(targets, get_single_boolean_function)
	if not targets or #targets <= 0 then
		return get_single_boolean_function(nil)
	end
	local all_true = true
	local all_false = true
	for _, target in ipairs(targets) do
		local single_result = get_single_boolean_function(target)
		if single_result == nil then
			return nil
		elseif single_result then
			all_false = false
		else
			all_true = false
		end
	end
	if all_true then
		return true
	elseif all_false then
		return false
	else
		return nil
	end
end

-- Returns the common numeric result for all the given targets according to the given function for getting number from each target.
-- If any of the targets has different result from the others, nil will be returned.
local function get_common_numeric_result_for_targets(targets, get_single_number_function)
	if not targets or #targets <= 0 then
		return tonumber(get_single_number_function(nil))
	end
	local common_number = get_single_number_function(targets[1])
	for i = 2, #targets, 1 do
		if common_number ~= get_single_number_function(targets[i]) then
			return nil
		end
	end
	return tonumber(common_number)
end

-- Returns the common string result for all the given targets according to the given function for getting string from each target.
-- If any of the targets has different result from the others, nil will be returned.
local function get_common_string_result_for_targets(targets, get_single_string_function)
	if not targets or #targets <= 0 then
		local val = get_single_string_function(nil)
		if val then
			return tostring(val)
		end
		return nil
	end
	local common_string = get_single_string_function(targets[1])
	for i = 2, #targets, 1 do
		if common_string ~= get_single_string_function(targets[i]) then
			return nil
		end
	end
	if common_string then
		return tostring(common_string)
	end
	return nil
end

-- Returns the common team result for all the given targets according to the given function for getting team from each target.
-- If any of the targets has different result from the others, nil will be returned.
local function get_common_team_result_for_targets(targets, get_single_team_function)
	if not targets or #targets <= 0 then
		return get_single_team_function(nil)
	end
	local common_team = get_single_team_function(targets[1])
	for i = 2, #targets, 1 do
		if common_team ~= get_single_team_function(targets[i]) then
			return nil
		end
	end
	return common_team
end

--------------------------------------------------------------------

-- Updates the GUI status for an on/off cheat in the given container according to the given GUI data and targets.
-- Make sure the GUI has been created before calling this method.
local function update_on_off_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
	local on_button_style, off_button_style
	if cheat_gui_data.cheat_data.get_value_function == nil then
		on_button_style = creative_mode_defines.names.gui_styles.cheat_on_off_button_off
		off_button_style = on_button_style
	else
		local value = get_common_boolean_result_for_targets(targets, cheat_gui_data.cheat_data.get_value_function)

		if value == nil then
			on_button_style = creative_mode_defines.names.gui_styles.cheat_on_off_button_off
			off_button_style = on_button_style
		elseif value then
			on_button_style = creative_mode_defines.names.gui_styles.cheat_on_off_button_on
			off_button_style = creative_mode_defines.names.gui_styles.cheat_on_off_button_off
		else
			on_button_style = creative_mode_defines.names.gui_styles.cheat_on_off_button_off
			off_button_style = creative_mode_defines.names.gui_styles.cheat_on_off_button_on
		end
	end

	-- Container
	local cheat_container = cheats_container[cheat_gui_data.container_name]
	-- On button
	local on_button = cheat_container[cheat_gui_data.on_button_name]
	on_button.style = on_button_style
	-- Off button
	local off_button = cheat_container[cheat_gui_data.off_button_name]
	off_button.style = off_button_style
end

-- Creates GUI elements for an on/off cheat in the given container according to the given GUI data and targets.
local function create_on_off_cheat_elements_from_data(cheats_container, cheat_gui_data, targets)
	-- Container
	local cheat_container = cheats_container.add({
		type = "table",
		name = cheat_gui_data.container_name,
		style = creative_mode_defines.names.gui_styles.cheat_table,
		column_count = 3,
	})
	-- Label
	cheat_container.add({
		type = "label",
		name = cheat_gui_data.label_name,
		style = creative_mode_defines.names.gui_styles.cheat_name_label,
		caption = cheat_gui_data.label_caption,
		tooltip = cheat_gui_data.label_tooltip,
	})
	-- On button
	cheat_container.add({
		type = "button",
		name = cheat_gui_data.on_button_name,
		caption = cheat_gui_data.on_button_caption,
	})
	-- Off button
	cheat_container.add({
		type = "button",
		name = cheat_gui_data.off_button_name,
		caption = cheat_gui_data.off_button_caption,
	})
	-- Update the buttons' status.
	update_on_off_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
end

-----

-- Updates the GUI status for a numeric-apply cheat in the given container according to the given GUI data and targets.
-- Make sure the GUI has been created before calling this method.
local function update_numeric_apply_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
	local text
	if cheat_gui_data.cheat_data.get_value_function == nil then
		text = 0
	else
		local value = get_common_numeric_result_for_targets(targets, cheat_gui_data.cheat_data.get_value_function)
		if value == nil then
			text = "---"
		else
			text = value
		end
	end

	-- Container
	local cheat_container = cheats_container[cheat_gui_data.container_name]
	-- Textfield
	local textfield = cheat_container[cheat_gui_data.textfield_name]
	textfield.text = tostring(text)
end

-- Creates GUI elements for a numeric-apply cheat in the given container according to the given GUI data and targets.
local function create_numeric_apply_cheat_elements_from_data(cheats_container, cheat_gui_data, targets)
	-- Container
	local cheat_container = cheats_container.add({
		type = "table",
		name = cheat_gui_data.container_name,
		style = creative_mode_defines.names.gui_styles.cheat_table,
		column_count = 4,
	})
	-- Label
	cheat_container.add({
		type = "label",
		name = cheat_gui_data.label_name,
		style = creative_mode_defines.names.gui_styles.cheat_name_label,
		caption = cheat_gui_data.label_caption,
		tooltip = cheat_gui_data.label_tooltip,
	})
	-- Textfield
	cheat_container.add({
		type = "textfield",
		name = cheat_gui_data.textfield_name,
		style = creative_mode_defines.names.gui_styles.cheat_numeric_textfield,
		text = "",
	})
	-- Separator
	cheat_container.add({
		type = "flow",
		name = cheat_gui_data.separator_name,
		style = creative_mode_defines.names.gui_styles.cheat_textfield_and_button_separate_flow,
		direction = "horizontal",
	})
	-- Apply button
	cheat_container.add({
		type = "button",
		name = cheat_gui_data.apply_button_name,
		style = creative_mode_defines.names.gui_styles.cheat_apply_button,
		caption = cheat_gui_data.apply_button_caption,
	})
	-- Update the textfield's text.
	update_numeric_apply_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
end

-----

-- Updates the GUI status for a string-apply cheat in the given container according to the given GUI data and targets.
-- Make sure the GUI has been created before calling this method.
local function update_string_apply_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
	local text
	if cheat_gui_data.cheat_data.get_value_function == nil then
		text = ""
	else
		local value = get_common_string_result_for_targets(targets, cheat_gui_data.cheat_data.get_value_function)
		if value == nil then
			text = "---"
		else
			text = value
		end
	end

	-- Container
	local cheat_container = cheats_container[cheat_gui_data.container_name]
	-- Textfield
	local textfield = cheat_container[cheat_gui_data.textfield_name]
	textfield.text = tostring(text)
end

-- Creates GUI elements for a string-apply cheat in the given container according to the given GUI data and targets.
local function create_string_apply_cheat_elements_from_data(cheats_container, cheat_gui_data, targets)
	-- Container
	local cheat_container = cheats_container.add({
		type = "table",
		name = cheat_gui_data.container_name,
		style = creative_mode_defines.names.gui_styles.cheat_table,
		column_count = 4,
	})
	-- Label
	cheat_container.add({
		type = "label",
		name = cheat_gui_data.label_name,
		style = creative_mode_defines.names.gui_styles.cheat_name_label,
		caption = cheat_gui_data.label_caption,
		tooltip = cheat_gui_data.label_tooltip,
	})
	-- Textfield
	cheat_container.add({
		type = "textfield",
		name = cheat_gui_data.textfield_name,
		style = creative_mode_defines.names.gui_styles.cheat_numeric_textfield,
		text = "",
	})
	-- Separator
	cheat_container.add({
		type = "flow",
		name = cheat_gui_data.separator_name,
		style = creative_mode_defines.names.gui_styles.cheat_textfield_and_button_separate_flow,
		direction = "horizontal",
	})
	-- Apply button
	cheat_container.add({
		type = "button",
		name = cheat_gui_data.apply_button_name,
		style = creative_mode_defines.names.gui_styles.cheat_apply_button,
		caption = cheat_gui_data.apply_button_caption,
	})
	-- Update the textfield's text.
	update_string_apply_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
end

-----

-- Creates GUI elements for an one-button-apply cheat in the given container according to the given GUI data.
local function create_one_button_apply_cheat_elements_from_data(cheats_container, cheat_gui_data)
	-- Container
	local cheat_container = cheats_container.add({
		type = "table",
		name = cheat_gui_data.container_name,
		style = creative_mode_defines.names.gui_styles.cheat_table,
		column_count = 3,
	})
	-- Label
	cheat_container.add({
		type = "label",
		name = cheat_gui_data.label_name,
		style = creative_mode_defines.names.gui_styles.cheat_with_one_button_name_label,
		caption = cheat_gui_data.label_caption,
		tooltip = cheat_gui_data.label_tooltip,
	})
	-- Button
	cheat_container.add({
		type = "button",
		name = cheat_gui_data.apply_button_name,
		style = creative_mode_defines.names.gui_styles.cheat_on_off_button_off,
		caption = cheat_gui_data.apply_button_caption,
	})
end

-----

-- Adds teams to the given flow of a team-target-auto-apply cheat drop down for the cheat of given GUI data.
local function add_teams_to_team_target_auto_apply_cheat_drop_down(cheat_gui_data, drop_down_inner_flow)
	-- Add teams.
	for _, force in pairs(game.forces) do
		drop_down_inner_flow.add({
			type = "button",
			name = cheat_gui_data.drop_down_selection_button_name_prefx .. force.name,
			style = creative_mode_defines.names.gui_styles.cheat_value_drop_down_selection_button,
			caption = force.name,
			tooltip = { "gui.creative-mode_team-name-tooltip", force.name },
		})
	end
end

-- Clears all teams in the given flow of a team-target-auto-apply cheat drop down.
local function clear_teams_in_team_target_auto_apply_cheat_drop_down(drop_down_inner_flow)
	for _, child_name in pairs(drop_down_inner_flow.children_names) do
		drop_down_inner_flow[child_name].destroy()
	end
end

-- Refreshes the contents in the given flow of a team-target-auto-apply cheat drop down for the cheat of given GUI data.
local function refresh_team_target_auto_apply_cheat_drop_down(cheat_gui_data, drop_down_inner_flow)
	clear_teams_in_team_target_auto_apply_cheat_drop_down(drop_down_inner_flow)
	add_teams_to_team_target_auto_apply_cheat_drop_down(cheat_gui_data, drop_down_inner_flow)
end

-- Shows or hides the drop down for a team-target-auto-apply cheat in the given container according to the given GUI data.
-- If the drop down is already visible, it will be hidden. Otherwise, it will be shown.
local function show_or_hide_team_target_auto_apply_cheat_drop_down_from_data(cheats_container, cheat_gui_data)
	-- Container
	local cheat_container = cheats_container[cheat_gui_data.container_name]
	-- Drop down container.
	local drop_down_container = cheat_container[cheat_gui_data.drop_down_container_name]
	-- Drop down scroll pane.
	local drop_down_scroll_pane = drop_down_container[cheat_gui_data.drop_down_scroll_pane_name]
	-- Drop down inner frame.
	local drop_down_inner_frame = drop_down_scroll_pane[cheat_gui_data.drop_down_inner_frame_name]
	-- Drop down inner flow.
	local drop_down_inner_flow = drop_down_inner_frame[cheat_gui_data.drop_down_inner_flow_name]

	if drop_down_scroll_pane.visible ~= false then
		-- Hide.
		drop_down_scroll_pane.visible = false
		-- Clear teams.
		clear_teams_in_team_target_auto_apply_cheat_drop_down(drop_down_inner_flow)
	else
		-- Add teams.
		add_teams_to_team_target_auto_apply_cheat_drop_down(cheat_gui_data, drop_down_inner_flow)
		-- Show.
		drop_down_scroll_pane.visible = true
	end
end

-- Updates the GUI status for a team-target-auto-apply cheat in the given container according to the given GUI data and targets.
-- Make sure the GUI has been created before calling this method.
local function update_team_target_auto_apply_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
	local text
	if cheat_gui_data.cheat_data.get_value_function == nil then
		text = "---"
	else
		local value = get_common_team_result_for_targets(targets, cheat_gui_data.cheat_data.get_value_function)
		if value == nil then
			text = "---"
		else
			text = value.name
		end
	end

	-- Container
	local cheat_container = cheats_container[cheat_gui_data.container_name]
	-- Drop down container.
	local drop_down_container = cheat_container[cheat_gui_data.drop_down_container_name]
	-- Current selection button.
	local button = drop_down_container[cheat_gui_data.current_selection_button_name]
	button.caption = text

	-- Also refresh the contents of the drop down, if it is visible.
	-- Drop down scroll pane.
	local drop_down_scroll_pane = drop_down_container[cheat_gui_data.drop_down_scroll_pane_name]
	if drop_down_scroll_pane.visible ~= false then
		-- Drop down inner frame.
		local drop_down_inner_frame = drop_down_scroll_pane[cheat_gui_data.drop_down_inner_frame_name]
		-- Drop down inner flow (vertical spacing doesn't work in frame).
		local drop_down_inner_flow = drop_down_inner_frame[cheat_gui_data.drop_down_inner_flow_name]
		refresh_team_target_auto_apply_cheat_drop_down(cheat_gui_data, drop_down_inner_flow)
	end
end

-- Creates GUI elements for a team-target-auto-apply cheat in the given container according to the given GUI data and targets.
local function create_team_target_auto_apply_cheat_elements_from_data(cheats_container, cheat_gui_data, targets)
	-- Container

	local cheat_container = cheats_container.add({
		type = "flow",
		name = cheat_gui_data.container_name,
		style = creative_mode_defines.names.gui_styles.cheat_flow,
		direction = "horizontal",
	})
	-- Label
	cheat_container.add({
		type = "label",
		name = cheat_gui_data.label_name,
		style = creative_mode_defines.names.gui_styles.cheat_name_label,
		caption = cheat_gui_data.label_caption,
		tooltip = cheat_gui_data.label_tooltip,
	})

	-- Drop down container.
	local drop_down_container = cheat_container.add({
		type = "flow",
		name = cheat_gui_data.drop_down_container_name,
		style = creative_mode_defines.names.gui_styles.no_vertical_spacing_resize_row_flow,
		direction = "vertical",
	})
	-- Current selection button.
	drop_down_container.add({
		type = "button",
		name = cheat_gui_data.current_selection_button_name,
		style = creative_mode_defines.names.gui_styles.cheat_value_drop_down_current_target_button,
		caption = "",
	})
	-- Drop down scroll pane.
	local drop_down_scroll_pane = drop_down_container.add({
		type = "scroll-pane",
		name = cheat_gui_data.drop_down_scroll_pane_name,
		style = creative_mode_defines.names.gui_styles.cheat_value_drop_down_scroll_pane,
		horizontal_scroll_policy = "never",
	})
	-- Drop down inner frame.
	local drop_down_inner_frame = drop_down_scroll_pane.add({
		type = "frame",
		name = cheat_gui_data.drop_down_inner_frame_name,
		style = creative_mode_defines.names.gui_styles.cheat_value_drop_down_container_frame,
		direction = "vertical",
	})
	-- Drop down inner flow (vertical spacing doesn't work in frame).
	drop_down_inner_frame.add({
		type = "flow",
		name = cheat_gui_data.drop_down_inner_flow_name,
		style = creative_mode_defines.names.gui_styles.no_vertical_spacing_resize_row_flow,
		direction = "vertical",
	})

	-- Hide the scorll pane first.
	drop_down_scroll_pane.visible = false
	-- Update the current button.
	update_team_target_auto_apply_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
end

-----

-- Updates cheat GUI status in the given container according to the given GUI data and targets.
function gui_menu_cheats.update_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
	if cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.on_off then
		update_on_off_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
	elseif cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.numeric_apply then
		update_numeric_apply_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
	elseif cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.string_apply then
		update_string_apply_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
	elseif cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.team_target_auto_apply then
		update_team_target_auto_apply_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
	end
end

-- Updates the visibility of the cheat GUI elements in the given container according to the given GUI data and the given player's access right.
local function update_cheat_visibility_from_data_for_player(player, cheats_container, cheat_gui_data)
	local cheat_container = cheats_container[cheat_gui_data.container_name]
	if cheat_gui_data.cheat_data.get_player_can_access_function == nil then
		cheat_container.visible = true
	else
		cheat_container.visible = cheat_gui_data.cheat_data.get_player_can_access_function(player)
	end
end

-- Creates cheat GUI elements in the given container according to the given GUI data and targets for the given player.
function gui_menu_cheats.create_cheat_elements_from_data_for_player(
	player,
	cheats_container,
	cheat_gui_data,
	targets,
	check_cheat_visibility_for_player
)
	if cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.on_off then
		create_on_off_cheat_elements_from_data(cheats_container, cheat_gui_data, targets)
	elseif cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.numeric_apply then
		create_numeric_apply_cheat_elements_from_data(cheats_container, cheat_gui_data, targets)
	elseif cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.string_apply then
		create_string_apply_cheat_elements_from_data(cheats_container, cheat_gui_data, targets)
	elseif cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.apply then
		create_one_button_apply_cheat_elements_from_data(cheats_container, cheat_gui_data)
	elseif cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.team_target_auto_apply then
		create_team_target_auto_apply_cheat_elements_from_data(cheats_container, cheat_gui_data, targets)
	end
	if check_cheat_visibility_for_player then
		update_cheat_visibility_from_data_for_player(player, cheats_container, cheat_gui_data)
	end
end

-- Creates the enable all and disable all buttons in the given container.
local function create_enable_and_disable_all_buttons(
	cheats_container,
	container_name,
	enable_all_button_name,
	disable_all_button_name
)
	-- Container
	local button_container = cheats_container.add({
		type = "table",
		name = container_name,
		style = creative_mode_defines.names.gui_styles.cheat_enable_disable_all_table,
		column_count = 2,
	})
	-- Enable all button
	button_container.add({
		type = "button",
		name = enable_all_button_name,
		style = creative_mode_defines.names.gui_styles.cheat_enable_disable_all_button,
		caption = creative_mode_defines.names.gui_captions.enable_all,
	})
	-- Disable all button
	button_container.add({
		type = "button",
		name = disable_all_button_name,
		style = creative_mode_defines.names.gui_styles.cheat_enable_disable_all_button,
		caption = creative_mode_defines.names.gui_captions.disable_all,
	})
end

---------------

-- Returns whether there is a target selection list for the cheats of given GUI data.
local function get_cheats_menu_has_targets_selection(cheats_menu_gui_data)
	if cheats_menu_gui_data.has_targets_selection then
		-- Used by the data in the modification popup.
		return true
	end

	local targets_scroll_pane_data = cheats_menu_gui_data.frame.outer_container.targets_scroll_pane
	return targets_scroll_pane_data ~= nil
end

-- Returns the frame according to the given cheats menu GUI data for the given player.
-- If the player has not opened such cheat menu page, nil will be returned.
local function get_cheats_frame_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		local cheats_menus_container = container[cheats_menu_gui_data.parent.get_container_name_function()]
		if cheats_menus_container then
			return cheats_menus_container[cheats_menu_gui_data.frame.name]
		end
	end
	return nil
end

-- Returns the outer container according to the given cheats menu GUI data for the given player.
-- If the player has not opened such cheat menu page, nil will be returned.
local function get_outer_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	local frame = get_cheats_frame_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	if frame then
		return frame[cheats_menu_gui_data.frame.outer_container.name]
	end
	return nil
end

-- Returns the targets scroll pane according to the given cheats menu GUI data for the given player.
-- If the player has not opened such cheat menu page, nil will be returned.
local function get_targets_scroll_pane_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	local outer_container = get_outer_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	if outer_container then
		local current_structure_data = cheats_menu_gui_data.frame.outer_container.targets_scroll_pane
		if current_structure_data then
			return outer_container[current_structure_data.name]
		end
	end
	return nil
end

-- Returns the targets inner container according to the given cheats menu GUI data for the given player.
-- If the player has not opened such cheat menu page, nil will be returned.
local function get_targets_inner_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	local targets_scroll_pane = get_targets_scroll_pane_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	if targets_scroll_pane then
		local current_structure_data = cheats_menu_gui_data.frame.outer_container.targets_scroll_pane.outer_container
		local targets_outer_container = targets_scroll_pane[current_structure_data.name]

		current_structure_data = current_structure_data.inner_container
		return targets_outer_container[current_structure_data.name]
	end
	return nil
end

-- Returns the cheats container according to the given cheats menu GUI data for the given player.
-- If the player has not opened such cheat menu page, nil will be returned.
local function get_cheats_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	if cheats_menu_gui_data.get_cheats_container_function then
		-- Used by the data in modification popup.
		return cheats_menu_gui_data.get_cheats_container_function(player)
	end
	local outer_container = get_outer_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	if outer_container then
		local cheats_scroll_pane_data = cheats_menu_gui_data.frame.outer_container.cheats_scroll_pane
		local cheats_scroll_pane = outer_container[cheats_scroll_pane_data.name]
		if cheats_scroll_pane then
			return cheats_scroll_pane[cheats_scroll_pane_data.cheats_container.name]
		end
	end
	return nil
end

---------------

-- Adds a target button with the given exact element name referring to the given target for the given player inside the given targets inner container and sets the button according to the given cheats menu GUI data.
-- Returns the created button and whether the target is marked as self.
local function add_target_button_with_exact_name_in_targets_inner_container_for_player(
	player,
	target,
	cheats_menu_gui_data,
	targets_inner_container,
	button_name
)
	local style
	-- Check if the target should be marked as "self" (blue font)
	local is_self = cheats_menu_gui_data.check_is_target_self_function(player, target)
	if is_self then
		style = creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
	else
		style = creative_mode_defines.names.gui_styles.cheat_target_unselected_button
	end
	local button = targets_inner_container.add({
		type = "button",
		name = button_name,
		style = style,
		caption = cheats_menu_gui_data.get_target_button_caption_function(player, target),
		tooltip = cheats_menu_gui_data.get_target_button_tooltip_function(player, target),
	})
	if cheats_menu_gui_data.post_create_target_button_function then
		cheats_menu_gui_data.post_create_target_button_function(player, target, button)
	end
	return button, is_self
end

-- Adds a target button referring to the given target for the given player inside the given targets inner container and sets the button according to the given cheats menu GUI data.
-- Returns the created button and whether the target is marked as self.
local function add_target_button_in_targets_inner_container_for_player(
	player,
	target,
	cheats_menu_gui_data,
	targets_inner_container,
	button_name_prefix
)
	return add_target_button_with_exact_name_in_targets_inner_container_for_player(
		player,
		target,
		cheats_menu_gui_data,
		targets_inner_container,
		button_name_prefix .. cheats_menu_gui_data.get_target_button_name_postfix_function(player, target)
	)
end

-- Shows or hides the targets selection scroll pane according to the given GUI elements.
local function show_or_hide_targets_selection(outer_container, targets_scroll_pane, show)
	if show then
		targets_scroll_pane.visible = true
		outer_container.style = "horizontal_flow"
	else
		targets_scroll_pane.visible = false
		outer_container.style = creative_mode_defines.names.gui_styles.no_horizontal_spacing_flow
	end
end

-- Updates the visibility of targets selection scroll pane represented by the given GUI elements according to the number of valid targets.
local function update_targets_selection_visibility_by_valid_target_count(
	outer_container,
	targets_scroll_pane,
	targets_inner_container
)
	local show = #targets_inner_container.children_names > 1
	if show then
		-- Some buttons may be hidden.
		local actual_count = 0
		for _, child_name in ipairs(targets_inner_container.children_names) do
			local button = targets_inner_container[child_name]
			if button.visible ~= false then
				actual_count = actual_count + 1
				if actual_count > 1 then
					break
				end
			end
		end
		show = actual_count > 1
	end
	show_or_hide_targets_selection(outer_container, targets_scroll_pane, show)
end

---------------

-- Returns all selected targets in the menu of given cheats menu GUI data for the given player.
-- If the player has not opened such cheats menu, nil will be returend.
-- @param special_target	If it is provided, the selected targets are returned only if this target is included. Otherwise, the result will be overridden by nil.
local function get_all_selected_targets_in_cheats_menu_for_player(player, cheats_menu_gui_data, special_target)
	if cheats_menu_gui_data.get_all_selected_targets_function then
		-- Used by the data in modification popup.
		return cheats_menu_gui_data.get_all_selected_targets_function(player)
	end

	local targets_scroll_pane = get_targets_scroll_pane_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	if targets_scroll_pane then
		local targets_inner_container =
			get_targets_inner_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
		if targets_inner_container then
			-- Preprare to iterate through the selections.
			local targets = {}
			-- Iterate!
			-- If the container is invisible, that means it only contains 1 valid target, e.g. the player himself if it is the personal cheats menu.
			-- In that case, it is impossible for the player to select the button. So, we don't check the style.
			local check_style = not targets_scroll_pane.visible == false
			if special_target ~= nil then
				-- Special target is provided! We should check it.
				local button_name_prefix =
					cheats_menu_gui_data.frame.outer_container.targets_scroll_pane.outer_container.inner_container.target_button.name_prefix
				local button_name = button_name_prefix
					.. cheats_menu_gui_data.get_target_button_name_postfix_function(player, special_target)
				local button = targets_inner_container[button_name]
				if button then
					local button_style_name = button.style.name
					if
						check_style
						and button_style_name ~= creative_mode_defines.names.gui_styles.cheat_target_selected_button
						and button_style_name
							~= creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
					then
						-- Target not selected!
						return nil
					end
				else
					-- No such button. Target not found.
					return nil
				end
			end
			for _, child_name in ipairs(targets_inner_container.children_names) do
				local button = targets_inner_container[child_name]
				local button_style_name = button.style.name
				if
					not check_style
					or (
						button_style_name == creative_mode_defines.names.gui_styles.cheat_target_selected_button
						or button_style_name
							== creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
					)
				then
					local target = cheats_menu_gui_data.get_button_actual_target_function(player, button)
					if target then
						if cheats_menu_gui_data.check_is_target_button_valid_function(player, target, button) then
							table.insert(targets, target)
						end
					end
				end
			end
			return targets
		end
	end
	return nil
end

-- Updates the cheat GUI status of given cheat GUI data for all players in the cheats menu of given cheats menu GUI data.
-- @param special_target	If it is provided, the GUI status will be updated only if it is selected by the iterated player.
function gui_menu_cheats.update_cheat_status_in_cheats_menu_for_all_players(
	cheats_menu_gui_data,
	cheat_gui_data,
	special_target
)
	for _, player in pairs(game.players) do
		local cheats_container = get_cheats_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
		if cheats_container then
			if get_cheats_menu_has_targets_selection(cheats_menu_gui_data) then
				-- There is a target list. Get the selected targets from the list.
				local targets =
					get_all_selected_targets_in_cheats_menu_for_player(player, cheats_menu_gui_data, special_target)
				if targets then
					gui_menu_cheats.update_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
				end
			else
				-- No target list, no target.
				gui_menu_cheats.update_cheat_status_from_data(cheats_container, cheat_gui_data, nil)
			end
		end
	end
end

-- Updates all cheat GUI status in the cheats menu of given cheats menu GUI data for the given player.
-- @param special_target	If it is provided, the GUI status will be updated only if it is selected by the player.
local function update_all_cheats_status_in_cheats_menu_for_player(player, cheats_menu_gui_data, special_target)
	local cheats_container = get_cheats_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	if cheats_container then
		if get_cheats_menu_has_targets_selection(cheats_menu_gui_data) then
			-- There is a target list. Get the selected targets from the list.
			local targets =
				get_all_selected_targets_in_cheats_menu_for_player(player, cheats_menu_gui_data, special_target)
			if targets then
				for _, cheat_gui_data in pairs(cheats_menu_gui_data.cheats_gui_data) do
					gui_menu_cheats.update_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
				end
			end
		else
			-- No target list, no target.
			for _, cheat_gui_data in pairs(cheats_menu_gui_data.cheats_gui_data) do
				gui_menu_cheats.update_cheat_status_from_data(cheats_container, cheat_gui_data, nil)
			end
		end
	end
end

-- Updates all cheat GUI status in the cheats menu of given cheats menu GUI data for the given player according to the given targets.
local function update_all_cheats_status_in_cheats_menu_for_player_with_known_targets(
	player,
	cheats_menu_gui_data,
	targets
)
	local cheats_container = get_cheats_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	if cheats_container then
		for _, cheat_gui_data in pairs(cheats_menu_gui_data.cheats_gui_data) do
			gui_menu_cheats.update_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
		end
	end
end

-- Updates all cheat GUI status in the cheats menu of given cheats menu GUI data for all players.
-- @param special_target	If it is provided, the GUI status will be updated only if it is selected by the iterated player.
local function update_all_cheats_status_in_cheats_menu_for_all_players(cheats_menu_gui_data, special_target)
	for _, player in pairs(game.players) do
		update_all_cheats_status_in_cheats_menu_for_player(player, cheats_menu_gui_data, special_target)
	end
end

-- Updates the visibility of the targets selection in the cheats menu of given cheats menu GUI for the given player according to the number of visible targets.
local function update_targets_selection_visibility_for_player(player, cheats_menu_gui_data)
	local outer_container = get_outer_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	if outer_container then
		local targets_scroll_pane = get_targets_scroll_pane_in_cheats_menu_for_player(player, cheats_menu_gui_data)
		if targets_scroll_pane then
			local targets_inner_container =
				get_targets_inner_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
			if targets_inner_container then
				update_targets_selection_visibility_by_valid_target_count(
					outer_container,
					targets_scroll_pane,
					targets_inner_container
				)
			end
		end
	end
end

-- Adds or removes the given target as a button in the cheats menu of given cheats menu GUI data for all players.
local function add_or_remove_target_in_cheats_menu_for_all_players(target, cheats_menu_gui_data, is_add)
	local targets_scroll_pane_data = cheats_menu_gui_data.frame.outer_container.targets_scroll_pane
	if targets_scroll_pane_data then
		local button_name_prefix = targets_scroll_pane_data.outer_container.inner_container.target_button.name_prefix
		for _, player in pairs(game.players) do
			-- Check if the given target is valid for the given player, i.e. can player access such target?
			if cheats_menu_gui_data.verify_target_for_insert_function(player, target) then
				local targets_inner_container =
					get_targets_inner_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
				if targets_inner_container then
					local button_name = button_name_prefix
						.. cheats_menu_gui_data.get_target_button_name_postfix_function(player, target)
					-- Check if such option already exists.
					local button = targets_inner_container[button_name]
					if button then
						-- The button exists.
						if is_add then
							-- If such button was just hidden before, reveal it now.
							if button.visible == false then
								-- Make sure it isn't selected.
								local button_style_name = button.style.name
								if
									button_style_name
									== creative_mode_defines.names.gui_styles.cheat_target_selected_button
								then
									button.style = creative_mode_defines.names.gui_styles.cheat_target_unselected_button
								elseif
									button_style_name
									== creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
								then
									button.style =
										creative_mode_defines.names.gui_styles.cheat_target_self_unselected_button
								else
									button.visible = true
								end
								-- Make sure we update the state AFTER the visibility of the targets container is updated.
								update_targets_selection_visibility_for_player(player, cheats_menu_gui_data)
								-- Update status.
								-- (There is a case that in a 2P game, if the admin selected the other player, but then that player left and joined back. The admin needs to update the status. So, no if-check before this line.)
								update_all_cheats_status_in_cheats_menu_for_player(player, cheats_menu_gui_data)
							end
						else
							-- Remove the button.
							-- If the button was already selected, we will need to update the cheats status.
							local button_style_name = button.style.name
							local need_update_status = button_style_name
									== creative_mode_defines.names.gui_styles.cheat_target_selected_button
								or button_style_name
									== creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
							if cheats_menu_gui_data.remove_target_button_function(player, target, button) then
								button.destroy()
							end
							-- Make sure we update the state AFTER the visibility of the targets container is updated.
							update_targets_selection_visibility_for_player(player, cheats_menu_gui_data)
							-- Update status if necessary.
							if need_update_status then
								update_all_cheats_status_in_cheats_menu_for_player(player, cheats_menu_gui_data)
							end
						end
					else
						-- The button doesn't exist.
						if is_add then
							add_target_button_with_exact_name_in_targets_inner_container_for_player(
								player,
								target,
								cheats_menu_gui_data,
								targets_inner_container,
								button_name
							)
							update_targets_selection_visibility_for_player(player, cheats_menu_gui_data)
						end
					end
				end
			end
		end
	end
end

----------------

-- Resets the last action applied on the cheats menu GUI by the player of given index.
local function reset_last_cheats_menu_gui_action_by_player_index(player_index)
	if storage.last_cheats_menu_gui_actions_by_players then
		storage.last_cheats_menu_gui_actions_by_players[player_index] = nil
	end
end

-- Generic function for creating a cheats menu for the given player according to the given cheats menu GUI data.
-- If the menu already exists, it will be destroyed instead.
local function create_or_destroy_cheats_menu_for_player(player, cheats_menu_gui_data, destroy_only)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		local cheats_menus_container = container[cheats_menu_gui_data.parent.get_container_name_function()]
		if cheats_menus_container then
			local current_structure_data = cheats_menu_gui_data.frame
			local frame = cheats_menus_container[current_structure_data.name]

			-- Reset recorded action.
			reset_last_cheats_menu_gui_action_by_player_index(player.index)

			if frame then
				-- Already opened.
				frame.destroy()
			elseif not destroy_only then
				-- Not yet opened.
				-- Frame.
				frame = cheats_menus_container.add({
					type = "frame",
					name = current_structure_data.name,
					direction = "vertical",
					caption = current_structure_data.caption,
				})

				-- Outer container.
				local outer_container_data = current_structure_data.outer_container
				current_structure_data = outer_container_data.targets_scroll_pane
				local column_count
				if current_structure_data then
					column_count = 2
				else
					column_count = 1
				end
				local outer_container = frame.add({
					type = "flow",
					name = outer_container_data.name,
					direction = "horizontal",
				})

				-------

				-- We will need the selected targets for setting the cheat status.
				local selected_targets = {}

				-- Targets scroll pane.
				if current_structure_data then
					local targets_scroll_pane = outer_container.add({
						type = "scroll-pane",
						name = current_structure_data.name,
						style = creative_mode_defines.names.gui_styles.cheat_scroll_pane,
					})

					-- Targets outer container.
					current_structure_data = current_structure_data.outer_container
					local targets_outer_container = targets_scroll_pane.add({
						type = "frame",
						name = current_structure_data.name,
						style = creative_mode_defines.names.gui_styles.cheat_target_selection_container_frame,
						direction = "vertical",
					})

					-- Targets inner container (vertical spacing doesn't work in frame).
					local inner_container_data = current_structure_data.inner_container
					local targets_inner_container = targets_outer_container.add({
						type = "flow",
						name = inner_container_data.name,
						style = creative_mode_defines.names.gui_styles.no_vertical_spacing_resize_row_flow,
						direction = "vertical",
					})

					-- Add targets.
					current_structure_data = inner_container_data.target_button
					local button_name_prefix = current_structure_data.name_prefix
					-- We will need the number of valid options for determining whether the target selection scroll pane should be shown or hidden.
					local valid_target_count = 0
					-- Get targets.
					local unverified_target_list, single_target =
						cheats_menu_gui_data.get_unverified_targets_function(player)
					-- Unverified target list.
					if unverified_target_list then
						for _, target in pairs(unverified_target_list) do
							-- Exclude invalid targets.
							if cheats_menu_gui_data.verify_target_function(player, target) then
								local button, is_self = add_target_button_in_targets_inner_container_for_player(
									player,
									target,
									cheats_menu_gui_data,
									targets_inner_container,
									button_name_prefix
								)
								if is_self then
									table.insert(selected_targets, target)
								end
								if
									cheats_menu_gui_data.check_is_target_button_valid_function(player, target, button)
								then
									valid_target_count = valid_target_count + 1
								end
							end
						end
					end
					-- Single, verified target.
					if single_target then
						local button, is_self = add_target_button_in_targets_inner_container_for_player(
							player,
							single_target,
							cheats_menu_gui_data,
							targets_inner_container,
							button_name_prefix
						)
						if is_self then
							table.insert(selected_targets, single_target)
						end
						if
							cheats_menu_gui_data.check_is_target_button_valid_function(player, single_target, button)
						then
							valid_target_count = valid_target_count + 1
						end
					end

					-- Select all button.
					current_structure_data = inner_container_data.select_all_button
					targets_scroll_pane.add({
						type = "button",
						name = current_structure_data.name,
						style = creative_mode_defines.names.gui_styles.cheat_select_all_targets_button,
						caption = { "gui.creative-mode_list-select-all" },
						tooltip = { "gui.creative-mode_list-select-all-tooltip" },
					})

					-- Show or hide the target selection scroll pane according to the number of valid options.
					show_or_hide_targets_selection(outer_container, targets_scroll_pane, valid_target_count > 1)
				end

				-------

				-- Cheats scroll pane.
				current_structure_data = outer_container_data.cheats_scroll_pane
				local cheats_scroll_pane = outer_container.add({
					type = "scroll-pane",
					name = current_structure_data.name,
					style = creative_mode_defines.names.gui_styles.cheat_scroll_pane,
				})

				-- Cheats container.
				current_structure_data = current_structure_data.cheats_container
				local cheats_container = cheats_scroll_pane.add({
					type = "flow",
					name = current_structure_data.name,
					direction = "vertical",
				})

				-- Cheats.
				for _, cheat_gui_data in pairs(cheats_menu_gui_data.cheats_gui_data) do
					gui_menu_cheats.create_cheat_elements_from_data_for_player(
						player,
						cheats_container,
						cheat_gui_data,
						selected_targets,
						true
					)
				end

				-- Enable all / Disable all.
				local enable_disable_all_container_data = current_structure_data.enable_disable_all_container
				if enable_disable_all_container_data then
					create_enable_and_disable_all_buttons(
						cheats_container,
						enable_disable_all_container_data.name,
						enable_disable_all_container_data.enable_all_button_name,
						enable_disable_all_container_data.disable_all_button_name
					)
				end

				-- Notes.
				if current_structure_data.notes then
					for _, note_data in pairs(current_structure_data.notes) do
						cheats_container.add({
							type = "label",
							name = note_data.name,
							style = creative_mode_defines.names.gui_styles.cheat_note_label,
							caption = note_data.caption,
						})
					end
				end
			end
		end
	end
end

--------------------------------------------------------------------

-- Updates the target list of the cheats menu of given cheats menu GUI data in the given outer table with its data for the given player.
-- Returns the targets that are still being selected.
-- Note: the cheats status will not be updated.
local function update_targets_selection_for_player_in_outer_container(
	player,
	cheats_menu_gui_data,
	outer_container_data,
	outer_container
)
	-- By update, we mean clear the whole target list and add back the valid targets.

	-- We will need the selected targets for setting the cheat status.
	local selected_targets = nil
	-- Targets scroll pane. Update only if there is the targets scroll pane.
	local current_structure_data = outer_container_data.targets_scroll_pane
	if current_structure_data then
		local targets_scroll_pane = outer_container[current_structure_data.name]
		selected_targets = {}
		-- Targets outer container.
		current_structure_data = current_structure_data.outer_container
		local targets_outer_container = targets_scroll_pane[current_structure_data.name]
		-- Targets inner container (vertical spacing doesn't work in frame).
		current_structure_data = current_structure_data.inner_container
		local targets_inner_container = targets_outer_container[current_structure_data.name]
		-- Update targets (A little bit different from creating the GUI).
		current_structure_data = current_structure_data.target_button
		local button_name_prefix = current_structure_data.name_prefix
		-- Get the buttons that are currently selected. We will keep selecting them after the target list is updated, so the user will not notice.
		local selected_buttons = {}
		for _, child_name in ipairs(targets_inner_container.children_names) do
			local button = targets_inner_container[child_name]
			local button_style_name = button.style.name
			if
				button_style_name == creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
				or button_style_name == creative_mode_defines.names.gui_styles.cheat_target_selected_button
			then
				selected_buttons[button.name] = true
			end
			-- Also clear the buttons at the same time.
			button.destroy()
		end
		-- Add back the	targets.
		-- We will need the number of valid options for determining whether the target selection scroll pane should be shown or hidden.
		local valid_target_count = 0
		-- Get targets.
		local unverified_target_list, single_target = cheats_menu_gui_data.get_unverified_targets_function(player)
		-- Unverified target list.
		if unverified_target_list then
			for _, target in pairs(unverified_target_list) do
				-- Exclude invalid targets.
				if cheats_menu_gui_data.verify_target_function(player, target) then
					local button, is_self = add_target_button_in_targets_inner_container_for_player(
						player,
						target,
						cheats_menu_gui_data,
						targets_inner_container,
						button_name_prefix
					)
					if cheats_menu_gui_data.check_is_target_button_valid_function(player, target, button) then
						valid_target_count = valid_target_count + 1
					end
					-- Check whether the button should be selected.
					if selected_buttons[button.name] then
						table.insert(selected_targets, target)
						if is_self then
							button.style = creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
						else
							button.style = creative_mode_defines.names.gui_styles.cheat_target_selected_button
						end
					else
						if is_self then
							button.style = creative_mode_defines.names.gui_styles.cheat_target_self_unselected_button
						else
							button.style = creative_mode_defines.names.gui_styles.cheat_target_unselected_button
						end
					end
				end
			end
		end
		-- Single, verified target.
		if single_target then
			local button, is_self = add_target_button_in_targets_inner_container_for_player(
				player,
				single_target,
				cheats_menu_gui_data,
				targets_inner_container,
				button_name_prefix
			)
			if cheats_menu_gui_data.check_is_target_button_valid_function(player, single_target, button) then
				valid_target_count = valid_target_count + 1
			end
			-- Check whether the button should be selected.
			-- If there is only one valid target, make sure this target is selected.
			if selected_buttons[button.name] or valid_target_count <= 1 then
				table.insert(selected_targets, single_target)
				if is_self then
					button.style = creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
				else
					button.style = creative_mode_defines.names.gui_styles.cheat_target_selected_button
				end
			else
				if is_self then
					button.style = creative_mode_defines.names.gui_styles.cheat_target_self_unselected_button
				else
					button.style = creative_mode_defines.names.gui_styles.cheat_target_unselected_button
				end
			end
		end
		-- Show or hide the target selection scroll pane according to the number of valid options.
		show_or_hide_targets_selection(outer_container, targets_scroll_pane, valid_target_count > 1)
	end
	return selected_targets
end

-- Updates the target list of the cheats menu of given cheats menu GUI data for the given player, then also updates all cheats status in that cheats menu.
-- Returns the targets that are still being selected.
local function update_targets_selection_and_all_cheats_status_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		-- Cheats container.
		local cheats_menus_container = container[cheats_menu_gui_data.parent.get_container_name_function()]
		if cheats_menus_container then
			local current_structure_data = cheats_menu_gui_data.frame
			-- Frame.
			local frame = cheats_menus_container[current_structure_data.name]
			if frame then
				-- Outer container.
				local outer_container_data = current_structure_data.outer_container
				local outer_container = frame[outer_container_data.name]
				local selected_targets = update_targets_selection_for_player_in_outer_container(
					player,
					cheats_menu_gui_data,
					outer_container_data,
					outer_container
				)
				update_all_cheats_status_in_cheats_menu_for_player_with_known_targets(
					player,
					cheats_menu_gui_data,
					selected_targets
				)
			end
		end
	end
	return nil
end

-- Updates the cheats menu accessibility according to the newest access right for the given player after the access rights of the given codes have changed.
function gui_menu_cheats.update_menu_accessibility_according_to_access_right_for_player(
	player,
	updated_access_right_codes
)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		-- Cheats container.
		local cheats_menus_container = container[gui_menu_cheats.get_container_name()]
		if cheats_menus_container then
			-- Iterate all submenus.
			for _, data in pairs(cheats_menus_gui_data.contents) do
				if updated_access_right_codes[data.access_right_code] then
					-- Check player access right.
					if data.get_player_can_access_function(player) then
						-- Player can access.
						-- Make sure the button is available for the player.
						local cheats_menu_frame =
							cheats_menus_container[creative_mode_defines.names.gui.cheats_menu_frame]
						local button = cheats_menu_frame[data.button_name]
						button.visible = true

						-- Update the targets and contents.
						local cheats_menu_gui_data = data.cheats_menu_gui_data
						local current_structure_data = cheats_menu_gui_data.frame

						-- Frame.
						local frame = cheats_menus_container[current_structure_data.name]
						-- Make sure the frame is currently being opened.
						if frame then
							-- Outer container.
							local outer_container_data = current_structure_data.outer_container
							local outer_container = frame[outer_container_data.name]
							-------
							-- Update targets (A little bit different from creating the GUI).
							local selected_targets = update_targets_selection_for_player_in_outer_container(
								player,
								cheats_menu_gui_data,
								outer_container_data,
								outer_container
							)
							-------
							-- Cheats scorll pane.
							current_structure_data = outer_container_data.cheats_scroll_pane
							local cheats_scroll_pane = outer_container[current_structure_data.name]
							-- Cheats container.
							current_structure_data = outer_container_data.cheats_container
							local cheats_container = outer_container[current_structure_data.name]
							-- Cheats.
							for _, cheat_gui_data in pairs(cheats_menu_gui_data.cheats_gui_data) do
								gui_menu_cheats.update_cheat_status_from_data(
									cheats_container,
									cheat_gui_data,
									selected_targets
								)
								update_cheat_visibility_from_data_for_player(player, cheats_container, cheat_gui_data)
							end
						end
					else
						-- Player cannot access.
						-- Hide the menu button.
						local cheats_menu_frame =
							cheats_menus_container[creative_mode_defines.names.gui.cheats_menu_frame]
						local button = cheats_menu_frame[data.button_name]
						button.visible = false

						-- Remove the menu.
						create_or_destroy_cheats_menu_for_player(player, data.cheats_menu_gui_data, true)
					end
				end
			end
		end
	end
end

-- Updates the build options menu accessibility according to the newest access right for the given player after the access rights of the given codes have changed.
function gui_menu_buildoptions.update_menu_accessibility_according_to_access_right_for_player(
	player,
	updated_access_right_codes
)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		-- Cheats container.
		local cheats_menus_container = container[gui_menu_buildoptions.get_container_name()]
		if cheats_menus_container then
			-- Iterate all submenus.
			for _, data in pairs(build_options_menus_gui_data.contents) do
				if updated_access_right_codes[data.access_right_code] then
					-- Update the targets and contents.
					local cheats_menu_gui_data = data.cheats_menu_gui_data
					local current_structure_data = cheats_menu_gui_data.frame

					-- Frame.
					local frame = cheats_menus_container[current_structure_data.name]
					-- Make sure the frame is currently being opened.
					if frame then
						-- Outer container.
						local outer_container_data = current_structure_data.outer_container
						local outer_container = frame[outer_container_data.name]
						-------
						-- Update targets (A little bit different from creating the GUI).
						local selected_targets = update_targets_selection_for_player_in_outer_container(
							player,
							cheats_menu_gui_data,
							outer_container_data,
							outer_container
						)
						-------
						-- Cheats scorll pane.
						current_structure_data = outer_container_data.cheats_scroll_pane
						local cheats_scroll_pane = outer_container[current_structure_data.name]
						-- Cheats container.
						current_structure_data = current_structure_data.cheats_container
						local cheats_container = cheats_scroll_pane[current_structure_data.name]
						-- Cheats.
						for _, cheat_gui_data in pairs(cheats_menu_gui_data.cheats_gui_data) do
							gui_menu_cheats.update_cheat_status_from_data(
								cheats_container,
								cheat_gui_data,
								selected_targets
							)
							update_cheat_visibility_from_data_for_player(player, cheats_container, cheat_gui_data)
						end
					end
				end
			end
		end
	end
end

--------------------------------------------------------------------

-- Creates the build options menu for the given player. If the meun already exists, it will be destroyed instead.
function gui_menu_buildoptions.create_or_destroy_menu_for_player(player)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		-- Build options container.
		local build_options_menus_container = container[gui_menu_buildoptions.get_container_name()]
		if build_options_menus_container then
			build_options_menus_container.destroy()
		else
			build_options_menus_container = container.add({
				type = "flow",
				name = gui_menu_buildoptions.get_container_name(),
				style = creative_mode_defines.names.gui_styles.no_horizontal_spacing_flow,
				direction = "horizontal",
			})

			-- Create the build options menu by calling the same method for creating cheats menu.
			create_or_destroy_cheats_menu_for_player(
				player,
				build_options_menus_gui_data.contents.build_options.cheats_menu_gui_data,
				false
			)
		end
	end
end

--------------------------------------------------------------------

-- Returns the style for the given cheat target selection button after it is clicked.
local function get_reversed_cheat_target_selection_button_style(button)
	local style_name = button.style.name
	if style_name == creative_mode_defines.names.gui_styles.cheat_target_selected_button then
		return creative_mode_defines.names.gui_styles.cheat_target_unselected_button
	elseif style_name == creative_mode_defines.names.gui_styles.cheat_target_unselected_button then
		return creative_mode_defines.names.gui_styles.cheat_target_selected_button
	elseif style_name == creative_mode_defines.names.gui_styles.cheat_target_self_selected_button then
		return creative_mode_defines.names.gui_styles.cheat_target_self_unselected_button
	else
		return creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
	end
end

-- Returns the current numeric value for the given numeric cheat according to the cheat's textfield.
-- If the value is not valid, the textfield will be reset to the given default value.
local function get_numeric_cheat_textfield_value(player, cheats_menu_gui_data, cheat_gui_data, default_value)
	local cheats_container = get_cheats_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	if cheats_container then
		-- Container
		local cheat_container = cheats_container[cheat_gui_data.container_name]
		-- Textfield
		local textfield = cheat_container[cheat_gui_data.textfield_name]
		local value = tonumber(textfield.text)
		if value then
			return value
		else
			value = default_value
			textfield.text = tostring(value)
		end
	end
	return default_value
end

-- Returns the current string value for the given string cheat according to the cheat's textfield.
-- If the value is not valid, the textfield will be reset to the given default value.
local function get_string_cheat_textfield_value(player, cheats_menu_gui_data, cheat_gui_data, default_value)
	local cheats_container = get_cheats_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	if cheats_container then
		-- Container
		local cheat_container = cheats_container[cheat_gui_data.container_name]
		-- Textfield
		local textfield = cheat_container[cheat_gui_data.textfield_name]
		local value = tostring(textfield.text)
		if value then
			return value
		else
			value = default_value
			textfield.text = tostring(value)
		end
	end
	return default_value
end

--------------------------------------------------------------------

-- Updates the status of all character cheats for all players as the given player has updated his cheat status.
function gui_menu_cheats.update_character_cheats_status_for_all_players_as_player_updated_his_status(changed_player)
	for _, player in pairs(game.players) do
		local targets =
			get_all_selected_targets_in_cheats_menu_for_player(player, personal_cheats_menu_gui_data, changed_player)
		if targets then
			local cheats_container =
				get_cheats_container_in_cheats_menu_for_player(player, personal_cheats_menu_gui_data)
			if cheats_container then
				for _, cheat_gui_data in pairs(personal_cheats_menu_gui_data.cheats_gui_data) do
					if cheat_gui_data.is_character_cheat then
						gui_menu_cheats.update_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
					end
				end
			end
		end
	end
end

-- Updates the status of all daytime cheats for all players as the given surface has updated its daytime.
function gui_menu_cheats.update_daytime_cheats_status_for_all_players_as_surface_updated_its_daytime(changed_surface)
	for _, player in pairs(game.players) do
		local targets =
			get_all_selected_targets_in_cheats_menu_for_player(player, surface_cheats_menu_gui_data, changed_surface)
		if targets then
			local cheats_container =
				get_cheats_container_in_cheats_menu_for_player(player, surface_cheats_menu_gui_data)
			if cheats_container then
				for _, cheat_gui_data in pairs(surface_cheats_menu_gui_data.cheats_gui_data) do
					if cheat_gui_data.is_daytime_cheat then
						gui_menu_cheats.update_cheat_status_from_data(cheats_container, cheat_gui_data, targets)
					end
				end
			end
		end
	end
end

--------------------------------------------------------------------

-- Updates GUI when a player joined the game.
function gui_menu_cheats.on_player_joined_game(event)
	local player = game.players[event.player_index]
	-- Add the player as an option in personal cheats menu.
	add_or_remove_target_in_cheats_menu_for_all_players(player, personal_cheats_menu_gui_data, true)
	-- Add the player as an option in build cheats menu.
	add_or_remove_target_in_cheats_menu_for_all_players(player, build_options_menu_gui_data, true)
end

-- Updates GUI when a player left the game.
function gui_menu_cheats.on_player_left_game(event)
	local player = game.players[event.player_index]
	-- Remove the player as an option in personal cheats menu.
	add_or_remove_target_in_cheats_menu_for_all_players(player, personal_cheats_menu_gui_data, false)
	-- Remove the player as an option in build cheats menu.
	add_or_remove_target_in_cheats_menu_for_all_players(player, build_options_menu_gui_data, false)
end

-- Updates GUI when a player went to another surface.
function gui_menu_cheats.on_player_changed_surface(event)
	-- Update the target list and cheats status in surface cheats menu.
	update_targets_selection_and_all_cheats_status_in_cheats_menu_for_player(
		game.players[event.player_index],
		surface_cheats_menu_gui_data
	)
end

-- Detects on_gui_click event on the toggles of the cheats menu of given cheats menu GUI data for the given player.
-- This is the first pass, meaning the element name detection should be straight forward, i.e. simple comparison.
-- Returns whether the on_gui_click event is consumed.
-- If an element of a cheat GUI data is clicked and the associated cheat is applied, the cheat GUI data as well as the applied value (if any) will be returned too.
-- The applied value will be in the form of primitive data, e.g. if the actual value is a team, the team name will be used instead.
-- @param pre_applied_function	Optional. This function is called after a button of a cheat GUI data is clicked, but before it is applied. It contains the targets, cheat GUI data as well as the applied value.
--								It is useful for accessing data of entities before they are destroyed by the cheat.
function gui_menu_cheats.on_gui_click_in_cheats_menu_toggles(
	element,
	element_name,
	player,
	cheats_menu_gui_data,
	pre_applied_function
)
	for _, cheat_gui_data in pairs(cheats_menu_gui_data.cheats_gui_data) do
		local applied_cheat_gui_data = nil
		local applied_value = nil
		if cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.on_off then
			-- On/off cheats.
			if element_name == cheat_gui_data.on_button_name then
				-- On
				if get_cheats_menu_has_targets_selection(cheats_menu_gui_data) then
					local targets = get_all_selected_targets_in_cheats_menu_for_player(player, cheats_menu_gui_data)
					-- Apply only if there is any target.
					if targets and #targets > 0 then
						applied_cheat_gui_data = cheat_gui_data
						applied_value = true
						if pre_applied_function then
							pre_applied_function(targets, applied_cheat_gui_data, applied_value)
						end
						cheats.apply_cheat_to_targets(
							player,
							targets,
							cheats_menu_gui_data.cheats_data,
							cheat_gui_data.cheat_data,
							true,
							true
						)
						gui_menu_cheats.update_cheat_status_in_cheats_menu_for_all_players(
							cheats_menu_gui_data,
							cheat_gui_data
						)
					end
				else
					applied_cheat_gui_data = cheat_gui_data
					applied_value = true
					if pre_applied_function then
						pre_applied_function(nil, applied_cheat_gui_data, applied_value)
					end
					cheats.apply_cheat_to_targets(
						player,
						nil,
						cheats_menu_gui_data.cheats_data,
						cheat_gui_data.cheat_data,
						true,
						true
					)
					gui_menu_cheats.update_cheat_status_in_cheats_menu_for_all_players(
						cheats_menu_gui_data,
						cheat_gui_data
					)
				end
				return true, applied_cheat_gui_data, applied_value
			end

			if element_name == cheat_gui_data.off_button_name then
				-- Off
				if get_cheats_menu_has_targets_selection(cheats_menu_gui_data) then
					local targets = get_all_selected_targets_in_cheats_menu_for_player(player, cheats_menu_gui_data)
					-- Apply only if there is any target.
					if targets and #targets > 0 then
						applied_cheat_gui_data = cheat_gui_data
						applied_value = false
						if pre_applied_function then
							pre_applied_function(targets, applied_cheat_gui_data, applied_value)
						end
						cheats.apply_cheat_to_targets(
							player,
							targets,
							cheats_menu_gui_data.cheats_data,
							cheat_gui_data.cheat_data,
							false,
							true
						)
						gui_menu_cheats.update_cheat_status_in_cheats_menu_for_all_players(
							cheats_menu_gui_data,
							cheat_gui_data
						)
					end
				else
					applied_cheat_gui_data = cheat_gui_data
					applied_value = false
					if pre_applied_function then
						pre_applied_function(nil, applied_cheat_gui_data, applied_value)
					end
					cheats.apply_cheat_to_targets(
						player,
						nil,
						cheats_menu_gui_data.cheats_data,
						cheat_gui_data.cheat_data,
						false,
						true
					)
					gui_menu_cheats.update_cheat_status_in_cheats_menu_for_all_players(
						cheats_menu_gui_data,
						cheat_gui_data
					)
				end
				return true, applied_cheat_gui_data, applied_value
			end
		elseif cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.numeric_apply then
			-- Numeric apply cheats.
			if element_name == cheat_gui_data.apply_button_name then
				-- Apply
				local current_value = get_numeric_cheat_textfield_value(player, cheats_menu_gui_data, cheat_gui_data, 0)
				if get_cheats_menu_has_targets_selection(cheats_menu_gui_data) then
					local targets = get_all_selected_targets_in_cheats_menu_for_player(player, cheats_menu_gui_data)
					-- Apply only if there is any target.
					if targets and #targets > 0 and current_value ~= nil then
						applied_cheat_gui_data = cheat_gui_data
						applied_value = current_value
						if pre_applied_function then
							pre_applied_function(targets, applied_cheat_gui_data, applied_value)
						end
						cheats.apply_cheat_to_targets(
							player,
							targets,
							cheats_menu_gui_data.cheats_data,
							cheat_gui_data.cheat_data,
							current_value,
							true
						)
						gui_menu_cheats.update_cheat_status_in_cheats_menu_for_all_players(
							cheats_menu_gui_data,
							cheat_gui_data
						)
					end
				else
					applied_cheat_gui_data = cheat_gui_data
					applied_value = current_value
					if pre_applied_function then
						pre_applied_function(nil, applied_cheat_gui_data, applied_value)
					end
					cheats.apply_cheat_to_targets(
						player,
						nil,
						cheats_menu_gui_data.cheats_data,
						cheat_gui_data.cheat_data,
						current_value,
						true
					)
					gui_menu_cheats.update_cheat_status_in_cheats_menu_for_all_players(
						cheats_menu_gui_data,
						cheat_gui_data
					)
				end
				return true, applied_cheat_gui_data, applied_value
			end
		elseif cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.string_apply then
			-- String apply cheats.
			if element_name == cheat_gui_data.apply_button_name then
				-- Apply
				local current_value = get_string_cheat_textfield_value(player, cheats_menu_gui_data, cheat_gui_data, "")
				if get_cheats_menu_has_targets_selection(cheats_menu_gui_data) then
					local targets = get_all_selected_targets_in_cheats_menu_for_player(player, cheats_menu_gui_data)
					-- Apply only if there is any target.
					if targets and #targets > 0 and current_value ~= nil then
						applied_cheat_gui_data = cheat_gui_data
						applied_value = current_value
						if pre_applied_function then
							pre_applied_function(targets, applied_cheat_gui_data, applied_value)
						end
						cheats.apply_cheat_to_targets(
							player,
							targets,
							cheats_menu_gui_data.cheats_data,
							cheat_gui_data.cheat_data,
							current_value,
							true
						)
						gui_menu_cheats.update_cheat_status_in_cheats_menu_for_all_players(
							cheats_menu_gui_data,
							cheat_gui_data
						)
					end
				else
					applied_cheat_gui_data = cheat_gui_data
					applied_value = current_value
					if pre_applied_function then
						pre_applied_function(nil, applied_cheat_gui_data, applied_value)
					end
					cheats.apply_cheat_to_targets(
						player,
						nil,
						cheats_menu_gui_data.cheats_data,
						cheat_gui_data.cheat_data,
						current_value,
						true
					)
					gui_menu_cheats.update_cheat_status_in_cheats_menu_for_all_players(
						cheats_menu_gui_data,
						cheat_gui_data
					)
				end
				return true, applied_cheat_gui_data, applied_value
			end
		elseif cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.apply then
			-- Apply cheats.
			if element_name == cheat_gui_data.apply_button_name then
				-- Apply
				if get_cheats_menu_has_targets_selection(cheats_menu_gui_data) then
					local targets = get_all_selected_targets_in_cheats_menu_for_player(player, cheats_menu_gui_data)
					-- Apply only if there is any target.
					if targets and #targets > 0 then
						applied_cheat_gui_data = cheat_gui_data
						if pre_applied_function then
							pre_applied_function(targets, applied_cheat_gui_data, applied_value)
						end
						cheats.apply_cheat_to_targets(
							player,
							targets,
							cheats_menu_gui_data.cheats_data,
							cheat_gui_data.cheat_data,
							nil,
							true
						)
					end
				else
					applied_cheat_gui_data = cheat_gui_data
					if pre_applied_function then
						pre_applied_function(nil, applied_cheat_gui_data, applied_value)
					end
					cheats.apply_cheat_to_targets(
						player,
						nil,
						cheats_menu_gui_data.cheats_data,
						cheat_gui_data.cheat_data,
						nil,
						true
					)
				end
				return true, applied_cheat_gui_data, nil
			end
		elseif cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.team_target_auto_apply then
			-- Team target auto apply cheats.
			if element_name == cheat_gui_data.current_selection_button_name then
				-- Current selectio button.
				local cheats_container = get_cheats_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
				show_or_hide_team_target_auto_apply_cheat_drop_down_from_data(cheats_container, cheat_gui_data)
				return true
			elseif element.parent and element.parent.name == cheat_gui_data.drop_down_inner_flow_name then
				-- Drop down target selection button.
				local selected_team_name =
					string.match(element_name, cheat_gui_data.drop_down_selection_button_name_pattern)
				if selected_team_name then
					local selected_team = game.forces[selected_team_name]
					if selected_team then
						if get_cheats_menu_has_targets_selection(cheats_menu_gui_data) then
							local targets =
								get_all_selected_targets_in_cheats_menu_for_player(player, cheats_menu_gui_data)
							-- Apply only if there is any target.
							if targets and #targets > 0 then
								applied_cheat_gui_data = cheat_gui_data
								applied_value = selected_team_name
								if pre_applied_function then
									pre_applied_function(targets, applied_cheat_gui_data, applied_value)
								end
								cheats.apply_cheat_to_targets(
									player,
									targets,
									cheats_menu_gui_data.cheats_data,
									cheat_gui_data.cheat_data,
									selected_team,
									true
								)
								gui_menu_cheats.update_cheat_status_in_cheats_menu_for_all_players(
									cheats_menu_gui_data,
									cheat_gui_data
								)
							end
						else
							applied_cheat_gui_data = cheat_gui_data
							applied_value = selected_team_name
							if pre_applied_function then
								pre_applied_function(nil, applied_cheat_gui_data, applied_value)
							end
							cheats.apply_cheat_to_targets(
								player,
								nil,
								cheats_menu_gui_data.cheats_data,
								cheat_gui_data.cheat_data,
								selected_team,
								true
							)
							gui_menu_cheats.update_cheat_status_in_cheats_menu_for_all_players(
								cheats_menu_gui_data,
								cheat_gui_data
							)
						end
						-- Hide the selection.
						local cheats_container =
							get_cheats_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
						show_or_hide_team_target_auto_apply_cheat_drop_down_from_data(cheats_container, cheat_gui_data)
					else
						-- Invalid team.
						element.destroy()
					end
				else
					-- Invalid team.
					element.destroy()
				end
				return true, applied_cheat_gui_data, applied_value
			end
		end
	end

	local enable_disable_all_container =
		cheats_menu_gui_data.frame.outer_container.cheats_scroll_pane.cheats_container.enable_disable_all_container
	if enable_disable_all_container then
		if element_name == enable_disable_all_container.enable_all_button_name then
			-- Enable all.
			if get_cheats_menu_has_targets_selection(cheats_menu_gui_data) then
				local targets = get_all_selected_targets_in_cheats_menu_for_player(player, cheats_menu_gui_data)
				if targets and #targets > 0 then
					cheats.enable_or_disable_all_cheats_to_targets(
						player,
						targets,
						cheats_menu_gui_data.cheats_data,
						true,
						true
					)
					update_all_cheats_status_in_cheats_menu_for_all_players(cheats_menu_gui_data)
				end
			else
				cheats.enable_or_disable_all_cheats_to_targets(
					player,
					nil,
					cheats_menu_gui_data.cheats_data,
					true,
					true
				)
				update_all_cheats_status_in_cheats_menu_for_all_players(cheats_menu_gui_data)
			end
			return true
		elseif element_name == enable_disable_all_container.disable_all_button_name then
			-- Disable all.
			if get_cheats_menu_has_targets_selection(cheats_menu_gui_data) then
				local targets = get_all_selected_targets_in_cheats_menu_for_player(player, cheats_menu_gui_data)
				if targets and #targets > 0 then
					cheats.enable_or_disable_all_cheats_to_targets(
						player,
						targets,
						cheats_menu_gui_data.cheats_data,
						false,
						true
					)
					update_all_cheats_status_in_cheats_menu_for_all_players(cheats_menu_gui_data)
				end
			else
				cheats.enable_or_disable_all_cheats_to_targets(
					player,
					nil,
					cheats_menu_gui_data.cheats_data,
					false,
					true
				)
				update_all_cheats_status_in_cheats_menu_for_all_players(cheats_menu_gui_data)
			end
			return true
		end
	end

	return false
end

-- Detects on_gui_click event on the select-all-targets button of the cheats menu of given cheats menu GUI data for the given player.
local function on_gui_click_in_cheats_menu_select_all_button(element, element_name, player, cheats_menu_gui_data)
	local targets_scroll_pane_data = cheats_menu_gui_data.frame.outer_container.targets_scroll_pane
	if targets_scroll_pane_data then
		if element_name == targets_scroll_pane_data.outer_container.inner_container.select_all_button.name then
			-- Select all targets button.
			local inner_container = get_targets_inner_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
			if inner_container then
				-- Select all or deselect all?
				local deselect_all = true
				for _, child_name in ipairs(inner_container.children_names) do
					local button = inner_container[child_name]
					if cheats_menu_gui_data.check_is_target_button_valid_unknown_target_function(player, button) then
						local style_name = button.style.name
						if
							style_name == creative_mode_defines.names.gui_styles.cheat_target_unselected_button
							or style_name
								== creative_mode_defines.names.gui_styles.cheat_target_self_unselected_button
						then
							deselect_all = false
							break
						end
					end
				end
				-- Apply!
				for _, child_name in ipairs(inner_container.children_names) do
					local button = inner_container[child_name]
					if cheats_menu_gui_data.check_is_target_button_valid_unknown_target_function(player, button) then
						local style_name = button.style.name
						if deselect_all then
							-- Deselect all.
							if style_name == creative_mode_defines.names.gui_styles.cheat_target_selected_button then
								button.style = creative_mode_defines.names.gui_styles.cheat_target_unselected_button
							elseif
								style_name
								== creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
							then
								button.style =
									creative_mode_defines.names.gui_styles.cheat_target_self_unselected_button
							end
						else
							-- Select all.
							if style_name == creative_mode_defines.names.gui_styles.cheat_target_unselected_button then
								button.style = creative_mode_defines.names.gui_styles.cheat_target_selected_button
							elseif
								style_name
								== creative_mode_defines.names.gui_styles.cheat_target_self_unselected_button
							then
								button.style = creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
							end
						end
					end
				end
				-- Update cheats status.
				if deselect_all then
					update_all_cheats_status_in_cheats_menu_for_player_with_known_targets(
						player,
						cheats_menu_gui_data,
						nil
					)
				else
					update_all_cheats_status_in_cheats_menu_for_player(player, cheats_menu_gui_data)
				end
			end
			return true
		end
	end
end

-- Detects on_gui_click event on the target buttons of the cheats menu of given cheats menu GUI data for the given player.
-- This is the last pass, meaning the element name detection can be complex, e.g. string pattern matching.
local function on_gui_click_in_cheats_menu_target_buttons(
	element,
	element_name,
	player,
	button,
	alt,
	control,
	shift,
	cheats_menu_gui_data
)
	local inner_container = get_targets_inner_container_in_cheats_menu_for_player(player, cheats_menu_gui_data)
	if element.parent and element.parent == inner_container then
		if cheats_menu_gui_data.get_button_actual_target_function then
			local target = cheats_menu_gui_data.get_button_actual_target_function(player, element)
			if target then
				-- We need to know the index of the clicked target.
				local slot
				for index, children in ipairs(inner_container.children) do
					if children == element then
						slot = index
						break
					end
				end

				-- Ctrl-click?
				if control then
					-- Simply reverse the clicked target without caring other selected targets.
					element.style = get_reversed_cheat_target_selection_button_style(element)
					update_all_cheats_status_in_cheats_menu_for_player(player, cheats_menu_gui_data)

					-- Record the slot for the next shift-click.
					storage.last_cheats_menu_gui_actions_by_players = storage.last_cheats_menu_gui_actions_by_players
						or {}
					storage.last_cheats_menu_gui_actions_by_players[player.index] = {
						non_shift = {
							slot = slot,
						},
					}
					return true
				end

				-- Shift-click?
				if shift then
					-- Select multiple targets and deselect the others.
					local non_shift_slot
					if
						storage.last_cheats_menu_gui_actions_by_players
						and storage.last_cheats_menu_gui_actions_by_players[player.index]
						and storage.last_cheats_menu_gui_actions_by_players[player.index].non_shift
					then
						non_shift_slot = storage.last_cheats_menu_gui_actions_by_players[player.index].non_shift.slot
					else
						-- In case there is no recorded non-shift-clicked slot, we make one.
						-- Find the first slot that has been selected. But assume we have the first slot first.
						non_shift_slot = 1
						for index, children in ipairs(inner_container.children) do
							local style_name = children.style.name
							if
								style_name == creative_mode_defines.names.gui_styles.cheat_target_selected_button
								or style_name
									== creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
							then
								non_shift_slot = index
								break
							end
						end
						storage.last_cheats_menu_gui_actions_by_players = storage.last_cheats_menu_gui_actions_by_players
							or {}
						storage.last_cheats_menu_gui_actions_by_players[player.index] = {
							non_shift = {
								slot = non_shift_slot,
							},
						}
					end

					local min_slot, max_slot
					if slot < non_shift_slot then
						min_slot = slot
						max_slot = non_shift_slot
					else
						min_slot = non_shift_slot
						max_slot = slot
					end

					-- Select the buttons that are in range and deselect those that are not.
					for index, child in ipairs(inner_container.children) do
						local style = child.style
						local visible = visible
						if visible ~= false then
							local style_name = style.name
							if index >= min_slot and index <= max_slot then
								-- Select.
								if
									style_name == creative_mode_defines.names.gui_styles.cheat_target_unselected_button
								then
									child.style = creative_mode_defines.names.gui_styles.cheat_target_selected_button
								elseif
									style_name
									== creative_mode_defines.names.gui_styles.cheat_target_self_unselected_button
								then
									child.style =
										creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
								end
							else
								-- Deselect.
								if
									style_name == creative_mode_defines.names.gui_styles.cheat_target_selected_button
								then
									child.style = creative_mode_defines.names.gui_styles.cheat_target_unselected_button
								elseif
									style_name
									== creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
								then
									child.style =
										creative_mode_defines.names.gui_styles.cheat_target_self_unselected_button
								end
							end
						end
					end

					-- Update cheats status.
					update_all_cheats_status_in_cheats_menu_for_player(player, cheats_menu_gui_data)
					return true
				end

				-- No ctrl, no shift, deselect others and only select the clicked target.
				-- Deselect all.
				for index, child in ipairs(inner_container.children) do
					if child ~= element then
						if cheats_menu_gui_data.check_is_target_button_valid_unknown_target_function(player, child) then
							local style_name = child.style.name
							if style_name == creative_mode_defines.names.gui_styles.cheat_target_selected_button then
								child.style = creative_mode_defines.names.gui_styles.cheat_target_unselected_button
							elseif
								style_name
								== creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
							then
								child.style = creative_mode_defines.names.gui_styles.cheat_target_self_unselected_button
							end
						end
					end
				end
				-- Select the clicked target.
				local style_name = element.style.name
				if style_name == creative_mode_defines.names.gui_styles.cheat_target_unselected_button then
					element.style = creative_mode_defines.names.gui_styles.cheat_target_selected_button
				elseif style_name == creative_mode_defines.names.gui_styles.cheat_target_self_unselected_button then
					element.style = creative_mode_defines.names.gui_styles.cheat_target_self_selected_button
				end
				-- Update cheats status.
				update_all_cheats_status_in_cheats_menu_for_player_with_known_targets(
					player,
					cheats_menu_gui_data,
					{ target }
				)

				-- Record the slot for the next shift-click.
				storage.last_cheats_menu_gui_actions_by_players = storage.last_cheats_menu_gui_actions_by_players or {}
				storage.last_cheats_menu_gui_actions_by_players[player.index] = {
					non_shift = {
						slot = slot,
					},
				}
				return true
			end
		end
	end
	return false
end

-- Detects on_gui_click event in the contents of the given cheats / build-options menus GUI data for the given player.
local function on_gui_click_in_cheats_menus_gui_data_contents(
	element,
	element_name,
	player,
	button,
	alt,
	control,
	shift,
	menus_gui_data
)
	for _, data in pairs(menus_gui_data.contents) do
		if
			gui_menu_cheats.on_gui_click_in_cheats_menu_toggles(
				element,
				element_name,
				player,
				data.cheats_menu_gui_data
			)
		then
			-- Cheat toggle.
			return true
		end
	end

	for _, data in pairs(menus_gui_data.contents) do
		local cheats_menu_gui_data = data.cheats_menu_gui_data
		if on_gui_click_in_cheats_menu_select_all_button(element, element_name, player, cheats_menu_gui_data) then
			-- Select-all-targets button.
			return true
		end

		if
			on_gui_click_in_cheats_menu_target_buttons(
				element,
				element_name,
				player,
				button,
				alt,
				control,
				shift,
				cheats_menu_gui_data
			)
		then
			-- Cheat target.
			return true
		end
	end
	return false
end

-- Callback of the on_gui_click event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_cheats.on_gui_click(element, element_name, player, button, alt, control, shift)
	for _, data in pairs(cheats_menus_gui_data.contents) do
		if element_name == data.button_name then
			-- Cheats menu button.
			-- Close other menus.
			for _, data2 in pairs(cheats_menus_gui_data.contents) do
				if data ~= data2 then
					create_or_destroy_cheats_menu_for_player(player, data2.cheats_menu_gui_data, true)
				end
			end
			-- Open menu.
			create_or_destroy_cheats_menu_for_player(player, data.cheats_menu_gui_data, false)
			return true
		end
	end

	-- Detect for the cheats menus.
	if
		on_gui_click_in_cheats_menus_gui_data_contents(
			element,
			element_name,
			player,
			button,
			alt,
			control,
			shift,
			cheats_menus_gui_data
		)
	then
		return true
	end

	-- Detect for the build-options menus.
	if
		on_gui_click_in_cheats_menus_gui_data_contents(
			element,
			element_name,
			player,
			button,
			alt,
			control,
			shift,
			build_options_menus_gui_data
		)
	then
		return true
	end

	return false
end

-- Callback of the on_gui_text_changed event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_cheats.on_gui_text_changed(element, element_name, player)
	return false
end

-- Callback of the on_gui_checked_state_changed event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_cheats.on_gui_checked_state_changed(element, element_name, player)
	return false
end
