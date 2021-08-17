net.Receive("XYZDoctor:Purchase:Examination", function(_, ply)
	if XYZShit.CoolDown.Check("XYZDoctor:Purchase", 2, ply) then return end
	
	local npc = net.ReadEntity()
	local item = net.ReadInt(3)

	-- Check over then NPC
	if not (npc:GetClass() == "xyz_doctor_npc") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end

	item = XYZDoctor.Config.Examinations[item]

	-- Invalid item
	if not item then return end
	local price = XYZDoctor.Config.Discount(ply, item.price, true)

	if not ply:canAfford(price) then XYZShit.Msg("Dr. Shkreli", XYZDoctor.Config.Color, "You can't afford this, we don't give free health-care here!", ply) return end

	local result = item.action(ply)
	if not result then XYZShit.Msg("Dr. Shkreli", XYZDoctor.Config.Color, "Seems you don't need this examination...", ply) return end

	ply:addMoney(-price)
	XYZShit.Msg("Dr. Shkreli", XYZDoctor.Config.Color, "Alrighty, you're all set for "..item.name.."! That'll be "..DarkRP.formatMoney(price), ply)
	xLogs.Log(xLogs.Core.Player(ply).." has purchased "..item.name.." for "..xLogs.Core.Color(DarkRP.formatMoney(price), Color(0, 200, 200)), "Doctor")
end)

XYZDoctor.Core.Limits = {}
net.Receive("XYZDoctor:Purchase:Entity", function(_, ply)
	if XYZShit.CoolDown.Check("XYZDoctor:Purchase", 2, ply) then return end
	
	local npc = net.ReadEntity()
	local item = net.ReadInt(3)
	local bulkBuy = net.ReadBool()

	-- Check over then NPC
	if not (npc:GetClass() == "xyz_doctor_npc") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end

	item = XYZDoctor.Config.Entities[item]

	-- Invalid item
	if not item then return end
	if bulkBuy and (not item.bulkBuy) then return end
	if bulkBuy and (XYZDoctor.Core.Limits[ply:SteamID64()] and XYZDoctor.Core.Limits[ply:SteamID64()][item.entity]) then
		XYZShit.Msg("Dr. Shkreli", XYZDoctor.Config.Color, "You've already started buying from me, I can't bulk sell to you anymore...", ply)
		return
	end
	local price = XYZDoctor.Config.Discount(ply, item.price) * (bulkBuy and item.max or 1)

	if not ply:canAfford(price) then XYZShit.Msg("Dr. Shkreli", XYZDoctor.Config.Color, "You can't afford this, I'm running an illegal business here!", ply) return end

	if not XYZDoctor.Core.Limits[ply:SteamID64()] then
		XYZDoctor.Core.Limits[ply:SteamID64()] = {}
	end
	if not XYZDoctor.Core.Limits[ply:SteamID64()][item.entity] then
		XYZDoctor.Core.Limits[ply:SteamID64()][item.entity] = 0
	end

	if XYZDoctor.Core.Limits[ply:SteamID64()][item.entity] >= item.max then
		XYZShit.Msg("Dr. Shkreli", XYZDoctor.Config.Color, "You've already bled me dry of that, I might have more in tomorrow!", ply)
		return
	end

	-- hacky, but the only way :/
	if (table.Count(Inventory.SavedInvs[ply:SteamID64()]) + ((bulkBuy and item.max or 0))) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
		XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
		return
	end

	XYZDoctor.Core.Limits[ply:SteamID64()][item.entity] = XYZDoctor.Core.Limits[ply:SteamID64()][item.entity] + (bulkBuy and item.max or 1)

	ply:addMoney(-price)
	if bulkBuy then
		XYZShit.Msg("Dr. Shkreli", XYZDoctor.Config.Color, "You have bulk purchased "..item.max.." "..item.name.."'s for "..DarkRP.formatMoney(price)..". Keep this on the down low, I wouldn't survive in prison!", ply)
		xLogs.Log(xLogs.Core.Player(ply).." has bulk purchased "..item.max.." "..item.name.."'s for "..xLogs.Core.Color(DarkRP.formatMoney(price), Color(0, 200, 200)), "Doctor")
	else
		XYZShit.Msg("Dr. Shkreli", XYZDoctor.Config.Color, "Alright, here's your "..item.name.." for "..DarkRP.formatMoney(price)..". Keep this on the down low, I wouldn't survive in prison!", ply)
		xLogs.Log(xLogs.Core.Player(ply).." has purchased a "..item.name.." for "..xLogs.Core.Color(DarkRP.formatMoney(price), Color(0, 200, 200)), "Doctor")
	end

	for i=1, (bulkBuy and item.max or 1) do
		local itemEntity = ents.Create(item.entity)
		itemEntity:SetPos(npc:GetPos() + (npc:GetForward()*8) + (npc:GetUp()*50))
		itemEntity:Setowning_ent(ply)
		itemEntity:Spawn()
	
		Inventory.Core.PickupItem(ply, itemEntity)
	end

	hook.Run("DoctorPurchaseEntity", ply, item.entity)
end)