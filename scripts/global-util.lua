-- This file contains functions to initialize and update the global meta-table used by this mod.
if not global_util then
	global_util = {}
end

-- Initializes the necessary meta-table if it doesn't exist yet. This is called for new games or existing games when the version of this mod has changed.
function global_util.initialize_or_update_global()
	-- Generate table for storing data that will be used later.
	if not global.creative_mode then
		global.creative_mode = {}
		-- Store whether creative mode has been enabled.
		global.creative_mode.enabled = false
		-- Whether the popup of asking for enabling Creative Mode has been shown.
		global.creative_mode.has_asked_for_enable = false
	else
		if global.creative_mode.enabled then
			global.creative_mode.has_asked_for_enable = true
		end
	end
	-- Also generate the sub-tables to store our entities.
	if not global.creative_mode.creative_chest_data_groups then
		global.creative_mode.creative_chest_data_groups = {}
	end
	if not global.creative_mode.creative_chest_next_group then
		global.creative_mode.creative_chest_next_group = 1
	end -- The group number for the next placed creative chest. (Number of items in each group <= Chest inventory size)
	if not global.creative_mode.creative_provider_chest_data_groups then
		global.creative_mode.creative_provider_chest_data_groups = {}
	end
	if not global.creative_mode.creative_provider_chest_next_group then
		global.creative_mode.creative_provider_chest_next_group = 1
	end
	if not global.creative_mode.autofill_requester_chest then
		global.creative_mode.autofill_requester_chest = {}
	end
	if not global.creative_mode.autofill_requester_chest_next_update_index then
		global.creative_mode.autofill_requester_chest_next_update_index = 1
	end
	if not global.creative_mode.duplicating_chest_data then
		global.creative_mode.duplicating_chest_data = {}
	end
	if not global.creative_mode.duplicating_chest_next_update_index then
		global.creative_mode.duplicating_chest_next_update_index = 1
	end
	if not global.creative_mode.duplicating_provider_chest_data then
		global.creative_mode.duplicating_provider_chest_data = {}
	end
	if not global.creative_mode.duplicating_provider_chest_next_update_index then
		global.creative_mode.duplicating_provider_chest_next_update_index = 1
	end
	if not global.creative_mode.void_requester_chest then
		global.creative_mode.void_requester_chest = {}
	end
	if not global.creative_mode.void_requester_chest_next_update_index then
		global.creative_mode.void_requester_chest_next_update_index = 1
	end
	if not global.creative_mode.void_chest then
		global.creative_mode.void_chest = {}
	end
	if not global.creative_mode.void_chest_next_update_index then
		global.creative_mode.void_chest_next_update_index = 1
	end
	if not global.creative_mode.void_storage_chest then
		global.creative_mode.void_storage_chest = {}
	end
	if not global.creative_mode.void_storage_chest_next_update_index then
		global.creative_mode.void_storage_chest_next_update_index = 1
	end
	if not global.creative_mode.creative_cargo_wagon_data_groups then
		global.creative_mode.creative_cargo_wagon_data_groups = {}
	end
	if not global.creative_mode.creative_cargo_wagon_next_group then
		global.creative_mode.creative_cargo_wagon_next_group = 1
	end
	if not global.creative_mode.duplicating_cargo_wagon_data then
		global.creative_mode.duplicating_cargo_wagon_data = {}
	end
	if not global.creative_mode.duplicating_cargo_wagon_next_update_index then
		global.creative_mode.duplicating_cargo_wagon_next_update_index = 1
	end
	if not global.creative_mode.void_cargo_wagon then
		global.creative_mode.void_cargo_wagon = {}
	end
	if not global.creative_mode.void_cargo_wagon_next_update_index then
		global.creative_mode.void_cargo_wagon_next_update_index = 1
	end
	if not global.creative_mode.super_roboport then
		global.creative_mode.super_roboport = {}
	end
	if not global.creative_mode.fluid_source then
		global.creative_mode.fluid_source = {}
	end
	if not global.creative_mode.fluid_void then
		global.creative_mode.fluid_void = {}
	end
	if not global.creative_mode.super_boiler then
		global.creative_mode.super_boiler = {}
	end
	if not global.creative_mode.super_cooler then
		global.creative_mode.super_cooler = {}
	end
	if not global.creative_mode.configurable_super_boiler_data then
		global.creative_mode.configurable_super_boiler_data = {}
	end
	if not global.creative_mode.heat_source then
		global.creative_mode.heat_source = {}
	end
	if not global.creative_mode.heat_void then
		global.creative_mode.heat_void = {}
	end
	if not global.creative_mode.item_source_data then
		global.creative_mode.item_source_data = {}
	end
	if not global.creative_mode.duplicator_data then
		global.creative_mode.duplicator_data = {}
	end
	if not global.creative_mode.item_void_data then
		global.creative_mode.item_void_data = {}
	end
	if not global.creative_mode.random_item_source_data then
		global.creative_mode.random_item_source_data = {}
	end
	if not global.creative_mode.creative_lab then
		global.creative_mode.creative_lab = {}
	end
	if not global.creative_mode.creative_lab_next_update_index then
		global.creative_mode.creative_lab_next_update_index = 1
	end
	if not global.creative_mode.energy_source then
		global.creative_mode.energy_source = {}
	end
	if not global.creative_mode.passive_energy_source then
		global.creative_mode.passive_energy_source = {}
	end
	if not global.creative_mode.energy_void then
		global.creative_mode.energy_void = {}
	end
	if not global.creative_mode.passive_energy_void then
		global.creative_mode.passive_energy_void = {}
	end
	if not global.creative_mode.super_radar then
		global.creative_mode.super_radar = {}
	end
	if not global.creative_mode.super_beacon then
		global.creative_mode.super_beacon = {}
	end

	-- Table for storing the equipments that need to be refilled with energy.
	if not global.energy_refill_equipments then
		global.energy_refill_equipments = {}
	end

	-- Table for storing which entity each player has opened.
	if not global.creative_mode.player_opened_entities then
		global.creative_mode.player_opened_entities = {}
	end
	-- Table for storing whether the entity GUI is opened.
	if not global.creative_mode.player_opened_entity_gui then
		global.creative_mode.player_opened_entity_gui = {}
	end

	-- Update: item_void -> item_void_data (since v0.1.1)
	if global.creative_mode.item_void then
		for _, item_void in ipairs(global.creative_mode.item_void) do
			-- Re-register the entities again to move them into the new table.
			global_util.register_entity(item_void)
		end
		global.creative_mode.item_void = nil
	end

	-- Update: creative_provider_chest_groups -> creative_provider_chest_data_groups (since v0.1.2)
	if global.creative_mode.creative_provider_chest_groups then
		for index, groups in ipairs(global.creative_mode.creative_provider_chest_groups) do
			-- Can't simply re-register in this case because the chests are divided into groups.
			if not global.creative_mode.creative_provider_chest_data_groups[index] then
				global.creative_mode.creative_provider_chest_data_groups[index] = {}
			end
			for index2, chest in ipairs(groups) do
				table.insert(global.creative_mode.creative_provider_chest_data_groups[index], {entity = chest, filtered_slots = {}})
			end
		end
		global.creative_mode.creative_provider_chest_groups = nil
	end

	-- Whether Creative Mode has been permanently disabled.
	if not global.creative_mode.permanently_disabled then
		global.creative_mode.permanently_disabled = false
	end

	-- Player rights.existence determinator
	if not global.creative_mode.player_rights then
		global.creative_mode.player_rights = {}
	end
	-- Right for enabling/disabling personal cheats.
	if global.creative_mode.player_rights.access_personal_cheats == nil then
		global.creative_mode.player_rights.access_personal_cheats = rights.default_access_personal_cheats_level
	end
	-- Right for enabling/disabling team cheats.
	if global.creative_mode.player_rights.access_team_cheats == nil then
		global.creative_mode.player_rights.access_team_cheats = rights.default_access_team_cheats_level
	end
	-- Right for enabling/disabling surface cheats.
	if global.creative_mode.player_rights.access_surface_cheats == nil then
		global.creative_mode.player_rights.access_surface_cheats = rights.default_access_surface_cheats_level
	end
	-- Right for enabling/disabling global cheats.
	if global.creative_mode.player_rights.access_global_cheats == nil then
		global.creative_mode.player_rights.access_global_cheats = rights.default_access_global_cheats_level
	end
	-- Right for changing build options.
	if global.creative_mode.player_rights.access_build_options == nil then
		global.creative_mode.player_rights.access_build_options = rights.default_access_build_options_level
	end
	-- Right for using the Creator Magic Wand. (True = all players can use; false = only admins can use)
	if global.creative_mode.player_rights.use_creator_magic_wand == nil then
		global.creative_mode.player_rights.use_creator_magic_wand = rights.default_use_creator_magic_wand
	end
	-- Right for using the Healer Magic Wand.
	if global.creative_mode.player_rights.use_healer_magic_wand == nil then
		global.creative_mode.player_rights.use_healer_magic_wand = rights.default_use_healer_magic_wand
	end
	-- Right for using the Modifier Magic Wand.
	if global.creative_mode.player_rights.use_modifier_magic_wand == nil then
		global.creative_mode.player_rights.use_modifier_magic_wand = rights.default_use_modifier_magic_wand
	end
	-- Right for accessing modding menu. (True = all players can access; false = only admins can access)
	if global.creative_mode.player_rights.access_modding_menu == nil then
		global.creative_mode.player_rights.access_modding_menu = rights.default_access_modding_menu
	end

	-- Table of personal cheats for each player.
	if not global.creative_mode.personal_cheats then
		global.creative_mode.personal_cheats = {}
	end
	-- Cheat mode.
	if not global.creative_mode.personal_cheats.cheat_mode then
		global.creative_mode.personal_cheats.cheat_mode = {}
	end
	-- Invincible player.
	if not global.creative_mode.personal_cheats.invincible_player then
		global.creative_mode.personal_cheats.invincible_player = {}
	end
	-- Keep last item.
	if not global.creative_mode.personal_cheats.keep_last_item then
		global.creative_mode.personal_cheats.keep_last_item = {}
	end
	-- Repair mined item.
	if not global.creative_mode.personal_cheats.repair_mined_item then
		global.creative_mode.personal_cheats.repair_mined_item = {}
	end
	-- Whether the cursor stack of each player has been restored after the player has put item to build something.
	-- We need to verify whether the built "something" is actually a ghost i.e. no item is spent, no need to restore.
	if not global.creative_mode.personal_cheats.has_restored_cursor_stack then
		global.creative_mode.personal_cheats.has_restored_cursor_stack = {}
	end
	-- Instant request.
	if not global.creative_mode.personal_cheats.instant_request then
		global.creative_mode.personal_cheats.instant_request = {}
	end
	-- Instant request: to minimize the impact to performance when there are many players in the game with many logistic request slots, we limited the maximum number of slots to be checked in each tick.
	-- The next player to be checked. It is ensure to be 1 even if it already exists in loaded save, because we don't want infinite loop in the get player function if someone loaded a multiplayer game that previously had many players.
	global.creative_mode.personal_cheats.instant_request_next_player_index = 1
	-- The next slot to be checked in that player.
	if not global.creative_mode.personal_cheats.instant_request_next_player_slot_index then
		global.creative_mode.personal_cheats.instant_request_next_player_slot_index = 1
	end
	-- Instant trash.
	if not global.creative_mode.personal_cheats.instant_trash then
		global.creative_mode.personal_cheats.instant_trash = {}
	end
	-- Instant trash: number of players to be updated in each tick is limited.
	global.creative_mode.personal_cheats.instant_trash_next_player_index = 1
	-- Instant blueprint.
	if not global.creative_mode.personal_cheats.instant_blueprint then
		global.creative_mode.personal_cheats.instant_blueprint = {}
	end
	-- Instant deconstruction.
	if not global.creative_mode.personal_cheats.instant_deconstruction then
		global.creative_mode.personal_cheats.instant_deconstruction = {}
	end
	-- Reach distance.
	if not global.creative_mode.personal_cheats.reach_distance then
		global.creative_mode.personal_cheats.reach_distance = {}
	end
	-- Build distance.
	if not global.creative_mode.personal_cheats.build_distance then
		global.creative_mode.personal_cheats.build_distance = {}
	end
	-- Resource reach distance.
	if not global.creative_mode.personal_cheats.resource_reach_distance then
		global.creative_mode.personal_cheats.resource_reach_distance = {}
	end
	-- Item drop distance.
	if not global.creative_mode.personal_cheats.item_drop_distance then
		global.creative_mode.personal_cheats.item_drop_distance = {}
	end
	-- Item pickup distance.
	if not global.creative_mode.personal_cheats.item_pickup_distance then
		global.creative_mode.personal_cheats.item_pickup_distance = {}
	end
	-- Loot pickup distance.
	if not global.creative_mode.personal_cheats.loot_pickup_distance then
		global.creative_mode.personal_cheats.loot_pickup_distance = {}
	end
	-- Mining speed.
	if not global.creative_mode.personal_cheats.mining_speed then
		global.creative_mode.personal_cheats.mining_speed = {}
	end
	-- Running speed.
	if not global.creative_mode.personal_cheats.running_speed then
		global.creative_mode.personal_cheats.running_speed = {}
	end
	-- Crafting speed.
	if not global.creative_mode.personal_cheats.crafting_speed then
		global.creative_mode.personal_cheats.crafting_speed = {}
	end
	-- Inventory bonus.
	if not global.creative_mode.personal_cheats.inventory_bonus then
		global.creative_mode.personal_cheats.inventory_bonus = {}
	end
	-- Quickbar bonus.
	if not global.creative_mode.personal_cheats.quickbar_bonus then
		global.creative_mode.personal_cheats.quickbar_bonus = {}
	end
	-- Health bonus.
	if not global.creative_mode.personal_cheats.health_bonus then
		global.creative_mode.personal_cheats.health_bonus = {}
	end
	-- God mode : list of characters that were previously characters of players before god mode was enabled.
	if not global.creative_mode.personal_cheats.god_mode_character then
		global.creative_mode.personal_cheats.god_mode_character = {}
	end

	-- Table of team cheats for each team.
	if not global.creative_mode.team_cheats then
		global.creative_mode.team_cheats = {}
	end
	-- Instant research.
	if not global.creative_mode.team_cheats.instant_research then
		global.creative_mode.team_cheats.instant_research = {}
	end

	-- Table of surface cheats for each surface.
	if not global.creative_mode.surface_cheats then
		global.creative_mode.surface_cheats = {}
	end
	-- Don't generate enemy.
	if not global.creative_mode.surface_cheats.dont_generate_enemy then
		global.creative_mode.surface_cheats.dont_generate_enemy = {}
	end

	-- Table of build options for each player.
	if not global.creative_mode.build_options then
		global.creative_mode.build_options = {}
	end
	-- Active.
	if not global.creative_mode.build_options.active then
		global.creative_mode.build_options.active = {}
	end
	-- Destructible.
	if not global.creative_mode.build_options.destructible then
		global.creative_mode.build_options.destructible = {}
	end
	-- Minable.
	if not global.creative_mode.build_options.minable then
		global.creative_mode.build_options.minable = {}
	end
	-- Rotatable.
	if not global.creative_mode.build_options.rotatable then
		global.creative_mode.build_options.rotatable = {}
	end
	-- Operable.
	if not global.creative_mode.build_options.operable then
		global.creative_mode.build_options.operable = {}
	end
	-- Full health.
	if not global.creative_mode.build_options.full_health then
		global.creative_mode.build_options.full_health = {}
	end
	-- Team (force name).
	if not global.creative_mode.build_options.team then
		global.creative_mode.build_options.team = {}
	end

	-- Table of magic wand settings for each player.
	if not global.creative_mode.magic_wand_settings then
		global.creative_mode.magic_wand_settings = {}
	end
	-- Creator.
	if not global.creative_mode.magic_wand_settings.creator then
		global.creative_mode.magic_wand_settings.creator = {}
	end
	-- Healer.
	if not global.creative_mode.magic_wand_settings.healer then
		global.creative_mode.magic_wand_settings.healer = {}
	end
	-- Modifier.
	if not global.creative_mode.magic_wand_settings.modifier then
		global.creative_mode.magic_wand_settings.modifier = {}
	end
	-- Modifier - selected entities.
	if not global.creative_mode.modifier_magic_wand_selection then
		global.creative_mode.modifier_magic_wand_selection = {}
	end
	-- Modifier - quick actions.
	if not global.creative_mode.modifier_magic_wand_quick_actions then
		global.creative_mode.modifier_magic_wand_quick_actions = {}
	end

	-- Unused. Previously it is used for global instant blueprint and instant deconstruction (before v0.2.0)
	if global.creative_mode.cheats then
		global.creative_mode.cheats = nil
	end

	-- List of ghost entities that are pending to be revived.
	-- A 1-tick delay is used for better compatilibty of other mods. This can also solve the problem that when shift-place a blueprint, the ghosts that collide with trees do not get revived even though the trees are removed by instant-deconstruction.
	if not global.creative_mode.pending_instant_blueprint then
		global.creative_mode.pending_instant_blueprint = {}
	end

	-- List of entities that are pending to be deconstructed.
	-- A 1-tick delay is used before we really destroy the entities. It is used to encounter mods like Filtered Deconstruction Planner which unmark filtered entities right after they are marked.
	if not global.creative_mode.pending_instant_deconstruction then
		global.creative_mode.pending_instant_deconstruction = {}
	end

	-- List of areas on surfaces for removing enemies.
	-- Because the on_chunk_generated event is invoked after enemy is generated (due to RSO?), we have to use a 1-tick delay to remove the enemies.
	if not global.creative_mode.pending_areas_to_remove_enemies then
		global.creative_mode.pending_areas_to_remove_enemies = {}
	end

	-- Table of events selected by each player.
	if not global.creative_mode.selected_events then
		global.creative_mode.selected_events = {}
	end
	-- Table of Booleans, for whether the selected events should be printed in each player's console.
	if not global.creative_mode.print_events then
		global.creative_mode.print_events = {}
	end
	-- Table of Booleans, for whether the parameters of the events should also be printed.
	if not global.creative_mode.also_print_event_params then
		global.creative_mode.also_print_event_params = {}
	end
	-- Table of Booleans, for whether the selected events should be written in each player's file system as txt files.
	if not global.creative_mode.write_events then
		global.creative_mode.write_events = {}
	end
	-- Table of Booleans, for whether the parameters of the events should also be written.
	if not global.creative_mode.also_write_event_params then
		global.creative_mode.also_write_event_params = {}
	end
	-- Table of Booleans, for whether the selected events should be logged in each player's file system as log files.
	if not global.creative_mode.log_events then
		global.creative_mode.log_events = {}
	end
	-- Table of Booleans, for whether the parameters of the events should also be logged.
	if not global.creative_mode.also_log_event_params then
		global.creative_mode.also_log_event_params = {}
	end

	-- Legacy config.
	global.creative_mode.config = nil
