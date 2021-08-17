net.Receive("ChristmasCredits:Purchase", function(_, ply)
	local npc = net.ReadEntity()

	if not (npc:GetClass() == "xyz_christmas_credits_npc") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end
	if npc.cooldown > CurTime() then return end
	npc.cooldown = CurTime() + 0.5

	local item = net.ReadInt(32)
	item = XYZChristmasCredits.Config.Items[item]

	if not item then return end

	if not (tonumber(XYZChristmasCredits.Core.PlyCredits[ply:SteamID64()]) >= tonumber(item.price)) then
		XYZShit.Msg("Christmas Credit Store", Color(246, 70, 99), "You cannot afford this item...", ply)
		return
	end

	if item.canBuy then
		if not item.canBuy(ply) then
			XYZShit.Msg("Christmas Credit Store", Color(246, 70, 99), "You cannot purchase this item for some unknown reason", ply)
			return
		end
	end

	XYZShit.Msg("Christmas Credit Store", Color(246, 70, 99), "You have purchased "..item.name.." for "..string.Comma(item.price).." Christmas Credits!", ply)
	XYZChristmasCredits.Database.GiveCredits(ply, -item.price)
	item.action(ply, npc)
end)