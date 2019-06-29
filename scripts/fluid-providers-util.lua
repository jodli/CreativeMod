-- This file contains variables or functions that are common for our fluid provider entities and specific for this mod.
if not fluid_providers_util then
	fluid_providers_util = {}
end

-- Removes all fluids inside the given entity.
function fluid_providers_util.remove_all_fluids(entity)
	for i = 1, #entity.fluidbox, 1 do
		entity.fluidbox[i] = nil
	end
end

-- Duplicates the fluid in each fluid box of the given entity.
function fluid_providers_util.duplicate_fluid_in_each_fluidbox(entity)
	local fluidbox = entity.fluidbox
	for i = 1, #fluidbox, 1 do
		local fluid = fluidbox[i]
		local capacity = fluidbox.get_capacity(i)
		if fluid ~= nil then
			fluid.amount = math.min(capacity, fluid.amount + 50)
			entity.fluidbox[i] = fluid
		end
	end
end

-- Heats all fluids inside the given entity up to their corresponding maximum temperature.
function fluid_providers_util.heat_all_fluids_up_to_max_temperature(entity)
	for i = 1, #entity.fluidbox, 1 do
		local fluid = entity.fluidbox[i]
		if fluid then
			local fluid_prototype = game.fluid_prototypes[fluid.name]
			fluid.temperature = fluid_prototype.max_temperature
			entity.fluidbox[i] = fluid
		end
	end
end

-- Cools all fluids inside the given entity down to their corresponding default temperature.
function fluid_providers_util.cool_all_fluids_down_to_default_temperature(entity)
	for i = 1, #entity.fluidbox, 1 do
		local fluid = entity.fluidbox[i]
		if fluid then
			local fluid_prototype = game.fluid_prototypes[fluid.name]
			fluid.temperature = fluid_prototype.default_temperature
			entity.fluidbox[i] = fluid
		end
	end
end

-- Sets all fluids inside the given entity to the given temperature.
function fluid_providers_util.set_all_fluids_to_temperature(entity, temperature)
	for i = 1, #entity.fluidbox, 1 do
		local fluid = entity.fluidbox[i]
		if fluid then
			fluid.temperature = temperature
			entity.fluidbox[i] = fluid
		end
	end
end
