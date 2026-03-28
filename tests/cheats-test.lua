-- Tests for player cheats (invincibility, speed, reach, etc.)
local helpers = require("tests.helpers")

describe("Personal cheats", function()
  before_each(function()
    helpers.clear_surface()
    helpers.enable_creative_mode()
  end)

  after_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  it("player has cheat_mode enabled", function()
    local player = helpers.get_player()
    assert.is_true(player.cheat_mode)
  end)

  it("player character is invincible by default", function()
    local player = helpers.get_player()
    if player.character then
      assert.is_false(player.character.destructible)
    end
  end)

  it("player has extended reach distance", function()
    local player = helpers.get_player()
    if player.character then
      assert.is_true(player.character_reach_distance_bonus > 0, "Reach distance bonus should be positive")
    end
  end)

  it("player has extended build distance", function()
    local player = helpers.get_player()
    if player.character then
      assert.is_true(player.character_build_distance_bonus > 0, "Build distance bonus should be positive")
    end
  end)

  it("player has fast running speed", function()
    local player = helpers.get_player()
    if player.character then
      assert.is_true(player.character_running_speed_modifier > 0, "Running speed modifier should be positive")
    end
  end)

  it("player has fast mining speed", function()
    local player = helpers.get_player()
    if player.character then
      assert.is_true(player.character_mining_speed_modifier > 0, "Mining speed modifier should be positive")
    end
  end)
end)

describe("Cheats disabled", function()
  before_each(function()
    helpers.clear_surface()
    helpers.disable_creative_mode()
  end)

  after_each(function()
    helpers.disable_creative_mode()
  end)

  it("player does not have cheat_mode when CM is disabled", function()
    local player = helpers.get_player()
    assert.is_false(player.cheat_mode)
  end)

  it("player character is destructible when CM is disabled", function()
    local player = helpers.get_player()
    if player.character then
      assert.is_true(player.character.destructible)
    end
  end)
end)
