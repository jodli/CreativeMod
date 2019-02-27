-- This file contains variables or functions that are related to the Super Boiler in this mod.
if not configurable_super_boiler then configurable_super_boiler = {} end

-- Processes the table of configurable_super_boiler_data in global.
function configurable_super_boiler.tick()
	-- Loop through the table of super-boiler to give free energy and heat up fluid inside.
	for index, configurable_super_boiler_data in ipairs(global.creative_mode.configurable_super_boiler_data) do
		local configurable_super_boiler = configurable_super_boiler_data.entity
		local temperature = configurable_super_boiler_data.temperature
		if configurable_super_boiler.valid then
			if not configurable_super_boiler.to_be_deconstructed(configurable_super_boiler.force) then
				configurable_super_boiler.energy = 1000000000000000
				fluid_providers_util.set_all_fluids_to_temperature(configurable_super_boiler, temperature)
			end
		else
			table.remove(global.creative_mode.configurable_super_boiler_data, index)
		end
	end
end

-- Updates the temperature of the boiler of given data to the given value.
-- This will not update the GUI.
function configurable_super_boiler.update_temperature(configurable_super_boiler_data, new_temperature)
	if configurable_super_boiler_data.temperature ~= new_temperature then
		local entity = configurable_super_boiler_data.entity
		entity.surface.create_entity{name = "flying-text", position = entity.position, color = {r = 1, g = 1, b = 1}, text = new_temperature .. "°C"}
		configurable_super_boiler_data.temperature = new_temperature
	end
end

-- Returns the configurable super boiler data according to the given entity.
-- If no data is found, nil will be returned.
function configurable_super_boiler.get_data_for_entity(entity)
	for _, configurable_super_boiler_data in ipairs(global.creative_mode.configurable_super_boiler_data) do
		if configurable_super_boiler_data.entity == entity then
			return configurable_super_boiler_data
		end
	end
	return nil
end

-- Pastes the temperature of the source super boiler to the destination super boiler.
function configurable_super_boiler.on_entity_copied_pasted(source, destination)
	local source_data = configurable_super_boiler.get_data_for_entity(source)
	if not source_data then
		return
	end
	local destination_data = configurable_super_boiler.get_data_for_entity(destination)
	if not destination_data then
		return
	end
	
	configurable_super_boiler.update_temperature(destination_data, source_data.temperature)
end