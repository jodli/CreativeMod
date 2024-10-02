-- This file manages remote-interface-related variables or functions that are specific for this mod.
if not remote_interface then
	remote_interface = {}
end

-- Command for showing all available commands for this mod.
local command_help = '/c remote.call("' .. creative_mode_defines.names.interface .. '", "help")'
local command_help_list = {}
-- Command for enabling Creative Mode.
remote_interface.command_enable = '/c remote.call("' .. creative_mode_defines.names.interface .. '", "enable")'
table.insert(command_help_list, remote_interface.command_enable)
-- Command for disabling Creative Mode.
local command_disable = '/c remote.call("' .. creative_mode_defines.names.interface .. '", "disable", [true|false])'
table.insert(command_help_list, command_disable)

-- Name of the function for registering remote functions so they can be called via the modding UI.
remote_interface.register_remote_function_name =
	'remote.call("' ..
	creative_mode_defines.names.interface ..
		'", "register_remote_function_to_modding_ui", "<interface-name>", "<function_name>", [{caption = "<Button caption>", tooltip="<Button tooltip>"}])'
-- Name of the function for deregistering remote functions so they can no longer be called via the modding UI.
remote_interface.deregister_remote_function_name =
	'remote.call("' ..
	creative_mode_defines.names.interface ..
		'", "deregister_remote_function_from_modding_ui", "<interface-name>", "<function_name>")'

-- The event IDs for the creative mode on-enabled event and on-disabled event respectively.
local on_enabled_event_id
local on_disabled_event_id

-- Returns the event ID for the creative mode on-enabled event.
-- If it has not been loaded, it will be loaded first.
function remote_interface.get_or_load_on_enabled_event_id()
	if on_enabled_event_id == nil then
		on_enabled_event_id = script.generate_event_name()
	end
	return on_enabled_event_id
end
-- Returns the event ID for the creative mode on-disabled event.
-- If it has not been loaded, it will be loaded first.
function remote_interface.get_or_load_on_disabled_event_id()
	if on_disabled_event_id == nil then
		on_disabled_event_id = script.generate_event_name()
	end
	return on_disabled_event_id
end

-- Raises the on_enabled event.
function remote_interface.raise_on_enabled_event(player)
	util.raise_event(
		on_enabled_event_id,
		{
			player_index = player.index
		}
	)
end

-- Raises the on_disabled event.
function remote_interface.raise_on_disabled_event(player)
	util.raise_event(
		on_disabled_event_id,
		{
			player_index = player.index
		}
	)
end

