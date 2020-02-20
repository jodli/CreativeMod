require("scripts/creative-chest-util")
require("circuit-connector-sprites")

local function flying_robot(volume)
	return {
		sound = {
			{
				filename = "__base__/sound/flying-robot-1.ogg", volume = volume
			},
			{
				filename = "__base__/sound/flying-robot-2.ogg", volume = volume
			},
			{
				filename = "__base__/sound/flying-robot-3.ogg", volume = volume
			},
			{
				filename = "__base__/sound/flying-robot-4.ogg", volume = volume
			},
			{
				filename = "__base__/sound/flying-robot-5.ogg", volume = volume
			},
			{
				filename = "__base__/sound/flying-robot-6.ogg", volume = volume
			},
			{
				filename = "__base__/sound/flying-robot-7.ogg", volume = volume
			},
			{
				filename = "__base__/sound/flying-robot-8.ogg", volume = volume
			},
			{
				filename = "__base__/sound/flying-robot-9.ogg", volume = volume
			}
		},
		max_sounds_per_type = 5,
		audible_distance_modifier = 1,
		probability = 1 / (10 * 60) -- average pause between the sound is 10 seconds
	}
end

local function construction_robot(volume)
	return {
		sound = {
			{
				filename = "__base__/sound/construction-robot-1.ogg", volume = volume
			},
			{
				filename = "__base__/sound/construction-robot-2.ogg", volume = volume
			},
			{
				filename = "__base__/sound/construction-robot-3.ogg", volume = volume
			},
			{
				filename = "__base__/sound/construction-robot-4.ogg", volume = volume
			},
			{
				filename = "__base__/sound/construction-robot-5.ogg", volume = volume
			},
			{
				filename = "__base__/sound/construction-robot-6.ogg", volume = volume
			},
			{
				filename = "__base__/sound/construction-robot-7.ogg", volume = volume
			},
			{
				filename = "__base__/sound/construction-robot-8.ogg", volume = volume
			},
			{
				filename = "__base__/sound/construction-robot-9.ogg", volume = volume
			}
		},
		max_sounds_per_type = 1,
		audible_distance_modifier = 1,
		probability = 1 / (10 * 60) -- average pause between the sound is 10 seconds
	}
end

local function def_CC_table(main_offset, shadow_offset, variation)
	return {
		variation = variation,
		main_offset = main_offset,
		shadow_offset = shadow_offset,
		show_shadow = shadow_offset ~= nil
	}
end

-- Generates data for container according to the given data.
local function container(entity_name, item_name, icon_name, picture_name, additional_pastable_entities, inventory_size)
	circuit_connector_definitions[entity_name] =
		circuit_connector_definitions.create(
		universal_connector_template,
		{
			def_CC_table({0.1875, 0.15625}, nil, 18)
		}
	)

	return {
		type = "container",
		name = entity_name,
		icon_size = 32,
		icon = creative_mode_defines.mod_directory .. "/graphics/icons/" .. icon_name,
		flags = {"placeable-player", "player-creation"},
		minable = {mining_time = 0.5, result = item_name},
		max_health = 150,
		corpse = "small-remnants",
		fast_replaceable_group = "container",
		additional_pastable_entities = additional_pastable_entities,
		collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
		inventory_size = inventory_size,
		open_sound = {filename = "__base__/sound/metallic-chest-open.ogg", volume = 0.65},
		close_sound = {filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7},
		picture = {
			filename = creative_mode_defines.mod_directory .. "/graphics/entity/" .. picture_name,
			priority = "extra-high",
			width = 48,
			height = 34,
			shift = {0.1875, 0}
		},
		circuit_wire_connection_point = {
			shadow = {
				red = {0.734375, 0.453125},
				green = {0.609375, 0.515625}
			},
			wire = {
				red = {0.40625, 0.21875},
				green = {0.40625, 0.375}
			}
		},
		circuit_wire_max_distance = 1000,
		circuit_connector_sprites = circuit_connector_definitions[entity_name].sprites
	}
end

-- Generates data for logistic container according to the given data.
local function logistic_container(
	entity_name,
	item_name,
	icon_name,
	picture_name,
	additional_pastable_entities,
	inventory_size,
	logistic_mode)
	circuit_connector_definitions[entity_name] =
		circuit_connector_definitions.create(
		universal_connector_template,
		{
			def_CC_table({0.1875, 0.15625}, nil, 18)
		}
	)

	return {
		type = "logistic-container",
		name = entity_name,
		icon_size = 32,
		icon = creative_mode_defines.mod_directory .. "/graphics/icons/" .. icon_name,
		flags = {"placeable-player", "player-creation"},
		minable = {mining_time = 0.5, result = item_name},
		max_health = 150,
		corpse = "small-remnants",
		fast_replaceable_group = "container",
		additional_pastable_entities = additional_pastable_entities,
		collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
		inventory_size = inventory_size,
		logistic_mode = logistic_mode,
		logistic_slots_count = ((logistic_mode ~= "storage") and 12) or nil,
		open_sound = {filename = "__base__/sound/metallic-chest-open.ogg", volume = 0.65},
		close_sound = {filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7},
		picture = {
			filename = creative_mode_defines.mod_directory .. "/graphics/entity/" .. picture_name,
			priority = "extra-high",
			width = 38,
			height = 32,
			shift = {0.09375, 0}
		},
		circuit_wire_connection_point = {
			shadow = {
				red = {0.734375, 0.453125},
				green = {0.609375, 0.515625}
			},
			wire = {
				red = {0.40625, 0.21875},
				green = {0.40625, 0.375}
			}
		},
		circuit_wire_max_distance = 1000,
		circuit_connector_sprites = circuit_connector_definitions[entity_name].sprites
	}
end

-- Generates data for cargo wagon according to the given data.
local function cargo_wagon(entity_name, item_name, tint, additional_pastable_entities, inventory_size)
	return {
		type = "cargo-wagon",
		name = entity_name,
		icon_size = 32,
		icons = {
			{
				icon = "__base__/graphics/icons/cargo-wagon.png",
				tint = tint
			}
		},
		flags = {"player-creation", "placeable-off-grid", "not-on-map"},
		additional_pastable_entities = additional_pastable_entities,
		inventory_size = inventory_size,
		minable = {mining_time = 1, result = item_name},
		mined_sound = {filename = "__core__/sound/deconstruct-medium.ogg"},
		max_health = 600,
		corpse = "medium-remnants",
		dying_explosion = "medium-explosion",
		collision_box = {{-0.6, -2.4}, {0.6, 2.4}},
		selection_box = {{-1, -2.703125}, {1, 3.296875}},
		vertical_selection_shift = -0.796875,
		weight = 1000,
		max_speed = 1.5,
		braking_force = 3,
		friction_force = 0.50,
		air_resistance = 0.01,
		connection_distance = 3,
		joint_distance = 4,
		energy_per_hit_point = 5,
		resistances = {
			{
				type = "fire",
				decrease = 15,
				percent = 50
			},
			{
				type = "physical",
				decrease = 15,
				percent = 30
			},
			{
				type = "impact",
				decrease = 50,
				percent = 60
			},
			{
				type = "explosion",
				decrease = 15,
				percent = 30
			},
			{
				type = "acid",
				decrease = 10,
				percent = 20
			}
		},
		back_light = rolling_stock_back_light(),
		stand_by_light = rolling_stock_stand_by_light(),
		color = {r = 0.43, g = 0.23, b = 0, a = 0.5},
		pictures = {
			layers = {
				{
					priority = "very-low",
					width = 222,
					height = 205,
					back_equals_front = true,
					direction_count = 128,
					filenames = {
						"__base__/graphics/entity/cargo-wagon/cargo-wagon-1.png",
						"__base__/graphics/entity/cargo-wagon/cargo-wagon-2.png",
						"__base__/graphics/entity/cargo-wagon/cargo-wagon-3.png",
						"__base__/graphics/entity/cargo-wagon/cargo-wagon-4.png"
					},
					line_length = 4,
					lines_per_file = 8,
					shift = {0, -0.796875},
					tint = tint
				},
				{
					flags = {"mask"},
					width = 196,
					height = 174,
					direction_count = 128,
					back_equals_front = true,
					apply_runtime_tint = true,
					shift = {0, -1.125},
					filenames = {
						"__base__/graphics/entity/cargo-wagon/cargo-wagon-mask-1.png",
						"__base__/graphics/entity/cargo-wagon/cargo-wagon-mask-2.png",
						"__base__/graphics/entity/cargo-wagon/cargo-wagon-mask-3.png"
					},
					line_length = 4,
					lines_per_file = 11
				},
				{
					flags = {"compressed"},
					width = 246,
					height = 201,
					back_equals_front = true,
					draw_as_shadow = true,
					direction_count = 128,
					filenames = {
						"__base__/graphics/entity/cargo-wagon/cargo-wagon-shadow-1.png",
						"__base__/graphics/entity/cargo-wagon/cargo-wagon-shadow-2.png",
						"__base__/graphics/entity/cargo-wagon/cargo-wagon-shadow-3.png",
						"__base__/graphics/entity/cargo-wagon/cargo-wagon-shadow-4.png"
					},
					line_length = 4,
					lines_per_file = 8,
					shift = {0.8, -0.078125}
				}
			}
		},
		horizontal_doors = {
			layers = {
				{
					filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-door-horizontal-end.png",
					line_length = 1,
					width = 220,
					height = 33,
					frame_count = 8,
					shift = {0, -0.921875},
					tint = tint
				},
				{
					filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-door-horizontal-side.png",
					line_length = 1,
					width = 186,
					height = 38,
					frame_count = 8,
					shift = {0, -0.78125},
					tint = tint
				},
				{
					filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-door-horizontal-side-mask.png",
					width = 182,
					height = 35,
					line_length = 1,
					frame_count = 8,
					shift = {0, -0.828125},
					apply_runtime_tint = true
				},
				{
					filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-door-horizontal-top.png",
					line_length = 1,
					width = 184,
					height = 28,
					frame_count = 8,
					shift = {0.015625, -1.125}
				},
				{
					filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-door-horizontal-top-mask.png",
					width = 185,
					height = 23,
					frame_count = 8,
					line_length = 1,
					shift = {0.015625, -1.17188},
					apply_runtime_tint = true
				}
			}
		},
		vertical_doors = {
			layers = {
				{
					filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-door-vertical-end.png",
					line_length = 8,
					width = 30,
					height = 23,
					frame_count = 8,
					shift = util.by_pixel(0, 62.5),
					tint = tint
				},
				{
					filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-door-vertical-side.png",
					line_length = 8,
					width = 67,
					height = 169,
					frame_count = 8,
					shift = {0.015625, -1.01563},
					tint = tint
				},
				{
					filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-door-vertical-side-mask.png",
					line_length = 8,
					width = 56,
					height = 163,
					frame_count = 8,
					shift = {0, -1.10938},
					apply_runtime_tint = true
				},
				{
					filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-door-vertical-top.png",
					line_length = 8,
					width = 32,
					height = 168,
					frame_count = 8,
					shift = {0, -1.125}
				},
				{
					filename = "__base__/graphics/entity/cargo-wagon/cargo-wagon-door-vertical-top-mask.png",
					line_length = 8,
					width = 32,
					height = 166,
					frame_count = 8,
					shift = {0, -1.15625},
					apply_runtime_tint = true
				}
			}
		},
		wheels = standard_train_wheels,
		rail_category = "regular",
		drive_over_tie_trigger = drive_over_tie(),
		tie_distance = 50,
		working_sound = {
			sound = {
				filename = "__base__/sound/train-wheels.ogg",
				volume = 0.6
			},
			match_volume_to_activity = true
		},
		crash_trigger = crash_trigger(),
		open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.85},
		close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.75},
		sound_minimum_speed = 0.5,
		vehicle_impact_sound = {filename = "__base__/sound/car-wood-impact.ogg", volume = 1.0}
	}
