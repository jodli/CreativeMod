-- This file contains variables and functions related to entity GUI.
if not gui_entity then gui_entity = {} end

-- Creates the GUI frame (for opened entity GUI) for the given entity if the frame has not been created. Otherwise, destroys the element.
-- Returns the frame container and the frame if they are created.
local function create_or_destroy_entity_gui_frame(entity_gui_container, entity, use_frame_container)
	local element_name
	if use_frame_container then
		element_name = creative_mode_defines.names.gui.entity_gui_frame_container
	else
		element_name = creative_mode_defines.names.gui.entity_gui_frame
	end
	if entity_gui_container[element_name] then
		entity_gui_container[element_name].destroy()
		return nil
	end
	
	if use_frame_container then
		-- Don't use table, as it will be repositioned when any child is destroyed.
		local frame_container = entity_gui_container.add{type = "flow", name = creative_mode_defines.names.gui.entity_gui_frame_container, style = creative_mode_defines.names.gui_styles.no_vertical_spacing_resize_row_flow, direction = "vertical"}
		frame_container.add{type = "frame", name = creative_mode_defines.names.gui.entity_gui_frame, direction = "vertical", caption = entity.localised_name}
		return frame_container, frame_container[creative_mode_defines.names.gui.entity_gui_frame]
	else
		entity_gui_container.add{type = "frame", name = creative_mode_defines.names.gui.entity_gui_frame, direction = "vertical", caption = entity.localised_name}
		return nil, entity_gui_container[creative_mode_defines.names.gui.entity_gui_frame]
	end
end

-- Returns the frame and frame container for the given player and entity GUI of the given entity.
-- 2 nils will be returned if the player has not opened the entity GUI.
-- @param use_frame_container	Whether an additional container was used outside the entity GUI frame when creating the entity GUI.
local function get_frame_and_frame_container_for_entity_gui(player, entity, use_frame_container)
	local entity_gui_container = mod_gui.get_frame_flow(player)[creative_mode_defines.names.gui.entity_gui_container]
	if not entity_gui_container then
		return nil, nil
	end
	if use_frame_container then
		local frame_container = entity_gui_container[creative_mode_defines.names.gui.entity_gui_frame_container]
		if not frame_container then
			return nil, nil
		end
		return frame_container, frame_container[creative_mode_defines.names.gui.entity_gui_frame]
	else
		return nil, entity_gui_container[creative_mode_defines.names.gui.entity_gui_frame]
	end	
end

-- Updates the entity GUI for all players who are checking the given entity using the given update delegate.
-- @param use_frame_container	Whether an additional container was used outside the entity GUI frame when creating the entity GUI.
local function update_entity_gui_for_all_players_checking_the_entity(entity, use_frame_container, update_delegate)
	for _, player in pairs(game.players) do
		if global.creative_mode.player_opened_entities[player.index] == entity then
			local frame_container, frame = get_frame_and_frame_container_for_entity_gui(player, entity, use_frame_container)
			update_delegate(player, frame_container, frame)
		end
	end
end

--------------------------------------------------------------------

-- Returns the caption for the creative chest group number label according to the given group number.
local function get_caption_for_creative_chest_group_number_label(group_number, max_group_number)
	return group_number .. "/" .. max_group_number
end

-- Creates the filter table for the given creative chest GUI frame according to the given chest data and group number.
local function create_filter_table_for_creative_chest_gui_frame(chest_data, group_number, contain_hidden_items, frame)
	-- Slot table wrapped inside a scroll-pane.
	local scroll_pane = frame.add{type = "scroll-pane", name = creative_mode_defines.names.gui.creative_chest_filter_scroll_pane}
	scroll_pane.style.maximal_height = 465
	local filter_table = scroll_pane.add{type = "table", name = creative_mode_defines.names.gui.creative_chest_filter_table, column_count = 10, style = creative_mode_defines.names.gui_styles.slot_table}
	-- The slots.
	local inventory = creative_chest_util.get_inventory_from_data(chest_data)
	local slot = 1
	local inventory_size = #inventory
	local filtered_slots = chest_data.filtered_slots
	local filtered_slots_count = #filtered_slots
	local next_filtered_slot_to_check = 1
	if filtered_slots_count <= 0 then
		next_filtered_slot_to_check = 0
	end
	local start_item_index, end_item_index = creative_chest_util.get_start_end_item_index_for_group(group_number, inventory_size - 1, contain_hidden_items)
	for i = start_item_index, end_item_index, 1 do
		local item = creative_chest_util.get_item_at(i, contain_hidden_items)
		local style
		-- Check whether the slot has been filtered out.
		if next_filtered_slot_to_check <= 0 or filtered_slots[next_filtered_slot_to_check] ~= slot then
			style = creative_mode_defines.names.gui_styles.creative_chest_filter_slot_on
		else
			style = creative_mode_defines.names.gui_styles.creative_chest_filter_slot_off
			-- Check for the next index of filtered slot if possible.
			if filtered_slots_count >= next_filtered_slot_to_check + 1 then
				next_filtered_slot_to_check = next_filtered_slot_to_check + 1
			else
				next_filtered_slot_to_check = 0
			end
		end
		
		filter_table.add{type = "sprite-button", name = creative_mode_defines.names.gui.creative_chest_filter_slot_prefix .. slot, sprite = "item/" .. item.name, style = style, tooltip = item.localised_name}
		
		-- Next slot.
		slot = slot + 1
		-- Though it is unlikely to happen... (caused by mod version change?) Break the loop if slot exceeds.
		if slot > inventory_size then
			break
		end
	end
end

