-- Makes and returns a graphical set according to the given properties.
local function extract_monolith(file_name, x, y, width, height)
	return {
		filename = creative_mode_defines.mod_directory .. "/graphics/gui/" .. file_name,
		position = {x, y},
		size = {width, height},
		scale = 1,
		border = 1
	}
end
-- Create styles.
local default_style = data.raw["gui-style"].default
local default_horizontal_spacing = 8
local slider_button_width = 10
local slider_button_height = 18
local slider_textfield_width = 60
local cheat_all_height = 500
local cheat_selection_width = 160
local cheat_selection_button_height = 25
local cheat_selection_min_height = 400
local cheat_width = 350
local cheat_label_width = 200
local cheat_on_off_button_width = (cheat_width - cheat_label_width) / 2
local cheat_on_off_button_height = cheat_selection_button_height
local cheat_value_drop_down_height = cheat_on_off_button_height * 4
local magic_wand_popup_height = 300
local access_right_on_off_button_width = 300
local inventory_slot_width = 36
local big_button_width_height = 36
local magic_wand_popup_slot_table_width = inventory_slot_width * 10 + 9
local frame_caption_button_width = default_style["search_button"].size -- search_button_style with in base mod.
local search_textfield_width = default_style["search_textfield_with_fixed_width"].width
local quick_action_remove_button_width = 18
local magic_wand_popup_left_frame_caption_width = magic_wand_popup_slot_table_width - frame_caption_button_width
local magic_wand_popup_right_frame_caption_width = cheat_width - frame_caption_button_width
local events_menu_frame_width = cheat_width + 15 + 8
local events_menu_frame_caption_label_width =
	events_menu_frame_width - default_horizontal_spacing - search_textfield_width - default_horizontal_spacing -
	frame_caption_button_width

local creative_chest_item_group_left_right_button_width = 20
local creative_chest_item_group_number_label_width = 60

-- Flow style with resize to row height.
default_style[creative_mode_defines.names.gui_styles.resize_col_flow] = {
	type = "horizontal_flow_style",
	parent = "horizontal_flow",
	resize_to_row_height = true
}
-- Flow style with no horizontal spacing.
default_style[creative_mode_defines.names.gui_styles.no_horizontal_spacing_flow] = {
	type = "horizontal_flow_style",
	parent = "horizontal_flow",
	horizontal_spacing = 0
}
-- Flow style with no horizontal spacing and resize to row height.
default_style[creative_mode_defines.names.gui_styles.no_horizontal_spacing_resize_col_flow] = {
	type = "horizontal_flow_style",
	parent = creative_mode_defines.names.gui_styles.no_horizontal_spacing_flow,
	resize_to_row_height = true
}
-- Flow style with no vertical spacing and resize row to width.
default_style[creative_mode_defines.names.gui_styles.no_vertical_spacing_resize_row_flow] = {
	type = "vertical_flow_style",
	parent = "vertical_flow",
	vertical_spacing = 0,
	resize_row_to_width = true
}

--------------------------------------------------------------------

-- Longer dialog button, but still shorter than menu button.
default_style[creative_mode_defines.names.gui_styles.long_dialog_button] = {
	type = "button_style",
	parent = "dialog_button",
	minimal_width = 200
}
-- Single-lined height, no fixed width button style with default-bold font.
default_style[creative_mode_defines.names.gui_styles.small_default_bold_button] = {
	type = "button_style",
	parent = "button",
	font = "default-bold",
	height = cheat_on_off_button_height,
	top_padding = 0,
	bottom_padding = 0,
	left_click_sound = {
		{
			filename = "__core__/sound/gui-click.ogg",
			volume = 1
		}
	}
}
-- The style for the search textfield besides the frame title.
default_style[creative_mode_defines.names.gui_styles.frame_search_textfield] = {
	type = "textbox_style",
	parent = "search_textfield_with_fixed_width",
	width = search_textfield_width,
	scalable = false
}
-- The style for the placeholder flow when search textfield is not visible.
default_style[creative_mode_defines.names.gui_styles.frame_search_textfield_placeholder_flow] = {
	type = "horizontal_flow_style",
	parent = "horizontal_flow",
	width = search_textfield_width,
	scalable = false
}

