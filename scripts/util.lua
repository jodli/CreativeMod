-- This file contains variables or functions that are not specific to any mod and can be used by other mods.
if not util then
	util = {}
end

-- Cache the reference to math functions can speed up the process slightly.
-- When called 1216 times in each frame, this can boost the FPS from 57 to 58.
local math_floor = math.floor
local math_ceil = math.ceil
local math_max = math.max
local math_min = math.min
local math_fmod = math.fmod

-- The distance between items on transport belt.
-- Last update: Factorio 0.13.3
transport_belt_item_distance = 0.28125

--- Tests if a string starts with a given substring
-- @param s the string to check for the start substring
-- @param start the substring to test for
-- @return true if the start substring was found in the string
-- Source: https://github.com/Afforess/Factorio-Stdlib/blob/master/stdlib/utils/string.lua
function util.string_starts_with(s, start)
	return string.find(s, start, 1, true) == 1
end

--- Tests if a string ends with a given substring.
-- @tparam string s the string to check for the end substring
-- @tparam string ends the substring to test for
-- @treturn boolean true if the end substring was found in the string
-- Source: https://github.com/Afforess/Factorio-Stdlib/blob/master/stdlib/utils/string.lua
function util.string_ends_with(s, ends)
	return #s >= #ends and s:find(ends, #s - #ends + 1, true) and true or false
end

-- Limits the given number in between the given minimum and maximum inclusively.
function util.clamp(number, minimum, maximum)
	return math_max(minimum, math_min(number, maximum))
end

-- Wraps the given number between the given minimum and maximum inclusively.
function util.repeat_index(number, minimum, maximum)
	local range_size = maximum - minimum + 1
	if number < minimum then
		number = number + (range_size * (math_floor((minimum - number) / range_size) + 1))
	end
	return minimum + math_fmod(number - minimum, range_size)
end

-- Rounds the given value to the nearest decimal. If no decimal is given, it will be rounded to the nearest integer.
function util.round(val, decimal)
	if decimal then
		return math_floor((val * 10 ^ decimal) + 0.5) / (10 ^ decimal)
	else
		return math_floor(val + 0.5)
	end
end

-- Returns a random number inside the given range using the Factorio random generator.
-- The range is optional. See API doc.
function util.random(minimum, maximum)
	if util.random_generator == nil then
		util.random_generator = game.create_random_generator()
	end
	return util.random_generator(minimum, maximum)
end

-- Returns whether the given sorted array contain the given specific key.
function util.array_contains_key(tab, key)
	for k, _ in pairs(tab) do
		if k == key then
			return true
		end
	end
	return false
end

-- Returns whether the given sorted array contain the given specific value.
function util.array_contains_val(tab, val)
	for _, v in pairs(tab) do
		if v == val then
			return true
		end
	end
	return false
end

-- Returns the key for the given value in the given table.
function util.find_key_for_value(tab, val)
	for k, v in pairs(tab) do
		if v == val then
			return k
		end
	end
	return nil
end

-- Returns the bounding box of the tile at the given position.
-- Note: turns out it is quite a FPS heavy task. Use only when needed.
-- @param	position	It should contain {x: float, y: float}
function util.get_tile_bb(position)
	return { { math_floor(position.x), math_floor(position.y) }, { math_ceil(position.x), math_ceil(position.y) } }
end

-- Returns whether the given entity has at least one inventory.
function util.has_inventory(entity)
	for _, inv in pairs(defines.inventory) do
		if entity.get_inventory(inv) ~= nil then
			return true
		end
	end
	return false
end