-- Creates or destroys the Creative Chest GUI for the given player. Returns whether the GUI is created.
local function create_or_destroy_creative_chest_gui(player, entity, entity_gui_container)
	-- Creative chest open button.
	local chest_groups, max_group_number, contain_hidden_items = creative_chest_util.get_creative_chest_data_groups(entity)
	local chest_data, group_number = creative_chest_util.get_creative_chest_data_group_number(entity, chest_groups)
	if chest_data and group_number > 0 then
		-- Frame.
		local _, frame = create_or_destroy_entity_gui_frame(entity_gui_container, entity, false)
		
		if frame then
			-- Item group label.
			local item_group_container = frame.add{type = "table", name = creative_mode_defines.names.gui.creative_chest_item_group_container, style = creative_mode_defines.names.gui_styles.unscalable_no_spacing_table, column_count = 4}
			item_group_container.add{type = "label", name = creative_mode_defines.names.gui.creative_chest_item_group_label, style = creative_mode_defines.names.gui_styles.creative_chest_item_group_label, caption = {"gui.creative-mode_item-group"}, tooltip = {"gui.creative-mode_item-group-tooltip"}}
			-- Item group left button.
			item_group_container.add{type = "button", name = creative_mode_defines.names.gui.creative_chest_item_group_left_button, style = creative_mode_defines.names.gui_styles.creative_chest_item_group_left_right_button, caption = "<"}
			-- Item group number label.
			item_group_container.add{type = "label", name = creative_mode_defines.names.gui.creative_chest_item_group_number_label, style = creative_mode_defines.names.gui_styles.creative_chest_item_group_number_label, caption = get_caption_for_creative_chest_group_number_label(group_number, max_group_number)}
			-- Item group right button.
			item_group_container.add{type = "button", name = creative_mode_defines.names.gui.creative_chest_item_group_right_button, style = creative_mode_defines.names.gui_styles.creative_chest_item_group_left_right_button, caption = ">"}
			
			-- Filter items label.
			local label_container = frame.add{type = "table", name = creative_mode_defines.names.gui.creative_chest_filter_container, style = creative_mode_defines.names.gui_styles.unscalable_no_spacing_table, column_count = 3}
			label_container.add{type = "label", name = creative_mode_defines.names.gui.creative_chest_filter_label, style = creative_mode_defines.names.gui_styles.creative_chest_select_slot_label, caption = {"gui.creative-mode_select-slots-to-filter"}, tooltip = {"gui.creative-mode_select-slots-to-filter-tooltip"}}
			-- Inventory display mode button.
			local display_mode_style
			local display_mode_tooltip
			if chest_data.inventory_display_mode == creative_chest_util.inventory_display_modes.original_mode then
				display_mode_style = creative_mode_defines.names.gui_styles.creative_chest_display_mode_button_original
				display_mode_tooltip = creative_mode_defines.names.gui_captions.creative_chest_display_mode_original
			else
				display_mode_style = creative_mode_defines.names.gui_styles.creative_chest_display_mode_button_compact
				display_mode_tooltip = creative_mode_defines.names.gui_captions.creative_chest_display_mode_compact
			end
			label_container.add{type = "button", name = creative_mode_defines.names.gui.creative_chest_display_mode_button, style = display_mode_style, tooltip = display_mode_tooltip}
			-- Toggle all button.
			label_container.add{type = "button", name = creative_mode_defines.names.gui.creative_chest_toggle_all_button, style = creative_mode_defines.names.gui_styles.inventory_toggle_all_button, tooltip = {"gui.creative-mode_toggle-all-filtered-slots-tooltip"}}
			
			-- Filter table.
			create_filter_table_for_creative_chest_gui_frame(chest_data, group_number, contain_hidden_items, frame)
			
			return true
		end
	end
	return false
end

-- Adds the group number of the given creative chest and updates the GUI about its contents.
local function add_creative_chest_group_number_and_update_gui(creative_chest_entity, add_amount)
	local chest_groups, max_group_number, contain_hidden_items = creative_chest_util.get_creative_chest_data_groups(creative_chest_entity)
	local chest_data, group_number, index_in_group = creative_chest_util.get_creative_chest_data_group_number(creative_chest_entity, chest_groups)
	if chest_data and group_number > 0 then
		-- Change group number.
		local new_group_number = group_number + add_amount
		new_group_number = util.repeat_index(new_group_number, 1, max_group_number)
		if creative_chest_util.change_creative_chest_group_number(chest_data, chest_groups, group_number, index_in_group, new_group_number) then
			-- Update the GUI for all players who are checking the entity.
			update_entity_gui_for_all_players_checking_the_entity(creative_chest_entity, false, function(p, _, frame)
				if frame then
					-- Update item group number.
					local item_group_container = frame[creative_mode_defines.names.gui.creative_chest_item_group_container]
					local item_group_number_label = item_group_container[creative_mode_defines.names.gui.creative_chest_item_group_number_label]
					item_group_number_label.caption = get_caption_for_creative_chest_group_number_label(new_group_number, max_group_number)
					
					-- Update filter table.
					local scroll_pane = frame[creative_mode_defines.names.gui.creative_chest_filter_scroll_pane]
					-- Destroy the original scroll pane and re-create it and its contents.
					scroll_pane.destroy()
					create_filter_table_for_creative_chest_gui_frame(chest_data, new_group_number, contain_hidden_items, frame)
				end
			end)
		end
	end
end

--------------------------------------------------------------------

-- Creates or destroys the duplicating chest GUI for the given player. Returns whether the GUI is created.
local function create_or_destroy_duplicating_chest_gui(player, entity, entity_gui_container)
	local data = duplicating_chest_util.get_data_for_entity(entity)
	if data then
		-- Frame.
		local _, frame = create_or_destroy_entity_gui_frame(entity_gui_container, entity, false)
		
		if frame then
			-- Checkbox.
			frame.add{type = "checkbox", name = creative_mode_defines.names.gui.duplicating_chest_lock_item_checkbox, state = data.lock_item, caption = {"gui.creative-mode_lock-item"}, tooltip = {"gui.creative-mode_lock-item-tooltip"}}
			
			return true
		end
	end
	return false
end

--------------------------------------------------------------------

-- Creates or destroys the Configurable Super Boiler GUI for the given player. Returns whether the GUI is created.
local function create_or_destroy_configurable_super_boiler_gui(player, entity, entity_gui_container)
	local data = configurable_super_boiler.get_data_for_entity(entity)
	if data then
		-- Frame.
		local _, frame = create_or_destroy_entity_gui_frame(entity_gui_container, entity, false)
		
		if frame then
			-- Container.
			local set_temp_container = frame.add{type = "flow", name = creative_mode_defines.names.gui.configurable_super_boiler_set_temp_container, direction = "horizontal"}
			-- Label.
			set_temp_container.add{type = "label", name = creative_mode_defines.names.gui.configurable_super_boiler_set_temp_label, caption = {"gui.creative-mode_set-temperature"}}
			-- Textfield.
			set_temp_container.add{type = "textfield", name = creative_mode_defines.names.gui.configurable_super_boiler_set_temp_textfield, style = creative_mode_defines.names.gui_styles.item_count_textfield, text = data.temperature}
			-- Button.
			set_temp_container.add{type = "button", name = creative_mode_defines.names.gui.configurable_super_boiler_set_temp_button, style = creative_mode_defines.names.gui_styles.cheat_on_off_button_off, caption = creative_mode_defines.names.gui_captions.ok}
			
			return true
		end
	end
	return false
end

--------------------------------------------------------------------