--------------------------------------------------------------------

-- The main menu open button style.
default_style[creative_mode_defines.names.gui_styles.main_menu_open_button] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.entity_open_button,
	default_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 0,
		big_button_width_height * 0,
		big_button_width_height,
		big_button_width_height
	),
	hovered_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 1,
		big_button_width_height * 0,
		big_button_width_height,
		big_button_width_height
	),
	clicked_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 2,
		big_button_width_height * 0,
		big_button_width_height,
		big_button_width_height
	),
	disabled_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 3,
		big_button_width_height * 0,
		big_button_width_height,
		big_button_width_height
	)
}
-- The style for main menu buttons.
default_style[creative_mode_defines.names.gui_styles.main_menu_button] = {
	type = "button_style",
	parent = "button",
	width = 150,
	left_click_sound = {
		{
			filename = "__core__/sound/gui-click.ogg",
			volume = 1
		}
	}
}

--------------------------------------------------------------------

-- Frame style without graphic set and with a small, orange title.
default_style[creative_mode_defines.names.gui_styles.naked_small_orange_title_frame] = {
	type = "frame_style",
	parent = "inner_frame",
	font = "default-bold",
	font_color = default_orange_color
}
-- Frame style with just a white line at the right and a small, orange title.
default_style[creative_mode_defines.names.gui_styles.small_orange_title_with_right_border_frame] = {
	type = "frame_style",
	parent = creative_mode_defines.names.gui_styles.naked_small_orange_title_frame,
	right_padding = 1,
	graphical_set = {
		type = "composition",
		filename = creative_mode_defines.mod_directory .. "/graphics/gui/right-border.png",
		priority = "extra-high-no-scale",
		corner_size = {1, 1},
		position = {0, 0}
	}
}

--------------------------------------------------------------------

-- Table style with scalable equal to false and no horizontal or vertical spacing.
default_style[creative_mode_defines.names.gui_styles.unscalable_no_spacing_table] = {
	type = "table_style",
	parent = "table",
	horizontal_spacing = 0,
	vertical_spacing = 0,
	scalable = false
}
-- Style for the label in slot button.
-- Note: it is impossible to replicate the vanilla item count label, as the label will block raycast.
default_style[creative_mode_defines.names.gui_styles.slot_button_label] = {
	type = "label_style",
	parent = "label",
	font = "default-small-bold",
	align = "left",
	width = inventory_slot_width,
	height = inventory_slot_width
}

--------------------------------------------------------------------

-- Style for turned-on slider buttons.
default_style[creative_mode_defines.names.gui_styles.slider_button_on] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.slider_button_off,
	default_graphical_set = {
		type = "composition",
		filename = "__core__/graphics/gui.png",
		priority = "extra-high-no-scale",
		corner_size = {3, 3},
		position = {0, 8}
	}
}

-- Style for turned-off slider buttons.
default_style[creative_mode_defines.names.gui_styles.slider_button_off] = {
	type = "button_style",
	parent = "button",
	scalable = false,
	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
	width = slider_button_width,
	height = slider_button_height,
	left_click_sound = {
		{
			filename = "__core__/sound/list-box-click.ogg",
			volume = 1
		}
	}
}

-- Style for slider textfields.
default_style[creative_mode_defines.names.gui_styles.slider_textfield] = {
	type = "textbox_style",
	parent = "slider_value_textfield",
	width = slider_textfield_width,
	scalable = false
}

--------------------------------------------------------------------

