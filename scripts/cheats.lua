require("rights")

-- This file contains functions for enabling/disabling cheats.
if not cheats then
    cheats = {}
end

-- Values for default cheating.
cheats.default_cheat_values = {
    reach_distance = 10000000,
    mining_speed = 1000,
    running_speed = 2
}

--------------------------------------------------------------------

-- Function for limiting the value to be positive only before it is applied.
local function uint32_limit_value_before_apply_function(value)
    -- Negative value will cause error.
    return util.clamp(value, 0, 4294967295)
end

-- Function for limiting the value to be positive only before it is applied.
local function int32_limit_value_before_apply_function(value)
    -- Negative value will cause error.
    return util.clamp(value, -2147483648, 2147483647)
end

-- Function for limiting the value to be positive only before it is applied.
local function pickup_distance_limit_value_before_apply_function(value)
    -- Negative value will cause error.
    return util.clamp(value, 0, 320)
end

-- Function for limiting the value to be inside a large but safe range before it is applied.
local function large_range_limit_value_before_apply_function(value)
    return util.clamp(value, -1, 4294967296)
end

-- Applies all character-related personal cheats to the given player. Also updates GUI status about the cheat for all players, in case the given player is selected.
local function apply_character_cheats_to_player(player)
    -- Cheat mode.
    if storage.creative_mode.personal_cheats.cheat_mode[player.index] ~= nil then
        cheats.personal_cheats_data.cheats.cheat_mode.apply_to_target_function(player, storage.creative_mode
            .personal_cheats.cheat_mode[player.index], nil)
    end
    -- Invincible player.
    if storage.creative_mode.personal_cheats.invincible_player[player.index] ~= nil then
        cheats.personal_cheats_data.cheats.invincible_player.apply_to_target_function(player, storage.creative_mode
            .personal_cheats.invincible_player[player.index], nil)
    end
    -- Reach distance.
    if storage.creative_mode.personal_cheats.reach_distance[player.index] ~= nil then
        cheats.personal_cheats_data.cheats.reach_distance.apply_to_target_function(player, storage.creative_mode
            .personal_cheats.reach_distance[player.index], nil)
    end
    -- Build distance.
    if storage.creative_mode.personal_cheats.build_distance[player.index] ~= nil then
        cheats.personal_cheats_data.cheats.build_distance.apply_to_target_function(player, storage.creative_mode
            .personal_cheats.build_distance[player.index], nil)
    end
    -- Resource reach distance.
    if storage.creative_mode.personal_cheats.resource_reach_distance[player.index] ~= nil then
        cheats.personal_cheats_data.cheats.resource_reach_distance.apply_to_target_function(player,
            storage.creative_mode.personal_cheats.resource_reach_distance[player.index], nil)
    end
    -- Item drop distance.
    if storage.creative_mode.personal_cheats.item_drop_distance[player.index] ~= nil then
        cheats.personal_cheats_data.cheats.item_drop_distance.apply_to_target_function(player, storage.creative_mode
            .personal_cheats.item_drop_distance[player.index], nil)
    end
    -- Item pickup distance.
    if storage.creative_mode.personal_cheats.item_pickup_distance[player.index] ~= nil then
        cheats.personal_cheats_data.cheats.item_pickup_distance.apply_to_target_function(player, storage.creative_mode
            .personal_cheats.item_pickup_distance[player.index], nil)
    end
    -- Loot pickup distance.
    if storage.creative_mode.personal_cheats.loot_pickup_distance[player.index] ~= nil then
        cheats.personal_cheats_data.cheats.loot_pickup_distance.apply_to_target_function(player, storage.creative_mode
            .personal_cheats.loot_pickup_distance[player.index], nil)
    end
    -- Mining speed.
    if storage.creative_mode.personal_cheats.mining_speed[player.index] ~= nil then
        cheats.personal_cheats_data.cheats.mining_speed.apply_to_target_function(player, storage.creative_mode
            .personal_cheats.mining_speed[player.index], nil)
    end
    -- Running speed.
    if storage.creative_mode.personal_cheats.running_speed[player.index] ~= nil then
        cheats.personal_cheats_data.cheats.running_speed.apply_to_target_function(player, storage.creative_mode
            .personal_cheats.running_speed[player.index], nil)
    end
    -- Crafting speed.
    if storage.creative_mode.personal_cheats.crafting_speed[player.index] ~= nil then
        cheats.personal_cheats_data.cheats.crafting_speed.apply_to_target_function(player, storage.creative_mode
            .personal_cheats.crafting_speed[player.index], nil)
    end
    -- Inventory bonus.
    if storage.creative_mode.personal_cheats.inventory_bonus[player.index] ~= nil then
        cheats.personal_cheats_data.cheats.inventory_bonus.apply_to_target_function(player, storage.creative_mode
            .personal_cheats.inventory_bonus[player.index], nil)
    end
    -- Health bonus.
    if storage.creative_mode.personal_cheats.health_bonus[player.index] ~= nil then
        cheats.personal_cheats_data.cheats.health_bonus.apply_to_target_function(player, storage.creative_mode
            .personal_cheats.health_bonus[player.index], nil)
    end

    gui_menu_cheats.update_character_cheats_status_for_all_players_as_player_updated_his_status(player)
end

