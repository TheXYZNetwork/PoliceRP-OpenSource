-- SUGGESTION | Spectate
-- SUGGESTION | Setjob OR forcedemote
-- Add skipping newly joined players to AFK checker
-- Physgun freeze doesn't seem to be working. Seems to like freeze them but not physically
-- Have chat text be a different color
-- Have commands only show to people effected
-- Have !return default to admin as target

--- #
--- # NOCLIP
--- #
xAdmin.Core.RegisterCommand("noclip", "Toggle a user's noclip", 30, function(admin, args)
	local target = admin
	if (not admin.isSOD) and (not admin:HasPower(xAdmin.Config.Admin)) and (not (admin:Team() == TEAM_EVENTTEAM)) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "You must be SOD to noclip!"}, admin)
		return
	end

	if args and args[1] then
		target = xAdmin.Core.GetUser(args[1], admin)
		if not IsValid(target) or admin.isConsole then
			xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
			return
		end
	end

	if target:GetMoveType() == MOVETYPE_WALK then
		target:SetMoveType(MOVETYPE_NOCLIP)
	elseif target:GetMoveType() == MOVETYPE_NOCLIP then
		target:SetMoveType(MOVETYPE_WALK)
	end
end)

hook.Add("PlayerNoClip", "xAdminBlockNoclip", function(ply, desiredState)
	return false
end)

--- #
--- # HEALTH
--- #
xAdmin.Core.RegisterCommand("health", "Set a user's health", 40, function(admin, args)
	if not args or not args[1] or not args[2] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	if not tonumber(args[2]) then return end
	target:SetHealth(math.Clamp(tonumber(args[2]), 1, 100))
	xAdmin.Core.Msg({admin, " has set ", target, "'s health to ", Color(255, 0, 0), math.Clamp(tonumber(args[2]), 1, 100)})
end)
xAdmin.Core.RegisterCommand("hp", "Alias for health", 40, function(admin, args)
	xAdmin.Commands["health"].func(admin, args)
end)

--- #
--- # ARMOR
--- # 
xAdmin.Core.RegisterCommand("armor", "Set a user's armor", 50, function(admin, args)
	if not args or not args[1] or not args[2] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	if not tonumber(args[2]) then return end
	target:SetArmor(math.Clamp(tonumber(args[2]), 1, 100))
	xAdmin.Core.Msg({admin, " has set ", target, "'s armor to ", Color(0, 0, 255), math.Clamp(tonumber(args[2]), 1, 100)})
end)

--- #
--- # GOD
--- # 
xAdmin.Core.RegisterCommand("god", "God a user", 40, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	target:GodEnable()
	xAdmin.Core.Msg({admin, " has godded ", target})
end)

--- #
--- # UNGOD
--- # 
xAdmin.Core.RegisterCommand("ungod", "Ungod a user", 40, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	target:GodDisable()
	xAdmin.Core.Msg({admin, " has ungodded ", target})
end)

--- #
--- # SLAY
--- # 
xAdmin.Core.RegisterCommand("slay", "Kill a user", 70, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	target:Kill()
	xAdmin.Core.Msg({admin, " has slayed ", target})
end)

--- #
--- # REVIVE
--- # 
xAdmin.Core.RegisterCommand("revive", "Revive a user", 50, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	if target:Alive() then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), target, " is already alive."}, admin)
		return
	end

	local deathPos = target:GetPos()
	target:Spawn()
	target:SetPos(deathPos)

	xAdmin.Core.Msg({admin, " has revived ", target})
end)

--- #
--- # RESPAWN
--- # 
xAdmin.Core.RegisterCommand("respawn", "Respawn a user", 70, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end

	target:Spawn()
	xAdmin.Core.Msg({admin, " has respawned ", target})
end)

--- #
--- # STRIP
--- # 
xAdmin.Core.RegisterCommand("strip", "Strip a user", 70, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	target:StripWeapons()

	xAdmin.Core.Msg({admin, " has stripped ", target})
end)

--- #
--- # GIVE
--- # 
xAdmin.Core.RegisterCommand("give", "Give a user a weapon", 70, function(admin, args)
	if not args or not args[1] or not args[2] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	target:Give(args[2] or "weapon_357")

	xAdmin.Core.Msg({admin, " has given ", target, " a ", Color(138,43,226), args[2] or "models/props_lab/blastdoor001c.mdl"})
end)

