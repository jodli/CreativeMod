-- This file manages event-related variables or functions that are specific for this mod.
-- But the GUI related events are in gui.lua instead.
if not events then
    events = {}
end

-- Calls the remote functions.
local function call_remote_functions()
    -- Exclude the alien attractors from keep last item.
    remote.call("creative-mode", "exclude_from_keep_last_item", creative_mode_defines.names.items.alien_attractor_small)
    remote.call("creative-mode", "exclude_from_keep_last_item", creative_mode_defines.names.items.alien_attractor_medium)
    remote.call("creative-mode", "exclude_from_keep_last_item", creative_mode_defines.names.items.alien_attractor_large)
    -- Also run the examples, after our interface is ready for that.
    -- Example: register the remote function register_by_remote_function_example_1 to the modding UI.
    remote.call("creative-mode", "register_remote_function_to_modding_ui", "creative-mode", --  Interface name
    "register_by_remote_function_example_1" -- Function name
    )

    --[[
	-- Demo for subscribing and using the custom events.
	script.on_event(remote.call("creative-mode", "on_enabled"), function(event)
		game.print("Test: Creative Mode enabled!")
	end)
	script.on_event(remote.call("creative-mode", "on_disabled"), function(event)
		game.print("Test: Creative Mode disabled!")
	end)
	--]]

    --[[
	-- Demo for excluding an item from the keep-last-item personal cheat.
	remote.call("creative-mode", "exclude_from_keep_last_item", "assembling-machine-2")
	--]]

    --[[
	-- Demo for excluding an entity from the instant-blueprint personal cheat.
	remote.call("creative-mode", "exclude_from_instant_blueprint", "assembling-machine-3")
	--]]

    --[[
	-- Demo for excluding an entity from the instant-deconstruction personal cheat.
	remote.call("creative-mode", "exclude_from_instant_deconstruction", "oil-refinery")
	--]]
end

-- Callback of the on_init event, which is invoked when a new game is started.
function events.on_init()
    -- Initializes meta-table.
    global_util.initialize_or_update_global()

    -- Generate event IDs if they are not generated.
    remote_interface.get_or_load_on_enabled_event_id()
    remote_interface.get_or_load_on_disabled_event_id()

    -- Call remote functions.
    call_remote_functions()

    -- Initializes the item lists.
    global_util.initialize_item_lists_if_not_exist()
end

-- Callback of the on_load event, which is invoked when an existing game is loaded.
-- The global table should not be touched here.
function events.on_load(event)
    -- Generate event IDs if they are not generated.
    remote_interface.get_or_load_on_enabled_event_id()
    remote_interface.get_or_load_on_disabled_event_id()

    -- Call remote functions.
    call_remote_functions()
end

-- Callback of the on_configuration_changed event, which is invoked when the game version or any active mods changed.
function events.on_configuration_changed(data)
    -- Game version changed?
    local is_game_changed = data.old_version ~= data.new_version
    -- Any mod changed?
    local is_any_mod_changed = data.mod_changes ~= nil
    -- Is this mod changed?
    local is_our_mod_changed = false
    if is_any_mod_changed then
        is_our_mod_changed = data.mod_changes[creative_mode_defines.mod_id] ~= nil
    end
    -- Is this mod just installed for an existing game?
    local is_our_mod_new = false
    if is_our_mod_changed then
        is_our_mod_new = data.mod_changes[creative_mode_defines.mod_id].old_version == nil and
                             data.mod_changes[creative_mode_defines.mod_id].new_version ~= nil
    end

    -- If our mod has changed (whether version is different or the mod is new for existing game), new meta-tables may be needed. Initializes them if needed.
    if is_our_mod_changed then
        global_util.initialize_or_update_global()

        if not is_our_mod_new then
            local our_mod_old_version = data.mod_changes[creative_mode_defines.mod_id].old_version
            local our_mod_new_version = data.mod_changes[creative_mode_defines.mod_id].new_version
            global_util.update_global_as_our_mod_updated(our_mod_old_version, our_mod_new_version)

            if our_mod_old_version < "0.2.0" and our_mod_new_version >= "0.2.0" then
                -- Big changes in the GUI system in v0.2.0, so we have to force close the opened GUI.
                for _, player in pairs(game.players) do
                    gui_entity.create_or_destroy_gui_of_entity(player, nil, false)
                end
                -- Destroy more cheats popup.
                gui.destroy_more_cheats_popup()
                -- Create main menu button if Creative Mode is enabled.
                gui_menu.create_or_destroy_main_menu_open_button_for_all_players()
            end
        end

        -- Make sure the main menu and modifer popup is closed whenever our mod version has changed.
        for _, player in pairs(game.connected_players) do
            gui_menu.destroy_main_menu_for_player(player)
            gui_menu_magicwand.create_or_destroy_modification_popup_for_player(player, false)
        end
    end

    -- For game version changed or any mod changed, item list needs to be updated.
    if not global_util.item_lists_exist() or is_game_changed or is_any_mod_changed then
        global_util.renew_item_lists()
    end

    -- If creative mode is already enabled, we will also need to make sure all of our recipes are enabled in case there are new recipes for new items.
    if is_game_changed or is_any_mod_changed then
        local team_cheat_creative_tools_recipes = cheats.team_cheats_data.cheats.creative_tools_recipes
        for _, force in pairs(game.forces) do
            if team_cheat_creative_tools_recipes.get_value_function(force) then
                team_cheat_creative_tools_recipes.apply_to_target_function(force, true, nil)
            end
        end
    end
end

