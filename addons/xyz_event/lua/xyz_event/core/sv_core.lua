hook.Add("PlayerSay", "EventSystem:ChatCommand", function(ply, text)
	if not EventSystem.Config.EventCommand[string.lower(text)] then return end
	if not ply:IsStaff() then return end
	if not ply:IsEventTeam() then return end
	if not (ply:Team() == TEAM_EVENTTEAM) then return end

	if not EventSystem.Data.info.name then
		net.Start("EventSystem:UI:Admin:CreateEvent")
		net.Send(ply)
	else
		net.Start("EventSystem:UI:Admin")
		net.Send(ply)
	end
end)

local ammoTypes = {"9x17MM", "9x18MM", "9x19MM", "9x21MM", "9x39MM", "40MM", "5.7x28MM", ".44 Magnum", ".45 ACP", ".45 Auto ACP", ".50 AE", "12 Gauge", ".338 Lapua", "5.45x39MM", "7.62x51MM", "5.56x45MM", "SMG1", "pistol", "357", "7.62x54mmR", "SniperPenetratedRound", ".22LR", ".32 ACP", ".50 BMG", ".416 Barrett"}
hook.Add("PlayerSpawn", "EventSystem:Spawn", function(ply)
	if not (ply:Team() == TEAM_EVENT) then return end

	ply:StripWeapons()
	-- To make sure we get everything ;)
	timer.Simple(2, function()
		ply:StripWeapons()

		for k, v in pairs(EventSystem.Data.loadout) do
			ply:Give(k)
		end
	end)

	for k, v in pairs(ammoTypes) do
		ply:GiveAmmo(9999, v)
	end

	ply:SetArmor(100)

	ply.xAdmin_Gag = true
	ply.xAdmin_Mute = true

	xLogs.Log(xLogs.Core.Player(ply).." has respawned as an event member", "Gamemaster")
end)

hook.Add("OnPlayerChangedTeam", "EventSystem:JoinEvent", function(ply, old, new)
	if new == TEAM_EVENT then
		local firstTeam
		for i=1, #EventSystem.Config.TeamNames do
			if EventSystem.Data.teamMembers[i] then
				firstTeam = i
				break
			end
		end
	
		-- Register this new user
		EventSystem.Core.AddToTeam(ply, firstTeam)
		EventSystem.Data.remainingLives[ply] = EventSystem.Data.defaultLives
		EventSystem.Data.points[ply] = 0

		net.Start("EventSystem:TeamMembers")
			net.WriteBool(EventSystem.Data.teamDamage)
		net.Send(ply)

		xLogs.Log(xLogs.Core.Player(ply).." has joined the event", "Gamemaster")
	elseif old == TEAM_EVENT then
		EventSystem.Core.KickFromEvent(ply)
	end
end)

hook.Add("PlayerDeath", "EventSystem:KillPoints", function(ply, inf, attacker)
	if not (ply:Team() == TEAM_EVENT) then return end
	if not (attacker:Team() == TEAM_EVENT) then return end
	if not EventSystem.Data.pointsOnKills then return end

	local points = EventSystem.Data.points[attacker]
	if not points then
		print("[Event]", attacker, "is not registered in the event and has been assigned points. Kicking them.")
		EventSystem.Core.KickFromEvent(attacker)

		return
	end

	EventSystem.Data.points[attacker] = points + 1
	xLogs.Log(xLogs.Core.Player(attacker).." had gained 1 point for killing "..xLogs.Core.Player(ply), "Gamemaster")
end)

hook.Add("PlayerDeath", "EventSystem:Death", function(ply, inf, attacker)
	if not (ply:Team() == TEAM_EVENT) then return end

	local lives = EventSystem.Data.remainingLives[ply]
	if not lives then
		print("[Event]", ply, "is not registered in the event and has died. Kicking them.")
		EventSystem.Core.KickFromEvent(ply)

		return
	end

	if lives == 1 then
		print("[Event]", ply, "has ran out of lives.")
		EventSystem.Core.KickFromEvent(ply)
		return
	end

	if lives > 1 then
		EventSystem.Data.remainingLives[ply] = lives - 1
		xLogs.Log(xLogs.Core.Player(ply).." had lost 1 life for being killed by "..xLogs.Core.Player(attacker), "Gamemaster")
	end

	timer.Simple(EventSystem.Config.RespawnTimer, function()
		if not IsValid(ply) then return end
		
		ply:Spawn()
	end)
end)

