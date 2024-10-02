-- This file contains variables or functions that are related to the Creator magic wand in this mod.
if not magic_wand_creator then
	magic_wand_creator = {}
end

-- Returns whether tile correction should be performed for the given player.
function magic_wand_creator.get_tile_correction(player)
	if storage.creative_mode.magic_wand_settings.creator[player.index] then
		if storage.creative_mode.magic_wand_settings.creator[player.index].tile_correction ~= nil then
			return storage.creative_mode.magic_wand_settings.creator[player.index].tile_correction
		end
	end
	return true
end

-- Sets whether tile correction should be performed for the given player.
function magic_wand_creator.set_tile_correction(player, tile_correction)
	if not storage.creative_mode.magic_wand_settings.creator[player.index] then
		storage.creative_mode.magic_wand_settings.creator[player.index] = {}
	end
	storage.creative_mode.magic_wand_settings.creator[player.index].tile_correction = tile_correction
end

----

-- Returns whether the don't-kill-players-by-tiles option is turned on for the given player.
function magic_wand_creator.get_dont_kill_players_by_tiles(player)
	if storage.creative_mode.magic_wand_settings.creator[player.index] then
		if storage.creative_mode.magic_wand_settings.creator[player.index].dont_kill_players_by_tiles ~= nil then
			return storage.creative_mode.magic_wand_settings.creator[player.index].dont_kill_players_by_tiles
		end
	end
	return true
end

-- Sets whether the don't-kill-players-by-tiles option is turned on for the given player.
function magic_wand_creator.set_dont_kill_players_by_tiles(player, dont_kill_players_by_tiles)
	if not storage.creative_mode.magic_wand_settings.creator[player.index] then
		storage.creative_mode.magic_wand_settings.creator[player.index] = {}
	end
	storage.creative_mode.magic_wand_settings.creator[player.index].dont_kill_players_by_tiles = dont_kill_players_by_tiles
end

----

-- Returns the tile prototype selected by the given player.
-- If no tile is selected, nil will be returned.
function magic_wand_creator.get_selected_tile_prototype(player)
	if storage.creative_mode.magic_wand_settings.creator[player.index] then
		local tile_name = storage.creative_mode.magic_wand_settings.creator[player.index].tile_name
		if tile_name then
			return game.tile_prototypes[tile_name]
		end
	end
	-- Default to concrete. It can be nil if not existed.
	return game.tile_prototypes["concrete"]
end

-- Sets the given tile prototype as the selected tile by the given player. It can be nil.
function magic_wand_creator.set_selected_tile_prototype(player, tile_prototype)
	if not storage.creative_mode.magic_wand_settings.creator[player.index] then
		storage.creative_mode.magic_wand_settings.creator[player.index] = {}
	end
	if tile_prototype then
		storage.creative_mode.magic_wand_settings.creator[player.index].tile_name = tile_prototype.name
	else
		storage.creative_mode.magic_wand_settings.creator[player.index].tile_name = ""
	end
	storage.creative_mode.magic_wand_settings.creator[player.index].resource_name = ""
end

----

-- Returns the resource entity prototype selected by the given player.
-- If no resource is selected, nil will be returned.
function magic_wand_creator.get_selected_resource_prototype(player)
	if storage.creative_mode.magic_wand_settings.creator[player.index] then
		local resource_name = storage.creative_mode.magic_wand_settings.creator[player.index].resource_name
		if resource_name then
			return game.entity_prototypes[resource_name]
		end
	end
	return nil
end

-- Sets the given resource entity prototype as the selected resource by the given player. It can be nil.
function magic_wand_creator.set_selected_resource_prototype(player, resource_prototype)
	if not storage.creative_mode.magic_wand_settings.creator[player.index] then
		storage.creative_mode.magic_wand_settings.creator[player.index] = {}
	end
	storage.creative_mode.magic_wand_settings.creator[player.index].tile_name = ""
	if resource_prototype then
		storage.creative_mode.magic_wand_settings.creator[player.index].resource_name = resource_prototype.name
	else
		storage.creative_mode.magic_wand_settings.creator[player.index].resource_name = ""
	end
