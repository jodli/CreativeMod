-- This file contains variables and functions related to Creative Mode menu - magic wand GUI. The Modification popup for the Modifer magic wand is also included here.
if not gui_menu_magicwand then gui_menu_magicwand = {} end


--function gui_menu_magicwand.on_player_cursor_stack_changed(event)
--    local player = game.players[event.player_index]
--    local left = mod_gui.get_frame_flow(player)
--	local container = left[creative_mode_defines.names.gui.main_menu_container]
    
--end

-- Gets the name of the magic wand menu container.
function gui_menu_magicwand.get_container_name()
	return creative_mode_defines.names.gui.magic_wand_menus_container
end

----

-- The values of the resource amount slider buttons for the Creator magic wand.
local creator_resource_amount_slider_values = {1, 2, 3, 5, 10, 100, 1000, 2000, 5000, 10000, 100000, 1000000, 10000000}

-- GUI data for each of the cheats on the modification popup, created by the Modifier magic wand.
gui_menu_magicwand.modification_popup_cheats_gui_data =
{
	frame =
	{
		outer_container =
		{
			cheats_scroll_pane =
			{
				cheats_container =
				{
					enable_disable_all_container = nil
				}
			}
		}
	},
	
	cheats_data = cheats.magic_wand_modifications,
	
	cheats_gui_data =
	{
		active =
		{
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.magic_wand_modifications.cheats.active,
			container_name = creative_mode_defines.names.gui.magic_wand_modifier_active_container,
			label_name = creative_mode_defines.names.gui.magic_wand_modifier_active_label,
			label_caption = {"gui.creative-mode_build-active"},
			label_tooltip = {"gui.creative-mode_build-active-tooltip"},
			on_button_name = creative_mode_defines.names.gui.magic_wand_modifier_active_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.magic_wand_modifier_active_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
			
			action_code = "active",
			action_caption = {"gui.creative-mode_quick-action-active"},
			close_popup_after_applied = false
		},
		destructible =
		{
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.magic_wand_modifications.cheats.destructible,
			container_name = creative_mode_defines.names.gui.magic_wand_modifier_destructible_container,
			label_name = creative_mode_defines.names.gui.magic_wand_modifier_destructible_label,
			label_caption = {"gui.creative-mode_build-destructible"},
			label_tooltip = {"gui.creative-mode_build-destructible-tooltip"},
			on_button_name = creative_mode_defines.names.gui.magic_wand_modifier_destructible_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.magic_wand_modifier_destructible_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
			
			action_code = "destructible",
			action_caption = {"gui.creative-mode_quick-action-destructible"},
			close_popup_after_applied = false
		},
		minable =
		{
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.magic_wand_modifications.cheats.minable,
			container_name = creative_mode_defines.names.gui.magic_wand_modifier_minable_container,
			label_name = creative_mode_defines.names.gui.magic_wand_modifier_minable_label,
			label_caption = {"gui.creative-mode_build-minable"},
			label_tooltip = {"gui.creative-mode_build-minable-tooltip"},
			on_button_name = creative_mode_defines.names.gui.magic_wand_modifier_minable_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.magic_wand_modifier_minable_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
			
			action_code = "minable",
			action_caption = {"gui.creative-mode_quick-action-active"},
			close_popup_after_applied = false
		},
		rotatable =
		{
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.magic_wand_modifications.cheats.rotatable,
			container_name = creative_mode_defines.names.gui.magic_wand_modifier_rotatable_container,
			label_name = creative_mode_defines.names.gui.magic_wand_modifier_rotatable_label,
			label_caption = {"gui.creative-mode_build-rotatable"},
			label_tooltip = {"gui.creative-mode_build-rotatable-tooltip"},
			on_button_name = creative_mode_defines.names.gui.magic_wand_modifier_rotatable_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.magic_wand_modifier_rotatable_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
			
			action_code = "rotatable",
			action_caption = {"gui.creative-mode_quick-action-rotatable"},
			close_popup_after_applied = false
		},
		operable =
		{
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.magic_wand_modifications.cheats.operable,
			container_name = creative_mode_defines.names.gui.magic_wand_modifier_operable_container,
			label_name = creative_mode_defines.names.gui.magic_wand_modifier_operable_label,
			label_caption = {"gui.creative-mode_build-operable"},
			label_tooltip = {"gui.creative-mode_build-operable-tooltip"},
			on_button_name = creative_mode_defines.names.gui.magic_wand_modifier_operable_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.magic_wand_modifier_operable_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
			
			action_code = "operable",
			action_caption = {"gui.creative-mode_quick-action-operable"},
			close_popup_after_applied = false
		},
		full_health =
		{
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.magic_wand_modifications.cheats.full_health,
			container_name = creative_mode_defines.names.gui.magic_wand_modifier_full_health_container,
			label_name = creative_mode_defines.names.gui.magic_wand_modifier_full_health_label,
			label_caption = {"gui.creative-mode_build-full-health"},
			label_tooltip = {"gui.creative-mode_build-full-health-tooltip"},
			on_button_name = creative_mode_defines.names.gui.magic_wand_modifier_full_health_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.magic_wand_modifier_full_health_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
			
			action_code = "full-health",
			action_caption = {"gui.creative-mode_quick-action-full-health"},
			close_popup_after_applied = false
		},
		backer_name =
		{
			type = gui_menu_cheats.cheat_gui_type.string_apply,
			cheat_data = cheats.magic_wand_modifications.cheats.backer_name,
			container_name = creative_mode_defines.names.gui.magic_wand_modifier_backer_name_container,
			label_name = creative_mode_defines.names.gui.magic_wand_modifier_backer_name_label,
			label_caption = {"gui.creative-mode_backer-name"},
			label_tooltip = nil,
			textfield_name = creative_mode_defines.names.gui.magic_wand_modifier_backer_name_textfield,
			separator_name = creative_mode_defines.names.gui.magic_wand_modifier_backer_name_separator,
			apply_button_name = creative_mode_defines.names.gui.magic_wand_modifier_backer_name_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			
			action_code = "backer-name",
			action_caption = {"gui.creative-mode_backer-name"},
			close_popup_after_applied = false
		},
		to_be_looted =
		{
			type = gui_menu_cheats.cheat_gui_type.on_off,
			cheat_data = cheats.magic_wand_modifications.cheats.to_be_looted,
			container_name = creative_mode_defines.names.gui.magic_wand_modifier_to_be_looted_container,
			label_name = creative_mode_defines.names.gui.magic_wand_modifier_to_be_looted_label,
			label_caption = {"gui.creative-mode_to-be-looted"},
			label_tooltip = {"gui.creative-mode_to-be-looted-tooltip"},
			on_button_name = creative_mode_defines.names.gui.magic_wand_modifier_to_be_looted_on_button,
			on_button_caption = creative_mode_defines.names.gui_captions.on,
			off_button_name = creative_mode_defines.names.gui.magic_wand_modifier_to_be_looted_off_button,
			off_button_caption = creative_mode_defines.names.gui_captions.off,
			
			action_code = "to-be-looted",
			action_caption = {"gui.creative-mode_quick-action-to-be-looted"},
			close_popup_after_applied = false
		},
		revive =
		{
			type = gui_menu_cheats.cheat_gui_type.apply,
			cheat_data = cheats.magic_wand_modifications.cheats.revive,
			container_name = creative_mode_defines.names.gui.magic_wand_modifier_revive_container,
			label_name = creative_mode_defines.names.gui.magic_wand_modifier_revive_label,
			label_caption = {"gui.creative-mode_revive"},
			label_tooltip = {"gui.creative-mode_revive-tooltip"},
			apply_button_name = creative_mode_defines.names.gui.magic_wand_modifier_revive_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			
			action_code = "revive",
			action_caption = {"gui.creative-mode_quick-action-revive"},
			close_popup_after_applied = false
		},
		kill =
		{
			type = gui_menu_cheats.cheat_gui_type.apply,
			cheat_data = cheats.magic_wand_modifications.cheats.kill,
			container_name = creative_mode_defines.names.gui.magic_wand_modifier_kill_container,
			label_name = creative_mode_defines.names.gui.magic_wand_modifier_kill_label,
			label_caption = {"gui.creative-mode_kill"},
			label_tooltip = nil,
			apply_button_name = creative_mode_defines.names.gui.magic_wand_modifier_kill_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			
			action_code = "kill",
			action_caption = {"gui.creative-mode_kill"},
			close_popup_after_applied = false
		},
		destroy =
		{
			type = gui_menu_cheats.cheat_gui_type.apply,
			cheat_data = cheats.magic_wand_modifications.cheats.destroy,
			container_name = creative_mode_defines.names.gui.magic_wand_modifier_destroy_container,
			label_name = creative_mode_defines.names.gui.magic_wand_modifier_destroy_label,
			label_caption = {"gui.creative-mode_remove"},
			label_tooltip = nil,
			apply_button_name = creative_mode_defines.names.gui.magic_wand_modifier_destroy_apply_button,
			apply_button_caption = creative_mode_defines.names.gui_captions.ok,
			
			action_code = "destroy",
			action_caption = {"gui.creative-mode_remove"},
			close_popup_after_applied = true
		},
		team =
		{
			type = gui_menu_cheats.cheat_gui_type.team_target_auto_apply,
			cheat_data = cheats.magic_wand_modifications.cheats.team,
			container_name = creative_mode_defines.names.gui.magic_wand_modifier_team_container,
			label_name = creative_mode_defines.names.gui.magic_wand_modifier_team_label,
			label_caption = {"gui.creative-mode_build-team"},
			label_tooltip = {"gui.creative-mode_build-team-tooltip"},
			drop_down_container_name = creative_mode_defines.names.gui.magic_wand_modifier_team_targets_drop_down_container,
			current_selection_button_name = creative_mode_defines.names.gui.magic_wand_modifier_team_current_button,
			drop_down_scroll_pane_name = creative_mode_defines.names.gui.magic_wand_modifier_team_targets_scroll_pane,
			drop_down_inner_frame_name = creative_mode_defines.names.gui.magic_wand_modifier_team_targets_container,
			drop_down_inner_flow_name = creative_mode_defines.names.gui.magic_wand_modifier_team_targets_inner_container,
			drop_down_selection_button_name_prefx = creative_mode_defines.names.gui.magic_wand_modifier_team_target_name_button_prefix,
			drop_down_selection_button_name_pattern = creative_mode_defines.match_patterns.gui.magic_wand_modifier_team_target_name_button,
			
			action_code = "team",
			action_caption = {"gui.creative-mode_quick-action-team"},
			close_popup_after_applied = false
		}
	},
	
	has_targets_selection = true,
	
	get_all_selected_targets_function = function(player)
		return global.creative_mode.modifier_magic_wand_selection[player.index]
	end,
	
	get_cheats_container_function = function(player)
		local center = player.gui.center
		-- Container.
		local container = center[creative_mode_defines.names.gui.magic_wand_modifier_popup_container]
		if container then
			-- Actions frame.
			return container[creative_mode_defines.names.gui.magic_wand_modifier_popup_actions_frame]
		end
		return nil
	end
}

-- Maps the action code to the corresponding cheat GUI data.
gui_menu_magicwand.action_code_to_cheat_gui_data = {}
for _, cheat_gui_data in pairs(gui_menu_magicwand.modification_popup_cheats_gui_data.cheats_gui_data) do
	gui_menu_magicwand.action_code_to_cheat_gui_data[cheat_gui_data.action_code] = cheat_gui_data
end

----