-- Adds or removes the GUI about options for Matter Source insert only once to player according to the given Matter Source entity data.
local function add_or_remove_item_source_insert_only_once_to_player_options_gui(frame_container, entity_data)
	if entity_data.insert_only_once_to_player then
		if not frame_container[creative_mode_defines.names.gui.item_source_insert_once_to_player_frame] then
			-- Insert only once to player frame.
			local insert_once_to_player_frame = frame_container.add{type = "frame", name = creative_mode_defines.names.gui.item_source_insert_once_to_player_frame, direction = "vertical"}
			-- Container.
			local insert_once_to_player_container = insert_once_to_player_frame.add{type = "table", name = creative_mode_defines.names.gui.item_source_insert_once_to_player_container, column_count = 1}
			-- Insert to player amount.
			local insert_to_player_amount_container = insert_once_to_player_container.add{type = "flow", name = creative_mode_defines.names.gui.item_source_insert_once_to_player_amount_container, direction = "horizontal"}
			insert_to_player_amount_container.add{type = "label", name = creative_mode_defines.names.gui.item_source_insert_once_to_player_amount_label, caption = {"gui.creative-mode_insert-to-player-amount"}, tooltip = {"gui.creative-mode_insert-to-player-amount-tooltip"}}
			insert_to_player_amount_container.add{type = "textfield", name = creative_mode_defines.names.gui.item_source_insert_once_to_player_amount_field, style = creative_mode_defines.names.gui_styles.item_count_textfield, text = entity_data.insert_to_player_amount}
			-- Insert to player by stack.
			insert_once_to_player_container.add{type = "checkbox", name = creative_mode_defines.names.gui.item_source_insert_once_to_player_by_stack_checkbox, state = entity_data.insert_to_player_by_stack, caption = {"gui.creative-mode_by-stack"}, tooltip = {"gui.creative-mode_by-stack-tooltip"}}
		end
	else
		if frame_container[creative_mode_defines.names.gui.item_source_insert_once_to_player_frame] then
			frame_container[creative_mode_defines.names.gui.item_source_insert_once_to_player_frame].destroy()
		end
	end
end

-- Adds or removes the GUI about options for Matter Source insert to player according to the given Matter Source entity data.
local function add_or_remove_item_source_insert_to_player_options_gui(frame_container, entity_data)
	if entity_data.can_insert_to_player then
		if not frame_container[creative_mode_defines.names.gui.item_source_insert_to_player_frame] then
			-- Insert to player frame.
			local insert_to_player_frame = frame_container.add{type = "frame", name = creative_mode_defines.names.gui.item_source_insert_to_player_frame, direction = "vertical"}
			-- Insert to player only once.
			insert_to_player_frame.add{type = "checkbox", name = creative_mode_defines.names.gui.item_source_insert_only_once_to_player_checkbox, state = entity_data.insert_only_once_to_player, caption = {"gui.creative-mode_insert_only_once_to_player"}, tooltip = {"gui.creative-mode_insert_only_once_to_player-tooltip"}}
			
			-- Insert only once to player GUI.
			add_or_remove_item_source_insert_only_once_to_player_options_gui(frame_container, entity_data)
		end
	else
		if frame_container[creative_mode_defines.names.gui.item_source_insert_to_player_frame] then
			frame_container[creative_mode_defines.names.gui.item_source_insert_to_player_frame].destroy()
		end
		if frame_container[creative_mode_defines.names.gui.item_source_insert_once_to_player_frame] then
			frame_container[creative_mode_defines.names.gui.item_source_insert_once_to_player_frame].destroy()
		end
	end
end

-- Creates or destroys the Matter Source GUI for the given player. Returns whether the GUI is created.
local function create_or_destroy_item_source_gui(player, entity, entity_gui_container)
	local data = nil
	if entity.name == creative_mode_defines.names.entities.item_source then
		data = item_source.get_data_for_entity(entity)
	else
		data = random_item_source.get_data_for_entity(entity)
	end
	if data then
		-- Frame.
		local frame_container, frame = create_or_destroy_entity_gui_frame(entity_gui_container, entity, true)
		
		if frame_container and frame then
			-- Options container.
			local options_container = frame.add{type = "table", name = creative_mode_defines.names.gui.item_source_options_container, column_count = 1}
			-- Can insert to vehicle.
			options_container.add{type = "checkbox", name = creative_mode_defines.names.gui.item_source_can_insert_to_vehicle_checkbox, state = data.can_insert_to_vehicle, caption = {"gui.creative-mode_can-insert-to-vehicle"}}
			-- Can insert to player.
			options_container.add{type = "checkbox", name = creative_mode_defines.names.gui.item_source_can_insert_to_player_checkbox, state = data.can_insert_to_player, caption = {"gui.creative-mode_can-insert-to-player"}}
			-- Can drop on ground.
			options_container.add{type = "checkbox", name = creative_mode_defines.names.gui.item_source_can_drop_on_ground_checkbox, state = data.can_drop_on_ground, caption = {"gui.creative-mode_can-drop-on-ground"}}
			
			add_or_remove_item_source_insert_to_player_options_gui(frame_container, data)
			
			return true
		end
	end
	return false
end

--------------------------------------------------------------------

-- Creates or destroys the Matter Duplicator GUI for the given player. Returns whether the GUI is created.
local function create_or_destroy_duplicator_gui(player, entity, entity_gui_container)
	local data = duplicator.get_data_for_entity(entity)
	if data then
		-- Frame.
		local frame_container, frame = create_or_destroy_entity_gui_frame(entity_gui_container, entity, true)
		
		if frame_container and frame then
			-- Options container.
			local options_container = frame.add{type = "table", name = creative_mode_defines.names.gui.duplicator_options_container, column_count = 1}
			-- Can duplicate in vehicle.
			options_container.add{type = "checkbox", name = creative_mode_defines.names.gui.duplicator_can_duplicate_in_vehicle_checkbox, state = data.can_duplicate_in_vehicle, caption = {"gui.creative-mode_can-duplicate-in-vehicle"}}
			-- Can duplicate in player.
			options_container.add{type = "checkbox", name = creative_mode_defines.names.gui.duplicator_can_duplicate_in_player_checkbox, state = data.can_duplicate_in_player, caption = {"gui.creative-mode_can-duplicate-in-player"}}
		
			return true
		end
	end
	return false
end

--------------------------------------------------------------------

-- Creates or destroys the Matter Void GUI for the given player. Returns whether the GUI is created.
local function create_or_destroy_item_void_gui(player, entity, entity_gui_container)
	local data = item_void.get_data_for_entity(entity)
	if data then
		-- Frame.
		local frame_container, frame = create_or_destroy_entity_gui_frame(entity_gui_container, entity, true)
		
		if frame_container and frame then
			-- Options container.
			local options_container = frame.add{type = "table", name = creative_mode_defines.names.gui.item_void_options_container, column_count = 1}
			-- Can remove from vehicle.
			options_container.add{type = "checkbox", name = creative_mode_defines.names.gui.item_void_can_remove_from_vehicle_checkbox, state = data.can_remove_from_vehicle, caption = {"gui.creative-mode_can-remove-from-vehicle"}}
			-- Can remove from player.
			options_container.add{type = "checkbox", name = creative_mode_defines.names.gui.item_void_can_remove_from_player_checkbox, state = data.can_remove_from_player, caption = {"gui.creative-mode_can-remove-from-player"}}
			-- Can remove from ground.
			options_container.add{type = "checkbox", name = creative_mode_defines.names.gui.item_void_can_remove_from_ground_checkbox, state = data.can_remove_from_ground, caption = {"gui.creative-mode_can-remove-from-ground"}}
		end
		
		return true
	end
	return false
