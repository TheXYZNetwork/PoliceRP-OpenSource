hook.Add("PlayerInitialSpawn", "xWhitelistLoadsUsersWhitelists", function(ply)
	xWhitelist.Users[ply:SteamID64()] = {}
	xWhitelist.Users[ply:SteamID64()].whitelist = {}
	xWhitelist.Users[ply:SteamID64()].blacklist = {}
	xWhitelist.Database.GetUsersWhitelists(ply:SteamID64(), function(data)
		for k, v in pairs(data) do
			xWhitelist.Users[ply:SteamID64()].whitelist[v.job] = true
		end
	end)
	xWhitelist.Database.GetUsersBlacklists(ply:SteamID64(), function(data)
		for k, v in pairs(data) do
			xWhitelist.Users[ply:SteamID64()].blacklist[v.job] = true
		end
	end)
end)

net.Receive("xWhitelistRequestUserData", function(_, ply)
	if XYZShit.CoolDown.Check("xWhitelistRequestUserData", 1, ply) then return end

	local target = net.ReadString()
	if xWhitelist.Users[target] then
		net.Start("xWhitelistRequestedUserData")
			net.WriteTable(xWhitelist.Users[target])
		net.Send(ply)
	else
		target = xWhitelist.Core.ValidateToID64(target)
		if not target then return end
		local userInfo = {}
		userInfo.whitelist = {}
		userInfo.blacklist = {}
		xWhitelist.Database.GetUsersWhitelists(target, function(data)
			for k, v in pairs(data) do
				userInfo.whitelist[v.job] = true
			end
			xWhitelist.Database.GetUsersBlacklists(target, function(data)
				for k, v in pairs(data) do
					userInfo.blacklist[v.job] = true
				end

				net.Start("xWhitelistRequestedUserData")
					net.WriteTable(userInfo)
				net.Send(ply)
			end)
		end)
	end
end)

function xWhitelist.Core.AddWhitelist(plyid, job)
	if xWhitelist.Users[plyid] then
		xWhitelist.Users[plyid].whitelist[job] = true
	end
	xWhitelist.Database.GiveUserWhitelist(plyid, job)
end

function xWhitelist.Core.RemoveWhitelist(plyid, job)
	if xWhitelist.Users[plyid] then
		xWhitelist.Users[plyid].whitelist[job] = nil
	end
	xWhitelist.Database.RemoveUserWhitelist(plyid, job)
end

function xWhitelist.Core.AddBlacklist(plyid, job)
	if xWhitelist.Users[plyid] then
		xWhitelist.Users[plyid].blacklist[job] = true
	end
	xWhitelist.Database.GiveUserBlackist(plyid, job)
end

function xWhitelist.Core.RemoveBlacklist(plyid, job)
	if xWhitelist.Users[plyid] then
		xWhitelist.Users[plyid].blacklist[job] = nil
	end
	xWhitelist.Database.RemoveUserBlacklist(plyid, job)
end

