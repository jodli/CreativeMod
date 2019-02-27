-- This file manages variables or functions that are related to the compatibility to other mods.
if not mod_compatibler then mod_compatibler = {} end

-------------------------------------------------
-- Instant Blueprint

-- Returns whether the instant blueprint mod has been installed.
function mod_compatibler.is_instant_blueprint_installed()
	return game.active_mods["instant-blueprints"]
end

-- Returns whether the instant blueprint mod has been installed and is activated for the given player.
function mod_compatibler.is_instant_blueprint_installed_and_activated_for_player(player)
	return mod_compatibler.is_instant_blueprint_installed() and player.cheat_mode
end

-- Returns whether the instant blueprint mod has been installed and is activated for the player of given index.
function mod_compatibler.is_instant_blueprint_installed_and_activated_for_player_index(player_index)
	return mod_compatibler.is_instant_blueprint_installed_and_activated_for_player(game.players[player_index])
end