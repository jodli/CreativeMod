-- This file contains variables and functions about player rights.
if not rights then
	rights = {}
end

-- All possible player right levels for enabling/disabling personal cheats.
rights.access_personal_cheats_level = {
	-- Only admins have the right to enable/disable personal cheats for all non-admin players and himself.
	admin_only = 0,
	-- All players can enable/disable personal cheats freely for themselves.
	free = 10
}
-- Default personal cheats access right level.
rights.default_access_personal_cheats_level = rights.access_personal_cheats_level.free
-- Code, used for determining which right is changed by the admin.
rights.access_personal_cheats_code = "personal_cheats"

-- All possible player right levels for enabling/disabling team cheats.
rights.access_team_cheats_level = {
	-- Only admins have the right to enable/disable cheats for all teams.
	admin_only = 0,
	-- Each non-admin player can enable/disable cheats for the team he belongs to.
	own_team_only = 10,
	-- All players can enable/disable cheats for all teams.
	free = 20
}
-- Default team cheats access right level.
rights.default_access_team_cheats_level = rights.access_team_cheats_level.admin_only
-- Code, used for determining which right is changed by the admin.
rights.access_team_cheats_code = "team_cheats"

-- All possible player right levels for enabling/disable surface cheats.
rights.access_surface_cheats_level = {
	-- Only admins have the right to enable/disable cheats for all surfaces.
	admin_only = 0,
	-- Each non-admin player can enable/disable cheats for the surface he is on.
	current_surface_only = 10,
	-- All players can enable/disable cheats for all surfaces.
	free = 20
}
-- Default surface cheats access right level.
rights.default_access_surface_cheats_level = rights.access_surface_cheats_level.admin_only
-- Code, used for determining which right is changed by the admin.
rights.access_surface_cheats_code = "surface_cheats"

-- All possible player right levels for enabling/disabling global cheats.
rights.access_global_cheats_level = {
	-- Only admin have the right to enable/disable the global cheats.
	admin_only = 0,
	-- All players can enable/disable the global cheats.
	free = 10
}
-- Default global cheats access right level.
rights.default_access_global_cheats_level = rights.access_global_cheats_level.admin_only
-- Code, used for determining which right is changed by the admin.
rights.access_global_cheats_code = "global_cheats"

-- Returns whether the given player can access the cheats for other non-admin players.
function rights.can_player_access_other_non_admin_players_cheats(player)
	return player.admin
end

-- Returns whether the given player can access the personal cheats menu.
function rights.can_player_access_personal_cheats_menu(player)
	-- Admins can do anything they want.
	if player.admin then
		return true
	end

	if storage.creative_mode.player_rights.access_personal_cheats == rights.access_personal_cheats_level.free then
		return true
	end

	return false
end

-- Returns whether the given player can access the cheats for teams that he doesn't belong to.
function rights.can_player_access_other_teams_cheats(player)
	-- Admins can do anything they want.
	if player.admin then
		return true
	end

	if storage.creative_mode.player_rights.access_team_cheats == rights.access_team_cheats_level.free then
		return true
	end

	return false
end

-- Returns whether the given player can access the team cheats menu.
function rights.can_player_access_team_cheats_menu(player)
	-- Admins can do anything they want.
	if player.admin then
		return true
	end

	if storage.creative_mode.player_rights.access_team_cheats == rights.access_team_cheats_level.admin_only then
		return false
	end

	return true
end

-- Returns whether the given player can access the cheats for surfaces that he isn't on.
function rights.can_player_access_other_surfaces_cheats(player)
	-- Admins can do anything they want.
	if player.admin then
		return true
	end

	if storage.creative_mode.player_rights.access_surface_cheats == rights.access_surface_cheats_level.free then
		return true
	end

	return false
end

-- Returns whether the given player can access the surface cheats menu.
function rights.can_player_access_surface_cheats_menu(player)
	-- Admins can do anything they want.
	if player.admin then
		return true
	end

	if storage.creative_mode.player_rights.access_surface_cheats == rights.access_surface_cheats_level.admin_only then
		return false
	end

	return true
end

-- Returns whether the given player can access the global cheats menu.
function rights.can_player_access_global_cheats_menu(player)
	-- Admins can do anything they want.
	if player.admin then
		return true
	end

	if storage.creative_mode.player_rights.access_global_cheats == rights.access_global_cheats_level.admin_only then
		return false
	end

	return true
end

-- Returns whether the given player can access the cheats menu.
function rights.can_player_access_cheats_menu(player)
	return rights.can_player_access_personal_cheats_menu(player) or rights.can_player_access_team_cheats_menu(player) or
		rights.can_player_access_surface_cheats_menu(player) or
		rights.can_player_access_global_cheats_menu(player)
end

--------------------------------------------------------------------

-- All possible player right levels for changing build options.
rights.access_build_options_level = {
	-- Only admins have the right to change build options for all non-admin players and himself.
	admin_only = 0,
	-- Non-admin players can change build options, except which team the built entities will belong to.
	no_team_options = 10,
	-- All players can change build options freely.
	free = 20
}
-- Default build options access right level.
rights.default_access_build_options_level = rights.access_build_options_level.no_team_options
-- Code, used for determining which right is changed by the admin.
rights.access_build_options_code = "build_options"

-- Returns whether the given player can access the build options of other non-admin players.
function rights.can_player_access_other_non_admin_players_build_options(player)
	return player.admin
end

