-- Con command to write mesages as server
concommand.Add("server_msg", function(ply, cmd, args, argStr)
	if IsValid(ply) then return end
	XYZShit.Msg("Server", Color(0,255,255), argStr)
end)

-- Block frozen players from changing team
hook.Add("playerCanChangeTeam", "BlockWhileFrozen", function(ply, team, forced)
	if forced then return end

	if ply:IsFrozen() then
		return false
	end
end)

-- Prevent using the kill command
hook.Add("CanPlayerSuicide", "BlockSuicide", function(ply)
	return false
end)

-- Boot a player from specific jobs if AFK 
hook.Add("loadCustomDarkRPItems", "xyz_afk_darkrp", function()
	local playerTable = {}
	local afkjobs = {
		[TEAM_BUS] = true,
		[TEAM_TAXI] = true,
		[TEAM_UPSDRIVER] = true,
		[TEAM_TRUCKER] = true,
		[TEAM_MECHANIC] = true,
		[TEAM_TRASHCOLLECTOR] = true,
		[TEAM_LAWYER] = true,
		[TEAM_JUDGE] = true,
	}
	for k, v in pairs(RPExtraTeams) do
		if category == "Fire & Rescue" then
			afkjobs[v.team] = true
		end
	end

	timer.Create( "xyz_afk_checker", 450, 0, function()
		for k, v in ipairs( player.GetAll() ) do
			-- using goto because I was having issues w/ continue
			if not afkjobs[v:Team()] then goto cont end
			if playerTable[v:SteamID64()] and playerTable[v:SteamID64()]:IsEqualTol(v:GetPos(), 1) then v:changeTeam(TEAM_CITIZEN) goto cont end
			playerTable[v:SteamID64()] = v:GetPos()
			::cont::
		end
	end)
end)