end

----

-- Returns the resource amount when creating resources for the given player.
function magic_wand_creator.get_resource_amount(player)
	if storage.creative_mode.magic_wand_settings.creator[player.index] then
		local resource_amount = storage.creative_mode.magic_wand_settings.creator[player.index].resource_amount
		if resource_amount then
			return resource_amount
		end
	end
	return 2000
end

-- Sets the resource amount when creating resources for the given player.
function magic_wand_creator.set_resource_amount(player, resource_amount)
	if not storage.creative_mode.magic_wand_settings.creator[player.index] then
		storage.creative_mode.magic_wand_settings.creator[player.index] = {}
	end
	storage.creative_mode.magic_wand_settings.creator[player.index].resource_amount = resource_amount
end

----

-- Returns the index of used pattern for the given player.
function magic_wand_creator.get_use_pattern(player)
	if storage.creative_mode.magic_wand_settings.creator[player.index] then
		if storage.creative_mode.magic_wand_settings.creator[player.index].used_pattern_index then
			return storage.creative_mode.magic_wand_settings.creator[player.index].used_pattern_index
		end
	end
	return 1
end

-- Sets the index of the used pattern for the given player.
function magic_wand_creator.set_use_pattern(player, used_pattern_index)
	if not storage.creative_mode.magic_wand_settings.creator[player.index] then
		storage.creative_mode.magic_wand_settings.creator[player.index] = {}
	end
	storage.creative_mode.magic_wand_settings.creator[player.index].used_pattern_index = used_pattern_index
end

----

-- Returns the second tile prototype selected by the given player.
-- If no tile is selected, nil will be returned.
function magic_wand_creator.get_selected_tile_prototype_2(player)
	if storage.creative_mode.magic_wand_settings.creator[player.index] then
		local tile_name_2 = storage.creative_mode.magic_wand_settings.creator[player.index].tile_name_2
		if tile_name_2 then
			return game.tile_prototypes[tile_name_2]
		end
	end
	-- Default to lab-dark-1. It can be nil if not existed.
	return game.tile_prototypes["lab-dark-1"]
end

-- Sets the given tile prototype as the second selected tile by the given player. It can be nil.
function magic_wand_creator.set_selected_tile_prototype_2(player, tile_prototype_2)
	if not storage.creative_mode.magic_wand_settings.creator[player.index] then
		storage.creative_mode.magic_wand_settings.creator[player.index] = {}
	end
	if tile_prototype_2 then
		storage.creative_mode.magic_wand_settings.creator[player.index].tile_name_2 = tile_prototype_2.name
	else
		storage.creative_mode.magic_wand_settings.creator[player.index].tile_name_2 = ""
	end
	storage.creative_mode.magic_wand_settings.creator[player.index].resource_name_2 = ""
end

----

-- Returns the second resource entity prototype selected by the given player.
-- If no resource is selected, nil will be returned.
function magic_wand_creator.get_selected_resource_prototype_2(player)
	if storage.creative_mode.magic_wand_settings.creator[player.index] then
		local resource_name_2 = storage.creative_mode.magic_wand_settings.creator[player.index].resource_name_2
		if resource_name_2 then
			return game.entity_prototypes[resource_name_2]
		end
	end
	return nil
end

-- Sets the given resource entity prototype as the second selected resource by the given player. It can be nil.
function magic_wand_creator.set_selected_resource_prototype_2(player, resource_prototype_2)
	if not storage.creative_mode.magic_wand_settings.creator[player.index] then
		storage.creative_mode.magic_wand_settings.creator[player.index] = {}
	end
	storage.creative_mode.magic_wand_settings.creator[player.index].tile_name_2 = ""
	if resource_prototype_2 then
		storage.creative_mode.magic_wand_settings.creator[player.index].resource_name_2 = resource_prototype_2.name
	else
		storage.creative_mode.magic_wand_settings.creator[player.index].resource_name_2 = ""
	end
