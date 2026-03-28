-- Tests for Duplicating Chest behavior (should duplicate first item to fill)
local helpers = require("tests.helpers")

describe("Duplicating Chest", function()
  before_each(function()
    helpers.clear_surface()
    helpers.enable_creative_mode()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  it("duplicates items inserted into first slot", function()
    local chest = helpers.place_entity("creative-mod_duplicating-chest", { 0, 0 })
    local inv = chest.get_inventory(defines.inventory.chest)
    assert.is_not_nil(inv)

    -- Insert one iron plate
    inv.insert({ name = "iron-plate", count = 1 })
    local initial_count = inv.get_item_count("iron-plate")
    assert.are_equal(1, initial_count)

    -- After some ticks, the chest should have duplicated the item
    after_ticks(120, function()
      local count = inv.get_item_count("iron-plate")
      assert.is_true(count > initial_count, "Duplicating chest should have more items than initially inserted")
    end)
  end)
end)
