-- This file contains variables or functions that are related to the Modifier magic wand in this mod.
if not magic_wand_modifier then
	magic_wand_modifier = {}
end

-- Gets whether player characters should be ignored by the standard selection mode for the given player.
function magic_wand_modifier.get_std_ignore_player_characters(player)
	if global.creative_mode.magic_wand_settings.modifier[player.index] then
		if global.creative_mode.magic_wand_settings.modifier[player.index].standard_ignore_player_characters ~= nil then
			return global.creative_mode.magic_wand_settings.modifier[player.index].standard_ignore_player_characters
		end
	end
	return true
end

-- Sets whether player characters should be ignored by the standard selection mode for the given player.
function magic_wand_modifier.set_std_ignore_player_characters(player, ignore_player_characters)
	if not global.creative_mode.magic_wand_settings.modifier[player.index] then
		global.creative_mode.magic_wand_settings.modifier[player.index] = {}
	end
	global.creative_mode.magic_wand_settings.modifier[player.index].standard_ignore_player_characters =
		ignore_player_characters
end

----

-- Gets whether healthless entities should be ignored by the standard selection mode for the given player.
function magic_wand_modifier.get_std_ignore_healthess_entities(player)
	if global.creative_mode.magic_wand_settings.modifier[player.index] then
		if global.creative_mode.magic_wand_settings.modifier[player.index].standard_ignore_healthess_entities ~= nil then
			return global.creative_mode.magic_wand_settings.modifier[player.index].standard_ignore_healthess_entities
		end
	end
	return true
end

-- Sets whether healthless entities should be ignored by the standard selection mode for the given player.
function magic_wand_modifier.set_std_ignore_healthess_entities(player, ignore_healthless_entities)
	if not global.creative_mode.magic_wand_settings.modifier[player.index] then
		global.creative_mode.magic_wand_settings.modifier[player.index] = {}
	end
	global.creative_mode.magic_wand_settings.modifier[player.index].standard_ignore_healthess_entities =
		ignore_healthless_entities
end

----

-- Gets whether indestructible entities should be ignored by the standard selection mode for the given player.
function magic_wand_modifier.get_std_ignore_indestructible_entities(player)
	if global.creative_mode.magic_wand_settings.modifier[player.index] then
		if global.creative_mode.magic_wand_settings.modifier[player.index].standard_ignore_indestructible_entities ~= nil then
			return global.creative_mode.magic_wand_settings.modifier[player.index].standard_ignore_indestructible_entities
		end
	end
	return true
end

-- Sets whether indestructible entities should be ignored by the standard selection mode for the given player.
function magic_wand_modifier.set_std_ignore_indestructible_entities(player, standard_ignore_indestructible_entities)
	if not global.creative_mode.magic_wand_settings.modifier[player.index] then
		global.creative_mode.magic_wand_settings.modifier[player.index] = {}
	end
	global.creative_mode.magic_wand_settings.modifier[player.index].standard_ignore_indestructible_entities =
		standard_ignore_indestructible_entities
end

----

-- Gets whether the entities belonging the given force can be selected by standard selection mode for the given player.
function magic_wand_modifier.get_std_select_entities_on_force(player, force)
	if global.creative_mode.magic_wand_settings.modifier[player.index] then
		if global.creative_mode.magic_wand_settings.modifier[player.index].standard_forces ~= nil then
			return global.creative_mode.magic_wand_settings.modifier[player.index].standard_forces[force.name] ~= false
		end
	end
	return true
end

-- Sets whether the entities belonging the given force can be selected by standard selection mode for the given player.
function magic_wand_modifier.set_std_select_entities_on_force(player, force, can_select)
	if not global.creative_mode.magic_wand_settings.modifier[player.index] then
		global.creative_mode.magic_wand_settings.modifier[player.index] = {}
	end
	if not global.creative_mode.magic_wand_settings.modifier[player.index].standard_forces then
		global.creative_mode.magic_wand_settings.modifier[player.index].standard_forces = {}
	end
	global.creative_mode.magic_wand_settings.modifier[player.index].standard_forces[force.name] = can_select
end

----

-- Gets whether player characters should be ignored by the alternate selection mode for the given player.
function magic_wand_modifier.get_alt_ignore_player_characters(player)
	if global.creative_mode.magic_wand_settings.modifier[player.index] then
		if global.creative_mode.magic_wand_settings.modifier[player.index].alternate_ignore_player_characters ~= nil then
			return global.creative_mode.magic_wand_settings.modifier[player.index].alternate_ignore_player_characters
		end
	end
	return true
