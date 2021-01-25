local mod_gui = require("mod-gui")

-- This file contains variables and functions related to Creative Mode menu - modding GUI.
if not gui_menu_modding then
	gui_menu_modding = {}
end

-- Gets the name of the modding menu container.
function gui_menu_modding.get_container_name()
	return creative_mode_defines.names.gui.modding_menus_container
end

-- Creates the modding menu for the given player. If the menu already exists, it will be destroyed instead.
function gui_menu_modding.create_or_destroy_menu_for_player(player)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		-- Modding container.
		local modding_menus_container = container[gui_menu_modding.get_container_name()]
		if modding_menus_container then
			modding_menus_container.destroy()
		else
			modding_menus_container =
				container.add {
				type = "flow",
				name = gui_menu_modding.get_container_name(),
				style = creative_mode_defines.names.gui_styles.no_horizontal_spacing_flow,
				direction = "horizontal",
				resize_row_to_width = true,
				minimal_width = 2000
			}

			-- Frame.
			local modding_menu_frame =
				modding_menus_container.add {
				type = "frame",
				name = creative_mode_defines.names.gui.modding_menu_frame,
				direction = "vertical",
				caption = {"gui.creative-mode_modding"}
			}

			-- Events.
			modding_menu_frame.add {
				type = "button",
				name = creative_mode_defines.names.gui.events_menu_button,
				style = creative_mode_defines.names.gui_styles.main_menu_button,
				caption = {"gui.creative-mode_events"}
			}

			-- Interfaces.
			modding_menu_frame.add {
				type = "button",
				name = creative_mode_defines.names.gui.interfaces_menu_button,
				style = creative_mode_defines.names.gui_styles.main_menu_button,
				caption = {"gui.creative-mode_interfaces"}
			}
		end
	end
end

--------------------------------------------------------------------

