local function create_void_technology_ingredients()
    return {
        {
            name = "automation-science-pack",
            amount = 1
        },
        {
            name = "logistic-science-pack",
            amount = 1
        },
        {
            name = "military-science-pack",
            amount = 1
        },
        {
            name = "chemical-science-pack",
            amount = 1
        },
        {
            name = "production-science-pack",
            amount = 1
        },
        {
            name = "utility-science-pack",
            amount = 1
        },
        {
            name = "space-science-pack",
            amount = 1
        }
    }
end

data:extend({
    {
        type = "technology",
        name = creative_mode_defines.names.technology.void_technology,
        enabled = false,
        icon_size = 64,
        icons = {
            {
                icon = "__base__/graphics/icons/lab.png",
                tint = {
                    r = 50,
                    g = 50,
                    b = 50
                }
            }
        },
        unit = {
            count = 4294967296,
            ingredients = create_void_technology_ingredients(),
            time = settings.startup[creative_mode_defines.names.settings.time_for_void_technology].value
        }
    }
})
