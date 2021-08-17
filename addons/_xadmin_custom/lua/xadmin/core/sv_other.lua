hook.Add("PlayerSpawnProp", "xAdmin:Frozen:Block", function(ply)
	if not ply:IsFrozen() then return end
	
	return false
end)