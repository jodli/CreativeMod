-- Tests for Creative Chest behavior (should contain all items)
local helpers = require("tests.helpers")

describe("Creative Chest", function()
  before_each(function()
    helpers.clear_surface()
    helpers.enable_creative_mode()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  it("has a non-empty inventory after ticks", function()
    local chest = helpers.place_entity("creative-mod_new-creative-chest", { 0, 0 })
    local inv = chest.get_inventory(defines.inventory.chest)
    assert.is_not_nil(inv)

    -- Creative chests are filled over time by the on_tick handler
    after_ticks(120, function()
      assert.is_true(#inv > 0, "Creative chest inventory should not be empty")
    end)
  end)

  it("creative provider chest also has inventory", function()
    local chest = helpers.place_entity("creative-mod_new-creative-provider-chest", { 0, 0 })
    local inv = chest.get_inventory(defines.inventory.chest)
    assert.is_not_nil(inv)

    after_ticks(120, function()
      assert.is_true(#inv > 0, "Creative provider chest inventory should not be empty")
    end)
  end)
end)