end

--------------------------------------------------------------------

-- Resets the last action applied on the entity GUI by the player of given index.
local function reset_last_entity_gui_action_by_player_index(player_index)
	if global.last_entity_gui_actions_by_players then
		global.last_entity_gui_actions_by_players[player_index] = nil
	end
end

-- Creates or destroys the GUI of given entity on the given player.
-- Nothing will be created if there is no GUI for the entity.
function gui_entity.create_or_destroy_gui_of_entity(player, entity, is_create)
	local left = mod_gui.get_frame_flow(player)
    local top = mod_gui.get_button_flow(player)
	-- Register or deregister the entity.
	if is_create then
		global.creative_mode.player_opened_entities[player.index] = entity
	else
		global.creative_mode.player_opened_entities[player.index] = nil
	end
	
	-- Reset action.
	reset_last_entity_gui_action_by_player_index(player.index)
	
	if is_create and player.opened_gui_type == defines.gui_type.entity then
		-- Create GUI.
		local entity_name = entity.name
		-- Get the data about the button that we will created.
		local button_name
		local open_gui_function
		if entity_name == creative_mode_defines.names.entities.creative_chest or entity_name == creative_mode_defines.names.entities.creative_provider_chest or entity_name == creative_mode_defines.names.entities.creative_cargo_wagon then
			-- Button for the creative chest family.
			button_name = creative_mode_defines.names.gui.creative_chest_open_button
			open_gui_function = create_or_destroy_creative_chest_gui
		elseif entity_name == creative_mode_defines.names.entities.duplicating_chest or entity_name == creative_mode_defines.names.entities.duplicating_provider_chest or entity_name == creative_mode_defines.names.entities.duplicating_cargo_wagon then
			-- Button for the duplicating chest family.
			button_name = creative_mode_defines.names.gui.duplicating_chest_open_button
			open_gui_function = create_or_destroy_duplicating_chest_gui
		elseif entity_name == creative_mode_defines.names.entities.configurable_super_boiler then
			-- Button for the configurable super boiler.
			button_name = creative_mode_defines.names.gui.configurable_super_boiler_open_button
			open_gui_function = create_or_destroy_configurable_super_boiler_gui
		elseif entity_name == creative_mode_defines.names.entities.item_source or entity_name == creative_mode_defines.names.entities.random_item_source then
			-- Button for the matter source and random item source.
			button_name = creative_mode_defines.names.gui.item_source_open_button
			open_gui_function = create_or_destroy_item_source_gui
		elseif entity_name == creative_mode_defines.names.entities.duplicator then
			-- Button for the matter duplicator.
			button_name = creative_mode_defines.names.gui.duplicator_open_button
			open_gui_function = create_or_destroy_duplicator_gui
		elseif entity_name == creative_mode_defines.names.entities.item_void then
			-- Button for the matter void.
			button_name = creative_mode_defines.names.gui.item_void_open_button
			open_gui_function = create_or_destroy_item_void_gui
		else
			-- No GUI for the entity.
			return
		end
		
		-- Container.
		local container = left.add{type = "table", name = creative_mode_defines.names.gui.entity_gui_container, column_count = 2}
		container.style.top_padding = 8
		container.style.horizontal_spacing = 0
		
		-- Button container.
		local button_container = top.add{type = "flow", name = creative_mode_defines.names.gui.entity_gui_button_container}
		
		-- Button.
		button_container.add{type = "sprite-button", name = button_name, style = creative_mode_defines.names.gui_styles.entity_open_button, sprite = "item/" .. entity_name, tooltip = {"gui.creative-mode_entity-button-tooltip", entity.localised_name}}
	
		-- Open the detailed GUI if necessary.
		if global.creative_mode.player_opened_entity_gui[player.index] == nil or global.creative_mode.player_opened_entity_gui[player.index] then
			open_gui_function(player, entity, container)
		end
	else
		-- Destroy GUI.
		global.creative_mode.player_opened_entities[player.index] = nil
        local container = left[creative_mode_defines.names.gui.entity_gui_container]
		if container then
			container.destroy()
		end
        local button_container = top[creative_mode_defines.names.gui.entity_gui_button_container]
        if button_container then
            button_container.destroy()
        end
	end
end

--------------------------------------------------------------------

