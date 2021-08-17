hook.Add("PlayerInitialSpawn", "XYZInvLoadInv", function(ply)
	Inventory.Database.LoadItems(ply)
end)

function Inventory.Core.CheckIfOwnsItem(ply, class)
	if not Inventory.SavedInvs[ply:SteamID64()] then return false end
	for k, v in pairs(Inventory.SavedInvs[ply:SteamID64()]) do
		if v.class == class then
			return k
		end
	end

	return false
end
function Inventory.Core.CheckIfItemInLocker(ply, class)
	if not Inventory.SavedBanks[ply:SteamID64()] then return false end
	for k, v in pairs(Inventory.SavedBanks[ply:SteamID64()]) do
		if v.class == class then
			return k
		end
	end

	return false
end

function Inventory.Core.ConvertShipmentToWeps(ent)
	local shipmentInfo = CustomShipments[ent:Getcontents()]
	if not shipmentInfo then return false end
	local entData = duplicator.CopyEntTable(ent)
	if not entData.DT then return false end

	return shipmentInfo.entity, entData.DT.count
end

function Inventory.Core.PickupItem(ply, entity)
	if entity.InvMarkedForRemoval then return end -- Prevents dup exploits/bugs

	if entity:GetClass() == "spawned_shipment" then
		if entity.locked then return end -- Shipment is still spawning
		local class, amount = Inventory.Core.ConvertShipmentToWeps(entity)
		if not class then return end

		if (table.Count(Inventory.SavedInvs[ply:SteamID64()]) + amount) > (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
			XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
			return
		end

		for i=1, amount do
			Inventory.Core.HolsterWeapon(ply, class)
		end
		entity.InvMarkedForRemoval = true
		entity:Remove()
		return
	elseif entity:GetClass() == "spawned_weapon" then
		for i=1, entity:Getamount() do
			Inventory.Core.HolsterWeapon(ply, entity:GetWeaponClass())
		end
		entity.InvMarkedForRemoval = true
		entity:Remove()
		return
	end

	if not Inventory.Config.AllowedItems[entity:GetClass()] then return end

	local block = hook.Run("Inventory.CanPickup", ply, entity)
	if block == false then return end

	if table.Count(Inventory.SavedInvs[ply:SteamID64()]) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
		XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
		return
	end
	

	local tblInfo = Inventory.ItemTypes[entity:GetClass()] or Inventory.ItemTypes['default']
	tblInfo = tblInfo.dataFormat(entity)

	if not tblInfo then return end

	Inventory.Core.GiveItem(ply:SteamID64(), entity:GetClass(), tblInfo)
	xLogs.Log(xLogs.Core.Player(ply).." has picked up "..xLogs.Core.Color(entity:GetClass(), Color(200, 200, 0)), "Inventory")

	entity.InvMarkedForRemoval = true
	entity:Remove()
end

function Inventory.Core.GiveItem(plyID, class, data)
	local ply = player.GetBySteamID64(plyID)

	Inventory.Database.InsertItem(plyID, class, data, function(responseData)
		if not IsValid(ply) then return end

		table.insert(Inventory.SavedInvs[plyID], {dbID = responseData[1]["LAST_INSERT_ID()"], class = class, data = data})

		net.Start("XYZInv:AddItem")
			net.WriteTable({dbID = responseData[1]["LAST_INSERT_ID()"], class = class, data = data})
		net.Send(ply)
	end)
end

function Inventory.Core.HolsterWeapon(ply, wep, command) -- the command arg is only used when the user /holsters. If that is the case, it will return true. Otherwise it is never provided.
	if not Inventory.Config.AllowedItems[wep] then return end

	local block = hook.Run("Inventory.CanHolster", ply, wep, command)
	if block == false then return end

	if command then
		local block = hook.Run("canDropWeapon", ply, ply:GetWeapon(wep))
		if block == false then return end
	end
	
	if table.Count(Inventory.SavedInvs[ply:SteamID64()]) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
		XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
		return
	end

	local tblInfo = Inventory.ItemTypes[wep] or Inventory.ItemTypes['default_weapon']
	tblInfo = tblInfo.dataFormat(wep)

	if not tblInfo then return end

	Inventory.Core.GiveItem(ply:SteamID64(), wep, tblInfo)
 	xLogs.Log(xLogs.Core.Player(ply).." has holstered "..xLogs.Core.Color(wep, Color(200, 200, 0)), "Inventory")
	if command then
		ply:StripWeapon(wep)
	end
end

function Inventory.Core.SpawnItem(ply, data)
	local tblInfo = Inventory.ItemTypes[data.class] or (data.data.type.isWeapon and Inventory.ItemTypes['default_weapon']) or Inventory.ItemTypes['default']
	local ent = tblInfo.spawn(ply, data.class, data.data)
	if not ent then return end

	ent.invOwner = ply

 	xLogs.Log(xLogs.Core.Player(ply).." has dropped "..xLogs.Core.Color(data.class, Color(200, 200, 0)), "Inventory")
	Inventory.Core.RemoveItemFromInv(ply, data.class)
end

function Inventory.Core.EquipItem(ply, data)
	if not data.data.type.isWeapon then return end
	local tblInfo = Inventory.ItemTypes[data.class] or Inventory.ItemTypes['default_weapon']
	local ent = tblInfo.equip(ply, data.class, data.data)
	if not ent then return end

 	xLogs.Log(xLogs.Core.Player(ply).." has equipped "..xLogs.Core.Color(data.class, Color(200, 200, 0)), "Inventory")
	Inventory.Core.RemoveItemFromInv(ply, data.class)
end

function Inventory.Core.MoveToLocker(ply, data)
	local ownsItem = Inventory.Core.CheckIfOwnsItem(ply, data.class)
	if not ownsItem then return end

	Inventory.Database.TransferToLocker(data.dbID)

	table.insert(Inventory.SavedBanks[ply:SteamID64()], data)
	Inventory.SavedInvs[ply:SteamID64()][ownsItem] = nil
	net.Start("XYZInv:RemoveItem")
		net.WriteString(data.class)
	net.Send(ply)

	xLogs.Log(xLogs.Core.Player(ply).." has moved "..xLogs.Core.Color(data.class, Color(200, 200, 0)).." to their locker", "Inventory")

	hook.Run("Inventory.MoveToLocker", ply, data.class)
end

function Inventory.Core.MoveToInventory(ply, data)
	local ownsItem = Inventory.Core.CheckIfItemInLocker(ply, data.class)
	if not ownsItem then return end

	Inventory.Database.TransferToInventory(data.dbID)

	table.insert(Inventory.SavedInvs[ply:SteamID64()], data)
	
	net.Start("XYZInv:AddItem")
		net.WriteTable(data)
	net.Send(ply)

	Inventory.SavedBanks[ply:SteamID64()][ownsItem] = nil

	xLogs.Log(xLogs.Core.Player(ply).." has moved "..xLogs.Core.Color(data.class, Color(200, 200, 0)).." to their inventory", "Inventory")
end

function Inventory.Core.RemoveItemFromInv(ply, class)
	local ownsItem = Inventory.Core.CheckIfOwnsItem(ply, class)
	if not ownsItem then return end

	Inventory.SavedInvs[ply:SteamID64()][ownsItem] = nil
	Inventory.Database.RemoveItem(ply:SteamID64(), class)

 	xLogs.Log(xLogs.Core.Player(ply).." has destroyed "..xLogs.Core.Color(class, Color(200, 200, 0)), "Inventory")

	net.Start("XYZInv:RemoveItem")
		net.WriteString(class)
	net.Send(ply)
end

function Inventory.Core.MoveToOrg(ply, class)
	local ownsItem = Inventory.Core.CheckIfOwnsItem(ply, class)
	if not ownsItem then return end
	local orgid = XYZ_ORGS.Core.Members[ply:SteamID64()]
	local plyorg = XYZ_ORGS.Core.Orgs[orgid]
	if not plyorg then return end

	if not XYZ_ORGS.Core.HasPerms(plyorg.roles[plyorg.members[ply:SteamID64()]].perms, 'DEPOSIT', ply) then return end
	if table.Count(XYZ_ORGS.Core.Orgs[XYZ_ORGS.Core.Members[ply:SteamID64()]].inventory) >= XYZ_ORGS.Core.Orgs[XYZ_ORGS.Core.Members[ply:SteamID64()]].upgrades['storageLimit'] then
		XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "Storage is full!", ply)
		return
	end

	XYZ_ORGS.Database.InsertItem(XYZ_ORGS.Core.Members[ply:SteamID64()], Inventory.SavedInvs[ply:SteamID64()][ownsItem].class, Inventory.SavedInvs[ply:SteamID64()][ownsItem].data)
	table.insert(XYZ_ORGS.Core.Orgs[XYZ_ORGS.Core.Members[ply:SteamID64()]].inventory, {class = Inventory.SavedInvs[ply:SteamID64()][ownsItem].class, data = Inventory.SavedInvs[ply:SteamID64()][ownsItem].data})
	Inventory.Database.RemoveItem(ply:SteamID64(), class)

	XYZShit.Msg("Organizations", XYZ_ORGS.Config.Color, "Moved to organization!", ply)

	Inventory.SavedInvs[ply:SteamID64()][ownsItem] = nil

 	xLogs.Log(xLogs.Core.Player(ply).." has moved "..xLogs.Core.Color(class, Color(200, 200, 0)).." to their organization", "Inventory")

	Quest.Core.ProgressQuest(ply, "gang_warfare", 4)

	net.Start("XYZInv:RemoveItem")
		net.WriteString(class)
	net.Send(ply)
