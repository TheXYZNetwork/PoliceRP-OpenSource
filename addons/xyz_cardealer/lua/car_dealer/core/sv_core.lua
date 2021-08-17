hook.Add("PlayerInitialSpawn", "CarDealer:Player:Load", function(ply)
	CarDealer.Vehicles[ply:SteamID64()] = {}

	CarDealer.Database.LoadID(ply:SteamID64(), function(data)
		if not IsValid(ply) then return end
		
		for k, v in pairs(data) do
			local vehicleData = {}

			vehicleData.id = v.id
			vehicleData.class = v.class
			local color = string.Split(v.color, ",")
			vehicleData.color = Color(color[1], color[2], color[3])
			vehicleData.skin = v.skin
			vehicleData.bodygroups = util.JSONToTable(v.bodygroups)
			vehicleData.mods = util.JSONToTable(v.mods)
			vehicleData.performance = util.JSONToTable(v.performance)
			vehicleData.damage = util.JSONToTable(v.damage)

			CarDealer.Vehicles[ply:SteamID64()][v.id] = vehicleData
		end

		net.Start("CarDealer:Vehicle:Load")
			net.WriteTable(CarDealer.Vehicles[ply:SteamID64()])
		net.Send(ply)
	end)
end)

net.Receive("CarDealer:Purchase", function(_, ply)
    if XYZShit.CoolDown.Check("CarDealer:Purchase", 1, ply) then return end

    -- Load sent data
	local npc = net.ReadEntity()
	local class = net.ReadString()
	local customs = net.ReadTable()

	-- Validate NPC
	if not (npc:GetClass() == "xyz_car_dealer") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 300 then return end
	
	-- Validate requested vehicle
	local vehicleData = CarDealer.Config.Cars[class]
	if not vehicleData then return end

	if not vehicleData.restricted(ply) then return end

	-- Check they have a license
	if not isnumber(licensedUsers[ply:SteamID64()]) then
		XYZShit.Msg("Car Salesmen", CarDealer.Config.Color, "You must have a driver's license to purchase a vehicle!", ply)
		return
	end

	-- The color
	local color = customs.color or Color(255, 255, 255)
	-- The skin
	local skin = customs.skin or 0

	local bodygroups = {}
	for k, v in pairs(customs.bodygroups or {}) do
		-- Someone is probably trying to put a sneaky in there
		if (not isnumber(k)) or (not isnumber(v)) then return end

		bodygroups[k] = v
	end

	local mods = {}
	for k, v in pairs(customs.mods or {}) do
		-- Someone gave an invalid mod :/
		if not CarDealer.Config.Mods[k] then return end
		
		mods[k] = (v == true)
	end

	local performance = {}
	for k, v in pairs(customs.performance or {}) do
		-- Someone gave an invalid performance
		if not CarDealer.Config.Performance[k] then return end
		if not CarDealer.Config.Performance[k].options[v] then return end

		performance[k] = v
	end


	local totalCost = 0
	-- Vehicle cost
	totalCost = totalCost + CarDealer.Config.Price.Vehicle(ply, vehicleData.price)
	-- Vehicle Skin
	if not (skin == 0) then
		totalCost = totalCost + CarDealer.Config.Price.Skin(ply)
	end
	-- Bodygroups
	for k, v in pairs(bodygroups) do
		if v == 0 then continue end

		totalCost = totalCost + CarDealer.Config.Price.Bodygroup(ply)
	end
	-- Mods
	for k, v in pairs(mods) do
		if not v then continue end

		totalCost = totalCost + CarDealer.Config.Mods[k].price(ply)
	end
	-- Performance
	for k, v in pairs(performance) do
		local data = CarDealer.Config.Performance[k].options[v]

		if data then
			totalCost = totalCost + data.price
		end
	end

	if not ply:canAfford(totalCost) then
		XYZShit.Msg("Car Salesmen", CarDealer.Config.Color, "You can't afford this vehicle, maybe go for something a little less flashy...", ply)
		return
	end

	XYZShit.Msg("Car Salesmen", CarDealer.Config.Color, "You have purchased a new vehicle!", ply)

	ply:addMoney(-totalCost)

	xLogs.Log(xLogs.Core.Player(ply).." has just purchased "..xLogs.Core.Color(class, Color(0, 0, 200)).." for "..xLogs.Core.Color(DarkRP.formatMoney(totalCost), Color(0, 200, 0)), "Car Dealer")

	CarDealer.Core.Give(ply, class, color, skin, bodygroups, mods, performance)

	Quest.Core.ProgressQuest(ply, "joyrider", 5, totalCost)
end)

