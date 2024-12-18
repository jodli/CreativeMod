-- This file contains variables or functions that are related to the Creative Lab in this mod.
if not creative_lab then
	creative_lab = {}
end

-- Processes the table of creative_lab in storage.
function creative_lab.tick()
	local next_update_index = storage.creative_mode.creative_lab_next_update_index
	local creative_labs = storage.creative_mode.creative_lab
	local lab_count = #creative_labs

	if lab_count <= 0 then
		-- Nothing to do.
		return
	end

	-- Remove invalid labs from the array.
	local labs_updated = false
	for i = lab_count, 1, -1 do
		local lab = creative_labs[i]
		if lab.valid then
			
		else
			table.remove(creative_labs, i)
			labs_updated = true
			lab_count = lab_count - 1
		end
	end

	-- Do we still have valid labs?
	if lab_count > 0 then
		-- Make sure the update index is in range.
		if next_update_index > lab_count then
			next_update_index = lab_count
		end
		-- Refill science packs. Because there may be many science packs, we only refill 10 labs at most in every tick.
		for i = 1, 10, 1 do
			local creative_lab = creative_labs[next_update_index]
			-- Update the lab.
			if not creative_lab.to_be_deconstructed(creative_lab.force) then
				for _, item in ipairs(storage.tool_item_list) do
					creative_lab.insert {name = item.name, count = prototypes.item[item.name].stack_size}
				end
			end
			-- Prepare for the next lab.
			next_update_index = next_update_index + 1
			if next_update_index > lab_count then
				-- No more next lab. Return to the first one.
				next_update_index = 1
				break
			end
		end
	else
		next_update_index = 1
	end

	if labs_updated then
		storage.creative_mode.creative_lab = creative_labs
	end
	storage.creative_mode.creative_lab_next_update_index = next_update_index
end