-- Creates and returns the forces table for the given player in the given container.
local function create_forces_table(player, forces_table_container, forces_table_name, force_checkbox_name_prefix, get_force_checkbox_state_function, select_all_button_name)
	-- Force table.
	local force_table = forces_table_container.add{type = "table", name = forces_table_name, column_count = 1}
	-- Forces.
	for _, force in pairs(game.forces) do
		force_table.add
		{
			type = "checkbox",
			name = force_checkbox_name_prefix .. force.name,
			caption = force.name,
			tooltip = {"gui.creative-mode_team-name-tooltip", force.name},
			state = get_force_checkbox_state_function(player, force)
		}
	end	
	-- Select all button.
	force_table.add{type = "button", name = select_all_button_name, style = creative_mode_defines.names.gui_styles.magic_wand_select_all_button, caption = creative_mode_defines.names.gui_captions.select_all}
	return force_table
end

-- Function for creating tile or resource selection UI elements for the Creator magic wand.
local function create_tile_or_resource_selection_for_creator(player,
																container,
																get_selected_tile_prototype_function,
																tiles_table_name,
																tile_name_button_prefix,
																get_selected_resource_prototype_function,
																resources_table_name,
																resource_name_button_prefix,
																get_resource_amount_function,
																resource_amount_slider_container_name,
																resource_amount_slider_label_name,
																resource_amount_slider_space_name,
																resource_amount_slider_button_name_prefix,
																resource_amount_slider_space_2_name,
																resource_amount_slider_textfield_name)
	local column_count = 9															
	
	-- Get the selected tile.
	local selected_tile = get_selected_tile_prototype_function(player)
	-- Tiles table.
	local tiles_table = container.add{type = "table", name = tiles_table_name, style = creative_mode_defines.names.gui_styles.slot_table, column_count = column_count}
	-- Tile slots.
	for _, tile in pairs(game.tile_prototypes) do
		local style
		if selected_tile == tile then
			style = creative_mode_defines.names.gui_styles.tile_slot_selected
		else
			style = creative_mode_defines.names.gui_styles.tile_slot_deselected
		end
		tiles_table.add{type = "sprite-button", name = tile_name_button_prefix .. tile.name, sprite = "tile/" .. tile.name, style = style, tooltip = tile.localised_name}
	end
	
	-- Get the selected resource.
	local selected_resource = get_selected_resource_prototype_function(player)
	-- Resources table.
	local resources_table = container.add{type = "table", name = resources_table_name, style = creative_mode_defines.names.gui_styles.slot_table, column_count = column_count}
	-- Resource slots.
	for _, resource in pairs(game.entity_prototypes) do
		if resource.resource_category then
			local style
			if selected_resource == resource then
				style = creative_mode_defines.names.gui_styles.tile_slot_selected
			else
				style = creative_mode_defines.names.gui_styles.tile_slot_deselected
			end
			resources_table.add{type = "sprite-button", name = resource_name_button_prefix .. resource.name, sprite = "entity/" .. resource.name, style = style, tooltip = resource.localised_name}
		end	
	end
	
	-- Get the resource amount.
	local resource_amount = get_resource_amount_function(player)
	-- Resource amount table.
	local resource_amount_container = container.add{type = "table", name = resource_amount_slider_container_name, style = creative_mode_defines.names.gui_styles.unscalable_no_spacing_table, column_count = 1 + 1 + 16 + 1 + 1}
	-- Resource amount label.
	resource_amount_container.add{type = "label", name = resource_amount_slider_label_name, style = creative_mode_defines.names.gui_styles.magic_wand_slider_label, caption = {"gui.creative-mode_resource-amount"}}
	-- Spacing.
	resource_amount_container.add{type = "flow", name = resource_amount_slider_space_name, style = creative_mode_defines.names.gui_styles.cheat_textfield_and_button_separate_flow, direction = "horizontal"}
	-- Resource amount buttons.
	for i, value in ipairs(creator_resource_amount_slider_values) do
		local style
		if value <= resource_amount then
			style = creative_mode_defines.names.gui_styles.slider_button_on
		else
			style = creative_mode_defines.names.gui_styles.slider_button_off
		end
		resource_amount_container.add{type = "button", name = resource_amount_slider_button_name_prefix .. i, style = style}
	end
	-- Spacing.
	resource_amount_container.add{type = "flow", name = resource_amount_slider_space_2_name, style = creative_mode_defines.names.gui_styles.cheat_textfield_and_button_separate_flow, direction = "horizontal"}
	-- Textfield.
	resource_amount_container.add{type = "textfield", name = resource_amount_slider_textfield_name, style = creative_mode_defines.names.gui_styles.slider_textfield, text = resource_amount}				
end

-- Function for creating common UI elements for either the selection mode or the alternate selection mode of the Modifier magic wand.
local function create_common_elements_for_modifier(player,
													container,
													get_ignore_player_characters_function,
													ignore_player_characters_checkbox_name,
													get_ignore_healthless_entities_function,
													ignore_healthless_entities_checkbox_name,
													get_ignore_indestructible_entities_function,
													ignore_indestructible_entities_checkbox_name,
													forces_table_label_name,
													forces_table_name,
													force_checkbox_name_prefix,
													get_force_checkbox_state_function,
													select_all_button_name)
	-- Gets whether player characters should be ignored.
	local ignore_player_characters = get_ignore_player_characters_function(player)
	-- Checkbox.
	container.add{type = "checkbox", name = ignore_player_characters_checkbox_name, style = creative_mode_defines.names.gui_styles.magic_wand_checkbox, caption = {"gui.creative-mode_ignore-player-characters"}, state = ignore_player_characters}
	
	-- Gets whether healthless entities should be ignored.
	local ignore_healthless_entities = get_ignore_healthless_entities_function(player)
	-- Checkbox.
	container.add{type = "checkbox", name = ignore_healthless_entities_checkbox_name, style = creative_mode_defines.names.gui_styles.magic_wand_checkbox, caption = {"gui.creative-mode_ignore-healthless-entities"}, tooltip = {"gui.creative-mode_ignore-healthless-entities-tooltip"}, state = ignore_healthless_entities}
	
	-- Gets whether indestructible entities should be ignored.
	local ignore_indestructible_entities = get_ignore_indestructible_entities_function(player)
	-- Checkbox.
	container.add{type = "checkbox", name = ignore_indestructible_entities_checkbox_name, style = creative_mode_defines.names.gui_styles.magic_wand_checkbox, caption = {"gui.creative-mode_ignore-indestructible-entities"}, tooltip = {"gui.creative-mode_ignore-indestructible-entities-tooltip"}, state = ignore_indestructible_entities}
	
	-- Label.
	local label = container.add{type = "label", name = forces_table_label_name, style = creative_mode_defines.names.gui_styles.magic_wand_label, caption = {"gui.creative-mode_selectable-teams-of-entities"}}
	label.style.top_padding = 8
	-- Force table.
	create_forces_table(
		player,
		container,
		forces_table_name,
		force_checkbox_name_prefix,
		get_force_checkbox_state_function,
		select_all_button_name)
end

-- Clears all GUI elements for all recorded actions of the Modifier magic wand in the given actions container.
local function clear_all_elements_for_recorded_actions_of_modifier(actions_container, container)
	for _, child_name in ipairs(actions_container.children_names) do
		actions_container[child_name].destroy()
	end
	-- Also remove the remove all actions button.
	local remove_all_button = container[creative_mode_defines.names.gui.magic_wand_modifier_remove_all_quick_actions_button]
	if remove_all_button then
		remove_all_button.destroy()
	end
end

-- Creates the GUI elements for the given recorded action of the Modifier magic wand into the given actions container.
local function create_elements_for_recorded_action_of_modifier(actions_container, action)
	local index = #actions_container.children_names + 1
	
	-- The corresponding cheat GUI data.
	local cheat_gui_data = gui_menu_magicwand.action_code_to_cheat_gui_data[action.code]
	
	-- Container.
	local action_container = actions_container.add
	{
		type = "flow",
		name = creative_mode_defines.names.gui.magic_wand_modifier_quick_action_container_prefix .. index,
		style = creative_mode_defines.names.gui_styles.no_horizontal_spacing_flow,
		direction = "horizontal"
	}
	
	-- Remove button.
	action_container.add{type = "sprite-button", name = creative_mode_defines.names.gui.magic_wand_modifier_quick_action_remove_button, style = creative_mode_defines.names.gui_styles.magic_wand_quick_action_remove_button, sprite = creative_mode_defines.names.sprites.cancel, tooltip = {"gui.creative-mode_remove-this-action"}}
	-- Separator.
	action_container.add{type = "flow", name = creative_mode_defines.names.gui.magic_wand_modifier_quick_action_separator, style = creative_mode_defines.names.gui_styles.cheat_textfield_and_button_separate_flow, direction = "horizontal"}
	-- Name label.
	action_container.add{type = "label", name = creative_mode_defines.names.gui.magic_wand_modifier_quick_action_name_label, caption = cheat_gui_data.action_caption}
	
	if action.value ~= nil then
		-- Convert the value to value str.
		local value_str = nil
		if cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.on_off then
			-- On-off cheat: map to the on/off button captions.
			if action.value then
				value_str = cheat_gui_data.on_button_caption
			else
				value_str = cheat_gui_data.off_button_caption
			end
		elseif cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.numeric_apply then
			-- Numeric action.
			value_str = tostring(action.value)
		elseif cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.string_apply then
			-- String action.
			value_str = tostring(action.value)
		elseif cheat_gui_data.type == gui_menu_cheats.cheat_gui_type.team_target_auto_apply then
			-- Team selection action.
			value_str = tostring(action.value)
		end
		if value_str ~= nil then
			-- Colon label.
			action_container.add{type = "label", name = creative_mode_defines.names.gui.magic_wand_modifier_quick_action_colon_label, caption = " : "}
			-- Value label.
			action_container.add{type = "label", name = creative_mode_defines.names.gui.magic_wand_modifier_quick_action_value_label, caption = value_str}
		end
	end
end

-- Creates the remove all recorded actions button in the given container, if such button does not exist.
local function create_remove_all_recorded_actions_button_in_container(container)
	if not container[creative_mode_defines.names.gui.magic_wand_modifier_remove_all_quick_actions_button] then
		container.add{type = "button", name = creative_mode_defines.names.gui.magic_wand_modifier_remove_all_quick_actions_button, style = creative_mode_defines.names.gui_styles.magic_wand_select_all_button, caption = creative_mode_defines.names.gui_captions.remove_all}
	end
end

-- Creates the GUI elements for all recorded actions of modifier for the given player.
local function create_elements_for_recorded_actions_of_modifier(player, actions_container, container)
	if global.creative_mode.modifier_magic_wand_quick_actions[player.index] and global.creative_mode.modifier_magic_wand_quick_actions[player.index].actions then
		for _, action in ipairs(global.creative_mode.modifier_magic_wand_quick_actions[player.index].actions) do
			create_elements_for_recorded_action_of_modifier(actions_container, action)
		end
	end
	-- If there is no actions, add a hint about how to record actions.
	if #actions_container.children_names <= 0 then
		actions_container.add{type = "label", name = creative_mode_defines.names.gui.magic_wand_modifier_quick_action_name_label, caption = {"gui.creative-mode_quick-action-hints"}}
	else
		-- There is at least one action. Add the remove-all button.
		create_remove_all_recorded_actions_button_in_container(container)
	end
end

-- Refreshes the GUI elements for all recorded actions of modifier for the given player.
local function refresh_elements_for_recorded_actions_of_modifier(player, actions_container, container)
	-- Clear.
	clear_all_elements_for_recorded_actions_of_modifier(actions_container, container)
	-- Actions.
	create_elements_for_recorded_actions_of_modifier(player, actions_container, container)
end

