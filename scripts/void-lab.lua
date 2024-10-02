-- This file contains variables or functions that are related to the Creative Lab in this mod.
if not void_lab then
    void_lab = {}
end

-- Processes the table of void_lab in storage.
function void_lab.tick()
    storage.creative_mode.void_lab_next_update_index =
        void_chest_util.remove_contents(storage.creative_mode.void_lab,
                                        storage.creative_mode.void_lab_next_update_index)
end