-- Returns whether the given player can access the build team options.
function rights.can_player_access_build_team_options(player)
	-- Admins can do anything they want.
	if player.admin then
		return true
	end

	if storage.creative_mode.player_rights.access_build_options == rights.access_build_options_level.free then
		return true
	end

	return false
end

-- Returns whether the given player can access the build options menu.
function rights.can_player_access_build_options_menu(player)
	-- Admins can do anything they want.
	if player.admin then
		return true
	end

	if
		storage.creative_mode.player_rights.access_build_options == rights.access_build_options_level.no_team_options or
			storage.creative_mode.player_rights.access_build_options == rights.access_build_options_level.free
	 then
		return true
	end

	return false
end

--------------------------------------------------------------------

-- Default right for accessing each magic wand.
rights.default_use_creator_magic_wand = true
rights.default_use_healer_magic_wand = true
rights.default_use_modifier_magic_wand = true

-- Code, used for determining which right is changed by the admin.
rights.use_creator_magic_wand_code = "creator_magic_wand"
rights.use_healer_magic_wand_code = "healer_magic_wand"
rights.use_modifier_magic_wand_code = "modifier_magic_wand"

-- Returns whether the given player can use the creator magic wand.
function rights.can_player_use_creator_magic_wand(player)
	-- Admins can do anything they want.
	if player.admin then
		return true
	end

	return storage.creative_mode.player_rights.use_creator_magic_wand
end

-- Returns whether the given player can use the healer magic wand.
function rights.can_player_use_healer_magic_wand(player)
	-- Admins can do anything they want.
	if player.admin then
		return true
	end

	return storage.creative_mode.player_rights.use_healer_magic_wand
end

-- Returns whether the given player can use the modifier magic wand.
function rights.can_player_use_modifier_magic_wand(player)
	-- Admins can do anything they want.
	if player.admin then
		return true
	end

	return storage.creative_mode.player_rights.use_modifier_magic_wand
end

-- Returns whether the given player can access the magic wand menu.
function rights.can_player_access_magic_wand_menu(player)
	return rights.can_player_use_creator_magic_wand(player) or rights.can_player_use_healer_magic_wand(player) or
		rights.can_player_use_modifier_magic_wand(player)
end

--------------------------------------------------------------------

-- Default right for accessing the modding menu.
rights.default_access_modding_menu = false
-- Code, used for determining which right is changed by the admin.
rights.access_modding_menu_code = "modding_menu"

-- Returns whether the given player can access the modding menu.
function rights.can_player_access_modding_menu(player)
	-- Admins can do anything they want.
	if player.admin then
		return true
	end

	return storage.creative_mode.player_rights.access_modding_menu
end

--------------------------------------------------------------------

-- Returns whether the given player can access the Creative Mode menu.
function rights.can_player_access_creative_mode_menu(player)
	if player.admin then
		return true
	end

	return rights.can_player_access_cheats_menu(player) or rights.can_player_access_build_options_menu(player) or
		rights.can_player_access_magic_wand_menu(player) or
		rights.can_player_access_modding_menu(player)
end

--------------------------------------------------------------------

-- Sets all the rights to be admin-only.
function rights.set_overall_admin_only()
	-- Personal cheats.
	storage.creative_mode.player_rights.access_personal_cheats = rights.access_personal_cheats_level.admin_only
	-- Team cheats.
	storage.creative_mode.player_rights.access_team_cheats = rights.access_team_cheats_level.admin_only
	-- Surface cheats.
	storage.creative_mode.player_rights.access_surface_cheats = rights.access_surface_cheats_level.admin_only
	-- Global cheats.
	storage.creative_mode.player_rights.access_global_cheats = rights.access_global_cheats_level.admin_only
	-- Build options.
	storage.creative_mode.player_rights.access_build_options = rights.access_build_options_level.admin_only
	-- Magic wand - creator.
	storage.creative_mode.player_rights.use_creator_magic_wand = false
	-- Magic wand - healer.
	storage.creative_mode.player_rights.use_healer_magic_wand = false
	-- Magic wand - modifier.
	storage.creative_mode.player_rights.use_modifier_magic_wand = false
	-- Modding menu.
	storage.creative_mode.player_rights.access_modding_menu = false
end

-- Resets all the rights to be default.
function rights.set_overall_default()
	-- Personal cheats.
	storage.creative_mode.player_rights.access_personal_cheats = rights.default_access_personal_cheats_level
	-- Team cheats.
	storage.creative_mode.player_rights.access_team_cheats = rights.default_access_team_cheats_level
	-- Surface cheats.
	storage.creative_mode.player_rights.access_surface_cheats = rights.default_access_surface_cheats_level
	-- Global cheats.
	storage.creative_mode.player_rights.access_global_cheats = rights.default_access_global_cheats_level
	-- Build options.
	storage.creative_mode.player_rights.access_build_options = rights.default_access_build_options_level
	-- Magic wand - creator.
	storage.creative_mode.player_rights.use_creator_magic_wand = rights.default_use_creator_magic_wand
	-- Magic wand - healer.
	storage.creative_mode.player_rights.use_healer_magic_wand = rights.default_use_healer_magic_wand
	-- Magic wand - modifier.
	storage.creative_mode.player_rights.use_modifier_magic_wand = rights.default_use_modifier_magic_wand
	-- Modding menu.
	storage.creative_mode.player_rights.access_modding_menu = rights.default_access_modding_menu
end
