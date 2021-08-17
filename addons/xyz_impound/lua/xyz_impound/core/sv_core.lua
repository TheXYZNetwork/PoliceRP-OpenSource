hook.Add("InitPostEntity", "Impound:Load", function(ply)
	Impound.Database.Load(function(data)
		for k, v in pairs(data) do
			Impound.Vehicles[v.id] = true
		end
	end)
end)

function Impound.Core.Clamp(car, clamper, price)
	if not IsValid(car) then return end

	local owner = car:getDoorOwner()
	if not IsValid(owner) then
		car:Remove()
		return
	end

	local wheelPoint = car:LookupAttachment("wheel_fr")
	local wheel = car:GetAttachment(wheelPoint)

	local ent = ents.Create("prop_dynamic")
	ent:SetModel("models/freeman/wheel_clamp.mdl")
	ent:SetPos(wheel.Pos + (wheel.Ang:Forward()*3) + (wheel.Ang:Right()*4))
	ent:SetAngles(Angle(wheel.Ang.x, wheel.Ang.y, wheel.Ang.z))
	ent:SetParent(car)
	car.isClamped = ent
	ent.price = price
	ent.clamper = clamper
	ent:Spawn()

	if IsValid(car:GetDriver()) then
		car:GetDriver():ExitVehicle()
	end

	hook.Run("XYZImpoundClamp", clamper, owner, car)
	xLogs.Log(xLogs.Core.Player(clamper).." has just clamped "..xLogs.Core.Player(owner).."'s "..xLogs.Core.Color(car:GetVehicleClass(), Color(0, 0, 200)), "Impound")

	XYZShit.Msg("Impound", Color(200, 60, 120), "Your car has been clamped. If you do not pay for it to be unclamped soon, it will be impounded...", owner)

	timer.Create("Impound:Clamp:"..car:EntIndex(), 60*Impound.Config.ClampTime, 1, function()
		if not IsValid(car) then return end

		Impound.Core.Impound(car, clamper)
	end)
end

function Impound.Core.Impound(car, clamper)
	local owner = car:getDoorOwner()

	if car.vehicleID then
		Impound.Vehicles[car.vehicleID] = true
		Impound.Database.Add(car.vehicleID, IsValid(clamper) and clamper:SteamID64() or false)
	end
	if IsValid(owner) then
		XYZShit.Msg("Impound", Color(200, 60, 120), "Your vehicle has been impounded. You can pay the fee when you next attempt to spawn this vehicle.", owner)
	end
	xLogs.Log(xLogs.Core.Player(owner).."'s "..xLogs.Core.Color(car:GetVehicleClass(), Color(0, 0, 200)).." has just been impounded.", "Impound")

	car:Remove()
end

net.Receive("Impound:Unimpound", function(_, ply)
	local vehicleID = net.ReadUInt(32)
	if not vehicleID then return end
	if not Impound.Vehicles[vehicleID] then return end

	local vehicle = CarDealer.Vehicles[ply:SteamID64()][vehicleID] 
	if not vehicle then return end

	if not ply:canAfford(Impound.Config.ImpoundFee) then
		XYZShit.Msg("Impound", Color(200, 60, 120), "You cannot afford the impound fee...", owner)
		return
	end

	ply:addMoney(-Impound.Config.ImpoundFee)
	Impound.Vehicles[vehicleID] = false
	Impound.Database.Remove(vehicleID)

	xLogs.Log(xLogs.Core.Player(ply).."'s "..xLogs.Core.Color(vehicle.class, Color(0, 0, 200)).."'s impound fee has been paid.", "Impound")

	XYZShit.Msg("Impound", Color(200, 60, 120), "You have paid the fee to have your impound removed!", ply)
end)

net.Receive("Impound:Unclamp", function(_, ply)
	local vehicle = net.ReadEntity()

	if not IsValid(vehicle) then return end
	if not vehicle:IsVehicle() then return end

	local vehicleID = vehicle.vehicleID
	if not IsValid(vehicle.isClamped) then return end

	local owner = vehicle:getDoorOwner()
	if not IsValid(owner) then return end
	if not (ply == owner) then return end


	local price = vehicle.isClamped.price

	if not ply:canAfford(price) then
		XYZShit.Msg("Impound", Color(200, 60, 120), "You cannot afford the impound fee...", owner)
		return
	end

	ply:addMoney(-price)
	if IsValid(vehicle.isClamped.clamper) then
		vehicle.isClamped.clamper:addMoney(price * 0.5)
		XYZShit.Msg("Impound", Color(200, 60, 120), "You have been paid "..DarkRP.formatMoney(price * 0.5).." because of a vehicle you clamped", vehicle.isClamped.clamper)
	end

	vehicle.isClamped:Remove()
	vehicle.isClamped = nil
	
	timer.Remove("Impound:Clamp:"..vehicle:EntIndex())
	xLogs.Log(xLogs.Core.Player(owner).."'s "..xLogs.Core.Color(vehicle:GetVehicleClass(), Color(0, 0, 200)).."'s clamp fee has been paid.", "Impound")

	XYZShit.Msg("Impound", Color(200, 60, 120), "You have paid the fee to have your vehicle unclamped!", owner)
end)

hook.Add("CarDealerCanSpawn", "Impound:Block", function(ply, vehicle)
	local vehicleID = vehicle.id
	if not vehicleID then return end
	if not Impound.Vehicles[vehicleID] then return end

	net.Start("Impound:UI:Impound")
		net.WriteUInt(vehicleID, 32)
	net.Send(ply)

	return false, "This vehicle is currently impounded."
end)

hook.Add("CanPlayerEnterVehicle", "Impound:Clamp", function(ply, vehicle)
	if not vehicle.isClamped then return end
	local owner = vehicle:getDoorOwner()
	if not IsValid(owner) then return end


	if not (ply == owner) then return false end

	net.Start("Impound:UI:Clamp")
		net.WriteEntity(vehicle)
		net.WriteUInt(vehicle.isClamped.price, 32)
	net.Send(ply)

	return false
end)