-- Callback of the on_runtime_mod_setting_changed event, which is invoked when a runtime mod setting is changed by a player.
local function on_runtime_mod_setting_changed(event)
    local setting = event.setting
    if setting == creative_mode_defines.names.settings.creative_chest_contains_hidden_items or setting ==
        creative_mode_defines.names.settings.creative_cargo_wagon_contains_hidden_items then
        -- Creative chest contains hidden items.
        creative_chest_util.update_item_lists_data()
        game.print {"message.creative-mode_creative-chest-item-group-updated"}
    end
end

--------------------------------------------------------------------

-- Callback of the on_tick event.
function events.on_tick()
    -- Auto enable Creative Mode or ask for enabling it if not asked before.
    -- It is not shown in the 0th tick so the message box has to be closed before the popup is shown.
    if not global.creative_mode.has_asked_for_enable and not global.creative_mode.enabled then
        if game.tick >= 1 then
            -- Wait until the initial cutscene is over.
            -- We wait until there's at least one connected player not currently
            -- in a cutscene. There are likely ways to sneak around these
            -- checks, but it works perfect for Factorio 1.0's scenarios.
            local player = game.players[1]
            if player ~= nil and player.controller_type ~= defines.controllers.cutscene then
                global.creative_mode.has_asked_for_enable = true
                -- Check the default initial action in settings.
                local default_initial_action = settings.global[creative_mode_defines.names.settings
                                                   .default_initial_action].value
                if default_initial_action == creative_mode_defines.values.default_initial_actions.enable then
                    -- Enable CM.
                    cheats.enable_or_disable_creative_mode(player, true, false, false, true)
                elseif default_initial_action == creative_mode_defines.values.default_initial_actions.enable_all then
                    -- Enable all cheats.
                    cheats.enable_or_disable_creative_mode(player, true, false, true, true)
                elseif default_initial_action == creative_mode_defines.values.default_initial_actions.disable then
                    -- Disable CM.
                    cheats.enable_or_disable_creative_mode(player, false, false, false, true)
                elseif default_initial_action ==
                    creative_mode_defines.values.default_initial_actions.disable_permanently then
                    -- Disable permanently.
                    cheats.enable_or_disable_creative_mode(player, false, true, false, true)
                else
                    -- Default: show popup.
                    gui.show_main_popup(player, gui.main_popup_content_type.enable_creative_mode)
                end
            end
        end
    end

    -- Cheats should be executed first, so entities can be updated immediately after they are built by instant blueprint.
    gui.tick()
    cheats.tick()

    creative_chest_util.tick()
    creative_chest.tick()
    creative_lab.tick()
    void_lab.tick()
    creative_provider_chest.tick()
    autofill_requester_chest.tick()
    duplicating_chest.tick()
    duplicating_provider_chest.tick()
    void_requester_chest.tick()
    void_chest.tick()
    void_storage_chest.tick()
    creative_cargo_wagon.tick()
    duplicating_cargo_wagon.tick()
    void_cargo_wagon.tick()
    super_roboport.tick()
    fluid_source.tick()
    fluid_void.tick()
    super_boiler.tick()
    super_cooler.tick()
    configurable_super_boiler.tick()
    heat_source.tick()
    heat_void.tick()
    item_source.tick()
    duplicator.tick()
    item_void.tick()
    random_item_source.tick()
    energy_source.tick()
    passive_energy_source.tick()
    energy_void.tick()
    passive_energy_void.tick()
    super_radar.tick()
    super_beacon.tick()
    equipments.tick()
end

--------------------------------------------------------------------

-- Callback of the on_pre_build event, which is invoked when a player uses item to build something.
local function on_pre_build(event)
    local player = game.players[event.player_index]
    cheats.on_pre_build(player)
end

-- Callback of the on_built_entity event, which is invoked when an entity is built by player.
local function on_built_entity(event)
    local player = game.players[event.player_index]
    local entity = event.created_entity
    local is_entity_ghost = entity.name == "entity-ghost"
    local is_tile_ghost = entity.name == "tile-ghost"
    local is_ghost = is_entity_ghost or is_tile_ghost
    local is_item_request_proxy = entity.name == "item-request-proxy"

    -- Pass to cheats.lua to verify the built entity.
    cheats.on_built_entity(player, entity, is_ghost, is_entity_ghost, is_item_request_proxy)

    -- Register the built entity if it is one of the creative entities and it needs to be updated via script.
    global_util.register_entity(entity)
end

-- Callback of the script_raised_built event, which is invoked when an entity is revived by robot.
local function script_raised_revive(event)
    global_util.register_entity(event.entity)
end

-- Returns whether the given entity is a member of the Creative Chest family (i.e. Creative Chest or Creative Provider Chest).
local function is_entity_creative_chest_family(entity)
    -- Creative chest.
    if entity.name == creative_mode_defines.names.entities.creative_chest then
        return true
    end
    -- Creative provider chest.
    if entity.name == creative_mode_defines.names.entities.creative_provider_chest then
        return true
    end
    -- Creative cargo wagon.
    if entity.name == creative_mode_defines.names.entities.creative_cargo_wagon then
        return true
    end

    return false
end

-- Returns whether the given entity is a member of the Duplicating Chest family (i.e. Duplicating Chest or Duplicating Provider Chest).
local function is_entity_duplicating_chest_family(entity)
    -- Duplicating chest.
    if entity.name == creative_mode_defines.names.entities.duplicating_chest then
        return true
    end
    -- Duplicating provider chest.
    if entity.name == creative_mode_defines.names.entities.duplicating_provider_chest then
        return true
    end
    -- Duplicating cargo wagon.
    if entity.name == creative_mode_defines.names.entities.duplicating_cargo_wagon then
        return true
    end

    return false