-- GUI data about the menus for each magic wand.
gui_menu_magicwand.magic_wand_menus_gui_data =
{
	creator =
	{
		access_right_code = rights.use_creator_magic_wand_code,
		get_player_can_access_function = rights.can_player_use_creator_magic_wand,
		button_name = creative_mode_defines.names.gui.magic_wand_creator_menu_button,
		button_caption = {"gui.creative-mode_magic-wand-short-creator"},
		contents =
		{
			frame_name = creative_mode_defines.names.gui.magic_wand_creator_frame,
			title_container_name = creative_mode_defines.names.gui.magic_wand_creator_frame_title_container,
			title_name = creative_mode_defines.names.gui.magic_wand_creator_frame_title,
			get_item_button_name = creative_mode_defines.names.gui.magic_wand_creator_get_item_button,
			item_name = creative_mode_defines.names.items.magic_wand_creator,
			scroll_pane_name = creative_mode_defines.names.gui.magic_wand_creator_scroll_pane,
			container_name = creative_mode_defines.names.gui.magic_wand_creator_container,
			select_mode_container_name = creative_mode_defines.names.gui.magic_wand_creator_select_mode_container,
			alt_select_mode_container_name = creative_mode_defines.names.gui.magic_wand_creator_alt_select_mode_container,
			select_mode_label_name = creative_mode_defines.names.gui.magic_wand_creator_select_mode_label,
			select_mode_label_caption = {"gui.creative-mode_create-tiles-or-resources"},
			alt_select_mode_label_name = creative_mode_defines.names.gui.magic_wand_creator_alt_select_mode_label,
			alt_select_mode_label_caption = {"gui.creative-mode_remove-entities"},
			----
			create_select_mode_gui_function = function(player, container)
				-- Get whether tile edges should be corrected.
				local tile_correction = magic_wand_creator.get_tile_correction(player)
				-- Correct tiles checkbox.
				container.add{type = "checkbox", name = creative_mode_defines.names.gui.magic_wand_creator_correct_tiles_checkbox, style = creative_mode_defines.names.gui_styles.magic_wand_checkbox, caption = {"gui.creative-mode_correct-tiles"}, tooltip = {"gui.creative-mode_correct-tiles-tooltip"}, state = tile_correction}
				
				-- Get whether the don't-kill-players-by-tiles option is turned on.
				local dont_kill_players_by_tiles = magic_wand_creator.get_dont_kill_players_by_tiles(player)
				-- Don't kill players by tiles checkbox.
				container.add{type = "checkbox", name = creative_mode_defines.names.gui.magic_wand_creator_dont_kill_by_tiles_checkbox, style = creative_mode_defines.names.gui_styles.magic_wand_checkbox, caption = {"gui.creative-mode_dont-kill-players-by-tiles"}, tooltip = {"gui.creative-mode_dont-kill-players-by-tiles-tooltip"}, state = dont_kill_players_by_tiles}
				
				-- Tile or resource selection.
				create_tile_or_resource_selection_for_creator(
					player,
					container,
					magic_wand_creator.get_selected_tile_prototype,
					creative_mode_defines.names.gui.magic_wand_creator_tiles_table,
					creative_mode_defines.names.gui.magic_wand_creator_tile_name_button_prefix,
					magic_wand_creator.get_selected_resource_prototype,
					creative_mode_defines.names.gui.magic_wand_creator_resources_table,
					creative_mode_defines.names.gui.magic_wand_creator_resource_name_button_prefix,
					magic_wand_creator.get_resource_amount,
					creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_container,
					creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_label,
					creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_spacing_1,
					creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_button_prefix,
					creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_spacing_2,
					creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_textfield)
				
				-- Get the index of used pattern.
				local pattern_index = magic_wand_creator.get_use_pattern(player)
				-- Create use pattern container.
				local use_pattern_container = container.add
				{
					type = "flow",
					name = creative_mode_defines.names.gui_styles.magic_wand_creator_use_pattern_container,
					direction = "horizontal"
				}
				-- Create use pattern lable.
				use_pattern_container.add
				{
					type = "label",
					name = creative_mode_defines.names.gui_styles.magic_wand_creator_use_pattern_label,
					style = creative_mode_defines.names.gui_styles.magic_wand_drop_down_label,
					caption = {"gui.creative-mode_use-pattern"},
					tooltip = {"gui.creative-mode_use-pattern-tooltip"},
				}
				-- Create use pattern drop-down.
				use_pattern_container.add
				{
					type = "drop-down",
					name = creative_mode_defines.names.gui.magic_wand_creator_use_pattern_drop_down,
					style = creative_mode_defines.names.gui_styles.magic_wand_drop_down,
					items =
					{
						{"gui.creative-mode_no-pattern"},
						{"gui.creative-mode_horizontal-stripe-pattern"},
						{"gui.creative-mode_vertical-stripe-pattern"},
						{"gui.creative-mode_checker-pattern"},
						{"gui.creative-mode_random-pattern"}
					},
					selected_index = pattern_index
				}
				
				-- Second tile or resource selection.
				-- Container.
				local tile_or_resource_2_container = container.add{type = "flow", name = creative_mode_defines.names.gui.magic_wand_creator_tile_or_resource_2_container, direction = "vertical"}
				-- UI.
				create_tile_or_resource_selection_for_creator(
					player,
					tile_or_resource_2_container,
					magic_wand_creator.get_selected_tile_prototype_2,
					creative_mode_defines.names.gui.magic_wand_creator_tiles_table_2,
					creative_mode_defines.names.gui.magic_wand_creator_tile_name_button_2_prefix,
					magic_wand_creator.get_selected_resource_prototype_2,
					creative_mode_defines.names.gui.magic_wand_creator_resources_table_2,
					creative_mode_defines.names.gui.magic_wand_creator_resource_name_button_2_prefix,
					magic_wand_creator.get_resource_amount_2,
					creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_container_2,
					creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_label_2,
					creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_spacing_1_2,
					creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_button_2_prefix,
					creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_spacing_2_2,
					creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_textfield_2)
				-- Set visibilitiy.
				--tile_or_resource_2_container.style.visible = selected_index > 1
				-- Known issue: making it invisible will bug the scroll-pane.
			end,
			----
			create_alt_select_mode_gui_function = function(player, container)
				-- Get whether the also-remove-decoratives option is turned on.
				local also_remove_decoratives = magic_wand_creator.get_also_remove_decoratives(player)
				-- Checkbox.
				container.add{type = "checkbox", name = creative_mode_defines.names.gui.magic_wand_creator_also_remove_decoratives_checkbox, style = creative_mode_defines.names.gui_styles.magic_wand_checkbox, caption = {"gui.creative-mode_also-remove-decoratives"}, state = also_remove_decoratives}
				
				-- Get whether the don't-remove-player-characters option is turned on.
				local dont_remove_player_characters = magic_wand_creator.get_dont_remove_player_characters(player)
				-- Checkbox.
				container.add{type = "checkbox", name = creative_mode_defines.names.gui.magic_wand_creator_dont_remove_characters_checkbox, style = creative_mode_defines.names.gui_styles.magic_wand_checkbox, caption = {"gui.creative-mode_dont-remove-player-characters"}, tooltip = {"gui.creative-mode_dont-remove-player-characters-tooltip"}, state = dont_remove_player_characters}
				
				-- Get whether tile removal should not be performed if any entity is selected.
				local dont_remove_tiles_if_any_entity_is_selected = magic_wand_creator.get_dont_remove_tiles_if_any_entity_is_selected(player)
				-- Checkbox.
				container.add{type = "checkbox", name = creative_mode_defines.names.gui.magic_wand_creator_dont_remove_tiles_with_entities_checkbox, style = creative_mode_defines.names.gui_styles.magic_wand_checkbox, caption = {"gui.creative-mode_dont-remove-tiles-if-any-entity-is-selected"}, tooltip = {"gui.creative-mode_dont-remove-tiles-if-any-entity-is-selected-tooltip"}, state = dont_remove_tiles_if_any_entity_is_selected}
				
				-- Get whether the don't-kill-players-by-removing-tiles option is turned on.
				local dont_kill_players_by_removing_tiles = magic_wand_creator.get_dont_kill_players_by_removing_tiles(player)
				-- Checkbox.
				container.add{type = "checkbox", name = creative_mode_defines.names.gui.magic_wand_creator_dont_kill_by_removing_tiles_checkbox, style = creative_mode_defines.names.gui_styles.magic_wand_checkbox, caption = {"gui.creative-mode_dont-kill-players-by-removing-tiles"}, tooltip = {"gui.creative-mode_dont-kill-players-by-removing-tiles-tooltip"}, state = dont_kill_players_by_removing_tiles}
				
				-- Label.
				local label = container.add{type = "label", name = creative_mode_defines.names.gui.magic_wand_creator_alt_forces_label, style = creative_mode_defines.names.gui_styles.magic_wand_label, caption = {"gui.creative-mode_select-teams-of-entities-to-remove"}}
				label.style.top_padding = 8
				-- Force table.
				create_forces_table(
					player,
					container,
					creative_mode_defines.names.gui.magic_wand_creator_alt_forces_table,
					creative_mode_defines.names.gui.magic_wand_creator_alt_force_name_checkbox_prefix,
					magic_wand_creator.get_alt_mode_apply_on_force,
					creative_mode_defines.names.gui.magic_wand_creator_alt_forces_select_all_button)
			end
		}
	},
	healer =
	{
		access_right_code = rights.use_healer_magic_wand_code,
		get_player_can_access_function = rights.can_player_use_healer_magic_wand,
		button_name = creative_mode_defines.names.gui.magic_wand_healer_menu_button,
		button_caption = {"gui.creative-mode_magic-wand-short-healer"},
		contents =
		{
			frame_name = creative_mode_defines.names.gui.magic_wand_healer_frame,
			title_container_name = creative_mode_defines.names.gui.magic_wand_healer_frame_title_container,
			title_name = creative_mode_defines.names.gui.magic_wand_healer_frame_title,
			get_item_button_name = creative_mode_defines.names.gui.magic_wand_healer_get_item_button,
			item_name = creative_mode_defines.names.items.magic_wand_healer,
			scroll_pane_name = creative_mode_defines.names.gui.magic_wand_healer_scroll_pane,
			container_name = creative_mode_defines.names.gui.magic_wand_healer_container,
			select_mode_container_name = creative_mode_defines.names.gui.magic_wand_healer_select_mode_container,
			alt_select_mode_container_name = creative_mode_defines.names.gui.magic_wand_healer_alt_select_mode_container,
			select_mode_label_name = creative_mode_defines.names.gui.magic_wand_healer_select_mode_label,
			select_mode_label_caption = {"gui.creative-mode_revive-ghosts-and-heal-entities"},
			alt_select_mode_label_name = creative_mode_defines.names.gui.magic_wand_healer_alt_select_mode_label,
			alt_select_mode_label_caption = {"gui.creative-mode_lower-hp-or-kill-entities"},
			----
			create_select_mode_gui_function = function(player, container)
				-- Gets whether ghost entities can be revived.
				local revive_ghosts = magic_wand_healer.get_revive_ghosts(player)
				-- Revive ghosts checkbox.
				container.add{type = "checkbox", name = creative_mode_defines.names.gui.magic_wand_healer_revive_ghosts_checkbox, style = creative_mode_defines.names.gui_styles.magic_wand_checkbox, caption = {"gui.creative-mode_revive-ghosts"}, tooltip = {"gui.creative-mode_revive-ghosts-tooltip"}, state = revive_ghosts}
				
				-- Label.
				local label = container.add{type = "label", name = creative_mode_defines.names.gui.magic_wand_healer_heal_forces_label, style = creative_mode_defines.names.gui_styles.magic_wand_label, caption = {"gui.creative-mode_select-teams-of-entities-to-heal"}}
				label.style.top_padding = 8
				-- Force table.
				create_forces_table(
					player,
					container,
					creative_mode_defines.names.gui.magic_wand_healer_heal_forces_table,
					creative_mode_defines.names.gui.magic_wand_healer_heal_force_name_checkbox_prefix,
					magic_wand_healer.get_heal_entities_on_force,
					creative_mode_defines.names.gui.magic_wand_healer_heal_forces_select_all_button)
			end,
			----
			create_alt_select_mode_gui_function = function(player, container)
				-- Gets the alt-mode action.
				local alt_mode_action = magic_wand_healer.get_alt_mode_action(player)
				-- Alt-mode actions container.
				local alt_mode_actions_container = container.add{type = "flow", name = creative_mode_defines.names.gui.magic_wand_healer_alt_actions_container, direction = "vertical"}
				-- Set-HP radiobutton.
				alt_mode_actions_container.add{type = "radiobutton", name = creative_mode_defines.names.gui.magic_wand_healer_alt_set_hp_radiobutton, style = creative_mode_defines.names.gui_styles.magic_wand_radiobutton, caption = {"gui.creative-mode_lower-hp"}, tooltip = {"gui.creative-mode_lower-hp-tooltip"}, state = alt_mode_action == magic_wand_healer.alt_mode_action.set_hp_to_one}
				-- Kill radiobutton.
				alt_mode_actions_container.add{type = "radiobutton", name = creative_mode_defines.names.gui.magic_wand_healer_alt_kill_radiobutton, style = creative_mode_defines.names.gui_styles.magic_wand_radiobutton, caption = {"gui.creative-mode_kill"}, state = alt_mode_action == magic_wand_healer.alt_mode_action.kill}
				
				-- Get don't-affect-player-characters.
				local alt_mode_dont_affect_player_characters = magic_wand_healer.get_alt_mode_dont_affect_player_characters(player)
				-- Checkbox.
				local alt_mode_dont_affect_player_characters_checkbox = container.add{type = "checkbox", name = creative_mode_defines.names.gui.magic_wand_healer_alt_dont_affect_characters_checkbox, style = creative_mode_defines.names.gui_styles.magic_wand_checkbox, caption = {"gui.creative-mode_dont-affect-player-characters"}, tooltip = {"gui.creative-mode_dont-affect-player-characters-tooltip"}, state = alt_mode_dont_affect_player_characters}
				alt_mode_dont_affect_player_characters_checkbox.style.top_padding = 8
				
				-- Get don't-affect-indestructible-entities.
				local alt_mode_dont_affect_indestructible_entities = magic_wand_healer.get_alt_mode_dont_affect_indestructible_entities(player)
				-- Checkbox.
				container.add{type = "checkbox", name = creative_mode_defines.names.gui.magic_wand_healer_alt_dont_affect_indestructible_checkbox, style = creative_mode_defines.names.gui_styles.magic_wand_checkbox, caption = {"gui.creative-mode_dont-affect-indestructible-entities"}, tooltip = {"gui.creative-mode_dont-affect-indestructible-entities-tooltip"}, state = alt_mode_dont_affect_indestructible_entities}
				
				-- Label.
				local label = container.add{type = "label", name = creative_mode_defines.names.gui.magic_wand_healer_alt_forces_label, style = creative_mode_defines.names.gui_styles.magic_wand_label, caption = {"gui.creative-mode_select-teams-of-entities-to-be-affected"}}
				label.style.top_padding = 8
				-- Force table.
				create_forces_table(
					player,
					container,
					creative_mode_defines.names.gui.magic_wand_healer_alt_forces_table,
					creative_mode_defines.names.gui.magic_wand_healer_alt_force_name_checkbox_prefix,
					magic_wand_healer.get_alt_mode_apply_on_force,
					creative_mode_defines.names.gui.magic_wand_healer_alt_forces_select_all_button)
			end
		}
	},
	modifier =
	{
		access_right_code = rights.use_modifier_magic_wand_code,
		get_player_can_access_function = rights.can_player_use_modifier_magic_wand,
		button_name = creative_mode_defines.names.gui.magic_wand_modifier_menu_button,
		button_caption = {"gui.creative-mode_magic-wand-short-modifier"},
		contents =
		{
			frame_name = creative_mode_defines.names.gui.magic_wand_modifier_frame,
			title_container_name = creative_mode_defines.names.gui.magic_wand_modifier_frame_title_container,
			title_name = creative_mode_defines.names.gui.magic_wand_modifier_frame_title,
			get_item_button_name = creative_mode_defines.names.gui.magic_wand_modifier_get_item_button,
			item_name = creative_mode_defines.names.items.magic_wand_modifier,
			scroll_pane_name = creative_mode_defines.names.gui.magic_wand_modifier_scroll_pane,
			container_name = creative_mode_defines.names.gui.magic_wand_modifier_container,
			select_mode_container_name = creative_mode_defines.names.gui.magic_wand_modifier_select_mode_container,
			alt_select_mode_container_name = creative_mode_defines.names.gui.magic_wand_modifier_alt_select_mode_container,
			select_mode_label_name = creative_mode_defines.names.gui.magic_wand_modifier_select_mode_label,
			select_mode_label_caption = {"gui.creative-mode_select-and-modify"},
			alt_select_mode_label_name = creative_mode_defines.names.gui.magic_wand_modifier_alt_select_mode_label,
			alt_select_mode_label_caption = {"gui.creative-mode_select-and-modify-alt"},
			----
			create_select_mode_gui_function = function(player, container)
				create_common_elements_for_modifier(
					player,
					container,
					magic_wand_modifier.get_std_ignore_player_characters,
					creative_mode_defines.names.gui.magic_wand_modifier_std_ignore_characters_checkbox,
					magic_wand_modifier.get_std_ignore_healthess_entities,
					creative_mode_defines.names.gui.magic_wand_modifier_std_ignore_healthless_checkbox,
					magic_wand_modifier.get_std_ignore_indestructible_entities,
					creative_mode_defines.names.gui.magic_wand_modifier_std_ignore_indestructible_checkbox,
					creative_mode_defines.names.gui.magic_wand_modifier_std_forces_label,
					creative_mode_defines.names.gui.magic_wand_modifier_std_forces_table,
					creative_mode_defines.names.gui.magic_wand_modifier_std_force_name_checkbox_prefix,
					magic_wand_modifier.get_std_select_entities_on_force,
					creative_mode_defines.names.gui.magic_wand_modifier_std_forces_select_all_button)
			end,
			----
			create_alt_select_mode_gui_function = function(player, container)
				create_common_elements_for_modifier(
					player,
					container,
					magic_wand_modifier.get_alt_ignore_player_characters,
					creative_mode_defines.names.gui.magic_wand_modifier_alt_ignore_characters_checkbox,
					magic_wand_modifier.get_alt_ignore_healthess_entities,
					creative_mode_defines.names.gui.magic_wand_modifier_alt_ignore_healthless_checkbox,
					magic_wand_modifier.get_alt_ignore_indestructible_entities,
					creative_mode_defines.names.gui.magic_wand_modifier_alt_ignore_indestructible_checkbox,
					creative_mode_defines.names.gui.magic_wand_modifier_alt_forces_label,
					creative_mode_defines.names.gui.magic_wand_modifier_alt_forces_table,
					creative_mode_defines.names.gui.magic_wand_modifier_alt_force_name_checkbox_prefix,
					magic_wand_modifier.get_alt_select_entities_on_force,
					creative_mode_defines.names.gui.magic_wand_modifier_alt_forces_select_all_button)
					
				-- Actions label.
				local actions_label = container.add{type = "label", name = creative_mode_defines.names.gui.magic_wand_modifier_quick_actions_label, style = creative_mode_defines.names.gui_styles.magic_wand_label, caption = {"gui.creative-mode_quick-action-actions"}}
				actions_label.style.top_padding = 8
				-- Actions container.
				local actions_container = container.add{type = "table", name = creative_mode_defines.names.gui.magic_wand_modifier_quick_actions_container, column_count = 1}
				-- Refresh actions.
				refresh_elements_for_recorded_actions_of_modifier(player, actions_container, container)
			end
		}
	}
}

