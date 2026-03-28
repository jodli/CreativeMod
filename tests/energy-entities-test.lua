-- Tests for energy-related creative entities
local helpers = require("tests.helpers")

describe("Energy Source", function()
  before_each(function()
    helpers.clear_surface()
    helpers.enable_creative_mode()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  it("is placeable", function()
    local entity = helpers.place_entity("creative-mod_energy-source", { 0, 0 })
    assert.is_true(entity.valid)
  end)

  it("produces power", function()
    local entity = helpers.place_entity("creative-mod_energy-source", { 0, 0 })
    assert.is_true(entity.power_production > 0, "Energy source should produce power")
  end)
end)

describe("Energy Void", function()
  before_each(function()
    helpers.clear_surface()
    helpers.enable_creative_mode()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  it("is placeable", function()
    local entity = helpers.place_entity("creative-mod_energy-void", { 0, 0 })
    assert.is_true(entity.valid)
  end)

  it("consumes power", function()
    local entity = helpers.place_entity("creative-mod_energy-void", { 0, 0 })
    assert.is_true(entity.power_usage > 0, "Energy void should consume power")
  end)
end)

describe("Heat Source", function()
  before_each(function()
    helpers.clear_surface()
    helpers.enable_creative_mode()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  it("is placeable and sets temperature on build", function()
    local entity = helpers.place_entity("creative-mod_heat-source", { 0, 0 })
    assert.is_true(entity.valid)
    -- Heat source sets temperature to 1000 on placement
    assert.are_equal(1000, entity.temperature)
  end)
end)

describe("Heat Void", function()
  before_each(function()
    helpers.clear_surface()
    helpers.enable_creative_mode()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  it("is placeable and sets temperature on build", function()
    local entity = helpers.place_entity("creative-mod_heat-void", { 0, 0 })
    assert.is_true(entity.valid)
    -- Heat void sets temperature to 0 on placement
    assert.are_equal(0, entity.temperature)
  end)
end)