end

----

-- Returns the resource amount when creating resources based on the second selected resource for the given player.
function magic_wand_creator.get_resource_amount_2(player)
	if storage.creative_mode.magic_wand_settings.creator[player.index] then
		local resource_amount_2 = storage.creative_mode.magic_wand_settings.creator[player.index].resource_amount_2
		if resource_amount_2 then
			return resource_amount_2
		end
	end
	return 2000
end

-- Sets the resource amount when creating resources based on the second selected resource for the given player.
function magic_wand_creator.set_resource_amount_2(player, resource_amount_2)
	if not storage.creative_mode.magic_wand_settings.creator[player.index] then
		storage.creative_mode.magic_wand_settings.creator[player.index] = {}
	end
	storage.creative_mode.magic_wand_settings.creator[player.index].resource_amount_2 = resource_amount_2
end

----

-- Returns whether the also-remove-decoratives option is turned on for the given player.
function magic_wand_creator.get_also_remove_decoratives(player)
	if storage.creative_mode.magic_wand_settings.creator[player.index] then
		if storage.creative_mode.magic_wand_settings.creator[player.index].also_remove_decoratives ~= nil then
			return storage.creative_mode.magic_wand_settings.creator[player.index].also_remove_decoratives
		end
	end
	return true
end

-- Sets whether the also-remove-decoratives option is turned on for the given player.
function magic_wand_creator.set_also_remove_decoratives(player, also_remove_decoratives)
	if not storage.creative_mode.magic_wand_settings.creator[player.index] then
		storage.creative_mode.magic_wand_settings.creator[player.index] = {}
	end
	storage.creative_mode.magic_wand_settings.creator[player.index].also_remove_decoratives = also_remove_decoratives
end

----

-- Returns whether the don't-remove-player-characters option is turned on for the given player.
function magic_wand_creator.get_dont_remove_player_characters(player)
	if storage.creative_mode.magic_wand_settings.creator[player.index] then
		if storage.creative_mode.magic_wand_settings.creator[player.index].dont_remove_player_characters ~= nil then
			return storage.creative_mode.magic_wand_settings.creator[player.index].dont_remove_player_characters
		end
	end
	return true
end

-- Sets whether the don't-remove-player-characters option is turned on for the given player.
function magic_wand_creator.set_dont_remove_player_characters(player, dont_remove_player_characters)
	if not storage.creative_mode.magic_wand_settings.creator[player.index] then
		storage.creative_mode.magic_wand_settings.creator[player.index] = {}
	end
	storage.creative_mode.magic_wand_settings.creator[player.index].dont_remove_player_characters =
		dont_remove_player_characters
end

----

-- Returns whether tile removal should not be performed when there is any entity being selected for the given player.
function magic_wand_creator.get_dont_remove_tiles_if_any_entity_is_selected(player)
	if storage.creative_mode.magic_wand_settings.creator[player.index] then
		if storage.creative_mode.magic_wand_settings.creator[player.index].dont_remove_tiles_if_any_entity_is_selected ~= nil then
			return storage.creative_mode.magic_wand_settings.creator[player.index].dont_remove_tiles_if_any_entity_is_selected
		end
	end
	return true
end

-- Sets whether tile removal should not be performed when there is any entity being selected for the given player.
function magic_wand_creator.set_dont_remove_tiles_if_any_entity_is_selected(
	player,
	dont_remove_tiles_if_any_entity_is_selected)
	if not storage.creative_mode.magic_wand_settings.creator[player.index] then
		storage.creative_mode.magic_wand_settings.creator[player.index] = {}
	end
	storage.creative_mode.magic_wand_settings.creator[player.index].dont_remove_tiles_if_any_entity_is_selected =
		dont_remove_tiles_if_any_entity_is_selected
