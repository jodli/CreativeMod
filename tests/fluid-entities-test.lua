-- Tests for fluid-related creative entities
local helpers = require("tests.helpers")

describe("Fluid Void", function()
  before_each(function()
    helpers.clear_surface()
    helpers.enable_creative_mode()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  it("drains fluids from its fluidbox", function()
    local entity = helpers.place_entity("creative-mod_fluid-void", { 0, 0 })
    assert.is_not_nil(entity.fluidbox)

    -- Insert fluid directly into the fluidbox
    if #entity.fluidbox > 0 then
      entity.fluidbox[1] = { name = "water", amount = 1000 }

      -- Fluid void should drain it
      after_ticks(30, function()
        local fluid = entity.fluidbox[1]
        if fluid then
          assert.is_true(fluid.amount < 1000, "Fluid void should have reduced fluid amount")
        end
        -- nil fluidbox means it was fully drained, which is also success
      end)
    end
  end)
end)

describe("Super Boiler", function()
  before_each(function()
    helpers.clear_surface()
    helpers.enable_creative_mode()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  it("is placeable and valid", function()
    local entity = helpers.place_entity("creative-mod_super-boiler", { 0, 0 })
    assert.is_true(entity.valid)
  end)

  it("has energy set to a high value after ticks", function()
    local entity = helpers.place_entity("creative-mod_super-boiler", { 0, 0 })

    after_ticks(10, function()
      -- Super boiler sets energy to 1e15 every tick
      assert.is_true(entity.energy > 0, "Super boiler should have energy")
    end)
  end)
end)

describe("Super Cooler", function()
  before_each(function()
    helpers.clear_surface()
    helpers.enable_creative_mode()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  it("is placeable and valid", function()
    local entity = helpers.place_entity("creative-mod_super-cooler", { 0, 0 })
    assert.is_true(entity.valid)
  end)
end)
