XYZPresident.TotalMoney = XYZPresident.TotalMoney or 0
XYZPresident.TaxRate = XYZPresident.TaxRate or 20
XYZPresident.Stats.AddedToFunds = 0
XYZPresident.Stats.Tax = 0 -- THESE ARE INCLUDED IN ADDEDTOFUNDS
XYZPresident.Stats.Tickets = 0 -- THESE ARE INCLUDED IN ADDEDTOFUNDS
XYZPresident.Stats.Seizures = 0 -- THESE ARE INCLUDED IN ADDEDTOFUNDS
XYZPresident.Stats.ThrownAwayCap = 0
XYZPresident.Stats.PaidOut = 0
XYZPresident.Stats.Stolen = 0

function XYZPresident:ChangeTaxRate( pPresident , iTaxAmount )
    if iTaxAmount > 100 or iTaxAmount < 0 then return end

    XYZPresident.TaxRate = iTaxAmount

    Quest.Core.ProgressQuest(pPresident, "rigged_elections", 4)

    XYZShit.Msg("Tax", Color(0, 255, 200), "The president has changed the tax rate to "..XYZPresident.TaxRate.."%")
end

net.Receive("XYZ_PRES_UP_TAX", function(len, ply)
    if XYZShit.CoolDown.Check("XYZ_PRES_UP_TAX", 10, ply) then return end

    if not (ply:Team() == TEAM_PRESIDENT) then return end


    local newTax = net.ReadInt(16)
    XYZPresident:ChangeTaxRate(ply , math.Clamp(newTax, 0, 90))
end)

net.Receive("XYZ_PRES_MANAGE_LICENSE", function(len, ply)
    if XYZShit.CoolDown.Check("XYZ_PRES_MANAGE_LICENSE", 10, ply) then return end

    if (not (ply:Team() == TEAM_PRESIDENT)) and (not (ply:Team() == TEAM_PCOM)) and (not (ply:Team() == TEAM_PDCOM)) then return end

    local target = net.ReadEntity()
    if not IsValid(target) then return end

    if target:getDarkRPVar("HasGunlicense") then
        target:setDarkRPVar("HasGunlicense", false)
        XYZShit.Msg("President Computer", Color(0, 255, 200), "You revoked "..target:Nick().."'s license", ply)
    else
        target:setDarkRPVar("HasGunlicense", true)
        XYZShit.Msg("President Computer", Color(0, 255, 200), "You gave "..target:Nick().." a license", ply)
    end
end)

hook.Add("playerGetSalary", "XYZPresidentGetSalary", function(ply, cashMoney)
    if XYZShit.IsGovernment(ply:Team(), true) then return end
    if ply.isSOD then return end

    local payout = math.Round(cashMoney - (cashMoney / 100 * XYZPresident.TaxRate))
    local taxtoadd = math.Round(cashMoney / 100 * XYZPresident.TaxRate)

    XYZShit.Msg("Tax", Color(0, 255, 200), "You paid "..DarkRP.formatMoney(taxtoadd).." in income tax", ply)

    local clamped = math.Clamp(XYZPresident.TotalMoney + taxtoadd, 0, XYZPresident.Config.HoldCap)
    local thrownaway = 0

    if clamped ~= (XYZPresident.TotalMoney + taxtoadd) then
        thrownaway = ((XYZPresident.TotalMoney + taxtoadd) - XYZPresident.Config.HoldCap)
        XYZPresident.Stats.ThrownAwayCap = XYZPresident.Stats.ThrownAwayCap + thrownaway
    end
    XYZPresident.Stats.AddedToFunds = XYZPresident.Stats.AddedToFunds + (taxtoadd - thrownaway or 0)
    XYZPresident.Stats.Tax = XYZPresident.Stats.Tax + (taxtoadd - thrownaway or 0)

    XYZPresident.TotalMoney = clamped

    return false, nil, payout
end)

