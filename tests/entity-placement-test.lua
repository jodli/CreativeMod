-- Tests that all core creative entities can be placed and are registered correctly
local helpers = require("tests.helpers")

describe("Entity placement", function()
  before_each(function()
    helpers.clear_surface()
    helpers.enable_creative_mode()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  -- Core creative entities that must be placeable
  local placeable_entities = {
    { name = "creative-mod_new-creative-chest", desc = "Creative Chest" },
    { name = "creative-mod_new-creative-provider-chest", desc = "Creative Provider Chest" },
    { name = "creative-mod_duplicating-chest", desc = "Duplicating Chest" },
    { name = "creative-mod_duplicating-provider-chest", desc = "Duplicating Provider Chest" },
    { name = "creative-mod_void-chest", desc = "Void Chest" },
    { name = "creative-mod_void-requester-chest", desc = "Void Requester Chest" },
    { name = "creative-mod_void-storage-chest", desc = "Void Storage Chest" },
    { name = "creative-mod_fluid-source", desc = "Fluid Source" },
    { name = "creative-mod_fluid-void", desc = "Fluid Void" },
    { name = "creative-mod_super-boiler", desc = "Super Boiler" },
    { name = "creative-mod_super-cooler", desc = "Super Cooler" },
    { name = "creative-mod_configurable-super-boiler", desc = "Configurable Super Boiler" },
    { name = "creative-mod_heat-source", desc = "Heat Source" },
    { name = "creative-mod_heat-void", desc = "Heat Void" },
    { name = "creative-mod_item-source", desc = "Matter Source" },
    { name = "creative-mod_duplicator", desc = "Duplicator" },
    { name = "creative-mod_item-void", desc = "Matter Void" },
    { name = "creative-mod_random-item-source", desc = "Random Item Source" },
    { name = "creative-mod_creative-lab", desc = "Creative Lab" },
    { name = "creative-mod_void-lab", desc = "Void Lab" },
    { name = "creative-mod_energy-source", desc = "Energy Source" },
    { name = "creative-mod_passive-energy-source", desc = "Passive Energy Source" },
    { name = "creative-mod_energy-void", desc = "Energy Void" },
    { name = "creative-mod_passive-energy-void", desc = "Passive Energy Void" },
    { name = "creative-mod_super-electric-pole", desc = "Super Electric Pole" },
    { name = "creative-mod_super-substation", desc = "Super Substation" },
    { name = "creative-mod_super-roboport", desc = "Super Roboport" },
    { name = "creative-mod_super-radar", desc = "Super Radar" },
    { name = "creative-mod_super-beacon", desc = "Super Beacon" },
    { name = "creative-mod_linked-chest", desc = "Linked Chest" },
    { name = "creative-mod_linked-belt", desc = "Linked Belt" },
  }

  for i, entity_info in ipairs(placeable_entities) do
    it("can place " .. entity_info.desc, function()
      -- Offset each entity so they don't collide
      local entity = helpers.place_entity(entity_info.name, { i * 3, 0 })
      assert.is_true(entity.valid)
      assert.are_equal(entity_info.name, entity.name)
    end)
  end
end)