end

-- Returns the charging offsets for the super roboport.
local function get_super_roboport_charging_offsets()
	local charging_offsets = {}
	for i = -1.5, 1.5, 0.2 do
		table.insert(charging_offsets, {i, -0.5})
	end
	for i = -0.5, 1.5, 0.2 do
		table.insert(charging_offsets, {1.5, i})
	end
	for i = 1.5, -1.5, -0.2 do
		table.insert(charging_offsets, {i, 1.5})
	end
	for i = 1.5, -0.5, -0.2 do
		table.insert(charging_offsets, {-1.5, i})
	end
	return charging_offsets
end

-- Generates data for super boiler according to the given data.
local function super_boiler(entity_name, item_name, icon_name, picture_name, additional_pastable_entities)
	circuit_connector_definitions[entity_name] =
		circuit_connector_definitions.create(
		universal_connector_template,
		{
			def_CC_table({-0.1875, -0.375}, nil, 7),
			def_CC_table({0.375, -0.53125}, nil, 1),
			def_CC_table({-0.1875, -0.375}, nil, 7),
			def_CC_table({0.375, -0.53125}, nil, 1)
		}
	)

	return {
		type = "storage-tank",
		name = entity_name,
		icon_size = 32,
		icon = creative_mode_defines.mod_directory .. "/graphics/icons/" .. icon_name,
		flags = {"placeable-player", "player-creation"},
		minable = {mining_time = 0.5, result = item_name},
		additional_pastable_entities = additional_pastable_entities,
		max_health = 100,
		corpse = "small-remnants",
		vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
		resistances = {
			{
				type = "fire",
				percent = 90
			},
			{
				type = "explosion",
				percent = 30
			},
			{
				type = "impact",
				percent = 30
			}
		},
		fast_replaceable_group = "pipe",
		collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		fluid_box = {
			base_area = 1,
			pipe_covers = pipecoverspictures(),
			pipe_connections = {
				{type = "input", position = {0, 1}},
				{type = "output", position = {0, -1}}
			},
			production_type = "input-output"
		},
		two_direction_only = false,
		window_bounding_box = {{0, 0}, {0, 0}},
		working_sound = {
			sound = {
				filename = "__base__/sound/boiler.ogg",
				volume = 0.8
			},
			max_sounds_per_type = 3
		},
		pictures = {
			picture = {
				sheet = {
					filename = creative_mode_defines.mod_directory .. "/graphics/entity/" .. picture_name,
					priority = "extra-high",
					frames = 4,
					width = 66,
					height = 72
				}
			},
			fluid_background = creative_mode_defines.empty_png.data,
			window_background = creative_mode_defines.empty_png.data,
			flow_sprite = creative_mode_defines.empty_png.data,
			gas_flow = creative_mode_defines.empty_animation
		},
		flow_length_in_ticks = 360,
		circuit_wire_connection_points = {
			{
				shadow = {
					red = {2.35938, 0.890625},
					green = {2.29688, 0.953125}
				},
				wire = {
					red = {-0.40625, -0.375},
					green = {-0.53125, -0.46875}
				}
			},
			{
				shadow = {
					red = {2.35938, 0.890625},
					green = {2.29688, 0.953125}
				},
				wire = {
					red = {0.46875, -0.53125},
					green = {0.375, -0.4375}
				}
			},
			{
				shadow = {
					red = {2.35938, 0.890625},
					green = {2.29688, 0.953125}
				},
				wire = {
					red = {-0.40625, -0.375},
					green = {-0.53125, -0.46875}
				}
			},
			{
				shadow = {
					red = {2.35938, 0.890625},
					green = {2.29688, 0.953125}
				},
				wire = {
					red = {0.46875, -0.53125},
					green = {0.375, -0.4375}
				}
			}
		},
		circuit_connector_sprites = circuit_connector_definitions[entity_name].sprites,
		circuit_wire_max_distance = 1000
	}
end

-- Generates data for heat pipe according to the given data.
local function heat_pipe(entity_name, item_name, tint, use_heated_pictures, max_temperature)
	local heat_pipe = table.deepcopy(data.raw["heat-pipe"]["heat-pipe"])
	heat_pipe.name = entity_name
	heat_pipe.icon_size = 32
	heat_pipe.icons = {
		{
			icon = heat_pipe.icon,
			tint = tint
		}
	}
	heat_pipe.icon = nil
	heat_pipe.flags = {"placeable-player", "player-creation"}
	heat_pipe.minable = {mining_time = 0.5, result = item_name}
	heat_pipe.heat_buffer.max_temperature = max_temperature
	for _, pictures in pairs(heat_pipe.connection_sprites) do
		for _, picture in ipairs(pictures) do
			-- Replace the normal heat pipe pictures by the hidden heated pictures?
			if use_heated_pictures then
				local filename = picture.filename
				-- There is no image for heated single pipe.
				if
					not filename:find("heat%-pipe%-straight%-horizontal%-single.png") and
						not filename:find("heat%-pipe%-straight%-vertical%-single.png")
				 then
					picture.filename = filename:gsub("heat%-pipe%-", "heated-")
				end
			end
			picture.tint = table.deepcopy(tint) -- Deep copy is needed or else it is nullified.
			local hr_version = picture.hr_version
			if hr_version then
				if use_heated_pictures then
					filename = hr_version.filename
					if
						not filename:find("hr%-heat%-pipe%-straight%-horizontal%-single.png") and
							not filename:find("hr%-heat%-pipe%-straight%-vertical%-single.png")
					 then
						hr_version.filename = filename:gsub("hr%-heat%-pipe%-", "hr-heated-")
					end
				end
				hr_version.tint = table.deepcopy(tint)
			end
		end
	end
	heat_pipe.fast_replaceable_group =
		heat_pipe.fast_replaceable_group or creative_mode_defines.names.fast_replaceable_groups.heat_source_void
	return heat_pipe
end

