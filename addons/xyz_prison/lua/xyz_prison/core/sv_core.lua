function PrisonSystem.Arrest(ply, time)
	-- Just demote the president
	if (ply:Team() == TEAM_PRESIDENT) or (ply:Team() == TEAM_VICE_PRESIDENT) then
		ply:changeTeam(TEAM_CITIZEN, true, true)
		xLogs.Log(xLogs.Core.Player(ply).." has been demoted to citizen as they were arrested as a (Vice) President.", "Prison")
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "The (Vice) President has been arrested and as a result: was demoted!")
		return
	end

	-- Can't arrest government, silly
	if XYZShit.IsGovernment(ply:Team(), true) then return end

	if PrisonSystem.Arrested[ply:SteamID64()] then
		PrisonSystem.Arrested[ply:SteamID64()].length = PrisonSystem.Arrested[ply:SteamID64()].length + PrisonSystem.Config.EscapeTimeout
		
		ply:Spawn()

		-- Let's see if this fixes issues
		ply:changeTeam(PrisonSystem.Config.Prisoner, true, true)
		ply:SetTeam(PrisonSystem.Config.Prisoner)

		local arrestData = PrisonSystem.Arrested[ply:SteamID64()]
		local timeLeft = (arrestData.length - (os.time() - arrestData.start)) + PrisonSystem.Config.EscapeTimeout
		net.Start("PrisonSystem:Sentence")
			net.WriteEntity(ply)
			net.WriteUInt(timeLeft, 10)
		net.Broadcast()


		timer.Adjust("PrisonSystem:Jailed:"..ply:SteamID64(), timeLeft)

		xLogs.Log(xLogs.Core.Player(ply).." has been re-arrested for "..PrisonSystem.Config.EscapeTimeout.." more seconds due to jail break.", "Prison")
		return
	end

	PrisonSystem.Arrested[ply:SteamID64()] = {
		start = os.time(),
		length = time
	}

	ply:changeTeam(PrisonSystem.Config.Prisoner, true, true)
	ply:SetTeam(PrisonSystem.Config.Prisoner)
	timer.Simple(1, function()
		ply:setDarkRPVar("job", team.GetName(PrisonSystem.Config.Prisoner))
	end)
	ply:unWarrant()
	ply:unWanted()

	net.Start("PrisonSystem:Sentence")
		net.WriteEntity(ply)
		net.WriteUInt(time, 10)
	net.Broadcast()

	timer.Create("PrisonSystem:Jailed:"..ply:SteamID64(), time, 1, function()
		if not IsValid(ply) then return end

		PrisonSystem.UnArrest(ply)
	end)

	Quest.Core.ProgressQuest(ply, "jail_break", 1)

	xLogs.Log(xLogs.Core.Player(ply).." has been arrested for "..time.." seconds.", "Prison")
end

function PrisonSystem.UnArrest(ply)
	if ply:XYZIsArrested() then return end

	ply:XYZUnarrest(ply)
	ply:changeTeam(TEAM_CITIZEN, true, true)
	ply:SetTeam(TEAM_CITIZEN)
	
	ply:unWarrant()
	ply:unWanted()

	ply:Spawn()

	PrisonSystem.Arrested[ply:SteamID64()] = nil

	timer.Remove("PrisonSystem:Jailed:"..ply:SteamID64())

	net.Start("PrisonSystem:Sentence:Destroy")
		net.WriteEntity(ply)
	net.Broadcast()

	xLogs.Log(xLogs.Core.Player(ply).." has been unarrested.", "Prison")
end


function PrisonSystem.RegisterJob(job, startJob, endJob)
	print("Registering job", job)
	PrisonSystem.Jobs[job] = {}
	PrisonSystem.Jobs[job].name = job
	PrisonSystem.Jobs[job].startJob = startJob
	PrisonSystem.Jobs[job].endJob = endJob
end

-- We have to run this server side so we can load the files to send to the client.
function PrisonSystem.FindJobs()
	print("Running job finder")
	for _, File in SortedPairs(file.Find("xyz_prison/core/jobs/*.lua", "LUA"), true) do
		print("	", "Found:", File)
		if SERVER then
			AddCSLuaFile("xyz_prison/core/jobs/" .. File)
	        include("xyz_prison/core/jobs/" .. File)
		else
	   		include("xyz_prison/core/jobs/" .. File)
		end	
	end
end
PrisonSystem.FindJobs()

hook.Add("XYZHandcuffsUncuffed", "PrisonSystem:ReleaseOnUncuff", function(arrester, ply)
	if not PrisonSystem.Arrested[ply:SteamID64()] then return end
	if timer.Exists("PrisonSystem:Jailed:"..ply:SteamID64()) then return end
	if arrester == ply then return end

	PrisonSystem.UnArrest(ply)
end)