-- Events are separated into different categories.
local event_categories = {
	technology_related_events = {
		container_name = creative_mode_defines.names.gui.event_category_technology_container,
		label_name = creative_mode_defines.names.gui.event_category_technology_label,
		label_caption = {"gui.creative-mode_technology-related-events"},
		label_tooltip = nil,
		show_button_name = creative_mode_defines.names.gui.event_category_technology_show_button,
		hide_button_name = creative_mode_defines.names.gui.event_category_technology_hide_button,
		events = {
			defines.events.on_research_finished,
			defines.events.on_research_started
		}
	},
	item_related_events = {
		container_name = creative_mode_defines.names.gui.event_category_item_container,
		label_name = creative_mode_defines.names.gui.event_category_item_label,
		label_caption = {"gui.creative-mode_item-related-events"},
		label_tooltip = nil,
		show_button_name = creative_mode_defines.names.gui.event_category_item_show_button,
		hide_button_name = creative_mode_defines.names.gui.event_category_item_hide_button,
		events = {
			defines.events.on_picked_up_item,
			defines.events.on_player_alt_selected_area,
			defines.events.on_player_crafted_item,
			defines.events.on_player_deconstructed_area,
			defines.events.on_player_mined_item,
			defines.events.on_player_placed_equipment,
			defines.events.on_player_removed_equipment,
			defines.events.on_player_selected_area,
			defines.events.on_player_setup_blueprint,
			defines.events.on_robot_mined
		}
	},
	entity_related_events = {
		container_name = creative_mode_defines.names.gui.event_category_entity_container,
		label_name = creative_mode_defines.names.gui.event_category_entity_label,
		label_caption = {"gui.creative-mode_entity-related-events"},
		label_tooltip = nil,
		show_button_name = creative_mode_defines.names.gui.event_category_entity_show_button,
		hide_button_name = creative_mode_defines.names.gui.event_category_entity_hide_button,
		events = {
			defines.events.on_biter_base_built,
			defines.events.on_built_entity,
			defines.events.on_canceled_deconstruction,
			defines.events.script_raised_destroy,
			defines.events.on_entity_renamed,
			defines.events.on_entity_settings_pasted,
			defines.events.on_marked_for_deconstruction,
			defines.events.on_market_item_purchased,
			defines.events.on_player_alt_selected_area,
			defines.events.on_player_dropped_item,
			defines.events.on_player_mined_entity,
			defines.events.on_player_rotated_entity,
			defines.events.on_player_selected_area,
			defines.events.on_pre_entity_settings_pasted,
			defines.events.on_preplayer_mined_item,
			defines.events.on_resource_depleted,
			defines.events.script_raised_built,
			defines.events.script_raised_revive,
			defines.events.on_robot_mined,
			defines.events.on_robot_mined_entity,
			defines.events.on_rocket_launched,
			defines.events.on_sector_scanned,
			defines.events.on_selected_entity_changed,
			defines.events.on_train_changed_state,
			defines.events.on_train_created,
			defines.events.on_trigger_created_entity
		}
	},
	tile_related_events = {
		container_name = creative_mode_defines.names.gui.event_category_tile_container,
		label_name = creative_mode_defines.names.gui.event_category_tile_label,
		label_caption = {"gui.creative-mode_tile-related-events"},
		label_tooltip = nil,
		show_button_name = creative_mode_defines.names.gui.event_category_tile_show_button,
		hide_button_name = creative_mode_defines.names.gui.event_category_tile_hide_button,
		events = {
			defines.events.on_player_alt_selected_area,
			defines.events.script_raised_set_tiles,
			defines.events.on_player_mined_tile,
			defines.events.on_player_selected_area,
			defines.events.script_raised_built,
			defines.events.script_raised_destroy,
			defines.events.script_raised_revive
		}
	},
	player_related_events = {
		container_name = creative_mode_defines.names.gui.event_category_player_container,
		label_name = creative_mode_defines.names.gui.event_category_player_label,
		label_caption = {"gui.creative-mode_player-related-events"},
		label_tooltip = nil,
		show_button_name = creative_mode_defines.names.gui.event_category_player_show_button,
		hide_button_name = creative_mode_defines.names.gui.event_category_player_hide_button,
		events = {
			defines.events.on_built_entity,
			defines.events.on_canceled_deconstruction,
			defines.events.on_console_chat,
			defines.events.on_console_command,
			defines.events.on_gui_checked_state_changed,
			defines.events.on_gui_click,
			defines.events.on_gui_elem_changed,
			defines.events.on_gui_selection_state_changed,
			defines.events.on_gui_text_changed,
			defines.events.on_marked_for_deconstruction,
			defines.events.on_market_item_purchased,
			defines.events.on_picked_up_item,
			defines.events.on_player_alt_selected_area,
			defines.events.on_player_ammo_inventory_changed,
			defines.events.on_player_armor_inventory_changed,
			defines.events.script_raised_set_tiles,
			defines.events.on_player_changed_force,
			defines.events.on_player_changed_surface,
			defines.events.on_player_configured_blueprint,
			defines.events.on_player_crafted_item,
			defines.events.on_player_created,
			defines.events.on_player_cursor_stack_changed,
			defines.events.on_player_died,
			defines.events.on_player_deconstructed_area,
			defines.events.on_player_driving_changed_state,
			defines.events.on_player_dropped_item,
			defines.events.on_player_gun_inventory_changed,
			defines.events.on_player_joined_game,
			defines.events.on_player_left_game,
			defines.events.on_player_main_inventory_changed,
			defines.events.on_player_mined_entity,
			defines.events.on_player_mined_item,
			defines.events.on_player_mined_tile,
			defines.events.on_player_placed_equipment,
			defines.events.on_player_quickbar_inventory_changed,
			defines.events.on_player_removed,
			defines.events.on_player_removed_equipment,
			defines.events.on_player_respawned,
			defines.events.on_player_rotated_entity,
			defines.events.on_player_selected_area,
			defines.events.on_player_setup_blueprint,
			defines.events.on_player_tool_inventory_changed,
			defines.events.on_pre_entity_settings_pasted,
			defines.events.on_pre_player_died,
			defines.events.on_pre_player_mined_item,
			defines.events.on_pre_build,
			defines.events.on_selected_entity_changed
		}
	},
	force_related_events = {
		container_name = creative_mode_defines.names.gui.event_category_force_container,
		label_name = creative_mode_defines.names.gui.event_category_force_label,
		label_caption = {"gui.creative-mode_force-related-events"},
		label_tooltip = nil,
		show_button_name = creative_mode_defines.names.gui.event_category_force_show_button,
		hide_button_name = creative_mode_defines.names.gui.event_category_force_hide_button,
		events = {
			defines.events.script_raised_destroy,
			defines.events.on_force_created,
			defines.events.on_forces_merging,
			defines.events.on_player_changed_force
		}
	},
	surface_related_events = {
		container_name = creative_mode_defines.names.gui.event_category_surface_container,
		label_name = creative_mode_defines.names.gui.event_category_surface_label,
		label_caption = {"gui.creative-mode_surface-related-events"},
		label_tooltip = nil,
		show_button_name = creative_mode_defines.names.gui.event_category_surface_show_button,
		hide_button_name = creative_mode_defines.names.gui.event_category_surface_hide_button,
		events = {
			defines.events.on_chunk_generated,
			defines.events.on_player_changed_surface,
			defines.events.on_pre_surface_deleted,
			defines.events.on_surface_created,
			defines.events.on_surface_deleted
		}
	},
	position_related_events = {
		container_name = creative_mode_defines.names.gui.event_category_position_container,
		label_name = creative_mode_defines.names.gui.event_category_position_label,
		label_caption = {"gui.creative-mode_position-related-events"},
		label_tooltip = nil,
		show_button_name = creative_mode_defines.names.gui.event_category_position_show_button,
		hide_button_name = creative_mode_defines.names.gui.event_category_position_hide_button,
		events = {
			defines.events.on_chunk_generated,
			defines.events.on_player_alt_selected_area,
			defines.events.script_raised_set_tiles,
			defines.events.on_player_deconstructed_area,
			defines.events.on_player_mined_tile,
			defines.events.on_player_selected_area,
			defines.events.on_player_setup_blueprint,
			defines.events.on_pre_build,
			defines.events.script_raised_built,
			defines.events.script_raised_destroy,
			defines.events.on_sector_scanned
		}
	},
	gui_related_events = {
		container_name = creative_mode_defines.names.gui.event_category_gui_container,
		label_name = creative_mode_defines.names.gui.event_category_gui_label,
		label_caption = {"gui.creative-mode_gui-related-events"},
		label_tooltip = nil,
		show_button_name = creative_mode_defines.names.gui.event_category_gui_show_button,
		hide_button_name = creative_mode_defines.names.gui.event_category_gui_hide_button,
		events = {
			defines.events.on_gui_checked_state_changed,
			defines.events.on_gui_click,
			defines.events.on_gui_elem_changed,
			defines.events.on_gui_selection_state_changed,
			defines.events.on_gui_text_changed
		}
	},
	settings_related_events = {
		container_name = creative_mode_defines.names.gui.event_category_settings_container,
		label_name = creative_mode_defines.names.gui.event_category_settings_label,
		label_caption = {"gui.creative-mode_settings-related-events"},
		label_tooltip = nil,
		show_button_name = creative_mode_defines.names.gui.event_category_settings_show_button,
		hide_button_name = creative_mode_defines.names.gui.event_category_settings_hide_button,
		events = {
			defines.events.on_difficulty_settings_changed,
			defines.events.on_runtime_mod_setting_changed
		}
	},
	all_events = {
		container_name = creative_mode_defines.names.gui.event_category_all_container,
		label_name = creative_mode_defines.names.gui.event_category_all_label,
		label_caption = {"gui.creative-mode_all-events"},
		label_tooltip = nil,
		show_button_name = creative_mode_defines.names.gui.event_category_all_show_button,
		hide_button_name = creative_mode_defines.names.gui.event_category_all_hide_button,
		events = nil -- Special operation.
	}
}

