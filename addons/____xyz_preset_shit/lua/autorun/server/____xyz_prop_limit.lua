local propLimits = {}
propLimits["vip"] = 30
propLimits["elite"] = 40
propLimits["event"] = 80
propLimits["superadmin"] = 100
propLimits["developer"] = 100

hook.Add("PlayerSpawnProp", "xyz_prop_limit_check", function(ply, model)
	local count = ply:GetCount("props") + 1
	local limit = propLimits[ply:GetUserGroup()] or propLimits[ply:GetSecondaryUserGroup()] or 25

	if count > limit then XYZShit.Msg("Props", Color(30, 150, 200), string.format("You have reached your prop limit of %s/%s", limit, limit), ply) return false end
end)

hook.Add("PlayerSpawnedProp", "xyz_prop_limit_notify", function(ply, model)
	local count = ply:GetCount("props") + 1
	local limit = propLimits[ply:GetUserGroup()] or propLimits[ply:GetSecondaryUserGroup()] or 25

	XYZShit.Msg("Props", Color(30, 150, 200), string.format("You have spawned a prop. You're now at %s/%s", count, limit ), ply)
end)