net.Receive("PrisonSystem:StartJob", function(_, ply)
    if XYZShit.CoolDown.Check("PrisonSystem:StartJob", 2, ply) then return end

	if not (ply:Team() == PrisonSystem.Config.Prisoner) then return end

	-- Check distance
	local ent = net.ReadEntity()
    if ent:GetPos():Distance(ply:GetPos()) > 500 then return end

	local jobName = net.ReadString()
	local job = PrisonSystem.Jobs[jobName]
	-- Not a valid job
	if not job then return end

	-- Already that job
	if PrisonSystem.ActiveJobs[ply:SteamID64()] and (PrisonSystem.ActiveJobs[ply:SteamID64()].name == job.name) then return end

	-- Clear old job
	if PrisonSystem.ActiveJobs[ply:SteamID64()] then
		PrisonSystem.ActiveJobs[ply:SteamID64()].endJob(ply)
	end

	PrisonSystem.ActiveJobs[ply:SteamID64()] = job
	-- Start the job
	job.startJob(ply)

	XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "You have started the job: "..PrisonSystem.Config.Jobs[job.name], ply)

	xLogs.Log(xLogs.Core.Player(ply).." has started the job: "..xLogs.Core.Color(PrisonSystem.Config.Jobs[job.name], Color(0, 0, 200)), "Prison")
end)


hook.Add("OnPlayerChangedTeam", "PrisonSystem:ChangeTeam", function(ply, old, new)
	-- They weren't a prisoner
	if not (old == PrisonSystem.Config.Prisoner) then return end

	if PrisonSystem.ActiveJobs[ply:SteamID64()] then
		PrisonSystem.ActiveJobs[ply:SteamID64()].endJob(ply)
	end

	PrisonSystem.ActiveJobs[ply:SteamID64()] = nil

	timer.Remove("PrisonSystem:Jailed:"..ply:SteamID64())

	PrisonSystem.Arrested[ply:SteamID64()] = nil

	net.Start("PrisonSystem:Sentence:Destroy")
		net.WriteEntity(ply)
	net.Broadcast()
end)

hook.Add("PlayerDisconnected", "PrisonSystem:PlayerLeave", function(ply)
	-- They weren't a prisoner
	if not (ply:Team() == PrisonSystem.Config.Prisoner) then return end

	if PrisonSystem.ActiveJobs[ply:SteamID64()] then
		PrisonSystem.ActiveJobs[ply:SteamID64()].endJob(ply)
	end

	PrisonSystem.ActiveJobs[ply:SteamID64()] = nil

	timer.Remove("PrisonSystem:Jailed:"..ply:SteamID64())

	PrisonSystem.Arrested[ply:SteamID64()] = nil
end)

hook.Add("playerCanChangeTeam", "PrisonSystem:BlockJobChange", function(ply, team, forced)
	if forced then return end
	if not (ply:Team() == PrisonSystem.Config.Prisoner) then return end

	XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "You cannot change job while in jail...", ply)

	return false
end)

hook.Add("PlayerSelectSpawn", "PrisonSystem:SpawnInJail", function(ply)
	-- They weren't a prisoner
	if not (ply:Team() == PrisonSystem.Config.Prisoner) then return end

	return NULL, table.Random(PrisonSystem.Config.JailPositions)
end)

hook.Add("PlayerSpawn", "PrisonSystem:ResetWeps", function(ply)
	if not (ply:Team() == PrisonSystem.Config.Prisoner) then return end

	timer.Simple(1, function()
		ply:StripWeapons()
		ply:Give("weapon_physcannon")
		ply:Give("weapon_fists")
	end)
end)

-- block stuff while in jail
hook.Add("Inventory.CanDrop", "PrisonSystem:BlockInv", function(ply)
	if not (ply:Team() == PrisonSystem.Config.Prisoner) then return end
	return false
end)
hook.Add("Inventory.CanDestroy", "PrisonSystem:BlockInv", function(ply)
	if not (ply:Team() == PrisonSystem.Config.Prisoner) then return end
	return false
end)
hook.Add("Inventory.CanPickup", "PrisonSystem:BlockInv", function(ply)
	if not (ply:Team() == PrisonSystem.Config.Prisoner) then return end
	return false
end)
hook.Add("Inventory.CanHolster", "PrisonSystem:BlockInv", function(ply)
	if not (ply:Team() == PrisonSystem.Config.Prisoner) then return end
	return false
end)
hook.Add("Inventory.CanEquip", "PrisonSystem:BlockInv", function(ply)
	if not (ply:Team() == PrisonSystem.Config.Prisoner) then return end
	return false
end)
hook.Add("PlayerSpawnProp", "PrisonSystem:Block", function(ply)
	if not (ply:Team() == PrisonSystem.Config.Prisoner) then return end
	return false
end)
hook.Add("canBuyCustomEntity", "PrisonSystem:Block", function(ply)
	if not (ply:Team() == PrisonSystem.Config.Prisoner) then return end
	return false
end)
hook.Add("canBuyAmmo", "PrisonSystem:Block", function(ply)
	if not (ply:Team() == PrisonSystem.Config.Prisoner) then return end
	return false
end)
hook.Add("canDropWeapon", "PrisonSystem:Block", function(ply)
	if not (ply:Team() == PrisonSystem.Config.Prisoner) then return end
	return false
end)