-- All event names, sorted in alphabetical order.
local sorted_event_names = {}
for event_name, event_id in pairs(defines.events) do
	-- By doing this, the list is not sorted properly (maybe sorted by event_id), that's why we need to sort it our own.
	table.insert(sorted_event_names, event_name)
end
table.sort(sorted_event_names)

--------------------------------------------------------------------

-- Creates the events menu for the given player. If the menu already exists, it will be destroyed instead.
local function create_or_destroy_events_menu_for_player(player)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		local modding_menus_container = container[gui_menu_modding.get_container_name()]
		if modding_menus_container then
			-- Events.
			local events_menu_frame = modding_menus_container[creative_mode_defines.names.gui.events_menu_frame]
			if events_menu_frame then
				events_menu_frame.destroy()
			else
				-- Make sure the other menus are closed.
				local interfaces_menu_frame = modding_menus_container[creative_mode_defines.names.gui.interfaces_menu_frame]
				if interfaces_menu_frame then
					interfaces_menu_frame.destroy()
				end
				local interface_contents_and_hints_container =
					modding_menus_container[creative_mode_defines.names.gui.interface_contents_and_hints_container]
				if interface_contents_and_hints_container then
					interface_contents_and_hints_container.destroy()
				end

				-- Frame.
				events_menu_frame =
					modding_menus_container.add {
					type = "frame",
					name = creative_mode_defines.names.gui.events_menu_frame,
					direction = "vertical"
				}

				-- Title container.
				local title_container =
					events_menu_frame.add {
					type = "flow",
					name = creative_mode_defines.names.gui.events_menu_title_container,
					style = creative_mode_defines.names.gui_styles.no_horizontal_spacing_flow,
					direction = "horizontal"
				}
				-- Title label.
				title_container.add {
					type = "label",
					name = creative_mode_defines.names.gui.events_menu_title_label,
					style = creative_mode_defines.names.gui_styles.events_menu_frame_caption_label,
					caption = {"gui.creative-mode_events"}
				}
				-- Separator.
				title_container.add {
					type = "flow",
					name = creative_mode_defines.names.gui.events_menu_title_separator_1,
					style = creative_mode_defines.names.gui_styles.cheat_textfield_and_button_separate_flow
				}
				-- Search textfield. (Hidden by default)
				local search_textfield =
					title_container.add {
					type = "textfield",
					name = creative_mode_defines.names.gui.events_menu_search_textfield,
					style = creative_mode_defines.names.gui_styles.frame_search_textfield,
					text = ""
				}
				search_textfield.visible = false
				-- Search textfield placeholder.
				title_container.add {
					type = "flow",
					name = creative_mode_defines.names.gui.events_menu_search_textfield_placeholder_flow,
					style = creative_mode_defines.names.gui_styles.frame_search_textfield_placeholder_flow
				}
				-- Separator.
				title_container.add {
					type = "flow",
					name = creative_mode_defines.names.gui.events_menu_title_separator_2,
					style = creative_mode_defines.names.gui_styles.cheat_textfield_and_button_separate_flow
				}
				-- Search button.
				title_container.add {
					type = "sprite-button",
					name = creative_mode_defines.names.gui.events_menu_search_button,
					style = creative_mode_defines.names.gui_styles.frame_caption_button,
					sprite = creative_mode_defines.names.sprites.search,
					tooltip = {"gui.creative-mode_search-events"}
				}

				-- Label.
				events_menu_frame.add {
					type = "label",
					name = creative_mode_defines.names.gui.events_menu_label,
					caption = {"gui.creative-mode_select-events-to-print"}
				}

				-- Scroll pane.
				local scroll_pane =
					events_menu_frame.add {
					type = "scroll-pane",
					name = creative_mode_defines.names.gui.events_scroll_pane,
					style = creative_mode_defines.names.gui_styles.cheat_scroll_pane
				}

				-- Container (no vertical spacing).
				local inner_container =
					scroll_pane.add {
					type = "flow",
					name = creative_mode_defines.names.gui.events_inner_container,
					style = creative_mode_defines.names.gui_styles.no_vertical_spacing_resize_row_flow,
					direction = "vertical"
				}

				-- Events.
				for _, event_name in ipairs(sorted_event_names) do
					local event_id = defines.events[event_name]
					-- We don't print on_tick as it will be too spammy.
					if event_id ~= defines.events.on_tick then
						-- Container.
						local event_container =
							inner_container.add {
							type = "table",
							name = creative_mode_defines.names.gui.event_container_prefix .. event_id,
							style = creative_mode_defines.names.gui_styles.cheat_table,
							column_count = 1
						}
						-- Checkbox.
						event_container.add {
							type = "checkbox",
							name = creative_mode_defines.names.gui.event_toggle_checkbox_prefix .. event_id,
							caption = event_name,
							state = (global.creative_mode.selected_events[player.index] and
								global.creative_mode.selected_events[player.index][event_id]) or
								false
						}
					end
				end

				-- Enable all and disable all buttons.
				local button_container =
					inner_container.add {
					type = "table",
					name = creative_mode_defines.names.gui.events_all_button_container,
					style = creative_mode_defines.names.gui_styles.cheat_enable_disable_all_table,
					column_count = 2
				}
				button_container.add {
					type = "button",
					name = creative_mode_defines.names.gui.events_enable_all_button,
					style = creative_mode_defines.names.gui_styles.cheat_enable_disable_all_button,
					caption = creative_mode_defines.names.gui_captions.enable_all
				}
				button_container.add {
					type = "button",
					name = creative_mode_defines.names.gui.events_disable_all_button,
					style = creative_mode_defines.names.gui_styles.cheat_enable_disable_all_button,
					caption = creative_mode_defines.names.gui_captions.disable_all
				}
			end

			-- Event categories and options.
			local event_categories_and_options_container =
				modding_menus_container[creative_mode_defines.names.gui.event_categories_and_options_container]
			if event_categories_and_options_container then
				event_categories_and_options_container.destroy()
			else
				event_categories_and_options_container =
					modding_menus_container.add {
					type = "flow",
					name = creative_mode_defines.names.gui.event_categories_and_options_container,
					style = creative_mode_defines.names.gui_styles.no_vertical_spacing_resize_row_flow,
					direction = "vertical"
				}

				-- Event categories.
				-- Frame.
				local event_categories_frame =
					event_categories_and_options_container.add {
					type = "frame",
					name = creative_mode_defines.names.gui.event_categories_frame,
					direction = "vertical",
					caption = {"gui.creative-mode_categories"}
				}

				-- Categories.
				for _, data in pairs(event_categories) do
					-- Container
					local category_container =
						event_categories_frame.add {
						type = "table",
						name = data.container_name,
						style = creative_mode_defines.names.gui_styles.cheat_table,
						column_count = 3
					}
					-- Label
					category_container.add {
						type = "label",
						name = data.label_name,
						style = creative_mode_defines.names.gui_styles.cheat_name_label,
						caption = data.label_caption,
						tooltip = data.label_tooltip
					}
					-- Show button
					category_container.add {
						type = "button",
						name = data.show_button_name,
						style = creative_mode_defines.names.gui_styles.cheat_on_off_button_off,
						caption = creative_mode_defines.names.gui_captions.show
					}
					-- Hide button
					category_container.add {
						type = "button",
						name = data.hide_button_name,
						style = creative_mode_defines.names.gui_styles.cheat_on_off_button_off,
						caption = creative_mode_defines.names.gui_captions.hide
					}
				end

				-- Options.
				-- Frame.
				local options_frame =
					event_categories_and_options_container.add {
					type = "frame",
					name = creative_mode_defines.names.gui.event_options_frame,
					direction = "vertical",
					caption = {"gui.creative-mode_options"}
				}

				-- Container.
				local event_options_container =
					options_frame.add {
					type = "table",
					name = creative_mode_defines.names.gui.event_options_container,
					column_count = 2
				}
				-- Print events checkbox.
				local state = true
				if global.creative_mode.print_events[player.index] ~= nil then
					state = global.creative_mode.print_events[player.index]
				end
				event_options_container.add {
					type = "checkbox",
					name = creative_mode_defines.names.gui.event_option_print_events_checkbox,
					caption = {"gui.creative-mode_print-events"},
					tooltip = {"gui.creative-mode_print-events-tooltip"},
					state = state
				}
				-- Also print event parameters checkbox.
				state = true
				if global.creative_mode.also_print_event_params[player.index] ~= nil then
					state = global.creative_mode.also_print_event_params[player.index]
				end
				event_options_container.add {
					type = "checkbox",
					name = creative_mode_defines.names.gui.event_option_print_parameters_checkbox,
					caption = {"gui.creative-mode_also-print-parameters"},
					state = state
				}

				-- Write events checkbox.
				state = false
				if global.creative_mode.write_events[player.index] ~= nil then
					state = global.creative_mode.write_events[player.index]
				end
				event_options_container.add {
					type = "checkbox",
					name = creative_mode_defines.names.gui.event_option_write_events_checkbox,
					caption = {"gui.creative-mode_write-events"},
					tooltip = {"gui.creative-mode_write-events-tooltip", "script-output/" .. events.event_write_file_name},
					state = state
				}
				-- Also write event parameters checkbox.
				state = true
				if global.creative_mode.also_write_event_params[player.index] ~= nil then
					state = global.creative_mode.also_write_event_params[player.index]
				end
				event_options_container.add {
					type = "checkbox",
					name = creative_mode_defines.names.gui.event_option_write_parameters_checkbox,
					caption = {"gui.creative-mode_also-write-parameters"},
					state = state
				}

				-- Log events checkbox.
				state = false
				if global.creative_mode.log_events[player.index] ~= nil then
					state = global.creative_mode.log_events[player.index]
				end
				event_options_container.add {
					type = "checkbox",
					name = creative_mode_defines.names.gui.event_option_log_events_checkbox,
					caption = {"gui.creative-mode_log-events"},
					tooltip = {"gui.creative-mode_log-events-tooltip", "factorio-current.log"},
					state = state
				}
				-- Also log event parameters checkbox.
				state = true
				if global.creative_mode.also_log_event_params[player.index] ~= nil then
					state = global.creative_mode.also_log_event_params[player.index]
				end
				event_options_container.add {
					type = "checkbox",
					name = creative_mode_defines.names.gui.event_option_log_parameters_checkbox,
					caption = {"gui.creative-mode_also-log-parameters"},
					state = state
				}
			end
		end
	end