net.Receive("CarDealer:Tune", function(_, ply)
    -- Load sent data
	local npc = net.ReadEntity()
	local vehicleID = net.ReadUInt(32)
	local customs = net.ReadTable()

	local vehicle = CarDealer.Vehicles[ply:SteamID64()][vehicleID] 
	-- Confirm they have the vehicle
	if not vehicle then return end
	local vehicleData = CarDealer.Config.Cars[vehicle.class]
	-- No vehicle data
	if not vehicleData then return end

	-- Validate NPC
	if not (npc:GetClass() == "xyz_car_dealer") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 300 then return end


	-- The color
	local color = customs.color or vehicle.color
	-- The skin
	local skin = customs.skin or vehicle.skin

	local bodygroups = vehicle.bodygroups and table.Copy(vehicle.bodygroups) or {}
	for k, v in pairs(customs.bodygroups or {}) do
		-- Someone is probably trying to put a sneaky in there
		if (not isnumber(k)) or (not isnumber(v)) then return end

		bodygroups[k] = v
	end

	local mods = vehicle.mods and table.Copy(vehicle.mods) or {}
	for k, v in pairs(customs.mods or {}) do
		-- Someone gave an invalid mod :/
		if not CarDealer.Config.Mods[k] then return end
		
		mods[k] = (v == true)
	end

	local performance = vehicle.performance and table.Copy(vehicle.performance) or {}
	for k, v in pairs(customs.performance or {}) do
		-- Someone gave an invalid performance
		if not CarDealer.Config.Performance[k] then return end
		if not CarDealer.Config.Performance[k].options[v] then return end

		performance[k] = v
	end

	local totalCost = 0
	-- Vehicle Color
	if not (color == vehicle.color) then
		totalCost = totalCost + CarDealer.Config.Price.Color(ply)
	end
	-- Vehicle Skin
	if not (skin == vehicle.skin) then
		totalCost = totalCost + CarDealer.Config.Price.Skin(ply)
	end

	-- Bodygroups
	for k, v in pairs(bodygroups) do
		if vehicle.bodygroups and vehicle.bodygroups[k] and (v == vehicle.bodygroups[k]) then continue end

		totalCost = totalCost + CarDealer.Config.Price.Bodygroup(ply)
	end
	-- Mods
	for k, v in pairs(mods) do
		if vehicle.mods and (not (vehicle.mods[k] == nil)) and (vehicle.mods[k] == v) then continue end

		totalCost = totalCost + CarDealer.Config.Mods[k].price(ply)
	end
	-- Performance
	for k, v in pairs(performance) do
		if vehicle.performance and vehicle.performance[k] and (v == vehicle.performance[k]) then continue end
		local data = CarDealer.Config.Performance[k].options[v]

		if data then
			totalCost = totalCost + data.price
		end
	end

	if not ply:canAfford(totalCost) then
		XYZShit.Msg("Car Salesmen", CarDealer.Config.Color, "You can't afford these tune changes!", ply)
		return
	end
	
	XYZShit.Msg("Car Salesmen", CarDealer.Config.Color, "You have tuned your vehicle!", ply)

	ply:addMoney(-totalCost)

	xLogs.Log(xLogs.Core.Player(ply).." has just tuned their "..xLogs.Core.Color(vehicle.class, Color(0, 0, 200)).." ("..tostring(vehicleID)..") for "..xLogs.Core.Color(DarkRP.formatMoney(totalCost), Color(0, 200, 0)), "Car Customs")

	CarDealer.Core.Tune(ply, vehicleID, color, skin, bodygroups, mods, performance)

	Quest.Core.ProgressQuest(ply, "joyrider", 2)
end)