hook.Add("PlayerShouldTakeDamage", "EventSystem:PreventTeamDamage", function(victim, attacker)
	if EventSystem.Data.teamDamage then return end
	if not attacker:IsPlayer() then return end
	if not (victim:Team() == TEAM_EVENT) then return end
	if not (attacker:Team() == TEAM_EVENT) then return end

	local victimJob = victim:getDarkRPVar("job")
	local attackerJob = attacker:getDarkRPVar("job")

	if victimJob == attackerJob then return false end
end)

hook.Add("PlayerSelectSpawn", "EventSystem:SpawnPoints", function(ply)
	-- They weren't a prisoner
	if not (ply:Team() == TEAM_EVENT) then return end

	local teamID
	for i, t in pairs(EventSystem.Data.teamMembers) do
		if table.HasValue(t, ply) then
			teamID = i
			break
		end
	end

	if not teamID then return end

	local possibleSpawns = EventSystem.Data.spawns[teamID]
	if not possibleSpawns then
		possibleSpawns = EventSystem.Data.spawns["everyone"]
	end
	if not possibleSpawns then return end

	return NULL, table.Random(possibleSpawns)
end)

hook.Add("PlayerDisconnected", "EventSystem:RemoveOnDisconnect", function(ply)
	EventSystem.Core.KickFromEvent(ply)
end)

net.Receive("EventSystem:UI:Admin:RequestData", function(_, ply)
	if not ply:IsStaff() then return end
	if not ply:IsEventTeam() then return end
	if not (ply:Team() == TEAM_EVENTTEAM) then return end

	net.Start("EventSystem:UI:Admin:RequestData")
		net.WriteTable(EventSystem.Data)
	net.Send(ply)
end)

net.Receive("EventSystem:UI:Admin:SendAction", function(_, ply)
	if not ply:IsStaff() then return end
	if not ply:IsEventTeam() then return end
	if not (ply:Team() == TEAM_EVENTTEAM) then return end


	local action = net.ReadString()
	local data = net.ReadTable()

	local func = EventSystem.Core.Actions[action]

	if not func then return end
	func(data, ply)

	xLogs.Log(xLogs.Core.Player(ply).." has ran the action "..xLogs.Core.Color(action, Color(200, 0, 0)), "Gamemaster")

	if data.refresh then
		net.Start("EventSystem:UI:Admin:RequestData")
			net.WriteTable(EventSystem.Data)
		net.Send(team.GetPlayers(TEAM_EVENTTEAM))
	end
end)

net.Receive("EventSystem:Invite:Accept", function(_, ply)
	if ply:Team() == TEAM_EVENT then return end
	if ply.UCOriginalJob then return end
	if not EventSystem.Data.activeInvites then return end

	ply:changeTeam(TEAM_EVENT, true)
end)