end

-- Enables or disables all visible event log for the given player.
local function enable_or_disable_all_visible_events_for_player(player, is_enable)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		local modding_menus_container = container[gui_menu_modding.get_container_name()]
		if modding_menus_container then
			local events_menu_frame = modding_menus_container[creative_mode_defines.names.gui.events_menu_frame]
			if events_menu_frame then
				local scroll_pane = events_menu_frame[creative_mode_defines.names.gui.events_scroll_pane]
				local inner_container = scroll_pane[creative_mode_defines.names.gui.events_inner_container]

				for event_name, event_id in pairs(defines.events) do
					-- Container
					local event_container = inner_container[creative_mode_defines.names.gui.event_container_prefix .. event_id]
					if event_container and (event_container.visible == nil or event_container.visible == true) then
						if not global.creative_mode.selected_events[player.index] then
							global.creative_mode.selected_events[player.index] = {}
						end
						if is_enable then
							global.creative_mode.selected_events[player.index][event_id] = true
							-- Checkbox.
							event_container[creative_mode_defines.names.gui.event_toggle_checkbox_prefix .. event_id].state = true
						else
							global.creative_mode.selected_events[player.index][event_id] = nil
							-- Checkbox.
							event_container[creative_mode_defines.names.gui.event_toggle_checkbox_prefix .. event_id].state = false
						end
					end
				end
			end
		end
	end
