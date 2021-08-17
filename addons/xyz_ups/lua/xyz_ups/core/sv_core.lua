UPS.Core.ActiveDeliveries = UPS.Core.ActiveDeliveries or {}
UPS.Core.RecentDeliveries = UPS.Core.RecentDeliveries or {}
net.Receive("xyz_ups_select", function(_, ply)
	if not ply:Team() == TEAM_UPSDRIVER then return end
	local npc = net.ReadEntity()
	local selected = net.ReadUInt(32)

	if not npc:GetClass() == "ups_npc" then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end
	if npc.coolDown > CurTime() then return end
	npc.coolDown = CurTime() + 2

	if UPS.Core.ActiveDeliveries[ply:SteamID64()] then
		return
	end

	if not IsValid(ply.upstruck) then
		local truck = ents.Create("prop_vehicle_jeep")
		truck:SetPos(UPS.Config.TruckSpawnPos)
		truck:SetAngles(Angle(0, 0, 0))
		truck:SetModel("models/tdmcars/courier_truck.mdl")
		truck:SetKeyValue("vehiclescript", "scripts/vehicles/tdmcars/courier_truck.txt")
		truck:Spawn()
		truck:Activate()
		truck:SetVehicleClass("courier_trucktdm")
		truck:keysOwn(ply)
		truck:keysLock()
		truck:SetSkin(1)
		truck.owner = ply

		Quest.Core.ProgressQuest(ply, "delivery_boy", 2)

		ply.upstruck = truck
	end

	local pack = ents.Create("ups_package")
	pack:SetPos(npc:GetPos()+(npc:GetForward()*33)+(npc:GetUp()*35))
	pack:SetAngles(npc:GetAngles())
	pack:Spawn()
	pack:CPPISetOwner(ply)

	ply.upspackage = pack

	UPS.Core.ActiveDeliveries[ply:SteamID64()] = selected
	UPS.Core.RecentDeliveries[ply:SteamID64()] = UPS.Core.RecentDeliveries[ply:SteamID64()] or {}
	UPS.Core.RecentDeliveries[ply:SteamID64()][selected] = true
	timer.Simple( 5*60, function() 
		if not IsValid(ply) then return end
		if UPS.Core.ActiveDeliveries[ply:SteamID64()] and UPS.Core.ActiveDeliveries[ply:SteamID64()] == selected then
			ply.upslate = true
			XYZShit.Msg("UPS", UPS.Config.Color, "You're late! Pay reduced to $1,000", ply)
		end
		UPS.Core.RecentDeliveries[ply:SteamID64()][selected] = nil
	end )

	timer.Simple( 10*60, function() 
		if not IsValid(ply) then return end
		if UPS.Core.ActiveDeliveries[ply:SteamID64()] and UPS.Core.ActiveDeliveries[ply:SteamID64()] == selected then
			XYZShit.Msg("UPS", UPS.Config.Color, "You're very late! Oh well, let's not do this.", ply)
			ply:addMoney(reward)
			net.Start("xyz_ups_end")
			net.Send(ply)
			if IsValid(truck) then truck.hasPackage = nil end
			ply.upslate = nil
			UPS.Core.ActiveDeliveries[ply:SteamID64()] = nil
		end
	end )

	local del = UPS.Platforms
	net.Start("xyz_ups_select")
	net.WriteTable({name = del[selected].name, reward = del[selected].reward, pos = del[selected]:GetPos()})
	net.Send(ply)

	XYZShit.Msg("UPS", UPS.Config.Color, "Your UPS truck has been spawned. Grab your package and deliver it within 5 minutes!", ply)
end)


hook.Add("EntityRemoved", "xyz_ups_entremoved", function(ent)
	if IsValid(ent.owner) and IsValid(ent.owner.upspackage) then ent.owner.upspackage:Remove() end
	if ent:IsVehicle() and ent:GetVehicleClass() == "courier_trucktdm" then
		if IsValid(ent.owner) then
			ent.owner:addMoney(UPS.Config.LateDelivery)
			UPS.Core.ActiveDeliveries[ent.owner:SteamID64()] = nil
			net.Start("xyz_ups_end")
			net.Send(ent.owner)
		end
	end
end)

hook.Add("OnPlayerChangedTeam", "xyz_ups_jobchange", function(ply, before, after)
	if before == TEAM_UPSDRIVER then
		if IsValid(ply.upspackage) then ply.upspackage:Remove() end
		if IsValid(ply.upstruck) then ply.upstruck:Remove() end
		UPS.Core.ActiveDeliveries[ply:SteamID64()] = nil
		net.Start("xyz_ups_end")
		net.Send(ply)
	end
end)