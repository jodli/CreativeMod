-- Tests for equipment energy refill (the on_tick refill mechanism)
local helpers = require("tests.helpers")

describe("Equipment energy refill", function()
  before_each(function()
    helpers.clear_surface()
    helpers.enable_creative_mode()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  it("storage.energy_refill_equipments table exists", function()
    assert.is_not_nil(storage.energy_refill_equipments)
    assert.are_equal("table", type(storage.energy_refill_equipments))
  end)
end)