----

-- Creates the magic wands menu for the given player. If the meun already exists, it will be destroyed instead.
function gui_menu_magicwand.create_or_destroy_menu_for_player(player, allow_destroy)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		-- Magic wands container.
		local magic_wand_menus_container = container[gui_menu_magicwand.get_container_name()]
		if magic_wand_menus_container then
			if allow_destroy == nil or allow_destroy then
				magic_wand_menus_container.destroy()
			end
		else
			magic_wand_menus_container = container.add{type = "flow", name = gui_menu_magicwand.get_container_name(), style = creative_mode_defines.names.gui_styles.no_horizontal_spacing_flow, direction = "horizontal"}
			
			-- Magic wands frame.
			local magic_wand_frame = magic_wand_menus_container.add{type = "frame", name = creative_mode_defines.names.gui.magic_wand_frame, direction = "vertical", caption = {"gui.creative-mode_magic-wand"}}
			
			-- Buttons for each magic wand.
			for _, data in pairs(gui_menu_magicwand.magic_wand_menus_gui_data) do
				local button = magic_wand_frame.add
				{
					type = "button",
					name = data.button_name,
					style = creative_mode_defines.names.gui_styles.main_menu_button,
					caption = data.button_caption
				}
				button.style.visible = data.get_player_can_access_function(player)
			end
		end
	end
end

--------------------------------------------------------------------

-- Creates the magic wand menu of the given GUI data for the given player. If it already exists, nothing will be done.
-- Returns whether such menu has not been opened and is opened now.
local function create_magic_wand_menu_for_player(player, magic_wand_menu_gui_data)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		local magic_wand_menus_container = container[gui_menu_magicwand.get_container_name()]
		if magic_wand_menus_container then
			local contents_data = magic_wand_menu_gui_data.contents
			-- Frame.
			local frame = magic_wand_menus_container[contents_data.frame_name]
			if not frame then
				frame = magic_wand_menus_container.add{type = "frame", name = contents_data.frame_name, direction = "vertical"}
				
				-- Frame title container.
				local title_container = frame.add{type = "flow", name = contents_data.title_container_name, direction = "horizontal"}
				-- Frame title.
				title_container.add{type = "label", name = contents_data.title_name, style = creative_mode_defines.names.gui_styles.magic_wand_frame_caption_label, caption = magic_wand_menu_gui_data.button_caption}
				-- Get item button.
				title_container.add{type = "sprite-button", name = contents_data.get_item_button_name, sprite = "item/" .. contents_data.item_name, style = creative_mode_defines.names.gui_styles.tile_slot_deselected, tooltip = {"gui.creative-mode_click-this-to-get-the-magic-wand"}}
				
				-- Scroll-pane.
				local scroll_pane = frame.add{type = "scroll-pane", name = contents_data.scroll_pane_name, style = creative_mode_defines.names.gui_styles.magic_wand_scroll_pane, horizontal_scroll_policy = "never"}
				
				-- Container.
				local flow = scroll_pane.add{type = "flow", name = contents_data.container_name, style = creative_mode_defines.names.gui_styles.resize_col_flow, direction = "horizontal"}
				
				-- Select mode container.
				local select_mode_container = flow.add{type = "frame", name = contents_data.select_mode_container_name, style = creative_mode_defines.names.gui_styles.magic_wand_select_mode_frame, caption = {"gui.creative-mode_standard-mode"}, direction = "vertical"}
				-- Label.
				select_mode_container.add{type = "label", name = contents_data.select_mode_label_name, style = creative_mode_defines.names.gui_styles.magic_wand_label, caption = contents_data.select_mode_label_caption}
				-- Contents.
				contents_data.create_select_mode_gui_function(player, select_mode_container)
				
				-- Alt select mode container.
				local alt_select_mode_container = flow.add{type = "frame", name = contents_data.alt_select_mode_container_name, style = creative_mode_defines.names.gui_styles.magic_wand_alt_select_mode_frame, caption = {"gui.creative-mode_alternate-mode"}, direction = "vertical"}
				-- Label.
				alt_select_mode_container.add{type = "label", name = contents_data.alt_select_mode_label_name, style = creative_mode_defines.names.gui_styles.magic_wand_label, caption = contents_data.alt_select_mode_label_caption}
				-- Contents.
				contents_data.create_alt_select_mode_gui_function(player, alt_select_mode_container)
				
				return true
			end
		end
	end
	return false