end

-- Returns whether the given entity is a member of the Void Chest Family (i.e. Void Requester Chest or Void Storage Chest).
local function is_entity_void_chest_family(entity)
    -- Void requester chest.
    if entity.name == creative_mode_defines.names.entities.void_requester_chest then
        return true
    end
    -- Void chest.
    if entity.name == creative_mode_defines.names.entities.void_chest then
        return true
    end
    -- Void storage chest.
    if entity.name == creative_mode_defines.names.entities.void_storage_chest then
        return true
    end
    -- Void cargo wagon.
    if entity.name == creative_mode_defines.names.entities.void_cargo_wagon then
        return true
    end
end

-- Clears the inventory of the given entity before it is mined so that player will not be filled by the items inside it and robots will not need to clear it before deconstruction.
-- Nothing will be done if such action is not necessary according to the entity type.
-- Returns whether the inventory is cleared.
local function clear_inventory_before_mined_if_needed(entity)
    -- Creative chest family.
    if is_entity_creative_chest_family(entity) then
        local inventory = creative_chest_util.get_inventory(entity)
        inventory.clear()
        return true
    end

    -- Autofill requester chest.
    if entity.name == creative_mode_defines.names.entities.autofill_requester_chest then
        entity.get_output_inventory().clear()
        return true
    end

    -- Duplicating chest family.
    if is_entity_duplicating_chest_family(entity) then
        local inventory = duplicating_chest_util.get_inventory(entity)
        inventory.clear()
        return true
    end

    -- Void chest family.
    if is_entity_void_chest_family(entity) then
        local inventory = void_chest_util.get_inventory(entity)
        inventory.clear()
        return true
    end

    -- Creative lab.
    if entity.name == creative_mode_defines.names.entities.creative_lab then
        local inventory = entity.get_inventory(defines.inventory.lab_input)
        if inventory then
            inventory.clear()
            return true
        end
    end

    return false
end

-- Callback of the on_preplayer_mined_item event, which is invoked just before a player starts mining something.
local function on_preplayer_mined_item(event)
    -- Clear inventory if needed.
    clear_inventory_before_mined_if_needed(event.entity)
    -- Apply cheats.
    cheats.on_preplayer_mined_item(event.player_index, event.entity)
end

-- Callback of the on_marked_for_deconstruction event, which is invoked when an entity is marked for deconstruction.
local function on_marked_for_deconstruction(event)
    -- Clear inventory if needed.
    clear_inventory_before_mined_if_needed(event.entity)

    -- Apply cheats, e.g. instant deconstruction.
    cheats.on_marked_for_deconstruction(event.player_index, event.entity)
end

-- Callback of the on_entity_settings_pasted event, which is invoked after entity copy-paste is done.
local function on_entity_settings_pasted(event)
    -- If both the source and destination entities are members of the Creative Chest family, move the destination chest to the group number of the source chest.
    if is_entity_creative_chest_family(event.source) and is_entity_creative_chest_family(event.destination) then
        creative_chest_util.on_entity_copied_pasted(event.source, event.destination)
        return
    end

    -- If both the source and destination entities are members of the Duplicating Chest family, copy the contents from the source chest to the destination chest.
    if is_entity_duplicating_chest_family(event.source) and is_entity_duplicating_chest_family(event.destination) then
        duplicating_chest_util.on_entity_copied_pasted(event.source, event.destination)
        return
    end

    -- If both the source and destination entities are Configurable Super Boilers...
    if event.source.name == creative_mode_defines.names.entities.configurable_super_boiler and event.destination.name ==
        event.source.name then
        configurable_super_boiler.on_entity_copied_pasted(event.source, event.destination)
        return
    end

    -- If both the source and destination entities are Matter Sources...
    if event.source.name == creative_mode_defines.names.entities.item_source and event.destination.name ==
        event.source.name then
        item_source.on_entity_copied_pasted(event.source, event.destination)
        return
    end

    -- If both the source and destination entities are Matter Duplicators...
    if event.source.name == creative_mode_defines.names.entities.duplicator and event.destination.name ==
        event.source.name then
        duplicator.on_entity_copied_pasted(event.source, event.destination)
        return
    end

    -- If both the source and destination entities are Matter Voids...
    if event.source.name == creative_mode_defines.names.entities.item_void and event.destination.name ==
        event.source.name then
        item_void.on_entity_copied_pasted(event.source, event.destination)
        return
    end
end

-- Callback of the on_player_created event, which is invoked after a player is created.
local function on_player_created(event)
    local player = game.players[event.player_index]
    gui_menu.create_or_destroy_main_menu_open_button_for_player(player)
end

-- Callback of the on_player_respawned event, which is invoked after a player is respawned.
local function on_player_respawned(event)
    cheats.on_player_respawned(event)
end

-- Callback of the on_player_joined_game event, which is invoked after a player joined a multiplayer game.
local function on_player_joined_game(event)
    cheats.on_player_joined_game(event)
    gui.on_player_joined_game(event)
end

-- Callback of the on_player_left_game event, which is invoked after a player left a multiplayer game.
local function on_player_left_game(event)
    gui.on_player_left_game(event)
end

-- Callback of the on_player_changed_surface event, which is invoked after a player went to another surface.
local function on_player_changed_surface(event)
    gui.on_player_changed_surface(event)
end