net.Receive("CarDealer:Spawn", function(_, ply)
    if XYZShit.CoolDown.Check("CarDealer:Spawn", 1, ply) then return end
	if XYZShit.IsGovernment(ply:Team(), true) and not table.HasValue(XYZShit.Jobs.Government.FBI, ply:Team()) then
		XYZShit.Msg("Car Salesmen", CarDealer.Config.Color, "You cannot spawn personal vehicles as government...", ply)
		return
	end

    -- Load sent data
	local npc = net.ReadEntity()
	local vehicleID = net.ReadUInt(32)
	local vehicle = CarDealer.Vehicles[ply:SteamID64()][vehicleID]
	-- Confirm they have the vehicle
	if not vehicle then return end
	local vehicleData = CarDealer.Config.Cars[vehicle.class]
	-- No vehicle data
	if not vehicleData then return end

	-- Validate NPC
	if not (npc:GetClass() == "xyz_car_dealer") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 300 then return end

	if IsValid(ply.currentVehicle) then
			XYZShit.Msg("Car Salesmen", CarDealer.Config.Color, "Please return your current vehicle before trying to retrieve a new one...", ply)
		return
	end

	-- Allow other addons to block spawning. For example the impound
	local canSpawn, reason = hook.Run("CarDealerCanSpawn", ply, vehicle)
	if canSpawn == false then
		if reason then
			XYZShit.Msg("Car Salesmen", CarDealer.Config.Color, reason, ply)
		end
		return
	end

	local spawnData = CarDealer.Core.GetSpawnPoint()
	if not spawnData then
		XYZShit.Msg("Car Salesmen", CarDealer.Config.Color, "There are currently no parking spots available", ply)
		return
	end

	local car = ents.Create("prop_vehicle_jeep")
	car:SetPos(spawnData.pos)
	car:SetAngles(spawnData.ang)
	car:SetModel(vehicleData.model)
	car:SetKeyValue("vehiclescript", vehicleData.script)
	car:Spawn()
	car:Activate()
	car:DropToFloor()
	car:SetVehicleClass(vehicleData.class)
	car:keysOwn(ply)
	car:keysLock()
	car.owner = ply

	car.vehicleID = vehicleID
	car:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	timer.Simple(CarDealer.Config.SpawnProtection, function()
		if not IsValid(car) then return end

		car:SetCollisionGroup(COLLISION_GROUP_NONE)
	end)

	local id64 = ply:SteamID64()
	hook.Add("VC_postVehicleInit", "CarDealer:Load:"..id64, function(ent)
		hook.Remove("VC_postVehicleInit", "CarDealer:Load:"..id64)

		if not IsValid(ply) then return end
		if not IsValid(ent) then return end
		if not (ent == car) then return end

		CarDealer.Core.ApplyCustoms(ply, ent)

		if car:VC_getHealth(true) <= 20 then

			net.Start("CarDealer:UI:Repair")
				net.WriteEntity(npc)
			net.Send(ply)
		end
	end)

	xLogs.Log(xLogs.Core.Player(ply).." has just spawned "..xLogs.Core.Color(car:GetVehicleClass(), Color(0, 0, 200)), "Car Dealer")


	ply.currentVehicle = car
end)