-- Generates data for inserter according to the given data.
local function inserter(
	entity_name,
	item_name,
	icon_name,
	platform_sheet_name,
	additional_pastable_entities,
	fast_replaceable_group,
	pickup_position,
	insert_position,
	filter_count)
	--circuit_connector_definitions[entity_name] = circuit_connector_definitions.create
	--(
	--  universal_connector_template,
	--  {
	--    def_CC_table({0, -0.125}, nil, 6),
	--  }
	--)

	return {
		type = "inserter",
		name = entity_name,
		icon_size = 32,
		icon = creative_mode_defines.mod_directory .. "/graphics/icons/" .. icon_name,
		flags = {"placeable-player", "player-creation"},
		minable = {mining_time = 0.5, result = item_name},
		max_health = 150,
		corpse = "small-remnants",
		additional_pastable_entities = additional_pastable_entities,
		fast_replaceable_group = fast_replaceable_group,
		collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
		selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
		open_sound = {filename = "__base__/sound/metallic-chest-open.ogg", volume = 0.65},
		close_sound = {filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.7},
		vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
		energy_per_movement = "1J",
		energy_per_rotation = "1J",
		energy_source = creative_mode_defines.non_electric_energy_source,
		pickup_position = pickup_position,
		insert_position = insert_position,
		extension_speed = 0,
		rotation_speed = 0,
		filter_count = filter_count,
		platform_picture = {
			sheet = {
				filename = creative_mode_defines.mod_directory .. "/graphics/entity/" .. platform_sheet_name,
				priority = "extra-high",
				width = 79,
				height = 63,
				shift = {0.140625, 0.140625}
			}
		},
		hand_base_picture = creative_mode_defines.empty_png.data,
		hand_closed_picture = creative_mode_defines.empty_png.data,
		hand_open_picture = creative_mode_defines.empty_png.data,
		hand_base_shadow = creative_mode_defines.empty_png.data,
		hand_closed_shadow = creative_mode_defines.empty_png.data,
		hand_open_shadow = creative_mode_defines.empty_png.data,
		circuit_wire_connection_point = {
			shadow = {
				red = {0.890625, 0.390625},
				green = {0.890625, 0.265625}
			},
			wire = {
				red = {-0.28125, -0.25},
				green = {-0.28125, -0.375}
			}
		},
		circuit_connector_sprites = circuit_connector_definitions["inserter"].sprites,
		circuit_wire_max_distance = 1000
	}
end

-- Generates data for lab.
local function lab(entity_name, item_name, icon_name, on_animation_filename, off_animation_filename)
	local lab = table.deepcopy(data.raw["lab"]["lab"])
	lab.name = entity_name
	lab.icon_size = 32
	lab.icon_mipmaps = 1
	lab.icon = creative_mode_defines.mod_directory .. "/graphics/icons/" .. icon_name
	lab.minable = {mining_time = 0.5, result = item_name}
	lab.on_animation.filename = creative_mode_defines.mod_directory .. "/graphics/entity/" .. on_animation_filename
	lab.off_animation.filename = creative_mode_defines.mod_directory .. "/graphics/entity/" .. off_animation_filename
	lab.energy_source = creative_mode_defines.non_electric_energy_source
	lab.module_specification.module_slots = 7
	return lab
end

-- Generates data for electric energy interface.
local function electric_energy_interface(
	entity_name,
	item_name,
	icon_name,
	animation_filename,
	usage_priority,
	default_input_flow,
	default_output_flow,
	default_production,
	default_usage,
	additional_pastable_entities)
	return {
		type = "electric-energy-interface",
		name = entity_name,
		icon_size = 32,
		icon = creative_mode_defines.mod_directory .. "/graphics/icons/" .. icon_name,
		flags = {"placeable-player", "player-creation"},
		minable = {mining_time = 0.5, result = item_name},
		max_health = 200,
		corpse = "big-remnants",
		collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
		selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
		enable_gui = true,
		allow_copy_paste = true,
		energy_source = {
			type = "electric",
			buffer_capacity = "10GJ",
			usage_priority = usage_priority,
			input_flow_limit = default_input_flow,
			output_flow_limit = default_output_flow
		},
		energy_production = default_production,
		energy_usage = default_usage,
		animation = {
			filename = creative_mode_defines.mod_directory .. "/graphics/entity/" .. animation_filename,
			width = 176,
			height = 186,
			frame_count = 32,
			line_length = 6,
			shift = {1.2, 0.5},
			animation_speed = 1 / 3
		},
		vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
		working_sound = {
			sound = {
				filename = "__base__/sound/accumulator-working.ogg",
				volume = 1
			},
			idle_sound = {
				filename = "__base__/sound/accumulator-idle.ogg",
				volume = 0.4
			},
			max_sounds_per_type = 5
		},
		additional_pastable_entities = additional_pastable_entities,
		fast_replaceable_group = creative_mode_defines.names.fast_replaceable_groups.electric_energy_interface
	}
end

-- Generates data for the smoke of magic wands.
local function magic_wand_smoke(entity_name, color)
	return {
		affected_by_wind = false,
		animation = {
			animation_speed = 60 / 40,
			axially_symmetrical = false,
			direction_count = 1,
			filename = "__base__/graphics/entity/smoke/smoke.png",
			flags = {
				"smoke"
			},
			frame_count = 60,
			height = 120,
			line_length = 5,
			priority = "high",
			shift = {
				-0.53125,
				-0.4375
			},
			width = 152
		},
		color = color,
		cyclic = true,
		duration = 40,
		end_scale = 3.0,
		fade_away_duration = 40,
		fade_in_duration = 0,
		flags = {
			"not-on-map"
		},
		name = entity_name,
		spread_duration = 40,
		start_scale = 0.5,
		type = "trivial-smoke"
	}
end

-- Generates data for radar.
local function radar(entity_name, item_name, icon_name, pictures_name, scan_distance)
	return {
		type = "radar",
		name = entity_name,
		icon_size = 32,
		icon = creative_mode_defines.mod_directory .. "/graphics/icons/" .. icon_name,
		flags = {"placeable-player", "player-creation"},
		minable = {mining_time = 0.5, result = item_name},
		max_health = 150,
		corpse = "big-remnants",
		resistances = {
			{
				type = "fire",
				percent = 70
			}
		},
		collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
		selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
		energy_per_sector = "1MJ", -- Make the frequency of scanning each sector to be very low.
		max_distance_of_sector_revealed = scan_distance, -- Scan area
		max_distance_of_nearby_sector_revealed = scan_distance, -- Always revealed area
		energy_per_nearby_scan = "1kJ",
		--energy_source = creative_mode_defines.non_electric_energy_source, -- Burner energy won't work on radar, regardless of fuel_inventory_size.
		energy_source = {
			type = "electric",
			usage_priority = "tertiary"
		},
		energy_usage = "1kW",
		pictures = {
			filename = creative_mode_defines.mod_directory .. "/graphics/entity/" .. pictures_name,
			priority = "low",
			width = 153,
			height = 131,
			apply_projection = false,
			direction_count = 64,
			line_length = 8,
			shift = {0.875, -0.34375}
		},
		vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
		working_sound = {
			sound = {
				{
					filename = "__base__/sound/radar.ogg"
				}
			},
			apparent_volume = 2
		}
	}
end

-- Generates data for the alien attractor proxy.
local function alien_attractor_proxy(entity_name, mark_scale)
	return {
		type = "smoke-with-trigger",
		name = entity_name,
		flags = {"not-on-map", "placeable-off-grid", "not-blueprintable", "not-deconstructable"},
		show_when_smoke_off = true,
		animation = {
			filename = "__core__/graphics/shoot-cursor-red.png",
			priority = "low",
			width = 258,
			height = 183,
			frame_count = 1,
			animation_speed = 1,
			line_length = 1,
			shift = {0, 1},
			scale = mark_scale
		},
		movement_slow_down_factor = 0,
		affected_by_wind = false,
		cyclic = true,
		duration = 60 * 3,
		fade_away_duration = 60 * 3,
		spread_duration = 0,
		color = {r = 1, g = 1, b = 1}
	}
end

circuit_connector_definitions[creative_mode_defines.names.entities.super_roboport] =
	circuit_connector_definitions.create(
	universal_connector_template,
	{
		def_CC_table({0.59375, 1.3125}, nil, 18)
	}
)

circuit_connector_definitions[creative_mode_defines.names.entities.fluid_void] =
	circuit_connector_definitions.create(
	universal_connector_template,
	{
		def_CC_table({-0.1875, -0.375}, nil, 7),
		def_CC_table({0.375, -0.53125}, nil, 1),
		def_CC_table({-0.1875, -0.375}, nil, 7),
		def_CC_table({0.375, -0.53125}, nil, 1)
	}
)

circuit_connector_definitions[creative_mode_defines.names.entities.passive_energy_source] =
	circuit_connector_definitions.create(
	universal_connector_template,
	{
		def_CC_table({0.46875, 0.5}, {0.46875, 0.8125}, 26)
	}
)

circuit_connector_definitions[creative_mode_defines.names.entities.passive_energy_void] =
	circuit_connector_definitions.create(
	universal_connector_template,
	{
		def_CC_table({0.46875, 0.5}, {0.46875, 0.8125}, 26)
	}
)