-- Copies the contents of the source inventory to the destination inventory.
function util.copy_inventory_contents(source_inventory, destination_inventory)
	for i = 1, math_min(#source_inventory, #destination_inventory), 1 do
		local source_slot = source_inventory[i]
		if source_slot.valid_for_read then
			destination_inventory[i].set_stack(source_slot)
		end
	end
end

-- Transfers the contents of the source inventory to the destination inventory.
function util.transfer_inventory_contents(source_inventory, destination_inventory)
	for i = 1, math_min(#source_inventory, #destination_inventory), 1 do
		local source_slot = source_inventory[i]
		if source_slot.valid_for_read then
			if destination_inventory[i].set_stack(source_slot) then
				source_inventory[i].clear()
			end
		end
	end
end

-- Returns whether the given entity has at least one fluidbox.
function util.has_fluidbox(entity)
	if not entity.fluidbox then
		return false
	end
	return #entity.fluidbox > 0
end

-- Returns whether the given inserter entity is enabled according to its circuit network state as well as its logistic network state.
function util.is_inserter_enabled(inserter)
	local control = inserter.get_control_behavior()
	-- Does it have control behaviour? (Not connected = no control?)
	if control and control.valid then
		return not control.disabled
	end

	-- No control? Because not connected to network?
	return true
end

-- Returns the player who is controlling the given character entity.
-- Nil will be returned if the given entity is not a character or no player is controlling it.
function util.get_character_owning_player(entity)
	if entity.type == "character" then
		if entity.force then
			for _, player in ipairs(entity.force.connected_players) do
				if player.character == entity then
					return player
				end
			end
		end
	end
	return nil
end

-- Raises event of the given ID containing the given data.
-- It makes sure the provided data contains the standard set of information about the event as it is a built-in event.
function util.raise_event(event_id, data)
	-- data.name = event_id
	-- data.tick = game.tick
	-- data.mod = creative_mode_defines.mod_id
	-- These are standard now (except officially its mod_name instead of mod)
	script.raise_event(event_id, data)
end

-- Returns an invalid robot parameter that can be used by events.
local function get_fake_robot_param(force)
	return {
		valid = false,
		type = "character",
		name = "character",
		force = force,
	}
end

-- Fulfills the given item requests for the given entity.
-- Items will be inserted into module inventory first, then to main inventory.
-- Returns the remaining item requests that cannot be inserted into the entity.
function util.fulfill_item_requests(target_entity, item_requests)
	-- Try to insert into the module inventory first.
	local module_inventory = target_entity.get_module_inventory()
	if module_inventory then
		for _, item_request in ipairs(item_requests) do
			if item_request.count > 0 then
				-- Reduce the number of items being inserted.
				item_requests[item_request.name] = item_request.count
					- module_inventory.insert({
						name = item_request.name,
						quality = item_request.quality,
						count = item_request.count,
					})
			end
		end
	end
	-- In case there are items other than modules left (special items?), here is the last chance to insert them to the entity.
	for _, item_request in ipairs(item_requests) do
		if item_request.count > 0 then
			item_requests[item_request.name] = item_request.count
				- target_entity.insert({
					name = item_request.name,
					quality = item_request.quality,
					count = item_request.count,
				})
		end
	end
	return item_requests
end

-- Revives the given entity ghost and raises the script_raised_revive event for it.
-- You shouldn't call this function if the given ghost is actually a tile ghost!
-- Returns the revived entity. It can be null if it is not revived.
function util.revive_entity_ghost_and_raise_event(entity_ghost, reviver_player, is_instant_blueprint)
	-- Get the items this ghost will request when it is revived, most likely modules.
	local item_requests = entity_ghost.item_requests

	-- Revive entity.
	local _, revived_entity, item_request_proxy = entity_ghost.revive({
		return_item_request_proxy = true,
		raise_revive = true,
	})
	if revived_entity and revived_entity.valid then
		-- Supply the requested items.
		if item_requests then
			util.fulfill_item_requests(revived_entity, item_requests)

			-- Remove item request because we have already supplied it.
			if item_request_proxy then
				item_request_proxy.destroy()
			end
		end
	end

	-- Some mods may destroy the revived entity immediately. The entity is useful only if it is still valid.
	if revived_entity and revived_entity.valid then
		return revived_entity
	end
	return nil
end

-- Revives the given tile ghost and raises the script_raised_built event for it.
-- Returns the position of the revived tile. It will be nil if it cannot be revived.
function util.revive_tile_ghost_and_raise_event(tile_ghost, reviver_player, is_instant_blueprint)
	-- A simplified version of the entity ghost revive function, as tile doesn't have item requests.
	-- No revived entity is returned because it is a tile.
	local position = tile_ghost.position
	local prototype = tile_ghost.ghost_prototype
	local old_tile_prototype = tile_ghost.surface.get_tile(position).prototype
	local collided_entities = tile_ghost.revive({
		raise_revive = true,
	})

	if collided_entities then
		local tiles = {}
		table.insert(tiles, {
			old_tile = old_tile_prototype,
			position = position,
		})
	end
	return collided_entities
end

-- Destroys the given entity and raises the script_raised_destroy event for it. Note that not all entites can be destroyed.
-- Returns whether the entity is destroyed.
-- @param destroyer_player	Optional.
function util.destroy_entity_and_raise_event(entity, destroyer_player, is_instant_deconstruction)
	-- No default event for LuaEntity::destroy(). Just a workaround.
	-- Here we assume the entity will 100% be removed.
	-- See this discussion: https://forums.factorio.com/viewtopic.php?f=34&t=34952
	if entity.can_be_destroyed() == true then
		if entity.destroy({
			raise_destroy = true,
		}) then
			return true
		end
	end
	return false
end

-- Kills the given entity and raises the script_raised_destroy event for it. Note that not all entities can be killed.
-- Returns whether the entity is killed.
function util.kill_entity_and_raise_event(entity, killer_player)
	if entity.health ~= nil then
		if killer_player then
			-- Record to kill count statistics.
			local kill_count_statistics =
				killer_player.force.get_kill_count_statistics(killer_player.physical_surface_index)
			local count = kill_count_statistics.get_input_count(entity.name)
			kill_count_statistics.set_input_count(entity.name, count + 1)
		end
		entity.destroy({
			raise_destroy = true,
		}) -- LuaEntity.destroy() will raise the script_raised_destroy event.
		return true
	end
	return false
end