net.Receive("CarDealer:Sell", function(_, ply)
    if XYZShit.CoolDown.Check("CarDealer:Sell", 1, ply) then return end

    -- Load sent data
	local npc = net.ReadEntity()
	local vehicleID = net.ReadUInt(32)
	local vehicle = CarDealer.Vehicles[ply:SteamID64()][vehicleID] 
	-- Confirm they have the vehicle
	if not vehicle then return end
	local vehicleData = CarDealer.Config.Cars[vehicle.class]
	-- No vehicle data
	if not vehicleData then return end

	if not vehicleData.sellable then return end

	-- Validate NPC
	if not (npc:GetClass() == "xyz_car_dealer") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 300 then return end

	-- Allow other addons to block spawning. For example the impound
	local canSpawn, reason = hook.Run("CarDealerCanSell", ply, vehicle)
	if canSpawn == false then
		if reason then
			XYZShit.Msg("Car Salesmen", CarDealer.Config.Color, reason, ply)
		end
		return
	end

	if IsValid(ply.currentVehicle) and (ply.currentVehicle.vehicleID == vehicle.id) then
			XYZShit.Msg("Car Salesmen", CarDealer.Config.Color, "Please return this vehicle first!", ply)
		return
	end

	ply:addMoney(vehicleData.price * CarDealer.Config.SellBack)
	XYZShit.Msg("Car Salesmen", CarDealer.Config.Color, "You have sold a vehicle for "..DarkRP.formatMoney(vehicleData.price * CarDealer.Config.SellBack).."!", ply)

	xLogs.Log(xLogs.Core.Player(ply).." has just sold "..xLogs.Core.Color(vehicle.class, Color(0, 0, 200)).." for "..xLogs.Core.Color(DarkRP.formatMoney(vehicleData.price * CarDealer.Config.SellBack), Color(0, 200, 0)), "Car Dealer")

	CarDealer.Core.Remove(ply, vehicleID)
end)

net.Receive("CarDealer:Return", function(_, ply)
    if XYZShit.CoolDown.Check("CarDealer:Sell", 1, ply) then return end

    local vehicle = ply.currentVehicle
    if not IsValid(vehicle) then return end

    -- Store current vehicle state in a database
	CarDealer.Core.UpdateDamage(ply, vehicle)
    
	xLogs.Log(xLogs.Core.Player(ply).." has just spawned returned their vehicle.", "Car Dealer")

    vehicle:Remove()
    ply.currentVehicle = nil
end)

net.Receive("CarDealer:Vehicle:Repair", function(_, ply)
    if XYZShit.CoolDown.Check("CarDealer:Repair", 1, ply) then return end

	local npc = net.ReadEntity()
    local vehicle = ply.currentVehicle
    if not IsValid(npc) then return end
    if not IsValid(vehicle) then return end

	-- Validate NPC
	if not (npc:GetClass() == "xyz_car_dealer") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 300 then return end

	local cost = CarDealer.Config.RepairCost(ply)

	if not ply:canAfford(cost) then
		XYZShit.Msg("Car Salesmen", CarDealer.Config.Color, "You can't afford to repair your vehicle...", ply)
		return
	end

	XYZShit.Msg("Car Salesmen", CarDealer.Config.Color, "You have repaired your vehicle!", ply)

	ply:addMoney(-cost)

	vehicle:VC_repairFull_Admin()

	local vehicleMaxFuel = vehicle:VC_fuelGetMax()
	vehicle:VC_fuelSet(vehicleMaxFuel)
    
	xLogs.Log(xLogs.Core.Player(ply).." has repaired their vehicle to 20%.", "Car Dealer")
end)

function CarDealer.Core.Give(ply, class, color, skin, bodygroups, mods, performance)
	if not class then return end
	local vehicleData = CarDealer.Config.Cars[class]
	if not vehicleData then return end

	color = color and Color(color.r, color.g, color.b) or Color(255, 255, 255)
	skin = skin or 0
	bodygroups = bodygroups or {}
	mods = mods or {}
	performance = performance or {}

	CarDealer.Database.GiveID(ply:SteamID64(), class, color, skin, bodygroups, mods, performance, function(responseData)
		if not IsValid(ply) then return end
		if not responseData[1] then return end
		if not responseData[1]["LAST_INSERT_ID()"] then return end

		local vehicleID = responseData[1]["LAST_INSERT_ID()"]

		local data = {
			id = vehicleID,
			class = class,
			color = color,
			skin = skin,
			bodygroups = bodygroups,
			mods = mods,
			performance = performance
		}

		CarDealer.Vehicles[ply:SteamID64()][vehicleID] = data

		net.Start("CarDealer:Vehicle:New")
			net.WriteTable(data)
		net.Send(ply)

		-- Give them their badge
		if table.Count(CarDealer.Vehicles[ply:SteamID64()]) >= 15 then
			ply:GiveBadge("connoisseur")
		end
	end)
end