-- All remote functions from this mod.
remote_interface.remote_functions = {
	-- This event is invoked when Creative Mode is enabled.
	--	Parameters:
	--		player_index :: uint: Index of the player who enabled Creative Mode.
	on_enabled = function()
		return remote_interface.get_or_load_on_enabled_event_id()
	end,
	-- Create a custom event to notify other mods that creative mode is disabled.
	--	Parameters:
	--		player_index :: uint: Index of the player who disabled Creative Mode.
	on_disabled = function()
		return remote_interface.get_or_load_on_disabled_event_id()
	end,
	-- Checks whether Creative Mode has been enabled.
	--	Returns:
	--		True if Creative Mode has been enabled. Otherwise, false will be returned.
	is_enabled = function()
		return storage.creative_mode.enabled
	end,
	------

	-- Registers the function in your remote interface to make it callable via the modding UI as the form of a button.
	-- You can provide additional data with the third optional table parameter. So far, only caption and tooltip are supported.
	-- This function can be used for updating the additional data as well.
	--	Parameters:
	--		interface_name :: string: Name of your remote interface. For example, "creative-mode".
	--		function_name :: string: Name of your remote function to be registered. For example, "register_remote_function_to_modding_ui".
	--		additional :: table of additional data (optional):
	--			- caption :: string or LocalisedString (optional): caption of the button representing the function.
	--			- tooltip :: string or LocalisedString (optional): tooltip of the button representing the function.
	register_remote_function_to_modding_ui = function(interface_name, function_name, additional_data)
		gui_menu_modding.register_or_deregister_remote_function(interface_name, function_name, true, additional_data)
	end,
	-- Deregisters the function in your remote interface to make it uncallable via the modding UI as the form of a button.
	--	Parameters:
	--		interface_name :: string: Name of your remote interface. For example, "creative-mode".
	--		function_name :: string: Name of your remote function to be deregistered. For example, "register_remote_function_to_modding_ui".
	--	Returns:
	--		Whether such function has been registered before so it can be deregistered.
	deregister_remote_function_from_modding_ui = function(interface_name, function_name)
		return gui_menu_modding.register_or_deregister_remote_function(interface_name, function_name, false)
	end,
	-- Checks whether the given function has been registered so that it is callable via the modding UI as the form of a button.
	--	Parameters:
	--		interface_name :: string: Name of your remote interface. For example, "creative-mode".
	--		function_name :: string: Name of your remote function. For example, "register_remote_function_to_modding_ui".
	--	Returns:
	--		Whether such function has been registered.
	has_registered_remote_function_to_modding_ui = function(interface_name, function_name)
		return gui_menu_modding.has_registered_remote_function(interface_name, function_name)
	end,
	------

	-- Registers the given item name to the blacklist of the keep-last-item personal cheat, so the cheat will not apply to such item when it is used by a player.
	-- i.e. the keep-last-item cheat will not be applied if the player is using this item to build entities.
	--	Parameters:
	--		item_name :: string: name of the item to be registered. For example, "assembling-machine-2".
	exclude_from_keep_last_item = function(item_name)
		cheats.register_or_deregister_item_to_be_ignored_by_keep_last_item(item_name, true)
	end,
	-- Deregisters the given item name from the blacklist of the keep-last-item personal cheat, so the item will be affected by it again.
	--	Parameters:
	--		item_name :: string: name of the item to be deregistered. For example, "assembling-machine-2".
	--	Returns:
	--		Whether such item has been registered before so it can be deregistered.
	add_back_to_keep_last_item = function(item_name)
		return cheats.register_or_deregister_item_to_be_ignored_by_keep_last_item(item_name, false)
	end,
	-- Checks whether the given item name has been ignored by keep-last-item.
	--	Parameters:
	--		item_name :: string: item name. For example, "assembling-machine-2".
	--	Returns:
	--		Whether such item has been registered to the blacklist of the keep-last-item personal cheat.
	has_excluded_from_keep_last_item = function(item_name)
		return cheats.has_item_ignored_by_keep_last_item(item_name)
	end,
	------

	-- Registers the given entity name to the blacklist of the instant-blueprint personal cheat, so the cheat will not apply on such entity when its ghost is placed by a player.
	--  Parameters:
	--		entity_name :: string: name of the entity to be registered. For example, "assembling-machine-2".
	exclude_from_instant_blueprint = function(entity_name)
		cheats.register_or_deregister_entity_to_be_ignored_by_instant_blueprint(entity_name, true)
	end,
	-- Deregisters the given entity name from the blacklist of the instant-blueprint personal cheat, so the cheat will apply again on such entity when its ghost is placed by a player.
	--  Parameters:
	--		entity_name :: string: name of the entity to be deregistered. For example, "assembling-machine-2".
	--	Returns:
	--		Whether such entity has been registered before so it can be deregistered.
	add_back_to_instant_blueprint = function(entity_name)
		return cheats.register_or_deregister_entity_to_be_ignored_by_instant_blueprint(entity_name, false)
	end,
	-- Checks whether the given entity name has been ignored by instant-blueprint.
	--	Parameters:
	--		entity_name :: string: entity name. For example, "assembling-machine-2".
	--	Returns:
	--		Whether such entity has been registered to the blacklist of the instant-blueprint personal cheat.
	has_excluded_from_instant_blueprint = function(entity_name)
		return cheats.has_entity_ignored_by_instant_blueprint(entity_name)
	end,
	------

	-- Registers the given entity name to the blacklist of the instant-deconstruction personal cheat, so the cheat will not apply on such entity when it is marked to be deconstructed by a player.
	--  Parameters:
	--		entity_name :: string: name of the entity to be registered. For example, "assembling-machine-2".
	exclude_from_instant_deconstruction = function(entity_name)
		cheats.register_or_deregister_entity_to_be_ignored_by_instant_deconstruction(entity_name, true)
	end,
	-- Deregisters the given entity name from the blacklist of the instant-deconstruction personal cheat, so the cheat will apply again on such entity when it is marked to be deconstructed by a player.
	--  Parameters:
	--		entity_name :: string: name of the entity to be deregistered. For example, "assembling-machine-2".
	--	Returns:
	--		Whether such entity has been registered before so it can be deregistered.
	add_back_to_instant_deconstruction = function(entity_name)
		return cheats.register_or_deregister_entity_to_be_ignored_by_instant_deconstruction(entity_name, false)
	end,
	-- Checks whether the given entity name has been ignored by instant-deconstruction.
	--	Parameters:
	--		entity_name :: string: entity name. For example, "assembling-machine-2".
	--	Returns:
	--		Whether such entity has been registered to the blacklist of the instant-deconstruction personal cheat.
	has_excluded_from_instant_deconstruction = function(entity_name)
		return cheats.has_entity_ignored_by_instant_deconstruction(entity_name)
	end,
	----------

	-- The help command. Prints all usable commands on the console.
	help = function()
		game.player.print {"message.creative-mode_available_commands"}
		for _, command in ipairs(command_help_list) do
			game.player.print(command)
		end
	end,
	-- The command for enabling creative mode.
	enable = function()
		cheats.enable_or_disable_creative_mode(game.player, true, false, false, false)
	end,
	-- The command for disabling creative mode.
	disable = function(permanent_disable)
		-- If creative mode has not been enabled, notify the player in charge and do nothing.
		if not cheats.check_creative_mode_has_enabled(game.player) then
			return
		end
		if permanent_disable then
			gui.show_main_popup(game.player, gui.main_popup_content_type.permanent_disable_creative_mode)
		else
			gui.show_main_popup(game.player, gui.main_popup_content_type.disable_creative_mode)
		end
	end,
	----------

	-- An example of registering remote function to the modding UI by using function name starts with "creative_mode_"
	creative_mode_register_by_function_name_example = function(data)
		if data.creative_mode_modding then
			game.players[data.player_index].print {"message.creative-mode_remote-function-example-1"}
		end
	end,
	-- An example of registering remote function to the modding UI by our mod's function.
	register_by_remote_function_example_1 = function(data)
		if data.creative_mode_modding then
			-- Register another function.
			remote.call(
				"creative-mode",
				"register_remote_function_to_modding_ui",
				"creative-mode", -- Interface name
				"register_by_remote_function_example_2", -- Function name
				{
					caption = {"gui.creative-mode_register-by-remote-function-example-2"}, -- Button caption
					tooltip = {"gui.creative-mode_register-by-remote-function-example-2-tooltip"} -- Button tooltip
				}
			)
			game.players[data.player_index].print {"message.creative-mode_remote-function-example-2"}
		end
	end,
	-- Another example of registering remote function to the modding UI. This time, it is performed in runtime.
	-- It is also an example of deregistering remote function from the modding UI.
	register_by_remote_function_example_2 = function(data)
		if data.creative_mode_modding then
			-- Deregister this function.
			remote.call(
				"creative-mode",
				"deregister_remote_function_from_modding_ui",
				"creative-mode",
				"register_by_remote_function_example_2"
			)
			game.players[data.player_index].print {"message.creative-mode_remote-function-example-3"}
		end
	end
}