end

-- Shows or hides the given events for the given player.
-- If no events (nil) is given, all events will be affected.
local function show_or_hide_events_for_player(player, events, is_show)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		local modding_menus_container = container[gui_menu_modding.get_container_name()]
		if modding_menus_container then
			local events_menu_frame = modding_menus_container[creative_mode_defines.names.gui.events_menu_frame]
			if events_menu_frame then
				local scroll_pane = events_menu_frame[creative_mode_defines.names.gui.events_scroll_pane]
				local inner_container = scroll_pane[creative_mode_defines.names.gui.events_inner_container]

				if events == nil then
					-- All events.
					events = defines.events
				end
				for event_name, event_id in pairs(events) do
					local event_container = inner_container[creative_mode_defines.names.gui.event_container_prefix .. event_id]
					if event_container then
						event_container.visible = is_show
					end
				end
			end
		end
	end
end

-- Shows the events whose names match the given search name for the given player.
-- If no search name (nil or empty string) is given, all events will be shown.
local function show_events_for_player_by_search_name(player, search_name)
	if search_name == nil or search_name == "" then
		show_or_hide_events_for_player(player, nil, true)
		return
	end

	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		local modding_menus_container = container[gui_menu_modding.get_container_name()]
		if modding_menus_container then
			local events_menu_frame = modding_menus_container[creative_mode_defines.names.gui.events_menu_frame]
			if events_menu_frame then
				local scroll_pane = events_menu_frame[creative_mode_defines.names.gui.events_scroll_pane]
				local inner_container = scroll_pane[creative_mode_defines.names.gui.events_inner_container]

				for event_name, event_id in pairs(defines.events) do
					local event_container = inner_container[creative_mode_defines.names.gui.event_container_prefix .. event_id]
					if event_container then
						if string.find(event_name, search_name) then
							event_container.visible = true
						else
							event_container.visible = false
						end
					end
				end
			end
		end
	end
end

--------------------------------------------------------------------

-- The table of registered remote functions so they are callable via the modding UI.
-- The structure of this table will be like this:
--[[
{
	["interface-name-1"] =
	{
		["function_name_1"] = {},
		["function_name_2"] = {caption = "...", tooltip = "..."},
	},

	["interface-name-2"] =
	{
		["function_name_1"] = {caption = "..."}
	}
}
--]]
local registered_remote_functions = {}

----