net.Receive("EventSystem:UI:Admin:CreateEvent:Start", function(_, ply)
	if not ply:IsStaff() then return end
	if not ply:IsEventTeam() then return end
	if not (ply:Team() == TEAM_EVENTTEAM) then return end

	if EventSystem.Data.info.name then return end

	local name = net.ReadString()
	local desc = net.ReadString()
	local prize = net.ReadUInt(14)

	if prize < 100 then return end
	if prize > 10000 then return end

	EventSystem.Data.info = {
		name = name,
		desc = desc,
		prize = prize
	}

	XYZShit.Msg("Game Master", EventSystem.Config.Color, "The event "..name.." will be starting in roughly 30 minutes, stick around to take part.")

	XYZShit.Webhook.PostEmbed("event_alert", {
        author = {
            name = ply:SteamName(),
            url = "https://steamcommunity.com/profiles/"..ply:SteamID64().."/",
            icon_url = "http://extra.thexyznetwork.xyz/steamProfileByID?id="..ply:SteamID64()
        },
        fields = {
            {
                name = "Server",
                value = "PoliceRP",
                inline = false,
            },
            {
                name = "Name",
                value = string.gsub(name, "%@", ""),
                inline = true,
            },
            {
                name = "Prize",
                value = string.gsub(string.Comma(prize).." Credits", "%@", ""),
                inline = true,
            },
            {
                name = "Description",
                value = string.gsub(desc, "%@", ""),
                inline = false,
            },
            {
                name = "Details",
                value = "This event will start in roughly 30 minutes. Start joining now to take part: steam://connect/"..game.GetIPAddress(),
                inline = false,
            },
        },
        color = math.random(1, 16777215)
    })

	xLogs.Log(xLogs.Core.Player(ply).." has created an event called "..xLogs.Core.Color(name, Color(0, 200, 200)), "Gamemaster")
end)

net.Receive("EventSystem:UI:Admin:AddSpawnPoint", function(_, ply)
	if not ply:IsStaff() then return end
	if not ply:IsEventTeam() then return end
	if not (ply:Team() == TEAM_EVENTTEAM) then return end

	if not EventSystem.Data.info.name then return end

	local targetType = net.ReadString()
	local pos = net.ReadVector()

	local target = targetType

	if string.find(targetType, "team_") then
		target = tonumber(string.Explode("_", targetType, false)[2])
	end
	
	if not EventSystem.Data.spawns[target] then
		EventSystem.Data.spawns[target] = {}
	end

	table.insert(EventSystem.Data.spawns[target], pos)
	
	net.Start("EventSystem:SendSpawnPoints")
		net.WriteTable(EventSystem.Data.spawns)
	net.Send(team.GetPlayers(TEAM_EVENTTEAM))

	xLogs.Log(xLogs.Core.Player(ply).." has added a spawn point for "..xLogs.Core.Color(targetType, Color(0, 200, 200)), "Gamemaster")
end)

net.Receive("EventSystem:UI:Admin:WipeSpawnPoint", function(_, ply)
	if not ply:IsStaff() then return end
	if not ply:IsEventTeam() then return end
	if not (ply:Team() == TEAM_EVENTTEAM) then return end

	EventSystem.Data.spawns = {}

	net.Start("EventSystem:SendSpawnPoints")
		net.WriteTable(EventSystem.Data.spawns)
	net.Send(team.GetPlayers(TEAM_EVENTTEAM))

	xLogs.Log(xLogs.Core.Player(ply).." has cleared all spawn points", "Gamemaster")
end)

net.Receive("EventSystem:UI:Admin:RemoveSpawnPoint", function(_, ply)
	if not ply:IsStaff() then return end
	if not ply:IsEventTeam() then return end
	if not (ply:Team() == TEAM_EVENTTEAM) then return end

	local teamID = net.ReadString()
	local spawnID = net.ReadUInt(32)

	if not (teamID == "everyone") then
		teamID = tonumber(teamID)
	end

	if not EventSystem.Data.spawns[teamID] then return end
	if not EventSystem.Data.spawns[teamID][spawnID] then return end

	EventSystem.Data.spawns[teamID][spawnID] = nil

	net.Start("EventSystem:SendSpawnPoints")
		net.WriteTable(EventSystem.Data.spawns)
	net.Send(team.GetPlayers(TEAM_EVENTTEAM))

	xLogs.Log(xLogs.Core.Player(ply).." has removed a spawnpoint for "..xLogs.Core.Color(teamID, Color(0, 200, 200)), "Gamemaster")
end)