-- Data about all personal cheats.
cheats.personal_cheats_data = {
    -- Function for checking whether the target is self of the source player.
    check_is_self_function = function(source_player, player)
        return source_player == player
    end,
    -- Function for print a message to the admin after he failed to apply changes to a target.
    print_admin_failed_to_apply_to_single_target_message_function = function(source_player, target, reason)
        source_player.print { "message.creative-mode_failed-to-apply-to-single-player-admin", target.name, reason }
    end,
    -- Function for print a message to the admin after he failed to apply changes to multiple targets.
    print_admin_failed_to_apply_to_multi_targets_message_function = function(source_player, fail_count, reason)
        source_player.print { "message.creative-mode_failed-to-apply-to-multiple-players-admin", fail_count, reason }
    end,
    -- Function for printing a message to the target after the admin applied "Enable All" or "Disable All" on it.
    print_enabled_all_by_admin_message_function = function(source_player, player, enable)
        if enable then
            player.print { "message.creative-mode_personal-cheats-enabled-all-by-admin", source_player.name }
        else
            player.print { "message.creative-mode_personal-cheats-disabled-all-by-admin", source_player.name }
        end
    end,
    -- All cheats in this category. No other data except cheat data should be put inside.
    cheats = {
        cheat_mode = {
            -- Whether this cheat is one of the default cheats that can be triggered by the "Enable All" and "Disable All" buttons.
            is_default = true,
            -- Value when "Enable All" is applied.
            default_enable_value = true,
            -- Value when "Disable All" is applied.
            default_disable_value = false,
            -- Function for getting the current value of this cheat on the target. Nil for apply-cheat.
            -- Note: this function will NOT be used to control whether apply_to_target_function will be called.
            get_value_function = function(player)
                -- If player is respawning, accessing cheat_mode will cause error.
                if player and player.connected and player.controller_type ~= defines.controllers.ghost then
                    return player.cheat_mode
                end
                return nil
            end,
            -- Function for limiting the value before it is applied to any target. For example, you can limit the value to be >= 0 by clamping it. Nil for no limit.
            limit_value_before_apply_function = nil,
            -- Function for applying the cheat to a single target. source_player may be nil, depending on the cheat. Returns the locale key of failure reason if it cannot be applied to target.
            apply_to_target_function = function(player, enable, source_player)
                if not player.connected then
                    return { "message.creative-mode_player-is-offline" }
                end

                if player.controller_type == defines.controllers.ghost then
                    return { "gui.creative-mode_cannot-apply-this-cheat-before-respawned" }
                end

                storage.creative_mode.personal_cheats.cheat_mode[player.index] = enable
                player.cheat_mode = enable
                return nil
            end,
            -- Function for printing a message to the target if the source player succeeded to apply the cheat to it.
            -- Only called if the the new value is different from current and target is not the source player himself according to the result of check_is_self_function.
            print_applied_by_admin_message_function = function(source_player, player, enable)
                if enable then
                    player.print { "message.creative-mode_cheat-mode-enabled-by-admin", source_player.name }
                else
                    player.print { "message.creative-mode_cheat-mode-disabled-by-admin", source_player.name }
                end
            end,
            -- Function for getting whether the given player can access this cheat. Nil = all players can access, as long as they can see it.
            get_player_can_access_function = nil
        },
        invincible_player = {
            get_is_default_from_player = function(source_player)
                return source_player.mod_settings[creative_mode_defines.names.settings
                    .enable_invincible_player_by_default].value
            end,
            is_default = true,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = function(player)
                if player and player.connected and player.character then
                    return not player.character.destructible
                else
                    return nil
                end
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(player, enable, source_player)
                if not player.connected then
                    return { "message.creative-mode_player-is-offline" }
                end

                if player.character then
                    storage.creative_mode.personal_cheats.invincible_player[player.index] = enable
                    player.character.destructible = not enable
                    return nil
                end

                if player.controller_type == defines.controllers.ghost then
                    return { "gui.creative-mode_cannot-apply-this-cheat-before-respawned" }
                else
                    return { "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" }
                end
            end,
            print_applied_by_admin_message_function = function(source_player, player, enable)
                if enable then
                    player.print { "message.creative-mode_invincible-player-enabled-by-admin", source_player.name }
                else
                    player.print { "message.creative-mode_invincible-player-disabled-by-admin", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        keep_last_item = {
            is_default = true,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = function(player)
                if player then
                    return storage.creative_mode.personal_cheats.keep_last_item[player.index] or false
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(player, enable, source_player)
                storage.creative_mode.personal_cheats.keep_last_item[player.index] = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, player, enable)
                if enable then
                    player.print { "message.creative-mode_keep-last-item-enabled-by-admin", source_player.name }
                else
                    player.print { "message.creative-mode_keep-last-item-disabled-by-admin", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        repair_mined_item = {
            is_default = true,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = function(player)
                if player then
                    return storage.creative_mode.personal_cheats.repair_mined_item[player.index] or false
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(player, enable, source_player)
                storage.creative_mode.personal_cheats.repair_mined_item[player.index] = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, player, enable)
                if enable then
                    player.print { "message.creative-mode_repair-mined-item-enabled-by-admin", source_player.name }
                else
                    player.print { "message.creative-mode_repair-mined-item-disabled-by-admin", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        instant_request = {
            is_default = true,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = function(player)
                if player then
                    return storage.creative_mode.personal_cheats.instant_request[player.index] or false
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(player, enable, source_player)
                storage.creative_mode.personal_cheats.instant_request[player.index] = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, player, enable)
                if enable then
                    player.print { "message.creative-mode_instant-request-enabled-by-admin", source_player.name }
                else
                    player.print { "message.creative-mode_instant-request-disabled-by-admin", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        instant_trash = {
            is_default = true,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = function(player)
                if player then
                    return storage.creative_mode.personal_cheats.instant_trash[player.index] or false
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(player, enable, source_player)
                storage.creative_mode.personal_cheats.instant_trash[player.index] = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, player, enable)
                if enable then
                    player.print { "message.creative-mode_instant-trash-enabled-by-admin", source_player.name }
                else
                    player.print { "message.creative-mode_instant-trash-disabled-by-admin", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        instant_blueprint = {
            get_is_default_from_player = function(source_player)
                return source_player.mod_settings[creative_mode_defines.names.settings
                    .enable_instant_blueprint_by_default].value
            end,
            is_default = true,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = function(player)
                if player then
                    return storage.creative_mode.personal_cheats.instant_blueprint[player.index] or false
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(player, enable, source_player)
                storage.creative_mode.personal_cheats.instant_blueprint[player.index] = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, player, enable)
                if enable then
                    player.print { "message.creative-mode_instant-blueprint-enabled-by-admin", source_player.name }
                else
                    player.print { "message.creative-mode_instant-blueprint-disabled-by-admin", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        instant_deconstruction = {
            get_is_default_from_player = function(source_player)
                return source_player.mod_settings[creative_mode_defines.names.settings
                    .enable_instant_deconstruction_by_default].value
            end,
            is_default = true,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = function(player)
                if player then
                    return storage.creative_mode.personal_cheats.instant_deconstruction[player.index] or false
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(player, enable, source_player)
                storage.creative_mode.personal_cheats.instant_deconstruction[player.index] = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, player, enable)
                if enable then
                    player.print { "message.creative-mode_instant-deconstruction-enabled-by-admin", source_player.name }
                else
                    player.print { "message.creative-mode_instant-deconstruction-disabled-by-admin", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        reach_distance = {
            get_is_default_from_player = function(source_player)
                return source_player.mod_settings[creative_mode_defines.names.settings
                    .enable_personal_long_reach_by_default].value
            end,
            is_default = true,
            default_enable_value = cheats.default_cheat_values.reach_distance,
            default_disable_value = 0,
            get_value_function = function(player)
                if player and player.connected and player.character then
                    return player.character_reach_distance_bonus
                else
                    return nil
                end
            end,
            limit_value_before_apply_function = uint32_limit_value_before_apply_function,
            apply_to_target_function = function(player, value, source_player)
                if not player.connected then
                    return { "message.creative-mode_player-is-offline" }
                end
                if player.character then
                    storage.creative_mode.personal_cheats.reach_distance[player.index] = value
                    player.character_reach_distance_bonus = value
                    return nil
                end
                if player.controller_type == defines.controllers.ghost then
                    return { "gui.creative-mode_cannot-apply-this-cheat-before-respawned" }
                else
                    return { "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" }
                end
            end,
            print_applied_by_admin_message_function = function(source_player, player, value)
                player.print { "message.creative-mode_reach-distance-updated-by-admin", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        build_distance = {
            get_is_default_from_player = function(source_player)
                return source_player.mod_settings[creative_mode_defines.names.settings
                    .enable_personal_long_reach_by_default].value
            end,
            is_default = true,
            default_enable_value = cheats.default_cheat_values.reach_distance,
            default_disable_value = 0,
            get_value_function = function(player)
                if player and player.connected and player.character then
                    return player.character_build_distance_bonus
                else
                    return nil
                end
            end,
            limit_value_before_apply_function = uint32_limit_value_before_apply_function,
            apply_to_target_function = function(player, value, source_player)
                if not player.connected then
                    return { "message.creative-mode_player-is-offline" }
                end
                if player.character then
                    storage.creative_mode.personal_cheats.build_distance[player.index] = value
                    player.character_build_distance_bonus = value
                    return nil
                end
                if player.controller_type == defines.controllers.ghost then
                    return { "gui.creative-mode_cannot-apply-this-cheat-before-respawned" }
                else
                    return { "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" }
                end
            end,
            print_applied_by_admin_message_function = function(source_player, player, value)
                player.print { "message.creative-mode_build-distance-updated-by-admin", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        resource_reach_distance = {
            get_is_default_from_player = function(source_player)
                return source_player.mod_settings[creative_mode_defines.names.settings
                    .enable_personal_long_reach_by_default].value
            end,
            is_default = true,
            default_enable_value = cheats.default_cheat_values.reach_distance,
            default_disable_value = 0,
            get_value_function = function(player)
                if player and player.connected and player.character then
                    return player.character_resource_reach_distance_bonus
                else
                    return nil
                end
            end,
            limit_value_before_apply_function = uint32_limit_value_before_apply_function,
            apply_to_target_function = function(player, value, source_player)
                if not player.connected then
                    return { "message.creative-mode_player-is-offline" }
                end
                if player.character then
                    storage.creative_mode.personal_cheats.resource_reach_distance[player.index] = value
                    player.character_resource_reach_distance_bonus = value
                    return nil
                end
                if player.controller_type == defines.controllers.ghost then
                    return { "gui.creative-mode_cannot-apply-this-cheat-before-respawned" }
                else
                    return { "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" }
                end
            end,
            print_applied_by_admin_message_function = function(source_player, player, value)
                player.print { "message.creative-mode_resource-reach-distance-updated-by-admin", source_player.name,
                    value }
            end,
            get_player_can_access_function = nil
        },
        item_drop_distance = {
            get_is_default_from_player = function(source_player)
                return source_player.mod_settings[creative_mode_defines.names.settings
                    .enable_personal_long_reach_by_default].value
            end,
            is_default = true,
            default_enable_value = cheats.default_cheat_values.reach_distance,
            default_disable_value = 0,
            get_value_function = function(player)
                if player and player.connected and player.character then
                    return player.character_item_drop_distance_bonus
                else
                    return nil
                end
            end,
            limit_value_before_apply_function = uint32_limit_value_before_apply_function,
            apply_to_target_function = function(player, value, source_player)
                if not player.connected then
                    return { "message.creative-mode_player-is-offline" }
                end
                if player.character then
                    storage.creative_mode.personal_cheats.item_drop_distance[player.index] = value
                    player.character_item_drop_distance_bonus = value
                    return nil
                end
                if player.controller_type == defines.controllers.ghost then
                    return { "gui.creative-mode_cannot-apply-this-cheat-before-respawned" }
                else
                    return { "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" }
                end
            end,
            print_applied_by_admin_message_function = function(source_player, player, value)
                player.print { "message.creative-mode_item-drop-distance-updated-by-admin", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        item_pickup_distance = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(player)
                if player and player.connected and player.character then
                    return player.character_item_pickup_distance_bonus
                else
                    return nil
                end
            end,
            limit_value_before_apply_function = pickup_distance_limit_value_before_apply_function,
            apply_to_target_function = function(player, value, source_player)
                if not player.connected then
                    return { "message.creative-mode_player-is-offline" }
                end
                if player.character then
                    storage.creative_mode.personal_cheats.item_pickup_distance[player.index] = value
                    player.character_item_pickup_distance_bonus = value
                    return nil
                end
                if player.controller_type == defines.controllers.ghost then
                    return { "gui.creative-mode_cannot-apply-this-cheat-before-respawned" }
                else
                    return { "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" }
                end
            end,
            print_applied_by_admin_message_function = function(source_player, player, value)
                player.print { "message.creative-mode_item-pickup-distance-updated-by-admin", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        loot_pickup_distance = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(player)
                if player and player.connected and player.character then
                    return player.character_loot_pickup_distance_bonus
                else
                    return nil
                end
            end,
            limit_value_before_apply_function = pickup_distance_limit_value_before_apply_function,
            apply_to_target_function = function(player, value, source_player)
                if not player.connected then
                    return { "message.creative-mode_player-is-offline" }
                end
                if player.character then
                    storage.creative_mode.personal_cheats.loot_pickup_distance[player.index] = value
                    player.character_loot_pickup_distance_bonus = value
                    return nil
                end
                if player.controller_type == defines.controllers.ghost then
                    return { "gui.creative-mode_cannot-apply-this-cheat-before-respawned" }
                else
                    return { "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" }
                end
            end,
            print_applied_by_admin_message_function = function(source_player, player, value)
                player.print { "message.creative-mode_loot-pickup-distance-updated-by-admin", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        mining_speed = {
            is_default = true,
            default_enable_value = cheats.default_cheat_values.mining_speed,
            default_disable_value = 0,
            get_value_function = function(player)
                if player and player.connected and player.character then
                    return player.character_mining_speed_modifier
                else
                    return nil
                end
            end,
            limit_value_before_apply_function = large_range_limit_value_before_apply_function,
            apply_to_target_function = function(player, value, source_player)
                if not player.connected then
                    return { "message.creative-mode_player-is-offline" }
                end

                if player.character then
                    storage.creative_mode.personal_cheats.mining_speed[player.index] = value
                    player.character_mining_speed_modifier = value
                    return nil
                end
                if player.controller_type == defines.controllers.ghost then
                    return { "gui.creative-mode_cannot-apply-this-cheat-before-respawned" }
                else
                    return { "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" }
                end
            end,
            print_applied_by_admin_message_function = function(source_player, player, value)
                player.print { "message.creative-mode_mining-speed-updated-by-admin", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        running_speed = {
            get_is_default_from_player = function(source_player)
                return source_player.mod_settings[creative_mode_defines.names.settings
                    .enable_personal_fast_run_by_default].value
            end,
            is_default = true,
            default_enable_value = cheats.default_cheat_values.running_speed,
            default_disable_value = 0,
            get_value_function = function(player)
                if player and player.connected and player.character then
                    return player.character_running_speed_modifier
                else
                    return nil
                end
            end,
            limit_value_before_apply_function = large_range_limit_value_before_apply_function,
            apply_to_target_function = function(player, value, source_player)
                if not player.connected then
                    return { "message.creative-mode_player-is-offline" }
                end

                if player.character then
                    storage.creative_mode.personal_cheats.running_speed[player.index] = value
                    player.character_running_speed_modifier = value
                    return nil
                end
                if player.controller_type == defines.controllers.ghost then
                    return { "gui.creative-mode_cannot-apply-this-cheat-before-respawned" }
                else
                    return { "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" }
                end
            end,
            print_applied_by_admin_message_function = function(source_player, player, value)
                player.print { "message.creative-mode_running-speed-updated-by-admin", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        crafting_speed = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(player)
                if player and player.connected and player.character then
                    return player.character_crafting_speed_modifier
                else
                    return nil
                end
            end,
            limit_value_before_apply_function = large_range_limit_value_before_apply_function,
            apply_to_target_function = function(player, value, source_player)
                if not player.connected then
                    return { "message.creative-mode_player-is-offline" }
                end

                if player.character then
                    storage.creative_mode.personal_cheats.crafting_speed[player.index] = value
                    player.character_crafting_speed_modifier = value
                    return nil
                end
                if player.controller_type == defines.controllers.ghost then
                    return { "gui.creative-mode_cannot-apply-this-cheat-before-respawned" }
                else
                    return { "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" }
                end
            end,
            print_applied_by_admin_message_function = function(source_player, player, value)
                player.print { "message.creative-mode_crafting-speed-updated-by-admin", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        inventory_bonus = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(player)
                if player and player.connected and player.character then
                    return player.character_inventory_slots_bonus
                else
                    return nil
                end
            end,
            limit_value_before_apply_function = function(value)
                return util.clamp(value, 0, 100000)
            end,
            apply_to_target_function = function(player, value, source_player)
                if not player.connected then
                    return { "message.creative-mode_player-is-offline" }
                end

                if player.character then
                    storage.creative_mode.personal_cheats.inventory_bonus[player.index] = value
                    player.character_inventory_slots_bonus = value
                    return nil
                end
                if player.controller_type == defines.controllers.ghost then
                    return { "gui.creative-mode_cannot-apply-this-cheat-before-respawned" }
                else
                    return { "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" }
                end
            end,
            print_applied_by_admin_message_function = function(source_player, player, value)
                player.print { "message.creative-mode_inventory-bonus-updated-by-admin", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        health_bonus = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(player)
                if player and player.connected and player.character then
                    return player.character_health_bonus
                else
                    return nil
                end
            end,
            limit_value_before_apply_function = int32_limit_value_before_apply_function,
            apply_to_target_function = function(player, value, source_player)
                if not player.connected then
                    return { "message.creative-mode_player-is-offline" }
                end

                if player.character then
                    storage.creative_mode.personal_cheats.health_bonus[player.index] = value
                    player.character_health_bonus = value
                    return nil
                end
                if player.controller_type == defines.controllers.ghost then
                    return { "gui.creative-mode_cannot-apply-this-cheat-before-respawned" }
                else
                    return { "gui.creative-mode_cannot-apply-this-cheat-in-god-mode" }
                end
            end,
            print_applied_by_admin_message_function = function(source_player, player, value)
                player.print { "message.creative-mode_health-bonus-updated-by-admin", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        god_mode = {
            is_default = false,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = function(player)
                if player and player.connected then
                    if player.character then
                        return false
                    else
                        -- It is possible that the player has just died and is waiting for respawn.
                        return player.controller_type ~= defines.controllers.ghost
                    end
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(player, enable, source_player)
                if not player.connected then
                    return { "message.creative-mode_player-is-offline" }
                end
                if player.controller_type == defines.controllers.ghost then
                    -- Cannot apply before player respawned.
                    return { "gui.creative-mode_cannot-apply-this-cheat-before-respawned" }
                end
                -- Cheat mode will be reset after toggling god mode, so we will need to apply it again.
                local cheat_mode = player.cheat_mode
                if enable then
                    -- Store the character so that we can get it back when god mode is off.
                    local character = player.character
                    -- Make sure the player is not already in god mode.
                    if character then
                        storage.creative_mode.personal_cheats.god_mode_character[player.index] = character
                        -- Remove character (Enter god mode).
                        player.character = nil
                        if character then
                            -- Transfer items.
                            local character_main = character.get_inventory(defines.inventory.character_main)
                            local god_main = player.get_inventory(defines.inventory.god_main)
                            util.transfer_inventory_contents(character_main, god_main)
                            -- Transfer cursor stack.
                            local cursor_stack = character.cursor_stack
                            if cursor_stack and cursor_stack.valid_for_read then
                                player.cursor_stack.set_stack(cursor_stack)
                                character.cursor_stack.clear()
                            end
                        end
                        -- Update cheat status on GUI.
                        gui_menu_cheats.update_character_cheats_status_for_all_players_as_player_updated_his_status(
                            player)
                    end
                else
                    -- Make sure the player is in god mode.
                    if not player.character then
                        -- Restore the character if it is still here.
                        local character = storage.creative_mode.personal_cheats.god_mode_character[player.index]
                        if character and character.valid then
                            storage.creative_mode.personal_cheats.god_mode_character[player.index] = nil
                        else
                            -- Character is dead! Create new one.
                            character = player.surface.create_entity {
                                name = "character",
                                position = player.position,
                                force = player.force
                            }
                        end
                        -- Transfer items.
                        local character_main = character.get_inventory(defines.inventory.character_main)
                        local god_main = player.get_inventory(defines.inventory.god_main)
                        util.transfer_inventory_contents(god_main, character_main)
                        -- Transfer cursor stack.
                        local cursor_stack = player.cursor_stack
                        if cursor_stack and cursor_stack.valid_for_read then
                            character.cursor_stack.set_stack(cursor_stack)
                            player.cursor_stack.clear()
                        end
                        -- Note: surface teleportation only works on player at this moment. So we can't teleport the character to the player's surface.
                        local surface = player.surface
                        local position = player.position
                        -- Note: to set player character, the character has to be on the same surface as the player. Because we cannot teleport the character, we can only teleport the player.
                        player.teleport(character.position, character.surface)
                        -- Set character.
                        player.character = character
                        -- Teleport.
                        player.teleport(position, surface)
                        -- Apply character cheats.
                        apply_character_cheats_to_player(player)
                        -- Note: don't raise the on_player_respawned event as it will generate a gun and ammo (starting items).
                    end
                end
                -- Apply cheat mode.
                player.cheat_mode = cheat_mode
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, player, enable)
                if enable then
                    player.print { "message.creative-mode_god-mode-enabled-by-admin", source_player.name }
                else
                    player.print { "message.creative-mode_god-mode-disabled-by-admin", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        }
    }
}

-- Data about all team cheats.
cheats.team_cheats_data = {
    check_is_self_function = function(source_player, force)
        return false
    end,
    print_admin_failed_to_apply_to_single_target_message_function = function(source_player, target, reason)
        -- No reason to fail so far.
    end,
    print_admin_failed_to_apply_to_multi_targets_message_function = function(source_player, fail_count, reason)
        -- No reason to fail so far.
    end,
    print_enabled_all_by_admin_message_function = function(source_player, force, enable)
        if enable then
            force.print { "message.creative-mode_team-cheats-enabled-all", source_player.name }
        else
            force.print { "message.creative-mode_team-cheats-disabled-all", source_player.name }
        end
    end,
    cheats = {
        creative_tools_recipes = {
            is_default = true,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = function(force)
                if force then
                    return force.recipes[creative_mode_defines.names.recipes.item_source].enabled
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(force, enable, source_player)
                -- Item recipes.
                for _, recipe_name in pairs(creative_mode_defines.names.recipes) do
                    local recipe = force.recipes[recipe_name]
                    if recipe then
                        recipe.enabled = enable
                    end
                end
                -- Free fluid recipes. Get the recipe names by looping through the fluid prototypes in game.
                for _, fluid in pairs(prototypes.fluid) do
                    local recipe = force.recipes[creative_mode_defines.names.free_fluid_recipe_prefix .. fluid.name]
                    if recipe then
                        recipe.enabled = enable
                    end
                end
                -- Enemy recipes.
                for _, entity in pairs(prototypes.entity) do
                    local recipe = force.recipes[creative_mode_defines.names.enemy_recipe_prefix .. entity.name]
                    if recipe then
                        recipe.enabled = enable
                    end
                end
                -- Technology
                for _, technology_name in pairs(creative_mode_defines.names.technology) do
                    local technology = force.technologies[technology_name]
                    if technology then
                        technology.enabled = enable
                    end
                end
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, enable)
                if enable then
                    force.print { "message.creative-mode_creative-tools-recipes-enabled", source_player.name }
                else
                    force.print { "message.creative-mode_creative-tools-recipes-disabled", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        loaders_recipes = {
            is_default = true,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = function(force)
                if force then
                    for _, recipe_name in pairs(creative_mode_defines.names.loader_recipes) do
                        if not (force.recipes[recipe_name] and force.recipes[recipe_name].enabled) then
                            return false
                        end
                    end
                    return true
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(force, enable, source_player)
                for _, recipe_name in pairs(creative_mode_defines.names.loader_recipes) do
                    if force.recipes[recipe_name] then
                        force.recipes[recipe_name].enabled = enable
                    end
                end
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, enable)
                if enable then
                    force.print { "message.creative-mode_loaders-recipes-enabled", source_player.name }
                else
                    force.print { "message.creative-mode_loaders-recipes-disabled", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        research_all_technologies = {
            get_is_default_from_player = function(source_player)
                return source_player.mod_settings[creative_mode_defines.names.settings
                    .default_technology_research_cheat_type].value ~=
                    creative_mode_defines.values.default_technology_research_cheat_types.nothing
            end,
            is_default = true,
            get_default_enable_value_from_player = function(source_player)
                return source_player.mod_settings[creative_mode_defines.names.settings
                    .default_technology_research_cheat_type].value ==
                    creative_mode_defines.values.default_technology_research_cheat_types.research_all
            end,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = function(force)
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(force, enable, source_player)
                if enable then
                    force.research_all_technologies()
                    -- "Unresearch" the void technology.
                    if force.technologies[creative_mode_defines.names.technology.void_technology] ~= nil then
                        force.technologies[creative_mode_defines.names.technology.void_technology].researched = false
                    end
                else
                    -- Calling LuaForce::reset() will hide all the originally hidden recipes.
                    -- We have to enable them back if they were enabled.
                    local creative_tools_recipes_enabled = cheats.team_cheats_data.cheats.creative_tools_recipes
                        .get_value_function(force)
                    local loaders_recipes_enabled = cheats.team_cheats_data.cheats.loaders_recipes.get_value_function(
                        force)

                    force.reset()

                    if creative_tools_recipes_enabled then
                        cheats.team_cheats_data.cheats.creative_tools_recipes.apply_to_target_function(force, true,
                            source_player)
                    end
                    if loaders_recipes_enabled then
                        cheats.team_cheats_data.cheats.loaders_recipes.apply_to_target_function(force, true,
                            source_player)
                    end
                end
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, enable)
                if enable then
                    force.print { "message.creative-mode_all-technologies-researched", source_player.name }
                else
                    force.print { "message.creative-mode_all-technologies-reset", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        instant_research = {
            get_is_default_from_player = function(source_player)
                return source_player.mod_settings[creative_mode_defines.names.settings
                    .default_technology_research_cheat_type].value ~=
                    creative_mode_defines.values.default_technology_research_cheat_types.nothing
            end,
            is_default = true,
            get_default_enable_value_from_player = function(source_player)
                return source_player.mod_settings[creative_mode_defines.names.settings
                    .default_technology_research_cheat_type].value ==
                    creative_mode_defines.values.default_technology_research_cheat_types.instant_research
            end,
            default_enable_value = false,
            default_disable_value = false,
            get_value_function = function(force)
                if force then
                    return storage.creative_mode.team_cheats.instant_research[force.name] or false
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(force, enable, source_player)
                storage.creative_mode.team_cheats.instant_research[force.name] = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, enable)
                if enable then
                    force.print { "message.creative-mode_instant-research-enabled", source_player.name }
                else
                    force.print { "message.creative-mode_instant-research-disabled", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        reach_distance = {
            is_default = false,
            default_enable_value = cheats.default_cheat_values.reach_distance,
            default_disable_value = 0,
            get_value_function = function(force)
                if force then
                    return force.character_reach_distance_bonus
                end
                return nil
            end,
            limit_value_before_apply_function = uint32_limit_value_before_apply_function,
            apply_to_target_function = function(force, value, source_player)
                force.character_reach_distance_bonus = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_team-reach-distance-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        build_distance = {
            is_default = false,
            default_enable_value = cheats.default_cheat_values.reach_distance,
            default_disable_value = 0,
            get_value_function = function(force)
                if force then
                    return force.character_build_distance_bonus
                end
                return nil
            end,
            limit_value_before_apply_function = uint32_limit_value_before_apply_function,
            apply_to_target_function = function(force, value, source_player)
                force.character_build_distance_bonus = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_team-build-distance-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        resource_reach_distance = {
            is_default = false,
            default_enable_value = cheats.default_cheat_values.reach_distance,
            default_disable_value = 0,
            get_value_function = function(force)
                if force then
                    return force.character_resource_reach_distance_bonus
                end
                return nil
            end,
            limit_value_before_apply_function = uint32_limit_value_before_apply_function,
            apply_to_target_function = function(force, value, source_player)
                force.character_resource_reach_distance_bonus = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_team-resource-reach-distance-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        item_drop_distance = {
            is_default = false,
            default_enable_value = cheats.default_cheat_values.reach_distance,
            default_disable_value = 0,
            get_value_function = function(force)
                if force then
                    return force.character_item_drop_distance_bonus
                end
                return nil
            end,
            limit_value_before_apply_function = uint32_limit_value_before_apply_function,
            apply_to_target_function = function(force, value, source_player)
                force.character_item_drop_distance_bonus = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_team-item-drop-distance-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        item_pickup_distance = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(force)
                if force then
                    return force.character_item_pickup_distance_bonus
                end
                return nil
            end,
            limit_value_before_apply_function = uint32_limit_value_before_apply_function,
            apply_to_target_function = function(force, value, source_player)
                force.character_item_pickup_distance_bonus = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_team-item-pickup-distance-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        loot_pickup_distance = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(force)
                if force then
                    return force.character_loot_pickup_distance_bonus
                end
                return nil
            end,
            limit_value_before_apply_function = uint32_limit_value_before_apply_function,
            apply_to_target_function = function(force, value, source_player)
                force.character_loot_pickup_distance_bonus = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_team-loot-pickup-distance-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        mining_speed = {
            is_default = false,
            default_enable_value = cheats.default_cheat_values.mining_speed,
            default_disable_value = 0,
            get_value_function = function(force)
                if force then
                    -- Not character_mining_speed_modifier
                    return force.manual_mining_speed_modifier
                end
                return nil
            end,
            limit_value_before_apply_function = large_range_limit_value_before_apply_function,
            apply_to_target_function = function(force, value, source_player)
                force.manual_mining_speed_modifier = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_team-mining-speed-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        running_speed = {
            is_default = false,
            default_enable_value = cheats.default_cheat_values.running_speed,
            default_disable_value = 0,
            get_value_function = function(force)
                if force then
                    return force.character_running_speed_modifier
                end
                return nil
            end,
            limit_value_before_apply_function = large_range_limit_value_before_apply_function,
            apply_to_target_function = function(force, value, source_player)
                force.character_running_speed_modifier = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_team-running-speed-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        crafting_speed = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(force)
                if force then
                    return force.manual_crafting_speed_modifier
                end
                return nil
            end,
            limit_value_before_apply_function = large_range_limit_value_before_apply_function,
            apply_to_target_function = function(force, value, source_player)
                force.manual_crafting_speed_modifier = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_team-crafting-speed-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        character_inventory_bonus = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(force)
                if force then
                    return force.character_inventory_slots_bonus
                end
                return nil
            end,
            limit_value_before_apply_function = function(value)
                return util.clamp(value, 0, 100000)
            end,
            apply_to_target_function = function(force, value, source_player)
                force.character_inventory_slots_bonus = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_character-inventory-bonus-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        health_bonus = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(force)
                if force then
                    return force.character_health_bonus
                end
                return nil
            end,
            limit_value_before_apply_function = large_range_limit_value_before_apply_function,
            apply_to_target_function = function(force, value, source_player)
                force.character_health_bonus = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_character-health-bonus-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        inserter_capacity_bonus = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(force)
                if force then
                    return force.inserter_stack_size_bonus
                end
                return nil
            end,
            limit_value_before_apply_function = uint32_limit_value_before_apply_function,
            apply_to_target_function = function(force, value, source_player)
                force.inserter_stack_size_bonus = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_inserter-capacity-bonus", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        bulk_inserter_capacity_bonus = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(force)
                if force then
                    return force.bulk_inserter_capacity_bonus
                end
                return nil
            end,
            limit_value_before_apply_function = uint32_limit_value_before_apply_function,
            apply_to_target_function = function(force, value, source_player)
                force.bulk_inserter_capacity_bonus = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_bulk-inserter-capacity-bonus", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        evolution_factor = {
            get_is_default_from_player = function(source_player)
                return source_player.mod_settings[creative_mode_defines.names.settings
                    .override_evolution_factor_by_default].value
            end,
            is_default = false,
            get_default_enable_value_from_player = function(source_player)
                return source_player.mod_settings[creative_mode_defines.names.settings.default_evolution_factor].value
            end,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(force)
                if force then
                    return force.get_evolution_factor()
                end
                return nil
            end,
            limit_value_before_apply_function = function(value)
                return util.clamp(value, 0, 1)
            end,
            apply_to_target_function = function(force, value, source_player)
                force.set_evolution_factor(value)
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_evolution-factor-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        chart_all = {
            is_default = false,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = nil,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(force, value, source_player)
                force.chart_all()
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_chart-all-applied", source_player.name }
            end,
            get_player_can_access_function = nil
        },
        kill_all_units = {
            is_default = false,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = nil,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(force, value, source_player)
                force.kill_all_units()
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, force, value)
                force.print { "message.creative-mode_kill-all-units-applied", source_player.name }
            end,
            get_player_can_access_function = nil
        }
    }
}

-- Data about all surface cheats.
cheats.surface_cheats_data = {
    check_is_self_function = function(source_player, surface)
        return false
    end,
    print_admin_failed_to_apply_to_single_target_message_function = function(source_player, target, reason)
        -- No reason to fail so far.
    end,
    print_admin_failed_to_apply_to_multi_targets_message_function = function(source_player, fail_count, reason)
        -- No reason to fail so far.
    end,
    print_enabled_all_by_admin_message_function = function(source_player, surface, enable)
        -- No enable all so far.
    end,
    cheats = {
        freeze_daytime = {
            is_default = true,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = function(surface)
                if surface then
                    return surface.freeze_daytime
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(surface, enable, source_player)
                surface.freeze_daytime = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, surface, enable)
                if enable then
                    surface.print { "message.creative-mode_daytime-frozen", source_player.name }
                else
                    surface.print { "message.creative-mode_daytime-unfrozen", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        daytime = {
            is_default = true,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(surface)
                if surface then
                    return surface.daytime
                end
                return nil
            end,
            limit_value_before_apply_function = function(value)
                return util.clamp(value, 0, 1)
            end,
            apply_to_target_function = function(surface, value, source_player)
                surface.daytime = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, surface, value)
                surface.print { "message.creative-mode_daytime-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        daytime_selection = {
            is_default = false,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = function(surface)
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(surface, enable, source_player)
                local value
                if enable then
                    value = 0
                else
                    value = 0.5
                end
                cheats.apply_cheat_to_targets(source_player, { surface }, cheats.surface_cheats_data,
                    cheats.surface_cheats_data.cheats.daytime, value, false)
                -- Update the GUI status of the daytime cheat.
                gui_menu_cheats.update_daytime_cheats_status_for_all_players_as_surface_updated_its_daytime(surface)
            end,
            print_applied_by_admin_message_function = function(source_player, surface, enable)
                local value
                if enable then
                    value = 0
                else
                    value = 0.5
                end
                surface.print { "message.creative-mode_daytime-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        peaceful_mode = {
            is_default = false,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = function(surface)
                if surface then
                    return surface.peaceful_mode
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(surface, enable, source_player)
                surface.peaceful_mode = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, surface, enable)
                if enable then
                    surface.print { "message.creative-mode_peaceful-mode-enabled", source_player.name }
                else
                    surface.print { "message.creative-mode_peaceful-mode-disabled", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        destroy_all_enemies = {
            is_default = false,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = nil,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(surface, value, source_player)
                for chunk in surface.get_chunks() do
                    local area = { { chunk.x * 32, chunk.y * 32 }, { chunk.x * 32 + 32, chunk.y * 32 + 32 } }
                    for _, entity in pairs(surface.find_entities_filtered {
                        area = area,
                        force = "enemy"
                    }) do
                        util.kill_entity_and_raise_event(entity, source_player)
                    end
                end
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, surface, value)
                surface.print { "message.creative-mode_destroy-all-enemies-applied", source_player.name }
            end,
            get_player_can_access_function = nil
        },
        remove_all_enemies = {
            is_default = false,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = nil,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(surface, value, source_player)
                for chunk in surface.get_chunks() do
                    local area = { { chunk.x * 32, chunk.y * 32 }, { chunk.x * 32 + 32, chunk.y * 32 + 32 } }
                    for _, entity in pairs(surface.find_entities_filtered {
                        area = area,
                        force = "enemy"
                    }) do
                        util.destroy_entity_and_raise_event(entity, source_player, false)
                    end
                end
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, surface, value)
                surface.print { "message.creative-mode_remove-all-enemies-applied", source_player.name }
            end,
            get_player_can_access_function = nil
        },
        dont_generate_enemy = {
            is_default = false,
            default_enable_value = true,
            default_disable_value = false,
            get_value_function = function(surface)
                if surface then
                    return storage.creative_mode.surface_cheats.dont_generate_enemy[surface.index] == true
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(surface, enable, source_player)
                storage.creative_mode.surface_cheats.dont_generate_enemy[surface.index] = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, surface, enable)
                if enable then
                    surface.print { "message.creative-mode_dont-generate-enemy-enabled", source_player.name }
                else
                    surface.print { "message.creative-mode_dont-generate-enemy-disabled", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        }
    }
}

-- Data about all global cheats.
cheats.global_cheats_data = {
    check_is_self_function = function(source_player, target)
        return false
    end,
    print_admin_failed_to_apply_to_single_target_message_function = function(source_player, target, reason)
        -- No reason to fail so far.
    end,
    print_admin_failed_to_apply_to_multi_targets_message_function = function(source_player, fail_count, reason)
        -- No reason to fail so far.
    end,
    print_enabled_all_by_admin_message_function = function(source_player, target, enable)
        -- No enable all so far.
    end,
    cheats = {
        pollution = {
            is_default = false,
            default_enable_value = false,
            default_disable_value = true,
            get_value_function = function(target)
                return game.map_settings.pollution.enabled
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(target, enable, source_player)
                game.map_settings.pollution.enabled = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, target, enable)
                if enable then
                    game.print { "message.creative-mode_pollution-enabled", source_player.name }
                else
                    game.print { "message.creative-mode_pollution-disabled", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        enemy_evolution = {
            is_default = false,
            default_enable_value = false,
            default_disable_value = true,
            get_value_function = function(target)
                return game.map_settings.enemy_evolution.enabled
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(target, enable, source_player)
                game.map_settings.enemy_evolution.enabled = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, target, enable)
                if enable then
                    game.print { "message.creative-mode_enemy-evolution-enabled", source_player.name }
                else
                    game.print { "message.creative-mode_enemy-evolution-disabled", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        evolution_time_factor = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(target)
                return game.map_settings.enemy_evolution.time_factor
            end,
            limit_value_before_apply_function = large_range_limit_value_before_apply_function,
            apply_to_target_function = function(target, value, source_player)
                game.map_settings.enemy_evolution.time_factor = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, target, value)
                game.print { "message.creative-mode_evolution-time-factor-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        evolution_destroy_factor = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(target)
                return game.map_settings.enemy_evolution.destroy_factor
            end,
            limit_value_before_apply_function = large_range_limit_value_before_apply_function,
            apply_to_target_function = function(target, value, source_player)
                game.map_settings.enemy_evolution.destroy_factor = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, target, value)
                game.print { "message.creative-mode_evolution-destroy-factor-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        evolution_pollution_factor = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(target)
                return game.map_settings.enemy_evolution.pollution_factor
            end,
            limit_value_before_apply_function = large_range_limit_value_before_apply_function,
            apply_to_target_function = function(target, value, source_player)
                game.map_settings.enemy_evolution.pollution_factor = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, target, value)
                game.print { "message.creative-mode_evolution-pollution-factor-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        enemy_expansion = {
            is_default = false,
            default_enable_value = false,
            default_disable_value = true,
            get_value_function = function(target)
                return game.map_settings.enemy_expansion.enabled
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(target, enable, source_player)
                game.map_settings.enemy_expansion.enabled = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, target, enable)
                if enable then
                    game.print { "message.creative-mode_enemy-expansion-enabled", source_player.name }
                else
                    game.print { "message.creative-mode_enemy-expansion-disabled", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        enemy_expansion_min_cooldown = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(target)
                return game.map_settings.enemy_expansion.min_expansion_cooldown
            end,
            limit_value_before_apply_function = uint32_limit_value_before_apply_function,
            apply_to_target_function = function(target, value, source_player)
                game.map_settings.enemy_expansion.min_expansion_cooldown = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, target, value)
                game.print { "message.creative-mode_enemy-expansion-min-cooldown-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        enemy_expansion_max_cooldown = {
            is_default = false,
            default_enable_value = 0,
            default_disable_value = 0,
            get_value_function = function(target)
                return game.map_settings.enemy_expansion.max_expansion_cooldown
            end,
            limit_value_before_apply_function = uint32_limit_value_before_apply_function,
            apply_to_target_function = function(target, value, source_player)
                game.map_settings.enemy_expansion.max_expansion_cooldown = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, target, value)
                game.print { "message.creative-mode_enemy-expansion-max-cooldown-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        },
        game_speed = {
            is_default = false,
            default_enable_value = 1,
            default_disable_value = 1,
            get_value_function = function(target)
                return game.speed
            end,
            limit_value_before_apply_function = function(value)
                return util.clamp(value, 0.1, 100)
            end,
            apply_to_target_function = function(target, value, source_player)
                game.speed = value
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, target, value)
                game.print { "message.creative-mode_game-speed-updated", source_player.name, value }
            end,
            get_player_can_access_function = nil
        }
    }
}

-- Data about all build options.
cheats.build_options_data = {
    check_is_self_function = function(source_player, player)
        return source_player == player
    end,
    print_admin_failed_to_apply_to_single_target_message_function = function(source_player, target, reason)
        -- No reason to fail so far.
    end,
    print_admin_failed_to_apply_to_multi_targets_message_function = function(source_player, fail_count, reason)
        -- No reason to fail so far.
    end,
    print_enabled_all_by_admin_message_function = function(source_player, player, enable)
        -- No enable all so far.
    end,
    cheats = {
        active = {
            is_default = false,
            default_enable_value = false,
            default_disable_value = true,
            get_value_function = function(player)
                if player then
                    if storage.creative_mode.build_options.active[player.index] ~= nil then
                        return storage.creative_mode.build_options.active[player.index]
                    else
                        return true
                    end
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(player, enable, source_player)
                storage.creative_mode.build_options.active[player.index] = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, player, enable)
                if enable then
                    player.print { "message.creative-mode_build-active-enabled-by-admin", source_player.name }
                else
                    player.print { "message.creative-mode_build-active-disabled-by-admin", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        destructible = {
            is_default = false,
            default_enable_value = false,
            default_disable_value = true,
            get_value_function = function(player)
                if player then
                    if storage.creative_mode.build_options.destructible[player.index] ~= nil then
                        return storage.creative_mode.build_options.destructible[player.index]
                    else
                        return true
                    end
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(player, enable, source_player)
                storage.creative_mode.build_options.destructible[player.index] = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, player, enable)
                if enable then
                    player.print { "message.creative-mode_build-destructible-enabled-by-admin", source_player.name }
                else
                    player.print { "message.creative-mode_build-destructible-disabled-by-admin", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        minable = {
            is_default = false,
            default_enable_value = false,
            default_disable_value = true,
            get_value_function = function(player)
                if player then
                    if storage.creative_mode.build_options.minable[player.index] ~= nil then
                        return storage.creative_mode.build_options.minable[player.index]
                    else
                        return true
                    end
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(player, enable, source_player)
                storage.creative_mode.build_options.minable[player.index] = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, player, enable)
                if enable then
                    player.print { "message.creative-mode_build-minable-enabled-by-admin", source_player.name }
                else
                    player.print { "message.creative-mode_build-minable-disabled-by-admin", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        rotatable = {
            is_default = false,
            default_enable_value = false,
            default_disable_value = true,
            get_value_function = function(player)
                if player then
                    if storage.creative_mode.build_options.rotatable[player.index] ~= nil then
                        return storage.creative_mode.build_options.rotatable[player.index]
                    else
                        return true
                    end
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(player, enable, source_player)
                storage.creative_mode.build_options.rotatable[player.index] = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, player, enable)
                if enable then
                    player.print { "message.creative-mode_build-rotatable-enabled-by-admin", source_player.name }
                else
                    player.print { "message.creative-mode_build-rotatable-disabled-by-admin", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        operable = {
            is_default = false,
            default_enable_value = false,
            default_disable_value = true,
            get_value_function = function(player)
                if player then
                    if storage.creative_mode.build_options.operable[player.index] ~= nil then
                        return storage.creative_mode.build_options.operable[player.index]
                    else
                        return true
                    end
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(player, enable, source_player)
                storage.creative_mode.build_options.operable[player.index] = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, player, enable)
                if enable then
                    player.print { "message.creative-mode_build-operable-enabled-by-admin", source_player.name }
                else
                    player.print { "message.creative-mode_build-operable-disabled-by-admin", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        full_health = {
            is_default = false,
            default_enable_value = false,
            default_disable_value = true,
            get_value_function = function(player)
                if player then
                    if storage.creative_mode.build_options.full_health[player.index] ~= nil then
                        return storage.creative_mode.build_options.full_health[player.index]
                    else
                        return true
                    end
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(player, enable, source_player)
                storage.creative_mode.build_options.full_health[player.index] = enable
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, player, enable)
                if enable then
                    player.print { "message.creative-mode_build-full-health-enabled-by-admin", source_player.name }
                else
                    player.print { "message.creative-mode_build-full-health-disabled-by-admin", source_player.name }
                end
            end,
            get_player_can_access_function = nil
        },
        team = {
            is_default = false,
            default_enable_value = "",
            default_disable_value = "",
            get_value_function = function(player)
                if player then
                    if storage.creative_mode.build_options.team[player.index] ~= nil then
                        local force_name = storage.creative_mode.build_options.team[player.index]
                        if game.forces[force_name] then
                            return game.forces[force_name]
                        else
                            return player.force
                        end
                    else
                        return player.force
                    end
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(player, force, source_player)
                storage.creative_mode.build_options.team[player.index] = force.name
                return nil
            end,
            print_applied_by_admin_message_function = function(source_player, player, force)
                player.print { "message.creative-mode_build-team-updated-by-admin", source_player.name, force.name }
            end,
            get_player_can_access_function = rights.can_player_access_build_team_options
        }
    }
}

-- Data about all magic wand modifications.
-- Actually a simplified version of the above cheats data.
cheats.magic_wand_modifications = {
    check_is_self_function = function(source_player, target)
        return true
    end,
    cheats = {
        active = {
            get_value_function = function(entity)
                if entity and entity.valid then
                    return entity.active
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(entity, enable, source_player)
                -- Fix for this bug report: https://forums.factorio.com/viewtopic.php?f=30&t=41386&p=243803#p243803
                if entity.type == "smoke" or entity.type == "corpse" then
                    return nil
                end
                if entity.name == "entity-ghost" or entity.name == "tile-ghost" then
                    return nil
                end
                entity.active = enable
                return nil
            end
        },
        destructible = {
            get_value_function = function(entity)
                if entity and entity.valid then
                    return entity.destructible
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(entity, enable, source_player)
                entity.destructible = enable
                return nil
            end
        },
        minable = {
            get_value_function = function(entity)
                if entity and entity.valid then
                    return entity.minable
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(entity, enable, source_player)
                entity.minable = enable
                return nil
            end
        },
        rotatable = {
            get_value_function = function(entity)
                if entity and entity.valid then
                    return entity.rotatable
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(entity, enable, source_player)
                entity.rotatable = enable
                return nil
            end
        },
        operable = {
            get_value_function = function(entity)
                if entity and entity.valid then
                    return entity.operable
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(entity, enable, source_player)
                entity.operable = enable
                return nil
            end
        },
        full_health = {
            get_value_function = function(entity)
                if entity and entity.valid then
                    if entity.health then
                        return entity.health >= entity.prototype.max_health
                    end
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(entity, enable, source_player)
                if entity.health then
                    if enable then
                        entity.health = entity.prototype.max_health
                    else
                        entity.health = 1
                    end
                end
                return nil
            end
        },
        backer_name = {
            get_value_function = function(entity)
                if entity and entity.valid then
                    return entity.backer_name
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(entity, value, source_player)
                if entity.supports_backer_name() then
                    entity.backer_name = value
                end
                return nil
            end
        },
        to_be_looted = {
            get_value_function = function(entity)
                if entity and entity.valid then
                    if entity.name == "item-on-ground" then
                        return entity.to_be_looted
                    end
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(entity, enable, source_player)
                if entity.name == "item-on-ground" then
                    entity.to_be_looted = enable
                end
                return nil
            end
        },
        revive = {
            get_value_function = nil,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(entity, value, source_player)
                if entity.name == "entity-ghost" then
                    util.revive_entity_ghost_and_raise_event(entity, source_player, false)
                elseif entity.name == "tile-ghost" then
                    util.revive_tile_ghost_and_raise_event(entity, source_player, false)
                end
                return nil
            end
        },
        kill = {
            get_value_function = nil,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(entity, value, source_player)
                util.kill_entity_and_raise_event(entity, source_player)
                return nil
            end
        },
        destroy = {
            get_value_function = nil,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(entity, value, source_player)
                util.destroy_entity_and_raise_event(entity, source_player, false)
                return nil
            end
        },
        team = {
            get_value_function = function(entity)
                if entity and entity.valid then
                    return entity.force
                end
                return nil
            end,
            limit_value_before_apply_function = nil,
            apply_to_target_function = function(entity, force, source_player)
                entity.force = force
                return nil
            end
        }
    }
}

--------------------------------------------------------------------

-- Applies the given value to the cheat of given cheat data (e.g. cheat_mode), under the given cheats data (e.g. personal_cheats_data), to the given targets.
-- If the cheat is simply an apply-cheat, just provide nil for the value.
function cheats.apply_cheat_to_targets(source_player, targets, cheats_data, cheat, value, should_print_message)
    local fail_count = 0
    local is_self_failed = false
    local failed_target = nil
    local failure_reason = nil
    -- Limit value before it is applied if necessary.
    if cheat.limit_value_before_apply_function then
        value = cheat.limit_value_before_apply_function(value)
    end
    -- Apply to targets.
    if targets then
        for _, target in pairs(targets) do
            if target.valid then -- Just play safe.
                local value_before_change
                if cheat.get_value_function == nil then
                    value_before_change = -1
                else
                    value_before_change = cheat.get_value_function(target)
                end
                local failure = cheat.apply_to_target_function(target, value, source_player)
                local is_self = cheats_data.check_is_self_function(source_player, target)
                if failure == nil then
                    -- Succeeded to apply the cheat.
                    -- It is possible that floating-point values are rounded by Factorio internally.
                    local value_after_change
                    if cheat.get_value_function == nil then
                        value_after_change = 0 -- Make sure it is different from value_before_change
                    else
                        value_after_change = cheat.get_value_function(target)
                    end
                    if should_print_message and not is_self then
                        if value_before_change ~= value_after_change then
                            cheat.print_applied_by_admin_message_function(source_player, target, value_after_change)
                        else
                            -- Before is the same as after. But some cheats just cannot get the current value. They are always nil.
                            -- In that case, we print the message according to the value.
                            if value_after_change == nil then
                                cheat.print_applied_by_admin_message_function(source_player, target, value)
                            end
                        end
                    end
                else
                    -- Failed to apply the cheat.
                    is_self_failed = is_self_failed or is_self
                    failed_target = target
                    if failure_reason == nil then
                        failure_reason = failure
                    end
                    fail_count = fail_count + 1
                end
            end
        end
    else
        -- No target. It may be the game itself.
        local value_before_change
        if cheat.get_value_function == nil then
            value_before_change = -1
        else
            value_before_change = cheat.get_value_function(nil)
        end
        local failure = cheat.apply_to_target_function(nil, value, source_player)
        local is_self = cheats_data.check_is_self_function(source_player, nil)
        if failure == nil then
            -- Succeeded to apply the cheat.
            local value_after_change
            if cheat.get_value_function == nil then
                value_after_change = 0
            else
                value_after_change = cheat.get_value_function(nil)
            end
            if should_print_message and not is_self and value_before_change ~= value_after_change then
                cheat.print_applied_by_admin_message_function(source_player, nil, value_after_change)
            end
        else
            -- Failed to apply the cheat.
            is_self_failed = is_self_failed or is_self
            failed_target = nil
            if failure_reason == nil then
                failure_reason = failure
            end
            fail_count = fail_count + 1
        end
    end

    -- Failed to apply on one or more players
    if should_print_message and failure_reason ~= nil then
        if fail_count <= 1 then
            if is_self_failed then
                -- Failed to apply on self.
                source_player.print(failure_reason)
            else
                -- Failed to apply on a non-self target.
                cheats_data.print_admin_failed_to_apply_to_single_target_message_function(source_player, failed_target,
                    failure_reason)
            end
        else
            -- Failed to apply on multiple targets.
            cheats_data.print_admin_failed_to_apply_to_multi_targets_message_function(source_player, fail_count,
                failure_reason)
        end
    end
    return fail_count
end

-- Enables or disables all the cheats in the given cheats data to the given targets.
-- @param cheats_data	For example, the personal_cheats_data.
function cheats.enable_or_disable_all_cheats_to_targets(source_player, targets, cheats_data, enable,
                                                        should_print_message)
    -- Iterate all cheats inside the cheats_data to enable or disable them.
    for _, cheat_data in pairs(cheats_data.cheats) do
        local is_default
        if enable and source_player and cheat_data.get_is_default_from_player then
            is_default = cheat_data.get_is_default_from_player(source_player)
        else
            is_default = cheat_data.is_default
        end
        if is_default then
            if cheat_data.get_player_can_access_function == nil or
                cheat_data.get_player_can_access_function(source_player) then
                local value
                if enable then
                    if source_player and cheat_data.get_default_enable_value_from_player then
                        value = cheat_data.get_default_enable_value_from_player(source_player)
                    else
                        value = cheat_data.default_enable_value
                    end
                else
                    value = cheat_data.default_disable_value
                end
                cheats.apply_cheat_to_targets(source_player, targets, cheats_data, cheat_data, value, false)
            end
        end
    end
    -- Print to targets.
    if should_print_message then
        for _, target in pairs(targets) do
            local is_self = cheats_data.check_is_self_function(source_player, target)
            if not is_self then
                cheats_data.print_enabled_all_by_admin_message_function(source_player, target, enable)
            end
        end
    end
end

--------------------------------------------------------------------

-- Returns whether Creative Mode has been enabled. If not, a message will be printed for the given player.
function cheats.check_creative_mode_has_enabled(player)
    -- If creative mode has not been enabled, notify the player in charge and do nothing.
    if not storage.creative_mode.enabled then
        if player then
            player.print { "message.creative-mode_not-yet-enabled" }
        end
        return false
    end
    return true
end

-- Enables or disables Creative Mode for all players.
-- @param source_player	The player who enables or disables Creative Mode.
-- @param ignore_current_state Whether the current state of Creative Mode should be ignored, such that the given command for enabling or disabling Creative Mode will be executed for sure.
function cheats.enable_or_disable_creative_mode(source_player, enable, is_permanent, auto_apply_to_all_cheats,
                                                ignore_current_state)
    if not ignore_current_state then
        if enable then
            -- If creative mode has been enabled, notify the player in charge and do nothing.
            if storage.creative_mode.enabled then
                if source_player then
                    source_player.print { "message.creative-mode_already-enabled" }
                end
                return
            end

            -- If creative mode has already been permanently disabled, notify the player in charge and do nothing.
            if storage.creative_mode.permanently_disabled then
                if source_player then
                    source_player.print { "message.creative-mode_enable-failed" }
                end
                return
            end
        else
            -- If creative mode has not been enabled, notify the player in charge and do nothing.
            if not cheats.check_creative_mode_has_enabled(source_player) then
                return
            end
        end
    end

    -- Also unhide/hide the items so they can be selected as filter.
    -- Unfortunately, LuaItemPrototype doesn't have flags property. This cannot be done at this moment.
    --		for _, item in pairs(creative_mode_defines.names.items) do
    --			if prototypes.item[item] ~= nil then
    --				if enable then
    --					table.remove(prototypes.item[item].flags, 2) -- The hidden flag is the second one.
    --				else
    --					table.insert(prototypes.item[item].flags, "hidden")
    --				end
    --			end
    --		end

    local player_name = source_player.name

    -- Save as creative mode has been enabled/disabled.
    local previous_state = storage.creative_mode.enabled
    storage.creative_mode.enabled = enable

    if enable then
        -- Notify the players.
        game.print { "message.creative-mode_enable-succeeded", player_name }

        -- Also raise the on-enable event.
        if not previous_state then
            remote_interface.raise_on_enabled_event(source_player)
        end
    else
        -- Notify the players.
        if is_permanent then
            game.print { "message.creative-mode_permanently-disable-succeeded", player_name }
        else
            game.print { "message.creative-mode_disable-succeeded", player_name }
        end

        -- Also raise the on-disable event.
        if previous_state then
            remote_interface.raise_on_disabled_event(source_player)
        end
    end

    -- If it is permanently disabled, save the state so it cannot be enabled later.
    if not enable and is_permanent then
        storage.creative_mode.permanently_disabled = true
    end

    -- Apply to all cheats if needed
    if auto_apply_to_all_cheats then
        -- Personal cheats.
        cheats.enable_or_disable_all_cheats_to_targets(source_player, game.players, cheats.personal_cheats_data, enable,
            false)
        -- Team cheats.
        cheats.enable_or_disable_all_cheats_to_targets(source_player, game.forces, cheats.team_cheats_data, enable,
            false)
        -- Surface cheat - freeze daytime.
        cheats.apply_cheat_to_targets(source_player, game.surfaces, cheats.surface_cheats_data,
            cheats.surface_cheats_data.cheats.freeze_daytime, enable, false)
        -- Surface cheat - set daytime to 0.
        if enable then
            cheats.apply_cheat_to_targets(source_player, game.surfaces, cheats.surface_cheats_data,
                cheats.surface_cheats_data.cheats.daytime, 0, false)
        end

        if enable then
            game.print { "message.creative-mode_enabled-all-cheats", player_name }
        end
    else
        -- Unlock the creative tools' recipes.
        for _, force in pairs(game.forces) do
            cheats.team_cheats_data.cheats.creative_tools_recipes.apply_to_target_function(force, enable, nil)
        end
    end

    -- Create or destroy the Creative Mode menu button.
    gui_menu.create_or_destroy_main_menu_open_button_for_all_players()
end

--------------------------------------------------------------------

-- Returns whether the given player is a valid candidate for instant request.
local function is_player_valid_for_instant_request(player)
    return player and storage.creative_mode.personal_cheats.instant_request[player.index] and player.valid and
        player.connected and
        player.character
end

-- Returns the number of logistic request slot on the given character.
function get_character_request_slot_count(entity)
    local slot_count = 0
    for _, point in ipairs(entity.get_logistic_point()) do
        if point ~= nil and point.enabled and point.filters ~= nil then
            slot_count = slot_count + #point.filters
        end
    end
    return slot_count
end

-- Applies instant request on the player's character with the given slot index.
local function apply_instant_request_on_player_character_slot(player, character, slot_index)
    local points = character.get_logistic_point()
    for _, point in ipairs(points) do
        if point ~= nil and point.enabled and point.filters ~= nil then
            local requested_item_stack = point.filters[slot_index]
        local item_count_diff = requested_item_stack.count - player.get_item_count(requested_item_stack.name)
        if item_count_diff > 0 then
            -- Insert the wanted item.
            player.insert {
                name = requested_item_stack.name,
                count = item_count_diff
            }
            end
        end
    end
end

-- Returns whether the given player is a valid candidate for instant trash.
local function is_player_valid_for_instant_trash(player)
    return storage.creative_mode.personal_cheats.instant_trash[player.index] and player.valid and player.connected and
        player.character
end

-- Returns the logistic trash inventory on the given character.
local function get_character_trash_inventory(character)
    return character.get_inventory(defines.inventory.character_trash)
end

-- Applies instant trash on the given logistic trash inventory of the given player's character.
local function apply_instant_trash_on_player_character_inventory(player, character, inventory)
    if inventory then
        inventory.clear()
    end
end

-- Returns 1) the next valid player for slot cheat, e.g. instant request or instant trash, 2) whether the player index is updated,
-- 3) the iterated next player index, and 4) the remaining number of check player count
local function get_next_valid_player_for_slot_cheat(initial_next_player_index, current_next_player_index,
                                                    check_same_player_index, remaining_total_check_player_count,
                                                    check_player_valid_function)
    local player_count = #game.players
    local player_index_updated = false
    repeat
        -- If the player index exceeds the number of players, go back to the first player.
        if current_next_player_index > player_count then
            if current_next_player_index <= 1 then
                -- But we have started the search from the first player. Even the first player is invalid, so, no player will be valid.
                return nil, false, current_next_player_index, remaining_total_check_player_count
            end
            current_next_player_index = 1
            player_index_updated = true
        end

        -- Avoid infinite loop.
        if check_same_player_index and initial_next_player_index == current_next_player_index then
            -- We are back to the starting player. Don't process anymore!
            return nil, player_index_updated, current_next_player_index, remaining_total_check_player_count
        end

        local player = game.players[current_next_player_index]
        if check_player_valid_function(player) then
            -- The player is a valid candidate.
            return player, player_index_updated, current_next_player_index, remaining_total_check_player_count
        end

        -- Invalid candidate, check the next player.
        current_next_player_index = current_next_player_index + 1
        player_index_updated = true
        check_same_player_index = true
        remaining_total_check_player_count = remaining_total_check_player_count - 1
        if remaining_total_check_player_count <= 0 then
            -- But not more step remaining. Cannot check anymore players.
            return nil, false, current_next_player_index, remaining_total_check_player_count
        end
    until false
end

-- Applies slot cheat, e.g. instant request or instant trash, to players according to the given settings.
-- Returns the next player index and next slot index.
-- @param initial_next_player_index					The first next_player_index. It should be found from storage.
-- @param initial_slot_index						The first next_player_slot_index. It should be found from storage.
-- @param check_player_valid_function				The function for getting valid players for applying the cheat. It should accept LuaPlayer as parameter and returns Boolean, true for valid and false for invalid.
-- @param have_specific_inventory					Whether the cheat can be applied on specific inventory on the player's character. It is false for instant request, as there is no logsitic request inventory. But it is true for instant trash.
-- @param apply_to_whole_inventory_at_once			If there is a specific inventory, whether the cheat can be applied to the whole inventory at once. For instant trash, it is true.
-- @param get_inventory_or_slot_count_function		The function for getting the inventory, or maximum number of slots to be operated on the same player. It should accept LuaEntity (character) and returns either the inventory or the number of slots.
-- @param apply_effect_function						The function for actually applying cheat effect on players. It should accept LuaPlayer, LuaEntity (character). If the cheat cannot be applied to the whole inventory at once, it should also accept uint (slot index). If there is specific inventory, it should also accept the inventory.
local function apply_slot_cheat_to_players(initial_next_player_index, initial_slot_index, check_player_valid_function,
                                           have_specific_inventory, apply_to_whole_inventory_at_once,
                                           get_inventory_or_slot_count_function,
                                           apply_effect_function)
    -- Note: the logic is different from Creative Chest.
    -- 		For Creative Chest, if the iterated chest is invalid, the tick will do nothing.
    -- 		But for instant request (and instant trash), we want every ticks to be busy, to shorten the time between updates on each player.
    --		Therefore, if an invalid player is iterated, we quickly find the next valid player to perform the actions.
    -- Maximum number of players to be checked in each tick.
    local remaining_total_check_player_count = 1
    -- Maximum number of slots to be operated in each tick.
    local remaining_total_slot_count = 200
    -- Remember the first player. If we go back to this player, the process should be ended. Otherwise, it is most likely an infinite loop.
    local current_next_player_index = initial_next_player_index
    local check_same_player_index = false
    -- Get the slot index to start with.
    local slot_index = initial_slot_index
    repeat
        -- Get the valid player.
        local player, player_index_updated
        player, player_index_updated, current_next_player_index, remaining_total_check_player_count =
        get_next_valid_player_for_slot_cheat(initial_next_player_index, current_next_player_index,
            check_same_player_index, remaining_total_check_player_count, check_player_valid_function)
        if player then
            current_next_player_index = player.index

            -- Get character and apply cheat.
            local character = player.character
            local slot_count
            local inventory = nil
            if have_specific_inventory then
                inventory = get_inventory_or_slot_count_function(character)
            else
                slot_count = get_inventory_or_slot_count_function(character)
            end

            if have_specific_inventory and apply_to_whole_inventory_at_once then
                -- Apply to the whole inventory at once.
                apply_effect_function(player, character, inventory)

                -- Next player.
                current_next_player_index = current_next_player_index + 1
                remaining_total_check_player_count = remaining_total_check_player_count - 1
                if remaining_total_check_player_count <= 0 then
                    -- But we have no more processing power to check more players.
                    break
                end
            else
                -- Apply to the slots one by one.
                if player_index_updated then
                    -- The player index has been updated. Reset slot index.
                    slot_index = 1
                end
                -- Get slot count.
                if have_specific_inventory then
                    if inventory then
                        slot_count = #inventory
                    else
                        slot_count = 0
                    end
                end
                local i_max = math.min(slot_index + remaining_total_slot_count - 1, slot_count)
                for i = slot_index, i_max, 1 do
                    -- Apply the cheat on the iterated slot.
                    apply_effect_function(player, character, i, inventory)
                    remaining_total_slot_count = remaining_total_slot_count - 1
                    slot_index = slot_index + 1
                end

                if remaining_total_slot_count > 0 then
                    -- We can check more slots. Go to the next player.
                    current_next_player_index = current_next_player_index + 1
                    slot_index = 1
                    remaining_total_check_player_count = remaining_total_check_player_count - 1
                    if remaining_total_check_player_count <= 0 then
                        -- But we have no more processing power to check more players.
                        break
                    end
                else
                    -- No more processing power to iterate more slots.
                    if slot_index > slot_count then
                        -- All requester slots have been checked. Move to next player for the next tick.
                        current_next_player_index = current_next_player_index + 1
                        slot_index = 1
                    end
                    break
                end
            end
        else
            -- No more valid player.
            slot_index = 1
            break
        end
        -- We should check whether the processed player is itereated this time, to avoid infinite loop.
        check_same_player_index = true
    until false
    -- Make sure player index is in range before saving in storage.
    if current_next_player_index > #game.players then
        current_next_player_index = 1
    end
    return current_next_player_index, slot_index
end

------------------------------------------------------------

-- Applies cheat events that have been pending in the previous ticks.
function cheats.tick()
    -- Instant request.
    storage.creative_mode.personal_cheats.instant_request_next_player_index, storage.creative_mode.personal_cheats
        .instant_request_next_player_slot_index = apply_slot_cheat_to_players(
        storage.creative_mode.personal_cheats
        .instant_request_next_player_index, storage.creative_mode
        .personal_cheats.instant_request_next_player_slot_index,
        is_player_valid_for_instant_request, false, false,
        get_character_request_slot_count,
        apply_instant_request_on_player_character_slot)

    -- Instant trash.
    storage.creative_mode.personal_cheats.instant_trash_next_player_index, _ =
    apply_slot_cheat_to_players(storage.creative_mode.personal_cheats.instant_trash_next_player_index, 0,
        is_player_valid_for_instant_trash, true, true, get_character_trash_inventory,
        apply_instant_trash_on_player_character_inventory)

    -- Instant blueprint. Iterate from back to front.
    for i = #storage.creative_mode.pending_instant_blueprint, 1, -1 do
        local data = storage.creative_mode.pending_instant_blueprint[i]
        local entity = data.entity
        if entity.valid then
            local player_index = data.player_index
            local player = game.players[player_index]
            local is_item_request_proxy = data.is_item_request_proxy
            if is_item_request_proxy then
                -- It is an item request proxy. Fulfill its request.
                entity.item_requests = util.fulfill_item_requests(entity.proxy_target, entity.item_requests)
                -- Check if all items have be inserted so we can destroy the proxy.
                local is_fulfilled = true
                for item_name, item_count in pairs(entity.item_requests) do
                    if item_count > 0 then
                        is_fulfilled = false
                        break
                    end
                end
                if is_fulfilled then
                    entity.destroy()
                end
                table.remove(storage.creative_mode.pending_instant_blueprint, i)
            else
                -- It is a ghost entity. Revive it.
                local is_entity_ghost = data.is_entity_ghost
                local try_revive_count = data.try_revive_count
                local revive_result
                if is_entity_ghost then
                    revive_result = util.revive_entity_ghost_and_raise_event(entity, player, true)
                else
                    revive_result = util.revive_tile_ghost_and_raise_event(entity, player, true)
                end

                if revive_result == nil then
                    -- The ghost can not be revived.
                    if try_revive_count >= 1 then
                        -- We have tried before, but still no luck. Just give up.
                        table.remove(storage.creative_mode.pending_instant_blueprint, i)
                    else
                        -- Try again in the next tick.
                        storage.creative_mode.pending_instant_blueprint[i].try_revive_count = try_revive_count + 1
                    end
                end
            end
        else
            table.remove(storage.creative_mode.pending_instant_blueprint, i)
        end
    end

    -- Instant deconstruction. Iterate from back to front.
    -- Prepare for tile deconstruction.
    local new_tiles_on_surfaces = nil
    for i = #storage.creative_mode.pending_instant_deconstruction, 1, -1 do
        local data = storage.creative_mode.pending_instant_deconstruction[i]
        local entity = data.entity
        if entity.valid then
            local player_index = data.player_index
            -- Make sure it is really needed to deconstruct.
            -- Filtered Deconstruction Planner unmarks filtered entities right after they are marked by the deconstruction planner.
            if entity.to_be_deconstructed(entity.force) then
                if entity.type == "deconstructible-tile-proxy" then
                    -- It is a tile to be removed, not a real entity.
                    local surface = entity.surface
                    local surface_name = surface.name
                    local position = entity.position
                    -- Don't mine the raw tiles. Only mine the man-made ones (covering hidden tiles).
                    local hidden_tile = surface.get_hidden_tile(position)
                    if hidden_tile then
                        -- Group the tiles to be set. Set them only after all data is ready.
                        if not new_tiles_on_surfaces then
                            new_tiles_on_surfaces = {}
                        end
                        -- Don't directly use "surface" as the key, because in each iteration, surface is a different instance of table. Use surface name instead because it is a primitive data type.
                        if not new_tiles_on_surfaces[surface_name] then
                            new_tiles_on_surfaces[surface_name] = {}
                        end
                        -- Tile array, for setting tiles.
                        if not new_tiles_on_surfaces[surface_name].tiles then
                            new_tiles_on_surfaces[surface_name].tiles = {}
                        end
                        -- Position array associated with player index, for raising event.
                        if not new_tiles_on_surfaces[surface_name].event_data then
                            new_tiles_on_surfaces[surface_name].event_data = {}
                        end
                        if not new_tiles_on_surfaces[surface_name].event_data[player_index] then
                            new_tiles_on_surfaces[surface_name].event_data[player_index] = {}
                        end
                        -- Record.
                        table.insert(new_tiles_on_surfaces[surface_name].event_data[player_index], position)
                        table.insert(new_tiles_on_surfaces[surface_name].tiles, {
                            name = hidden_tile,
                            position = position
                        })
                    end
                    entity.destroy()
                else
                    util.destroy_entity_and_raise_event(entity, game.players[player_index], true)
                end
            end
        end
        table.remove(storage.creative_mode.pending_instant_deconstruction, i)
    end
    -- Destroy tiles and raise event.
    if new_tiles_on_surfaces then
        for surface_name, data in pairs(new_tiles_on_surfaces) do
            local surface = game.surfaces[surface_name]
            -- Set tiles and raise the event
            surface.set_tiles(data.tiles, true, true, true, true)
        end
    end

    -- Surface cheat - don't generate enemy.
    for i = #storage.creative_mode.pending_areas_to_remove_enemies, 1, -1 do
        local surface = storage.creative_mode.pending_areas_to_remove_enemies[i].surface
        local area = storage.creative_mode.pending_areas_to_remove_enemies[i].area
        if surface.valid then
            for _, entity in pairs(surface.find_entities_filtered {
                area = area,
                force = "enemy"
            }) do
                entity.destroy()
            end
        end
        table.remove(storage.creative_mode.pending_areas_to_remove_enemies, i)
    end
end

----

-- List of blacklisted items that are going to be ignored by keep last item.
local keep_last_item_blacklist = {}
-- Registers or deregisters the given item name to or from the blacklist of keep last item.
-- If it is deregistration, returns whether the process is success.
function cheats.register_or_deregister_item_to_be_ignored_by_keep_last_item(item_name, is_register)
    if is_register then
        -- Register.
        keep_last_item_blacklist[item_name] = true
    else
        -- Deregister.
        if keep_last_item_blacklist[item_name] then
            keep_last_item_blacklist[item_name] = nil
            return true
        end
        return false
    end
end

-- Returns whether the given item name has been blacklisted by keep last item.
function cheats.has_item_ignored_by_keep_last_item(item_name)
    return keep_last_item_blacklist[item_name] ~= nil
end

-- Applies cheats to the player when he/she uses item to build something.
function cheats.on_pre_build(player)
    -- Keep last item.
    if storage.creative_mode.personal_cheats.keep_last_item[player.index] then
        local cursor_stack = player.cursor_stack
        if cursor_stack.valid_for_read then -- Don't know why sometimes the stack becomes invalid and causes error.
            local cursor_stack_name = cursor_stack.name
            -- Make sure the item is not blacklisted.
            if not keep_last_item_blacklist[cursor_stack_name] then
                if player.get_item_count(cursor_stack_name) <= 1 then
                    local cursor_stack_prototype = cursor_stack.prototype
                    if cursor_stack_prototype.stackable and cursor_stack_prototype.stack_size > 1 then
                        -- The item is stackable. Simply increase the stack size on the cursor.
                        cursor_stack.count = 2
                        -- But it is possible that cursor stack count is still 1 because the item is damaged, i.e. prototype is stackable but the actual item is not!
                        if cursor_stack.count <= 1 then
                            -- Insert an item to player's inventory.
                            if player.insert {
                                name = cursor_stack_name,
                                count = 1
                            } > 0 then
                                -- This event is invoked even if the player uses the item to build ghost entity, i.e. no item is going to be spent.
                                -- In that case, we will have to get back the inserted item.
                                storage.creative_mode.personal_cheats.has_restored_cursor_stack[player.index] = game.tick
                            end
                        else
                            -- Successfully set cursor stack to 2.
                            storage.creative_mode.personal_cheats.has_restored_cursor_stack[player.index] = game.tick
                        end
                    else
                        -- The item is not stackable. Insert the item to the player's inventory.
                        if player.insert {
                            name = cursor_stack_name,
                            count = 1
                        } > 0 then
                            storage.creative_mode.personal_cheats.has_restored_cursor_stack[player.index] = game.tick
                        end
                    end
                end
            end
        end
    end
end

----

-- List of blacklisted entities that are going to be ignored by instant blueprint.
local instant_blueprint_blacklist = {}

-- Registers or deregisters the given entity name to or from the blacklist of instant blueprint.
-- If it is deregistration, returns whether the process is success.
function cheats.register_or_deregister_entity_to_be_ignored_by_instant_blueprint(entity_name, is_register)
    if is_register then
        -- Register.
        instant_blueprint_blacklist[entity_name] = true
    else
        -- Deregister.
        if instant_blueprint_blacklist[entity_name] then
            instant_blueprint_blacklist[entity_name] = nil
            return true
        end
        return false
    end
end

-- Returns whether the given entity name has been blacklisted by instant blueprint.
function cheats.has_entity_ignored_by_instant_blueprint(entity_name)
    return instant_blueprint_blacklist[entity_name] ~= nil
end

-- Applies cheats to the player when he/she builds something.
function cheats.on_built_entity(player, entity, is_ghost, is_entity_ghost, is_item_request_proxy)
    -- Keep last item.
    if storage.creative_mode.personal_cheats.keep_last_item[player.index] then
        if storage.creative_mode.personal_cheats.has_restored_cursor_stack[player.index] == game.tick then
            -- An item has been given to the player for free.
            if is_ghost then
                -- But the player didn't spend the item. So, we get the item back.
                local cursor_stack = player.cursor_stack
                local cursor_stack_prototype = cursor_stack.prototype
                if cursor_stack_prototype.stackable and cursor_stack_prototype.stack_size > 1 then
                    cursor_stack.count = 1
                else
                    player.remove_item {
                        name = cursor_stack.name,
                        count = 1
                    }
                end
            end
        else --
            -- If the player use the rail planner system to build rails, it is possible that the rail is consumed but the on_pre_build was not fired.
            -- The following was a planned fix for that, but unfortunately, the cursor stack has already become invalid for read and we cannot get its data.
            --[[
			if not is_ghost and (entity.type == "straight-rail" or entity.type == "curved-rail") then
				local cursor_stack = player.cursor_stack
				-- Check if the stack is no longer valid (i.e. count <= 0) and it is a rail planner item.
				if not cursor_stack.count <= 0 and cursor_stack.prototype.straight_rail ~= nil then
					-- Keep the rail.
					player.cursor_stack.count = 1
				end
			end
			]]
            -- Approach no. 2
            -- It works, but need more work to make it mod-proof. (Build a rail entity type to rail item table)
            --[[
			if not is_ghost and (entity.type == "straight-rail" or entity.type == "curved-rail") then
				if player.get_item_count("rail") <= 0 then
					player.insert{name = "rail", count = 1}
				end
			end
			--]]
        end
        storage.creative_mode.personal_cheats.has_restored_cursor_stack[player.index] = nil
    end

    -- Build options.
    -- Active.
    if storage.creative_mode.build_options.active[player.index] == false then
        entity.active = false
    end
    -- Destructible.
    if storage.creative_mode.build_options.destructible[player.index] == false then
        entity.destructible = false
    end
    -- Minable.
    if storage.creative_mode.build_options.minable[player.index] == false then
        entity.minable = false
    end
    -- Rotatable.
    if storage.creative_mode.build_options.rotatable[player.index] == false then
        entity.rotatable = false
    end
    -- Operable.
    if storage.creative_mode.build_options.operable[player.index] == false then
        entity.operable = false
    end
    -- Full health.
    if storage.creative_mode.build_options.full_health[player.index] == false then
        if entity.health ~= nil then
            entity.health = 1
        end
    end
    -- Team.
    if storage.creative_mode.build_options.team[player.index] ~= nil then
        local force = game.forces[storage.creative_mode.build_options.team[player.index]]
        if force then
            entity.force = force
        end
    end

    -- Instant blueprint. (Has to be done at last.)
    if storage.creative_mode.personal_cheats.instant_blueprint[player.index] then
        if is_ghost or is_item_request_proxy then
            -- Make sure the entity is not ignored by instant blueprint.
            if not is_ghost or not instant_blueprint_blacklist[entity.ghost_name] then
                -- We don't do the job if the instant-blueprint mod is installed and is activated.
                if not mod_compatibler.is_instant_blueprint_installed_and_activated_for_player(player) then
                    -- Don't construct it right now.
                    table.insert(storage.creative_mode.pending_instant_blueprint, {
                        entity = entity,
                        player_index = player.index,
                        is_entity_ghost = is_entity_ghost,
                        try_revive_count = 0, -- We will only try to revive each ghost twice.
                        is_item_request_proxy = is_item_request_proxy
                    })
                end
            end
        end
    end
end

----

-- List of blacklisted entities that are going to be ignored by instant deconstruction.
local instant_deconstruction_blacklist = {}

-- Registers or deregisters the given entity name to or from the blacklist of instant deconstruction.
-- If it is deregistration, returns whether the process is success.
function cheats.register_or_deregister_entity_to_be_ignored_by_instant_deconstruction(entity_name, is_register)
    if is_register then
        -- Register.
        instant_deconstruction_blacklist[entity_name] = true
    else
        -- Deregister.
        if instant_deconstruction_blacklist[entity_name] then
            instant_deconstruction_blacklist[entity_name] = nil
            return true
        end
        return false
    end
end

-- Returns whether the given entity name has been blacklisted by instant deconstruction.
function cheats.has_entity_ignored_by_instant_deconstruction(entity_name)
    return instant_deconstruction_blacklist[entity_name] ~= nil
end

-- Applies cheats when an entity is marked for deconstruction.
function cheats.on_marked_for_deconstruction(player_index, entity)
    -- Thanks Nexela for the inspiration of following snippet.
    -- Instant deconstruction, raise script_raised_destroy event.
    -- Make sure player_index is provided. Some mods use LuaEntity::order_deconstruction which dosn't not have player_index.
    if player_index ~= nil then
        if storage.creative_mode.personal_cheats.instant_deconstruction[player_index] then
            -- Make sure the entity is not ignored.
            if not instant_deconstruction_blacklist[entity.name] then
                -- We shouldn't raise event if the instant-blueprint mod is installed and is activated.
                if not mod_compatibler.is_instant_blueprint_installed_and_activated_for_player_index(player_index) then
                    -- Don't destroy it right now. Filtered Deconstruction Planner may unmark the entity if it is filtered.
                    table.insert(storage.creative_mode.pending_instant_deconstruction, {
                        entity = entity,
                        player_index = player_index
                    })
                end
            end
        end
    end
end

----

-- Applies cheats when a player mined an entity, before it is removed from map.
function cheats.on_preplayer_mined_item(player_index, entity)
    -- Repair mined item.
    if storage.creative_mode.personal_cheats.repair_mined_item[player_index] then
        if entity.health ~= nil then
            entity.health = entity.prototype.get_max_health()
        end
    end
end

-- Applies cheats to the respawned player's character if necessary.
function cheats.on_player_respawned(event)
    local player = game.players[event.player_index]
    apply_character_cheats_to_player(player)
end

-- Applies cheats to the player who either newly joined the game or joined back the game.
function cheats.on_player_joined_game(event)
    local player = game.players[event.player_index]
    if player then
        apply_character_cheats_to_player(player)
    end
end

-- Applies cheats to the force whose research has been started if necessary.
function cheats.on_research_started(event)
    local research = event.research
    local force = research.force

    -- Exclude our void technology from the instant research... Destroys the point I guess :D
    if storage.creative_mode.team_cheats.instant_research[force.name] and research.name ~=
        creative_mode_defines.names.technology.void_technology then
        force.research_progress = 1
    end
end

-- Applies cheats to the newly generated chunk if necessary.
function cheats.on_chunk_generated(event)
    local area = event.area
    local surface = event.surface
    -- Surface cheat - don't generate enemy.
    if storage.creative_mode.surface_cheats.dont_generate_enemy[surface.index] then
        -- Remove the enemies in the on_tick event.
        -- Extend the area a bit.
        area.left_top.x = area.left_top.x - 32
        area.left_top.y = area.left_top.y - 32
        area.right_bottom.x = area.right_bottom.x + 32
        area.right_bottom.y = area.right_bottom.y + 32
        table.insert(storage.creative_mode.pending_areas_to_remove_enemies, {
            surface = surface,
            area = area
        })
    end
end