-- Callback of the on_player_cursor_stack_changed event, which is invoked after a player picks up or puts down an item stack.
local function on_player_cursor_stack_changed(event)
    gui.on_player_cursor_stack_changed(event)
end

-- Callback of the on_player_selected_area event, which is invoked after a player selected an area with a selection-tool item.
local function on_player_selected_area(event)
    local player = game.players[event.player_index]
    local area = event.area
    local item_name = event.item
    local entities = event.entities
    local tiles = event.tiles

    -- Forward the event to magic wand - creator.
    if magic_wand_creator.on_player_selected_area(player, area, item_name, entities, tiles) then
        return
    end
    -- Forward the event to magic wand - healer.
    if magic_wand_healer.on_player_selected_area(player, area, item_name, entities, tiles) then
        return
    end
    -- Forward the event to magic wand - modifier.
    if magic_wand_modifier.on_player_selected_area(player, area, item_name, entities, tiles) then
        return
    end
end

-- Callback of the on_player_alt_selected_area event, which is invoked after a player alt-selected an area with a selection-tool item.
local function on_player_alt_selected_area(event)
    local player = game.players[event.player_index]
    local area = event.area
    local item_name = event.item
    local entities = event.entities
    local tiles = event.tiles

    -- Forward the event to magic wand - creator.
    if magic_wand_creator.on_player_alt_selected_area(player, area, item_name, entities, tiles) then
        return
    end
    -- Forward the event to magic wand - healer.
    if magic_wand_healer.on_player_alt_selected_area(player, area, item_name, entities, tiles) then
        return
    end
    -- Forward the event to magic wand - modifier.
    if magic_wand_modifier.on_player_alt_selected_area(player, area, item_name, entities, tiles) then
        return
    end
end

-- Callback of the on_player_placed_equipment event, which is invoked after a player placed an equipment into equipment grid.
local function on_player_placed_equipment(event)
    local equipment = event.equipment

    -- Register the equipments that need to be refilled with energy.
    if equipment.name == creative_mode_defines.names.equipments.super_personal_roboport_equipment then
        table.insert(global.energy_refill_equipments, equipment)
    end
end

-- Callback of the on_research_started event, which is invoked after a research is started.
local function on_research_started(event)
    cheats.on_research_started(event)
end

-- Callback of the on_chunk_generated event, which is invoked after a chunk is generated.
local function on_chunk_generated(event)
    cheats.on_chunk_generated(event)
end

-- Callback of the on_gui_closed event. Forward to gui.lua
local function on_gui_closed(event)
    gui.on_gui_closed(event)
end

-- Callback of the on_gui_click event. Forward to gui.lua.
local function on_gui_click(event)
    gui.on_gui_click(event)
end

-- Callback of the on_gui_text_changed event. Forward to gui.lua.
local function on_gui_text_changed(event)
    gui.on_gui_text_changed(event)
end

-- Callback of the on_gui_checked_state_changed evnet. Forward to gui.lua.
local function on_gui_checked_state_changed(event)
    gui.on_gui_checked_state_changed(event)
end

-- Callback of the on_gui_selection_state_changed event. Forward to gui.lua.
local function on_gui_selection_state_changed(event)
    gui.on_gui_selection_state_changed(event)
end

-- The look up table for forwarding events to the corresponding handlers.
local event_handlers_look_up = {
    [defines.events.on_pre_build] = on_pre_build,
    [defines.events.on_built_entity] = on_built_entity,
    [defines.events.script_raised_revive] = script_raised_revive,
    [defines.events.on_pre_player_mined_item] = on_preplayer_mined_item,
    [defines.events.on_marked_for_deconstruction] = on_marked_for_deconstruction,
    [defines.events.on_entity_settings_pasted] = on_entity_settings_pasted,
    [defines.events.on_player_created] = on_player_created,
    [defines.events.on_player_respawned] = on_player_respawned,
    [defines.events.on_player_joined_game] = on_player_joined_game,
    [defines.events.on_player_left_game] = on_player_left_game,
    [defines.events.on_player_changed_surface] = on_player_changed_surface,
    [defines.events.on_player_selected_area] = on_player_selected_area,
    [defines.events.on_player_alt_selected_area] = on_player_alt_selected_area,
    [defines.events.on_player_cursor_stack_changed] = on_player_cursor_stack_changed,
    [defines.events.on_player_placed_equipment] = on_player_placed_equipment,
    [defines.events.on_research_started] = on_research_started,
    [defines.events.on_chunk_generated] = on_chunk_generated,
    [defines.events.on_gui_closed] = on_gui_closed,
    [defines.events.on_gui_click] = on_gui_click,
    [defines.events.on_gui_text_changed] = on_gui_text_changed,
    [defines.events.on_gui_checked_state_changed] = on_gui_checked_state_changed,
    [defines.events.on_gui_selection_state_changed] = on_gui_selection_state_changed,
    [defines.events.on_runtime_mod_setting_changed] = on_runtime_mod_setting_changed
}

-- Does nothing.
local function get_empty_message(log_prefix, param_name, param)
    return nil
end