net.Receive("EventSystem:UI:Admin:SpawnEntity", function(_, ply)
	if not ply:IsStaff() then return end
	if not ply:IsEventTeam() then return end
	if not (ply:Team() == TEAM_EVENTTEAM) then return end

	local class = net.ReadString()
	local pos = ply:GetEyeTrace().HitPos

	if not EventSystem.Config.SpawnBlacklist[class] then return end

	-- Create the entity
	local ent = ents.Create(class)
	if not IsValid(ent) then return end
	ent:SetPos(pos)
	ent:Spawn()
	ent:Activate()


	undo.Create("prop")
		undo.AddEntity(ent)
		undo.SetPlayer(ply)
	undo.Finish()

	xLogs.Log(xLogs.Core.Player(ply).." has spawned the entity "..xLogs.Core.Color(class, Color(0, 200, 200)), "Gamemaster")
end)

net.Receive("EventSystem:UI:Admin:EndEvent", function(_, ply)
	if not ply:IsStaff() then return end
	if not ply:IsEventTeam() then return end
	if not (ply:Team() == TEAM_EVENTTEAM) then return end

	if not EventSystem.Data.info.name then return end

	local winnersTemp = net.ReadTable()
	local winners = {}
	for k, v in pairs(winnersTemp) do
		table.insert(winners, k:Name().." ("..k:SteamID64()..")")
	end
	winnersTemp = nil

	local eventTeam = {}
	for k, v in pairs(team.GetPlayers(TEAM_EVENTTEAM)) do
		table.insert(eventTeam, v:Name().." ("..v:SteamID64()..")")
	end

	XYZShit.Msg("Game Master", EventSystem.Config.Color, "The event "..EventSystem.Data.info.name.." has ended.", ply)

	XYZShit.Webhook.PostEmbed("event_log", {
        author = {
            name = ply:SteamName(),
            url = "https://steamcommunity.com/profiles/"..ply:SteamID64().."/",
            icon_url = "http://extra.thexyznetwork.xyz/steamProfileByID?id="..ply:SteamID64()
        },
        fields = {
            {
                name = "Server",
                value = "PoliceRP",
                inline = false,
            },
            {
                name = "Name",
                value = string.gsub(EventSystem.Data.info.name, "%@", ""),
                inline = true,
            },
            {
                name = "Prize Pool",
                value = string.gsub(string.Comma(EventSystem.Data.info.prize).." Credits", "%@", ""),
                inline = true,
            },
            {
                name = "Description",
                value = string.gsub(EventSystem.Data.info.desc, "%@", ""),
                inline = false,
            },
            {
                name = "Gamemasters",
                value = table.concat(eventTeam, "\n"),
                inline = true,
            },
            {
                name = "Winners",
                value = table.concat(winners, "\n"),
                inline = true,
            },
        },
        color = math.random(1, 16777215)
    })

	xLogs.Log(xLogs.Core.Player(ply).." has ended the event "..xLogs.Core.Color(EventSystem.Data.info.name, Color(0, 200, 200)), "Gamemaster")

	EventSystem.Core.Actions["cancel_event"]()
end)

function EventSystem.Core.KickFromEvent(ply)
	-- Remove then from existing team
	for i, t in pairs(EventSystem.Data.teamMembers) do
		if table.HasValue(t, ply) then
			for _, n in pairs(t) do
				if n == ply then
					table.remove(t, _)
				end
			end
		end
	end

	EventSystem.Data.remainingLives[ply] = nil
	EventSystem.Data.points[ply] = nil

	-- Reset some stuff
	ply:SetMaterial("")
	ply:SetColor(color_white)
	ply.xAdmin_Gag = false
	ply.xAdmin_Mute = false
	-- Change their team
	ply:changeTeam(GAMEMODE.DefaultTeam, true)

	xLogs.Log(xLogs.Core.Player(ply).." has been kicked from the event", "Gamemaster")

end
function EventSystem.Core.AddToTeam(ply, teamID)
	for i, t in pairs(EventSystem.Data.teamMembers) do
		if table.HasValue(t, ply) then
			for _, n in pairs(t) do
				if n == ply then
					table.remove(t, _)
					break
				end
			end
		end
		if found then break end
	end

	table.insert(EventSystem.Data.teamMembers[tonumber(teamID)], ply)

	ply:setDarkRPVar("job", "Team "..EventSystem.Config.TeamNames[teamID])

	xLogs.Log(xLogs.Core.Player(ply).." has been added to the team "..xLogs.Core.Color(EventSystem.Config.TeamNames[teamID], Color(0, 200, 200)), "Gamemaster")
