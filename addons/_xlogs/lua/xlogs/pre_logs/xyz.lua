xLogs.RegisterCategory("911", "The XYZ Network")
xLogs.RegisterCategory("Armory", "The XYZ Network")
xLogs.RegisterCategory("Auction House", "The XYZ Network")
xLogs.RegisterCategory("Baton", "The XYZ Network")
xLogs.RegisterCategory("Black Market", "The XYZ Network")
xLogs.RegisterCategory("Car Dealer", "The XYZ Network")
xLogs.RegisterCategory("Car Scrapper", "The XYZ Network")
xLogs.RegisterCategory("Car Tracker", "The XYZ Network")
xLogs.RegisterCategory("Cash Reigster", "The XYZ Network")
xLogs.RegisterCategory("DMV", "The XYZ Network")
xLogs.RegisterCategory("Doctor", "The XYZ Network")
xLogs.RegisterCategory("Drug NPC", "The XYZ Network")
xLogs.RegisterCategory("Drug Tablet", "The XYZ Network")
xLogs.RegisterCategory("EMS", "The XYZ Network")
xLogs.RegisterCategory("Front Desk", "The XYZ Network")
xLogs.RegisterCategory("Gamemaster", "The XYZ Network")
xLogs.RegisterCategory("Gun Dealer", "The XYZ Network")
xLogs.RegisterCategory("Handcuffs", "The XYZ Network")
xLogs.RegisterCategory("Hitman", "The XYZ Network")
xLogs.RegisterCategory("Impound", "The XYZ Network")
xLogs.RegisterCategory("Inventory", "The XYZ Network")
xLogs.RegisterCategory("Mining", "The XYZ Network")
xLogs.RegisterCategory("Organizations", "The XYZ Network")
xLogs.RegisterCategory("PNC", "The XYZ Network")
xLogs.RegisterCategory("Panic Button", "The XYZ Network")
xLogs.RegisterCategory("Party", "The XYZ Network")
xLogs.RegisterCategory("Prison", "The XYZ Network")
xLogs.RegisterCategory("Rewards", "The XYZ Network")
xLogs.RegisterCategory("Store Robbery", "The XYZ Network")
xLogs.RegisterCategory("Tow Truck", "The XYZ Network")
xLogs.RegisterCategory("Trash Collection", "The XYZ Network")
xLogs.RegisterCategory("Weapon Checker", "The XYZ Network")
xLogs.RegisterCategory("Weapon Skins", "The XYZ Network")


hook.Add("XYZ911", "xLogsXYZ-911", function(ply, reason)
	xLogs.Log(xLogs.Core.Player(ply).." has made a 911 report for "..xLogs.Core.Color(reason, Color(0, 200, 200)), "911")
end)

hook.Add("XYZArmoryRob", "xLogsXYZ-Armory", function(ply)
	xLogs.Log(xLogs.Core.Player(ply).." has started robbing the armory", "Armory")
end)
hook.Add("XYZArmoryRobbed", "xLogsXYZ-Armory", function(ply, money)
	xLogs.Log(xLogs.Core.Player(ply).." has robbed the armory for "..xLogs.Core.Color(DarkRP.formatMoney(money), Color(0, 200, 0)), "Armory")
end)
hook.Add("XYZArmoryRestock", "xLogsXYZ-Armory", function(ply, price)
	xLogs.Log("The armory has restocked for "..xLogs.Core.Color(DarkRP.formatMoney(price), Color(0, 200, 200)), "Armory")
end)

hook.Add("XYZBatonHit", "xLogsXYZ-Baton", function(ply, target)
	xLogs.Log(xLogs.Core.Player(ply).." has hit "..xLogs.Core.Player(target).." with a baton", "Baton")
end)

hook.Add("XYZBatonHitVehicle", "xLogsXYZ-Baton", function(ply, target, vehicle)
	xLogs.Log(xLogs.Core.Player(ply).." has hit "..xLogs.Core.Player(target).." out of "..xLogs.Core.Color(vehicle:GetVehicleClass(), Color(0, 200, 0)), "Baton")
end)

hook.Add("XYZHitmanPlace", "xLogsXYZ-Hitman", function(ply, hitee, price)
	xLogs.Log(xLogs.Core.Player(ply).." has placed a hit on "..xLogs.Core.Player(hitee).." for "..xLogs.Core.Color(DarkRP.formatMoney(price), Color(0, 200, 0)), "Hitman")
end)
hook.Add("XYZHitmanIncrease", "xLogsXYZ-Hitman", function(ply, hitee, price)
	xLogs.Log(xLogs.Core.Player(ply).." has increased the hit on "..xLogs.Core.Player(hitee).." by "..xLogs.Core.Color(DarkRP.formatMoney(price), Color(0, 200, 0)), "Hitman")
end)
hook.Add("XYZHitmanClaim", "xLogsXYZ-Hitman", function(ply, hitID)
	xLogs.Log(xLogs.Core.Player(ply).." has claimed the hit on "..xLogs.Core.Player(XYZ_HITMAN.ActiveHits[hitID].BountyPlayer), "Hitman")
end)
hook.Add("XYZHitmanUnclaim", "xLogsXYZ-Hitman", function(ply, hitID)
	xLogs.Log(xLogs.Core.Player(ply).." has unclaimed the hit on "..xLogs.Core.Player(XYZ_HITMAN.ActiveHits[hitID].BountyPlayer), "Hitman")
end)
hook.Add("XYZHitmanComplete", "xLogsXYZ-Hitman", function(hitter, hitee, price)
	xLogs.Log(xLogs.Core.Player(hitter).." has completed their hit on "..xLogs.Core.Player(hitee).." and received "..xLogs.Core.Color(DarkRP.formatMoney(price), Color(0, 200, 0)), "Hitman")
end)