function CarDealer.Core.Remove(ply, vehicleID)
	if not IsValid(ply) then return end
	if not vehicleID then return end

	local vehicle = CarDealer.Vehicles[ply:SteamID64()][vehicleID] 
	if not vehicle then return end

	CarDealer.Database.RemoveVehicleID(vehicleID)

	net.Start("CarDealer:Vehicle:Remove")
		net.WriteUInt(vehicleID, 32)
	net.Send(ply)

	CarDealer.Vehicles[ply:SteamID64()][vehicleID] = nil
end

function CarDealer.Core.Tune(ply, vehicleID, color, skin, bodygroups, mods, performance)
	local vehicle = CarDealer.Vehicles[ply:SteamID64()][vehicleID]
	if not vehicle then return end

	local vehicleData = CarDealer.Config.Cars[vehicle.class]
	if not vehicleData then return end

	color = Color(color.r, color.g, color.b) or Color(255, 255, 255)
	skin = skin or 0
	bodygroups = bodygroups or {}
	mods = mods or {}
	performance = performance or {}


	CarDealer.Database.TuneVehicleID(vehicleID, color, skin, bodygroups, mods, performance)

	CarDealer.Vehicles[ply:SteamID64()][vehicleID].color = color
	CarDealer.Vehicles[ply:SteamID64()][vehicleID].skin = skin
	CarDealer.Vehicles[ply:SteamID64()][vehicleID].bodygroups = bodygroups
	CarDealer.Vehicles[ply:SteamID64()][vehicleID].mods = mods
	CarDealer.Vehicles[ply:SteamID64()][vehicleID].performance = performance

	net.Start("CarDealer:Vehicle:Update")
		net.WriteTable(CarDealer.Vehicles[ply:SteamID64()][vehicleID])
	net.Send(ply)
end

function CarDealer.Core.UpdateDamage(ply, vehicle)
	if not ply then return end
	if not vehicle then return end
	if not vehicle.vehicleID then return end

	local damageState = {
		parts = vehicle:VC_getDamagedParts(),
		health = vehicle:VC_getHealth(),
		fuel = vehicle:VC_fuelGet(),
	}

	CarDealer.Vehicles[ply:SteamID64()][vehicle.vehicleID].damage = damageState

	CarDealer.Database.UpdateDamageVehicleID(vehicle.vehicleID, damageState)
end

function CarDealer.Core.GetSpawnPoint()
	for k, v in ipairs(CarDealer.Config.Spawns) do
		if not v.last then
			v.last = 0
		end

		-- has been used in the last 3 seconds
		if (v.last + 180) > os.time() then continue end

		v.last = os.time()
		return v
	end

	return false
end

function CarDealer.Core.ApplyCustoms(ply, vehicle)
	if not vehicle then return end
	if not vehicle.vehicleID then return end

	local vehicleData = CarDealer.Vehicles[ply:SteamID64()][vehicle.vehicleID]

	-- Apply color
	if vehicleData.color then
		vehicle:SetColor(vehicleData.color)
	end
	-- Apply skin
	if vehicleData.skin then
		vehicle:SetSkin(vehicleData.skin)
	end
	-- Apply bodygroups
	if vehicleData.bodygroups then
		for k, v in pairs(vehicleData.bodygroups) do
			vehicle:SetBodygroup(k, v)
		end
	end
	-- Apply mods
	if vehicleData.mods then
		for k, v in pairs(vehicleData.mods) do
			if not v then continue end

			local modData = CarDealer.Config.Mods[k]
			modData.spawnAction(vehicle, ply)
		end
	end
	-- Apply performance
	if vehicleData.performance then
		for k, v in pairs(vehicleData.performance) do
			if not v then continue end

			local perfData = CarDealer.Config.Performance[k]
			local perfVal = perfData.options[v].val
			perfData.spawnAction(vehicle, perfVal)
		end
	end

	-- Apply damage
	if vehicleData.damage then
		if vehicleData.damage.parts then
			for k, v in pairs(vehicleData.damage.parts) do
				for n, m in pairs(v) do
					vehicle:VC_damagePart(k, n)
				end
			end
		end
		if vehicleData.damage.health then
			vehicle:VC_setHealth(vehicleData.damage.health)
		end
		if vehicleData.damage.fuel then
			vehicle:VC_fuelSet(vehicleData.damage.fuel)
		end
	end
