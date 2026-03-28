-- Tests for the on_tick handler behavior
-- These tests verify the baseline behavior before Phase 1 refactoring
local helpers = require("tests.helpers")

describe("on_tick handler", function()
  before_each(function()
    helpers.clear_surface()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  it("runs without errors when CM is enabled and no entities exist", function()
    helpers.enable_creative_mode()
    -- Just let a bunch of ticks run with no entities - should not crash
    after_ticks(300, function()
      assert.is_true(storage.creative_mode.enabled)
    end)
  end)

  it("runs without errors when CM is disabled", function()
    helpers.disable_creative_mode()
    -- Let ticks run with CM disabled - currently all tick functions still run
    -- After Phase 1, they should early-out
    after_ticks(300, function()
      assert.is_false(storage.creative_mode.enabled)
    end)
  end)

  it("runs without errors with multiple entity types placed", function()
    helpers.enable_creative_mode()
    -- Place a variety of entities that have tick handlers
    helpers.place_entity("creative-mod_new-creative-chest", { 0, 0 })
    helpers.place_entity("creative-mod_duplicating-chest", { 3, 0 })
    helpers.place_entity("creative-mod_void-chest", { 6, 0 })
    helpers.place_entity("creative-mod_fluid-void", { 9, 0 })
    helpers.place_entity("creative-mod_super-boiler", { 12, 0 })
    helpers.place_entity("creative-mod_creative-lab", { 15, 0 })
    helpers.place_entity("creative-mod_void-lab", { 18, 0 })
    helpers.place_entity("creative-mod_energy-source", { 21, 0 })

    -- Let many ticks run with all entities active
    after_ticks(600, function()
      assert.is_true(storage.creative_mode.enabled)
    end)
  end)
end)