end

-- Updates the global meta-table according to the change of version of our mod.
-- Suitable for making big changes that require significant processing power and should perform as few times as possible.
function global_util.update_global_as_our_mod_updated(our_mod_old_version, our_mod_new_version)
	-- Update: additional config for item_source_data, item_void_data and duplicator_data (since v0.2.0)
	if our_mod_old_version ~= nil then
		if our_mod_old_version < "0.2.0" and our_mod_new_version >= "0.2.0" then
			for _, data in ipairs(global.creative_mode.item_source_data) do
				if data.can_insert_to_vehicle == nil then
					data.can_insert_to_vehicle = true
				end
				if data.can_insert_to_player == nil then
					data.can_insert_to_player = true
				end
				if data.insert_only_once_to_player == nil then
					data.insert_only_once_to_player = true
				end
				if data.insert_to_player_amount == nil then
					data.insert_to_player_amount = 1
				end
				if data.insert_to_player_by_stack == nil then
					data.insert_to_player_by_stack = true
				end
				if data.can_drop_on_ground == nil then
					data.can_drop_on_ground = false
				end
			end
			for _, data in ipairs(global.creative_mode.duplicator_data) do
				if data.can_duplicate_in_vehicle == nil then
					data.can_duplicate_in_vehicle = true
				end
				if data.can_duplicate_in_player == nil then
					data.can_duplicate_in_player = false
				end
			end
			for _, data in ipairs(global.creative_mode.item_void_data) do
				if data.can_remove_from_vehicle == nil then
					data.can_remove_from_vehicle = false
				end
				if data.can_remove_from_player == nil then
					data.can_remove_from_player = false
				end
				if data.can_remove_from_ground == nil then
					data.can_remove_from_ground = true
				end
			end
		end

		if our_mod_old_version >= "0.2.0" and our_mod_old_version < "0.2.2" and our_mod_new_version >= "0.2.2" then
			-- v0.2.0 ~ v0.2.1 -> v0.2.2+
			-- log events --- renamed to ---> write events. Keep the original array.
			if global.creative_mode.log_events then
				for player_index, value in ipairs(global.creative_mode.log_events) do
					global.creative_mode.write_events[player_index] = value
				end
			end
			-- Fixed typo.
			if global.creative_mode.also_log_even_params then
				for player_index, value in ipairs(global.creative_mode.also_log_even_params) do
					global.creative_mode.also_write_event_params[player_index] = value
				end
				global.creative_mode.also_log_even_params = nil
			end
		end

		if our_mod_old_version <= "0.3.7" and our_mod_new_version >= "0.3.7" then
			-- v0.3.6- -> v0.3.7+
			-- duplicating_chest --- updated to ---> duplicating_chest_data.
			if global.creative_mode.duplicating_chest then
				for _, entity in ipairs(global.creative_mode.duplicating_chest) do
					global_util.register_entity(entity)
				end
				global.creative_mode.duplicating_chest = nil
			end
			-- duplicating_provider_chest --- updated to ---> duplicating_provider_chest_data.
			if global.creative_mode.duplicating_provider_chest then
				for _, entity in ipairs(global.creative_mode.duplicating_provider_chest) do
					global_util.register_entity(entity)
				end
				global.creative_mode.duplicating_provider_chest = nil
			end
			-- duplicating_cargo_wagon --- updated to ---> duplicating_cargo_wagon_data.
			if global.creative_mode.duplicating_cargo_wagon then
				for _, entity in ipairs(global.creative_mode.duplicating_cargo_wagon) do
					global_util.register_entity(entity)
				end
				global.creative_mode.duplicating_cargo_wagon = nil
			end
		end
	end