end

----

-- Returns whether the don't-kill-players-by-removing-tiles option is turned on for the given player.
function magic_wand_creator.get_dont_kill_players_by_removing_tiles(player)
	if storage.creative_mode.magic_wand_settings.creator[player.index] then
		if storage.creative_mode.magic_wand_settings.creator[player.index].dont_kill_players_by_removing_tiles ~= nil then
			return storage.creative_mode.magic_wand_settings.creator[player.index].dont_kill_players_by_removing_tiles
		end
	end
	return true
end

-- Sets whether the don't-kill-players-by-removing-tiles option is turned on for the given player.
function magic_wand_creator.set_dont_kill_players_by_removing_tiles(player, dont_kill_players_by_removing_tiles)
	if not storage.creative_mode.magic_wand_settings.creator[player.index] then
		storage.creative_mode.magic_wand_settings.creator[player.index] = {}
	end
	storage.creative_mode.magic_wand_settings.creator[player.index].dont_kill_players_by_removing_tiles =
		dont_kill_players_by_removing_tiles
end

----

-- Returns whether the alt-mode of the magic wand can apply on the given force for the given player.
function magic_wand_creator.get_alt_mode_apply_on_force(player, force)
	if storage.creative_mode.magic_wand_settings.creator[player.index] then
		if storage.creative_mode.magic_wand_settings.creator[player.index].alt_mode_forces ~= nil then
			return storage.creative_mode.magic_wand_settings.creator[player.index].alt_mode_forces[force.name] ~= false
		end
	end
	return true
end

-- Sets whether the alt-mode of the magic wand can apply on the given force for the given player.
function magic_wand_creator.set_alt_mode_apply_on_force(player, force, apply)
	if not storage.creative_mode.magic_wand_settings.creator[player.index] then
		storage.creative_mode.magic_wand_settings.creator[player.index] = {}
	end
	if not storage.creative_mode.magic_wand_settings.creator[player.index].alt_mode_forces then
		storage.creative_mode.magic_wand_settings.creator[player.index].alt_mode_forces = {}
	end
	storage.creative_mode.magic_wand_settings.creator[player.index].alt_mode_forces[force.name] = apply
end

------------------------------------------------------

-- Creates smoke effect at the given position in the given surface.
local function create_smoke_at(surface, position)
	surface.create_trivial_smoke {
		name = creative_mode_defines.names.entities.magic_wand_smoke_creator,
		position = position
	}
end

-- Creates smoke effect at the entity's position.
local function create_smoke_effect_at_entity_position(entity)
	create_smoke_at(entity.surface, entity.position)
end

------------------------------------------------------

-- Returns the dictionary of all safe positions for all connected players with characters on the given surface.
local function get_safe_positions_for_all_players_on_surface(surface)
	local player_positions = {}
	for _, player in pairs(game.connected_players) do
		local character = player.character
		if character then
			if character.surface == surface then
				local position = character.position
				local rounded_x = util.round(position.x)
				local rounded_y = util.round(position.y)

				-- Give him a 3x3 safe area.
				local x = rounded_x - 1
				player_positions[x] = player_positions[x] or {}
				player_positions[x][rounded_y - 1] = true
				player_positions[x][rounded_y] = true
				player_positions[x][rounded_y + 1] = true

				x = rounded_x
				player_positions[x] = player_positions[x] or {}
				player_positions[x][rounded_y - 1] = true
				player_positions[x][rounded_y] = true
				player_positions[x][rounded_y + 1] = true

				x = rounded_x + 1
				player_positions[x] = player_positions[x] or {}
				player_positions[x][rounded_y - 1] = true
				player_positions[x][rounded_y] = true
				player_positions[x][rounded_y + 1] = true
			end
		end
	end
	return player_positions
end