-- The style for cheat scoll pane.
default_style[creative_mode_defines.names.gui_styles.cheat_scroll_pane] = {
	type = "scroll_pane_style",
	parent = "scroll_pane",
	maximal_height = cheat_all_height,
	scalable = false,
	vertical_scroll_bar_spacing = 0
}
-- The style for cheat target selection frame that contains all cheat target options.
default_style[creative_mode_defines.names.gui_styles.cheat_target_selection_container_frame] = {
	type = "frame_style",
	parent = "frame",
	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
	minimal_height = cheat_selection_min_height,
	scalable = false,
	graphical_set = {
		type = "composition",
		filename = creative_mode_defines.mod_directory .. "/graphics/gui/" .. "black.png",
		priority = "extra-high-no-scale",
		corner_size = 1,
		position = {0, 0}
	}
}
-- The style for selected cheat target (not self) button.
default_style[creative_mode_defines.names.gui_styles.cheat_target_selected_button] = {
	type = "button_style",
	parent = "button",
	align = "left",
	top_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
	right_padding = 0,
	width = cheat_selection_width,
	height = cheat_selection_button_height,
	scalable = false,
	default_font_color = {r = 1, g = 1, b = 1},
	default_graphical_set = {
		type = "composition",
		filename = creative_mode_defines.mod_directory .. "/graphics/gui/" .. "orange.png",
		priority = "extra-high-no-scale",
		corner_size = 1,
		position = {0, 0}
	},
	hovered_font_color = {r = 1, g = 1, b = 1},
	hovered_graphical_set = {
		type = "composition",
		filename = creative_mode_defines.mod_directory .. "/graphics/gui/" .. "orange.png",
		priority = "extra-high-no-scale",
		corner_size = 1,
		position = {0, 0}
	},
	clicked_font_color = {r = 1, g = 1, b = 1},
	clicked_graphical_set = {
		type = "composition",
		filename = creative_mode_defines.mod_directory .. "/graphics/gui/" .. "orange.png",
		priority = "extra-high-no-scale",
		corner_size = 1,
		position = {0, 0}
	},
	disabled_font_color = {r = 0.5, g = 0.5, b = 0.5},
	disabled_graphical_set = {
		type = "none"
	},
	left_click_sound = {
		{
			filename = "__core__/sound/list-box-click.ogg",
			volume = 1
		}
	}
}
-- The style for unselected cheat target (not self) button.
default_style[creative_mode_defines.names.gui_styles.cheat_target_unselected_button] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.cheat_target_selected_button,
	default_graphical_set = {
		type = "none"
	},
	clicked_graphical_set = {
		type = "composition",
		filename = creative_mode_defines.mod_directory .. "/graphics/gui/" .. "grey.png",
		priority = "extra-high-no-scale",
		corner_size = 1,
		position = {0, 0}
	},
	hovered_graphical_set = {
		type = "composition",
		filename = creative_mode_defines.mod_directory .. "/graphics/gui/" .. "grey.png",
		priority = "extra-high-no-scale",
		corner_size = 1,
		position = {0, 0}
	}
}
-- The style for selected cheat target (self) button.
default_style[creative_mode_defines.names.gui_styles.cheat_target_self_selected_button] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.cheat_target_selected_button,
	default_font_color = {r = 0, g = 0, b = 1},
	hovered_font_color = {r = 0, g = 0, b = 1},
	clicked_font_color = {r = 0, g = 0, b = 1},
	disabled_font_color = {r = 0, g = 0, b = 0.5}
}
-- The style for unselected cheat target (self) button.
default_style[creative_mode_defines.names.gui_styles.cheat_target_self_unselected_button] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.cheat_target_unselected_button,
	default_font_color = {r = 0, g = 0, b = 1},
	hovered_font_color = {r = 0, g = 0, b = 1},
	clicked_font_color = {r = 0, g = 0, b = 1},
	disabled_font_color = {r = 0, g = 0, b = 0.5}
}
-- The style for the select all targets button.
default_style[creative_mode_defines.names.gui_styles.cheat_select_all_targets_button] = {
	type = "button_style",
	parent = "button",
	width = cheat_selection_width,
	scalable = false,
	left_click_sound = {
		{
			filename = "__core__/sound/gui-click.ogg",
			volume = 1
		}
	}
}
-- The style for the table that contains each individual cheat option.
default_style[creative_mode_defines.names.gui_styles.cheat_table] = {
	type = "table_style",
	parent = "table",
	horizontal_spacing = 0,
	width = cheat_width,
	scalable = false
}
-- The style for the flow that contains each individual cheat option.
default_style[creative_mode_defines.names.gui_styles.cheat_flow] = {
	type = "horizontal_flow_style",
	parent = "horizontal_flow",
	horizontal_spacing = 0,
	width = cheat_width,
	scalable = false
}
-- The cheat name label style.
default_style[creative_mode_defines.names.gui_styles.cheat_name_label] = {
	type = "label_style",
	parent = "label",
	width = cheat_label_width,
	scalable = false
}
-- The cheat on/off button with off state style.
default_style[creative_mode_defines.names.gui_styles.cheat_on_off_button_off] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.small_default_bold_button,
	width = cheat_on_off_button_width,
	scalable = false
}
-- The cheat on/off button with on state style.
default_style[creative_mode_defines.names.gui_styles.cheat_on_off_button_on] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.cheat_on_off_button_off,
	default_graphical_set = {
		type = "composition",
		filename = "__core__/graphics/gui.png",
		priority = "extra-high-no-scale",
		corner_size = {3, 3},
		position = {0, 8}
	}
}
-- The cheat numeric textfield style.
default_style[creative_mode_defines.names.gui_styles.cheat_numeric_textfield] = {
	type = "textbox_style",
	parent = "long_number_textfield",
	width = math.floor((cheat_width - cheat_label_width - 8) * 0.625),
	scalable = false
}
-- The flow style for separating the cheat numeric textfield and apply button.
default_style[creative_mode_defines.names.gui_styles.cheat_textfield_and_button_separate_flow] = {
	type = "horizontal_flow_style",
	parent = "horizontal_flow",
	width = default_horizontal_spacing,
	scalable = false
}
-- The cheat apply button style.
default_style[creative_mode_defines.names.gui_styles.cheat_apply_button] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.small_default_bold_button,
	width = math.floor((cheat_width - cheat_label_width - 8) * 0.375),
	scalable = false
}
-- The cheat name label style for cheats that have only one button.
default_style[creative_mode_defines.names.gui_styles.cheat_with_one_button_name_label] = {
	type = "label_style",
	parent = creative_mode_defines.names.gui_styles.cheat_name_label,
	width = cheat_label_width + cheat_on_off_button_width,
	scalable = false
}
-- The style for the enable all/disable all buttons table container.
default_style[creative_mode_defines.names.gui_styles.cheat_enable_disable_all_table] = {
	type = "table_style",
	parent = creative_mode_defines.names.gui_styles.cheat_table,
	top_padding = 15
}
-- The cheat enable/disable all button style.
default_style[creative_mode_defines.names.gui_styles.cheat_enable_disable_all_button] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.small_default_bold_button,
	width = cheat_width / 2,
	scalable = false
}
-- The style for note label under the cheat enable/disable all buttons.
default_style[creative_mode_defines.names.gui_styles.cheat_note_label] = {
	type = "label_style",
	parent = "label",
	font = "default-small",
	width = cheat_width,
	scalable = false
}
-- The style for cheat value target selection drop down (e.g. team selection) - current selection button.
default_style[creative_mode_defines.names.gui_styles.cheat_value_drop_down_current_target_button] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.cheat_on_off_button_off,
	font = "default",
	align = "left",
	width = cheat_on_off_button_width * 2,
	scalable = false,
	right_padding = 4,
	left_padding = 4,
	bottom_padding = 2,
	default_graphical_set = {
		filename = creative_mode_defines.mod_directory .. "/graphics/gui/" .. "cheat-dropdown.png",
		top_border = 3,
		right_border = 14,
		bottom_border = 3,
		left_border = 3,
		width = 150,
		height = 25
	},
	hovered_graphical_set = {
		top_border = 3,
		right_border = 14,
		bottom_border = 3,
		left_border = 3,
		filename = creative_mode_defines.mod_directory .. "/graphics/gui/" .. "cheat-dropdown.png",
		width = 150,
		height = 25
	},
	clicked_graphical_set = {
		top_border = 3,
		right_border = 14,
		bottom_border = 3,
		left_border = 3,
		filename = creative_mode_defines.mod_directory .. "/graphics/gui/" .. "cheat-dropdown.png",
		width = 150,
		height = 25
	},
	disabled_graphical_set = {
		top_border = 3,
		right_border = 14,
		bottom_border = 3,
		left_border = 3,
		filename = creative_mode_defines.mod_directory .. "/graphics/gui/" .. "cheat-dropdown.png",
		width = 150,
		height = 25
	}
}
-- The style for cheat value target selection drop down (e.g. team selection) - scroll pane.
default_style[creative_mode_defines.names.gui_styles.cheat_value_drop_down_scroll_pane] = {
	type = "scroll_pane_style",
	parent = creative_mode_defines.names.gui_styles.cheat_scroll_pane,
	maximal_height = cheat_value_drop_down_height
}
-- The style for cheat value target selection drop down (e.g. team selection) - frame.
default_style[creative_mode_defines.names.gui_styles.cheat_value_drop_down_container_frame] = {
	type = "frame_style",
	parent = creative_mode_defines.names.gui_styles.cheat_target_selection_container_frame,
	minimal_height = cheat_value_drop_down_height
}
-- The style for cheat value target selection drop down (e.g. team selection) - selection button.
default_style[creative_mode_defines.names.gui_styles.cheat_value_drop_down_selection_button] = {
	type = "button_style",
	parent = "button",
	font = "default",
	align = "left",
	top_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
	right_padding = 0,
	width = cheat_on_off_button_width * 2,
	height = cheat_on_off_button_height,
	scalable = false,
	default_font_color = {r = 1, g = 1, b = 1},
	default_graphical_set = {
		type = "none"
	},
	hovered_font_color = {r = 1, g = 1, b = 1},
	hovered_graphical_set = {
		type = "composition",
		filename = creative_mode_defines.mod_directory .. "/graphics/gui/" .. "orange.png",
		priority = "extra-high-no-scale",
		corner_size = 1,
		position = {0, 0}
	},
	clicked_font_color = {r = 1, g = 1, b = 1},
	clicked_graphical_set = {
		type = "composition",
		filename = creative_mode_defines.mod_directory .. "/graphics/gui/" .. "orange.png",
		priority = "extra-high-no-scale",
		corner_size = 1,
		position = {0, 0}
	},
	disabled_font_color = {r = 0.5, g = 0.5, b = 0.5},
	disabled_graphical_set = {
		type = "none"
	},
	left_click_sound = {
		{
			filename = "__core__/sound/list-box-click.ogg",
			volume = 1
		}
	}
}

