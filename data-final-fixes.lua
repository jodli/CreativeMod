-- Create free recipe for each fluid.
for _, fluid in pairs(data.raw["fluid"]) do
	data:extend(
		{
			{
				type = "recipe",
				name = creative_mode_defines.names.free_fluid_recipe_prefix .. fluid.name,
				category = creative_mode_defines.names.recipe_categories.free_fluids,
				ingredients = {},
				results = {
					{type = "fluid", name = fluid.name, amount = 5000}
				},
				main_product = fluid.name,
				subgroup = creative_mode_defines.names.item_subgroups.free_fluids,
				enabled = false
			}
		}
	)
end

-- Some mods (e.g. Bob's Modules) add limitations to all productivity modules. But we want our super productivity module to be limitless.
data.raw["module"][creative_mode_defines.names.recipes.super_productivity_module].limitation = nil

--------------------------------------------------------------

-- All possible data raw names for items that have place results of entities.
local possible_data_raw_types_for_items_of_entities = {
	"item",
	"item-with-entity-data", -- 0.13
	"item-with-label" -- 0.13
}
-- Make a dictionary for recording all items' place results, so we can find whether the items for the enemy worms and spawners already exist.
local item_place_results = {}
for _, raw_name in pairs(possible_data_raw_types_for_items_of_entities) do
	local data_raw = data.raw[raw_name]
	if data_raw then
		for _, item in pairs(data_raw) do
			if item.place_result then
				item_place_results[item.place_result] = true
			end
		end
	end
end
-- Returns whether there is already an item for the given entity.
local function has_item_for_enemy_entity(entity)
	return item_place_results[entity.name] == true
end

-- Make a dictionary for recording all spawner's result units, so we can find whether a unit is really spawnable.
local spawnable_units = {}
local unit_spawners = data.raw["unit-spawner"]
if unit_spawners then
	for _, spawner in pairs(unit_spawners) do
		local result_units = spawner.result_units
		if result_units then
			for _, unit_data in pairs(result_units) do
				spawnable_units[unit_data[1]] = true
			end
		end
	end
end
-- Returns whether there is a spawner that can spawn the given entity.
local function has_spawner_for_enemy_unit(entity)
	return spawnable_units[entity.name] == true
end

-- Clones the enemy entities in the given data raw and creates item and recipe for them.
-- It will not touch those entities that already have an item to build it.
local function clone_enemy_entities_in_data_raw_and_create_recipe(raw_name)
	if not data.raw[raw_name] then
		return
	end

	-- We will extend the data after the following for-loop, to avoid problem caused by altering the iterating list.
	local new_data = {}
	for _, entity in pairs(data.raw[raw_name]) do
		-- Add item and recipe only if
		-- a) for structures: there is no item for the entity. If there is already an item, there is high chance that its recipe is also there.
		-- b) for units: there is spawner for the unit. If there is no spawner for the unit, there is high chance that the unit is created by script for special purpose.
		if
			(raw_name == "unit" and has_spawner_for_enemy_unit(entity)) or
				(raw_name ~= "unit" and not has_item_for_enemy_entity(entity))
		 then
			local entity_name = creative_mode_defines.names.enemy_entity_prefix .. entity.name
			local entity_localised_name
			if settings.startup[creative_mode_defines.names.settings.enemy_structures_add_name_suffix].value then
				-- Add suffix to these new spawners and worms.
				if entity.localised_name then
					entity_localised_name = {"entity-name.creative-mode_enemy-object", entity.localised_name}
				else
					entity_localised_name = {"entity-name.creative-mode_enemy-object", "__ENTITY__" .. entity.name .. "__"}
				end
			else
				-- Use their original name.
				if entity.localised_name then
					entity_localised_name = entity.localised_name
				else
					entity_localised_name = {"entity-name." .. entity.name}
				end
			end
			local item_name = creative_mode_defines.names.enemy_item_prefix .. entity.name
			local recipe_name = creative_mode_defines.names.enemy_recipe_prefix .. entity.name

			-- Clone the entity.
			-- We don't use the original entity because that will make their corpse collide with our structures.
			local new_entity = util.table.deepcopy(entity)
			new_entity.name = entity_name
			new_entity.flags = {"player-creation"} -- Reset the flags so it is blueprintable and repairable.
			new_entity.localised_name = entity_localised_name
			-- Make the entity minable.
			new_entity.minable = {hardness = 0.2, mining_time = 0.5, result = item_name}
			-- No autoplace.
			new_entity.autoplace = nil
			table.insert(new_data, new_entity)
			-- Flags.
			local flags = {}
			if not settings.startup[creative_mode_defines.names.settings.unhide_items].value then
				table.insert(flags, "hidden")
			end
			-- Create item for the entity.
			table.insert(
				new_data,
				{
					type = "item",
					name = item_name,
					localised_name = entity_localised_name, -- Item does not know the entity's custom localised name, so we have to also use custom localised name for it.
					icon_size = 64,
					icon_mipmaps = 4,
					icon = entity.icon,
					flags = flags,
					subgroup = creative_mode_defines.names.item_subgroups.enemies,
					--order = entity.order,
					place_result = entity_name,
					stack_size = 50
				}
			)
			-- And recipe.
			table.insert(
				new_data,
				{
					type = "recipe",
					name = recipe_name,
					category = creative_mode_defines.names.recipe_categories.enemies,
					ingredients = {},
					result = item_name,
					enabled = false
				}
			)
		end
	end

	-- Extend data.
	if #new_data > 0 then
		data:extend(new_data)
	end