hook.Add("canBuyShipment", "XYZPresidentShipment", function(ply, shipment)
    local canbecome = false
    for _, b in pairs(shipment.allowed) do
        if ply:Team() == b then
            canbecome = true
            break
        end
    end
    if not canbecome then return false end 
    local taxtoadd = math.Round(shipment.price / 100 * XYZPresident.TaxRate)
    local total = shipment.price + taxtoadd

    XYZShit.Msg("Tax", Color(0, 255, 200), "You paid "..DarkRP.formatMoney(taxtoadd).." in shipment tax", ply)

    local clamped = math.Clamp(XYZPresident.TotalMoney + taxtoadd, 0, XYZPresident.Config.HoldCap)
    local thrownaway = 0

    if clamped ~= (XYZPresident.TotalMoney + taxtoadd) then
        thrownaway = ((XYZPresident.TotalMoney + taxtoadd) - XYZPresident.Config.HoldCap)
        XYZPresident.Stats.ThrownAwayCap = XYZPresident.Stats.ThrownAwayCap + thrownaway
    end
    XYZPresident.Stats.AddedToFunds = XYZPresident.Stats.AddedToFunds + (taxtoadd - thrownaway or 0)
    XYZPresident.Stats.Tax = XYZPresident.Stats.Tax + (taxtoadd - thrownaway or 0)

    XYZPresident.TotalMoney = clamped

    return nil, nil, nil, total
end)

hook.Add("getDoorCost", "XYZPresidentDoor", function(ply)
    local taxtoadd = math.Round(GAMEMODE.Config.doorcost / 100 * XYZPresident.TaxRate)
    local total = GAMEMODE.Config.doorcost + taxtoadd

    XYZShit.Msg("Tax", Color(0, 255, 200), "You paid "..DarkRP.formatMoney(taxtoadd).." in property tax", ply)

    local clamped = math.Clamp(XYZPresident.TotalMoney + taxtoadd, 0, XYZPresident.Config.HoldCap)
    local thrownaway = 0

    if clamped ~= (XYZPresident.TotalMoney + taxtoadd) then
        thrownaway = ((XYZPresident.TotalMoney + taxtoadd) - XYZPresident.Config.HoldCap)
        XYZPresident.Stats.ThrownAwayCap = XYZPresident.Stats.ThrownAwayCap + thrownaway
    end
    XYZPresident.Stats.AddedToFunds = XYZPresident.Stats.AddedToFunds + (taxtoadd - thrownaway or 0)
    XYZPresident.Stats.Tax = XYZPresident.Stats.Tax + (taxtoadd - thrownaway or 0)

    XYZPresident.TotalMoney = clamped

    return total
end)

net.Receive("tax_office_payout", function(_, ply)
    if XYZShit.CoolDown.Check("tax_office_payout", 1, ply) then return end
   -- XYZPresident.TotalMoney

    if (not (ply:Team() == TEAM_PRESIDENT)) and (not (ply:Team() == TEAM_PCOM)) and (not (ply:Team() == TEAM_PDCOM)) then return end

    if XYZPresident.TotalMoney == 0 then
        XYZShit.Msg("Tax", Color(0, 255, 200), "There is no money to pay out", ply)
        return
    end

    local rewarded = {}
    for k, v in pairs(player.GetAll()) do
        if not XYZShit.IsGovernment(v:Team(), true) then continue end
        table.insert(rewarded, v)
    end      

    if #rewarded <= 1 then
        XYZShit.Msg("Tax", Color(0, 255, 200), "There are not enough government to pay out.", ply)
        return
    end

    local perUser = math.Round(XYZPresident.TotalMoney/#rewarded)
    for k, v in pairs(rewarded) do
        v:addMoney(perUser)
    end

    XYZShit.Msg("Tax", Color(0, 255, 200), "The President has done a payout on his funds.")
    XYZShit.Msg("Tax", Color(0, 255, 200), "You have been given "..DarkRP.formatMoney(perUser), rewarded)

    XYZPresident.Stats.PaidOut = XYZPresident.Stats.PaidOut + XYZPresident.TotalMoney

    Quest.Core.ProgressQuest(ply, "rigged_elections", 6)

    XYZPresident.TotalMoney = 0
end)