end


-- A scuffed but easily managable way to handle this
EventSystem.Core.Actions = {}
EventSystem.Core.Actions["add_team"] = function(data)
	if EventSystem.Data.teams == EventSystem.Config.MaxTeams then return end
	
	local currentTeamCount = EventSystem.Data.teams

	EventSystem.Data.teams = currentTeamCount + 1
	for i=1, EventSystem.Data.teams do
		if EventSystem.Data.teamMembers[i] then continue end

		EventSystem.Data.teamMembers[i] = {}

		break
	end
end
EventSystem.Core.Actions["remove_team"] = function(data)
	if table.Count(EventSystem.Data.teamMembers[data.id]) > 0 then return end

	local currentTeamCount = EventSystem.Data.teams
	EventSystem.Data.teams = currentTeamCount - 1
	EventSystem.Data.teamMembers[data.id] = nil
end
EventSystem.Core.Actions["balance_team"] = function(data)
	local allPlayers = {}
	local allTeams = {}
	for k, v in pairs(EventSystem.Data.teamMembers) do
		for i, p in pairs(v) do
			table.insert(allPlayers, p)
		end

		table.insert(allTeams, k)
	
		EventSystem.Data.teamMembers[k] = {}
	end


	local count = 0
	for k, v in pairs(allPlayers) do
		count = count + 1

		if count > EventSystem.Data.teams then
			count = 1
		end


		EventSystem.Core.AddToTeam(v, allTeams[count])
	end
end
EventSystem.Core.Actions["default_lives"] = function(data)
	local defaultLives = data.lives

	EventSystem.Data.defaultLives = defaultLives
end
EventSystem.Core.Actions["toggle_kill_points"] = function(data)
	EventSystem.Data.pointsOnKills = not EventSystem.Data.pointsOnKills
end
EventSystem.Core.Actions["toggle_team_damage"] = function(data)
	EventSystem.Data.teamDamage = not EventSystem.Data.teamDamage

	net.Start("EventSystem:TeamMembers")
		net.WriteBool(EventSystem.Data.teamDamage)
	net.Send(team.GetPlayers(TEAM_EVENT))
end
EventSystem.Core.Actions["toggle_prop_spawning"] = function(data)
	EventSystem.Data.blockPropSpawning = not EventSystem.Data.blockPropSpawning
end

EventSystem.Core.Actions["move_team"] = function(data)
	local target = data.targets
	local teamID = data.teamID

	for k, v in pairs(target) do
		EventSystem.Core.AddToTeam(v, teamID)
	end
end
EventSystem.Core.Actions["set_health"] = function(data)
	local target = data.targets
	local health = data.amount

	for k, v in pairs(target) do
		v:SetHealth(health)
	end
end
EventSystem.Core.Actions["set_armour"] = function(data)
	local target = data.targets 
	local armour = data.amount

	for k, v in pairs(target) do
		v:SetArmor(armour)
	end
end
EventSystem.Core.Actions["strip_weapons"] = function(data)
	local target = data.targets

	for k, v in pairs(target) do
		v:StripWeapons()
	end
end
EventSystem.Core.Actions["set_model"] = function(data)
	local target = data.targets
	local model = data.model

	for k, v in pairs(target) do
		v:SetModel(model)
	end
end
EventSystem.Core.Actions["give_weapon"] = function(data)
	local target = data.targets
	local wep = data.weapon

	for k, v in pairs(target) do
		v:Give(wep)
	end
end
EventSystem.Core.Actions["set_lives"] = function(data)
	local target = data.targets
	local lives = data.lives

	for k, v in pairs(target) do
		EventSystem.Data.remainingLives[v] = lives
	end
end
EventSystem.Core.Actions["set_color"] = function(data)
	local target = data.targets
	local color = data.color

	for k, v in pairs(target) do
		v:SetMaterial("models/shiny")
		v:SetColor(color)
	end