end

-- Worms.
clone_enemy_entities_in_data_raw_and_create_recipe("turret")
-- Spawners.
clone_enemy_entities_in_data_raw_and_create_recipe("unit-spawner")
-- Units.
clone_enemy_entities_in_data_raw_and_create_recipe("unit")

--------------------------------------------------------------

-- Absolute resistance.
local resistances = {}
for _, damage_type in pairs(data.raw["damage-type"]) do
	local damage_type_name = damage_type.name
	table.insert(
		resistances,
		{
			type = damage_type_name,
			percent = 100
		}
	)
end

-- Make the super robots to have absolute resistance.
data.raw["logistic-robot"][creative_mode_defines.names.entities.super_logistic_robot].resistances = resistances
data.raw["construction-robot"][creative_mode_defines.names.entities.super_construction_robot].resistances = resistances

--------------------------------------------------------------

-- Allow the creative lab to accept all research materials.
local tools = {}
for _, tool in pairs(data.raw["tool"]) do
	table.insert(tools, tool.name)
end
data.raw["lab"][creative_mode_defines.names.entities.creative_lab].inputs = tools

--------------------------------------------------------------

-- Create infinite version of the resources that are not infinite.
local data_raw_resource = data.raw["resource"]

-- Record all infinite minables first.
local infinite_minables = {}
for _, resource in pairs(data_raw_resource) do
	if resource.infinite then
		local minable = resource.minable
		if minable then
			local results = minable.results
			if results then
				for _, result in pairs(results) do
					local result_name = (result.type or "item") .. "." .. (result.name or result[1])
					infinite_minables[result_name] = true
				end
			else
				local result = minable.result
				if result then
					local result_name = (minable.type or "item") .. "." .. result
					infinite_minables[result_name] = true
				end
			end
		end
	end
end

-- Find all resources that don't have the corresponding infinite minables.
local finite_resource_names = {}
for _, resource in pairs(data_raw_resource) do
	if not resource.infinite then
		local minable = resource.minable
		if minable then
			local results = minable.results
			if results then
				local results_count = #results
				for _, result in pairs(results) do
					local result_name = (result.type or "item") .. "." .. (result.name or result[1])
					if infinite_minables[result_name] then
						results_count = results_count - 1
					end
				end
				if results_count > 0 then
					table.insert(finite_resource_names, resource.name)
				end
			else
				local result = minable.result
				if result then
					local result_name = (minable.type or "item") .. "." .. result
					if not infinite_minables[result_name] then
						table.insert(finite_resource_names, resource.name)
					end
				end
			end
		end
	end
end

-- Create infinite version of the recorded resources.
for _, name in pairs(finite_resource_names) do
	local resource = util.table.deepcopy(data_raw_resource[name])
	resource.name = creative_mode_defines.names.infinite_resource_prefix .. name
	if resource.localised_name then
		resource.localised_name = {"entity-name.creative-mode_infinite-resource", resource.localised_name}
	else
		resource.localised_name = {"entity-name.creative-mode_infinite-resource", "__ENTITY__" .. name .. "__"}
	end
	local icons = resource.icons
	if icons then
		if resource.icon_size == 32 then
			table.insert(icons, {icon = creative_mode_defines.mod_directory .. "/graphics/icons/infinite-resource-32.png"})
		elseif resource.icon_size == 64 then
			table.insert(icons, {icon = creative_mode_defines.mod_directory .. "/graphics/icons/infinite-resource-64.png"})
		end
	else
		if resource.icon_size == 32 then
			resource.icons = {
				{icon = resource.icon},
				{icon = creative_mode_defines.mod_directory .. "/graphics/icons/infinite-resource-32.png"}
			}
		elseif resource.icon_size == 64 then
			resource.icons = {
				{icon = resource.icon},
				{icon = creative_mode_defines.mod_directory .. "/graphics/icons/infinite-resource-64.png"}
			}
		end
	end
	resource.infinite = true
	resource.minimum = 60000
	resource.normal = 300000
	resource.infinite_depletion_amount = 10
	resource.resource_patch_search_radius = 1
	local minable = resource.minable
	if minable then
		local results = minable.results
		if results then
			for _, result in pairs(results) do
				result.amount_min = 10
				result.amount_max = 10
				if not result.name then
					result.name = result[1]
					result[1] = nil
					result[2] = nil
				end
			end
		else
			local result = minable.result
			if result then
				minable.amount_min = 10
				minable.amount_max = 10
			end
		end
	end
	resource.autoplace = nil

	data:extend {resource}
end