--------------------------------------------------------------------

-- The style for magic wand frame title label.
default_style[creative_mode_defines.names.gui_styles.magic_wand_frame_caption_label] = {
	type = "label_style",
	-- parent = creative_mode_defines.names.gui_styles.frame_caption_label,
	width = cheat_width * 2 - inventory_slot_width,
	scalable = false
}
-- The style for magic wand scroll pane.
default_style[creative_mode_defines.names.gui_styles.magic_wand_scroll_pane] = {
	type = "scroll_pane_style",
	parent = "scroll_pane",
	maximal_height = cheat_all_height,
	scalable = false
}
-- The style for magic wand select mode frame.
default_style[creative_mode_defines.names.gui_styles.magic_wand_select_mode_frame] = {
	type = "frame_style",
	parent = creative_mode_defines.names.gui_styles.small_orange_title_with_right_border_frame,
	width = cheat_width + 3,
	scalable = false
}
-- The style for magic wand alt-select mode frame.
default_style[creative_mode_defines.names.gui_styles.magic_wand_alt_select_mode_frame] = {
	type = "frame_style",
	parent = creative_mode_defines.names.gui_styles.naked_small_orange_title_frame,
	width = cheat_width,
	scalable = false
}
-- The style for labels in magic wand select mode or alt-select mode frames.
default_style[creative_mode_defines.names.gui_styles.magic_wand_label] = {
	type = "label_style",
	parent = "label",
	width = cheat_width,
	scalable = false
}
-- The style for checkboxes in magic wand select mode or alt-select mode frames.
default_style[creative_mode_defines.names.gui_styles.magic_wand_checkbox] = {
	type = "checkbox_style",
	parent = "checkbox",
	width = cheat_width,
	scalable = false
}
-- The style for radiobuttons in magic wand select mode or alt-select mode frames.
default_style[creative_mode_defines.names.gui_styles.magic_wand_radiobutton] = {
	type = "radiobutton_style",
	parent = "radiobutton",
	width = cheat_width,
	scalable = false
}
-- The filter slot on button style.
default_style[creative_mode_defines.names.gui_styles.creative_chest_filter_slot_on] = {
	type = "button_style",
	parent = "slot_button",
	left_click_sound = {
		{
			filename = "__core__/sound/list-box-click.ogg",
			volume = 1
		}
	}
}
-- The filter slot off button style.
default_style[creative_mode_defines.names.gui_styles.creative_chest_filter_slot_off] = {
	type = "button_style",
	parent = "red_slot_button",
	left_click_sound = {
		{
			filename = "__core__/sound/list-box-click.ogg",
			volume = 1
		}
	}
}
-- The tile slot selected button style.
default_style[creative_mode_defines.names.gui_styles.tile_slot_selected] = {
	type = "button_style",
	parent = "selected_logistic_slot_button",
	left_click_sound = {
		{
			filename = "__core__/sound/list-box-click.ogg",
			volume = 1
		}
	}
}
-- The tile slot deselected button style.
default_style[creative_mode_defines.names.gui_styles.tile_slot_deselected] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.creative_chest_filter_slot_on
}
-- The style for labels of sliders in magic wand select mode or alt-select mode frames.
default_style[creative_mode_defines.names.gui_styles.magic_wand_slider_label] = {
	type = "label_style",
	parent = "label",
	width = cheat_width - default_horizontal_spacing - (slider_button_width * 13) - default_horizontal_spacing -
		slider_textfield_width -
		default_horizontal_spacing,
	scalable = false
}
-- The style for the labels before the drop-downs in magic wand select mode or alt-select mode frames.
default_style[creative_mode_defines.names.gui_styles.magic_wand_drop_down_label] = {
	type = "label_style",
	parent = "label",
	width = cheat_width * 0.5 - default_horizontal_spacing,
	scalable = false
}
-- The style for drop-downs in magic wand select mode or alt-select mode frames.
default_style[creative_mode_defines.names.gui_styles.magic_wand_drop_down] = {
	type = "dropdown_style",
	parent = "dropdown",
	width = cheat_width * 0.5 - default_horizontal_spacing,
	scalable = false
}
-- The style for magic wand select all (forces) button.
default_style[creative_mode_defines.names.gui_styles.magic_wand_select_all_button] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.small_default_bold_button,
	width = cheat_width,
	scalable = false
}
-- The style for magic wand quick action remove button.
default_style[creative_mode_defines.names.gui_styles.magic_wand_quick_action_remove_button] = {
	type = "button_style",
	parent = "slot_button",
	width = quick_action_remove_button_width,
	height = quick_action_remove_button_width,
	scalable = false,
	left_click_sound = {
		{
			filename = "__core__/sound/gui-click.ogg",
			volume = 1
		}
	}
}