concommand.Add("xwhitelist", function(ply, cmd, args)
	local whitelistType = args[1]
	if not whitelistType then return end

	local plyID = args[2]
	if not plyID then return end
	plyID = xWhitelist.Core.ValidateToID64(plyID)
	if not plyID then return end
	local plyTarget = player.GetBySteamID64(plyID)

	local command = args[3]
	if not command then return end

	local isConsole = ply == NULL

	local jobTbl = xWhitelist.Core.GetJobTableByCommand(command)
	jobName = (jobTbl and jobTbl.name) or command

	if whitelistType == "add" then
		if (not isConsole) and (not xWhitelist.Core.CanWhitelist(ply, command)) then return end

		xWhitelist.Core.AddWhitelist(plyID, command)
		if IsValid(plyTarget) then
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have been whitelisted for "..jobName, plyTarget)
			if isConsole then
				print("[xWhitelist]", "You have whitelisted "..plyTarget:Name().." for "..jobName)
			else
				XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have whitelisted "..plyTarget:Name().." for "..jobName, ply)
			end
			xLogs.Log((isConsole and "Console" or xLogs.Core.Player(ply)).." has whitelisted "..xLogs.Core.Player(plyTarget).." for "..xLogs.Core.Color(jobName, Color(240,230,140)), "Whitelist")
			hook.Run("xWhitelistWhitelist", ply, plyTarget:SteamID64(), jobName, jobTbl)
		else
			print("[xWhitelist]", "You have whitelisted "..plyID.." for "..jobName)
			xLogs.Log((isConsole and "Console" or xLogs.Core.Player(ply)).." has whitelisted "..xLogs.Core.Color(plyID, Color(240,140,230)).." for "..xLogs.Core.Color(jobName, Color(240,230,140)), "Whitelist")
			hook.Run("xWhitelistWhitelist", ply, plyID, jobName, jobTbl)
		end
	elseif whitelistType == "remove" then
		if (not isConsole) and (not xWhitelist.Core.CanWhitelist(ply, command)) then return end

		xWhitelist.Core.RemoveWhitelist(plyID, command)
		if IsValid(plyTarget) then
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have been unwhitelisted from "..jobName, plyTarget)
			if isConsole then
				print("[xWhitelist]", "You have unwhitelisted "..plyTarget:Name().." from "..jobName)
			else
				XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have unwhitelisted "..plyTarget:Name().." from "..jobName, ply)
			end
			xLogs.Log((isConsole and "Console" or xLogs.Core.Player(ply)).." has unwhitelisted "..xLogs.Core.Player(plyTarget).." from "..xLogs.Core.Color(jobName, Color(240,230,140)), "Unwhitelist")
			hook.Run("xWhitelistUnwhitelist", ply, plyTarget:SteamID64(), jobName, jobTbl)
		else
			print("[xWhitelist]", "You have unwhitelisted "..plyID.." for "..jobName)
			xLogs.Log((isConsole and "Console" or xLogs.Core.Player(ply)).." has unwhitelisted "..xLogs.Core.Color(plyID, Color(240,140,230)).." from "..xLogs.Core.Color(jobName, Color(240,230,140)), "Unwhitelist")
			hook.Run("xWhitelistUnwhitelist", ply, plyID, jobName, jobTbl)
		end
	elseif whitelistType == "blacklist" then
		if (not isConsole) and (not xWhitelist.Core.CanWhitelist(ply, command)) then return end

		xWhitelist.Core.AddBlacklist(plyID, command)
		if IsValid(plyTarget) then
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have been blacklisted for "..jobName, plyTarget)
			if isConsole then
				print("[xWhitelist]", "You have blacklisted "..plyTarget:Name().." for "..jobName)
			else
				XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have blacklisted "..plyTarget:Name().." for "..jobName, ply)
			end
			xLogs.Log((isConsole and "Console" or xLogs.Core.Player(ply)).." has blacklisted "..xLogs.Core.Player(plyTarget).." for "..xLogs.Core.Color(jobName, Color(240,230,140)), "Blacklist")
		else
			print("[xWhitelist]", "You have blacklisted "..plyID.." for "..jobName)
			xLogs.Log((isConsole and "Console" or xLogs.Core.Player(ply)).." has blacklisted "..xLogs.Core.Color(plyID, Color(240,140,230)).." for "..xLogs.Core.Color(jobName, Color(240,230,140)), "Blacklist")
		end
	elseif whitelistType == "unblacklist" then
		if (not isConsole) and (not xWhitelist.Core.CanWhitelist(ply, command)) then return end

		xWhitelist.Core.RemoveBlacklist(plyID, command)
		if IsValid(plyTarget) then
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have been unblacklisted from "..jobName, plyTarget)
			if isConsole then
				print("[xWhitelist]", "You have unblacklisted "..plyTarget:Name().." from "..jobName)
			else
				XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have unblacklisted "..plyTarget:Name().." from "..jobName, ply)
			end
			xLogs.Log((isConsole and "Console" or xLogs.Core.Player(ply)).." has unblacklisted "..xLogs.Core.Player(plyTarget).." from "..xLogs.Core.Color(jobName, Color(240,230,140)), "Unblacklist")
		else
			print("[xWhitelist]", "You have unblacklisted "..plyID.." from "..jobName)
			xLogs.Log((isConsole and "Console" or xLogs.Core.Player(ply)).." has unblacklisted "..xLogs.Core.Color(plyID, Color(240,140,230)).." from "..xLogs.Core.Color(jobName, Color(240,230,140)), "Unblacklist")
		end
	end
end)

