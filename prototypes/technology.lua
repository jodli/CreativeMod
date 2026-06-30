local function create_void_technology_ingredients()
  -- Require one of every science pack any real lab can consume. Deriving the list
  -- from other labs' inputs (rather than matching the "science-pack" subgroup) keeps
  -- non-pack items that merely share that subgroup -- such as "coin" and the "science"
  -- pictogram -- out of the requirement, so a real lab can actually satisfy it.
  local creative_lab_name = creative_mode_defines.names.entities.creative_lab
  local void_lab_name = creative_mode_defines.names.entities.void_lab
  local seen_science_packs = {}
  local research_items = {}
  for lab_name, lab in pairs(data.raw["lab"]) do
    if lab_name ~= creative_lab_name and lab_name ~= void_lab_name and lab.inputs then
      for _, input_name in pairs(lab.inputs) do
        if not seen_science_packs[input_name] then
          seen_science_packs[input_name] = true
          table.insert(research_items, {
            input_name,
            1,
          })
        end
      end
    end
  end

  return research_items
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
          b = 50,
        },
      },
    },
    unit = {
      count = 4294967296,
      ingredients = create_void_technology_ingredients(),
      time = settings.startup[creative_mode_defines.names.settings.time_for_void_technology].value,
    },
  },
})
