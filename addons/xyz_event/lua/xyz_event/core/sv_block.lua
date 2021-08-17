hook.Add("Inventory.CanDrop", "EventSystem:Block", function(ply)
	if not (ply:Team() == TEAM_EVENT) then return end
	return false
end)
hook.Add("Inventory.CanDestroy", "EventSystem:Block", function(ply)
	if not (ply:Team() == TEAM_EVENT) then return end
	return false
end)
hook.Add("Inventory.CanPickup", "EventSystem:Block", function(ply)
	if (not (ply:Team() == TEAM_EVENT)) and (not (ply:Team() == TEAM_EVENTTEAM)) then return end
	return false
end)
hook.Add("Inventory.CanHolster", "EventSystem:Block", function(ply)
	if (not (ply:Team() == TEAM_EVENT)) and (not (ply:Team() == TEAM_EVENTTEAM)) then return end
	return false
end)
hook.Add("Inventory.CanEquip", "EventSystem:Block", function(ply)
	if not (ply:Team() == TEAM_EVENT) then return end
	return false
end)
hook.Add("PlayerSpawnProp", "EventSystem:Block", function(ply)
	if not (ply:Team() == TEAM_EVENT) then return end
	if not EventSystem.Data.blockPropSpawning then return end
	
	return false
end)
hook.Add("canBuyCustomEntity", "EventSystem:Block", function(ply)
	if not (ply:Team() == TEAM_EVENT) then return end
	return false
end)
hook.Add("canBuyAmmo", "EventSystem:Block", function(ply)
	if not (ply:Team() == TEAM_EVENT) then return end
	return false
end)
hook.Add("canBuyAmmo", "EventSystem:Block", function(ply)
	if not (ply:Team() == TEAM_EVENT) then return end
	return false
end)
hook.Add("playerCanChangeTeam", "EventSystem:Block", function(ply, team, forced)
	if not (ply:Team() == TEAM_EVENT) then return end
	if forced then return end
	
	return false
end)