--- #
--- # SETJOB
--- #
xAdmin.Core.RegisterCommand("setjob", "[DarkRP] Sets the target's job", 60, function(admin, args)
	if not args or not args[1] then
		return
	end

	if not DarkRP then
		return
	end

	if not args[2] then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target"}, admin)

		return
	end

	local target = xAdmin.Core.GetUser(args[1], admin)
	local job = DarkRP.getJobByCommand(args[2])

	if not job then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid job "}, admin)

		return
	end

	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: " .. args[1]}, admin)

		return
	end


	xAdmin.Core.Msg({admin, " has set ", target, "'s job to ", Color(0, 255, 0), job.name})
	target:changeTeam(job.team, true, true)
end)


--- #
--- # SPECTATE
--- #
xAdmin.Core.RegisterCommand("spectate", "Enable spectate mode", 70, function(admin, args)
	local target
	if args and args[1] then
		target = xAdmin.Core.GetUser(args[1], admin)
	end

	admin:SelectWeapon("keys")

	if not admin.xAdminIsSpectating then
		admin.xAdminIsSpectating = true
		admin.xAdminSpectatePosition = admin:GetPos()

		if IsValid(target) then
			admin:Spectate(OBS_MODE_IN_EYE)
			admin:SpectateEntity(target)
		else
			admin:Spectate(OBS_MODE_ROAMING)
		end
	elseif IsValid(target) then
		admin:Spectate(OBS_MODE_IN_EYE)
		admin:SpectateEntity(target)
	else
		admin.xAdminIsSpectating = false

		admin:Spawn()
		admin:SetPos(admin.xAdminSpectatePosition or admin:GetPos())
		admin:UnSpectate()

		if admin.isSOD then
			timer.Simple(0, function()
				admin:GodEnable()
			end)
		end
	end

	net.Start("xAdminSpectate")
		net.WriteBool(admin.xAdminIsSpectating)
	net.Send(admin)
end)

hook.Add("FSpectate_canSpectate", "xAdminfAdminSpectateDisable", function()
	return false
end)

--- #
--- # ANNOUNCEMENT
--- # 
xAdmin.Core.RegisterCommand("announcement", "Broadcasts an announcement", 95, function(admin, args)
	if not args or not args[1] then return end

	net.Start("xAdminStartAnnouncement")
		net.WriteString(table.concat(args, " "))
	net.Broadcast()
end)

--- #
--- # ALTS
--- # 
local waitingAlts = {}
xAdmin.Core.RegisterCommand("alts", "Get a user's known alts", 90, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	net.Start("xAdminRequestAlts")
	net.Send(target)

	waitingAlts[target:SteamID64()] = admin
end)

net.Receive("xAdminRequestAlts", function(_, ply)
	if not waitingAlts[ply:SteamID64()] then return end

	local admin = waitingAlts[ply:SteamID64()]
	local altsTbl = net.ReadTable()
	local alts = {}
	for k, v in pairs(altsTbl) do
		if not v.userid then continue end

		table.insert(alts, v.userid)
	end

	if table.Count(alts) > 0 then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), ply, " has the following known alts: "..table.concat(alts, ", ")}, admin)
	else
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "No alts where found for ", ply}, admin)
	end

	waitingAlts[ply:SteamID64()] = nil
end)

--- #
--- # Friends
--- # 
local waitingFriends = {}
xAdmin.Core.RegisterCommand("friends", "Get a user's online friends", 70, function(admin, args)
	if not args or not args[1] then return end

	local target = xAdmin.Core.GetUser(args[1], admin)
	if not IsValid(target) then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "Please provide a valid target. The following was not recognised: "..args[1]}, admin)
		return
	end 

	net.Start("xAdminRequestFriends")
	net.Send(target)

	waitingFriends[target:SteamID64()] = admin
end)

net.Receive("xAdminRequestFriends", function(_, ply)
	if not waitingFriends[ply:SteamID64()] then return end

	local admin = waitingFriends[ply:SteamID64()]
	local friends = net.ReadTable()

	if table.Count(friends) > 0 then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), ply, " has the following known friends: "..table.concat(friends, ", ")}, admin)
	else
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "No friends where found for ", ply}, admin)
	end

	waitingFriends[ply:SteamID64()] = nil
end)