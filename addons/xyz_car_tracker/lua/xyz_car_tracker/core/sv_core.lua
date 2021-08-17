hook.Add("playerWarranted", "CarTracker:Warranted", function(criminal, actor, reason)
	local plyCar = criminal.currentVehicle

	-- Has no active car
	if not IsValid(plyCar) then return end
	-- Hasn't got a tracker
	if not tobool(plyCar:GetNWString("xyz_tracker")) then return end

	local govPlys = {}
	for k, v in pairs(player.GetAll()) do
		if XYZShit.Jobs.Government.List[v:Team()] or table.HasValue(XYZShit.Jobs.Government.FR, v:Team()) then
			table.insert(govPlys, v)
		end
	end

	net.Start("CarTracker:AddTracking")
		net.WriteEntity(criminal)
		net.WriteEntity(plyCar)
	net.Send(govPlys)
end)

hook.Add("playerUnWarranted", "CarTracker:Warranted", function(criminal)
	local plyCar = criminal.currentVehicle

	-- Has no active car
	if not IsValid(plyCar) then return end
	-- Hasn't got a tracker
	if not tobool(plyCar:GetNWString("xyz_tracker")) then return end

	local govPlys = {}
	for k, v in pairs(player.GetAll()) do
		if XYZShit.IsGovernment(v:Team(), true) then
			table.insert(govPlys, v)
		end
	end

	net.Start("CarTracker:RemoveTracking")
		net.WriteEntity(criminal)
	net.Send(govPlys)
end)

hook.Add("PlayerDeath", "CarTracker:Wipe", function(ply)
	if XYZShit.IsGovernment(ply:Team(), true) then return end
	
	net.Start("CarTracker:Wipe")
	net.Send(ply)
end)