end
EventSystem.Core.Actions["add_points"] = function(data)
	local target = data.targets
	local points = data.points
	for k, v in pairs(target) do
		EventSystem.Data.points[v] = EventSystem.Data.points[v] + points
	end
end
EventSystem.Core.Actions["remove_points"] = function(data)
	local target = data.targets
	local points = data.points
	for k, v in pairs(target) do
		EventSystem.Data.points[v] = EventSystem.Data.points[v] - points
	end
end
EventSystem.Core.Actions["give_buildtools"] = function(data)
	local target = data.targets

	for k, v in pairs(target) do
		v:Give("weapon_physgun")
		v:Give("gmod_tool")
	end
end
EventSystem.Core.Actions["gag"] = function(data)
	local target = data.targets

	for k, v in pairs(target) do
		v.xAdmin_Gag = true
	end
end
EventSystem.Core.Actions["ungag"] = function(data)
	local target = data.targets

	for k, v in pairs(target) do
		v.xAdmin_Gag = false
	end
end
EventSystem.Core.Actions["mute"] = function(data)
	local target = data.targets

	for k, v in pairs(target) do
		v.xAdmin_Mute = true
	end
end
EventSystem.Core.Actions["unmute"] = function(data)
	local target = data.targets

	for k, v in pairs(target) do
		v.xAdmin_Mute = false
	end
end
EventSystem.Core.Actions["bring"] = function(data, ply)
	local target = data.targets
	local plyPos = ply:GetPos()

	for k, v in pairs(target) do
		v:SetPos(plyPos)
	end
end


-- Special events
EventSystem.Core.Actions["kick"] = function(data)
	local target = data.targets

	for k, v in pairs(target) do
		EventSystem.Core.KickFromEvent(v)
	end
end
EventSystem.Core.Actions["reset_points"] = function(data)
	local target = data.targets
	for k, v in pairs(target) do
		EventSystem.Data.points[v] = 0
	end
end
EventSystem.Core.Actions["release_invites"] = function(data, ply)
	if table.IsEmpty(EventSystem.Data.info) then return end

	if XYZShit.CoolDown.Check("EventSystem:ReleaseInvites", 60) then
		XYZShit.Msg("Game Master", EventSystem.Config.Color, "Invites are currently active.", ply)
		return
	end

	EventSystem.Data.activeInvites = true
	timer.Simple(60, function()
		EventSystem.Data.activeInvites = false
	end)

	net.Start("EventSystem:Invite")
		net.WriteString(EventSystem.Data.info.name)
		net.WriteString(EventSystem.Data.info.desc)
		net.WriteUInt(EventSystem.Data.info.prize, 32)
	net.Broadcast()
end
EventSystem.Core.Actions["cancel_event"] = function(data)	
	EventSystem.Data.info = {}
	EventSystem.Data.defaultLives = 1
	EventSystem.Data.pointsOnKills = false
	EventSystem.Data.teamDamage = false
	EventSystem.Data.spawns = {}
	EventSystem.Data.loadout = {}

	for k, v in pairs(team.GetPlayers(TEAM_EVENT)) do
		EventSystem.Core.KickFromEvent(v)
	end

	EventSystem.Data.teams = 1
	EventSystem.Data.teamMembers = {
		[1] = {}
	}

	EventSystem.Data.spawns = {}
end
EventSystem.Core.Actions["broadcast_message"] = function(data, ply)
	local target = data.targets
	local msg = data.message

	net.Start("EventSystem:Message")
		net.WriteString(msg)
	net.Send(target)
end
EventSystem.Core.Actions["loadout"] = function(data, ply)
	local loadout = data.loadout

	EventSystem.Data.loadout = loadout
end

EventSystem.Core.Actions["toggle_doors"] = function(data, ply)
	if not ply:IsEventTeam() then return end
	local door = data.door
	for _, v in pairs(ents.FindByName("eventdoor"..(door or 1))) do
		if v:GetClass() == "func_door" then v:Fire("toggle") end
	end
end
