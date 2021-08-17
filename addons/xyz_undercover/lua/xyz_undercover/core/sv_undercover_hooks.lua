hook.Add("PlayerDeath", "xUndercoverHandleDeath", function(ply)
	if not ply.UCOriginalJob then return end

	ply:changeTeam(ply.UCOriginalJob, true, true)
	ply.UCOriginalJob = nil

	net.Start("undercover_go_off_undercover")
    net.Send(ply)

    XYZShit.Webhook.Post("fbi_undercover", nil, string.format("%s (%s) has ended their undercover session. (%s)", string.gsub(ply:Nick(), "@", ""), ply:SteamID64(), os.date("%X")))
end)

local function checkKeys(ply, ent)
      return (ent:getKeysDoorGroup() and table.HasValue (RPExtraTeamDoors[ent:getKeysDoorGroup()] or {}, ply.UCOriginalJob ) ) or ( ent:getKeysDoorTeams() and ent:getKeysDoorTeams()[ply.UCOriginalJob])
end
hook.Add("canKeysLock", "xUndercoverHandleKeyLock", checkKeys)
hook.Add("canKeysUnlock", "xUndercoverHandleKeyUnlock", checkKeys)

local function checkGovShit(target, actor, reason)
	if not IsValid(target) then return end
	if actor.UCOriginalJob then return true end
end

hook.Add("canRequestWarrant", "xUndercoverHandleWarrant", checkGovShit)
hook.Add("canWanted", "xUndercoverHandleWant", checkGovShit)
hook.Add("canUnwant", "xUndercoverHandleUnWant", checkGovShit)


hook.Add("playerCanChangeTeam", "xUndercoverHandleChangeTeam", function(ply, job, force)
	if force then return end -- If the job change is forced return
	if not ply.UCOriginalJob then return end -- If player isn't undercover return
	if ply.isSOD then print("Allowing job change during undercover - SOD.") return end -- If player is going SoD then return
	return false, "You cannot switch jobs while you are undercover. Please end your undercover session first." -- Player isn't going SoD and is Undercover, dont let them
end)

hook.Add("playerGetSalary", "xUndercoverHandlePay", function(ply)
	if not ply.UCOriginalJob then return end -- If player isn't undercover return
	return false, nil, RPExtraTeams[ply.UCOriginalJob].salary -- Player is undercover so lets modify their pay.
end)

hook.Add("canDropWeapon", "xUndercoverHandleDrop", function(ply)
	if not ply.UCOriginalJob then return end -- If player isn't undercover return
	return false -- Player is undercover so dont let them drop weapons
end)