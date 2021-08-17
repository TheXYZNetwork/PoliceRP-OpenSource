local allowed_ents = {
	["xyz_portable_radio"] = true,
	["xyz_dj_set"] = true,
}

net.Receive("CarRadio:ChangeChannel", function(_, ply)
	if XYZShit.CoolDown.Check("CarRadio:ChangeChannel", 1, ply) then return end

	local car = ply:GetVehicle()
	if not IsValid(car) then
		car = net.ReadEntity()
		if car:GetPos():DistToSqr(ply:GetPos()) > 500000 then return end
		if not allowed_ents[car:GetClass()] then return end
	else
	if car:GetClass() == "prop_vehicle_prisoner_pod" then return end
	end
	if not car then return end

	if not car:GetNWBool("CarDealer:Radio", false) then return end

	local channel = net.ReadUInt(5)

	if not CarRadio.Config.Channels[channel] then return end

	car:SetNWInt("CarRadio:Channel", channel)
	car:SetNWBool("CarRadio:On", true)

	net.Start("CarRadio:ResetRadio")
		net.WriteEntity(car)
	net.Broadcast()
end)


net.Receive("CarRadio:ToggleRadio", function(_, ply)
	if XYZShit.CoolDown.Check("CarRadio:ToggleRadio", 1, ply) then return end
	
	local car = ply:GetVehicle()
	if not IsValid(car) then
		car = net.ReadEntity()
		if car:GetPos():DistToSqr(ply:GetPos()) > 500000 then return end
		if not allowed_ents[car:GetClass()] then return end
	else
		if car:GetClass() == "prop_vehicle_prisoner_pod" then return end
	end
	if not car then return end

	if not car:GetNWBool("CarDealer:Radio", false) then return end

	car:SetNWBool("CarRadio:On", !car:GetNWBool("CarRadio:On", false))
end)

net.Receive("CarRadio:ChangeVolume", function(_, ply)
	if XYZShit.CoolDown.Check("CarRadio:ChangeVolume", 0.2, ply) then return end

	local car = ply:GetVehicle()
	if not IsValid(car) then
		car = net.ReadEntity()
		if car:GetPos():DistToSqr(ply:GetPos()) > 500000 then return end
		if not allowed_ents[car:GetClass()] then return end
	else
		if car:GetClass() == "prop_vehicle_prisoner_pod" then return end
	end
	if not car then return end

	if not car:GetNWBool("CarDealer:Radio", false) then return end
	
	local vol = net.ReadUInt(5)

	if vol > 30 then return end
	if vol < 1 then return end

	car:SetNWInt("CarRadio:Volume", vol)

	net.Start("CarRadio:BroadcastVolume")
		net.WriteEntity(car)
		net.WriteUInt(vol, 5)
	net.Broadcast()
end)