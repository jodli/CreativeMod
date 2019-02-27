data:extend
{
	{
		-- Super fusion reactor requipment
		type = "generator-equipment",
		name = creative_mode_defines.names.equipments.super_fusion_reactor_equipment,
		sprite =
		{
			filename = creative_mode_defines.mod_directory .. "/graphics/equipment/super-fusion-reactor-equipment.png",
			width = 32,
			height = 32,
			priority = "medium"
		},
		shape =
		{
			width = 1,
			height = 1,
			type = "full"
		},
		energy_source =
		{
			type = "electric",
			usage_priority = "primary-output"
		},
		power = "5.4PW",
		categories = {"armor"}
	},
	{
		-- Super personal roboport equipment
		type = "roboport-equipment",
		name = creative_mode_defines.names.equipments.super_personal_roboport_equipment,
		sprite =
		{
			filename = creative_mode_defines.mod_directory .. "/graphics/equipment/super-personal-roboport-equipment.png",
			width = 32,
			height = 32,
			priority = "medium"
		},
		shape =
		{
			width = 1,
			height = 1,
			type = "full"
		},
		energy_source =
		{
			type = "electric",
			buffer_capacity = "100PJ",
			input_flow_limit = "0KW",
			usage_priority = "secondary-input"
		},
		charging_energy = "40MJ",
		energy_consumption = "1W",
		robot_limit = 1000,
		construction_radius = 200,
		spawn_and_station_height = 0.4,
		charge_approach_distance = 2.6,
		recharging_animation =
		{
			filename = "__base__/graphics/entity/roboport/roboport-recharging.png",
			priority = "high",
			width = 37,
			height = 35,
			frame_count = 16,
			scale = 1.5,
			animation_speed = 0.5
		},
		recharging_light = {intensity = 0.4, size = 5},
		stationing_offset = {0, -0.6},
		charging_station_shift = {0, 0.5},
		charging_station_count = 1000,
		charging_distance = 1.6,
		charging_threshold_distance = 5,
		categories = {"armor"}
	}
}