hook.Add("XYZHandcuffsCuffed", "xLogsXYZ-Handcuffs", function(arrester, ply)
	xLogs.Log(xLogs.Core.Player(arrester).." has cuffed "..xLogs.Core.Player(ply), "Handcuffs")
end)
hook.Add("XYZHandcuffsUncuffed", "xLogsXYZ-Handcuffs", function(unarrester, ply)
	xLogs.Log(xLogs.Core.Player(unarrester).." has uncuffed "..xLogs.Core.Player(ply), "Handcuffs")
end)
hook.Add("XYZHandcuffsDragging", "xLogsXYZ-Handcuffs", function(dragger, draggee, state)
	if state then
		xLogs.Log(xLogs.Core.Player(dragger).." has started dragging "..xLogs.Core.Player(draggee), "Handcuffs")
	else
		xLogs.Log(xLogs.Core.Player(dragger).." has stopped dragging "..xLogs.Core.Player(draggee), "Handcuffs")
	end
end)
hook.Add("XYZHandcuffsStripped", "xLogsXYZ-Handcuffs", function(stripper, ply)
	xLogs.Log(xLogs.Core.Player(stripper).." stripped "..xLogs.Core.Player(ply).."'s weapons", "Handcuffs")
end)

hook.Add("XYZFrontDeskJail", "xLogsXYZ-FrontDesk", function(ply, prisoner, time)
	xLogs.Log(xLogs.Core.Player(ply).." has jailed "..xLogs.Core.Player(prisoner).." for "..xLogs.Core.Color(time or 1, Color(0, 0, 200)).." minute(s)", "Front Desk")
end)
hook.Add("XYZFrontDeskBail", "xLogsXYZ-FrontDesk", function(ply, prisoner, price)
	xLogs.Log(xLogs.Core.Player(ply).." has bailed "..xLogs.Core.Player(prisoner).." for "..xLogs.Core.Color(DarkRP.formatMoney(price), Color(34,139,34)), "Front Desk")
end)

hook.Add("XYZPartyJoin", "xLogsXYZ-Party", function(ply, party)
	xLogs.Log(xLogs.Core.Player(ply).." has joined the party "..xLogs.Core.Color(party, Color(34,34,139)), "Party")
end)
hook.Add("XYZPartyLeave", "xLogsXYZ-Party", function(ply, party)
	xLogs.Log(xLogs.Core.Player(ply).." has left (or was kicked from) the party "..xLogs.Core.Color(party, Color(34,34,139)), "Party")
end)
hook.Add("XYZPartyDisband", "xLogsXYZ-Party", function(party)
	xLogs.Log(xLogs.Core.Color(party, Color(34,34,139)).." was disbanded", "Party")
end)
hook.Add("XYZPartyStart", "xLogsXYZ-Party", function(ply, party)
	xLogs.Log(xLogs.Core.Player(ply).." has started the party "..xLogs.Core.Color(party, Color(34,34,139)), "Party")
end)

hook.Add("XYZEMSRevive", "xLogsXYZ-EMS", function(ply, medic)
	xLogs.Log(xLogs.Core.Player(ply).." has been revived by "..xLogs.Core.Player(medic), "EMS")
end)

hook.Add("XYZPanicButtonStart", "xLogsXYZ-PanicButton", function(ply)
	xLogs.Log(xLogs.Core.Player(ply).." has triggered their panic button", "Panic Button")
end)
hook.Add("XYZPanicButtonEnd", "xLogsXYZ-PanicButton", function(ply)
	xLogs.Log(xLogs.Core.Player(ply).."'s panic button has ended", "Panic Button")
end)

hook.Add("DMVPoint", "xLogsXYZ-DMV", function(ply, target)
	xLogs.Log(xLogs.Core.Player(ply).." gave "..xLogs.Core.Player(target).." a point on their drivers license", "DMV")
end)
hook.Add("DMVRemovePoint", "xLogsXYZ-DMV", function(ply, target)
	xLogs.Log(xLogs.Core.Player(ply).." removed a point from "..xLogs.Core.Player(target).."'s drivers license", "DMV")
end)
hook.Add("DMVRevoked", "xLogsXYZ-DMV", function(ply)
	xLogs.Log(xLogs.Core.Player(ply).."'s license was revoked", "DMV")
end)
hook.Add("DMVPassed", "xLogsXYZ-DMV", function(ply)
	xLogs.Log(xLogs.Core.Player(ply).." passed the test", "DMV")
end)
hook.Add("TicketBookDMVPoints", "xLogsXYZ-DMV", function(ply, ticketed, points)
	xLogs.Log(xLogs.Core.Player(ticketed).." received "..points.." points on their drivers license because of a ticket by "..xLogs.Core.Player(ply), "DMV")
end)