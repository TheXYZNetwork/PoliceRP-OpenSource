function XYZTracker.Core.GetJobInfo(teamSearch)
	for k, v in pairs(XYZTracker.Config.Filter) do
		if table.HasValue(v.jobs, teamSearch) then
			return v, k
		end
	end
end
function XYZTracker.Core.HasPerms(teamSearch)
	for k, v in pairs(XYZTracker.Config.Filter) do
		if table.HasValue(v.perms, teamSearch) then
			return true
		end
	end
	return false
end

local isJob
hook.Add("OnPlayerChangedTeam", "XYZJobTrackerEnd", function(ply, oldTeam, newTeam)
	isJob = XYZTracker.Core.GetJobInfo(oldTeam)
	print("Checking for job trackability on ", ply, oldTeam, newTeam)
	if isJob or ply.UCOriginalJob then
		print("End session")
		XYZTracker.Database.LogSessionEnd(ply:SteamID64(), ((isJob and team.GetName(oldTeam)) or "Undercover"))
	end

	isJob, jobType = XYZTracker.Core.GetJobInfo(newTeam)

	if isJob or ply.UCOriginalJob then
		print("Start session")
		XYZTracker.Database.LogSessionStart(ply:SteamID64(), ((isJob and team.GetName(ply:Team()) or "Undercover")), jobType or "fbi")
	end

end)

hook.Add("PlayerDisconnected", "XYZJobTrackerEndLeave", function(ply)
	isJob = XYZTracker.Core.GetJobInfo(ply:Team())
	if isJob or ply.UCOriginalJob then
		XYZTracker.Database.LogSessionEnd(ply:SteamID64(), ((isJob and team.GetName(ply:Team()) or "Undercover")))
	end
end)

hook.Add("xWhitelistWhitelist", "XYZTrackerWhiteslistAdd", function(ply, whitelisteeid, jobname, jobTbl)
	print("xWhitelistWhitelist", "XYZTrackerWhiteslistAdd")
	ply = (IsValid(ply) and ply:Name()) or "Console"

	if not jobTbl then return end

	local _, jobType = XYZTracker.Core.GetJobInfo(jobTbl.team)
	XYZTracker.Database.LogPromo(whitelisteeid, ply, jobname, jobType, "Promotion")
end)

hook.Add("xWhitelistUnwhitelist", "XYZTrackerWhiteslistRemove", function(ply, whitelisteeid, jobname, jobTbl)
	print("xWhitelistUnwhitelist", "XYZTrackerWhiteslistRemove")
	ply = (IsValid(ply) and ply:Name()) or "Console"

	if not jobTbl then return end
	local _, jobType = XYZTracker.Core.GetJobInfo(jobTbl.team)
	XYZTracker.Database.LogPromo(whitelisteeid, ply, jobname, jobType, "Demotion")
end)

net.Receive("JobTrackerRequestPlayerWhitelist", function(_, ply)
	if not XYZTracker.Core.HasPerms(ply:Team()) then return end

	local id64 = net.ReadString() or ply:SteamID64()
	local job, jobType = XYZTracker.Core.GetJobInfo(ply:Team())
	XYZTracker.Database.GetLogsByID(id64, jobType, function(data, error)
		if not data and not data[1] then
			XYZShit.Msg("Tracker", Color(200, 255, 0), error or "No data found", ply)
			return
		end
		net.Start("JobTrackerSearchPlayerWhitelist")
			net.WriteString(id64)
			net.WriteTable(data)
		net.Send(ply)
	end)
end)

net.Receive("JobTrackerRequestPlayer", function(_, ply)
	if not XYZTracker.Core.HasPerms(ply:Team()) then return end

	local id64 = net.ReadString() or ply:SteamID64()
	local job, jobType = XYZTracker.Core.GetJobInfo(ply:Team())

	XYZTracker.Database.GetSessionsByID(id64, jobType, function(data, error)
		if not data and not data[1] then
			XYZShit.Msg("Tracker", Color(200, 255, 0), error or "No data found", ply)
			return
		end
		net.Start("JobTrackerSearchPlayer")
			net.WriteString(id64)
			net.WriteTable(data)
		net.Send(ply)
	end)
end)

hook.Add("PlayerSay", "xyz_job_tracker_chat_command", function(ply, msg)
	local args = string.Split(msg, " ")
	if string.lower(args[1]) == "!tracker" and args[2] then
		if not XYZTracker.Core.HasPerms(ply:Team()) then return end

		local job, jobType = XYZTracker.Core.GetJobInfo(ply:Team())

		XYZTracker.Database.GetSessionsByID(args[2], jobType, function(data, error)
			if not data then
				XYZShit.Msg("Tracker", Color(200, 255, 0),  error, ply)
				return
			end
			net.Start("JobTrackerSearchPlayer")
				net.WriteString(args[2])
				net.WriteTable(data)
			net.Send(ply)
		end)
	end
end)