-- The style for magic wand popup left frame caption label.
default_style[creative_mode_defines.names.gui_styles.magic_wand_popup_left_frame_caption_label] = {
	type = "label_style",
	-- parent = creative_mode_defines.names.gui_styles.frame_caption_label,
	width = magic_wand_popup_left_frame_caption_width,
	scalable = false
}
-- The style for magic wand popup right frame caption label.
default_style[creative_mode_defines.names.gui_styles.magic_wand_popup_right_frame_caption_label] = {
	type = "label_style",
	-- parent = creative_mode_defines.names.gui_styles.frame_caption_label,
	width = magic_wand_popup_right_frame_caption_width,
	scalable = false
}
-- The style for magic wand popup frame.
default_style[creative_mode_defines.names.gui_styles.magic_wand_popup_slot_scroll_pane] = {
	type = "scroll_pane_style",
	parent = "scroll_pane",
	height = magic_wand_popup_height,
	scalable = false
}
-- The style for magic wand popup slot table.
default_style[creative_mode_defines.names.gui_styles.magic_wand_popup_slot_table] = {
	type = "table_style",
	parent = creative_mode_defines.names.gui_styles.slot_table,
	width = magic_wand_popup_slot_table_width,
	scalable = false
}
-- The item-on-ground slot on magic wand popup.
default_style[creative_mode_defines.names.gui_styles.magic_wand_popup_item_on_ground_slot_button] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.magic_wand_popup_ghost_slot_button,
	default_graphical_set = {
		top_border = 1,
		right_border = 1,
		bottom_border = 1,
		left_border = 1,
		filename = "__core__/graphics/gui.png",
		width = 36,
		height = 36,
		x = 111,
		y = 72
	},
	hovered_graphical_set = {
		top_border = 1,
		right_border = 1,
		bottom_border = 1,
		left_border = 1,
		filename = "__core__/graphics/gui.png",
		priority = "extra-high-no-scale",
		width = 36,
		height = 36,
		x = 148,
		y = 72
	},
	clicked_graphical_set = {
		top_border = 1,
		right_border = 1,
		bottom_border = 1,
		left_border = 1,
		filename = "__core__/graphics/gui.png",
		priority = "extra-high-no-scale",
		width = 36,
		height = 36,
		x = 185,
		y = 72
	}
}
-- The ghost slot on magic wand popup.
default_style[creative_mode_defines.names.gui_styles.magic_wand_popup_ghost_slot_button] = {
	type = "button_style",
	parent = "slot_with_filter_button",
	left_click_sound = {
		{
			filename = "__core__/sound/list-box-click.ogg",
			volume = 1
		}
	}
}