net.Receive("xWhitelistToggleWhitelistID", function(_, ply)
	if XYZShit.CoolDown.Check("xWhitelistToggleWhitelistID", 1, ply) then return end
	
	local plyID = net.ReadString()
	plyID = xWhitelist.Core.ValidateToID64(plyID)

	if not plyID then return end

	local command = net.ReadString()
	local currentlyWhitelisted = net.ReadBool()

	local plyTarget = player.GetBySteamID64(plyID)

	if not xWhitelist.Core.CanWhitelist(ply, command) then return end

	local jobTbl = xWhitelist.Core.GetJobTableByCommand(command)
	local jobName = (jobTbl and jobTbl.name) or command

	if currentlyWhitelisted then
		xWhitelist.Core.RemoveWhitelist(plyID, command)
		if IsValid(plyTarget) then
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have been unwhitelisted from "..jobName, plyTarget)
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have unwhitelisted "..plyTarget:Name().." from "..jobName, ply)
			xLogs.Log(xLogs.Core.Player(ply).." has unwhitelisted "..xLogs.Core.Player(plyTarget).." from "..xLogs.Core.Color(jobName, Color(240,230,140)), "Unwhitelist")
			hook.Run("xWhitelistUnwhitelist", ply, plyTarget:SteamID64(), jobName, jobTbl)
		else
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have unwhitelisted "..plyID.." from "..jobName, ply)
			xLogs.Log(xLogs.Core.Player(ply).." has unwhitelisted "..xLogs.Core.Color(plyID, Color(240,140,230)).." from "..xLogs.Core.Color(jobName, Color(240,230,140)), "Unwhitelist")
			hook.Run("xWhitelistUnwhitelist", ply, plyID, jobName, jobTbl)
		end
	else
		xWhitelist.Core.AddWhitelist(plyID, command)
		if IsValid(plyTarget) then
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have been whitelisted for "..jobName, plyTarget)
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have whitelisted "..plyTarget:Name().." for "..jobName, ply)
			xLogs.Log(xLogs.Core.Player(ply).." has whitelisted "..xLogs.Core.Player(plyTarget).." for "..xLogs.Core.Color(jobName, Color(240,230,140)), "Whitelist")
			hook.Run("xWhitelistWhitelist", ply, plyTarget:SteamID64(), jobName, jobTbl)
		else
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have whitelisted "..plyID.." for "..jobName, ply)
			xLogs.Log(xLogs.Core.Player(ply).." has whitelisted "..xLogs.Core.Color(plyID, Color(240,140,230)).." for "..xLogs.Core.Color(jobName, Color(240,230,140)), "Whitelist")
			hook.Run("xWhitelistWhitelist", ply, plyID, jobName, jobTbl)
		end
	end
end)

net.Receive("xWhitelistToggleBlacklistID", function(_, ply)
	if XYZShit.CoolDown.Check("xWhitelistToggleBlacklistID", 1, ply) then return end
	
	local plyID = net.ReadString()
	plyID = xWhitelist.Core.ValidateToID64(plyID)
	if not plyID then return end
	local command = net.ReadString()
	local currentlyBlacklisted = net.ReadBool()

	local plyTarget = player.GetBySteamID64(plyID)

	if not xWhitelist.Core.CanBlacklist(ply, command) then return end

	local jobTbl = xWhitelist.Core.GetJobTableByCommand(command)
	local jobName = (jobTbl and jobTbl.name) or command

	if currentlyBlacklisted then
		xWhitelist.Core.RemoveBlacklist(plyID, command)
		if IsValid(plyTarget) then
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have been unblacklisted from "..jobName, plyTarget)
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have unblacklisted "..plyTarget:Name().." from "..jobName, ply)
			xLogs.Log(xLogs.Core.Player(ply).." has unblacklisted "..xLogs.Core.Player(plyTarget).." from "..xLogs.Core.Color(jobName, Color(240,230,140)), "Unblacklist")
		else
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have unblacklisted "..plyID.." from "..jobName, ply)
			xLogs.Log(xLogs.Core.Player(ply).." has unblacklisted "..xLogs.Core.Color(jobName, Color(240,140,230)).." from "..xLogs.Core.Color(jobName, Color(240,230,140)), "Unblacklist")
		end
	else
		xWhitelist.Core.AddBlacklist(plyID, command)
		if IsValid(plyTarget) then
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have been blacklisted for "..jobName, plyTarget)
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have blacklisted "..plyTarget:Name().." for "..jobName, ply)
			xLogs.Log(xLogs.Core.Player(ply).." has blacklisted "..xLogs.Core.Player(plyTarget).." for "..xLogs.Core.Color(jobName, Color(240,230,140)), "Blacklist")
		else
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You have blacklisted "..plyID.." for "..jobName, ply)
			xLogs.Log(xLogs.Core.Player(ply).." has blacklisted "..xLogs.Core.Color(jobName, Color(240,140,230)).." for "..xLogs.Core.Color(jobName, Color(240,230,140)), "Blacklist")
		end
	end
end)

hook.Add("playerCanChangeTeam", "xWhitelistBlockTeamJoining", function(ply, newTeam, force)
	if force then return end

	local jobData = RPExtraTeams[newTeam]
	local jobCmd = jobData.command

	if xWhitelist.Users[ply:SteamID64()].blacklist[jobCmd] then
		XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You are blacklisted from "..jobData.name, ply)
		return false
	end
	if xWhitelist.Config.WhitelistedJobs[jobCmd] then
		if not xWhitelist.Users[ply:SteamID64()].whitelist[jobCmd] then
			XYZShit.Msg("xWhitelist", Color(155, 155, 155), "You are not whitelisted for "..jobData.name, ply)
			return false
		end
	end
end)

-- Demote on unwhitelist
hook.Add("xWhitelistUnwhitelist", "xWhitelist:Demote", function(ply, targetID, jobName, jobTbl)
	local target = player.GetBySteamID64(targetID)
	if not IsValid(target) then return end

	local targetTeamData = RPExtraTeams[target:Team()]

	if targetTeamData.command == jobTbl.command then
		target:changeTeam(TEAM_CITIZEN, true, true)
		target:SetTeam(TEAM_CITIZEN)
	
		target:Spawn()
	end
end)