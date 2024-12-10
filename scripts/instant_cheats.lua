-- Returns whether the given player is a valid candidate for instant request.
function is_player_valid_for_instant_request(player)
    return player
        and storage.creative_mode.personal_cheats.instant_request[player.index]
        and player.valid
        and player.connected
        and player.character
end

-- Returns whether the given player is a valid candidate for instant trash.
function is_player_valid_for_instant_trash(player)
    return player
        and storage.creative_mode.personal_cheats.instant_trash[player.index]
        and player.valid
        and player.connected
        and player.character
end

local function refill_inventory(entity, filter)
    local requested_item = { name = filter.value.name, quality = filter.value.quality }
    local items_in_inventory = entity.get_item_count(requested_item)
    local item_count_diff = filter.min - items_in_inventory
    if item_count_diff > 0 then
        requested_item.count = item_count_diff
        if entity.can_insert(requested_item) then
            entity.insert(requested_item)
        end
    end
end

local function handle_instant_request(entity, filter)
    if filter and next(filter) then
        if filter.value.type == "item" then
            refill_inventory(entity, filter)
        end
    end
end

function handle_entity_logistic_slot_changed(data)
    if data.entity.type == "character" and is_player_valid_for_instant_request(data.entity.player) then
        if data.section and data.section.active then
            local filter = data.section.get_slot(data.slot_index)
            handle_instant_request(data.entity, filter)
        end
    end
end

function handle_player_main_inventory_changed(data)
    local player = game.get_player(data.player_index)
    if is_player_valid_for_instant_request(player) then
        local logistic = player.get_requester_point()
        if logistic and logistic.enabled then
            for _, section in ipairs(logistic.sections) do
                if section and section.active then
                    for _, filter in ipairs(section.filters) do
                        handle_instant_request(player, filter)
                    end
                end
            end
        end
    end
end

function handle_player_trash_inventory_changed(data)
    local player = game.get_player(data.player_index)
    if is_player_valid_for_instant_trash(player) then
        local inventory = player.get_inventory(defines.inventory.character_trash)
        if inventory then
            inventory.clear()
        end
    end
end
