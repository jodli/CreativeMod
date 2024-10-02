-- This file contains variables or functions that are related to the Healer magic wand in this mod.
if not magic_wand_healer then
	magic_wand_healer = {}
end

-- Gets whether the selected ghost entities can be revived for the given player.
function magic_wand_healer.get_revive_ghosts(player)
	if storage.creative_mode.magic_wand_settings.healer[player.index] then
		if storage.creative_mode.magic_wand_settings.healer[player.index].revive_ghosts ~= nil then
			return storage.creative_mode.magic_wand_settings.healer[player.index].revive_ghosts
		end
	end
	return true
end

-- Sets whether the selected ghost entities can be revived for the given player.
function magic_wand_healer.set_revive_ghosts(player, revive_ghosts)
	if not storage.creative_mode.magic_wand_settings.healer[player.index] then
		storage.creative_mode.magic_wand_settings.healer[player.index] = {}
	end
	storage.creative_mode.magic_wand_settings.healer[player.index].revive_ghosts = revive_ghosts
end

----

-- Gets whether the selected entities belonging the given force can be healed for the given player.
function magic_wand_healer.get_heal_entities_on_force(player, force)
	if storage.creative_mode.magic_wand_settings.healer[player.index] then
		if storage.creative_mode.magic_wand_settings.healer[player.index].heal_forces ~= nil then
			return storage.creative_mode.magic_wand_settings.healer[player.index].heal_forces[force.name] ~= false
		end
	end
	return true
end

-- Sets whether the selected entities belonging the given force can be healed for the given player.
function magic_wand_healer.set_heal_entities_on_force(player, force, heal)
	if not storage.creative_mode.magic_wand_settings.healer[player.index] then
		storage.creative_mode.magic_wand_settings.healer[player.index] = {}
	end
	if not storage.creative_mode.magic_wand_settings.healer[player.index].heal_forces then
		storage.creative_mode.magic_wand_settings.healer[player.index].heal_forces = {}
	end
	storage.creative_mode.magic_wand_settings.healer[player.index].heal_forces[force.name] = heal
end

----

-- Possible alt-mode actions for the Healer magic wand.
magic_wand_healer.alt_mode_action = {
	set_hp_to_one = 1,
	kill = 2
}

-- Returns the alt-mode action of the magic wand for the given player.
function magic_wand_healer.get_alt_mode_action(player)
	if storage.creative_mode.magic_wand_settings.healer[player.index] then
		if storage.creative_mode.magic_wand_settings.healer[player.index].alt_mode_action ~= nil then
			return storage.creative_mode.magic_wand_settings.healer[player.index].alt_mode_action
		end
	end
	return magic_wand_healer.alt_mode_action.set_hp_to_one
end

-- Sets the alt-mode action of the magic wand for the given player.
function magic_wand_healer.set_alt_mode_action(player, alt_mode_action)
	if not storage.creative_mode.magic_wand_settings.healer[player.index] then
		storage.creative_mode.magic_wand_settings.healer[player.index] = {}
	end
	storage.creative_mode.magic_wand_settings.healer[player.index].alt_mode_action = alt_mode_action
end

----

-- Returns whether the alt-mode action of the magic wand can affect player characters for the given player.
function magic_wand_healer.get_alt_mode_dont_affect_player_characters(player)
	if storage.creative_mode.magic_wand_settings.healer[player.index] then
		if storage.creative_mode.magic_wand_settings.healer[player.index].alt_mode_dont_affect_player_characters ~= nil then
			return storage.creative_mode.magic_wand_settings.healer[player.index].alt_mode_dont_affect_player_characters
		end
	end
	return true
end

-- Sets whether the alt-mode action of the magic wand can affect player characters for the given player.
function magic_wand_healer.set_alt_mode_dont_affect_player_characters(player, alt_mode_dont_affect_player_characters)
	if not storage.creative_mode.magic_wand_settings.healer[player.index] then
		storage.creative_mode.magic_wand_settings.healer[player.index] = {}
	end
	storage.creative_mode.magic_wand_settings.healer[player.index].alt_mode_dont_affect_player_characters =
	alt_mode_dont_affect_player_characters
end

----

-- Returns whether the alt-mode action of the magic wand can affect indestructible entities for the given player.
function magic_wand_healer.get_alt_mode_dont_affect_indestructible_entities(player)
	if storage.creative_mode.magic_wand_settings.healer[player.index] then
		if storage.creative_mode.magic_wand_settings.healer[player.index].alt_mode_dont_affect_indestructible_entities ~= nil then
			return storage.creative_mode.magic_wand_settings.healer[player.index].alt_mode_dont_affect_indestructible_entities
		end
	end
	return true
end

-- Sets whether the alt-mode action of the magic wand can affect indestructible entities for the given player.
function magic_wand_healer.set_alt_mode_dont_affect_indestructible_entities(
    player,
    alt_mode_dont_affect_indestructible_entities)
	if not storage.creative_mode.magic_wand_settings.healer[player.index] then
		storage.creative_mode.magic_wand_settings.healer[player.index] = {}
	end
	storage.creative_mode.magic_wand_settings.healer[player.index].alt_mode_dont_affect_indestructible_entities =
	alt_mode_dont_affect_indestructible_entities
end

----

