net.Receive("Cocaine:BuyItem", function(_, ply)
    if XYZShit.CoolDown.Check("Cocaine:BuyItem", 2, ply) then return end
	local item = net.ReadString()
	local itemData = XYZDrugsTable.Core.GetDataByClass(item)
	if not itemData then return end
    if itemData.check and not (itemData.check(ply)) then return end

	if not XYZDrugsTable.Limits[ply:SteamID64()] then
		XYZDrugsTable.Limits[ply:SteamID64()] = {}
	end
	if not XYZDrugsTable.Limits[ply:SteamID64()][item] then
		XYZDrugsTable.Limits[ply:SteamID64()][item] = 0
	end
	if XYZDrugsTable.Limits[ply:SteamID64()][item] >= ((itemData.limit + (XYZDrugsTable.Config.Addition[ply:Team()] or 0)) or 99999) then
		XYZShit.Msg("Buy Drugs", XYZDrugsTable.Config.Color, "You have reached the limit for this item.", ply)
		return
	end

    local trace = ply:GetEyeTrace()
    local plyAngle = ply:GetAngles()
    local spawnPos = trace.HitPos + plyAngle:Forward() + plyAngle:Up()

    if spawnPos:DistToSqr(ply:GetPos()) > 50000 then
		XYZShit.Msg("Buy Drugs", XYZDrugsTable.Config.Color, "You are trying to place this item too far away from you!", ply)
		return
    end

    local blocks = ents.FindInBox(trace.HitPos - XYZDrugsTable.Config.SpawnBuffer, trace.HitPos + XYZDrugsTable.Config.SpawnBuffer)

    for k, v in pairs(blocks) do
    	if table.HasValue(XYZDrugsTable.Config.SpawnWhitelist, v:GetClass()) then continue end
    
    	print("Drug Tablet prevented spawning of", itemData.ent, "for", ply, "because", v:GetClass(), "was blocking it.")
		XYZShit.Msg("Buy Drugs", XYZDrugsTable.Config.Color, "Something is blocking you from spawning this item here!", ply)
		return
    end

    --if true then return end

	if not ply:canAfford(itemData.price) then return end
	XYZDrugsTable.Limits[ply:SteamID64()][item] = XYZDrugsTable.Limits[ply:SteamID64()][item] + 1

	ply:addMoney(-itemData.price)
	XYZShit.Msg("Buy Drugs", XYZDrugsTable.Config.Color, "You have purchased something from the Buy Drugs store.", ply)
	xLogs.Log(xLogs.Core.Player(ply).." has purchased "..xLogs.Core.Color(itemData.ent, Color(0, 0, 200)), "Drug Tablet")

	local itemEntity = ents.Create(itemData.ent)

	itemEntity:SetPos(spawnPos)
	itemEntity:SetAngles(Angle(0, math.Round(plyAngle.y/10)*10 + 180, plyAngle.z))


	itemEntity:Setowning_ent(ply)
	itemEntity:Spawn()
	
	hook.Run("DrugsTabletPurchase", ply, itemData.ent)
end)

hook.Add("EntityRemoved", "Cocaine:EntityRemoved", function(entity)
	local itemData = XYZDrugsTable.Core.GetDataByClass(entity:GetClass())
	if not itemData then return end

	local owner = entity:Getowning_ent()
	local class = entity:GetClass()
	if not IsValid(owner) then return end
	if not XYZDrugsTable.Limits[owner:SteamID64()][class] then return end

	XYZDrugsTable.Limits[owner:SteamID64()][class] = XYZDrugsTable.Limits[owner:SteamID64()][class] - 1
end)

hook.Add("PlayerInitialSpawn", "Cocaine:ResetLimits", function(ply)
	XYZDrugsTable.Limits[ply:SteamID64()] = {}
end)