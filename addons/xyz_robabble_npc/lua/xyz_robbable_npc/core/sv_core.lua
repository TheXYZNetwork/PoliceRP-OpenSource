hook.Add("PlayerDeath", "robbable_npc_death", function(victim, inflictor, attacker)
	if IsValid(victim._activeRobbery) then
		victim._activeRobbery:CancelRobbery(victim)
	end
end)

hook.Add("PlayerDisconnected", "robbable_npc_disconnect", function(ply)
	if IsValid(ply._activeRobbery) then
		ply._activeRobbery:CancelRobbery(ply)
	end
end)

hook.Add("OnPlayerChangedTeam", "robbable_npc_job", function(ply)
	if IsValid(ply._activeRobbery) then
		ply._activeRobbery:CancelRobbery(ply)
	end
end)