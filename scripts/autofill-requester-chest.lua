-- This file contains variables or functions that are related to the Autofill Requester Chest in this mod.
if not autofill_requester_chest then
	autofill_requester_chest = {}
end

-- Refill the given chest according to its requests.
local function refill_chest(chest)
	local inventory = chest.get_output_inventory()
	local inventory_size = #inventory
	local slot = 1
	local item_prototypes = prototypes.item
	local math_ceil = math.ceil

	local request_slot_count = chest.request_slot_count
	for request_slot = 1, request_slot_count, 1 do
		-- Get the request in the iterated request slot.
		local request = chest.get_request_slot(request_slot)
		if request then
			-- Get the requested item name and count.
			local item_name = request.name
			local item_count = request.count
			-- How many slots are required?
			if item_count > 0 then
				local stack_size = item_prototypes[item_name].stack_size
				local required_slot_count = math_ceil(item_count / stack_size)
				-- Set items until it fulfills the requested amount.
				local is_last_stack = false
				repeat
					local set_count
					if item_count <= stack_size then
						set_count = item_count
						is_last_stack = true
					else
						set_count = stack_size
					end
					inventory[slot].set_stack {name = item_name, count = set_count}
					item_count = item_count - set_count
					slot = slot + 1
					if slot > inventory_size then
						-- No more slot.
						return
					end
				until is_last_stack
			end
		end
	end
	-- Empty the remaining slots.
	for i = slot, inventory_size, 1 do
		inventory[i].clear()
	end
end

-- Refill the chest contents among the given array of chests according to the given index of the next chest to update.
-- Returns the index of the next chest to update in the next tick.
local function refill_chests(chests, next_chest_to_update)
	if #chests <= 0 then
		return 1
	end

	local chest_index = next_chest_to_update
	for i = 1, 5, 1 do
		local chest = chests[chest_index]
		if chest.valid then
			if not chest.to_be_deconstructed(chest.force) then
				-- Refill the chest.
				refill_chest(chest)
			end

			-- Prepare for the next chest.
			chest_index = chest_index + 1
			-- No more next chest. Return to the first chest.
			if chest_index > #chests then
				return 1
			end
		else
			table.remove(chests, chest_index)
			if chest_index > #chests then
				return 1
			end
		end
	end
	-- Return the index of the next chest to update.
	return chest_index
end

-- Processes the tables related to Autofill Requester Chests in storage.
function autofill_requester_chest.tick()
	-- Refill the chests.
	storage.creative_mode.autofill_requester_chest_next_update_index =
		refill_chests(
		storage.creative_mode.autofill_requester_chest,
		storage.creative_mode.autofill_requester_chest_next_update_index
	)
end