-- Returns whether the alt-mode of the magic wand can apply on the given force for the given player.
function magic_wand_healer.get_alt_mode_apply_on_force(player, force)
	if storage.creative_mode.magic_wand_settings.healer[player.index] then
		if storage.creative_mode.magic_wand_settings.healer[player.index].alt_mode_forces ~= nil then
			return storage.creative_mode.magic_wand_settings.healer[player.index].alt_mode_forces[force.name] ~= false
		end
	end
	return true
end

-- Sets whether the alt-mode of the magic wand can apply on the given force for the given player.
function magic_wand_healer.set_alt_mode_apply_on_force(player, force, apply)
	if not storage.creative_mode.magic_wand_settings.healer[player.index] then
		storage.creative_mode.magic_wand_settings.healer[player.index] = {}
	end
	if not storage.creative_mode.magic_wand_settings.healer[player.index].alt_mode_forces then
		storage.creative_mode.magic_wand_settings.healer[player.index].alt_mode_forces = {}
	end
	storage.creative_mode.magic_wand_settings.healer[player.index].alt_mode_forces[force.name] = apply
end

------------------------------------------------------

-- Creates smoke effect at the given position in the given surface.
local function create_smoke_at(surface, position)
	surface.create_trivial_smoke { name = creative_mode_defines.names.entities.magic_wand_smoke_healer, position = position }
end

-- Creates smoke effect at the entity's position.
local function create_smoke_effect_at_entity_position(entity)
	create_smoke_at(entity.surface, entity.position)
end

------------------------------------------------------

-- Handler of the on_player_selected_area event.
-- Returns whether the event is consumed and hence no need to further pass it to other handlers.
function magic_wand_healer.on_player_selected_area(player, area, item_name, entities, tiles)
	if item_name == creative_mode_defines.names.items.magic_wand_healer then
		if rights.can_player_use_healer_magic_wand(player) then
			-- Heal the selected entities and revive the ghost entities.
			local revive_ghosts = magic_wand_healer.get_revive_ghosts(player)
			-- Prepare to fire events.
			local revived_tile_positions
			for _, entity in ipairs(entities) do
				if entity.valid then -- It is possible that the entity becomes invalid.
					local health = entity.health
					if health ~= nil then
						-- The entity has health. It can be healed.
						if entity.force and magic_wand_healer.get_heal_entities_on_force(player, entity.force) then
							local max_health = entity.prototype.max_health -- For all entities in general
							if entity.type == "character" then -- But players have individual and force bonuses to max health
								local p = entity.player
								max_health = max_health + p.force.character_health_bonus + p.character_health_bonus
							end
							if health < max_health then
								-- Heal it.
								entity.health = max_health
								create_smoke_effect_at_entity_position(entity)
							end
						end
					else
						-- Maybe it is a ghost?
						if revive_ghosts then
							if entity.name == "entity-ghost" then
								local revived_entity = util.revive_entity_ghost_and_raise_event(entity, player, false)
								if revived_entity then
									create_smoke_effect_at_entity_position(revived_entity)
								end
							elseif entity.name == "tile-ghost" then
								local surface = entity.surface
								local position = entity.position
								-- We don't use the function in util because we want to raise the event once for all revived tiles.
								local collided_enitties = entity.revive()
								if collided_enitties then
									-- Revived. Prepare the raise the event.
									if not revived_tile_positions then
										revived_tile_positions = {}
									end
									table.insert(revived_tile_positions, position)
									create_smoke_at(surface, position)
								end
							end
						end
					end
				end
			end
		else
			-- No right to use.
			player.print { "message.creative-mode_no-right-to-use-magic-wand" }
		end

		return true
	end

	return false
end

-- Handler of the on_player_alt_selected_area event.
-- Returns whether the event is consumed and hence no need to further pass it to other handlers.
function magic_wand_healer.on_player_alt_selected_area(player, area, item_name, entities, tiles)
	if item_name == creative_mode_defines.names.items.magic_wand_healer then
		if rights.can_player_use_healer_magic_wand(player) then
			-- Lower the health of the selected entities or simply kill them.
			local action = magic_wand_healer.get_alt_mode_action(player)
			local dont_affect_player_characters = magic_wand_healer.get_alt_mode_dont_affect_player_characters(player)
			local dont_affect_indestructible_entities =
			magic_wand_healer.get_alt_mode_dont_affect_indestructible_entities(player)
			for _, entity in ipairs(entities) do
				if entity.valid then -- It is possible that the entity becomes invalid.
					-- Make sure the entity can be killed.
					if entity.health ~= nil then
						if entity.force and magic_wand_healer.get_alt_mode_apply_on_force(player, entity.force) then
							if not dont_affect_player_characters or not util.get_character_owning_player(entity) then
								if not dont_affect_indestructible_entities or entity.destructible then
									if action == magic_wand_healer.alt_mode_action.set_hp_to_one then
										-- Lower the health.
										if entity.health > 1 then
											create_smoke_effect_at_entity_position(entity)
											entity.health = 1
										end
									elseif action == magic_wand_healer.alt_mode_action.kill then
										-- Kill.
										create_smoke_effect_at_entity_position(entity)
										util.kill_entity_and_raise_event(entity, player)
									end
								end
							end
						end
					end
				end
			end
		else
			-- No right to use.
			player.print { "message.creative-mode_no-right-to-use-magic-wand" }
		end

		return true
	end

	return false
end
