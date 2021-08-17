net.Receive("XYZInv:InitalInv", function()
	local inv = net.ReadTable()
	
	for k, v in pairs(inv) do
		table.insert(Inventory.SavedInvs, v)
	end
end)

net.Receive("XYZInv:AddItem", function()
	local item = net.ReadTable()
	table.insert(Inventory.SavedInvs, item)
end)

net.Receive("XYZInv:RemoveItem", function()
	local item = net.ReadString()

	local hasItem = false
	if not Inventory.SavedInvs then return false end
	for k, v in pairs(Inventory.SavedInvs) do
		if v.class == item then
			hasItem = k
			break
		end
	end
	if not hasItem then return end

	Inventory.SavedInvs[hasItem] = nil
end)


net.Receive("XYZInv:OpenLocker", function()
	Inventory.Core.OpenLocker()
end)