end

-- Sets whether player characters should be ignored by the alternate selection mode for the given player.
function magic_wand_modifier.set_alt_ignore_player_characters(player, ignore_player_characters)
	if not global.creative_mode.magic_wand_settings.modifier[player.index] then
		global.creative_mode.magic_wand_settings.modifier[player.index] = {}
	end
	global.creative_mode.magic_wand_settings.modifier[player.index].alternate_ignore_player_characters =
		ignore_player_characters
end

----

-- Gets whether healthless entities should be ignored by the alternate selection mode for the given player.
function magic_wand_modifier.get_alt_ignore_healthess_entities(player)
	if global.creative_mode.magic_wand_settings.modifier[player.index] then
		if global.creative_mode.magic_wand_settings.modifier[player.index].alternate_ignore_healthess_entities ~= nil then
			return global.creative_mode.magic_wand_settings.modifier[player.index].alternate_ignore_healthess_entities
		end
	end
	return false
end

-- Sets whether healthless entities should be ignored by the alternate selection mode for the given player.
function magic_wand_modifier.set_alt_ignore_healthess_entities(player, ignore_healthless_entities)
	if not global.creative_mode.magic_wand_settings.modifier[player.index] then
		global.creative_mode.magic_wand_settings.modifier[player.index] = {}
	end
	global.creative_mode.magic_wand_settings.modifier[player.index].alternate_ignore_healthess_entities =
		ignore_healthless_entities
end

----

-- Gets whether indestructible entities should be ignored by the alternate selection mode for the given player.
function magic_wand_modifier.get_alt_ignore_indestructible_entities(player)
	if global.creative_mode.magic_wand_settings.modifier[player.index] then
		if global.creative_mode.magic_wand_settings.modifier[player.index].alternate_ignore_indestructible_entities ~= nil then
			return global.creative_mode.magic_wand_settings.modifier[player.index].alternate_ignore_indestructible_entities
		end
	end
	return false
end

-- Sets whether indestructible entities should be ignored by the alternate selection mode for the given player.
function magic_wand_modifier.set_alt_ignore_indestructible_entities(player, alternate_ignore_indestructible_entities)
	if not global.creative_mode.magic_wand_settings.modifier[player.index] then
		global.creative_mode.magic_wand_settings.modifier[player.index] = {}
	end
	global.creative_mode.magic_wand_settings.modifier[player.index].alternate_ignore_indestructible_entities =
		alternate_ignore_indestructible_entities
end

----

-- Gets whether the entities belonging the given force can be selected by alternate selection mode for the given player.
function magic_wand_modifier.get_alt_select_entities_on_force(player, force)
	if global.creative_mode.magic_wand_settings.modifier[player.index] then
		if global.creative_mode.magic_wand_settings.modifier[player.index].alternate_forces ~= nil then
			return global.creative_mode.magic_wand_settings.modifier[player.index].alternate_forces[force.name] ~= false
		end
	end
	return true
end

-- Sets whether the entities belonging the given force can be selected by alternate selection mode for the given player.
function magic_wand_modifier.set_alt_select_entities_on_force(player, force, can_select)
	if not global.creative_mode.magic_wand_settings.modifier[player.index] then
		global.creative_mode.magic_wand_settings.modifier[player.index] = {}
	end
	if not global.creative_mode.magic_wand_settings.modifier[player.index].alternate_forces then
		global.creative_mode.magic_wand_settings.modifier[player.index].alternate_forces = {}
	end
	global.creative_mode.magic_wand_settings.modifier[player.index].alternate_forces[force.name] = can_select
end

------------------------------------------------------

-- Creates smoke effect at the given position in the given surface.
local function create_smoke_at(surface, position)
	surface.create_trivial_smoke {
		name = creative_mode_defines.names.entities.magic_wand_smoke_modifier,
		position = position
	}
end

-- Creates smoke effect at the entity's position.
function magic_wand_modifier.create_smoke_effect_at_entity_position(entity)
	create_smoke_at(entity.surface, entity.position)
end

------------------------------------------------------

-- Returns whether the given entity can be selected by the given player according to the given tests.
local function check_can_select_entity(
	player,
	entity,
	ignore_player_characters,
	ignore_healthless_entities,
	ignore_indestructible_entities,
	get_select_entities_on_force_function)
	if entity.valid then
		if entity.name ~= creative_mode_defines.names.entities.magic_wand_smoke_modifier then
			if entity.health ~= nil or not ignore_healthless_entities then
				if entity.force and get_select_entities_on_force_function(player, entity.force) then
					if not ignore_player_characters or not util.get_character_owning_player(entity) then
						if not ignore_indestructible_entities or entity.destructible then
							return true
						end
					end
				end
			end
		end
	end
	return false