-- Creates the interfaces menu for the given player. If the menu already exists, it will be destroyed instead.
local function create_or_destroy_interfaces_menu_for_player(player)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		local modding_menus_container = container[gui_menu_modding.get_container_name()]
		if modding_menus_container then
			-- Interfaces.
			local interfaces_menu_frame = modding_menus_container[creative_mode_defines.names.gui.interfaces_menu_frame]
			if interfaces_menu_frame then
				interfaces_menu_frame.destroy()
			else
				-- Make sure the other menus are closed.
				local events_menu_frame = modding_menus_container[creative_mode_defines.names.gui.events_menu_frame]
				if events_menu_frame then
					events_menu_frame.destroy()
				end
				local event_categories_and_options_container =
					modding_menus_container[creative_mode_defines.names.gui.event_categories_and_options_container]
				if event_categories_and_options_container then
					event_categories_and_options_container.destroy()
				end

				-- Frame.
				interfaces_menu_frame =
					modding_menus_container.add {
					type = "frame",
					name = creative_mode_defines.names.gui.interfaces_menu_frame,
					direction = "vertical",
					caption = {"gui.creative-mode_interfaces"}
				}

				-- Label.
				interfaces_menu_frame.add {
					type = "label",
					name = creative_mode_defines.names.gui.interfaces_menu_label,
					caption = {"gui.creative-mode_select-remote-interfaces-to-check-contents"},
					tooltip = {"gui.creative-mode_select-remote-interfaces-to-check-contents-tooltip"}
				}

				-- Scroll pane.
				local scroll_pane =
					interfaces_menu_frame.add {
					type = "scroll-pane",
					name = creative_mode_defines.names.gui.interfaces_scroll_pane,
					style = creative_mode_defines.names.gui_styles.interfaces_scroll_pane
				}

				-- Container (no vertical spacing).
				local inner_container =
					scroll_pane.add {
					type = "flow",
					name = creative_mode_defines.names.gui.interfaces_inner_container,
					style = creative_mode_defines.names.gui_styles.no_vertical_spacing_resize_row_flow,
					direction = "vertical"
				}

				-- Interfaces.
				for interface_name, interface_contents in pairs(remote.interfaces) do
					-- Button.
					inner_container.add {
						type = "button",
						name = creative_mode_defines.names.gui.interface_button_prefix .. interface_name,
						style = creative_mode_defines.names.gui_styles.interface_button,
						caption = interface_name
					}
				end
			end

			-- Interface contents and hints.
			local interface_contents_and_hints_container =
				modding_menus_container[creative_mode_defines.names.gui.interface_contents_and_hints_container]
			if interface_contents_and_hints_container then
				interface_contents_and_hints_container.destroy()
			else
				-- Container. (Create it first, but hide it.)
				interface_contents_and_hints_container =
					modding_menus_container.add {
					type = "flow",
					name = creative_mode_defines.names.gui.interface_contents_and_hints_container,
					style = creative_mode_defines.names.gui_styles.no_vertical_spacing_resize_row_flow,
					direction = "vertical"
				}
				interface_contents_and_hints_container.visible = false

				-- Interface contents. (Create the frame first, but hide it.)
				local interface_contents_frame =
					interface_contents_and_hints_container.add {
					type = "frame",
					name = creative_mode_defines.names.gui.interface_contents_frame,
					direction = "vertical",
					caption = ""
				}
				interface_contents_frame.style.minimal_width = 300

				-- Interface hints.
				local interface_hints_frame =
					interface_contents_and_hints_container.add {
					type = "frame",
					name = creative_mode_defines.names.gui.interface_hints_frame,
					direction = "vertical",
					caption = {"gui.creative-mode_hints"}
				}
				-- Can register remote function hint.
				interface_hints_frame.add {
					type = "label",
					name = creative_mode_defines.names.gui.interface_can_register_remote_function_label,
					caption = {"gui.creative-mode_can-register-remote-function"},
					tooltip = {
						"gui.creative-mode_can-register-remote-function-tooltip-1",
						{"gui.creative-mode_can-register-remote-function-tooltip-2", "creative_mode_"},
						{
							"gui.creative-mode_can-register-remote-function-tooltip-3",
							remote_interface.register_remote_function_name,
							remote_interface.deregister_remote_function_name
						},
						{"gui.creative-mode_can-register-remote-function-tooltip-4"}
					}
				}
			end
		end
	end
end

-- Adds the contents of the interface of given name to the given frame for the given player.
-- Make sure the frame is visible before calling this method.
local function add_interface_contents_to_frame_for_player(player, interface_name, frame)
	-- Get the actual interface.
	local interface = remote.interfaces[interface_name]
	if interface then
		-- Scroll pane.
		local scroll_pane =
			frame.add {
			type = "scroll-pane",
			name = creative_mode_defines.names.gui.interface_contents_scroll_pane,
			style = creative_mode_defines.names.gui_styles.interface_contents_scroll_pane
		}
		-- Container.
		local interface_contents_container =
			scroll_pane.add {
			type = "flow",
			name = creative_mode_defines.names.gui.interface_contents_container,
			style = creative_mode_defines.names.gui_styles.no_vertical_spacing_resize_row_flow,
			direction = "vertical"
		}

		-- Show the functions.
		for content_name, content in pairs(interface) do
			-- Note: it is meaningless to check the type of content by type(content). They are all Booleans.
			-- Button or label?
			local registered_remote_function_data = nil
			if registered_remote_functions[interface_name] then
				registered_remote_function_data = registered_remote_functions[interface_name][content_name]
			end
			if util.string_starts_with(content_name, "creative_mode_") or registered_remote_function_data then
				-- Button.
				interface_contents_container.add {
					type = "button",
					name = creative_mode_defines.names.gui.interface_contents_button_prefix .. content_name,
					style = creative_mode_defines.names.gui_styles.interface_content_button,
					caption = (registered_remote_function_data and registered_remote_function_data.caption) or content_name,
					tooltip = registered_remote_function_data and registered_remote_function_data.tooltip
				}
			else
				-- Label.
				interface_contents_container.add {
					type = "label",
					name = creative_mode_defines.names.gui.interface_contents_label_prefix .. content_name,
					caption = content_name
				}
			end
		end
	else
		-- The interface does not exist anymore!
		frame.add {
			type = "label",
			name = creative_mode_defines.names.gui.interface_contents_label_prefix .. 1,
			caption = {"gui.creative-mode_interface-does-not-exist-anymore"}
		}
	end
