function XYZTrucker.Core.FinishedJob(ply)
	ply.truck_activeJob = false
	--if IsValid(ply.truck_truck) then
	--	ply.truck_truck:Remove()
	--	ply.truck_truck = nil
	--end
	if IsValid(ply.truck_trailer) then
		ply.truck_trailer:Remove()
		ply.truck_trailer = nil
	end
	ply.truck_platform = nil

	local loadTable = XYZTrucker.Core.Loads[ply.truck_load]

	XYZShit.Msg("Trucking Agency", Color(140, 140, 200), "You have completed a "..loadTable.name.." job. Your pay is "..DarkRP.formatMoney(loadTable.price).."!", ply)
	ply:addMoney(loadTable.price)

	Quest.Core.ProgressQuest(ply, "honk_honk", 3)
	Quest.Core.ProgressQuest(ply, "honk_honk", 4)

	ply.truck_load = nil
	net.Start("xyz_trucker_send_end")
	net.Send(ply)
end

function XYZTrucker.Core.CancelJob(ply)
	if IsValid(ply.truck_truck) then
		ply.truck_truck:Remove()
		ply.truck_truck = nil
	end
	if IsValid(ply.truck_trailer) then
		ply.truck_trailer:Remove()
		ply.truck_trailer = nil
	end
	ply.truck_platform = nil

	if ply.truck_activeJob then
		XYZShit.Msg("Trucking Agency", Color(140, 140, 200), "You have failed your job. You can pick up another job at the Trucking Agency.", ply)
	else
		XYZShit.Msg("Trucking Agency", Color(140, 140, 200), "Your truck has been despawned.", ply)
	end

	ply.truck_activeJob = false

	ply.truck_load = nil
	net.Start("xyz_trucker_send_end")
	net.Send(ply)
end

net.Receive("xyz_trucker_request_job", function(_, ply)
	local npc = net.ReadEntity()
	if npc:GetClass() != "trucker_npc" then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end

	if npc.coolDown > CurTime() then return end
	npc.coolDown = CurTime() + 30

	-- Check if he has access to use it
	if not (ply:Team() == TEAM_TRUCKER) then return end
	if ply.truck_activeJob then return end

	local loadKey = net.ReadInt(32)
	local load = XYZTrucker.Core.Loads[loadKey]

	local truckClass = table.Random(XYZTrucker.Core.Trucks)
	local trailerClass = table.Random(load.loads)


	ply.truck_activeJob = true

	local truck = ents.Create("prop_vehicle_jeep")
	truck:SetPos(XYZTrucker.Core.TruckSpawn)
	truck:SetAngles(Angle(0, 0, 0))
	truck:SetModel(list.Get("Vehicles")[truckClass].Model)
	truck:SetKeyValue("vehiclescript", list.Get("Vehicles")[truckClass].KeyValues.vehiclescript)
	truck:Spawn()
	truck:Activate()
	truck:SetVehicleClass(truckClass)
	truck:keysOwn(ply)

	ply:EnterVehicle(truck)

	local trailer = ents.Create("prop_vehicle_jeep")
	trailer:SetPos(table.Random(XYZTrucker.Core.TrailerSpawns))
	trailer:SetAngles(Angle(0, 0, 0))
	trailer:SetModel(list.Get("Vehicles")[trailerClass].Model)
	trailer:SetKeyValue("vehiclescript", list.Get("Vehicles")[trailerClass].KeyValues.vehiclescript)
	trailer:Spawn()
	trailer:Activate()
	trailer:SetVehicleClass(trailerClass)
	trailer:keysOwn(ply)
	trailer.driver = ply

	ply.truck_truck = truck
	ply.truck_trailer = trailer
	ply.truck_load = loadKey

	local ranNumber = math.random(#XYZTrucker.Platforms)
	ply.truck_platform = XYZTrucker.Platforms[ranNumber]

	XYZShit.Msg("Trucking Agency", Color(140, 140, 200), "Deliver the trailer to the shown location, then you'll get paid.", ply)

	Quest.Core.ProgressQuest(ply, "honk_honk", 2)

	timer.Simple(0.5, function()
		net.Start("xyz_trucker_send_active_data")
			net.WriteEntity(ply.truck_trailer)
			net.WriteVector(ply.truck_platform:GetPos())
		net.Send(ply)
	end)
end)

hook.Add("PlayerLeaveVehicle", "truck_remove_trucks", function(ply, vehicle)
	-- check the users job
	--if ply == vehicle:Getowning_ent() then
	if ply.truck_truck == vehicle then
		XYZTrucker.Core.CancelJob(ply)
	end
	--end
end)