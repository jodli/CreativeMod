-- This file contains variables or functions that are related to the equipments in this mod.
if not equipments then
  equipments = {}
end

-- Refills the energy of the registered equipments in the global table.
function equipments.tick()
  for index = #storage.energy_refill_equipments, 1, -1 do
    local equipment = storage.energy_refill_equipments[index]
    if equipment.valid then
      equipment.energy = 10000000000000000000000000
    else
      table.remove(storage.energy_refill_equipments, index)
    end
  end
end
