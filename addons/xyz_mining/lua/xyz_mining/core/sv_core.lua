function Mining.Core.GetRandomOre()
	local pool = {}

	for k, v in pairs(Mining.Config.Ores) do
		for i=1, v.rarity do
			table.insert(pool, k)
		end
	end

	return table.Random(pool)
end

function Mining.Core.MinedOre(ply, ore)
	local oreData = Mining.Config.Ores[ore]

	if not Mining.Users[ply:SteamID64()] then
		Mining.Users[ply:SteamID64()] = {}
	end
	if not Mining.Users[ply:SteamID64()][ore] then
		Mining.Users[ply:SteamID64()][ore] = 0
	end

	Mining.Users[ply:SteamID64()][ore] = Mining.Users[ply:SteamID64()][ore] + 1

	Mining.Database.GiveOre(ply:SteamID64(), ore, 1)

	XYZShit.Msg("Mining", Mining.Config.Color, "You have mined a chunk of "..oreData.name.."!", ply)
	xLogs.Log(xLogs.Core.Player(ply).." mined a chunk of "..xLogs.Core.Color(oreData.name, Color(0, 200, 200)), "Mining")
end

net.Receive("Mining:Buy", function(_, ply)
	if XYZShit.CoolDown.Check("Mining:Buy", 1, ply) then return end

	local npc = net.ReadEntity()
	local item = net.ReadUInt(10)

	-- Check over then NPC
	if not (npc:GetClass() == "xyz_mining_npc") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end

	local gearData = Mining.Config.Gear[item]
	if not gearData then return end

	if not gearData.canBuy(ply) then return end

	if not ply:canAfford(gearData.price) then
		XYZShit.Msg("Mining", Mining.Config.Color, "You cannot afford to buy "..gearData.name.."!", ply)

		return
	end

	ply:addMoney(-gearData.price)

	XYZShit.EcoBreakdown.AddLoss("Mining", gearData.price)

	gearData.action(ply)

	XYZShit.Msg("Mining", Mining.Config.Color, "You have purchased a "..gearData.name.."!", ply)
	xLogs.Log(xLogs.Core.Player(ply).." has purcahsed a "..xLogs.Core.Color(gearData.name, Color(0, 155, 255)).." for "..xLogs.Core.Color(DarkRP.formatMoney(gearData.price), Color(0, 155, 0)), "Mining")

	Quest.Core.ProgressQuest(ply, "minecraft", 1)
end)

net.Receive("Mining:Sell", function(_, ply)
	if XYZShit.CoolDown.Check("Mining:Sell", 1, ply) then return end

	local npc = net.ReadEntity()
	local ore = net.ReadString()
	local amount = net.ReadUInt(32)

	-- Check over then NPC
	if not (npc:GetClass() == "xyz_mining_npc") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end

	local oreData = Mining.Config.Ores[ore]
	if not oreData then return end

	if (not Mining.Users[ply:SteamID64()]) or (not Mining.Users[ply:SteamID64()][ore]) then return end

	local oreCount = Mining.Users[ply:SteamID64()][ore]

	if oreCount <= 0 then return end

	if amount > oreCount then return end

	local value = math.random(oreData.value.min, oreData.value.max)
	local totalSellValue = amount*value

	ply:addMoney(totalSellValue)
	Mining.Database.GiveOre(ply:SteamID64(), ore, -amount)
	Mining.Users[ply:SteamID64()][ore] = Mining.Users[ply:SteamID64()][ore] - amount

	XYZShit.EcoBreakdown.AddGain("Mining", totalSellValue)

	XYZShit.Msg("Mining", Mining.Config.Color, "You have sold "..amount.." "..oreData.name.." for "..DarkRP.formatMoney(totalSellValue).."!", ply)
	xLogs.Log(xLogs.Core.Player(ply).." has sold "..xLogs.Core.Color(amount, Color(255, 155, 0)).." of "..xLogs.Core.Color(oreData.name, Color(0, 155, 255)).." for "..xLogs.Core.Color(DarkRP.formatMoney(totalSellValue), Color(0, 155, 0)), "Mining")

	Quest.Core.ProgressQuest(ply, "minecraft", 3, totalSellValue)
end)

net.Receive("Mining:Sell:All", function(_, ply)
	if XYZShit.CoolDown.Check("Mining:Sell:All", 1, ply) then return end

	local npc = net.ReadEntity()

	-- Check over then NPC
	if not (npc:GetClass() == "xyz_mining_npc") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end

	if (not Mining.Users[ply:SteamID64()]) then return end


	local sellValue = 0
	for k, v in pairs(Mining.Config.Ores) do
		local amount = Mining.Users[ply:SteamID64()][k]
		if not amount then continue end

		sellValue = sellValue + (math.random(v.value.min, v.value.max) * amount)

		Mining.Database.GiveOre(ply:SteamID64(), k, -amount)
		Mining.Users[ply:SteamID64()][k] = Mining.Users[ply:SteamID64()][k] - amount
	end

	if sellValue == 0 then return end

	ply:addMoney(sellValue)

	XYZShit.EcoBreakdown.AddGain("Mining", sellValue)
	XYZShit.Msg("Mining", Mining.Config.Color, "You have sold all your ores for "..DarkRP.formatMoney(sellValue).."!", ply)
	xLogs.Log(xLogs.Core.Player(ply).." has sold all their ores for "..xLogs.Core.Color(DarkRP.formatMoney(sellValue), Color(0, 155, 0)), "Mining")
	
	Quest.Core.ProgressQuest(ply, "minecraft", 3, sellValue)
end)

hook.Add("PlayerInitialSpawn", "Mining:LoadPlayer", function(ply)
	Mining.Database.LoadPly(ply:SteamID64())
end)