end


net.Receive("XYZInv:DropItem", function(_, ply)
	local item = net.ReadString()
	if not item then return end

	local block = hook.Run("Inventory.CanDrop", ply, item)
	if block == false then return end

	local ownsItem = Inventory.Core.CheckIfOwnsItem(ply, item)
	if not ownsItem then return end

	Inventory.Core.SpawnItem(ply, Inventory.SavedInvs[ply:SteamID64()][ownsItem])
end)

net.Receive("XYZInv:MoveToLocker", function(_, ply)
	local item = net.ReadString()
	if not item then return end
	local amount = net.ReadUInt(7)
	if not amount then return end

	local closeToLocker = false
	for k, v in pairs(Inventory.BankEnts) do
		if not IsValid(v) then continue end

		if v:GetPos():DistToSqr(ply:GetPos()) > 20000 then continue end

		closeToLocker = true
	end

	if not closeToLocker then
		XYZShit.Msg("Inventory", Color(2, 108, 254), "You need to be closer to a Bank Locker before you can transfer it!", ply)
		return
	end

	for i=1, amount do
		if table.Count(Inventory.SavedBanks[ply:SteamID64()]) >= ((Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default'])*Inventory.Config.InvMultiplier) then
			XYZShit.Msg("Inventory", Color(2, 108, 254), "You Bank Locker is full!", ply)
			return
		end
	
		local block = hook.Run("Inventory.CanDrop", ply, item)
		if block == false then return end

		local ownsItem = Inventory.Core.CheckIfOwnsItem(ply, item)
		if not ownsItem then return end
	
		Inventory.Core.MoveToLocker(ply, Inventory.SavedInvs[ply:SteamID64()][ownsItem])
	end
end)

net.Receive("XYZInv:MoveToInv", function(_, ply)
	local item = net.ReadString()
	if not item then return end

	local closeToLocker = false
	for k, v in pairs(Inventory.BankEnts) do
		if not IsValid(v) then continue end

		if v:GetPos():DistToSqr(ply:GetPos()) > 20000 then continue end

		closeToLocker = true
	end
	if not closeToLocker then return end

	if table.Count(Inventory.SavedInvs[ply:SteamID64()]) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
		XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventroy is full!", ply)
		return
	end

	local block = hook.Run("Inventory.CanDrop", ply, item)
	if block == false then return end

	local ownsItem = Inventory.Core.CheckIfItemInLocker(ply, item)
	if not ownsItem then return end

	Inventory.Core.MoveToInventory(ply, Inventory.SavedBanks[ply:SteamID64()][ownsItem])
end)


net.Receive("XYZInv:EquipItem", function(_, ply)
	local item = net.ReadString()
	if not item then return end

	local block = hook.Run("Inventory.CanEquip", ply, item)
	if block == false then return end

	local ownsItem = Inventory.Core.CheckIfOwnsItem(ply, item)
	if not ownsItem then return end

	Inventory.Core.EquipItem(ply, Inventory.SavedInvs[ply:SteamID64()][ownsItem])
end)


net.Receive("XYZInv:DestroyItem", function(_, ply)
	local item = net.ReadString()
	if not item then return end

	local block = hook.Run("Inventory.CanDestroy", ply, item)
	if block == false then return end

	local ownsItem = Inventory.Core.CheckIfOwnsItem(ply, item)
	if not ownsItem then return end

	Inventory.Core.RemoveItemFromInv(ply, Inventory.SavedInvs[ply:SteamID64()][ownsItem].class)
end)

net.Receive("XYZInv:DestroyItem:All", function(_, ply)
	local item = net.ReadString()
	if not item then return end

	local block = hook.Run("Inventory.CanDestroy", ply, item)
	if block == false then return end

	local ownsItem = Inventory.Core.CheckIfOwnsItem(ply, item)
	if not ownsItem then return end
	
	while ownsItem do
		Inventory.Core.RemoveItemFromInv(ply, Inventory.SavedInvs[ply:SteamID64()][ownsItem].class)

		ownsItem = Inventory.Core.CheckIfOwnsItem(ply, item)
		if not ownsItem then return end
	end
end)

net.Receive("XYZInv:MoveToOrg", function(_, ply)
	local item = net.ReadString()
	if not XYZ_ORGS.Core.Members[ply:SteamID64()] then return end
	if not item then return end

	local closeToLocker = false
	for k, v in pairs(Inventory.BankEnts) do
		if not IsValid(v) then continue end

		if v:GetPos():DistToSqr(ply:GetPos()) > 20000 then continue end

		closeToLocker = true
	end

	if not closeToLocker then
		XYZShit.Msg("Inventory", Color(2, 108, 254), "You need to be closer to a Bank Locker before you can transfer it!", ply)
		return
	end

	local block = hook.Run("Inventory.CanDestroy", ply, item)
	if block == false then return end

	Inventory.Core.MoveToOrg(ply, item)
end)

net.Receive("XYZInv:RequestLocker", function(_, ply)
	-- Break the bank up into chunks of 30 items to not overload the player
	local inv = Inventory.SavedBanks[ply:SteamID64()]

	for i=1, math.ceil(#inv/30) do
	    local partInv = {}
	    for k, v in pairs(inv) do
	        if k > (30*i) then continue end
	        if k < ((30*i) - 29) then continue end
	        table.insert(partInv, v)
	    end

		net.Start("XYZInv:SendBank")
			net.WriteTable(partInv)
		net.Send(ply)
	end
end)

hook.Add("PlayerSay", "XYZInv:HolsterHook", function(ply, text)
	if (string.lower(text) == "/holster") or (string.lower(text) == "/invholster") then
		if not IsValid(ply:GetActiveWeapon()) then return end
		if Inventory.Config.BlockInvHolster[ply:GetActiveWeapon():GetClass()] then
			XYZShit.Msg("Inventory", Color(2, 108, 254), "This weapon is blocked from working with the holster command. Instead: Drop the weapon and pick it up with the SWEP!", ply)
			return
		end
		Inventory.Core.HolsterWeapon(ply, ply:GetActiveWeapon():GetClass(), true)
		return ""
	end
end)

hook.Add("Inventory.CanHolster", "BlockDefaultWeapons", function(ply, wep, command)
	if table.HasValue(GAMEMODE.Config.DefaultWeapons, wep) then
		return false
	end
end)
hook.Add("Inventory.CanHolster", "BlockJobWeapons", function(ply, wep, command)
	if ply:getJobTable() and ply:getJobTable().weapons and table.HasValue(ply:getJobTable().weapons, wep) then
		return false
	end
end)
hook.Add("Inventory.CanHolster", "BlockDisallowDrop", function(ply, wep, command)
	if GAMEMODE.Config.DisallowDrop[wep] then
		return false
	end
end)