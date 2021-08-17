net.Receive("GunDealer:Purchase", function(_, ply)
	if XYZShit.CoolDown.Check("GunDealer:Purchase", 1, ply) then return end
	if XYZShit.IsGovernment(ply:Team(), true) then
		XYZShit.Msg("Gun Dealer", GunDealer.Config.Color, "I cannot sell to government...", ply)
		return
	end

	local npc = net.ReadEntity()
	local category = net.ReadString()
	local key = net.ReadUInt(7)
	local quantity = net.ReadUInt(7)

	local wepData = GunDealer.Config.Weapons[category][key]
	if not wepData then return end
	local wep = weapons.Get(wepData.class)
	if not wep then return end

	-- Check over the NPC
	if not (npc:GetClass() == "xyz_gundealer_npc") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end

	-- Requesting less than 1 stock? Kinda sus dude
	if quantity < 1 then return end

	local stock = npc.stock[category][key]
	-- Requesting more than in stock
	if stock and (quantity > stock) then return end

	if (table.Count(Inventory.SavedInvs[ply:SteamID64()]) + quantity) > (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
		XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
		return
	end

	local cost = wepData.price * quantity

	if !ply:canAfford(cost) then
		XYZShit.Msg("Gun Dealer", GunDealer.Config.Color, "You cannot afford to purchase this!", ply)
		return
	end

	ply:addMoney(-cost)
	for i=1, quantity do
		Inventory.Core.HolsterWeapon(ply, wepData.class)
	end

	if stock then
		npc.stock[category][key] = npc.stock[category][key] - quantity
	end
	XYZShit.Msg("Gun Dealer", GunDealer.Config.Color, "You have purchased "..quantity.." of "..(wep.PrintName or wepData.class).." for "..DarkRP.formatMoney(cost).." (Added to your inventory)!", ply)
	
	xLogs.Log(xLogs.Core.Player(ply).." has purchased "..xLogs.Core.Color(string.Comma(quantity), Color(0, 0, 200)).." of "..xLogs.Core.Color(wep.PrintName or wepData.class, Color(200, 0, 0)).." for "..xLogs.Core.Color(DarkRP.formatMoney(cost), Color(0, 2000, 0)), "Gun Dealer")
end)