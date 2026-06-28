-- This file contains variables or functions that are related to the Creative Thruster in this mod.
if not creative_thruster then
  creative_thruster = {}
end

-- The creative thruster is cloned from the vanilla Space Age thruster, which has exactly two
-- filtered fluidboxes: fuel (thruster-fuel) and oxidizer (thruster-oxidizer), each with a volume
-- of 1000. The thruster entity does not expose a writable `fluidbox` property, so we top the two
-- fluids up via insert_fluid every tick (the engine clamps inserts at the per-fluid capacity).
local thruster_fluids = {
  { name = "thruster-fuel", capacity = 1000 },
  { name = "thruster-oxidizer", capacity = 1000 },
}

-- Processes the table of creative_thruster in storage.
function creative_thruster.tick()
  -- Loop through the table of creative thrusters and top off fuel + oxidizer to capacity, so the
  -- thruster always has fuel and the platform travels with no fuel chain to supply.
  -- Iterate backwards so table.remove of invalid entries doesn't skip elements.
  for index = #storage.creative_mode.creative_thruster, 1, -1 do
    local entity = storage.creative_mode.creative_thruster[index]
    if entity.valid then
      if not entity.to_be_deconstructed() then
        for _, fluid in ipairs(thruster_fluids) do
          local missing = fluid.capacity - entity.get_fluid_count(fluid.name)
          if missing > 0 then
            entity.insert_fluid({ name = fluid.name, amount = missing })
          end
        end
      end
    else
      table.remove(storage.creative_mode.creative_thruster, index)
    end
  end
end
