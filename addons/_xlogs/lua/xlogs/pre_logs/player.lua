xLogs.RegisterCategory("Connection", "Players")
xLogs.RegisterCategory("Disconnection", "Players")
xLogs.RegisterCategory("Deaths", "Players")
xLogs.RegisterCategory("Respawn", "Players")
xLogs.RegisterCategory("Say", "Players")
xLogs.RegisterCategory("Team Say", "Players")
xLogs.RegisterCategory("Damage", "Players")
xLogs.RegisterCategory("Pickup", "Players")

hook.Add("PlayerInitialSpawn", "xLogsPlayers-Connection", function(ply)
	xLogs.Log(xLogs.Core.Player(ply).." has connected", "Connection")
end)

hook.Add("PlayerDisconnected", "xLogsPlayers-Disconnection", function(ply)
	if ply:IsTimingOut() then
		xLogs.Log(xLogs.Core.Player(ply).." has timed out", "Disconnection")
	else
		xLogs.Log(xLogs.Core.Player(ply).." has disconnected", "Disconnection")
	end
end)

hook.Add("PlayerDeath", "xLogsPlayers-Death", function(victim, inflictor, attacker)
	if attacker:IsPlayer() then
		xLogs.Log(xLogs.Core.Player(victim).." was killed by "..xLogs.Core.Player(attacker), "Deaths")
	else
		xLogs.Log(xLogs.Core.Player(victim).." has died", "Deaths")
	end
end)

hook.Add("PlayerSpawn", "xLogsPlayers-Respawn", function(ply)
	xLogs.Log(xLogs.Core.Player(ply).." has respawned", "Respawn")
end)

hook.Add("EntityTakeDamage", "xLogsPlayers-Damage", function(target, dmgData)
	if target:IsPlayer() and dmgData:GetAttacker():IsPlayer() then
		xLogs.Log(xLogs.Core.Player(target).." took "..xLogs.Core.Color(math.Round(dmgData:GetDamage()), Color(200, 0, 0)).." damage from "..xLogs.Core.Player(dmgData:GetAttacker()), "Damage")
	elseif target:IsPlayer() then
		xLogs.Log(xLogs.Core.Player(target).." took "..xLogs.Core.Color(math.Round(dmgData:GetDamage()), Color(200, 0, 0)).." damage from "..xLogs.Core.Color(dmgData:GetAttacker():GetClass(), Color(0, 200, 200)), "Damage")
	end
end)

hook.Add("PlayerCanPickupWeapon", "xLogsPlayers-Pickup", function(ply, weapon)
	xLogs.Log(xLogs.Core.Player(ply).." attempted to pick up weapon "..xLogs.Core.Color(weapon:GetClass(), Color(0, 0, 200)), "Pickup")
end)

hook.Add("PlayerCanPickupItem", "xLogsPlayers-Pickup", function(ply, item)
	xLogs.Log(xLogs.Core.Player(ply).." attempted to pick up item "..xLogs.Core.Color(item:GetClass(), Color(0, 0, 200)), "Pickup")
end)

hook.Add("PlayerSay", "xLogsPlayers-Say", function(ply, text, isTeam)
	if ply:IsPlayer() then
		if isTeam then
			xLogs.Log(xLogs.Core.Player(ply).." said: "..text, "Team Say")
		else
			xLogs.Log(xLogs.Core.Player(ply).." said: "..text, "Say")
		end
	end
end)