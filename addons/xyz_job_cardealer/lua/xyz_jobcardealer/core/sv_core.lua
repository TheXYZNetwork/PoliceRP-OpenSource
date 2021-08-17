net.Receive("JobCarDealer:SpawnVehicle:Custom", function(_, ply)
	if XYZShit.CoolDown.Check("JobCarDealer:SpawnVehicle", 2, ply) then return end

	local npc = net.ReadEntity()
	local carKey = net.ReadInt(32)
	local customs = net.ReadTable()

	JobCarDealer.SpawnCar(ply, npc, carKey, customs)
end)
net.Receive("JobCarDealer:SpawnVehicle", function(_, ply)
	if XYZShit.CoolDown.Check("JobCarDealer:SpawnVehicle", 2, ply) then return end

	local npc = net.ReadEntity()
	local carKey = net.ReadInt(32)

	JobCarDealer.SpawnCar(ply, npc, carKey)
end)

function JobCarDealer.SpawnCar(ply, npc, carKey, customs)
	if not carKey then return end

	if not npc.CarSpawner then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end
	if npc.cooldown > CurTime() then
		XYZShit.Msg(npc.PrintName, Color(40, 40, 40), "Please wait a moment before trying to collect a vehicle.", ply)
		return
	end

	local carData = npc.Config.Vehicles[carKey]
	if not carData then return end

	local carInfo = list.Get("Vehicles")[carData.class]
	if not carInfo then return end
	
	if IsValid(ply.JobCarDealerCurCar) then return end

	if not carData.canAccess(ply) then return end

	if JobCarDealer.Config.PreventPartners and (JobCarDealer.Config.PreventPartnersPlayerCount <= player.GetCount()) then
		local partner = ply.currentPartner
		if IsValid(partner) and IsValid(partner.JobCarDealerCurCar) then
			XYZShit.Msg(npc.PrintName, Color(40, 40, 40), "Your partner already has a vehicle out!", ply)
			return
		end
	end

	if not ply:HasWeapon("weapon_drivers_license") then
		XYZShit.Msg(npc.PrintName, Color(40, 40, 40), "You need a Driver's License in order to pick up a vehicle from here.", ply)
		return
	end

	if carData.max then
		if not JobCarDealer.Max[npc:GetClass()] then
			JobCarDealer.Max[npc:GetClass()] = {}
		end
		if not JobCarDealer.Max[npc:GetClass()][carKey] then
			JobCarDealer.Max[npc:GetClass()][carKey] = {}
		end
		for k, v in pairs(JobCarDealer.Max[npc:GetClass()][carKey]) do
			if not IsValid(v) then
				JobCarDealer.Max[npc:GetClass()][carKey][k] = nil
			end
		end

		if table.Count(JobCarDealer.Max[npc:GetClass()][carKey]) >= carData.max then
			XYZShit.Msg(npc.PrintName, Color(40, 40, 40), "The max of this vehicle has already been spawned!", ply)
			return
		end
	end



	local car = ents.Create("prop_vehicle_jeep")
	car:SetPos(npc:GetPos() + (npc:GetForward() * 100))
	car:SetAngles(npc:GetAngles() + Angle(0, 180, 0))
	car:SetModel(carInfo.Model)
	car:SetKeyValue("vehiclescript", carInfo.KeyValues.vehiclescript)
	car:Spawn()
	car:Activate()
	car:SetVehicleClass(carData.class)
	car:keysOwn(ply)
	car.owner = ply

	if carData.editable and customs then
		for k, v in pairs(customs) do
			car:SetBodygroup(k, v)
		end
	end

	hook.Add("VC_postVehicleInit", "JobCarDealer:LoadCar"..ply:SteamID(), function(ent)
		hook.Remove("VC_postVehicleInit", "JobCarDealer:LoadCar"..ply:SteamID())
		
		if not IsValid(ply) then -- User DCed or something?
			car:Remove()
			return
		end

		if carData.postSpawn then
			carData.postSpawn(car, ply)
		end

		car.CarDealerAlarm = true
		car.CarDealerPunctionPrevention = 50
		car:SetNWString("CarDealer:Radio", "true")

		XYZShit.ApplyTracker(car, ply)
	
		local healthMax = car:VC_getHealthMax() or 100
		local newHealth = healthMax* (carData.healthMutliplier or 2)
		if car:GetVehicleClass() == "perryn_bearcat_g3" then
			car:VC_setHealthMax(healthMax+newHealth*100)
			car:VC_setHealth(healthMax+newHealth*100)
		else
			car:VC_setHealthMax(healthMax+newHealth)
			car:VC_setHealth(healthMax+newHealth)
		end
		if PNC.Config.AllowedVehicles[carData.class] then
			XYZShit.Msg(npc.PrintName, Color(40, 40, 40), "This vehicle has a computer. Use !pnc to access it", ply)
		end

		if IsValid(ply.currentPartner) then
			net.Start("xyz_partner_data")
				net.WriteEntity(ply)
				net.WriteEntity(ply.JobCarDealerCurCar)
			net.Send(ply.currentPartner)
		end
	end)

	ply:EnterVehicle(car)
	ply.JobCarDealerCurCar = car

	if carData.max then
		table.insert(JobCarDealer.Max[npc:GetClass()][carKey], car)
	end

	npc.cooldown = CurTime() + 10

	XYZShit.Msg(npc.PrintName, Color(40, 40, 40), "Your vehicle has been spawned.", ply)
end

hook.Add("OnPlayerChangedTeam", "JobCarDealer:TeamChange", function(ply, old, new)
	if IsValid(ply.JobCarDealerCurCar) then
		ply.JobCarDealerCurCar:Remove()
	elseif IsValid(ply.currentVehicle) and XYZShit.IsGovernment(new, true) and (not table.HasValue(XYZShit.Jobs.Government.FBI, new)) then
		ply.currentVehicle:Remove()
		XYZShit.Msg("Server", Color(83, 210, 210), "We have removed your personal vehicle as you have joined a government job.", ply)
	end
end)

hook.Add("PlayerDisconnected", "JobCarDealer:PlyLeave", function(ply)
	if IsValid(ply.JobCarDealerCurCar) then
		ply.JobCarDealerCurCar:Remove()
	end
end)