-- Prints Entity parameter.
local function get_entity_param_message(log_prefix, param_name, param)
    local entity_type = param.type
    local entity_name = param.name
    local message = log_prefix
    if param_name ~= '' then
        message = message .. '"' .. param_name .. '"'
    end
    message = message .. ' :: LuaEntity: {type = "' .. entity_type .. '", name = "' .. entity_name .. '"'
    if param.valid then
        if entity_name == "entity-ghost" or entity_name == "tile-ghost" then
            message = message .. ', ghost_name = "' .. param.ghost_name .. '"'
        end
        if entity_type == "item-entity" then
            local stack = param.stack
            message = message .. ', stack = {type = "' .. stack.type .. '", name = "' .. stack.name .. '", count = ' ..
                          stack.count .. "}"
        end
        if param.backer_name then
            message = message .. ', backer_name = "' .. param.backer_name .. '"'
        end
        if param.unit_number then
            message = message .. ", unit_number = " .. param.unit_number
        end
        message = message .. ", position = {" .. param.position.x .. ", " .. param.position.y .. "}"
    else
        message = message .. ", valid = false"
    end
    message = message .. "}"
    return message
end

-- Prints Prototype parameter.
local function get_prototype_param_message(log_prefix, param_name, param)
    local entity_type = param.type
    local entity_name = param.name
    local message = log_prefix
    if param_name ~= '' then
        message = message .. '"' .. param_name .. '"'
    end
    message = message .. ' :: LuaItemPrototype: {type = "' .. entity_type .. '", name = "' .. entity_name .. '"'
    if param.valid then
        message = message .. ", valid = true"
    else
        message = message .. ", valid = false"
    end
    message = message .. "}"
    return message
end

-- Prints table parameter.
local function get_table_param_message(log_prefix, param_name, param)
    local table = param.get()

    local message = log_prefix .. '"' .. param_name .. '" table :: {'
    for i, entry in ipairs(table) do
        message = message .. get_entity_param_message(i, '', entry)
        if next(table, i) ~= nil then
            message = message .. ', '
        end
    end
    message = message .. '}'
    return message
end

-- Prints uint parameter.
local function get_uint_param_message(log_prefix, param_name, param)
    return (log_prefix .. '"' .. param_name .. '" :: uint: ' .. param)
end

-- Prints BoundingBox parameter.
local function get_boundingbox_param_message(log_prefix, param_name, param)
    return (log_prefix .. '"' .. param_name .. '" :: BoundingBox: {left_top = (' .. param.left_top.x .. ", " ..
               param.left_top.y .. "), right_bottom = (" .. param.right_bottom.x .. ", " .. param.right_bottom.y .. ")}")
end

-- Prints Surface parameter.
local function get_surface_param_message(log_prefix, param_name, param)
    local message = log_prefix .. '"' .. param_name .. '" :: LuaSurface: {name = "' .. param.name .. '", index = ' ..
                        param.index .. '"'
    if not param.valid then
        message = message .. ", valid = false"
    end
    message = message .. "}"
    return message
end

-- Prints Force parameter.
local function get_force_param_message(log_prefix, param_name, param)
    local message = log_prefix .. '"' .. param_name .. '" :: LuaForce: {name = "' .. param.name .. '"'
    if not param.valid then
        message = message .. ", valid = false"
    end
    message = message .. "}"
    return message
end

-- Prints GuiElement parameter.
local function get_guielement_param_message(log_prefix, param_name, param)
    local message = log_prefix .. '"' .. param_name .. '" :: LuaGuiElement: {name = "' .. param.name .. '", type = "' ..
                        param.type .. '"'
    if not param.valid then
        message = message .. ", valid = false"
    end
    message = message .. "}"
    return message
end

-- Prints SimpleItemStack parameter.
local function get_simpleitemstack_param_message(log_prefix, param_name, param)
    return (log_prefix .. '"' .. param_name .. '" :: LuaItemStack: {name = "' .. param.name .. '", count = ' ..
               param.count .. "}")
end

-- Prints string parameter.
local function get_string_param_message(log_prefix, param_name, param)
    return (log_prefix .. '"' .. param_name .. '" :: string: "' .. param .. '"')
end

-- Prints Equipment parameter.
local function get_equipment_param_message(log_prefix, param_name, param)
    local message = log_prefix .. '"' .. param_name .. '" :: LuaEquipment: {type = "' .. param.type .. '", name = "' ..
                        param.name .. '"'
    if param.valid then
        message = message .. ", position = {" .. param.position.x .. ", " .. param.position.y .. "}"
    else
        message = message .. ", valid = false"
    end
    message = message .. "}"
    return message
end

-- Prints EquipmentGrid parameter.
local function get_equipmentgrid_param_message(log_prefix, param_name, param)
    local message = log_prefix .. '"' .. param_name .. '" :: LuaEquipmentGrid: {width = ' .. param.width ..
                        ", height = " .. param.height
    if not param.valid then
        message = message .. ", valid = false"
    end
    message = message .. "}"
    return message
end

-- Prints Position parameter.
local function get_position_param_message(log_prefix, param_name, param)
    return (log_prefix .. '"' .. param_name .. '" :: Position: {x = ' .. param.x .. ", y = " .. param.y .. "}")
end

-- Prints Technology parameter.
local function get_technology_param_message(log_prefix, param_name, param)
    local message = log_prefix .. '"' .. param_name .. '" :: LuaTechnology: {name = "' .. param.name .. '"'
    if param.valid then
        message = message .. ", level = " .. param.level .. ", upgrade = " .. tostring(param.upgrade)
    else
        message = message .. ", valid = false"
    end
    message = message .. "}"
    return message
end

