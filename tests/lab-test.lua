-- Tests for Creative Lab and Void Lab
local helpers = require("tests.helpers")

describe("Creative Lab", function()
  before_each(function()
    helpers.clear_surface()
    helpers.enable_creative_mode()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  it("is placeable and registered", function()
    local lab = helpers.place_entity("creative-mod_creative-lab", { 0, 0 })
    assert.is_true(lab.valid)
    assert.is_true(#storage.creative_mode.creative_lab > 0, "Lab should be registered in storage")
  end)

  it("gets science packs inserted over time", function()
    local lab = helpers.place_entity("creative-mod_creative-lab", { 0, 0 })
    local inv = lab.get_inventory(defines.inventory.lab_input)
    assert.is_not_nil(inv)

    -- Creative lab should get science packs from the on_tick handler
    after_ticks(120, function()
      assert.is_false(inv.is_empty(), "Creative lab should have science packs inserted")
    end)
  end)
end)

describe("Void Lab", function()
  before_each(function()
    helpers.clear_surface()
    helpers.enable_creative_mode()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  it("is placeable and registered", function()
    local lab = helpers.place_entity("creative-mod_void-lab", { 0, 0 })
    assert.is_true(lab.valid)
    assert.is_true(#storage.creative_mode.void_lab > 0, "Void lab should be registered in storage")
  end)

  it("clears inserted science packs over time", function()
    local lab = helpers.place_entity("creative-mod_void-lab", { 0, 0 })
    local inv = lab.get_inventory(defines.inventory.lab_input)
    assert.is_not_nil(inv)

    -- Insert some science packs
    if storage.tool_item_list and #storage.tool_item_list > 0 then
      inv.insert({ name = storage.tool_item_list[1].name, count = 10 })

      after_ticks(60, function()
        assert.is_true(inv.is_empty(), "Void lab should have cleared science packs")
      end)
    end
  end)
end)
