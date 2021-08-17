function XYZFire.Core.StartFire()
	local origin = table.Random(XYZFire.Config.Origin)
	local originProcessed = origin + Vector(math.random(-XYZFire.Config.OriginArea, XYZFire.Config.OriginArea), math.random(-XYZFire.Config.OriginArea, XYZFire.Config.OriginArea), 0)

	local fire = ents.Create("xyz_fire_origin")
	if not IsValid(fire) then return end
	fire:SetPos(originProcessed)
	fire:Spawn()

	if not util.IsInWorld(fire:GetPos()) then fire:Remove() end

	return fire
end

hook.Add("xAdminPostInit", "XYZFire:PostxAdminInit", function()
	xAdmin.Core.RegisterCommand("removefires", "Removes all fires", 40, function(admin, args)
		for k, v in pairs(XYZFire.AllFires) do 
			v:Remove()
		end
		xAdmin.Core.Msg({admin, " removed all fires."})
	end)
end)


hook.Add("InitPostEntity", "XYZFire:PostEntity", function()
	timer.Create("XYZFire:StartFire", XYZFire.Config.StartFire, 0, function()
		local fdCount = 0
		for k, v in pairs(player.GetAll()) do
			if table.HasValue(XYZShit.Jobs.Government.FR, v:Team()) then
				fdCount = fdCount + 1
			end
		end
		if fdCount < XYZFire.Config.MinimumFD then return end
	
		for k, v in pairs(XYZFire.AllFires) do
			if not IsValid(v) then
				XYZFire.AllFires[k] = nil
			end
		end

		if #XYZFire.AllFires >= XYZFire.Config.MaxActiveFires then return end

		XYZFire.Core.StartFire()
	end)
end)

concommand.Add("getentpos", function(ply)
	local ent = ply:GetEyeTrace().Entity
	print(ent:GetPos())
end)

hook.Add("PlayerChangedTeam", "XYZFire:RemoveFires", function(ply, old, new)
	if not table.HasValue(XYZShit.Jobs.Government.FR, old) then return end

	local fdCount = 0
	for k, v in pairs(player.GetAll()) do
		if table.HasValue(XYZShit.Jobs.Government.FR, v:Team()) then
			fdCount = fdCount + 1
		end
	end
	if fdCount >= XYZFire.Config.MinimumFD then return end

	for k, v in pairs(XYZFire.AllFires) do
		v:Remove()
	end
end)