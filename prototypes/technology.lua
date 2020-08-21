local function create_void_technology_ingredients()
    local research_items = {}
    for _, tool in pairs(data.raw.tool) do
        table.insert(research_items, {
            name = tool.name,
            amount = 1
        })
    end

    return research_items
end

data:extend({{
    type = "technology",
    name = creative_mode_defines.names.technology.void_technology,
    enabled = false,
    icon_size = 64,
    icons = {{
        icon = "__base__/graphics/icons/lab.png",
        tint = {
            r = 50,
            g = 50,
            b = 50
        }
    }},
    unit = {
        count = 4294967296,
        ingredients = create_void_technology_ingredients(),
        time = settings.startup[creative_mode_defines.names.settings.time_for_void_technology].value
    }
}})