end

-- Renews the lists of all in-game items and also the data that is used by the Creative Chest family.
function global_util.renew_item_lists()
	-- Unused.
	global.item_list = nil

	-- All non-hidden items.
	global.non_hidden_item_list = {}
	-- All hidden items, but not include our creative items.
	global.non_creative_hidden_item_list = {}
	-- All enemy items created by us. They are hidden as well but should be included in the creative chests even if they do not contain hidden items.
	global.hidden_creative_enemy_item_list = {}

	-- List of items with type equals to "tool"
	global.tool_item_list = {}

	for _, item in pairs(game.item_prototypes) do
		if item.has_flag("hidden") then
			local is_our_enemy_item = util.string_starts_with(item.name, creative_mode_defines.names.enemy_item_prefix)
			if is_our_enemy_item then
				-- Our enemy item.
				table.insert(global.hidden_creative_enemy_item_list, item)
			elseif
				not util.array_contains(creative_mode_defines.values.creative_provider_chest_additional_content_names, item.name)
			 then
				-- Not our hidden item.
				table.insert(global.non_creative_hidden_item_list, item)
			end
		else
			-- Non-hidden item.
			table.insert(global.non_hidden_item_list, item)
		end

		if item.type == "tool" then
			-- Tool item.
			table.insert(global.tool_item_list, item)
		end
	end

	global_util.remove_obsolete_items(global.non_hidden_item_list)
	global_util.remove_obsolete_items(global.non_creative_hidden_item_list)
	global_util.remove_obsolete_items(global.hidden_creative_enemy_item_list)
	global_util.remove_obsolete_items(global.tool_item_list)

	-- Update data for the Creative Chest family.
	creative_chest_util.update_item_lists_data()