--------------------------------------------------------------------

-- The style for events menu frame caption label.
default_style[creative_mode_defines.names.gui_styles.events_menu_frame_caption_label] = {
	type = "label_style",
	-- parent = creative_mode_defines.names.gui_styles.frame_caption_label,
	width = events_menu_frame_caption_label_width,
	scalable = false
}

--------------------------------------------------------------------

-- The style for interfaces scroll pane.
default_style[creative_mode_defines.names.gui_styles.interfaces_scroll_pane] = {
	type = "scroll_pane_style",
	parent = "scroll_pane",
	maximal_height = cheat_all_height
}
-- The style for interface buttons.
default_style[creative_mode_defines.names.gui_styles.interface_button] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.cheat_apply_button,
	width = cheat_width
}
-- The style for interface contents scroll pane.
default_style[creative_mode_defines.names.gui_styles.interface_contents_scroll_pane] = {
	type = "scroll_pane_style",
	parent = creative_mode_defines.names.gui_styles.interfaces_scroll_pane,
	maximal_height = cheat_all_height - 120
}
-- The style for interface content buttons.
default_style[creative_mode_defines.names.gui_styles.interface_content_button] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.interface_button,
	align = "left",
	font = "default"
}

--------------------------------------------------------------------

-- The access right option on/off button with on state style.
default_style[creative_mode_defines.names.gui_styles.access_right_on_off_button_on] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.cheat_on_off_button_on,
	width = access_right_on_off_button_width
}
-- The access right option on/off button with off state style.
default_style[creative_mode_defines.names.gui_styles.access_right_on_off_button_off] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.cheat_on_off_button_off,
	width = access_right_on_off_button_width
}

