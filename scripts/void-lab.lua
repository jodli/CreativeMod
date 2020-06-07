-- This file contains variables or functions that are related to the Creative Lab in this mod.
if not void_lab then
    void_lab = {}
end

-- Processes the table of void_lab in global.
function void_lab.tick()
    global.creative_mode.void_lab_next_update_index =
        void_chest_util.remove_contents(global.creative_mode.void_lab,
                                        global.creative_mode.void_lab_next_update_index)
end