data:extend(
	{
		-- Creative chest
		container(
			creative_mode_defines.names.entities.creative_chest,
			creative_mode_defines.names.items.creative_chest,
			"creative-chest.png",
			"creative-chest.png",
			{creative_mode_defines.names.entities.creative_provider_chest},
			settings.startup[creative_mode_defines.names.settings.creative_chest_size].value + 1
		),
		-- Creative provider chest
		logistic_container(
			creative_mode_defines.names.entities.creative_provider_chest,
			creative_mode_defines.names.items.creative_provider_chest,
			"creative-provider-chest.png",
			"creative-provider-chest.png",
			{creative_mode_defines.names.entities.creative_chest},
			settings.startup[creative_mode_defines.names.settings.creative_chest_size].value + 1,
			"passive-provider"
		),
		-- Autofill requester chest
		logistic_container(
			creative_mode_defines.names.entities.autofill_requester_chest,
			creative_mode_defines.names.items.autofill_requester_chest,
			"autofill-requester-chest.png",
			"autofill-requester-chest.png",
			nil,
			settings.startup[creative_mode_defines.names.settings.autofill_requester_chest_size].value,
			"requester"
		),
		-- Duplicating chest
		container(
			creative_mode_defines.names.entities.duplicating_chest,
			creative_mode_defines.names.items.duplicating_chest,
			"duplicating-chest.png",
			"duplicating-chest.png",
			{
				creative_mode_defines.names.entities.duplicating_provider_chest,
				creative_mode_defines.names.entities.duplicating_cargo_wagon
			},
			settings.startup[creative_mode_defines.names.settings.duplicating_chest_size].value
		),
		-- Duplicating provider chest
		logistic_container(
			creative_mode_defines.names.entities.duplicating_provider_chest,
			creative_mode_defines.names.items.duplicating_provider_chest,
			"duplicating-provider-chest.png",
			"duplicating-provider-chest.png",
			{
				creative_mode_defines.names.entities.duplicating_chest,
				creative_mode_defines.names.entities.duplicating_cargo_wagon
			},
			settings.startup[creative_mode_defines.names.settings.duplicating_chest_size].value,
			"passive-provider"
		),
		-- Void requester chest
		logistic_container(
			creative_mode_defines.names.entities.void_requester_chest,
			creative_mode_defines.names.items.void_requester_chest,
			"void-requester-chest.png",
			"void-requester-chest.png",
			nil,
			settings.startup[creative_mode_defines.names.settings.void_requester_chest_size].value,
			"requester"
		),
		-- Void chest
		container(
			creative_mode_defines.names.entities.void_chest,
			creative_mode_defines.names.items.void_chest,
			"void-chest.png",
			"void-chest.png",
			nil,
			settings.startup[creative_mode_defines.names.settings.void_chest_size].value
		),
		-- Void storage chest
		logistic_container(
			creative_mode_defines.names.entities.void_storage_chest,
			creative_mode_defines.names.items.void_storage_chest,
			"void-storage-chest.png",
			"void-storage-chest.png",
			nil,
			settings.startup[creative_mode_defines.names.settings.void_storage_chest_size].value,
			"storage"
		),
		-- Super loader
		{
			type = "loader",
			name = creative_mode_defines.names.entities.super_loader,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-loader.png",
			flags = {"placeable-player", "player-creation", "fast-replaceable-no-build-while-moving"},
			minable = {mining_time = 0.5, result = creative_mode_defines.names.items.super_loader},
			max_health = 70,
			filter_count = 5,
			corpse = "small-remnants",
			resistances = {
				{
					type = "fire",
					percent = 60
				}
			},
			collision_box = {{-0.4, -0.9}, {0.4, 0.9}},
			selection_box = {{-0.5, -1}, {0.5, 1}},
			animation_speed_coefficient = 32,
			belt_animation_set = basic_belt_animation_set,
			fast_replaceable_group = "loader",
			speed = 1,
			structure = {
				direction_in = {
					sheet = {
						filename = creative_mode_defines.mod_directory .. "/graphics/entity/super-loader-structure.png",
						priority = "extra-high",
						width = 64,
						height = 64
					}
				},
				direction_out = {
					sheet = {
						filename = creative_mode_defines.mod_directory .. "/graphics/entity/super-loader-structure.png",
						priority = "extra-high",
						width = 64,
						height = 64,
						y = 64
					}
				}
			},
			ending_patch = ending_patch_prototype
		},
		-----------------------------------------------------------------------------

		-- Creative cargo wagon
		cargo_wagon(
			creative_mode_defines.names.entities.creative_cargo_wagon,
			creative_mode_defines.names.items.creative_cargo_wagon,
			{r = 1, g = 0.3, b = 0.3}, -- Because the cargo wagon images are too large, we only use tint here to reduce the overall mod size.
			nil,
			settings.startup[creative_mode_defines.names.settings.creative_cargo_wagon_size].value + 1
		),
		-- Duplicating cargo wagon
		cargo_wagon(
			creative_mode_defines.names.entities.duplicating_cargo_wagon,
			creative_mode_defines.names.items.duplicating_cargo_wagon,
			{r = 0.35, g = 0.3, b = 1},
			{
				creative_mode_defines.names.entities.duplicating_chest,
				creative_mode_defines.names.entities.duplicating_provider_chest
			},
			settings.startup[creative_mode_defines.names.settings.duplicating_cargo_wagon_size].value
		),
		-- Void cargo wagon
		cargo_wagon(
			creative_mode_defines.names.entities.void_cargo_wagon,
			creative_mode_defines.names.items.void_cargo_wagon,
			{r = 0.4, g = 0.4, b = 0.4},
			nil,
			settings.startup[creative_mode_defines.names.settings.void_cargo_wagon_size].value
		),
		-- Super logistic robot.
		{
			type = "logistic-robot",
			name = creative_mode_defines.names.entities.super_logistic_robot,
			icon_size = 32,
			icons = {
				{
					icon = "__base__/graphics/icons/logistic-robot.png",
					tint = {r = 1, g = 0.3, b = 0.3}
				}
			},
			flags = {"placeable-player", "player-creation", "placeable-off-grid", "not-on-map"},
			minable = {hardness = 0.1, mining_time = 0.1, result = creative_mode_defines.names.items.super_logistic_robot},
			resistances = {},
			max_health = 100,
			collision_box = {{0, 0}, {0, 0}},
			selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
			max_payload_size = 1000,
			speed = 100,
			transfer_distance = 0.5,
			max_energy = "0kJ",
			energy_per_tick = "0kJ",
			speed_multiplier_when_out_of_energy = 1,
			energy_per_move = "0kJ",
			min_to_charge = 0,
			max_to_charge = 0,
			idle = {
				filename = "__base__/graphics/entity/logistic-robot/logistic-robot.png",
				priority = "high",
				line_length = 16,
				width = 41,
				height = 42,
				frame_count = 1,
				shift = util.by_pixel(0, -3),
				direction_count = 16,
				y = 42,
				tint = {r = 1, g = 0.3, b = 0.3}
			},
			idle_with_cargo = {
				filename = "__base__/graphics/entity/logistic-robot/logistic-robot.png",
				priority = "high",
				line_length = 16,
				width = 41,
				height = 42,
				frame_count = 1,
				shift = util.by_pixel(0, -3),
				direction_count = 16,
				tint = {r = 1, g = 0.3, b = 0.3}
			},
			in_motion = {
				filename = "__base__/graphics/entity/logistic-robot/logistic-robot.png",
				priority = "high",
				line_length = 16,
				width = 41,
				height = 42,
				frame_count = 1,
				shift = util.by_pixel(0, -3),
				direction_count = 16,
				y = 126,
				tint = {r = 1, g = 0.3, b = 0.3}
			},
			in_motion_with_cargo = {
				filename = "__base__/graphics/entity/logistic-robot/logistic-robot.png",
				priority = "high",
				line_length = 16,
				width = 41,
				height = 42,
				frame_count = 1,
				shift = util.by_pixel(0, -3),
				direction_count = 16,
				y = 84,
				tint = {r = 1, g = 0.3, b = 0.3}
			},
			shadow_idle = {
				filename = "__base__/graphics/entity/logistic-robot/logistic-robot-shadow.png",
				priority = "high",
				line_length = 16,
				width = 58,
				height = 29,
				frame_count = 1,
				shift = util.by_pixel(32, 19.5),
				direction_count = 16,
				y = 29,
				draw_as_shadow = true
			},
			shadow_idle_with_cargo = {
				filename = "__base__/graphics/entity/logistic-robot/logistic-robot-shadow.png",
				priority = "high",
				line_length = 16,
				width = 58,
				height = 29,
				frame_count = 1,
				shift = util.by_pixel(32, 19.5),
				direction_count = 16,
				draw_as_shadow = true
			},
			shadow_in_motion = {
				filename = "__base__/graphics/entity/logistic-robot/logistic-robot-shadow.png",
				priority = "high",
				line_length = 16,
				width = 58,
				height = 29,
				frame_count = 1,
				shift = util.by_pixel(32, 19.5),
				direction_count = 16,
				y = 29,
				draw_as_shadow = true
			},
			shadow_in_motion_with_cargo = {
				filename = "__base__/graphics/entity/logistic-robot/logistic-robot-shadow.png",
				priority = "high",
				line_length = 16,
				width = 58,
				height = 29,
				frame_count = 1,
				shift = util.by_pixel(32, 19.5),
				direction_count = 16,
				draw_as_shadow = true
			},
			working_sound = flying_robot(0.5),
			cargo_centered = {0.0, 0.2}
		},
		-- Super construction robot.
		{
			type = "construction-robot",
			name = creative_mode_defines.names.entities.super_construction_robot,
			icon_size = 32,
			icons = {
				{
					icon = "__base__/graphics/icons/construction-robot.png",
					tint = {r = 0.3, g = 0.3, b = 1}
				}
			},
			flags = {"placeable-player", "player-creation", "placeable-off-grid", "not-on-map"},
			minable = {hardness = 0.1, mining_time = 0.1, result = creative_mode_defines.names.items.super_construction_robot},
			resistances = {},
			max_health = 100,
			collision_box = {{0, 0}, {0, 0}},
			selection_box = {{-0.5, -1.5}, {0.5, -0.5}},
			max_payload_size = 1,
			speed = 100,
			transfer_distance = 0.5,
			max_energy = "0kJ",
			energy_per_tick = "0kJ",
			speed_multiplier_when_out_of_energy = 1,
			energy_per_move = "0kJ",
			min_to_charge = 0,
			max_to_charge = 0,
			working_light = {intensity = 0.8, size = 3},
			idle = {
				filename = "__base__/graphics/entity/construction-robot/construction-robot.png",
				priority = "high",
				line_length = 16,
				width = 32,
				height = 36,
				frame_count = 1,
				shift = {0, -0.15625},
				direction_count = 16,
				tint = {r = 0.3, g = 0.3, b = 1}
			},
			in_motion = {
				filename = "__base__/graphics/entity/construction-robot/construction-robot.png",
				priority = "high",
				line_length = 16,
				width = 32,
				height = 36,
				frame_count = 1,
				shift = {0, -0.15625},
				direction_count = 16,
				y = 36,
				tint = {r = 0.3, g = 0.3, b = 1}
			},
			shadow_idle = {
				filename = "__base__/graphics/entity/construction-robot/construction-robot-shadow.png",
				priority = "high",
				line_length = 16,
				width = 50,
				height = 24,
				frame_count = 1,
				shift = {1.09375, 0.59375},
				direction_count = 16
			},
			shadow_in_motion = {
				filename = "__base__/graphics/entity/construction-robot/construction-robot-shadow.png",
				priority = "high",
				line_length = 16,
				width = 50,
				height = 24,
				frame_count = 1,
				shift = {1.09375, 0.59375},
				direction_count = 16
			},
			working = {
				filename = "__base__/graphics/entity/construction-robot/construction-robot-working.png",
				priority = "high",
				line_length = 2,
				width = 28,
				height = 36,
				frame_count = 2,
				shift = {0, -0.15625},
				direction_count = 16,
				animation_speed = 0.3,
				tint = {r = 0.3, g = 0.3, b = 1}
			},
			shadow_working = {
				stripes = util.multiplystripes(
					2,
					{
						{
							filename = "__base__/graphics/entity/construction-robot/construction-robot-shadow.png",
							width_in_frames = 16,
							height_in_frames = 1
						}
					}
				),
				priority = "high",
				width = 50,
				height = 24,
				frame_count = 2,
				shift = {1.09375, 0.59375},
				direction_count = 16
			},
			smoke = {
				filename = "__base__/graphics/entity/smoke-construction/smoke-01.png",
				width = 39,
				height = 32,
				frame_count = 19,
				line_length = 19,
				shift = {0.078125, -0.15625},
				animation_speed = 0.3
			},
			sparks = {
				{
					filename = "__base__/graphics/entity/sparks/sparks-01.png",
					width = 39,
					height = 34,
					frame_count = 19,
					line_length = 19,
					shift = {-0.109375, 0.3125},
					tint = {r = 1.0, g = 0.9, b = 0.0, a = 1.0},
					animation_speed = 0.3
				},
				{
					filename = "__base__/graphics/entity/sparks/sparks-02.png",
					width = 36,
					height = 32,
					frame_count = 19,
					line_length = 19,
					shift = {0.03125, 0.125},
					tint = {r = 1.0, g = 0.9, b = 0.0, a = 1.0},
					animation_speed = 0.3
				},
				{
					filename = "__base__/graphics/entity/sparks/sparks-03.png",
					width = 42,
					height = 29,
					frame_count = 19,
					line_length = 19,
					shift = {-0.0625, 0.203125},
					tint = {r = 1.0, g = 0.9, b = 0.0, a = 1.0},
					animation_speed = 0.3
				},
				{
					filename = "__base__/graphics/entity/sparks/sparks-04.png",
					width = 40,
					height = 35,
					frame_count = 19,
					line_length = 19,
					shift = {-0.0625, 0.234375},
					tint = {r = 1.0, g = 0.9, b = 0.0, a = 1.0},
					animation_speed = 0.3
				},
				{
					filename = "__base__/graphics/entity/sparks/sparks-05.png",
					width = 39,
					height = 29,
					frame_count = 19,
					line_length = 19,
					shift = {-0.109375, 0.171875},
					tint = {r = 1.0, g = 0.9, b = 0.0, a = 1.0},
					animation_speed = 0.3
				},
				{
					filename = "__base__/graphics/entity/sparks/sparks-06.png",
					width = 44,
					height = 36,
					frame_count = 19,
					line_length = 19,
					shift = {0.03125, 0.3125},
					tint = {r = 1.0, g = 0.9, b = 0.0, a = 1.0},
					animation_speed = 0.3
				}
			},
			working_sound = construction_robot(0.5),
			cargo_centered = {0.0, 0.2},
			construction_vector = {0.30, 0.22}
		},
		-- Super roboport.
		{
			type = "roboport",
			name = creative_mode_defines.names.entities.super_roboport,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-roboport.png",
			flags = {"placeable-player", "player-creation"},
			minable = {mining_time = 0.5, result = creative_mode_defines.names.items.super_roboport},
			max_health = 500,
			corpse = "big-remnants",
			collision_box = {{-1.7, -1.7}, {1.7, 1.7}},
			selection_box = {{-2, -2}, {2, 2}},
			dying_explosion = "medium-explosion",
			energy_source = {
				type = "electric", -- Changing this to burner has no effect.
				usage_priority = "secondary-input",
				input_flow_limit = "0MW",
				buffer_capacity = "100PJ"
			},
			recharge_minimum = "40MJ",
			energy_usage = "1W",
			-- per one charge slot
			charging_energy = "1000MW",
			logistics_radius = 100,
			construction_radius = 200,
			charge_approach_distance = 5,
			robot_slots_count = 7,
			material_slots_count = 7,
			stationing_offset = {0, 0},
			charging_offsets = get_super_roboport_charging_offsets(),
			base = {
				filename = "__base__/graphics/entity/roboport/roboport-base.png",
				width = 143,
				height = 135,
				shift = {0.5, 0.25},
				tint = {r = 0.7, g = 0.3, b = 1}
			},
			base_patch = {
				filename = "__base__/graphics/entity/roboport/roboport-base-patch.png",
				priority = "medium",
				width = 69,
				height = 50,
				frame_count = 1,
				shift = {0.03125, 0.203125},
				tint = {r = 0.7, g = 0.3, b = 1}
			},
			base_animation = {
				filename = "__base__/graphics/entity/roboport/roboport-base-animation.png",
				priority = "medium",
				width = 42,
				height = 31,
				frame_count = 8,
				animation_speed = 0.5,
				shift = {-0.5315, -1.9375},
				tint = {r = 0.7, g = 0.3, b = 1}
			},
			door_animation_up = {
				filename = "__base__/graphics/entity/roboport/roboport-door-up.png",
				priority = "medium",
				width = 52,
				height = 20,
				frame_count = 16,
				shift = {0.015625, -0.890625},
				tint = {r = 0.7, g = 0.3, b = 1}
			},
			door_animation_down = {
				filename = "__base__/graphics/entity/roboport/roboport-door-down.png",
				priority = "medium",
				width = 52,
				height = 22,
				frame_count = 16,
				shift = {0.015625, -0.234375},
				tint = {r = 0.7, g = 0.3, b = 1}
			},
			recharging_animation = {
				filename = "__base__/graphics/entity/roboport/roboport-recharging.png",
				priority = "high",
				width = 37,
				height = 35,
				frame_count = 16,
				scale = 1.5,
				animation_speed = 0.5
			},
			vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
			working_sound = {
				sound = {filename = "__base__/sound/roboport-working.ogg", volume = 0.6},
				max_sounds_per_type = 3,
				audible_distance_modifier = 0.5,
				probability = 1 / (5 * 60) -- average pause between the sound is 5 seconds
			},
			recharging_light = {intensity = 0.4, size = 5},
			request_to_open_door_timeout = 15,
			spawn_and_station_height = -0.1,
			draw_logistic_radius_visualization = true,
			draw_construction_radius_visualization = true,
			open_door_trigger_effect = {
				{
					type = "play-sound",
					sound = {filename = "__base__/sound/roboport-door.ogg", volume = 1.2}
				}
			},
			close_door_trigger_effect = {
				{
					type = "play-sound",
					sound = {filename = "__base__/sound/roboport-door.ogg", volume = 0.75}
				}
			},
			circuit_wire_connection_point = {
				shadow = {
					red = {1.17188, 1.98438},
					green = {1.04688, 2.04688}
				},
				wire = {
					red = {0.78125, 1.375},
					green = {0.78125, 1.53125}
				}
			},
			circuit_connector_sprites = circuit_connector_definitions[creative_mode_defines.names.entities.super_roboport].sprites,
			circuit_wire_max_distance = 1000,
			default_available_logistic_output_signal = {type = "virtual", name = "signal-X"},
			default_total_logistic_output_signal = {type = "virtual", name = "signal-Y"},
			default_available_construction_output_signal = {type = "virtual", name = "signal-Z"},
			default_total_construction_output_signal = {type = "virtual", name = "signal-T"}
		},
		-----------------------------------------------------------------------------

		-- Fluid source
		{
			type = "assembling-machine",
			name = creative_mode_defines.names.entities.fluid_source,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/fluid-source.png",
			flags = {"placeable-player", "player-creation"},
			minable = {mining_time = 0.5, result = creative_mode_defines.names.items.fluid_source},
			max_health = 150,
			corpse = "small-remnants",
			fast_replaceable_group = creative_mode_defines.names.fast_replaceable_groups.fluid_source_void,
			collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
			selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
			vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
			fluid_boxes = {
				{
					production_type = "output",
					pipe_covers = pipecoverspictures(),
					base_area = 10,
					base_level = 1,
					pipe_connections = {{type = "output", position = {0, -1}}}
				}
			},
			animation = {
				north = {
					filename = creative_mode_defines.mod_directory .. "/graphics/entity/fluid-source-up.png",
					width = 46,
					height = 56,
					frame_count = 8,
					shift = {0.09375, 0.03125},
					animation_speed = 0.5
				},
				east = {
					filename = creative_mode_defines.mod_directory .. "/graphics/entity/fluid-source-right.png",
					width = 51 + 6,
					height = 56,
					frame_count = 8,
					shift = {0.265625 - 6 / 2 / 32, -0.21875},
					animation_speed = 0.5
				},
				south = {
					filename = creative_mode_defines.mod_directory .. "/graphics/entity/fluid-source-down.png",
					width = 61,
					height = 58,
					frame_count = 8,
					shift = {0.421875, -0.125},
					animation_speed = 0.5
				},
				west = {
					filename = creative_mode_defines.mod_directory .. "/graphics/entity/fluid-source-left.png",
					width = 56,
					height = 44,
					frame_count = 8,
					shift = {0.3125, 0.0625},
					animation_speed = 0.5
				}
			},
			energy_source = creative_mode_defines.non_electric_energy_source,
			energy_usage = "1W", -- Need to be at least 1W or the no energy signal will keep blinking
			crafting_speed = 1,
			ingredient_count = 0,
			crafting_categories = {creative_mode_defines.names.recipe_categories.free_fluids},
			module_specification = {module_slots = 0},
			allowed_effects = {"pollution"}
		},
		-- Fluid void
		{
			type = "storage-tank",
			name = creative_mode_defines.names.entities.fluid_void,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/fluid-void.png",
			flags = {"placeable-player", "player-creation"},
			minable = {mining_time = 0.5, result = creative_mode_defines.names.items.fluid_void},
			max_health = 150,
			corpse = "small-remnants",
			resistances = {
				{
					type = "fire",
					percent = 80
				},
				{
					type = "impact",
					percent = 40
				}
			},
			fast_replaceable_group = creative_mode_defines.names.fast_replaceable_groups.fluid_source_void,
			collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
			selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
			vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
			fluid_box = {
				base_area = 10000,
				base_level = -1,
				pipe_covers = pipecoverspictures(),
				pipe_connections = {
					{type = "input", position = {0, 1}}
				},
				production_type = "input"
			},
			two_direction_only = false,
			window_bounding_box = {{0, 0}, {0, 0}},
			working_sound = {
				sound = {
					filename = "__base__/sound/boiler.ogg",
					volume = 0
				},
				max_sounds_per_type = 3
			},
			pictures = {
				picture = {
					sheet = {
						filename = creative_mode_defines.mod_directory .. "/graphics/entity/fluid-void.png",
						priority = "extra-high",
						frames = 4,
						width = 76,
						height = 70
					}
				},
				fluid_background = creative_mode_defines.empty_png.data,
				window_background = creative_mode_defines.empty_png.data,
				flow_sprite = creative_mode_defines.empty_png.data,
				gas_flow = creative_mode_defines.empty_animation
			},
			flow_length_in_ticks = 10000,
			circuit_wire_connection_points = {
				{
					shadow = {
						red = {2.35938, 0.890625},
						green = {2.29688, 0.953125}
					},
					wire = {
						red = {-0.40625, -0.375},
						green = {-0.53125, -0.46875}
					}
				},
				{
					shadow = {
						red = {2.35938, 0.890625},
						green = {2.29688, 0.953125}
					},
					wire = {
						red = {0.46875, -0.53125},
						green = {0.375, -0.4375}
					}
				},
				{
					shadow = {
						red = {2.35938, 0.890625},
						green = {2.29688, 0.953125}
					},
					wire = {
						red = {-0.40625, -0.375},
						green = {-0.53125, -0.46875}
					}
				},
				{
					shadow = {
						red = {2.35938, 0.890625},
						green = {2.29688, 0.953125}
					},
					wire = {
						red = {0.46875, -0.53125},
						green = {0.375, -0.4375}
					}
				}
			},
			circuit_connector_sprites = circuit_connector_definitions[creative_mode_defines.names.entities.fluid_void].sprites,
			circuit_wire_max_distance = 1000
		},
		-- Super boiler
		super_boiler(
			creative_mode_defines.names.entities.super_boiler,
			creative_mode_defines.names.items.super_boiler,
			"super-boiler.png",
			"super-boiler.png",
			nil
		),
		-- Super cooler
		super_boiler(
			creative_mode_defines.names.entities.super_cooler,
			creative_mode_defines.names.items.super_cooler,
			"super-cooler.png",
			"super-cooler.png",
			nil
		),
		-- Configurable super boiler
		super_boiler(
			creative_mode_defines.names.entities.configurable_super_boiler,
			creative_mode_defines.names.items.configurable_super_boiler,
			"configurable-super-boiler.png",
			"configurable-super-boiler.png",
			{creative_mode_defines.names.entities.configurable_super_boiler}
		), -- This is needed because boiler does not support copy-and-paste by default.
		-- Heat source
		heat_pipe(
			creative_mode_defines.names.entities.heat_source,
			creative_mode_defines.names.items.heat_source,
			{r = 1, g = 0.3, b = 0.3},
			true,
			1000
		),
		-- Heat void
		heat_pipe(
			creative_mode_defines.names.entities.heat_void,
			creative_mode_defines.names.items.heat_void,
			{r = 0.2, g = 0.2, b = 0.2},
			false,
			1000
		),
		-----------------------------------------------------------------------------

		-- Matter source
		inserter(
			creative_mode_defines.names.entities.item_source,
			creative_mode_defines.names.items.item_source,
			"item-source.png",
			"item-source.png",
			nil,
			creative_mode_defines.names.fast_replaceable_groups.item_source_void_duplicator,
			{0, 0.8},
			{0, 1},
			2
		),
		-- Matter duplicator
		inserter(
			creative_mode_defines.names.entities.duplicator,
			creative_mode_defines.names.items.duplicator,
			"duplicator.png",
			"duplicator.png",
			nil,
			creative_mode_defines.names.fast_replaceable_groups.item_source_void_duplicator,
			{0, 0.8},
			{0, 1},
			1
		),
		-- Matter void
		inserter(
			creative_mode_defines.names.entities.item_void,
			creative_mode_defines.names.items.item_void,
			"item-void.png",
			"item-void.png",
			nil,
			creative_mode_defines.names.fast_replaceable_groups.item_source_void_duplicator,
			{0, -1},
			{0, -0.9},
			1
		),
		-- Random item source
		inserter(
			creative_mode_defines.names.entities.random_item_source,
			creative_mode_defines.names.items.random_item_source,
			"random-item-source.png",
			"random-item-source.png",
			nil,
			creative_mode_defines.names.fast_replaceable_groups.item_source_void_duplicator,
			{0, 0.8},
			{0, 1},
			0
		),
		-- Creative lab
		lab(
			creative_mode_defines.names.entities.creative_lab,
			creative_mode_defines.names.items.creative_lab,
			"creative-lab.png",
			"creative-lab.png",
			"creative-lab.png"
		),
		-----------------------------------------------------------------------------

		-- Active electric energy interface (output)
		electric_energy_interface(
			creative_mode_defines.names.entities.active_electric_energy_interface_output,
			creative_mode_defines.names.items.active_electric_energy_interface_output,
			"active-electric-energy-interface-output.png",
			"active-electric-energy-interface-output.png",
			"primary-output",
			"0kW", -- Default input flow
			"500GW", -- Default output flow
			"500GW", -- Default production
			"0kW", -- Default usage
			{
				creative_mode_defines.names.entities.passive_electric_energy_interface,
				creative_mode_defines.names.entities.active_electric_energy_interface_input
			}
		),
		-- Passive electric energy interface
		electric_energy_interface(
			creative_mode_defines.names.entities.passive_electric_energy_interface,
			creative_mode_defines.names.items.passive_electric_energy_interface,
			"passive-electric-energy-interface.png",
			"passive-electric-energy-interface.png",
			"tertiary",
			"500GW",
			"0kW",
			"0kW",
			"500GW",
			{
				creative_mode_defines.names.entities.active_electric_energy_interface_output,
				creative_mode_defines.names.entities.active_electric_energy_interface_input
			}
		),
		-- Active electric energy interface (input)
		electric_energy_interface(
			creative_mode_defines.names.entities.active_electric_energy_interface_input,
			creative_mode_defines.names.items.active_electric_energy_interface_input,
			"active-electric-energy-interface-input.png",
			"active-electric-energy-interface-input.png",
			"primary-input",
			"500GW",
			"0kW",
			"0kW",
			"500GW",
			{
				creative_mode_defines.names.entities.active_electric_energy_interface_output,
				creative_mode_defines.names.entities.passive_electric_energy_interface
			}
		),
		-- Active energy source
		{
			type = "generator",
			enable_gui = true,
			name = creative_mode_defines.names.entities.energy_source,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/energy-source.png",
			flags = {"placeable-player", "player-creation"},
			minable = {mining_time = 0.5, result = creative_mode_defines.names.items.energy_source},
			max_health = 150,
			corpse = "medium-remnants",
			fast_replaceable_group = creative_mode_defines.names.fast_replaceable_groups.energy_source_void,
			collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
			selection_box = {{-1, -1}, {1, 1}},
			vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
			effectivity = 1,
			fluid_usage_per_tick = 1000000000, -- This value affects the maximum energy output. Currently it is 5.4PW (GUI shows 5.1PW)
			maximum_temperature = 500,
			fluid_box = {
				base_area = 1,
				filter = "water",
				pipe_connections = {}
			},
			fluid_input = {
				name = "water",
				amount = 0.0,
				minimum_temperature = 0
			},
			energy_source = {
				type = "electric",
				usage_priority = "primary-output"
			},
			min_perceived_performance = 1,
			performance_to_sound_speedup = 0.5,
			horizontal_animation = {
				filename = creative_mode_defines.mod_directory .. "/graphics/entity/energy-source.png",
				width = 124,
				height = 103,
				frame_count = 1,
				line_length = 1,
				shift = {0.6875, -0.203125}
			},
			vertical_animation = {
				filename = creative_mode_defines.mod_directory .. "/graphics/entity/energy-source.png",
				width = 124,
				height = 103,
				frame_count = 1,
				line_length = 1,
				shift = {0.6875, -0.203125}
			},
			smoke = {},
			working_sound = {
				sound = {
					filename = "__base__/sound/accumulator-working.ogg",
					volume = 1
				},
				idle_sound = {
					filename = "__base__/sound/accumulator-idle.ogg",
					volume = 0.4
				},
				max_sounds_per_type = 5
			}
		},
		-- Passive energy source
		{
			type = "accumulator",
			name = creative_mode_defines.names.entities.passive_energy_source,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/passive-energy-source.png",
			flags = {"placeable-neutral", "player-creation"},
			minable = {hardness = 0.2, mining_time = 0.5, result = creative_mode_defines.names.items.passive_energy_source},
			max_health = 150,
			corpse = "medium-remnants",
			fast_replaceable_group = creative_mode_defines.names.fast_replaceable_groups.energy_source_void,
			collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
			selection_box = {{-1, -1}, {1, 1}},
			energy_source = {
				type = "electric",
				buffer_capacity = "5.4PW",
				usage_priority = "tertiary",
				input_flow_limit = "0W",
				output_flow_limit = "5.4PW"
			},
			picture = {
				filename = creative_mode_defines.mod_directory .. "/graphics/entity/passive-energy-source.png",
				priority = "extra-high",
				width = 124,
				height = 103,
				shift = {0.6875, -0.203125}
			},
			charge_animation = {
				filename = creative_mode_defines.mod_directory .. "/graphics/entity/passive-energy-source-working.png",
				width = 147,
				height = 128,
				line_length = 8,
				frame_count = 24,
				shift = {0.390625, -0.53125},
				animation_speed = 0.5
			},
			charge_cooldown = 30,
			charge_light = {intensity = 0.3, size = 7},
			discharge_animation = {
				filename = creative_mode_defines.mod_directory .. "/graphics/entity/passive-energy-source-working.png",
				width = 147,
				height = 128,
				line_length = 8,
				frame_count = 24,
				shift = {0.390625, -0.53125},
				animation_speed = 0.5
			},
			discharge_cooldown = 60,
			discharge_light = {intensity = 0.7, size = 7},
			vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
			working_sound = {
				sound = {
					filename = "__base__/sound/accumulator-working.ogg",
					volume = 1
				},
				idle_sound = {
					filename = "__base__/sound/accumulator-idle.ogg",
					volume = 0.4
				},
				max_sounds_per_type = 5
			},
			circuit_wire_connection_point = {
				shadow = {
					red = {0.984375, 1.10938},
					green = {0.890625, 1.10938}
				},
				wire = {
					red = {0.6875, 0.59375},
					green = {0.6875, 0.71875}
				}
			},
			circuit_connector_sprites = circuit_connector_definitions[creative_mode_defines.names.entities.passive_energy_source].sprites,
			circuit_wire_max_distance = 1000,
			default_output_signal = {type = "virtual", name = "signal-A"}
		},
		-- Active energy void
		{
			type = "assembling-machine",
			name = creative_mode_defines.names.entities.energy_void,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/energy-void.png",
			flags = {"placeable-player", "player-creation"},
			minable = {mining_time = 0.5, result = creative_mode_defines.names.items.energy_void},
			max_health = 150,
			corpse = "medium-remnants",
			fast_replaceable_group = creative_mode_defines.names.fast_replaceable_groups.energy_source_void,
			collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
			selection_box = {{-1, -1}, {1, 1}},
			fluid_boxes = {},
			animation = {
				filename = creative_mode_defines.mod_directory .. "/graphics/entity/energy-void.png",
				priority = "high",
				width = 124,
				height = 103,
				frame_count = 1,
				line_length = 1,
				shift = {0.6875, -0.203125}
			},
			vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
			open_sound = {filename = "__base__/sound/machine-open.ogg", volume = 0.85},
			close_sound = {filename = "__base__/sound/machine-close.ogg", volume = 0.75},
			working_sound = {
				sound = {
					filename = "__base__/sound/accumulator-working.ogg",
					volume = 1
				},
				idle_sound = {
					filename = "__base__/sound/accumulator-idle.ogg",
					volume = 0.4
				},
				apparent_volume = 1.5
			},
			crafting_categories = {creative_mode_defines.names.recipe_categories.energy_absorption},
			fixed_recipe = creative_mode_defines.names.recipes.energy_absorption,
			crafting_speed = 0.01,
			energy_source = {
				type = "electric",
				usage_priority = "secondary-input",
				emissions_per_minute = 0
			},
			energy_usage = "5.4PW",
			ingredient_count = 0,
			module_specification = {},
			allowed_effects = {"pollution"}
		},
		-- Passive energy void
		{
			type = "accumulator",
			name = creative_mode_defines.names.entities.passive_energy_void,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/passive-energy-void.png",
			flags = {"placeable-neutral", "player-creation"},
			minable = {hardness = 0.2, mining_time = 0.5, result = creative_mode_defines.names.items.passive_energy_void},
			max_health = 150,
			corpse = "medium-remnants",
			fast_replaceable_group = creative_mode_defines.names.fast_replaceable_groups.energy_source_void,
			collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
			selection_box = {{-1, -1}, {1, 1}},
			energy_source = {
				type = "electric",
				buffer_capacity = "5.4PW",
				usage_priority = "tertiary",
				input_flow_limit = "5.4PW",
				output_flow_limit = "0W"
			},
			picture = {
				filename = creative_mode_defines.mod_directory .. "/graphics/entity/passive-energy-void.png",
				priority = "extra-high",
				width = 124,
				height = 103,
				shift = {0.6875, -0.203125}
			},
			charge_animation = {
				filename = creative_mode_defines.mod_directory .. "/graphics/entity/passive-energy-void-working.png",
				width = 147,
				height = 128,
				line_length = 8,
				frame_count = 24,
				shift = {0.390625, -0.53125},
				animation_speed = 0.5
			},
			charge_cooldown = 30,
			charge_light = {intensity = 0.3, size = 7},
			discharge_animation = {
				filename = creative_mode_defines.mod_directory .. "/graphics/entity/passive-energy-void-working.png",
				width = 147,
				height = 128,
				line_length = 8,
				frame_count = 24,
				shift = {0.390625, -0.53125},
				animation_speed = 0.5
			},
			discharge_cooldown = 60,
			discharge_light = {intensity = 0.7, size = 7},
			vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
			working_sound = {
				sound = {
					filename = "__base__/sound/accumulator-working.ogg",
					volume = 1
				},
				idle_sound = {
					filename = "__base__/sound/accumulator-idle.ogg",
					volume = 0.4
				},
				max_sounds_per_type = 5
			},
			circuit_wire_connection_point = {
				shadow = {
					red = {0.984375, 1.10938},
					green = {0.890625, 1.10938}
				},
				wire = {
					red = {0.6875, 0.59375},
					green = {0.6875, 0.71875}
				}
			},
			circuit_connector_sprites = circuit_connector_definitions[creative_mode_defines.names.entities.passive_energy_void].sprites,
			circuit_wire_max_distance = 1000,
			default_output_signal = {type = "virtual", name = "signal-A"}
		},
		-- Super electric pole
		{
			type = "electric-pole",
			name = creative_mode_defines.names.entities.super_electric_pole,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-electric-pole.png",
			flags = {"placeable-player", "player-creation"},
			minable = {mining_time = 0.5, result = creative_mode_defines.names.items.super_electric_pole},
			max_health = 150,
			corpse = "medium-remnants",
			resistances = {
				{
					type = "fire",
					percent = 100
				}
			},
			collision_box = {{-0.65, -0.65}, {0.65, 0.65}},
			selection_box = {{-1, -1}, {1, 1}},
			drawing_box = {{-1, -3}, {1, 0.5}},
			maximum_wire_distance = 64,
			supply_area_distance = 2,
			vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
			pictures = {
				filename = creative_mode_defines.mod_directory .. "/graphics/entity/super-electric-pole.png",
				priority = "high",
				width = 168,
				height = 165,
				direction_count = 4,
				shift = {1.6, -1.1}
			},
			connection_points = {
				{
					shadow = {
						copper = {2.7, 0},
						green = {1.8, 0},
						red = {3.6, 0}
					},
					wire = {
						copper = {0, -3.125},
						green = {-0.59375, -3.125},
						red = {0.625, -3.125}
					}
				},
				{
					shadow = {
						copper = {3.1, 0.2},
						green = {2.3, -0.3},
						red = {3.8, 0.6}
					},
					wire = {
						copper = {-0.0625, -3.125},
						green = {-0.5, -3.4375},
						red = {0.34375, -2.8125}
					}
				},
				{
					shadow = {
						copper = {2.9, 0.06},
						green = {3.0, -0.6},
						red = {3.0, 0.8}
					},
					wire = {
						copper = {-0.09375, -3.09375},
						green = {-0.09375, -3.53125},
						red = {-0.09375, -2.65625}
					}
				},
				{
					shadow = {
						copper = {3.1, 0.2},
						green = {3.8, -0.3},
						red = {2.35, 0.6}
					},
					wire = {
						copper = {-0.0625, -3.1875},
						green = {0.375, -3.5},
						red = {-0.46875, -2.90625}
					}
				}
			},
			radius_visualisation_picture = {
				filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
				width = 12,
				height = 12,
				priority = "extra-high-no-scale"
			}
		},
		-- Super substation
		{
			type = "electric-pole",
			name = creative_mode_defines.names.entities.super_substation,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-substation.png",
			flags = {"placeable-player", "player-creation"},
			minable = {mining_time = 0.5, result = creative_mode_defines.names.items.super_substation},
			max_health = 200,
			corpse = "medium-remnants",
			track_coverage_during_build_by_moving = true,
			resistances = {
				{
					type = "fire",
					percent = 90
				}
			},
			collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
			selection_box = {{-1, -1}, {1, 1}},
			drawing_box = {{-1, -3}, {1, 1}},
			maximum_wire_distance = 64,
			supply_area_distance = 64,
			vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
			pictures = {
				filename = creative_mode_defines.mod_directory .. "/graphics/entity/super-substation.png",
				priority = "high",
				width = 132,
				height = 144,
				direction_count = 4,
				shift = {0.9, -1}
			},
			connection_points = {
				{
					shadow = {
						copper = {1.9, -0.6},
						green = {1.3, -0.6},
						red = {2.65, -0.6}
					},
					wire = {
						copper = {-0.25, -2.71875},
						green = {-0.84375, -2.71875},
						red = {0.34375, -2.71875}
					}
				},
				{
					shadow = {
						copper = {1.9, -0.6},
						green = {1.2, -0.8},
						red = {2.5, -0.35}
					},
					wire = {
						copper = {-0.21875, -2.71875},
						green = {-0.65625, -3.03125},
						red = {0.1875, -2.4375}
					}
				},
				{
					shadow = {
						copper = {1.9, -0.6},
						green = {1.9, -0.9},
						red = {1.9, -0.3}
					},
					wire = {
						copper = {-0.21875, -2.71875},
						green = {-0.21875, -3.15625},
						red = {-0.21875, -2.34375}
					}
				},
				{
					shadow = {
						copper = {1.8, -0.7},
						green = {1.3, -0.6},
						red = {2.4, -1.15}
					},
					wire = {
						copper = {-0.21875, -2.75},
						green = {-0.65625, -2.4375},
						red = {0.1875, -3.03125}
					}
				}
			},
			radius_visualisation_picture = {
				filename = "__base__/graphics/entity/small-electric-pole/electric-pole-radius-visualization.png",
				width = 12,
				height = 12,
				priority = "extra-high-no-scale"
			}
		},
		-----------------------------------------------------------------------------

		-- Magic wand smoke - creator
		magic_wand_smoke(creative_mode_defines.names.entities.magic_wand_smoke_creator, {r = 1, g = 0, b = 0, a = 0.4}),
		-- Magic wand smoke - healer
		magic_wand_smoke(creative_mode_defines.names.entities.magic_wand_smoke_healer, {r = 0, g = 1, b = 0, a = 0.4}),
		-- Magic wand smoke - modifier
		magic_wand_smoke(creative_mode_defines.names.entities.magic_wand_smoke_modifier, {r = 0.5, g = 0, b = 1, a = 0.4}),
		-----------------------------------------------------------------------------

		-- Super radar
		radar(
			creative_mode_defines.names.entities.super_radar,
			creative_mode_defines.names.items.super_radar,
			"super-radar.png",
			"super-radar.png",
			14
		),
		-- Super radar MK2
		radar(
			creative_mode_defines.names.entities.super_radar_2,
			creative_mode_defines.names.items.super_radar_2,
			"super-radar-2.png",
			"super-radar-2.png",
			50
		),
		-- Alien attractor proxy - small
		alien_attractor_proxy(creative_mode_defines.names.entities.alien_attractor_proxy_small, 0.1),
		-- Alien attractor proxy - medium
		alien_attractor_proxy(creative_mode_defines.names.entities.alien_attractor_proxy_medium, 0.25),
		-- Alien attractor proxy - large
		alien_attractor_proxy(creative_mode_defines.names.entities.alien_attractor_proxy_large, 0.5),
		-----------------------------------------------------------------------------

		-- Super beacon.
		{
			type = "beacon",
			name = creative_mode_defines.names.entities.super_beacon,
			icon_size = 32,
			icon = creative_mode_defines.mod_directory .. "/graphics/icons/super-beacon.png",
			flags = {"placeable-player", "player-creation"},
			minable = {mining_time = 0.5, result = creative_mode_defines.names.items.super_beacon},
			max_health = 200,
			corpse = "big-remnants",
			dying_explosion = "medium-explosion",
			collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
			selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
			allowed_effects = {"consumption", "speed", "pollution", "productivity"},
			base_picture = {
				filename = creative_mode_defines.mod_directory .. "/graphics/entity/super-beacon-base.png",
				width = 116,
				height = 93,
				shift = {0.34375, 0.046875}
			},
			animation = {
				filename = creative_mode_defines.mod_directory .. "/graphics/entity/super-beacon-antenna.png",
				width = 54,
				height = 50,
				line_length = 8,
				frame_count = 32,
				shift = {-0.03125, -1.71875},
				animation_speed = 0.5
			},
			animation_shadow = {
				filename = creative_mode_defines.mod_directory .. "/graphics/entity/super-beacon-antenna-shadow.png",
				width = 63,
				height = 49,
				line_length = 8,
				frame_count = 32,
				shift = {3.140625, 0.484375},
				animation_speed = 0.5
			},
			radius_visualisation_picture = {
				filename = "__base__/graphics/entity/beacon/beacon-radius-visualization.png",
				priority = "extra-high-no-scale",
				width = 10,
				height = 10
			},
			supply_area_distance = 64,
			--energy_source = creative_mode_defines.non_electric_energy_source, -- Burner energy won't work on beacon.
			energy_source = {
				type = "electric",
				usage_priority = "tertiary"
			},
			energy_usage = "1kW",
			vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
			distribution_effectivity = 0.5,
			module_specification = {
				module_slots = 7,
				module_info_icon_shift = {0, 0.5},
				module_info_multi_row_initial_height_modifier = -0.3
			}
		}
	}
)
