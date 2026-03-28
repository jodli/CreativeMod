-- Tests for the core Creative Mode enable/disable functionality
local helpers = require("tests.helpers")

describe("Creative Mode toggle", function()
  before_each(function()
    helpers.clear_surface()
  end)

  after_each(function()
    -- Always leave CM disabled to not affect other tests
    helpers.disable_creative_mode()
  end)

  it("starts disabled", function()
    helpers.disable_creative_mode()
    assert.is_false(storage.creative_mode.enabled)
  end)

  it("can be enabled", function()
    helpers.enable_creative_mode()
    assert.is_true(storage.creative_mode.enabled)
  end)

  it("can be disabled after enabling", function()
    helpers.enable_creative_mode()
    assert.is_true(storage.creative_mode.enabled)
    helpers.disable_creative_mode()
    assert.is_false(storage.creative_mode.enabled)
  end)

  it("enables cheat mode on the player when CM is enabled", function()
    local player = helpers.get_player()
    helpers.enable_creative_mode()
    assert.is_true(player.cheat_mode)
  end)

  it("is queryable via remote interface", function()
    helpers.disable_creative_mode()
    local is_enabled = remote.call("creative-mode", "is_enabled")
    assert.is_false(is_enabled)

    helpers.enable_creative_mode()
    is_enabled = remote.call("creative-mode", "is_enabled")
    assert.is_true(is_enabled)
  end)
end)