--------------------------------------------------------------------

-- The disable Creative Mode button style.
default_style[creative_mode_defines.names.gui_styles.disable_creative_mode_button] = {
	type = "button_style",
	parent = "button",
	width = 250,
	default_graphical_set = {
		type = "composition",
		filename = creative_mode_defines.mod_directory .. "/graphics/gui/red-button.png",
		priority = "extra-high-no-scale",
		corner_size = {3, 3},
		position = {0, 0}
	},
	left_click_sound = {
		{
			filename = "__core__/sound/gui-click.ogg",
			volume = 1
		}
	}
}

--------------------------------------------------------------------

-- The entity GUI open button style.
default_style[creative_mode_defines.names.gui_styles.entity_open_button] = {
	type = "button_style",
	parent = "button",
	scalable = false,
	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
	width = big_button_width_height + 1,
	height = big_button_width_height + 1,
	left_click_sound = {
		{
			filename = "__core__/sound/gui-click.ogg",
			volume = 1
		}
	}
}
-- The creative chest item-group label style.
default_style[creative_mode_defines.names.gui_styles.creative_chest_item_group_label] = {
	type = "label_style",
	parent = "label",
	width = (inventory_slot_width * 10 + 1 * 9) -
		(creative_chest_item_group_left_right_button_width * 2 + creative_chest_item_group_number_label_width),
	scalable = false
}
-- The creative chest item-group-number label style.
default_style[creative_mode_defines.names.gui_styles.creative_chest_item_group_number_label] = {
	type = "label_style",
	parent = creative_mode_defines.names.gui_styles.creative_chest_item_group_label,
	align = "center",
	width = creative_chest_item_group_number_label_width,
	scalable = false
}
-- The creative chest item-group left or right button style.
default_style[creative_mode_defines.names.gui_styles.creative_chest_item_group_left_right_button] = {
	type = "button_style",
	parent = "button",
	scalable = false,
	top_padding = 0,
	right_padding = 0,
	bottom_padding = 0,
	left_padding = 0,
	width = creative_chest_item_group_left_right_button_width,
	height = big_button_width_height,
	left_click_sound = {
		{
			filename = "__core__/sound/gui-click.ogg",
			volume = 1
		}
	}
}
-- The creative chest select-slot label style.
default_style[creative_mode_defines.names.gui_styles.creative_chest_select_slot_label] = {
	type = "label_style",
	parent = creative_mode_defines.names.gui_styles.creative_chest_item_group_label,
	width = (inventory_slot_width * 10 + 1 * 9) - (big_button_width_height * 2),
	scalable = false
}
-- The 36x36 original display mode button style.
default_style[creative_mode_defines.names.gui_styles.creative_chest_display_mode_button_original] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.entity_open_button,
	default_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 0,
		big_button_width_height * 2,
		big_button_width_height,
		big_button_width_height
	),
	hovered_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 1,
		big_button_width_height * 2,
		big_button_width_height,
		big_button_width_height
	),
	clicked_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 2,
		big_button_width_height * 2,
		big_button_width_height,
		big_button_width_height
	),
	disabled_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 3,
		big_button_width_height * 2,
		big_button_width_height,
		big_button_width_height
	)
}
-- The 36x36 compact display mode button style.
default_style[creative_mode_defines.names.gui_styles.creative_chest_display_mode_button_compact] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.entity_open_button,
	default_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 0,
		big_button_width_height * 3,
		big_button_width_height,
		big_button_width_height
	),
	hovered_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 1,
		big_button_width_height * 3,
		big_button_width_height,
		big_button_width_height
	),
	clicked_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 2,
		big_button_width_height * 3,
		big_button_width_height,
		big_button_width_height
	),
	disabled_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 3,
		big_button_width_height * 3,
		big_button_width_height,
		big_button_width_height
	)
}
-- The 36x36 toggle all button style.
default_style[creative_mode_defines.names.gui_styles.inventory_toggle_all_button] = {
	type = "button_style",
	parent = creative_mode_defines.names.gui_styles.entity_open_button,
	default_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 0,
		big_button_width_height * 1,
		big_button_width_height,
		big_button_width_height
	),
	hovered_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 1,
		big_button_width_height * 1,
		big_button_width_height,
		big_button_width_height
	),
	clicked_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 2,
		big_button_width_height * 1,
		big_button_width_height,
		big_button_width_height
	),
	disabled_graphical_set = extract_monolith(
		"big-buttons.png",
		big_button_width_height * 3,
		big_button_width_height * 1,
		big_button_width_height,
		big_button_width_height
	),
	left_click_sound = {
		{
			filename = "__core__/sound/gui-click.ogg",
			volume = 1
		}
	}
}
-- The item count textfield style.
default_style[creative_mode_defines.names.gui_styles.item_count_textfield] = {
	type = "textbox_style",
	parent = "short_number_textfield",
	width = 70
}
