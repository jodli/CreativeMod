require("defines")
require("util")

require("scripts.autofill-requester-chest")
require("scripts.cheats")
require("scripts.configurable-super-boiler")
require("scripts.creative-cargo-wagon")
require("scripts.creative-chest")
require("scripts.creative-chest-util")
require("scripts.creative-lab")
require("scripts.creative-provider-chest")
require("scripts.duplicating-cargo-wagon")
require("scripts.duplicating-chest")
require("scripts.duplicating-chest-util")
require("scripts.duplicating-provider-chest")
require("scripts.duplicator")
require("scripts.energy-source")
require("scripts.energy-void")
require("scripts.equipments")
require("scripts.events")
require("scripts.fluid-providers-util")
require("scripts.fluid-source")
require("scripts.fluid-void")
require("scripts.global-util")
require("scripts.gui")
require("scripts.gui-entity")
require("scripts.gui-menu-admin")
require("scripts.gui-menu-cheats")
require("scripts.gui-menu-magicwand")
require("scripts.gui-menu-modding")
require("scripts.gui-menu") -- It has to be loaded after the submenus.
require("scripts.heat-source")
require("scripts.heat-void")
require("scripts.item-providers-util")
require("scripts.item-source")
require("scripts.item-void")
require("scripts.magic-wand-creator")
require("scripts.magic-wand-healer")
require("scripts.magic-wand-modifier")
require("scripts.mod-compatibler")
require("scripts.passive-energy-source")
require("scripts.passive-energy-void")
require("scripts.random-item-source")
require("scripts.remote-interface")
require("scripts.rights")
require("scripts.super-beacon")
require("scripts.super-boiler")
require("scripts.super-cooler")
require("scripts.super-radar")
require("scripts.super-roboport")
require("scripts.util")
require("scripts.void-cargo-wagon")
require("scripts.void-chest-util")
require("scripts.void-chest")
require("scripts.void-requester-chest")
require("scripts.void-storage-chest")

-- Registers callback for each events.
script.on_init(events.on_init)
script.on_load(events.on_load)
script.on_configuration_changed(events.on_configuration_changed)

-- The on_tick event is called very frequently, it is better to NOT do a name check in the generic event handler.
script.on_event(defines.events.on_tick, events.on_tick)
-- Other events.
local events_except_on_tick = {}
for _, event in pairs(defines.events) do
    if event ~= defines.events.on_tick then
        table.insert(events_except_on_tick, event)
    end
end
script.on_event(events_except_on_tick, events.on_event)

-- Create interface for lua command.
remote.add_interface(creative_mode_defines.names.interface, remote_interface.remote_functions)
-- For demo usage of the remote interface, please see call_remote_functions() in scripts/events.lua.

--[[commands.add_command("creative-mode.reload", "Reload, in case something broke", function(event)
    if global.creative_mode.enabled then
        local player = game.players[event.player_index]
        --events.on_configuration_changed({mod_changes={}}) --this doesn't work, because it checks if the recipes are disabled(which they are), and will skip re-enabling if so
        cheats.enable_or_disable_creative_mode(player, false, false, false, false)
        cheats.enable_or_disable_creative_mode(player, true, false, false, false)
    end
end)]]
