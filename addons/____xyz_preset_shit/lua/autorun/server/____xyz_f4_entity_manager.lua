XYZShit = XYZShit or {}
XYZShit.EntityManager = {}
XYZShit.EntityManager.Ents = {}
XYZShit.EntityManager.Blacklist = {
	["tierp_printer"] = true
}

hook.Add("playerBoughtCustomEntity", "XYZShit:EntityManager", function(ply, entityTable, ent, price)
	if not XYZShit.EntityManager.Ents[ply:SteamID64()] then
		XYZShit.EntityManager.Ents[ply:SteamID64()] = {}
	end

	if XYZShit.EntityManager.Blacklist[ent:GetClass()] then return end

	table.insert(XYZShit.EntityManager.Ents[ply:SteamID64()], ent)
end)


hook.Add("PlayerChangedTeam", "XYZShit:EntityManager", function(ply, oldTeam, newTeam)
	if not XYZShit.EntityManager.Ents[ply:SteamID64()] then return end

	for k, v in pairs(XYZShit.EntityManager.Ents[ply:SteamID64()]) do
		if not IsValid(v) then continue end

		XYZShit.Msg("Server", Color(0,255,255), "Your "..(v.PrintName or v:GetClass() or "Unknown").." was removed due to you changing job!", ply)

		v:Remove()
	end

	XYZShit.EntityManager.Ents[ply:SteamID64()] = nil
end)