end

-- Removes all interface contents on GUI and adds back them for the given player, if he/she has opened such GUI.
local function refresh_interface_contents_on_gui_for_player(player)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		local modding_menus_container = container[gui_menu_modding.get_container_name()]
		if modding_menus_container then
			local interface_contents_and_hints_container =
				modding_menus_container[creative_mode_defines.names.gui.interface_contents_and_hints_container]
			if interface_contents_and_hints_container and interface_contents_and_hints_container.visible ~= false then
				local interface_contents_frame =
					interface_contents_and_hints_container[creative_mode_defines.names.gui.interface_contents_frame]
				if interface_contents_frame and interface_contents_frame.visible ~= false then
					-- Remove.
					for _, child_name in pairs(interface_contents_frame.children_names) do
						interface_contents_frame[child_name].destroy()
					end
					-- Add back.
					add_interface_contents_to_frame_for_player(player, interface_contents_frame.caption, interface_contents_frame)
				end
			end
		end
	end
end

-- Removes all interface contents on GUI and adds back them for all players.
local function refresh_interface_contents_on_gui_for_all_players()
	-- This function may be called before the game is ready.
	if not game or not game.players then
		return
	end

	for _, player in pairs(game.players) do
		refresh_interface_contents_on_gui_for_player(player)
	end
end

-- Shows the interface contents UI for the given player. If the UI is already visible, it will be hidden instead.
local function show_or_hide_interface_contents_for_player(player, interface_name)
	local left = mod_gui.get_frame_flow(player)
	local container = left[creative_mode_defines.names.gui.main_menu_container]
	if container then
		local modding_menus_container = container[gui_menu_modding.get_container_name()]
		if modding_menus_container then
			local interface_contents_and_hints_container =
				modding_menus_container[creative_mode_defines.names.gui.interface_contents_and_hints_container]
			if interface_contents_and_hints_container then
				local interface_contents_frame =
					interface_contents_and_hints_container[creative_mode_defines.names.gui.interface_contents_frame]
				if interface_contents_and_hints_container.visible ~= false then
					-- It is already visible.
					if interface_contents_frame.caption == interface_name then
						-- It is already showing the given interface.
						-- Hide it.
						interface_contents_and_hints_container.visible = false
						return
					end
				end

				-- Update the contents according to the given interface name.
				interface_contents_and_hints_container.visible = true
				interface_contents_frame.caption = interface_name
				-- Remove all children inside the frame.
				for _, child_name in pairs(interface_contents_frame.children_names) do
					interface_contents_frame[child_name].destroy()
				end
				-- Add contents.
				add_interface_contents_to_frame_for_player(player, interface_name, interface_contents_frame)
			end
		end
	end
end

--------------------------------------------------------------------

-- Registers or deregisters the given remote function in the given interface.
-- Returns whether the deregisteration is success.
function gui_menu_modding.register_or_deregister_remote_function(
	interface_name,
	function_name,
	is_register,
	additional_data)
	if is_register then
		-- Register.
		if not registered_remote_functions[interface_name] then
			registered_remote_functions[interface_name] = {}
		end
		registered_remote_functions[interface_name][function_name] = additional_data or {}
		refresh_interface_contents_on_gui_for_all_players()
		return nil
	else
		-- Deregister.
		if not registered_remote_functions[interface_name] then
			-- No such interface.
			return false
		end
		if not registered_remote_functions[interface_name][function_name] then
			-- No such function.
			return false
		end
		registered_remote_functions[interface_name][function_name] = nil
		refresh_interface_contents_on_gui_for_all_players()
		return true
	end
end

-- Returns whether the given remote function in the given function has been registered.
function gui_menu_modding.has_registered_remote_function(interface_name, function_name)
	if not registered_remote_functions[interface_name] then
		-- No such interface.
		return false
	end
	if not registered_remote_functions[interface_name][function_name] then
		-- No such function.
		return false
	end
	return true
end

--------------------------------------------------------------------