-- Creates tiles or resources in checker pattern on the given tiles for the given player.
local function create_tiles_or_resources_in_pattern(
	player,
	tiles,
	tile_or_resource_prototype_data_list,
	pattern_function)
	local surface = player.surface

	local dont_kill_players_by_tiles = magic_wand_creator.get_dont_kill_players_by_tiles(player)
	local player_positions

	local tiles_to_be_created
	local tile_positions_to_be_created

	-- Iterate the selected tiles.
	for _, tile in pairs(tiles) do
		local position = tile.position
		local x = position.x
		local y = position.y
		-- Get the data to be used according to the tile position.
		local data_index = pattern_function(x, y)
		local data = tile_or_resource_prototype_data_list[data_index]
		local selected_tile = data.tile_prototype
		if selected_tile then
			-- Create tiles.
			-- Setup.
			local new_tile_name = selected_tile.name
			local can_tile_kill_player = selected_tile.collision_mask["player-layer"]
			if can_tile_kill_player and dont_kill_players_by_tiles then
				-- Don't kill players, but the selected tile is harmful.
				-- Make sure the positions of all players are not touched.
				player_positions = player_positions or get_safe_positions_for_all_players_on_surface(surface)
			end
			if tile.name ~= new_tile_name then
				if
					not can_tile_kill_player or not dont_kill_players_by_tiles or not player_positions[x] or not player_positions[x][y]
				 then
					-- Prepare to set tiles.
					tiles_to_be_created = tiles_to_be_created or {}
					tile_positions_to_be_created = tile_positions_to_be_created or {}
					-- Record the position and tile name, so we can set them later.
					table.insert(
						tiles_to_be_created,
						{
							name = new_tile_name,
							position = position
						}
					)
					table.insert(tile_positions_to_be_created, position)
					create_smoke_at(surface, position)
				end
			end
		else
			-- Create resources.
			-- Setup.
			local selected_resource = data.resource_prototype
			local resource_amount = data.resource_amount
			if selected_resource then
				local new_resource_name = selected_resource.name
				-- Create entity if possible.
				if surface.can_place_entity {name = new_resource_name, position = position} then
						surface.create_entity {
						name = new_resource_name,
						position = position,
						amount = resource_amount,
						create_build_effect_smoke = true,
						raise_built = true
					}
				end
			end
		end
	end

	-- Actually create tiles.
	if tiles_to_be_created then
		surface.set_tiles(tiles_to_be_created, magic_wand_creator.get_tile_correction(player), true, true, true)
	end
end

