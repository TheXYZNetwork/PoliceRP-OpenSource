net.Receive("Scrapper:Sell", function(_, ply)
    if XYZShit.CoolDown.Check("Scrapper:Sell", 1, ply) then return end
	if XYZShit.IsGovernment(ply:Team(), true) then return end

	local npc = net.ReadEntity()
	local vehicle = net.ReadEntity()

	-- Validate NPC
	if not (npc:GetClass() == "xyz_car_scrapper") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 300 then return end

	-- Validate Vehicle
	if not vehicle:IsVehicle() then return end
	if npc:GetPos():Distance(vehicle:GetPos()) > 500 then return end

	if npc:GetPos():Distance(vehicle:GetPos()) > 500 then return end
	if vehicle.getDoorOwner and (vehicle:getDoorOwner() == ply) then return end



    if XYZShit.CoolDown.Check("Scrapper:Sell:Cooldown", Scrapper.Config.SellCooldown(ply), ply) then
		XYZShit.Msg("Car Scrapper", Scrapper.Config.Color, "You must wait a while before trying to scrap another vehicle...", ply)
    	return
    end

    if vehicle.vehicleID then
    	Scrapper.Cooldowns[vehicle.vehicleID] = CurTime()
    end
    if vehicle.getDoorOwner and IsValid(vehicle:getDoorOwner()) then
		XYZShit.Msg("Car Scrapper", Scrapper.Config.Color, "Your vehicle has been scrapped...", vehicle:getDoorOwner())
    end

    local price = math.Round(Scrapper.Config.PriceMultiplier(ply, npc:GetSellPrice()))


    ply:addMoney(price)
	XYZShit.Msg("Car Scrapper", Scrapper.Config.Color, "You have scrapped a vehicle for "..DarkRP.formatMoney(price).."!", ply)

	xLogs.Log(xLogs.Core.Player(ply).." has just scrapped a "..vehicle:GetVehicleClass().." for "..xLogs.Core.Color(DarkRP.formatMoney(price), Color(0, 200, 0)), "Car Scrapper")

	Quest.Core.ProgressPartyQuest(ply, "life_of_crime", 4)

    vehicle:Remove()
end)

hook.Add("CarDealerCanSpawn", "Scrapper:Block", function(ply, vehicle)
	local vehicleID = vehicle.id
	if not vehicleID then return end

	local scrappedTime = Scrapper.Cooldowns[vehicleID]
	if (not scrappedTime) or (not ((scrappedTime + Scrapper.Config.SpawnCooldown) > CurTime())) then return end

	return false, "We're still waiting for the insurance payout on this vehicle since it was scrapped, try again later."
end)