end

-- Handler of the on_player_selected_area event.
-- Returns whether the event is consumed and hence no need to further pass it to other handlers.
function magic_wand_modifier.on_player_selected_area(player, area, item_name, entities, tiles)
	if item_name == creative_mode_defines.names.items.magic_wand_modifier then
		if rights.can_player_use_modifier_magic_wand(player) then
			-- Show the modification popup for the selected entities.
			-- Destroy the previous popup first.
			gui_menu_magicwand.create_or_destroy_modification_popup_for_player(player, false)

			-- Filter out the unwanted entities and record the remaining ones.
			global.creative_mode.modifier_magic_wand_selection[player.index] = {}
			local ignore_player_characters = magic_wand_modifier.get_std_ignore_player_characters(player)
			local ignore_healthless_entities = magic_wand_modifier.get_std_ignore_healthess_entities(player)
			local ignore_indestructible_entities = magic_wand_modifier.get_std_ignore_indestructible_entities(player)
			for _, entity in pairs(entities) do
				if
					check_can_select_entity(
						player,
						entity,
						ignore_player_characters,
						ignore_healthless_entities,
						ignore_indestructible_entities,
						magic_wand_modifier.get_std_select_entities_on_force
					)
				 then
					table.insert(global.creative_mode.modifier_magic_wand_selection[player.index], entity)
				end
			end

			-- Show popup.
			if #global.creative_mode.modifier_magic_wand_selection[player.index] > 0 then
				gui_menu_magicwand.create_or_destroy_modification_popup_for_player(player, true)

				-- Mark the quick actions to be cleared once a new modification is received.
				if not global.creative_mode.modifier_magic_wand_quick_actions[player.index] then
					global.creative_mode.modifier_magic_wand_quick_actions[player.index] = {}
				end
				global.creative_mode.modifier_magic_wand_quick_actions[player.index].reset_when_new_action_received = true
			end
		else
			-- No right to use.
			player.print {"message.creative-mode_no-right-to-use-magic-wand"}
		end

		return true
	end

	return false
end

-- Handler of the on_player_alt_selected_area event.
-- Returns whether the event is consumed and hence no need to further pass it to other handlers.
function magic_wand_modifier.on_player_alt_selected_area(player, area, item_name, entities, tiles)
	if item_name == creative_mode_defines.names.items.magic_wand_modifier then
		if rights.can_player_use_modifier_magic_wand(player) then
			-- Apply the recorded actions to the selected entities.

			-- Do nothing if no action has been recorded.
			if not global.creative_mode.modifier_magic_wand_quick_actions[player.index] then
				return true
			end
			local actions = global.creative_mode.modifier_magic_wand_quick_actions[player.index].actions
			if not actions or #actions <= 0 then
				return true
			end

			-- Filter entities.
			local filtered_entities = {}
			local ignore_player_characters = magic_wand_modifier.get_alt_ignore_player_characters(player)
			local ignore_healthless_entities = magic_wand_modifier.get_alt_ignore_healthess_entities(player)
			local ignore_indestructible_entities = magic_wand_modifier.get_alt_ignore_indestructible_entities(player)
			for _, entity in pairs(entities) do
				if
					check_can_select_entity(
						player,
						entity,
						ignore_player_characters,
						ignore_healthless_entities,
						ignore_indestructible_entities,
						magic_wand_modifier.get_alt_select_entities_on_force
					)
				 then
					table.insert(filtered_entities, entity)

					-- Create smoke.
					magic_wand_modifier.create_smoke_effect_at_entity_position(entity)
				end
			end

			-- Apply actions.
			for _, action in ipairs(actions) do
				local cheat_gui_data = gui_menu_magicwand.action_code_to_cheat_gui_data[action.code]
				cheats.apply_cheat_to_targets(
					player,
					filtered_entities,
					cheats.magic_wand_modifications,
					cheat_gui_data.cheat_data,
					action.value,
					true
				)
				gui_menu_cheats.update_cheat_status_in_cheats_menu_for_all_players(
					gui_menu_magicwand.modification_popup_cheats_gui_data,
					cheat_gui_data
				)
			end
		else
			-- No right to use.
			player.print {"message.creative-mode_no-right-to-use-magic-wand"}
		end

		return true
	end

	return false
end