end

-- Creates the magic wand menu of the given GUI data for the given player. If it is already opened, it will be destroyed instead.
local function create_or_destroy_magic_wand_menu_for_player(player, magic_wand_menu_gui_data, destroy_only)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		local magic_wand_menus_container = container[gui_menu_magicwand.get_container_name()]
		if magic_wand_menus_container then
			local contents_data = magic_wand_menu_gui_data.contents
			-- Frame.
			local frame = magic_wand_menus_container[contents_data.frame_name]
			if frame then
				frame.destroy()
			elseif not destroy_only then
				create_magic_wand_menu_for_player(player, magic_wand_menu_gui_data)
			end
		end
	end
end

-- Opens the magic wand menu of the given GUI data for the given player and closes other menus.
-- Returns whether the such menu has not been opened and is opened now.
function gui_menu_magicwand.open_magic_wand_menu_for_player_and_close_others(player, magic_wand_menu_gui_data)
	-- Close the other magic wand menus if they are already opened.
	for _, data in pairs(gui_menu_magicwand.magic_wand_menus_gui_data) do
		if data ~= magic_wand_menu_gui_data then
			create_or_destroy_magic_wand_menu_for_player(player, data, true)
		end
	end
	-- Open the given magic wand menu.
	return create_magic_wand_menu_for_player(player, magic_wand_menu_gui_data)
end

--------------------------------------------------------------------

