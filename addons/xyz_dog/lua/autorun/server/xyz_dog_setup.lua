hook.Add("PlayerCanHearPlayersVoice", "XYZDogVoiceBlocker", function(listener, talker)
	if talker:Team() == TEAM_SHERIFFK9 then
		return false
	end
end)

hook.Add("PlayerSpawn", "XYZDogWeapons", function(ply)
	if not (ply:Team() == TEAM_SHERIFFK9) then return end
	timer.Simple(1, function()
		if not IsValid(ply) then return end
		
		ply:StripWeapons()
		ply:Give("weapon_dogswep")
		ply:Give("weapon_xyz_baton")
		ply:Give("xyz_weaponchecker")
		ply:SetRunSpeed(500)
	end)
end)

hook.Add("OnPlayerChangedTeam", "XYZDogMoves", function(ply, oldTeam, newTeam)
	if newTeam == TEAM_SHERIFFK9 then
		timer.Simple(3, function()
			ply:SetRunSpeed(500)
		end)
	end
end)