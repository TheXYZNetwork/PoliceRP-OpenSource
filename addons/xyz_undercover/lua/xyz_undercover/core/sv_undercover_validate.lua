-- This file validates player input

net.Receive("undercover_go_undercover", function(len, ply)
	if ply.UCCoolDown and ply.UCCoolDown > CurTime() then XYZShit.Msg("Undercover System", Color(105, 110, 117), "You are on an active cooldown. Try again after "..math.floor(ply.UCCoolDown - CurTime()).." seconds.", ply) return end
	if not xUndercover.Config.AllowedJobs[ply:Team()] then return end
	local job = net.ReadUInt(16)
	if not xUndercover.Config.UndercoverJobs[job] then return end
	if RPExtraTeams[job].customCheck and not RPExtraTeams[job].customCheck(ply) then return end
	local weapons = ply:GetWeapons()

	ply.UCOriginalJob = ply:Team()
	local pos = ply:GetPos()
	ply:changeTeam(job, true)
	ply:Spawn()
	ply:SetPos(pos)

	for k, v in ipairs( weapons ) do
		if v.xStore then continue end
		ply:Give(v:GetClass())
	end

	ply:setSelfDarkRPVar("salary", RPExtraTeams[ply.UCOriginalJob].salary) -- Let the client know about their modified pay

	net.Start("undercover_go_undercover") -- Now time to send it to the client, we've verified everything!
    net.Send(ply)

    XYZShit.Webhook.Post("fbi_undercover", nil, string.format("%s (%s) has gone undercover as a %s. (%s)", string.gsub(ply:Nick(), "@", ""), ply:SteamID64(), RPExtraTeams[job].name, os.date("%X")))
end)

net.Receive("undercover_go_off_undercover", function(len, ply)
	if not ply.UCOriginalJob then return end
	if ply:XYZIsArrested() then return end
	local hp, armor = ply:Health(), ply:Armor()
	local pos, angles = ply:GetPos(), ply:GetAngles()

	ply:changeTeam(ply.UCOriginalJob, true, true)
	ply:Spawn()
	ply:SetHealth(hp)
	ply:SetArmor(armor)
	ply:SetPos(pos)
	ply:SetAngles(angles)
	ply.UCOriginalJob = nil

	net.Start("undercover_go_off_undercover") -- Now time to send it to the client, we've verified everything!
    net.Send(ply)
    ply.UCCoolDown = CurTime() + 15

    XYZShit.Webhook.Post("fbi_undercover", nil, string.format("%s (%s) has ended their undercover session. (%s)", string.gsub(ply:Nick(), "@", ""), ply:SteamID64(), os.date("%X")))
end)