-- Returns the string for showing each item in the given array, under the given maximum number of visible items.
local function get_string_for_info_array(info_array, max_count)
	if info_array == nil or #info_array <= 0 then
		return "---"
	end
	local result = tostring(info_array[1])
	for i = 2, math.min(max_count, #info_array), 1 do
		result = result .. ", " .. tostring(info_array[i])
	end
	if #info_array > max_count then
		result = result .. ", ..."
	end
	return result
end

-- Creates or destroys the modification popup for the given player according to the selected entities.
function gui_menu_magicwand.create_or_destroy_modification_popup_for_player(player, is_create)
	local player_gui = player.gui
	local center = player_gui.center
	-- Container.
	local container = center[creative_mode_defines.names.gui.magic_wand_modifier_popup_container]
	if container then
		-- Already exists. Destroy it.
		container.destroy()
	end
	
	if is_create then
		container = center.add{type = "flow", name = creative_mode_defines.names.gui.magic_wand_modifier_popup_container, style = creative_mode_defines.names.gui_styles.no_horizontal_spacing_resize_col_flow, direction = "horizontal"}
		
		-- Entities frame.
		local entities_frame = container.add{type = "frame", name = creative_mode_defines.names.gui.magic_wand_modifier_popup_entities_frame, direction = "vertical"}
		-- Title container.
		local entities_frame_title_container = entities_frame.add{type = "flow", name = creative_mode_defines.names.gui.magic_wand_modifier_popup_entities_frame_title_container, direction = "horizontal"}
		-- Title label.
		entities_frame_title_container.add{type = "label", name = creative_mode_defines.names.gui.magic_wand_modifier_popup_entities_frame_title_label, style = creative_mode_defines.names.gui_styles.magic_wand_popup_left_frame_caption_label, caption = {"gui.creative-mode_magic-wand-short-modifier"}}
		-- Refresh button.
		entities_frame_title_container.add{type = "sprite-button", name = creative_mode_defines.names.gui.magic_wand_modifier_popup_entities_frame_refresh_button, style = creative_mode_defines.names.gui_styles.frame_caption_button, sprite = creative_mode_defines.names.sprites.reset, tooltip = {"gui.creative-mode_refresh"}}
		
		-- Entities scroll-pane.
		local entities_scroll_pane = entities_frame.add{type = "scroll-pane", name = creative_mode_defines.names.gui.magic_wand_modifier_popup_entities_sroll_pane, style = creative_mode_defines.names.gui_styles.magic_wand_popup_slot_scroll_pane}
		-- Entities table.
		local entities_table = entities_scroll_pane.add{type = "table", name = creative_mode_defines.names.gui.magic_wand_modifier_popup_entities_table, style = creative_mode_defines.names.gui_styles.magic_wand_popup_slot_table, column_count = 10}
		-- Group entities by their names. At the same time, remove invalid entities.
		local sorted_entities = {}
		local i = 1
		local i_max = #global.creative_mode.modifier_magic_wand_selection[player.index]
		while i <= i_max do
			local entity = global.creative_mode.modifier_magic_wand_selection[player.index][i]
			if entity.valid then
				local final_entity_name
				local stack = nil
				local item_name = nil
				local ghosted_entity_name = nil
				local ghosted_tile_name = nil
				local unit_number = entity.unit_number
				if entity.name == "item-on-ground" then
					-- If it is item-on-ground, further divide it accounding to its stack.
					stack = entity.stack
					final_entity_name = "item-on-ground_" .. stack.name
					item_name = stack.name					
				elseif entity.name == "entity-ghost" then
					-- Entity ghost.
					final_entity_name = "entity-ghost_" .. entity.ghost_name
					ghosted_entity_name = entity.ghost_name
				elseif entity.name == "tile-ghost" then
					-- Tile ghost.
					final_entity_name = "tile-ghost_" .. entity.ghost_name
					ghosted_tile_name = entity.ghost_name
				else
					-- Just a common entity.
					final_entity_name = entity.name
				end
				if not sorted_entities[final_entity_name] then
					sorted_entities[final_entity_name] = {}
					sorted_entities[final_entity_name].item_name = item_name
					sorted_entities[final_entity_name].ghosted_entity_name = ghosted_entity_name
					sorted_entities[final_entity_name].ghosted_tile_name = ghosted_tile_name
					sorted_entities[final_entity_name].entities = {}
					if item_name then
						sorted_entities[final_entity_name].stack_counts = {}
					end
					if unit_number then
						sorted_entities[final_entity_name].unit_numbers = {}
					end
				end
				
				table.insert(sorted_entities[final_entity_name].entities, entity)
				if item_name then
					-- We show 10, but insert 11, so we can determine whether we should show "...".
					if #sorted_entities[final_entity_name].stack_counts < 11 then
						table.insert(sorted_entities[final_entity_name].stack_counts, stack.count)
					end
				end
				if unit_number then
					if #sorted_entities[final_entity_name].unit_numbers < 11 then
						table.insert(sorted_entities[final_entity_name].unit_numbers, unit_number)
					end
				end
				i = i + 1
			else
				table.remove(global.creative_mode.modifier_magic_wand_selection[player.index], i)
				i_max = i_max - 1
			end
		end
		-- Add entity buttons by entity names.
		for entity_name, data in pairs(sorted_entities) do
			local item_name = data.item_name
			local ghosted_entity_name = data.ghosted_entity_name
			local ghosted_tile_name = data.ghosted_tile_name
			local entities = data.entities		
			local count = #entities
			if count > 0 then
				-- Sprite button.
				local button_name
				local button_sprite
				local button_style
				local button_tooltip
				local label_name
				if item_name then
					-- item-on-ground
					local item_prototype = game.item_prototypes[item_name]
					local stack_counts = data.stack_counts
					button_name = creative_mode_defines.names.gui.magic_wand_modifier_popup_item_on_ground_name_slot_prefix .. item_name
					button_sprite = "item/" .. item_name
					button_style = creative_mode_defines.names.gui_styles.magic_wand_popup_item_on_ground_slot_button
					button_tooltip =
					{
						"gui.creative-mode_item-on-ground-slot-tooltip",
						item_prototype.localised_name,
						{"gui.creative-mode_item-type", item_prototype.type},
						{"gui.creative-mode_item-name", item_name},
						{"gui.creative-mode_stack-count", get_string_for_info_array(stack_counts, 10)}
					}
					label_name = creative_mode_defines.names.gui.magic_wand_modifier_popup_item_on_ground_count_label_prefix .. item_name
				elseif ghosted_entity_name then
					-- entity-ghost
					local entity_prototype = game.entity_prototypes[ghosted_entity_name]
					local unit_numbers = data.unit_numbers
					button_name = creative_mode_defines.names.gui.magic_wand_modifier_popup_ghost_entity_name_slot_prefix .. ghosted_entity_name
					button_sprite = "entity/" .. ghosted_entity_name
					button_style = creative_mode_defines.names.gui_styles.magic_wand_popup_ghost_slot_button
					button_tooltip =
					{
						"gui.creative-mode_ghost-entity-slot-tooltip",
						entity_prototype.localised_name,
						{"gui.creative-mode_entity-type", entity_prototype.type},
						{"gui.creative-mode_entity-name", ghosted_entity_name},
						{"gui.creative-mode_unit-number", get_string_for_info_array(unit_numbers, 10)}
					}
					label_name = creative_mode_defines.names.gui.magic_wand_modifier_popup_ghost_entity_count_label_prefix .. ghosted_entity_name
				elseif ghosted_tile_name then
					-- tile-ghost
					local tile_prototype = game.tile_prototypes[ghosted_tile_name]
					local unit_numbers = data.unit_numbers
					button_name = creative_mode_defines.names.gui.magic_wand_modifier_popup_ghost_tile_name_slot_prefix .. ghosted_tile_name
					button_sprite = "tile/" .. ghosted_tile_name
					button_style = creative_mode_defines.names.gui_styles.magic_wand_popup_ghost_slot_button
					button_tooltip =
					{
						"gui.creative-mode_ghost-tile-slot-tooltip",
						tile_prototype.localised_name,
						{"gui.creative-mode_tile-name", ghosted_tile_name},
						{"gui.creative-mode_unit-number", get_string_for_info_array(unit_numbers, 10)}
					}
					label_name = creative_mode_defines.names.gui.magic_wand_modifier_popup_ghost_tile_count_label_prefix .. ghosted_tile_name
				else
					-- common entity
					local entity_prototype = game.entity_prototypes[entity_name]
					local unit_numbers = data.unit_numbers
					button_name = creative_mode_defines.names.gui.magic_wand_modifier_popup_entity_name_slot_prefix .. entity_name
					button_sprite = "entity/" .. entity_name
					button_style = creative_mode_defines.names.gui_styles.creative_chest_filter_slot_on
					button_tooltip =
					{
						"gui.creative-mode_entity-slot-tooltip",
						entity_prototype.localised_name,
						{"gui.creative-mode_entity-type", entity_prototype.type},
						{"gui.creative-mode_entity-name", entity_name},
						{"gui.creative-mode_unit-number", get_string_for_info_array(unit_numbers, 10)}
					}
					label_name = creative_mode_defines.names.gui.magic_wand_modifier_popup_entity_count_label_prefix .. entity_name
				end
				if not player_gui.is_valid_sprite_path(button_sprite) then
					button_sprite = nil
				end
				entities_table.add
				{
					type = "sprite-button",
					name = button_name,
					sprite = button_sprite,
					style = button_style,
					tooltip = button_tooltip
				}
				-- Format count string. Give it a suffix if necessary.
				local count_str
				if count >= 1000000000 then
					-- G
					count_str = tostring(util.round(count / 1000000000 * 10) * 0.1) .. "G"
				elseif count >= 1000000 then
					-- M
					count_str = tostring(util.round(count / 1000000 * 10) * 0.1) .. "M"
				elseif count >= 1000 then
					-- k
					count_str = tostring(util.round(count / 1000 * 10) * 0.1) .. "k"
				else
					count_str = tostring(count)
				end
				count_str = "x" .. count_str
				-- Count label.
				entities_table.add
				{
					type = "label",
					name = label_name,
					style = creative_mode_defines.names.gui_styles.slot_button_label,
					caption = count_str,
				}
			end
		end
		
		-- Actions frame.
		local actions_frame = container.add{type = "frame", name = creative_mode_defines.names.gui.magic_wand_modifier_popup_actions_frame, direction = "vertical"}
		-- Title container.
		local actions_frame_title_container = actions_frame.add{type = "flow", name = creative_mode_defines.names.gui.magic_wand_modifier_popup_actions_frame_title_container, direction = "horizontal"}
		-- Title label.
		actions_frame_title_container.add{type = "label", name = creative_mode_defines.names.gui.magic_wand_modifier_popup_actions_frame_title_label, style = creative_mode_defines.names.gui_styles.magic_wand_popup_right_frame_caption_label, caption = {"gui.creative-mode_actions"}}
		-- Close button.
		actions_frame_title_container.add{type = "sprite-button", name = creative_mode_defines.names.gui.magic_wand_modifier_popup_actions_frame_close_button, style = creative_mode_defines.names.gui_styles.frame_caption_button, sprite = creative_mode_defines.names.sprites.cancel, tooltip = {"gui.creative-mode_close"}}
		-- Actions (cheats).
		local targets = gui_menu_magicwand.modification_popup_cheats_gui_data.get_all_selected_targets_function(player)
		for _, data in pairs(gui_menu_magicwand.modification_popup_cheats_gui_data.cheats_gui_data) do
			gui_menu_cheats.create_cheat_elements_from_data_for_player(player, actions_frame, data, targets, false)
		end
	end
end

-- Updates the status of the options on modification popup for the given player according to his selected entities.
local function update_modification_popup_status_for_player(player)
	local actions_frame = gui_menu_magicwand.modification_popup_cheats_gui_data.get_cheats_container_function(player)
	if actions_frame then
		local targets = gui_menu_magicwand.modification_popup_cheats_gui_data.get_all_selected_targets_function(player)
		for _, data in pairs(gui_menu_magicwand.modification_popup_cheats_gui_data.cheats_gui_data) do
			gui_menu_cheats.update_cheat_status_from_data(actions_frame, data, targets)
		end
	end
end

--------------------------------------------------------------------

-- Updates the magic wand menu accessibility according to the newest access right for the given player after the access rights of the given codes have changed.
function gui_menu_magicwand.update_menu_accessibility_according_to_access_right_for_player(player, updated_access_right_codes)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		-- Magic wands container.
		local magic_wand_menus_container = container[gui_menu_magicwand.get_container_name()]
		if magic_wand_menus_container then
			-- Iterate all submenus.
			for _, data in pairs(gui_menu_magicwand.magic_wand_menus_gui_data) do
				if updated_access_right_codes[data.access_right_code] then
					-- Check player access right.
					if data.get_player_can_access_function(player) then
						-- Player can access.
						-- Make sure the button is available for the player.
						local magic_wand_frame = magic_wand_menus_container[creative_mode_defines.names.gui.magic_wand_frame]
						local button = magic_wand_frame[data.button_name]
						button.style.visible = true
					else
						-- Player cannot access.
						-- Hide the menu button.
						local magic_wand_frame = magic_wand_menus_container[creative_mode_defines.names.gui.magic_wand_frame]
						local button = magic_wand_frame[data.button_name]
						button.style.visible = false
						
						-- Remove the menu.
						create_or_destroy_magic_wand_menu_for_player(player, data, true)
					end
				end
			end
		end
	end
end

--------------------------------------------------------------------

-- Deselects the currently selected tile or resource slot for the player in the given GUI container.
local function deselect_currently_selected_tile_or_resource_slot_for_player_in_container(player, select_mode_container, tiles_table_name, tile_name_button_prefix, get_selected_tile_function, resources_table_name, resource_name_button_prefix, get_selected_resource_function)
	local selected_tile = get_selected_tile_function(player)
	if selected_tile then
		local tiles_table = select_mode_container[tiles_table_name]
		tiles_table[tile_name_button_prefix .. selected_tile.name].style = creative_mode_defines.names.gui_styles.tile_slot_deselected
		return
	end
	local selected_resource = get_selected_resource_function(player)
	if selected_resource then
		local resources_table = select_mode_container[resources_table_name]
		resources_table[resource_name_button_prefix .. selected_resource.name].style = creative_mode_defines.names.gui_styles.tile_slot_deselected
	end
end

-- Forward the on_gui_click event to the tiles selection table of the given name.
-- Returns whether the event is consumed and should no longer forward to other elements.
local function on_gui_click_in_tiles_table(element, element_name, player, tiles_table_name, set_selected_tile_prototype_function, tile_name_button_prefix, tile_name_button_pattern, get_selected_tile_function, resources_table_name, resource_name_button_prefix, get_selected_resource_function)
	if element.parent and element.parent.name == tiles_table_name then
		-- Creator - tile slot.
		local style = element.style
		if style.name == creative_mode_defines.names.gui_styles.tile_slot_selected then
			-- Alread selected. Just deselect it.
			element.style = creative_mode_defines.names.gui_styles.tile_slot_deselected
			set_selected_tile_prototype_function(player, nil)
		else
			-- Not selected, deselect the currently selected button.
			-- slot -> table -> select-mode container
			local select_mode_container = element.parent.parent
			deselect_currently_selected_tile_or_resource_slot_for_player_in_container(player, select_mode_container, tiles_table_name, tile_name_button_prefix, get_selected_tile_function, resources_table_name, resource_name_button_prefix, get_selected_resource_function)
			local tile_name = string.match(element.name, tile_name_button_pattern)
			if tile_name ~= nil then
				-- Select the tile.
				local tile = game.tile_prototypes[tile_name]
				if tile then
					element.style = creative_mode_defines.names.gui_styles.tile_slot_selected
					set_selected_tile_prototype_function(player, tile)
				end
			end
		end
		return true
	end
end

-- Forward the on_gui_click event to the resources selection table of the given name.
-- Returns whether the event is consumed and should no longer forward to other elements.
local function on_gui_click_in_resources_table(element, element_name, player, resources_table_name, set_selected_resource_prototype_function, resource_name_button_prefix, resource_name_button_pattern, get_selected_resource_function, tiles_table_name, tile_name_button_prefix, get_selected_tile_function)
	if element.parent and element.parent.name == resources_table_name then
		-- Creator - resource slot.
		local style = element.style
		if style.name == creative_mode_defines.names.gui_styles.tile_slot_selected then
			-- Alread selected. Just deselect it.
			element.style = creative_mode_defines.names.gui_styles.tile_slot_deselected
			set_selected_resource_prototype_function(player, nil)
		else
			-- Not selected, deselect the currently selected button.
			-- slot -> table -> select-mode container
			local select_mode_container = element.parent.parent
			deselect_currently_selected_tile_or_resource_slot_for_player_in_container(player, select_mode_container, tiles_table_name, tile_name_button_prefix, get_selected_tile_function, resources_table_name, resource_name_button_prefix, get_selected_resource_function)
			local resource_name = string.match(element.name, resource_name_button_pattern)
			if resource_name ~= nil then
				-- Select the resource.
				local resource = game.entity_prototypes[resource_name]
				if resource then
					element.style = creative_mode_defines.names.gui_styles.tile_slot_selected
					set_selected_resource_prototype_function(player, resource)
				end
			end
		end
		return true
	end
end

-- Updates all resource amount slider buttons as well as the textfield in the given container according to the given value.
local function update_resource_amount_slider_buttons_and_textfield_in_container(resource_amount_container, resource_amount, slider_button_name_prefix, slider_textfield_name)
	for i, value in ipairs(creator_resource_amount_slider_values) do
		local style
		if value <= resource_amount then
			style = creative_mode_defines.names.gui_styles.slider_button_on
		else
			style = creative_mode_defines.names.gui_styles.slider_button_off
		end
		resource_amount_container[slider_button_name_prefix .. i].style = style
	end
	resource_amount_container[slider_textfield_name].text = resource_amount
end

-- Forward the on_gui_click event to the resource amount slider container of the given name.
-- Returns whether the event is consumed and should no longer forward to other elements.
local function on_gui_click_in_resource_amount_slider(element, element_name, player, slider_container_name, slider_button_name_prefix, slider_button_name_pattern, set_resource_amount_function, slider_textfield_name)
	if element.parent and element.parent.name == slider_container_name then
		-- Creator - resource amount slider button.
		if element.type == "button" then
			local button_index = string.match(element_name, slider_button_name_pattern)
			if button_index then
				button_index = tonumber(button_index)
				if button_index and button_index >= 1 and button_index <= #creator_resource_amount_slider_values then
					local resource_amount = creator_resource_amount_slider_values[button_index]
					-- Set amount.
					set_resource_amount_function(player, resource_amount)
					-- Update the slider.
					update_resource_amount_slider_buttons_and_textfield_in_container(element.parent, resource_amount, slider_button_name_prefix, slider_textfield_name)
				end
			end
		end
		return true
	end
end

-- Unchecks all radiobuttons in the given container except the given one.
local function uncheck_other_radiobuttons_in_container(container, exclude_radiobutton)
	for _, child_name in ipairs(container.children_names) do
		local radiobutton = container[child_name]
		if radiobutton ~= exclude_radiobutton then
			radiobutton.state = false
		end
	end
end

----

-- Forward the on_gui_click event to the select all button of given name.
-- Returns whether the event is consumed and should no longer forward to other elements.
-- @param set_force_function	Function(player, force, enable)
local function on_gui_click_in_forces_table_select_all_button(element, element_name, player, select_all_button_name, set_force_function)
	if element.name == select_all_button_name then
		-- button -> table.
		local force_table = element.parent
		-- Select or deselect?
		local select_all = false
		for _, child_name in ipairs(force_table.children_names) do
			local child = force_table[child_name]
			if child.type == "checkbox" and child.state == false then
				select_all = true
				break
			end
		end
		-- Apply.
		for _, child_name in ipairs(force_table.children_names) do
			local child = force_table[child_name]
			if child.type == "checkbox" then
				child.state = select_all
			end
		end
		for _, force in pairs(game.forces) do
			set_force_function(player, force, select_all)
		end
		
		return true
	end
end

-- Checks and possibly removes the clicked entity slot on the modifier popup according to the given rules for finding entities. Also removes corresponding entries in the player selection.
-- Each rule should contain:
--	slot_name_match_pattern: the string pattern for matching the actual target name of the entity (if it is item-on-ground, the target is the stack) from the element name.
--	label_name_prefix: prefix of the label name for that slot
--	check_entity_is_target_function: function for checking if each selected entity matches the actual target. It should accept the entity and the actual target name.
local function check_and_remove_modifier_popup_slot_by_rules(element, element_name, player, rules)
	for _, rule in pairs(rules) do
		local target_name = string.match(element_name, rule.slot_name_match_pattern)
		if target_name then
			-- Remove the entry from the table.
			local label = element.parent[rule.label_name_prefix .. target_name]
			if label then
				label.destroy()
				element.destroy()
				
				-- Also remove from the selection.
				for i = #global.creative_mode.modifier_magic_wand_selection[player.index], 1, -1 do
					local entity = global.creative_mode.modifier_magic_wand_selection[player.index][i]
					if not entity.valid or rule.check_entity_is_target_function(entity, target_name) then
						table.remove(global.creative_mode.modifier_magic_wand_selection[player.index], i)
					end
				end
				
				-- Update options status.
				update_modification_popup_status_for_player(player)
			end
			return true
		end
	end
	
	return false
end

----

-- Callback of the on_gui_click event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_magicwand.on_gui_click(element, element_name, player, button, alt, control, shift)
	for _, data in pairs(gui_menu_magicwand.magic_wand_menus_gui_data) do
		if element_name == data.button_name then
			-- Magic wand menu button.
			-- Close other menus.
			for _, data2 in pairs(gui_menu_magicwand.magic_wand_menus_gui_data) do
				if data ~= data2 then
					create_or_destroy_magic_wand_menu_for_player(player, data2, true)
				end
			end
			-- Open menu.
			create_or_destroy_magic_wand_menu_for_player(player, data, false)
			return true
		end
		
		if element_name == data.contents.get_item_button_name then
			-- Get magic wand item button.
			player.clean_cursor()
			-- If the player already has the item, destroy it.
			local magic_wand_item_stack = {name = data.contents.item_name, count = 1}
			player.remove_item(magic_wand_item_stack)
			-- Give one to his cursor stack.
			player.cursor_stack.set_stack(magic_wand_item_stack)
		end
	end
	
	--------------------------------------------------------------------
	
	if on_gui_click_in_tiles_table(
		element, element_name, player,
		creative_mode_defines.names.gui.magic_wand_creator_tiles_table,
		magic_wand_creator.set_selected_tile_prototype,
		creative_mode_defines.names.gui.magic_wand_creator_tile_name_button_prefix,
		creative_mode_defines.match_patterns.gui.magic_wand_creator_tile_name_button,
		magic_wand_creator.get_selected_tile_prototype,
		creative_mode_defines.names.gui.magic_wand_creator_resources_table,
		creative_mode_defines.names.gui.magic_wand_creator_resource_name_button_prefix,
		magic_wand_creator.get_selected_resource_prototype) then
		-- Creator - tile slot.
		return true
	end
	
	if on_gui_click_in_resources_table(
		element, element_name, player,
		creative_mode_defines.names.gui.magic_wand_creator_resources_table,
		magic_wand_creator.set_selected_resource_prototype,
		creative_mode_defines.names.gui.magic_wand_creator_resource_name_button_prefix,
		creative_mode_defines.match_patterns.gui.magic_wand_creator_resource_name_button,
		magic_wand_creator.get_selected_resource_prototype,
		creative_mode_defines.names.gui.magic_wand_creator_tiles_table,
		creative_mode_defines.names.gui.magic_wand_creator_tile_name_button_prefix,
		magic_wand_creator.get_selected_tile_prototype) then
		-- Creator - resource slot.
		return true
	end
	
	if on_gui_click_in_resource_amount_slider(
		element, element_name, player,
		creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_container,
		creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_button_prefix,
		creative_mode_defines.match_patterns.gui.magic_wand_creator_rsc_amt_slider_button,
		magic_wand_creator.set_resource_amount,
		creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_textfield) then
		-- Creator - resource amount slider button.
		return true
	end
		
	if on_gui_click_in_forces_table_select_all_button(element, element_name, player, creative_mode_defines.names.gui.magic_wand_creator_alt_forces_select_all_button, magic_wand_creator.set_alt_mode_apply_on_force) then
		-- Creator - select all forces button for alt mode.
		return true
	end
	
	if on_gui_click_in_tiles_table(
		element, element_name, player,
		creative_mode_defines.names.gui.magic_wand_creator_tiles_table_2,
		magic_wand_creator.set_selected_tile_prototype_2,
		creative_mode_defines.names.gui.magic_wand_creator_tile_name_button_2_prefix,
		creative_mode_defines.match_patterns.gui.magic_wand_creator_tile_name_button_2,
		magic_wand_creator.get_selected_tile_prototype_2,
		creative_mode_defines.names.gui.magic_wand_creator_resources_table_2,
		creative_mode_defines.names.gui.magic_wand_creator_resource_name_button_2_prefix,
		magic_wand_creator.get_selected_resource_prototype_2) then
		-- Creator - tile slot 2.
		return true
	end
	
	if on_gui_click_in_resources_table(
		element, element_name, player,
		creative_mode_defines.names.gui.magic_wand_creator_resources_table_2,
		magic_wand_creator.set_selected_resource_prototype_2,
		creative_mode_defines.names.gui.magic_wand_creator_resource_name_button_2_prefix,
		creative_mode_defines.match_patterns.gui.magic_wand_creator_resource_name_button_2,
		magic_wand_creator.get_selected_resource_prototype_2,
		creative_mode_defines.names.gui.magic_wand_creator_tiles_table_2,
		creative_mode_defines.names.gui.magic_wand_creator_tile_name_button_2_prefix,
		magic_wand_creator.get_selected_tile_prototype_2) then
		-- Creator - resource slot 2.
		return true
	end
	
	if on_gui_click_in_resource_amount_slider(
		element, element_name, player,
		creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_container_2,
		creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_button_2_prefix,
		creative_mode_defines.match_patterns.gui.magic_wand_creator_rsc_amt_slider_button_2,
		magic_wand_creator.set_resource_amount_2,
		creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_textfield_2) then
		-- Creator - resource amount slider button 2.
		return true
	end	
	
	--------------------------------------------------------------------
	
	if on_gui_click_in_forces_table_select_all_button(element, element_name, player, creative_mode_defines.names.gui.magic_wand_healer_heal_forces_select_all_button, magic_wand_healer.set_heal_entities_on_force) then
		-- Healer - select all forces button for healing.
		return true
	end
	
	if on_gui_click_in_forces_table_select_all_button(element, element_name, player, creative_mode_defines.names.gui.magic_wand_healer_alt_forces_select_all_button, magic_wand_healer.set_alt_mode_apply_on_force) then
		-- Healer - select all forces button for alt mode.
		return true
	end
	
	--------------------------------------------------------------------
	
	if on_gui_click_in_forces_table_select_all_button(element, element_name, player, creative_mode_defines.names.gui.magic_wand_modifier_std_forces_select_all_button, magic_wand_modifier.set_std_select_entities_on_force) then
		-- Modifier - select all forces button for std mode.
		return true
	end
	
	if on_gui_click_in_forces_table_select_all_button(element, element_name, player, creative_mode_defines.names.gui.magic_wand_modifier_alt_forces_select_all_button, magic_wand_modifier.set_alt_select_entities_on_force) then
		-- Modifier - select all forces button for alt mode.
		return true
	end
	
	if element_name == creative_mode_defines.names.gui.magic_wand_modifier_quick_action_remove_button then
		-- Modifier - quick action remove button.
		-- remove button -> action container.
		local action_container = element.parent
		-- action container -> actions container.
		local actions_container = action_container.parent
		-- actions container -> alt select mode container.
		local container = actions_container.parent
		local action_index = string.match(action_container.name, creative_mode_defines.match_patterns.gui.magic_wand_modifier_quick_action_container)
		if action_index then
			action_index = tonumber(action_index)
			-- Remove action.
			table.remove(global.creative_mode.modifier_magic_wand_quick_actions[player.index].actions, action_index)
			-- Refresh GUI.
			refresh_elements_for_recorded_actions_of_modifier(player, actions_container, container)
		end
		return true
	end
	
	if element_name == creative_mode_defines.names.gui.magic_wand_modifier_remove_all_quick_actions_button then
		-- Modifier - remove all quick actions button.
		-- button -> alt select mode container.
		local container = element.parent
		local actions_container = container[creative_mode_defines.names.gui.magic_wand_modifier_quick_actions_container]
		-- Remove all actions.
		global.creative_mode.modifier_magic_wand_quick_actions[player.index].actions = nil
		-- Refresh GUI.
		refresh_elements_for_recorded_actions_of_modifier(player, actions_container, container)
		return true
	end
	
	----
	
	if element.name == creative_mode_defines.names.gui.magic_wand_modifier_popup_entities_frame_refresh_button then
		-- Modifier popup - refresh.
		-- The best way to do is create the popup again.
		gui_menu_magicwand.create_or_destroy_modification_popup_for_player(player, true)
		return true
	end
	
	if element.name == creative_mode_defines.names.gui.magic_wand_modifier_popup_actions_frame_close_button then
		-- Modifier popup - close.
		gui_menu_magicwand.create_or_destroy_modification_popup_for_player(player, false)
		return true
	end
	
	if element.parent and element.parent.name == creative_mode_defines.names.gui.magic_wand_modifier_popup_entities_table then
		if element.type == "sprite-button" then
			-- Modifier popup - entity button.
			check_and_remove_modifier_popup_slot_by_rules(element, element_name, player,
			{
				common_entity_rule =
				{
					slot_name_match_pattern = creative_mode_defines.match_patterns.gui.magic_wand_modifier_popup_entity_name_slot,
					label_name_prefix = creative_mode_defines.names.gui.magic_wand_modifier_popup_entity_count_label_prefix,
					check_entity_is_target_function = function(entity, entity_name) return entity.name == entity_name end
				},
				item_on_ground_entity_rule =
				{
					slot_name_match_pattern = creative_mode_defines.match_patterns.gui.magic_wand_modifier_popup_item_on_ground_name_slot,
					label_name_prefix = creative_mode_defines.names.gui.magic_wand_modifier_popup_item_on_ground_count_label_prefix,
					check_entity_is_target_function = function(entity, stack_name) return entity.name == "item-on-ground" and entity.stack.name == stack_name end
				},
				ghost_entity_rule =
				{
					slot_name_match_pattern = creative_mode_defines.match_patterns.gui.magic_wand_modifier_popup_ghost_entity_name_slot,
					label_name_prefix = creative_mode_defines.names.gui.magic_wand_modifier_popup_ghost_entity_count_label_prefix,
					check_entity_is_target_function = function(entity, ghosted_entity_name) return entity.name == "entity-ghost" and entity.ghost_name == ghosted_entity_name end
				},
				ghost_tile_rule =
				{
					slot_name_match_pattern = creative_mode_defines.match_patterns.gui.magic_wand_modifier_popup_ghost_tile_name_slot,
					label_name_prefix = creative_mode_defines.names.gui.magic_wand_modifier_popup_ghost_tile_count_label_prefix,
					check_entity_is_target_function = function(entity, ghosted_tile_name) return entity.name == "tile-ghost" and entity.ghost_name == ghosted_tile_name end
				},
			})
			return true
		end
	end
	
	-- Check the options in modifier popup.
	local clicked, cheat_gui_data, applied_value = gui_menu_cheats.on_gui_click_in_cheats_menu_toggles(element, element_name, player, gui_menu_magicwand.modification_popup_cheats_gui_data, function(targets, applied_cheat_gui_data, applied_value)
		-- Create smoke on the affected entities, before the modification is applied, because they will become inaccessible if the modification is destroy.
		for _, entity in ipairs(targets) do
			if entity.valid then
				magic_wand_modifier.create_smoke_effect_at_entity_position(entity)
			end
		end
	end)
	if clicked then
		if cheat_gui_data then
			-- We will need to update the actions in the magic wand menu if it is opened.
			local alt_select_mode_container = nil
			local actions_container = nil
			local left = mod_gui.get_frame_flow(player)
			local container = left[creative_mode_defines.names.gui.main_menu_container]
			if container then
				local magic_wand_menus_container = container[gui_menu_magicwand.get_container_name()]
				if magic_wand_menus_container then
					local contents_data = gui_menu_magicwand.magic_wand_menus_gui_data.modifier.contents
					-- Frame.
					local frame = magic_wand_menus_container[contents_data.frame_name]
					if frame then
						-- Scroll-pane.
						local scroll_pane = frame[contents_data.scroll_pane_name]
						-- Container.
						local flow = scroll_pane[contents_data.container_name]
						-- Alt select mode container.
						alt_select_mode_container = flow[contents_data.alt_select_mode_container_name]
						-- Actions container.
						actions_container = alt_select_mode_container[creative_mode_defines.names.gui.magic_wand_modifier_quick_actions_container]
					end
				end
			end
		
			-- A cheat data is activated, record it.
			if global.creative_mode.modifier_magic_wand_quick_actions[player.index].reset_when_new_action_received then
				-- Reset the stored actions.
				global.creative_mode.modifier_magic_wand_quick_actions[player.index].actions = {}
				global.creative_mode.modifier_magic_wand_quick_actions[player.index].reset_when_new_action_received = false
				-- Update GUI.
				if actions_container then
					clear_all_elements_for_recorded_actions_of_modifier(actions_container, alt_select_mode_container)
				end
			end
			
			-- Record action.
			local new_action = {code = cheat_gui_data.action_code, value = applied_value}
			table.insert(global.creative_mode.modifier_magic_wand_quick_actions[player.index].actions, new_action)
			-- Update GUI.
			if actions_container then
				create_elements_for_recorded_action_of_modifier(actions_container, new_action)
				create_remove_all_recorded_actions_button_in_container(alt_select_mode_container)
			end
			
			-- Close the popup if necessary.
			if cheat_gui_data.close_popup_after_applied then
				gui_menu_magicwand.create_or_destroy_modification_popup_for_player(player, false)
			end
		end
		return true
	end
	
	return false
end

-- Forward the on_gui_text_changed event to the textfield of the given name in the resource amount slider.
-- Returns whether the event is consumed and should no longer forward to the other elements.
local function on_gui_text_changed_in_resource_amount_slider_textfield(element, element_name, player, textfield_name, set_resource_amount_function, slider_button_name_prefix)
	if element_name == textfield_name then
		-- Creator - resource amount textfield.
		-- Clamp amount.
		local resource_amount = tonumber(element.text)
		if resource_amount then
			resource_amount = util.clamp(resource_amount, 1, 1000000000)
		else
			resource_amount = 1
		end
		-- Set amount.
		set_resource_amount_function(player, resource_amount)
		-- Update the slider.
		local resource_amount_container = element.parent
		update_resource_amount_slider_buttons_and_textfield_in_container(resource_amount_container, resource_amount, slider_button_name_prefix, textfield_name)
		return true
	end
end

-- Callback of the on_gui_text_changed event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_magicwand.on_gui_text_changed(element, element_name, player)
	if on_gui_text_changed_in_resource_amount_slider_textfield(
		element, element_name, player,
		creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_textfield,
		magic_wand_creator.set_resource_amount,
		creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_button_prefix) then
		-- Creator - resource amount textfield.
		return true
	end
	
	if on_gui_text_changed_in_resource_amount_slider_textfield(
		element, element_name, player,
		creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_textfield_2,
		magic_wand_creator.set_resource_amount_2,
		creative_mode_defines.names.gui.magic_wand_creator_rsc_amt_slider_button_2_prefix) then
		-- Creator - resource amount textfield 2.
		return true
	end
	
	return false		
end

-- Callback of the on_gui_checked_state_changed event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_magicwand.on_gui_checked_state_changed(element, element_name, player)
	if element_name == creative_mode_defines.names.gui.magic_wand_creator_correct_tiles_checkbox then
		-- Creator - tile correction checkbox.
		magic_wand_creator.set_tile_correction(player, element.state)
		return true
	end
	
	if element_name == creative_mode_defines.names.gui.magic_wand_creator_dont_kill_by_tiles_checkbox then
		-- Creator - don't kill players by tiles checkbox.
		magic_wand_creator.set_dont_kill_players_by_tiles(player, element.state)
		return true
	end
	
	----
	
	if element_name == creative_mode_defines.names.gui.magic_wand_creator_also_remove_decoratives_checkbox then
		-- Creator - also remove decoratives checkbox.
		magic_wand_creator.set_also_remove_decoratives(player, element.state)
		return true
	end
	
	if element_name == creative_mode_defines.names.gui.magic_wand_creator_dont_remove_characters_checkbox then
		-- Creator - don't remove player characters checkbox.
		magic_wand_creator.set_dont_remove_player_characters(player, element.state)
		return true
	end
	
	if element.name == creative_mode_defines.names.gui.magic_wand_creator_dont_remove_tiles_with_entities_checkbox then
		-- Creator - don't remove tiles if any entity is selected checkbox.
		magic_wand_creator.set_dont_remove_tiles_if_any_entity_is_selected(player, element.state)
	end
	
	if element.name == creative_mode_defines.names.gui.magic_wand_creator_dont_kill_by_removing_tiles_checkbox then
		-- Creator - don't kill players by removing tiles checkbox.
		magic_wand_creator.set_dont_kill_players_by_removing_tiles(player, element.state)
		return true
	end
	
	if element.parent and element.parent.name == creative_mode_defines.names.gui.magic_wand_creator_alt_forces_table then
		-- Creator - alt force checkboxes.
		local force_name = string.match(element.name, creative_mode_defines.match_patterns.gui.magic_wand_creator_alt_force_name_checkbox)
		if force_name then
			local force = game.forces[force_name]
			if force then
				magic_wand_creator.set_alt_mode_apply_on_force(player, force, element.state)
			else
				-- No such force anymore.
				element.destroy()
			end
		end
		return true
	end
	
	--------------------------------------------------------------------
	
	if element_name == creative_mode_defines.names.gui.magic_wand_healer_revive_ghosts_checkbox then
		-- Healer - revive ghosts checkbox.
		magic_wand_healer.set_revive_ghosts(player, element.state)
		return true
	end
	
	if element.parent and element.parent.name == creative_mode_defines.names.gui.magic_wand_healer_heal_forces_table then
		-- Healer - heal force checkboxes.
		local force_name = string.match(element.name, creative_mode_defines.match_patterns.gui.magic_wand_healer_heal_force_name_checkbox)
		if force_name then
			local force = game.forces[force_name]
			if force then
				magic_wand_healer.set_heal_entities_on_force(player, force, element.state)
			else
				-- No such force anymore.
				element.destroy()
			end
		end
		return true
	end
	
	----
	
	if element_name == creative_mode_defines.names.gui.magic_wand_healer_alt_set_hp_radiobutton then
		-- Healer - set HP to 1 radiobutton
		if element.state then
			-- radiobutton -> container.
			local container = element.parent
			uncheck_other_radiobuttons_in_container(container, element)
			magic_wand_healer.set_alt_mode_action(player, magic_wand_healer.alt_mode_action.set_hp_to_one)
		end
		return true
	end
	
	if element_name == creative_mode_defines.names.gui.magic_wand_healer_alt_kill_radiobutton then
		-- Healer - kill radiobutton
		if element.state then
			-- radiobutton -> container.
			local container = element.parent
			uncheck_other_radiobuttons_in_container(container, element)
			magic_wand_healer.set_alt_mode_action(player, magic_wand_healer.alt_mode_action.kill)
		end
		return true
	end
	
	if element_name == creative_mode_defines.names.gui.magic_wand_healer_alt_dont_affect_characters_checkbox then
		-- Healer - alt don't affect characters checkbox.
		magic_wand_healer.set_alt_mode_dont_affect_player_characters(player, element.state)
		return true
	end
	
	if element_name == creative_mode_defines.names.gui.magic_wand_healer_alt_dont_affect_indestructible_checkbox then
		-- Healer - alt don't affect indestructible entities.
		magic_wand_healer.set_alt_mode_dont_affect_indestructible_entities(player, element.state)
		return true
	end
	
	if element.parent and element.parent.name == creative_mode_defines.names.gui.magic_wand_healer_alt_forces_table then
		-- Healer - alt force checkboxes.
		local force_name = string.match(element.name, creative_mode_defines.match_patterns.gui.magic_wand_healer_alt_force_name_checkbox)
		if force_name then
			local force = game.forces[force_name]
			if force then
				magic_wand_healer.set_alt_mode_apply_on_force(player, force, element.state)
			else
				-- No such force anymore.
				element.destroy()
			end
		end
		return true
	end
	
	--------------------------------------------------------------------
	
	if element_name == creative_mode_defines.names.gui.magic_wand_modifier_std_ignore_characters_checkbox then
		-- Modifier - std ignore player characters checkbox.
		magic_wand_modifier.set_std_ignore_player_characters(player, element.state)
		return true
	end
	
	if element_name == creative_mode_defines.names.gui.magic_wand_modifier_std_ignore_healthless_checkbox then
		-- Modifier - std ignore healthless entities checkbox.
		magic_wand_modifier.set_std_ignore_healthess_entities(player, element.state)
		return true
	end
	
	if element_name == creative_mode_defines.names.gui.magic_wand_modifier_std_ignore_indestructible_checkbox then
		-- Modifier - std ignore indestructible entities checkbox.
		magic_wand_modifier.set_std_ignore_indestructible_entities(player, element.state)
	end
	
	if element.parent and element.parent.name == creative_mode_defines.names.gui.magic_wand_modifier_std_forces_table then
		-- Modifier - std force checkboxes.
		local force_name = string.match(element.name, creative_mode_defines.match_patterns.gui.magic_wand_modifier_std_force_name_checkbox)
		if force_name then
			local force = game.forces[force_name]
			if force then
				magic_wand_modifier.set_std_select_entities_on_force(player, force, element.state)
			else
				-- No such force anymore.
				element.destroy()
			end
		end
		return true
	end
	
	----
	
	if element_name == creative_mode_defines.names.gui.magic_wand_modifier_alt_ignore_characters_checkbox then
		-- Modifier - alt ignore player characters checkbox.
		magic_wand_modifier.set_alt_ignore_player_characters(player, element.state)
		return true
	end
	
	if element_name == creative_mode_defines.names.gui.magic_wand_modifier_alt_ignore_healthless_checkbox then
		-- Modifier - alt ignore healthless entities checkbox.
		magic_wand_modifier.set_alt_ignore_healthess_entities(player, element.state)
		return true
	end
	
	if element_name == creative_mode_defines.names.gui.magic_wand_modifier_alt_ignore_indestructible_checkbox then
		-- Modifier - alt ignore indestructible entities checkbox.
		magic_wand_modifier.set_alt_ignore_indestructible_entities(player, element.state)
	end
	
	if element.parent and element.parent.name == creative_mode_defines.names.gui.magic_wand_modifier_alt_forces_table then
		-- Modifier - alt force checkboxes.
		local force_name = string.match(element.name, creative_mode_defines.match_patterns.gui.magic_wand_modifier_alt_force_name_checkbox)
		if force_name then
			local force = game.forces[force_name]
			if force then
				magic_wand_modifier.set_alt_select_entities_on_force(player, force, element.state)
			else
				-- No such force anymore.
				element.destroy()
			end
		end
		return true
	end
	
	return false
end

-- Callback of the on_gui_selection_state_changed event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_magicwand.on_gui_selection_state_changed(element, element_name, player)
	if element_name == creative_mode_defines.names.gui.magic_wand_creator_use_pattern_drop_down then
		-- Creator - use pattern drop-down.
		magic_wand_creator.set_use_pattern(player, element.selected_index)
		-- Update the visibility of the UI elements for selecting the second tile or resource.
		--[[
		local container = element.parent.parent
		local tile_or_resource_2_container = container[creative_mode_defines.names.gui.magic_wand_creator_tile_or_resource_2_container]
		if tile_or_resource_2_container then
			tile_or_resource_2_container.style.visible = element.selected_index > 1
		end
		--]]
		-- Known issue: hiding the UI will bug the scroll-pane.
		return true
	end
end