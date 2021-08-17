CarRadio.Core.Cache = CarRadio.Core.Cache or {}

function CarRadio.Core.StartRadio(entity, channel, key, type)
	if not CarRadio.Config.Channels[channel] then return end
	if not CarRadio.Core.Cache[key] then return end

	CarRadio.Core.Cache[key].attemptingToCreate = true
	
	sound.PlayURL(CarRadio.Config.Channels[channel].url, type or "3d", function(station, errorID, errorReason)
		if not CarRadio.Core.Cache[key] then return end

		if not (entity:GetNWInt("CarRadio:Channel", 1) == channel) then
			CarRadio.Core.Cache[key].attemptingToCreate = false
			return
		end

	    if not IsValid(station) then
			if errorID == 21 then
				CarRadio.Core.StartRadio(entity, channel, key, "mono")
			end
			return
		end
		CarRadio.Core.Cache[key].attemptingToCreate = false
	    if not IsValid(entity) then
	    	return
	    end

	    station:SetPos(entity:GetPos())
	    station:Play()
	    station:Set3DFadeDistance(200, 100000000)
	    station:SetVolume(math.Clamp(entity:GetNWInt("CarRadio:Volume", 10), 0, XYZSettings.GetSetting("cardradio_volume_cap", 30))/10)

	    CarRadio.Core.Cache[key].station = station
	end)
end

net.Receive("CarRadio:ResetRadio", function()
	local car = net.ReadEntity()

	if not IsValid(car) then return end

	local cache = CarRadio.Core.Cache[car:EntIndex()]
	if not cache then
		CarRadio.Core.Cache[car:EntIndex()] = {entity = car}
		return
	end

	if cache.station then
		cache.station:Stop()
	end
	cache.station = nil
	cache.attemptingToCreate = nil
end)

net.Receive("CarRadio:BroadcastVolume", function()
	local car = net.ReadEntity()

	if not IsValid(car) then return end

	local cache = CarRadio.Core.Cache[car:EntIndex()]
	if not cache then
		CarRadio.Core.Cache[car:EntIndex()] = {entity = car}
		return
	end
	if not cache.station then return end

	local vol = net.ReadUInt(5)
	vol = math.Clamp(vol, 0, XYZSettings.GetSetting("cardradio_volume_cap", 30))
	cache.station:SetVolume(vol/10)
end)

hook.Add("OnEntityCreated", "CarRadio:VehicleCreated", function(entity)
	if (not entity:IsVehicle()) and (not (entity:GetClass() == "xyz_portable_radio") and (not (entity:GetClass() == "xyz_dj_set"))) then return end

	CarRadio.Core.Cache[entity:EntIndex()] = {entity = entity}
end)

local limit = 200000

hook.Add("Think", "CarRadio:PlayRadio", function()
	if not XYZSettings.GetSetting("cardradio_toggle_play", true) then return end
	for k, v in pairs(CarRadio.Core.Cache) do
		-- Remove all invalid vehicles
		if not IsValid(v.entity) then
			if v.station then
				v.station:Stop()
				v.station = nil
			end

			CarRadio.Core.Cache[k] = nil
			continue
		end

		if not v.entity:GetNWBool("CarRadio:On", false) then
			if v.station then
				v.station:Stop()
				v.station = nil
			end
			continue
		end

		if v.entity:GetClass() == "xyz_dj_set" then
			limit = 450000
		end

		if LocalPlayer():GetPos():DistToSqr(v.entity:GetPos()) > limit then
			if v.station then
				v.station:Stop()
				v.station = nil
			end
			continue
		end

		if (not v.station) and (not v.attemptingToCreate) then
			CarRadio.Core.StartRadio(v.entity, v.entity:GetNWInt("CarRadio:Channel", 1), k)
		elseif v.station then
			v.station:SetPos(v.entity:GetPos())
		end
	end
end)

hook.Add("PlayerButtonDown", "CarRadio:OpenMenu", function(ply, button)
	if not (ply == LocalPlayer()) then return end
	if not (button == KEY_F) then return end
	if not IsValid(LocalPlayer():GetVehicle()) then return end
	if LocalPlayer():GetVehicle():GetClass() == "prop_vehicle_prisoner_pod" then return end
	if not LocalPlayer():GetVehicle():GetNWBool("CarDealer:Radio", false) then return end
	if XYZShit.CoolDown.Check("CarRadio:OpenMenu", 1) then return end

	CarRadio.OpenMenu(LocalPlayer():GetVehicle())
end)

concommand.Add("carradio_openmenu", function()
	if not IsValid(LocalPlayer():GetVehicle()) then return end
	if LocalPlayer():GetVehicle():GetClass() == "prop_vehicle_prisoner_pod" then return end
	if not LocalPlayer():GetVehicle():GetNWBool("CarDealer:Radio", false) then return end

	CarRadio.OpenMenu(LocalPlayer():GetVehicle())
end)

net.Receive("CarRadio:OpenPortableUI", function()
	local ent = net.ReadEntity()
	if not ent then return end

	CarRadio.OpenMenu(ent)
end)