end

hook.Add("EntityRemoved", "CarDealer:VehiclePersistence", function(ent)
	if not IsValid(ent) then return end
	if not ent:IsVehicle() then return end
	if not ent.vehicleID then return end
	if not IsValid(ent.owner) then return end

	CarDealer.Core.UpdateDamage(ent.owner, ent)
end)

hook.Add("CanProperty", "CarDealer:Block", function(ply, property, ent)
	if ent:IsVehicle() then
		if property == "bodygroups" then
			if not XYZShit.Staff.All[ply:GetUserGroup()] then return false end
		elseif property == "skin" then
			if not XYZShit.Staff.All[ply:GetUserGroup()] then return false end
		end
	end
end)


-- Car engine
sound.Add ({
	name = "start_engine",
	channel = CHAN_STATIC,
	volume = 1,
	level = 68,
	pitch = 100,
	sound = "xyz/car_starter.wav"
})

hook.Add("PlayerEnteredVehicle", "CarDealer:Engine:Off", function(ply, vehicle)
	if vehicle:GetClass() == "prop_vehicle_prisoner_pod" then return end
	if vehicle.EngineState then return end

	vehicle:Fire("TurnOff", "1")
	vehicle.EngineState = false

	XYZShit.Msg("Server", Color(0,255,255), "Press and hold H to start your engine.", ply)
end)

hook.Add("PlayerLeaveVehicle", "StartEngine:Cancel", function(ply, vehicle)
	if timer.Exists("CarEngine:Start:"..vehicle:EntIndex()) then
		vehicle:StopSound("start_engine")
		timer.Remove("CarEngine:Start:"..vehicle:EntIndex())
	elseif vehicle.EngineState then
		vehicle:Fire("TurnOn", "1")
		vehicle:StartEngine(true)
		XYZShit.Msg("Server", Color(0,255,255), "You have left a vehicle with the engine running, this will consume fuel while idle.", ply)
	end
end) 

hook.Add("PlayerButtonDown", "StartEngine", function(ply, button)
	if not (button == KEY_H) then return end
    if XYZShit.CoolDown.Check("CarEngine:Toggle", 1, ply) then return end

	local vehicle = ply:GetVehicle()
	if not IsValid(vehicle) then return end

	if vehicle:VC_fuelGet(true) <= 1 then return end

	-- Engine is on
	if vehicle.EngineState then
		vehicle:Fire("TurnOff", "1")
		vehicle.EngineState = false
	else
		local startTime = vehicle:VC_getHealth()/vehicle:VC_getHealthMax()
		startTime = 3 - (2 * startTime)

		vehicle:EmitSound("start_engine")
		timer.Create("CarEngine:Start:"..vehicle:EntIndex(), startTime, 1, function()
			vehicle:StopSound("start_engine")
			vehicle:Fire("TurnOn", "1")
			vehicle.EngineState = true
		end)
	end
end)

hook.Add("PlayerButtonUp", "StartEngine:Cancel", function(ply, button)
	if not (button == KEY_H) then return end

	local vehicle = ply:GetVehicle()
	if not IsValid(vehicle) then return end

	vehicle:StopSound("start_engine")
	timer.Remove("CarEngine:Start:"..vehicle:EntIndex())
end)

hook.Add("VC_canChangeState", "StartEngine:Block", function(ent, id, new, old, ply)
	if id == "CruiseOn" and not ent.EngineState then
		return false
	end
end)

hook.Add("VC_healthChanged", "StartEngine:Kill", function(vehicle, oldHealth, newHealth)
	if newHealth > oldHealth then return end

	local damageTaken = oldHealth-newHealth

	if damageTaken < CarDealer.Config.KillEngineDamage then return end
	print("VC_healthChanged", vehicle, oldHealth, newHealth)
	print("The difference:", damageTaken)
	print("Killing engine")
	vehicle:Fire("TurnOff", "1")
	vehicle.EngineState = false
end)