-- Callback of the on_gui_click event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_modding.on_gui_click(element, element_name, player, button, alt, control, shift)
	if element_name == creative_mode_defines.names.gui.events_menu_button then
		-- Events menu button.
		create_or_destroy_events_menu_for_player(player)
		return true
	elseif element_name == creative_mode_defines.names.gui.interfaces_menu_button then
		---------------------------------------------------------------------------------------------------
		-- Interfaces menu button.
		create_or_destroy_interfaces_menu_for_player(player)
		return true
	elseif element_name == creative_mode_defines.names.gui.events_menu_search_button then
		-- Events - search button.
		-- button -> title container.
		local title_container = element.parent
		local search_textfield = title_container[creative_mode_defines.names.gui.events_menu_search_textfield]
		local search_textfield_placeholder =
			title_container[creative_mode_defines.names.gui.events_menu_search_textfield_placeholder_flow]

		if search_textfield.visible then
			-- Hide the search textfield.
			search_textfield.visible = false
			search_textfield_placeholder.visible = true
			-- Reset search text and show all events.
			search_textfield.text = ""
			show_events_for_player_by_search_name(player, nil)
		else
			-- Show the search textfield.
			search_textfield.visible = true
			search_textfield_placeholder.visible = false
		end
		return true
	elseif element_name == creative_mode_defines.names.gui.events_enable_all_button then
		-- Events - enable all button.
		enable_or_disable_all_visible_events_for_player(player, true)
		return true
	elseif element_name == creative_mode_defines.names.gui.events_disable_all_button then
		---------------------------------------------------------------------------------------------------
		-- Events - disable all button.
		enable_or_disable_all_visible_events_for_player(player, false)
		return true
	else
		for _, data in pairs(event_categories) do
			if element_name == data.show_button_name then
				-- Event category show button.
				show_or_hide_events_for_player(player, data.events, true)
				return true
			elseif element_name == data.hide_button_name then
				-- Event category hide button.
				show_or_hide_events_for_player(player, data.events, false)
				return true
			end
		end
	end

	---------------------------------------------------------------------------------------------------

	if element.parent and element.parent.name == creative_mode_defines.names.gui.interfaces_inner_container then
		-- Interface button.
		local interface_name = string.match(element_name, creative_mode_defines.match_patterns.gui.interface_button)
		if interface_name ~= nil then
			interface_name = tostring(interface_name)
			show_or_hide_interface_contents_for_player(player, interface_name)
			return true
		end
		return true
	end

	---------------------------------------------------------------------------------------------------

	if element.parent and element.parent.name == creative_mode_defines.names.gui.interface_contents_container then
		-- Interface content button.
		-- button -> table -> scroll-pane -> frame.
		local scroll_pane = element.parent.parent
		if scroll_pane then
			local frame = scroll_pane.parent
			if frame then
				local interface_name = frame.caption
				local interface = remote.interfaces[interface_name]
				if interface then
					local function_name =
						string.match(element_name, creative_mode_defines.match_patterns.gui.interface_contents_button)
					if function_name ~= nil then
						if interface[function_name] then
							-- Call the function.
							remote.call(
								interface_name,
								function_name,
								{
									player_index = player.index,
									creative_mode_modding = true
								}
							)
						else
							-- The function does not exist anymore.
							element.destroy()
						end
					end
				else
					-- The interface does not exists anymore.
					refresh_interface_contents_on_gui_for_player(player)
				end
			end
		end
		return true
	end

	return false
end

-- Callback of the on_gui_text_changed event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_modding.on_gui_text_changed(element, element_name, player)
	if element_name == creative_mode_defines.names.gui.events_menu_search_textfield then
		-- Events - search event name.
		show_events_for_player_by_search_name(player, element.text)
		return true
	end
	return false
end

-- Callback of the on_gui_checked_state_changed event, extended from gui-menu.lua.
-- Returns whether the event is consumed.
function gui_menu_modding.on_gui_checked_state_changed(element, element_name, player)
	if element_name == creative_mode_defines.names.gui.event_option_print_events_checkbox then
		-- Event options - print events.
		global.creative_mode.print_events[player.index] = element.state
		return true
	elseif element_name == creative_mode_defines.names.gui.event_option_print_parameters_checkbox then
		-- Event options - also print event parameters.
		global.creative_mode.also_print_event_params[player.index] = element.state
		return true
	elseif element_name == creative_mode_defines.names.gui.event_option_write_events_checkbox then
		-- Event options - write events.
		global.creative_mode.write_events[player.index] = element.state
		return true
	elseif element_name == creative_mode_defines.names.gui.event_option_write_parameters_checkbox then
		-- Event options - also write event parameters.
		global.creative_mode.also_write_event_params[player.index] = element.state
		return true
	elseif element_name == creative_mode_defines.names.gui.event_option_log_events_checkbox then
		-- Event options - log events.
		global.creative_mode.log_events[player.index] = element.state
		return true
	elseif element_name == creative_mode_defines.names.gui.event_option_log_parameters_checkbox then
		---------------------------------------------------------------------------------------------------
		-- Event options - also log event parameters.
		global.creative_mode.also_log_event_params[player.index] = element.state
		return true
	elseif
		element.parent and element.parent.parent and
			element.parent.parent.name == creative_mode_defines.names.gui.events_inner_container
	 then
		local event_id = string.match(element_name, creative_mode_defines.match_patterns.gui.event_toggle_checkbox)
		if event_id ~= nil then
			-- Event toggle.
			event_id = tonumber(event_id)
			if not global.creative_mode.selected_events[player.index] then
				global.creative_mode.selected_events[player.index] = {}
			end
			if element.state then
				global.creative_mode.selected_events[player.index][event_id] = true
			else
				global.creative_mode.selected_events[player.index][event_id] = nil
			end
		end
		return true
	end

	return false
end
