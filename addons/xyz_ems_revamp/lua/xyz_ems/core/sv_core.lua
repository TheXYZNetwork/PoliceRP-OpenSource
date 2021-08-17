XYZEMS.DeathCache = XYZEMS.DeathCache or {}
XYZEMS.CanRespawn = XYZEMS.CanRespawn or {}

hook.Add("PlayerDeath", "EMSOnDeath", function(ply)
	local respawnTime = XYZEMS.Config.BaseRespawn
	if XYZEMS.Core.EMSOnline() then
		respawnTime = respawnTime + XYZEMS.Config.EMSRespawn
	end

	XYZEMS.CanRespawn[ply:SteamID64()] = os.time() + respawnTime

	net.Start("EMSOnPlayerDeath")
		net.WriteInt(respawnTime, 32)
	net.Send(ply)

	ply.EMSDeathWeps = {}
	for k, v in pairs(ply:GetWeapons()) do
		if v.xStore then continue end
		if XYZEMS.Config.Blacklist[v:GetClass()] then continue end
		table.insert(ply.EMSDeathWeps, v:GetClass())
	end
end)


hook.Add("PlayerDeathThink", "EMSCanRespawn", function(ply) -- Think, yikes!
	local respawnTime = XYZEMS.CanRespawn[ply:SteamID64()]
	if not respawnTime then return end
	if respawnTime > os.time() then
		respawnTime = nil
		return false
	end
end)

local coodown = {}
net.Receive("EMSCallForHelp", function(_, ply)
	if ply:Alive() then return end
	if ply:Team() == TEAM_EVENT then return end -- Don't want them calling EMS in an event

	if not coodown[ply] then coodown[ply] = 0 end
	if coodown[ply] > os.time() then return end
	coodown[ply] = os.time() + XYZEMS.Config.EMSRespawn
	if not XYZEMS.Core.EMSOnline() then return end

	local onlineEMS = XYZEMS.Core.EMSGetOnline()
	XYZShit.Msg("EMS", Color(155, 0, 0), ply:Name().." has requested EMS!", onlineEMS)

	net.Start("EMSBroadcastBodyLocation")
		net.WriteString(ply:SteamID64())
		net.WriteVector(ply:GetPos())
	net.Send(onlineEMS)
end)

hook.Add("PlayerSpawn", "EMSRemoveOnRespawn", function(ply)
	if XYZEMS.Core.EMSOnline() then
		local onlineEMS = XYZEMS.Core.EMSGetOnline()
	
		net.Start("EMSDropOnRespawn")
			net.WriteString(ply:SteamID64())
		net.Send(onlineEMS)
	end

	net.Start("EMSKillMenu")
	net.Send(ply)

	ply.EMSStabilized = false
	ply.wasP = nil
	ply.wasVP = nil
	XYZEMS.CanRespawn[ply:SteamID64()] = nil
end)

local userCooldown = {}
net.Receive("EMSRevivePly", function(_, ply)
	if not ply:HasWeapon("xyz_defibs") then return end

	if XYZShit.CoolDown.Check("EMSRevivePly", 4, ply) then return end

	local target = net.ReadEntity()
	if target:Alive() then return end

	if target:GetPos():Distance(ply:GetPos()) > 1000 then return end

	if not userCooldown[target] then userCooldown[target] = 0 end
	if userCooldown[target] < os.time() then
		ply:addMoney(XYZEMS.Config.EMSReward)
		userCooldown[target] = os.time() + (10*60)
	end

	target.EMSWasRevived = true
	target.EMSWasRevivedPos = target:GetPos()
	
	hook.Call("XYZEMSRevive", nil, target, ply)

	target:Spawn()
end)

net.Receive("EMSRequestRespawn", function(_, ply)
	if ply:Alive() then return end

	local respawnTime = XYZEMS.CanRespawn[ply:SteamID64()]
	if not respawnTime then return end
	if respawnTime > os.time() then return end

	local dethPos = ply:GetPos()
	ply:Spawn()

	if player.GetCount() > (game.MaxPlayers()*XYZEMS.Config.BodyBagPerCap) then return end

	if not XYZEMS.Core.EMSOnline() then return end
	if XYZEMS.Core.IsEMS(ply) then return end

	local chance = math.random(100)
	if chance < XYZEMS.Config.BodyBagPerCap then return end

	local ent = ents.Create("xyz_bodybag")
	ent:SetPos(dethPos)
	ent:SetAngles(ply:GetAngles())
	ent:Spawn()

	timer.Simple(XYZEMS.Config.BodyBagDespawn, function()
		if not IsValid(ent) then return end
		ent:Remove()
	end)


	timer.Simple(0.1, function()
		net.Start("EMSBroadcastBodyBagLocation")
			net.WriteEntity(ent)
		net.Send(XYZEMS.Core.EMSGetOnline())
	end)
end)

net.Receive("EMSStabilize", function(_, ply)
	if not ply:isCP() then return end
	if not XYZEMS.Core.EMSOnline() then return end

	local target = net.ReadEntity()
	if not IsValid(target) then return end
	if target:Alive() then return end

	if target:GetPos():Distance(ply:GetPos()) > 300 then return end
	if target.EMSStabilized then XYZShit.Msg("EMS", Color(155, 0, 0), target:Name().." has already been stabilized", ply) return end
	if not XYZEMS.CanRespawn[target:SteamID64()] then return end

	target.EMSStabilized = true
	XYZEMS.CanRespawn[target:SteamID64()] = XYZEMS.CanRespawn[target:SteamID64()] + XYZEMS.Config.EMSStabilize

	XYZShit.Msg("EMS", Color(155, 0, 0), "You have stabilized "..target:Name(), ply)

	net.Start("EMSUpdateStabilityTime")
	net.Send(target)


	local onlineEMS = XYZEMS.Core.EMSGetOnline()
	XYZShit.Msg("EMS", Color(155, 0, 0), target:Name().." has been stabilized!", onlineEMS)

	net.Start("EMSBroadcastBodyLocation")
		net.WriteString(target:SteamID64())
		net.WriteVector(target:GetPos())
	net.Send(onlineEMS)
end)

local optimalOffset = Vector(0, 0, 1)
hook.Add("PlayerSelectSpawn", "EMS:Revive", function(ply)
	if not ply.EMSWasRevived then return end

	if ply.EMSDeathWeps then
		for k, v in pairs(ply.EMSDeathWeps) do
			if v == "weapon_cuffed" or v == "weapon_ziptied" then continue end
			ply:Give(v)
		end
	end
	
	ply:SetHealth(5)
	ply:SetArmor(0)

    timer.Simple(5, function()
    	if not IsValid(ply) then return end
		ply.EMSWasRevived = nil
		ply.EMSDeathWeps = nil       
    end)


    local optimalSpawnPos = ply.EMSWasRevivedPos

	for i=0, 360, 45 do
		local rad = math.rad(i)
		local dir = Vector(math.cos(rad), math.sin(rad), 0)
		-- Build a ring of positions around the point of wanting to spawn
		local startPos = optimalSpawnPos + dir * 15

		-- Get the ends in those points
		local trace = ents.FindAlongRay(startPos, startPos + optimalSpawnPos)

		if not table.IsEmpty(trace) then continue end

		optimalSpawnPos = startPos
		break
	end


	return NULL, optimalSpawnPos
end)