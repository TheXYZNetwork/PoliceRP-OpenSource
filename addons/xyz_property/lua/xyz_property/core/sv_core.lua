hook.Add("playerBuyDoor", "Property:Buy", function(ply, door, other)
	if door:IsVehicle() then return end

	local doorData, doorKey = Property.Core.FindProperty(door)
	if not doorData then return false end

	if Property.Ownership[ply:SteamID64()] then
		XYZShit.Msg("Property", Property.Config.Color, "You already own a property, sell that one first...", ply)
		return false
	end

	if door:isKeysOwned() then
		Property.Ownership[ply:SteamID64()] = doorKey
		for k, v in pairs(doorData.doorEnts) do
			v:addKeysDoorOwner(ply)
		end

		net.Start("Property:Icon")
			net.WriteBool(true)
			net.WriteUInt(doorKey, 32)
		net.Send(ply)

		XYZShit.Msg("Property", Property.Config.Color, "You have collected co-ownership keys for the property: "..doorData.name, ply)
		return false
	end

	if not ply:canAfford(doorData.price) then
		XYZShit.Msg("Property", Property.Config.Color, "You cannot afford this property...", ply)
		return false
	end

	-- Charge them for the property.
	ply:addMoney(-doorData.price)

	for k, v in pairs(doorData.doorEnts) do
		v:keysOwn(ply)
	end

	net.Start("Property:Icon")
		net.WriteBool(true)
		net.WriteUInt(doorKey, 32)
	net.Send(ply)

	Property.Ownership[ply:SteamID64()] = doorKey
	hook.Run("PropertyPurchase", ply, doorData)

	XYZShit.Msg("Property", Property.Config.Color, "You have purchased the property: "..doorData.name, ply)

	return false
end)

hook.Add("playerSellDoor", "Property:Sell", function(ply, door)
	if door:IsVehicle() then return end

	local doorData, doorKey = Property.Core.FindProperty(door)
	if not doorData then return end

	if not (doorKey == Property.Ownership[ply:SteamID64()]) then return end

	if not door:isMasterOwner(ply) then
		Property.Ownership[ply:SteamID64()] = nil
		for k, v in pairs(doorData.doorEnts) do
			v:removeKeysDoorOwner(ply)
		end

		net.Start("Property:Icon")
			net.WriteBool(false)
			net.WriteUInt(doorKey, 32)
		net.Send(ply)

		XYZShit.Msg("Property", Property.Config.Color, "You have left co-ownership keys for the property: "..doorData.name, ply)
		return false
	end
	
	ply:addMoney(doorData.price * Property.Config.ReturnAmount)

	for k, v in pairs(door:getKeysCoOwners() or {}) do
		local owner = Player(k)

		Property.Ownership[owner:SteamID64()] = nil
	end
	for k, v in pairs(doorData.doorEnts) do
        v:keysUnOwn(ply)
        v:setKeysTitle(nil)
        v:removeAllKeysExtraOwners()
        v:removeAllKeysAllowedToOwn()
	end

	Property.Ownership[ply:SteamID64()] = nil
	hook.Run("PropertySell", ply, doorData)

	net.Start("Property:Icon")
		net.WriteBool(false)
		net.WriteUInt(doorKey, 32)
	net.Send(ply)

	XYZShit.Msg("Property", Property.Config.Color, "You have sold the property: "..doorData.name, ply)

	return false
end)

hook.Add("onAllowedToOwnAdded", "Property:AddCoOwner", function(ply, door, target)
	if door:IsVehicle() then return end

	local doorData, doorKey = Property.Core.FindProperty(door)
	if not doorData then return end

	if not (doorKey == Property.Ownership[ply:SteamID64()]) then return false end
	if doorKey == Property.Ownership[target:SteamID64()] then return false end

	if not door:isMasterOwner(ply) then return false end

	for k, v in pairs(doorData.doorEnts) do
        v:addKeysAllowedToOwn(target)
	end

	return false
end)

hook.Add("onAllowedToOwnRemoved", "Property:RemoveCoOwner", function(ply, door, target)
	if door:IsVehicle() then return end

	local doorData, doorKey = Property.Core.FindProperty(door)
	if not doorData then return end

	if not (doorKey == Property.Ownership[ply:SteamID64()]) then return false end

	if not door:isMasterOwner(ply) then return false end

	for k, v in pairs(doorData.doorEnts) do
        v:removeKeysAllowedToOwn(target)
        v:keysUnOwn(target)

		net.Start("Property:Icon")
			net.WriteBool(false)
			net.WriteUInt(doorKey, 32)
		net.Send(target)

        if Property.Ownership[target:SteamID64()] == doorKey then
        	Property.Ownership[target:SteamID64()] = nil
        end
	end

	return false
end)