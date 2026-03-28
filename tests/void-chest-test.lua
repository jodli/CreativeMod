-- Tests for Void Chest behavior (should remove items from inventory)
local helpers = require("tests.helpers")

describe("Void Chest", function()
  before_each(function()
    helpers.clear_surface()
    helpers.enable_creative_mode()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  it("clears inserted items over time", function()
    local chest = helpers.place_entity("creative-mod_void-chest", { 0, 0 })
    local inv = chest.get_inventory(defines.inventory.chest)
    assert.is_not_nil(inv)

    -- Insert some items
    inv.insert({ name = "iron-plate", count = 100 })
    assert.are_not_equal(0, inv.get_item_count("iron-plate"))

    -- Void chest should clear items within a few ticks
    after_ticks(60, function()
      assert.are_equal(0, inv.get_item_count("iron-plate"), "Void chest should have removed items")
    end)
  end)
end)