-- Prints Entity array parameter.
local function get_entity_array_param_message(log_prefix, param_name, param)
    return (log_prefix .. '"' .. param_name .. '" :: array of LuaEntity: # = ' .. #param)
end

-- Prints Tile array parameter.
local function get_tile_array_param_message(log_prefix, param_name, param)
    return (log_prefix .. '"' .. param_name .. '" :: array of LuaTile: # = ' .. #param)
end

-- Prints Position array parameter.
local function get_position_array_param_message(log_prefix, param_name, param)
    return (log_prefix .. '"' .. param_name .. '" :: array of Position: # = ' .. #param)
end

-- Prints boolean parameter.
local function get_boolean_param_message(log_prefix, param_name, param)
    return (log_prefix .. '"' .. param_name .. '" :: boolean: ' .. tostring(param))
end

-- Prints number parameter.
local function get_number_param_message(log_prefix, param_name, param)
    return (log_prefix .. '"' .. param_name .. '" :: number: ' .. param)
end

-- Returns the backer name of the given train.
local function get_train_backer_name(train)
    local front_movers = train.locomotives["front_movers"]
    if #front_movers > 0 then
        return front_movers[1].backer_name
    else
        local back_movers = train.locomotives["back_movers"]
        if #back_movers > 0 then
            return back_movers[1].backer_name
        end
    end
    return "(nil)"
end
-- Returns the train state string.
local function get_train_state_string(train)
    for key, id in pairs(defines.train_state) do
        if id == train.state then
            return "defines.train_state." .. key .. "(" .. id .. ")"
        end
    end
    return "(Unknown train state)" -- Should not be possible.
end
-- Prints Train parameter.
local function get_train_param_message(log_prefix, param_name, param)
    local valid = param.valid
    local message = log_prefix .. '"' .. param_name .. '" :: LuaTrain: {'
    if valid then
        message = message .. 'backer_name = "' .. get_train_backer_name(param) .. '", state = ' ..
                      get_train_state_string(param)
    end
    message = message .. ", manual_mode = " .. tostring(param.manual_mode) .. ", speed = " .. param.speed
    if not valid then
        message = message .. ", valid = false"
    end
    message = message .. "}"
    return message
end

-- Prints tag value as string.
local function get_string_tag_value(value)
    return tostring(value)
end
-- Prints function tag value.
local function get_function_tag_value(value)
    return "(function)"
end
-- Prints table tag value.
local function get_table_tag_value(value)
    return "(table)"
end
-- Prints userdata tag value.
local function get_userdata_tag_value(value)
    return "(userdata)"
end
-- Prints thread tag value.
local function get_thread_tag_value(value)
    return "(thread)"
end
-- Look up table for tag values according to their types.
local get_tag_value_loop_up = {
    ["nil"] = get_string_tag_value,
    ["boolean"] = get_string_tag_value,
    ["number"] = get_string_tag_value,
    ["string"] = get_string_tag_value,
    ["function"] = get_function_tag_value,
    ["table"] = get_table_tag_value,
    ["userdata"] = get_userdata_tag_value,
    ["thread"] = get_thread_tag_value
}
-- Prints tags parameter.
local function get_tags_param_message(log_prefix, param_name, param)
    local message = log_prefix .. '"' .. param_name .. '" :: dictionary string - Any: {'
    local i = 1
    for key, value in pairs(param) do
        if i >= 2 then
            message = message .. ", "
        end
        local value_type = type(value)
        message = message .. "[" .. key .. "] = " .. get_tag_value_loop_up[value_type](value)
        i = i + 1
    end
    message = message .. "}"
    return message
end

-- Prints mouse button parameter.
local function get_mouse_button_param_message(log_prefix, param_name, param)
    return (log_prefix .. '"' .. param_name .. '" :: defines.mouse_button_type: ' .. tostring(param))
end

-- Prints recipe parameter.
local function get_recipe_param_message(log_prefix, param_name, param)
    local message = log_prefix .. '"' .. param_name .. '" :: LuaRecipe: {name = ' .. param.name
    if not param.valid then
        message = message .. ", valid = false"
    end
    message = message .. "}"
    return message
end

-- Prints inventory message.
local function get_inventory_param_message(log_prefix, param_name, param)
    local message = log_prefix .. '"' .. param_name .. '" :: LuaInventory: {'
    if param.valid then
        if param.index then
            message = message .. "index = " .. param.index .. ", "
        end
        message = message .. "# = " .. #param
    else
        message = message .. "valid = false"
    end
    message = message .. "}"
    return message
end

-- The look up table for getting the messages for event parameters according to the parameter name.
local event_param_message_look_up = {
    -- Don't print for "name" and "tick"
    ["name"] = get_empty_message,
    ["tick"] = get_empty_message,
    ["created_entity"] = get_entity_param_message,
    ["player_index"] = get_uint_param_message,
    ["entity"] = get_entity_param_message,
    ["mapping"] = get_table_param_message,
    ["area"] = get_boundingbox_param_message,
    ["surface"] = get_surface_param_message,
    ["message"] = get_string_param_message,
    ["command"] = get_string_param_message,
    ["parameters"] = get_string_param_message,
    ["force"] = get_force_param_message,
    ["element"] = get_guielement_param_message,
    ["stack"] = get_simpleitemstack_param_message,
    ["item_stack"] = get_simpleitemstack_param_message,
    ["item-table"] = get_prototype_param_message,
    ["item-string"] = get_string_param_message,
    ["entities"] = get_entity_array_param_message,
    ["tiles"] = get_tile_array_param_message,
    ["positions"] = get_position_array_param_message,
    ["surface_index"] = get_uint_param_message,
    ["grid"] = get_equipmentgrid_param_message,
    ["count"] = get_uint_param_message,
    ["position"] = get_position_param_message,
    ["research"] = get_technology_param_message,
    ["robot"] = get_entity_param_message,
    ["rocket"] = get_entity_param_message,
    ["radar"] = get_entity_param_message,
    ["chunk_position"] = get_position_param_message,
    ["train"] = get_train_param_message,
    ["tags"] = get_tags_param_message,
    ["old_recipe_difficulty"] = get_uint_param_message,
    ["old_technology_difficulty"] = get_uint_param_message,
    ["cause"] = get_entity_param_message,
    ["by_script"] = get_boolean_param_message,
    ["old_name"] = get_string_param_message,
    ["button"] = get_mouse_button_param_message,
    ["alt"] = get_boolean_param_message,
    ["control"] = get_boolean_param_message,
    ["shift"] = get_boolean_param_message,
    ["market"] = get_entity_param_message,
    ["offer_index"] = get_uint_param_message,
    ["recipe"] = get_recipe_param_message,
    ["buffer"] = get_inventory_param_message,
    ["setting"] = get_string_param_message,
    ["last_entity"] = get_entity_param_message,
    ["rocket_silo"] = get_entity_param_message
}

-- Additional look up table for getting the messages for event parameters according to the parameter name and also the event ID.
-- Because some events use the same parameter name. That's why we need another look up table for separating them.
local repeated_event_param_message_look_up = {
    [defines.events.on_entity_settings_pasted] = {
        ["source"] = get_entity_param_message,
        ["destination"] = get_entity_param_message
    },
    [defines.events.on_forces_merging] = {
        ["source"] = get_force_param_message,
        ["destination"] = get_force_param_message
    },
    [defines.events.on_pre_entity_settings_pasted] = {
        ["source"] = get_entity_param_message,
        ["destination"] = get_entity_param_message
    },
    [defines.events.on_player_placed_equipment] = {
        ["equipment"] = get_equipment_param_message
    },
    [defines.events.on_player_removed_equipment] = {
        ["equipment"] = get_string_param_message
    }
}

-- Prints undocumented boolean parameter.
local function get_undocumented_boolean_param_message(log_prefix, param_name, param, allow_localised_string)
    if allow_localised_string then
        return {"gui.creative-mode_undocumented-boolean", log_prefix, param_name, tostring(param)}
    end
    return (log_prefix .. '"' .. param_name .. '" (undocumented) :: boolean: ' .. tostring(param))
end

-- Prints undocumented number parameter.
local function get_undocumented_number_param_message(log_prefix, param_name, param, allow_localised_string)
    if allow_localised_string then
        return {"gui.creative-mode_undocumented-number", log_prefix, param_name, param}
    end
    return (log_prefix .. '"' .. param_name .. '" (undocumented) :: number: ' .. param)
end

-- Prints undocumented string parameter.
local function get_undocumented_string_param_message(log_prefix, param_name, param, allow_localised_string)
    if allow_localised_string then
        return {"gui.creative-mode_undocumented-string", log_prefix, param_name, param}
    end
    return (log_prefix .. '"' .. param_name .. '" (undocumented) :: string: "' .. param .. '"')
end

-- Prints undocumented function parameter.
local function get_undocumented_function_param_message(log_prefix, param_name, param, allow_localised_string)
    if allow_localised_string then
        return {"gui.creative-mode_undocumented-function", log_prefix, param_name}
    end
    return (log_prefix .. '"' .. param_name .. '" (undocumented) :: function')
end

-- Prints undocumented table parameter.
local function get_undocumented_table_param_message(log_prefix, param_name, param, allow_localised_string)
    if allow_localised_string then
        return {"gui.creative-mode_undocumented-table", log_prefix, param_name}
    end
    return (log_prefix .. '"' .. param_name .. '" (undocumented) :: table')
end

-- Prints undocumented userdata parameter.
local function get_undocumented_userdata_param_message(log_prefix, param_name, param, allow_localised_string)
    if allow_localised_string then
        return {"gui.creative-mode_undocumented-userdata", log_prefix, param_name}
    end
    return (log_prefix .. '"' .. param_name .. '" (undocumented) :: userdata')
end

-- Prints undocumented thread parameter.
local function get_undocumented_thread_param_message(log_prefix, param_name, param, allow_localised_string)
    if allow_localised_string then
        return {"gui.creative-mode_undocumented-thread", log_prefix, param_name}
    end
    return (log_prefix .. '"' .. param_name .. '" (undocumented) :: thread')
end

-- Extra look up table for undocumented parameters according to their types.
local undocumented_event_param_message_loop_up = {
    ["boolean"] = get_undocumented_boolean_param_message,
    ["number"] = get_undocumented_number_param_message,
    ["string"] = get_undocumented_string_param_message,
    ["function"] = get_undocumented_function_param_message,
    ["userdata"] = get_undocumented_userdata_param_message,
    ["thread"] = get_undocumented_thread_param_message
}

-- Look up table for quickly converting event IDs to event names.
local event_id_to_names_look_up = {}
for event_name, event_id in pairs(defines.events) do
    event_id_to_names_look_up[event_id] = event_name
end

-- Creates the event name message according to the given event if the message has not been created yet.
-- Also returns the tick prefix. The prefix will be included in the message. It is for further message creation.
local function create_event_name_message_if_not_exist(event, tick_prefix, message)
    if message ~= nil then
        return tick_prefix, message
    end

    local event_id = event.name
    local event_name = event_id_to_names_look_up[event_id]
    tick_prefix = "T" .. event.tick .. "\t\t"
    return tick_prefix, tick_prefix .. event_name .. " (ID " .. event_id .. ")"
end

-- Returns the message for the given parameter with given name in the event of given ID.
-- If the message will be printed to console, allow_localised_string can be true; otherwise, if the returned message will be concatenated, it has to be false.
local function get_event_param_message(message_prefix, event_id, param_name, param, allow_localised_string)
    -- Check for the repeated event params look up table first.
    if repeated_event_param_message_look_up[event_id] and repeated_event_param_message_look_up[event_id][param_name] then
        return repeated_event_param_message_look_up[event_id][param_name](message_prefix, param_name, param)
    else
        -- Prepare param_name if there's multiple fits...
        if param_name == 'item' then
            local param_type = type(param)
            if param_type == 'table' then
                param_name = param_name .. '-table'
            elseif param_type == 'string' then
                param_name = param_name .. '-string'
            end
        end
        -- Check for the normal event params look up table.
        if event_param_message_look_up[param_name] then
            return event_param_message_look_up[param_name](message_prefix, param_name, param)
        else
            -- Undocumated param. We will try to parse it anyway.
            local param_type = type(param)
            if undocumented_event_param_message_loop_up[param_type] then
                return undocumented_event_param_message_loop_up[param_type](message_prefix, param_name, param,
                           allow_localised_string)
            end
            -- Unknown type.
            if allow_localised_string then
                return {"gui.creative-mode_undocumented-unknown-type", message_prefix, param_name, param_type}
            else
                return message_prefix .. '"' .. param_name .. '" (undocumented) = ' .. param_type .. " (unknown type)"
            end
        end
    end
end

-- The file name for writing event logs into txt file.
events.event_write_file_name = creative_mode_defines.mod_id .. "/event-log.txt"
-- The file path for writing event logs into txt file.
local event_write_file_path = nil
-- Returns the file path for writing events for this section.
-- Due to limitation on the API, it is impossible to read system time. To separate logs between different sections, a separator will be added.
local function get_event_write_file_path(player)
    if not event_write_file_path then
        event_write_file_path = events.event_write_file_name
        game.write_file(event_write_file_path, "-------------------------------------------------\n", true, player.index)
    end
    return event_write_file_path
end

-- Writes or logs the given event according to the given data.
-- Returns the tick_prefix, name_message, param_message_prefix and full_write_or_log_message so they can be reused.
local function write_or_log_events(player, is_write, also_apply_to_params, event_id, event, tick_prefix, name_message,
    param_message_prefix, full_write_or_log_message)
    local final_message
    -- Log the tick followed by the event name.
    tick_prefix, name_message = create_event_name_message_if_not_exist(event, tick_prefix, name_message)

    -- Append the parameters if necessary.
    if also_apply_to_params then
        -- Create the full log message only if it does not exist.
        if not full_write_or_log_message then
            full_write_or_log_message = name_message
            if not param_message_prefix then
                param_message_prefix = tick_prefix .. "(ID " .. event_id .. ")\t"
            end
            for param_name, param in pairs(event) do
                local message = get_event_param_message(param_message_prefix, event_id, param_name, param, false)
                if message then
                    full_write_or_log_message = full_write_or_log_message .. "\n" .. message
                end
            end
        end

        -- Append the full message.
        final_message = full_write_or_log_message
    else
        -- Only append the event name.
        final_message = name_message
    end

    if is_write then
        -- Write.
        game.write_file(get_event_write_file_path(player), final_message .. "\n", true, player.index)
    else
        -- Log.
        log(final_message)
    end

    return tick_prefix, name_message, param_message_prefix, full_store_or_log_message
end

-- Generic event handler. All events, except on_tick, will be handled here.
function events.on_event(event)
    -- Note: event.name is acutally the event ID.
    local event_id = event.name

    -- Print or log the event if necessary.
    -- Create the messages only once.
    local tick_prefix = nil
    local name_message = nil
    local param_message_prefix = nil
    local full_write_or_log_message = nil
    if global.creative_mode and global.creative_mode.selected_events and game.players then
        for _, player in pairs(game.connected_players) do
            local selected_events = global.creative_mode.selected_events[player.index]
            if selected_events and selected_events[event_id] then
                -- Print event.
                if global.creative_mode.print_events[player.index] ~= false then
                    -- Print the tick followed by the event name.
                    tick_prefix, name_message = create_event_name_message_if_not_exist(event, tick_prefix, name_message)
                    player.print(name_message)

                    -- Print parameters.
                    if global.creative_mode.also_print_event_params[player.index] ~= false then
                        if not param_message_prefix then
                            param_message_prefix = tick_prefix .. "(ID " .. event_id .. ")\t"
                        end
                        for param_name, param in pairs(event) do
                            local message = get_event_param_message(param_message_prefix, event_id, param_name, param,
                                                true)
                            if message then
                                player.print(message)
                            end
                        end
                    end
                end

                -- Write events.
                if global.creative_mode.write_events[player.index] then
                    tick_prefix, name_message, param_message_prefix, full_write_or_log_message =
                        write_or_log_events(player, true,
                            global.creative_mode.also_write_event_params[player.index] ~= false, event_id, event,
                            tick_prefix, name_message, param_message_prefix, full_write_or_log_message)
                end

                -- Log events.
                if global.creative_mode.log_events[player.index] then
                    tick_prefix, name_message, param_message_prefix, full_write_or_log_message =
                        write_or_log_events(player, false,
                            global.creative_mode.also_log_event_params[player.index] ~= false, event_id, event,
                            tick_prefix, name_message, param_message_prefix, full_write_or_log_message)
                end
            end
        end
    end

    -- Forward the event to the corresponding handler.
    if event_handlers_look_up[event_id] then
        event_handlers_look_up[event_id](event)
    end
end