-- Handler of the on_player_selected_area event.
-- Returns whether the event is consumed and hence no need to further pass it to other handlers.
function magic_wand_creator.on_player_selected_area(player, area, item_name, entities, tiles)
	if item_name == creative_mode_defines.names.items.magic_wand_creator then
		if rights.can_player_use_creator_magic_wand(player) then
			-- Get the first selected tile or resource.
			local tile_or_resource_prototype_data_list = {
				{
					tile_prototype = magic_wand_creator.get_selected_tile_prototype(player),
					resource_prototype = magic_wand_creator.get_selected_resource_prototype(player),
					resource_amount = magic_wand_creator.get_resource_amount(player)
				}
			}
			-- Use pattern?
			local pattern_index = magic_wand_creator.get_use_pattern(player)
			-- Create second tile or resource?
			if pattern_index > 1 then
				-- Yes. Get the second selected tile or resource.
				table.insert(
					tile_or_resource_prototype_data_list,
					{
						tile_prototype = magic_wand_creator.get_selected_tile_prototype_2(player),
						resource_prototype = magic_wand_creator.get_selected_resource_prototype_2(player),
						resource_amount = magic_wand_creator.get_resource_amount_2(player)
					}
				)
			end
			-- Pattern function.
			local pattern_function
			local data_count = #tile_or_resource_prototype_data_list
			if pattern_index == 2 then
				-- Horizontal stripe.
				pattern_function = function(x, y)
					return y % data_count + 1
				end
			elseif pattern_index == 3 then
				-- Vertical stripe.
				pattern_function = function(x, y)
					return x % data_count + 1
				end
			elseif pattern_index == 4 then
				-- Checker.
				pattern_function = function(x, y)
					return (x + y) % data_count + 1
				end
			elseif pattern_index == 5 then
				-- Random.
				pattern_function = function(x, y)
					return util.random(1, data_count)
				end
			else
				-- Default: no pattern.
				pattern_function = function(x, y)
					return 1
				end
			end

			-- Create tiles or resources!
			local data_count = #tile_or_resource_prototype_data_list
			create_tiles_or_resources_in_pattern(player, tiles, tile_or_resource_prototype_data_list, pattern_function)
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
function magic_wand_creator.on_player_alt_selected_area(player, area, item_name, entities, tiles)
	if item_name == creative_mode_defines.names.items.magic_wand_creator then
		if rights.can_player_use_creator_magic_wand(player) then
			local surface = player.surface

			-- Removes decoratives.
			if magic_wand_creator.get_also_remove_decoratives(player) then
				surface.destroy_decoratives(area)
			end

			-- Removes the selected entities.
			local has_destroyed_entity = false
			local dont_remove_player_characters = magic_wand_creator.get_dont_remove_player_characters(player)
			for _, entity in ipairs(entities) do
				if entity.valid then -- It is possible that the entity becomes invalid.
					-- Don't select the smoke.
					if entity.name ~= creative_mode_defines.names.entities.magic_wand_smoke_creator then
						local force = entity.force
						if force then
							-- Force allowed?
							if magic_wand_creator.get_alt_mode_apply_on_force(player, force) then
								-- Player character.
								local can_destroy = true
								if dont_remove_player_characters then
									if util.get_character_owning_player(entity) then
										-- The character is owned by a player.
										can_destroy = false
									end
								end
								if can_destroy then
									create_smoke_effect_at_entity_position(entity)
									util.destroy_entity_and_raise_event(entity, player, false)
									has_destroyed_entity = true
								end
							end
						end
					end
				end
			end

			-- Also remove tiles.
			-- But check if we can do so first.
			if has_destroyed_entity and magic_wand_creator.get_dont_remove_tiles_if_any_entity_is_selected(player) then
				-- No, don't remove tiles.
				return
			end
			local new_tiles = nil
			local old_tiles = nil
			local player_positions = nil
			local dont_kill_players_by_removing_tiles = magic_wand_creator.get_dont_kill_players_by_removing_tiles(player)
			for _, tile in ipairs(tiles) do
				local position = tile.position
				local x = position.x
				local y = position.y
				-- Remove the tile if it is hidding a tile behind it.
				local hidden_tile_name = surface.get_hidden_tile(position)
				local hidden_tile = game.tile_prototypes[hidden_tile_name]
				if hidden_tile then
					local remove_this_tile = true
					if hidden_tile.collision_mask["player-layer"] and dont_kill_players_by_removing_tiles then
						-- The hidden tile is unsafe for players.
						-- Make sure the positions of all players are not touched.
						player_positions = player_positions or get_safe_positions_for_all_players_on_surface(surface)
						if player_positions[x] and player_positions[x][y] then
							remove_this_tile = false
						end
					end
					if remove_this_tile then
						if not new_tiles then
							new_tiles = {}
						end
						if not old_tiles then
							old_tiles = {}
						end
						table.insert(
							new_tiles,
							{
								name = hidden_tile_name,
								position = position
							}
						)
						create_smoke_at(surface, position)
					end
				end
			end
			if new_tiles then
				-- Set tiles and raise event.
				surface.set_tiles(new_tiles, true, true, true, true)
			end
		else
			-- No right to use.
			player.print {"message.creative-mode_no-right-to-use-magic-wand"}
		end

		return true
	end

	return false
end