-- Callback of the on_gui_click event, extended from gui.lua.
-- Returns whether the event is consumed.
function gui_entity.on_gui_click(element, element_name, player, button, alt, control, shift)
	local left = mod_gui.get_frame_flow(player)
	local entity = global.creative_mode.player_opened_entities[player.index]
	local entity_gui_container = left[creative_mode_defines.names.gui.entity_gui_container]
	
	if element_name == creative_mode_defines.names.gui.creative_chest_open_button then
		-- Creative chest open button.
		if create_or_destroy_creative_chest_gui(player, entity, entity_gui_container) then
			-- UI is opened.
			global.creative_mode.player_opened_entity_gui[player.index] = true
		else
			-- UI is closed.
			global.creative_mode.player_opened_entity_gui[player.index] = false
		end
		return true
	elseif element_name == creative_mode_defines.names.gui.creative_chest_item_group_left_button then
		-- Reduce group number by 1 for creative chest.
		add_creative_chest_group_number_and_update_gui(entity, -1)
		return true
	elseif element_name == creative_mode_defines.names.gui.creative_chest_item_group_right_button then
		-- Increase group number by 1 for creative chest.
		add_creative_chest_group_number_and_update_gui(entity, 1)
		return true
	elseif element_name == creative_mode_defines.names.gui.creative_chest_display_mode_button then
		-- Toggle inventory display mode for creative chest.
		local chest_data, group_number = creative_chest_util.get_creative_chest_data_group_number(entity, creative_chest_util.get_creative_chest_data_groups(entity))
		if chest_data and group_number > 0 then
			local display_mode_style
			local display_mode_tooltip
			if chest_data.inventory_display_mode == creative_chest_util.inventory_display_modes.original_mode then
				chest_data.inventory_display_mode = creative_chest_util.inventory_display_modes.compact_mode
				display_mode_style = creative_mode_defines.names.gui_styles.creative_chest_display_mode_button_compact
				display_mode_tooltip = creative_mode_defines.names.gui_captions.creative_chest_display_mode_compact
			else
				chest_data.inventory_display_mode = creative_chest_util.inventory_display_modes.original_mode
				display_mode_style = creative_mode_defines.names.gui_styles.creative_chest_display_mode_button_original
				display_mode_tooltip = creative_mode_defines.names.gui_captions.creative_chest_display_mode_original
			end
			
			-- Update the GUI for all players who are checking the entity.
			update_entity_gui_for_all_players_checking_the_entity(entity, false, function(p, _, frame)
				if frame then
					local label_container = frame[creative_mode_defines.names.gui.creative_chest_filter_container]
					local display_mode_button = label_container[creative_mode_defines.names.gui.creative_chest_display_mode_button]
					display_mode_button.style = display_mode_style
					display_mode_button.tooltip = display_mode_tooltip
				end
			end)
		end
		return true
	elseif element_name == creative_mode_defines.names.gui.creative_chest_toggle_all_button then
		-- Toggle all button for creative chest.
		local chest_groups, max_group_number, contain_hidden_items = creative_chest_util.get_creative_chest_data_groups(entity)
		local chest_data, group_number = creative_chest_util.get_creative_chest_data_group_number(entity, chest_groups)
		if chest_data and group_number > 0 then
			-- Toggle all button -> label container -> frame
			local inventory = creative_chest_util.get_inventory_from_data(chest_data)
			local start_item_index, end_item_index = creative_chest_util.get_start_end_item_index_for_group(group_number, #inventory - 1, contain_hidden_items)
			local item_count = end_item_index - start_item_index + 1
			local all_on = #chest_data.filtered_slots >= item_count
			local style
			-- The array of filtered slots is renewed not matter the slots are all filtered or restored.
			chest_data.filtered_slots = {}
			if all_on then
				-- Restore all slots.
				style = creative_mode_defines.names.gui_styles.creative_chest_filter_slot_on
			else
				-- Filter out all slots.
				style = creative_mode_defines.names.gui_styles.creative_chest_filter_slot_off
				for i = 1, item_count, 1 do
					table.insert(chest_data.filtered_slots, i)
					inventory[i].clear()
				end
			end
			
			-- Update the GUI for all players who are checking the entity.
			update_entity_gui_for_all_players_checking_the_entity(entity, false, function(p, _, frame)
				if frame then
					local scroll_pane = frame[creative_mode_defines.names.gui.creative_chest_filter_scroll_pane]
					local filter_table = scroll_pane[creative_mode_defines.names.gui.creative_chest_filter_table]
					for i = 1, item_count, 1 do
						filter_table[creative_mode_defines.names.gui.creative_chest_filter_slot_prefix .. i].style = style
					end
				end
			end)
		end
		-- Reset player action on GUI because toggle-all will affect the toggle action of shift-click on the filter slots.
		reset_last_entity_gui_action_by_player_index(player.index)
		return true
	
	---------------------------------------------------------------------------------------------------
	
	elseif element_name == creative_mode_defines.names.gui.duplicating_chest_open_button then
		-- Duplicating chest open button.
		if create_or_destroy_duplicating_chest_gui(player, entity, entity_gui_container) then
			-- UI is opened.
			global.creative_mode.player_opened_entity_gui[player.index] = true
		else
			-- UI is closed.
			global.creative_mode.player_opened_entity_gui[player.index] = false
		end
		return true
	
	---------------------------------------------------------------------------------------------------
	
	elseif element_name == creative_mode_defines.names.gui.configurable_super_boiler_open_button then
		-- Configurable super boiler open button.
		if create_or_destroy_configurable_super_boiler_gui(player, entity, entity_gui_container) then
			-- UI is opened.
			global.creative_mode.player_opened_entity_gui[player.index] = true
		else
			-- UI is closed.
			global.creative_mode.player_opened_entity_gui[player.index] = false
		end
		return true
	elseif element_name == creative_mode_defines.names.gui.configurable_super_boiler_set_temp_button then
		-- Configurable super boiler set temp button.
		local data = configurable_super_boiler.get_data_for_entity(entity)
		if data then
			-- button -> container.textfield
			local textfield = element.parent[creative_mode_defines.names.gui.configurable_super_boiler_set_temp_textfield]
			-- Validate temperature.
			local temperature = tonumber(textfield.text)
			if temperature then
				temperature = util.clamp(temperature, -1000000, 1000000)
			else
				temperature = 0
			end
			-- Update the boiler's temperature.
			configurable_super_boiler.update_temperature(data, temperature)
			-- Update the textfield for all players who are checking the entity.
			update_entity_gui_for_all_players_checking_the_entity(entity, false, function(p, _, frame)
				if frame then
					-- Container.
					local set_temp_container = frame[creative_mode_defines.names.gui.configurable_super_boiler_set_temp_container]
					-- Textfield.
					local set_temp_textfield = set_temp_container[creative_mode_defines.names.gui.configurable_super_boiler_set_temp_textfield]
					set_temp_textfield.text = temperature
				end
			end)
		end
		return true
	
	---------------------------------------------------------------------------------------------------
	
	elseif element_name == creative_mode_defines.names.gui.item_source_open_button then
		-- Matter source open button.
		if create_or_destroy_item_source_gui(player, entity, entity_gui_container) then
			-- UI is opened.
			global.creative_mode.player_opened_entity_gui[player.index] = true
		else
			-- UI is closed.
			global.creative_mode.player_opened_entity_gui[player.index] = false
		end
		return true
		
	---------------------------------------------------------------------------------------------------
	
	elseif element_name == creative_mode_defines.names.gui.duplicator_open_button then
		-- Matter duplicator open button.
		if create_or_destroy_duplicator_gui(player, entity, entity_gui_container) then
			-- UI is opened.
			global.creative_mode.player_opened_entity_gui[player.index] = true
		else
			-- UI is closed.
			global.creative_mode.player_opened_entity_gui[player.index] = false
		end
		return true
		
	---------------------------------------------------------------------------------------------------
	
	elseif element_name == creative_mode_defines.names.gui.item_void_open_button then
		-- Matter void open button.
		if create_or_destroy_item_void_gui(player, entity, entity_gui_container) then
			-- UI is opened.
			global.creative_mode.player_opened_entity_gui[player.index] = true
		else
			-- UI is closed.
			global.creative_mode.player_opened_entity_gui[player.index] = false
		end
		return true
		
	---------------------------------------------------------------------------------------------------
	
	else
		if element.parent and element.parent.name == creative_mode_defines.names.gui.creative_chest_filter_table then
			-- Creative chest filter slot.
			local slot = string.match(element_name, creative_mode_defines.match_patterns.gui.creative_chest_filter_slot)
			if slot ~= nil then
				slot = tonumber(slot)
				local chest_groups, _, contain_hidden_items = creative_chest_util.get_creative_chest_data_groups(entity)
				local chest_data, group_number = creative_chest_util.get_creative_chest_data_group_number(entity, chest_groups)
				if chest_data and group_number > 0 then
					-- Ctrl click?
					if control then
						-- Get a full stack of the item.
						local inventory = creative_chest_util.get_inventory_from_data(chest_data)
						local inventory_size = #inventory
						local start_item_index = creative_chest_util.get_start_end_item_index_for_group(group_number, inventory_size - 1, contain_hidden_items)
						local item = creative_chest_util.get_item_at(start_item_index + slot - 1, contain_hidden_items)
						player.clean_cursor()
						player.cursor_stack.set_stack{name = item.name, count = item.stack_size}
						
						-- Record the slot for the next shift-click.
						global.last_entity_gui_actions_by_players = global.last_entity_gui_actions_by_players or {}
						global.last_entity_gui_actions_by_players[player.index] = 
						{
							non_shift =
							{
								slot = slot,
								is_filter = element.style.name == creative_mode_defines.names.gui_styles.creative_chest_filter_slot_off
							}
						}
						return true
					end
					
					-- Shift click?
					if shift then
						-- Get the recorded non-shift-clicked slot and action (filter or unfilter).
						local non_shift_slot
						local is_filter
						local has_recorded_action
						if global.last_entity_gui_actions_by_players and global.last_entity_gui_actions_by_players[player.index] and global.last_entity_gui_actions_by_players[player.index].non_shift then
							local non_shift = global.last_entity_gui_actions_by_players[player.index].non_shift
							non_shift_slot = non_shift.slot
							is_filter = non_shift.is_filter
							has_recorded_action = true
						else
							-- If there is no recorded action, we make one.
							non_shift_slot = 1
							-- Set action according to the current state of the current slot.
							-- If it is not filtered, filter the slots.
							is_filter = element.style.name == creative_mode_defines.names.gui_styles.creative_chest_filter_slot_on							
							global.last_entity_gui_actions_by_players = global.last_entity_gui_actions_by_players or {}
							global.last_entity_gui_actions_by_players[player.index] =
							{
								non_shift =
								{
									slot = non_shift_slot,
									is_filter = is_filter
								}
							}
							
							has_recorded_action = false
						end
						
						local slot_actions_dict = {} -- true = filter, false = unfilter
						
						-- In case the player has filtered multiple slots before (i.e. previous shift-clicked slot), they should be restored.
						if has_recorded_action then
							local shift_data = global.last_entity_gui_actions_by_players[player.index].shift
							if shift_data then
								local shift_slot = shift_data.slot
								-- If the current shift-clicked slot is the same as the last shift-clicked slot, nothing to do.
								if slot == shift_slot then
									return
								end
								-- We care only if the last action is filter.
								if is_filter then
									local min_slot, max_slot
									if non_shift_slot < shift_slot then
										min_slot = non_shift_slot + 1
										max_slot = shift_slot
									else
										min_slot = shift_slot
										max_slot = non_shift_slot - 1
									end
									-- If the last action is filter, we should unfilter them.
									-- If the last action is unfilter, we should filter them.
									for i = min_slot, max_slot, 1 do
										slot_actions_dict[i] = false
									end
								end
							end
						end
						
						-- Now, filter or unfilter multiple slots from the last non-shift-clicked slot to the current shift-clicked slot.
						local min_slot, max_slot
						if non_shift_slot < slot then
							if has_recorded_action then
								min_slot = non_shift_slot + 1
							else
								-- No action has been recorded, we made the record, therefore the first slot should also be updated.
								min_slot = non_shift_slot
							end
							max_slot = slot
						else
							min_slot = slot
							if has_recorded_action then
								max_slot = non_shift_slot - 1
							else
								max_slot = non_shift_slot
							end
						end
						for i = min_slot, max_slot, 1 do
							slot_actions_dict[i] = is_filter
						end
						
						-- Finalize the changes. Apply the cached actions to the actual chest filtered slots array.
						-- The records in the slot actions dictionary will be removed once they are applied. We need another dictionary to record the actions for updating GUI.
						local final_slot_actions_dict = {}
						for i = #chest_data.filtered_slots, 1, -1 do
							local filtered_slot = chest_data.filtered_slots[i]
							if slot_actions_dict[filtered_slot] == false then
								-- The slot should be unfiltered but it has been filtered.
								table.remove(chest_data.filtered_slots, i)
								final_slot_actions_dict[filtered_slot] = false
							end
							slot_actions_dict[filtered_slot] = nil						
						end
						local inventory = creative_chest_util.get_inventory_from_data(chest_data)
						local need_resort = false
						for slot, is_filter in pairs(slot_actions_dict) do
							if is_filter then
								-- The slot should be filtered but has not been filtered yet.
								table.insert(chest_data.filtered_slots, slot)
								final_slot_actions_dict[slot] = true
								-- Clear slot.
								inventory[slot].clear()
								-- Prepare to sort the array.
								need_resort = true
							end
						end
						if need_resort then
							table.sort(chest_data.filtered_slots)
						end
						
						-- Record the current shift-clicked slot for the next shift-click.
						global.last_entity_gui_actions_by_players[player.index].shift = { slot = slot }
						
						-- Update the GUI for all players who are checking the entity.
						update_entity_gui_for_all_players_checking_the_entity(entity, false, function(p, _, frame)
							if frame then
								local scroll_pane = frame[creative_mode_defines.names.gui.creative_chest_filter_scroll_pane]
								local filter_table = scroll_pane[creative_mode_defines.names.gui.creative_chest_filter_table]
								for slot, is_filter in pairs(final_slot_actions_dict) do
									local slot_button = filter_table[creative_mode_defines.names.gui.creative_chest_filter_slot_prefix .. slot]
									-- The button will be nil if the chest group is changed such that there are fewer slots then before.
									if slot_button == nil then
										break
									end
									if is_filter then
										slot_button.style = creative_mode_defines.names.gui_styles.creative_chest_filter_slot_off
									else
										slot_button.style = creative_mode_defines.names.gui_styles.creative_chest_filter_slot_on
									end
								end
							end
						end)
						return true
					end
					-- Record the slot for the next shift-click.
					global.last_entity_gui_actions_by_players = global.last_entity_gui_actions_by_players or {}
					global.last_entity_gui_actions_by_players[player.index] = {non_shift = {slot = slot}}
					
					for index, filtered_slot in ipairs(chest_data.filtered_slots) do
						if slot == filtered_slot then
							-- The slot was filtered. Now turn it back.
							table.remove(chest_data.filtered_slots, index)
							
							-- Record the action for the next shift-click.
							global.last_entity_gui_actions_by_players[player.index].non_shift.is_filter = false
							
							-- Update the GUI for all players who are checking the entity.
							update_entity_gui_for_all_players_checking_the_entity(entity, false, function(p, _, frame)
								if frame then
									local scroll_pane = frame[creative_mode_defines.names.gui.creative_chest_filter_scroll_pane]
									local filter_table = scroll_pane[creative_mode_defines.names.gui.creative_chest_filter_table]
									local slot_button = filter_table[element_name]
									slot_button.style = creative_mode_defines.names.gui_styles.creative_chest_filter_slot_on
								end
							end)
							return
						end
					end
					
					-- The slot was not filtered. Now filter it.
					table.insert(chest_data.filtered_slots, slot)
					table.sort(chest_data.filtered_slots)
					
					-- Record the action for the next shift-click.
					global.last_entity_gui_actions_by_players[player.index].non_shift.is_filter = true
					
					-- Clear the slot.
					local inventory = creative_chest_util.get_inventory_from_data(chest_data)
					inventory[slot].clear()
					
					-- Update the GUI for all players who are checking the entity.
					update_entity_gui_for_all_players_checking_the_entity(entity, false, function(p, _, frame)
						if frame then
							local scroll_pane = frame[creative_mode_defines.names.gui.creative_chest_filter_scroll_pane]
							local filter_table = scroll_pane[creative_mode_defines.names.gui.creative_chest_filter_table]
							local slot_button = filter_table[element_name]
							slot_button.style = creative_mode_defines.names.gui_styles.creative_chest_filter_slot_off
						end
					end)
				end
			end
			return true
		end
	end
	return false
end

-- Callback of the on_gui_text_changed event, extended from gui.lua.
-- Returns whether the event is consumed.
function gui_entity.on_gui_text_changed(element, element_name, player)
	local entity = global.creative_mode.player_opened_entities[player.index]
	
	if element_name == creative_mode_defines.names.gui.item_source_insert_once_to_player_amount_field then
		-- Matter source or Random item source - insert to player amount.
		local data = nil
		if entity.name == creative_mode_defines.names.entities.item_source then
			data = item_source.get_data_for_entity(entity)
		else
			data = random_item_source.get_data_for_entity(entity)
		end
		if data then
			local amount = tonumber(element.text)
			if amount then
				amount = util.clamp(math.floor(amount), 0, 1000000)
			else
				amount = 0
			end
			data.insert_to_player_amount = amount
			
			-- Update the GUI for all players who are checking the entity.
			update_entity_gui_for_all_players_checking_the_entity(entity, true, function(p, frame_container, frame)
				if frame_container then
					local insert_once_to_player_frame = frame_container[creative_mode_defines.names.gui.item_source_insert_once_to_player_frame]
					if insert_once_to_player_frame then
						local insert_once_to_player_container = insert_once_to_player_frame[creative_mode_defines.names.gui.item_source_insert_once_to_player_container]
						local insert_to_player_amount_container = insert_once_to_player_container[creative_mode_defines.names.gui.item_source_insert_once_to_player_amount_container]
						local amount_field = insert_to_player_amount_container[creative_mode_defines.names.gui.item_source_insert_once_to_player_amount_field]
						amount_field.text = amount
					end
				end
			end)
		end
		return true
	end
	return false
end

-- Callback of the on_gui_checked_state_changed event, extended from gui.lua.
-- Returns whether the event is consumed.
function gui_entity.on_gui_checked_state_changed(element, element_name, player)
	local entity = global.creative_mode.player_opened_entities[player.index]
	
	if element_name == creative_mode_defines.names.gui.duplicating_chest_lock_item_checkbox then
		-- Duplicating chest - lock item.
		local data = duplicating_chest_util.get_data_for_entity(entity)
		if data then
			data.lock_item = element.state
			if data.lock_item then
				if not data.locked_item_name then
					-- Set the item in the first slot as the locked item.
					local inventory = duplicating_chest_util.get_inventory(entity)
					local item = inventory[1]
					if item ~= nil and item.valid_for_read then
						data.locked_item_name = item.name
					end
				end
			else
				-- Reset the locked item.
				data.locked_item_name = nil
			end
			
			-- Update the GUI for all players who are checking the entity.
			update_entity_gui_for_all_players_checking_the_entity(entity, false, function(p, frame_container, frame)
				if p ~= player then
					if frame then
						local lock_item_checkbox = frame[creative_mode_defines.names.gui.duplicating_chest_lock_item_checkbox]
						lock_item_checkbox.state = element.state
					end
				end
			end)
			return true
		end
		
	---------------------------------------------------------------------------------------------------
	
	elseif element_name == creative_mode_defines.names.gui.item_source_can_insert_to_vehicle_checkbox then
		-- Matter source or Random item source - can insert to vehicle.
		local data = nil
		if entity.name == creative_mode_defines.names.entities.item_source then
			data = item_source.get_data_for_entity(entity)
		else
			data = random_item_source.get_data_for_entity(entity)
		end
		if data then
			data.can_insert_to_vehicle = element.state
			
			-- Update the GUI for all other players who are checking the entity.
			update_entity_gui_for_all_players_checking_the_entity(entity, true, function(p, frame_container, frame)
				if p ~= player then
					if frame then
						local options_container = frame[creative_mode_defines.names.gui.item_source_options_container]
						options_container[creative_mode_defines.names.gui.item_source_can_insert_to_vehicle_checkbox].state = element.state
					end
				end
			end)
		end
		
		return true
				
	elseif element_name == creative_mode_defines.names.gui.item_source_can_insert_to_player_checkbox then
		-- Matter source or Random item source - can insert to player.
		local data = nil
		if entity.name == creative_mode_defines.names.entities.item_source then
			data = item_source.get_data_for_entity(entity)
		else
			data = random_item_source.get_data_for_entity(entity)
		end
		if data then
			data.can_insert_to_player = element.state
			-- Add or remove GUI for additional options.
			-- checkbox -> options container -> frame -> frame container
			local frame_container = element.parent.parent.parent
			add_or_remove_item_source_insert_to_player_options_gui(frame_container, data)
			
			-- Update the GUI for all other players who are checking the entity.
			update_entity_gui_for_all_players_checking_the_entity(entity, true, function(p, frame_container, frame)
				if p ~= player then
					if frame then
						local options_container = frame[creative_mode_defines.names.gui.item_source_options_container]
						options_container[creative_mode_defines.names.gui.item_source_can_insert_to_player_checkbox].state = element.state
						add_or_remove_item_source_insert_to_player_options_gui(frame_container, data)
					end
				end
			end)
		end
		
		return true
		
	elseif element_name == creative_mode_defines.names.gui.item_source_can_drop_on_ground_checkbox then
		-- Matter source or Random item source - can drop on ground.
		local data = nil
		if entity.name == creative_mode_defines.names.entities.item_source then
			data = item_source.get_data_for_entity(entity)
		else
			data = random_item_source.get_data_for_entity(entity)
		end
		if data then
			data.can_drop_on_ground = element.state
			
			-- Update the GUI for all other players who are checking the entity.
			update_entity_gui_for_all_players_checking_the_entity(entity, true, function(p, frame_container, frame)
				if p ~= player then
					if frame then
						local options_container = frame[creative_mode_defines.names.gui.item_source_options_container]
						options_container[creative_mode_defines.names.gui.item_source_can_drop_on_ground_checkbox].state = element.state
					end
				end
			end)
		end
		
		return true
		
	elseif element_name == creative_mode_defines.names.gui.item_source_insert_only_once_to_player_checkbox then
		-- Matter source or Random item source - insert only once to player.
		local data = nil
		if entity.name == creative_mode_defines.names.entities.item_source then
			data = item_source.get_data_for_entity(entity)
		else
			data = random_item_source.get_data_for_entity(entity)
		end
		if data then
			data.insert_only_once_to_player = element.state
			-- Add or remove GUI for additional options.
			-- checkbox -> frame -> frame container
			local frame_container = element.parent.parent
			add_or_remove_item_source_insert_only_once_to_player_options_gui(frame_container, data)
			
			-- Update the GUI for all other players who are checking the entity.
			update_entity_gui_for_all_players_checking_the_entity(entity, true, function(p, frame_container, frame)
				if p ~= player then
					if frame_container then
						local insert_to_player_frame = frame_container[creative_mode_defines.names.gui.item_source_insert_to_player_frame]
						if insert_to_player_frame then
							insert_to_player_frame[creative_mode_defines.names.gui.item_source_insert_only_once_to_player_checkbox].state = element.state
						end
						add_or_remove_item_source_insert_only_once_to_player_options_gui(frame_container, data)
					end
				end
			end)
		end
		
		return true
		
	elseif element_name == creative_mode_defines.names.gui.item_source_insert_once_to_player_by_stack_checkbox then
		-- Matter source or Random item source - insert to player by stack.
		local data = nil
		if entity.name == creative_mode_defines.names.entities.item_source then
			data = item_source.get_data_for_entity(entity)
		else
			data = random_item_source.get_data_for_entity(entity)
		end
		if data then
			data.insert_to_player_by_stack = element.state
			
			-- Update the GUI for all players who are checking the entity.
			update_entity_gui_for_all_players_checking_the_entity(entity, true, function(p, frame_container, frame)
				if p ~= player then
					if frame_container then
						local insert_once_to_player_frame = frame_container[creative_mode_defines.names.gui.item_source_insert_once_to_player_frame]
						if insert_once_to_player_frame then
							local insert_once_to_player_container = insert_once_to_player_frame[creative_mode_defines.names.gui.item_source_insert_once_to_player_container]
							insert_once_to_player_container[creative_mode_defines.names.gui.item_source_insert_once_to_player_by_stack_checkbox].state = element.state
						end
					end
				end
			end)
		end
		
		return true
	
	---------------------------------------------------------------------------------------------------
	
	elseif element_name == creative_mode_defines.names.gui.duplicator_can_duplicate_in_vehicle_checkbox then
		-- Matter duplicator - can duplicate in vehicle.
		local data = duplicator.get_data_for_entity(entity)
		if data then
			data.can_duplicate_in_vehicle = element.state
		end
		
		-- Update the GUI for all players who are checking the entity.
		update_entity_gui_for_all_players_checking_the_entity(entity, true, function(p, frame_container, frame)
			if p ~= player then
				if frame then
					local options_container = frame[creative_mode_defines.names.gui.duplicator_options_container]
					options_container[creative_mode_defines.names.gui.duplicator_can_duplicate_in_vehicle_checkbox].state = element.state
				end
			end
		end)
		
		return true
		
	elseif element_name == creative_mode_defines.names.gui.duplicator_can_duplicate_in_player_checkbox then
		-- Matter duplicator - can duplicate in player.
		local data = duplicator.get_data_for_entity(entity)
		if data then
			data.can_duplicate_in_player = element.state
		end
		
		-- Update the GUI for all players who are checking the entity.
		update_entity_gui_for_all_players_checking_the_entity(entity, true, function(p, frame_container, frame)
			if p ~= player then
				if frame then
					local options_container = frame[creative_mode_defines.names.gui.duplicator_options_container]
					options_container[creative_mode_defines.names.gui.duplicator_can_duplicate_in_player_checkbox].state = element.state
				end
			end
		end)
		
		return true
	
	---------------------------------------------------------------------------------------------------
	
	elseif element_name == creative_mode_defines.names.gui.item_void_can_remove_from_vehicle_checkbox then
		-- Matter void - can remove from vehicle.
		local data = item_void.get_data_for_entity(entity)
		if data then
			data.can_remove_from_vehicle = element.state
		end
		
		-- Update the GUI for all players who are checking the entity.
		update_entity_gui_for_all_players_checking_the_entity(entity, true, function(p, frame_container, frame)
			if p ~= player then
				if frame then
					local options_container = frame[creative_mode_defines.names.gui.item_void_options_container]
					options_container[creative_mode_defines.names.gui.item_void_can_remove_from_vehicle_checkbox].state = element.state
				end
			end
		end)
		
		return true
		
	elseif element_name == creative_mode_defines.names.gui.item_void_can_remove_from_player_checkbox then
		-- Matter void - can remove from player.
		local data = item_void.get_data_for_entity(entity)
		if data then
			data.can_remove_from_player = element.state
		end
		
		-- Update the GUI for all players who are checking the entity.
		update_entity_gui_for_all_players_checking_the_entity(entity, true, function(p, frame_container, frame)
			if p ~= player then
				if frame then
					local options_container = frame[creative_mode_defines.names.gui.item_void_options_container]
					options_container[creative_mode_defines.names.gui.item_void_can_remove_from_player_checkbox].state = element.state
				end
			end
		end)
		
		return true
		
	elseif element_name == creative_mode_defines.names.gui.item_void_can_remove_from_ground_checkbox then
		-- Matter void - can remove from ground.
		local data = item_void.get_data_for_entity(entity)
		if data then
			data.can_remove_from_ground = element.state
		end
		
		-- Update the GUI for all players who are checking the entity.
		update_entity_gui_for_all_players_checking_the_entity(entity, true, function(p, frame_container, frame)
			if p ~= player then
				if frame then
					local options_container = frame[creative_mode_defines.names.gui.item_void_options_container]
					options_container[creative_mode_defines.names.gui.item_void_can_remove_from_ground_checkbox].state = element.state
				end
			end
		end)
		
		return true
	
	end
	
	return false
end