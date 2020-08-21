require("defines")
require("scripts/util")

require("prototypes.item-group")
require("prototypes.recipe-category")
require("prototypes.entity")
require("prototypes.item")
require("prototypes.equipment")
require("prototypes.recipe")
require("prototypes.style")
require("prototypes.sprite")

if not util.array_contains_key(mods, "space-exploration-postprocess") then
    require("prototypes.technology")
end