end

function global_util.remove_obsolete_items(item_list)
	local i = 1
	while i <= #item_list do
		if item_list[i].type == "mining-tool" then
			table.remove(item_list, i)
		else
			i = i + 1
		end
	end
end

-- Returns whether all of the item lists are already exist.
function global_util.item_lists_exist()
	if not global.non_hidden_item_list or not global.non_creative_hidden_item_list or not global.tool_item_list then
		return false
	end
	return true
end

-- Initializes the lists of all in-game items if it doesn't not exist.
function global_util.initialize_item_lists_if_not_exist()
	if not global_util.item_lists_exist() then
		global_util.renew_item_lists()
	end
end

----

-- Look up table for matching entity-register functions according to the entity name.
local register_entity_look_up_functions = {
	[creative_mode_defines.names.entities.creative_chest] = function(entity)
		-- Creative Chests are added after Creative Provider Chests with the same logic.
		if not global.creative_mode.creative_chest_data_groups[global.creative_mode.creative_chest_next_place_group] then
			global.creative_mode.creative_chest_data_groups[global.creative_mode.creative_chest_next_place_group] = {}
		end
		table.insert(
			global.creative_mode.creative_chest_data_groups[global.creative_mode.creative_chest_next_place_group],
			{
				entity = entity, -- The creative-chest entity.
				filtered_slots = {}, -- The slot indexes that are filtered out in this chest.
				inventory_display_mode = creative_chest_util.inventory_display_modes.original_mode, -- The inventory display mode.
				is_cargo_wagon = false -- Whether the entity is cargo wagon, such that when its speed is not 0, we should find the cargo-wagon inventory if output inventory is nil (when it is moving).
			}
		)
		-- Increase the group number for the next chest.
		if global.creative_mode.creative_chest_next_place_group < global.creative_mode.creative_provider_chest_num_in_cycle then
			global.creative_mode.creative_chest_next_place_group = global.creative_mode.creative_chest_next_place_group + 1
		else
			global.creative_mode.creative_chest_next_place_group = 1
		end
	end,
	[creative_mode_defines.names.entities.creative_provider_chest] = function(entity)
		-- Creative Provider Chests are divided into groups.
		if
			not global.creative_mode.creative_provider_chest_data_groups[
				global.creative_mode.creative_provider_chest_next_place_group
			]
		 then
			global.creative_mode.creative_provider_chest_data_groups[
					global.creative_mode.creative_provider_chest_next_place_group
				] = {}
		end
		table.insert(
			global.creative_mode.creative_provider_chest_data_groups[
				global.creative_mode.creative_provider_chest_next_place_group
			],
			{
				entity = entity, -- The creative-chest entity.
				filtered_slots = {}, -- The slot indexes that are filtered out in this chest.
				inventory_display_mode = creative_chest_util.inventory_display_modes.original_mode, -- The inventory display mode.
				is_cargo_wagon = false -- Whether the entity is cargo wagon, such that when its speed is not 0, we should find the cargo-wagon inventory if output inventory is nil (when it is moving).
			}
		)
		-- Increase the group number for the next chest.
		if
			global.creative_mode.creative_provider_chest_next_place_group <
				global.creative_mode.creative_provider_chest_num_in_cycle
		 then
			global.creative_mode.creative_provider_chest_next_place_group =
				global.creative_mode.creative_provider_chest_next_place_group + 1
		else
			global.creative_mode.creative_provider_chest_next_place_group = 1
		end
	end,
	[creative_mode_defines.names.entities.autofill_requester_chest] = function(entity)
		table.insert(global.creative_mode.autofill_requester_chest, entity)
	end,
	[creative_mode_defines.names.entities.duplicating_chest] = function(entity)
		table.insert(
			global.creative_mode.duplicating_chest_data,
			{
				entity = entity,
				lock_item = false, -- Whether the item to be duplicated is locked.
				locked_item_name = nil -- Name of the item to be duplicated even if the first slot is empty.
			}
		)
	end,
	[creative_mode_defines.names.entities.duplicating_provider_chest] = function(entity)
		table.insert(
			global.creative_mode.duplicating_provider_chest_data,
			{
				entity = entity,
				lock_item = false, -- Whether the item to be duplicated is locked.
				locked_item_name = nil -- Name of the item to be duplicated even if the first slot is empty.
			}
		)
	end,
	[creative_mode_defines.names.entities.void_requester_chest] = function(entity)
		table.insert(global.creative_mode.void_requester_chest, entity)
	end,
	[creative_mode_defines.names.entities.void_chest] = function(entity)
		table.insert(global.creative_mode.void_chest, entity)
	end,
	[creative_mode_defines.names.entities.void_storage_chest] = function(entity)
		table.insert(global.creative_mode.void_storage_chest, entity)
	end,
	[creative_mode_defines.names.entities.creative_cargo_wagon] = function(entity)
		-- Creative Cargo Wagons are divided into groups.
		if
			not global.creative_mode.creative_cargo_wagon_data_groups[global.creative_mode.creative_cargo_wagon_next_place_group]
		 then
			global.creative_mode.creative_cargo_wagon_data_groups[global.creative_mode.creative_cargo_wagon_next_place_group] = {}
		end
		table.insert(
			global.creative_mode.creative_cargo_wagon_data_groups[global.creative_mode.creative_cargo_wagon_next_place_group],
			{
				entity = entity, -- The creative-cargo-wagon entity.
				filtered_slots = {}, -- The slot indexes that are filtered out in this wagon.
				inventory_display_mode = creative_chest_util.inventory_display_modes.original_mode, -- The inventory display mode.
				is_cargo_wagon = true -- Whether the entity is cargo wagon, such that when its speed is not 0, we should find the cargo-wagon inventory if output inventory is nil (when it is moving).
			}
		)
		-- Increase the group number for the next cargo wagon.
		if global.creative_mode.creative_cargo_wagon_next_place_group < global.creative_mode.creative_cargo_wagon_num_in_cycle then
			global.creative_mode.creative_cargo_wagon_next_place_group =
				global.creative_mode.creative_cargo_wagon_next_place_group + 1
		else
			global.creative_mode.creative_cargo_wagon_next_place_group = 1
		end
	end,
	[creative_mode_defines.names.entities.duplicating_cargo_wagon] = function(entity)
		table.insert(
			global.creative_mode.duplicating_cargo_wagon_data,
			{
				entity = entity,
				lock_item = false, -- Whether the item to be duplicated is locked.
				locked_item_name = nil -- Name of the item to be duplicated even if the first slot is empty.
			}
		)
	end,
	[creative_mode_defines.names.entities.void_cargo_wagon] = function(entity)
		table.insert(global.creative_mode.void_cargo_wagon, entity)
	end,
	[creative_mode_defines.names.entities.super_roboport] = function(entity)
		table.insert(global.creative_mode.super_roboport, entity)
	end,
	[creative_mode_defines.names.entities.fluid_source] = function(entity)
		table.insert(global.creative_mode.fluid_source, entity)
	end,
	[creative_mode_defines.names.entities.fluid_void] = function(entity)
		table.insert(global.creative_mode.fluid_void, entity)
	end,
	[creative_mode_defines.names.entities.super_boiler] = function(entity)
		table.insert(global.creative_mode.super_boiler, entity)
	end,
	[creative_mode_defines.names.entities.super_cooler] = function(entity)
		table.insert(global.creative_mode.super_cooler, entity)
	end,
	[creative_mode_defines.names.entities.configurable_super_boiler] = function(entity)
		table.insert(
			global.creative_mode.configurable_super_boiler_data,
			{
				entity = entity,
				temperature = 100.0
			}
		)
	end,
	[creative_mode_defines.names.entities.heat_source] = function(entity)
		table.insert(global.creative_mode.heat_source, entity)
	end,
	[creative_mode_defines.names.entities.heat_void] = function(entity)
		table.insert(global.creative_mode.heat_void, entity)
	end,
	[creative_mode_defines.names.entities.item_source] = function(entity)
		table.insert(
			global.creative_mode.item_source_data,
			{
				entity = entity, -- The matter-source entity.
				slot1_inserted_players = nil, -- The players who have been inserted the item in the first slot.
				slot1_last_item_position_on_belt = nil, -- The position of the last inserted item to a transport belt by the first slot.
				slot2_inserted_players = nil, -- The players who have been inserted the item in the second slot.
				slot2_last_item_position_on_belt = nil, -- The position of the last inserted item to a transport belt by the second slot.
				last_working_transport_belt = nil, -- The transport belt it is working for since the last tick. This cache is used for reducing the needs for calling LuaSurface::find_entity.
				last_working_transport_belt_type = 0, -- The type of the transport belt.
				last_working_static_container = nil, -- The non-movable container (chest, logistic chest, pipe, assembling machine, rocket silo, furnace, roboport, etc.) it is working for since the last tick.
				last_working_static_container_inventories = nil, -- The table of inventories that the static container have.
				last_working_static_container_type = static_item_container_type.unknown, -- Type of the container.
				last_direction = entity.direction, -- The direction of the matter source since the last tick. Of course we need this to verify the last working entity.
				can_insert_to_vehicle = true, -- Whether it can insert items into vehicles.
				can_insert_to_player = true, -- Whether it can insert items into players.
				insert_only_once_to_player = true, -- Whether it will insert the items only once into the same player before he/she moves away and comes back.
				insert_to_player_amount = 1, -- Number of items to be inserted into the player in each time. Only works if insert_only_once_to_player is true.
				insert_to_player_by_stack = true, -- If true, insert_to_player_amount means number of item stacks. Otherwise, it means the number of individual items.
				can_drop_on_ground = false -- Whether it can drop items to the ground if nothing is in front of it.
			}
		)
	end,
	[creative_mode_defines.names.entities.duplicator] = function(entity)
		table.insert(
			global.creative_mode.duplicator_data,
			{
				entity = entity, -- The duplicator entity.
				line1_last_item_position_on_belt = nil, -- The position of the last inserted item on the first line of a transport belt.
				line2_last_item_position_on_belt = nil, -- The position of the last inserted item on the second line of a transport belt.
				last_working_transport_belt = nil, -- The transport belt it is working for since the last tick. This cache is used for reducing the needs for calling LuaSurface::find_entity.
				last_working_transport_belt_type = 0, -- The type of the transport belt.
				last_working_static_container = nil, -- The non-movable container (chest, logistic chest, assembling machine, rocket silo, furnace, roboport, etc.) it is working for since the last tick.
				last_working_static_container_inventories = nil, -- The table of inventories that the static container have.
				last_working_static_fluidbox = nil, -- The non-movable fluidbox (pipe, storage tank, boiler, generator, fluid-turret, etc.) it is working for since the last tick.
				last_direction = entity.direction, -- The direction of the duplicator since the last tick. Of course we need this to verify the last working entity.
				can_duplicate_in_vehicle = true, -- Whether it can duplicate items in vehicles.
				can_duplicate_in_player = false -- Whether it can duplicate items in players.
			}
		)
	end,
	[creative_mode_defines.names.entities.item_void] = function(entity)
		table.insert(
			global.creative_mode.item_void_data,
			{
				entity = entity, -- The matter-void entity.
				last_working_transport_belt = nil, -- The transport belt it is working for since the last tick. This cache is used for reducing the needs for calling LuaSurface::find_entity.
				last_working_transport_belt_type = 0, -- The type of the transport belt.
				last_working_static_container = nil, -- The non-movable container (chest, logistic chest, pipe, assembling machine, rocket silo, furnace, roboport, etc.) it is working for since the last tick.
				last_working_static_container_inventories = nil, -- The table of inventories that the static container have.
				last_working_static_fluidbox = nil, -- The non-movable fluidbox (pipe, storage tank, boiler, generator, fluid-turret, etc.) it is working for since the last tick.
				last_direction = entity.direction, -- The direction of the matter void since the last tick. Of course we need this to verify the last working entity.
				can_remove_from_vehicle = false, -- Whether it can remove items from vehicles.
				can_remove_from_player = false, -- Whether it can remove items from players.
				can_remove_from_ground = true -- Whether it can remove items from ground.
			}
		)
	end,
	[creative_mode_defines.names.entities.random_item_source] = function(entity)
		-- The same structure as matter source data.
		table.insert(
			global.creative_mode.random_item_source_data,
			{
				entity = entity, -- The random-item-source entity.
				slot1_inserted_players = nil, -- The players who have been inserted the item in the first slot.
				slot1_last_item_position_on_belt = nil, -- The position of the last inserted item to a transport belt by the first slot.
				slot2_inserted_players = nil, -- The players who have been inserted the item in the second slot.
				slot2_last_item_position_on_belt = nil, -- The position of the last inserted item to a transport belt by the second slot.
				last_working_transport_belt = nil, -- The transport belt it is working for since the last tick. This cache is used for reducing the needs for calling LuaSurface::find_entity.
				last_working_transport_belt_type = 0, -- The type of the transport belt.
				last_working_static_container = nil, -- The non-movable container (chest, logistic chest, pipe, assembling machine, rocket silo, furnace, roboport, etc.) it is working for since the last tick.
				last_working_static_container_inventories = nil, -- The table of inventories that the static container have.
				last_working_static_container_type = static_item_container_type.unknown, -- Type of the container.
				last_direction = entity.direction, -- The direction of the random item source since the last tick. Of course we need this to verify the last working entity.
				can_insert_to_vehicle = true, -- Whether it can insert items into vehicles.
				can_insert_to_player = true, -- Whether it can insert items into players.
				insert_only_once_to_player = true, -- Whether it will insert the items only once into the same player before he/she moves away and comes back.
				insert_to_player_amount = 1, -- Number of items to be inserted into the player in each time. Only works if insert_only_once_to_player is true.
				insert_to_player_by_stack = true, -- If true, insert_to_player_amount means number of item stacks. Otherwise, it means the number of individual items.
				can_drop_on_ground = false -- Whether it can drop items to the ground if nothing is in front of it.
			}
		)
	end,
	[creative_mode_defines.names.entities.creative_lab] = function(entity)
		table.insert(global.creative_mode.creative_lab, entity)
	end,
	[creative_mode_defines.names.entities.energy_source] = function(entity)
		table.insert(global.creative_mode.energy_source, entity)
	end,
	[creative_mode_defines.names.entities.passive_energy_source] = function(entity)
		table.insert(global.creative_mode.passive_energy_source, entity)
	end,
	[creative_mode_defines.names.entities.energy_void] = function(entity)
		table.insert(global.creative_mode.energy_void, entity)
	end,
	[creative_mode_defines.names.entities.passive_energy_void] = function(entity)
		table.insert(global.creative_mode.passive_energy_void, entity)
	end,
	[creative_mode_defines.names.entities.super_radar] = function(entity)
		table.insert(global.creative_mode.super_radar, entity)
	end,
	[creative_mode_defines.names.entities.super_radar_2] = function(entity)
		table.insert(global.creative_mode.super_radar, entity)
	end,
	[creative_mode_defines.names.entities.super_beacon] = function(entity)
		table.insert(global.creative_mode.super_beacon, entity)
	end,
	[creative_mode_defines.names.entities.alien_attractor_proxy_small] = function(entity)
		entity.surface.build_enemy_base(entity.position, 5)
	end,
	[creative_mode_defines.names.entities.alien_attractor_proxy_medium] = function(entity)
		entity.surface.build_enemy_base(entity.position, 20)
	end,
	[creative_mode_defines.names.entities.alien_attractor_proxy_large] = function(entity)
		entity.surface.build_enemy_base(entity.position, 100)
	end
}

-- Registers the given entity if needed.
function global_util.register_entity(entity)
	if register_entity_look_up_functions[entity.name] then
		register_entity_look_up_functions[entity.name](entity)
	end
end
