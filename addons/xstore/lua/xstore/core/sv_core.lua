hook.Add("xStoreDatabaseConnected", "xStoreLoadListings", function()
	print("Loading xStore listings")
	if ISDEV then 
		print("[SERVER]", "Blocked loading xStore Credit Market Listings as Developer mode is active!")
		return
	end
	
	xStore.Database.GetActiveListings(function(data)
		for k, v in pairs(data) do
			if (os.time() - (60*60*48)) > tonumber(v.created) then
				print("Expired listing found")
				xStore.Database.RemoveListing(v.userid, v.created)
				xStore.Database.GiveIDCredits(v.userid, v.credits)

				xStore.Database.GetUsersCredits(v.userid, function(credits)
					xStore.Database.LogCreditChange(v.userid, "Market Listing Expired", v.credits, 0, credits+v.credits)
				end)

				xLogs.Log(xLogs.Core.Color(v.lister, Color(100, 100, 100)).."'s listing has expired. Their listing was "..xLogs.Core.Color(string.Comma(v.credits), Color(0, 0, 200)).." credits for "..xLogs.Core.Color(DarkRP.formatMoney(v.cost), Color(0, 200, 0)), "Listings")
				continue
			end
			
			table.insert(xStore.Listings, {lister = v.userid, credits = v.credits, cost = v.cost, created = v.created})
		end
	end)


end)
hook.Add("xStoreDatabaseConnected", "xStoreLoadCustomJobs", function()
	print("Loading xStore custom classes")
	xStore.Database.GetAllCustomClasses(function(data)
		for k, v in pairs(data) do
			xStore.CustomClasses[v.id] = {owner = v.userid, access = {}, name = v.name, model = v.model, slots = v.slots, weps = util.JSONToTable(v.weapons)}
			xStore.Database.GetCustomClassAccess(v.id, function(access)
				for k, v in pairs(access) do
					xStore.CustomClasses[v.id].access[v.userid] = true
				end
			end)
		end
	end)
end)

hook.Add("PlayerInitialSpawn", "xStoreLoadUser", function(ply)
	xStore.Users[ply:SteamID64()] = {}
	xStore.Users[ply:SteamID64()].credits = 0
	xStore.Users[ply:SteamID64()].items = {}
	xStore.Users[ply:SteamID64()].activeCC = nil

	xStore.Database.GetUsersCredits(ply:SteamID64(), function(credits)
		if not IsValid(ply) then return end
		
		xStore.Users[ply:SteamID64()].credits = credits
	end)
	xStore.Database.GetUserItem(ply:SteamID64(), function(data)
		if not IsValid(ply) then return end
		if not data[1] then return end

		xStore.Users[ply:SteamID64()].items = {}
		for k, v in pairs(data) do
			table.insert(xStore.Users[ply:SteamID64()].items, {item = v.packagename, paid = v.paid, active = tobool(v.active), created = v.created})
		end

		for k, v in pairs(xStore.Users[ply:SteamID64()].items) do
			if not v.active then continue end

			local item = xStore.Config.Items[v.item]
			if not item then continue end

			if not item.everyLoadInAction then continue end

			item.everyLoadInAction(ply)
		end
	end)

	for k, v in pairs(xStore.CustomClasses) do
		if v.owner == ply:SteamID64() then
			xStore.Users[ply:SteamID64()].activeCC = k
		end
		if not xStore.Users[ply:SteamID64()].activeCC then
			if v.access[ply:SteamID64()] then
				xStore.Users[ply:SteamID64()].activeCC = k
			end
		end
	end
end)

--hook.Add("PlayerSpawn", "xStoreSpawnActions", function(ply)
--	timer.Simple(0.1, function()
--		for k, v in pairs(xStore.Users[ply:SteamID64()].items) do
--			if not v.active then continue end
--
--			local item = xStore.Config.Items[v.item]
--			if not item then continue end
--
--			if not item.everyRepawnAction then continue end
--
--			item.everyRepawnAction(ply)
--		end
--	end)
--end)

net.Receive("xStoreRefreshCredits", function(_, ply)
    if XYZShit.CoolDown.Check("xStoreRefreshCredits", 30, ply) then
		XYZShit.Msg("xStore", Color(55, 55, 55), "Please wait "..math.Round(XYZShit.CoolDown.Get("xStoreRefreshCredits", ply)).." more seconds before trying to refresh your credits...", ply)
    	return
    end

	xStore.Database.GetUsersCredits(ply:SteamID64(), function(credits)
		if not IsValid(ply) then return end
		xStore.Users[ply:SteamID64()].credits = credits

		net.Start("xStoreRefreshCreditsReturn")
			net.WriteInt(credits, 32)
		net.Send(ply)
	end)
end)

net.Receive("xStorePurchaseItem", function(_, ply)
    if XYZShit.CoolDown.Check("xStorePurchaseItem", 5, ply) then
		XYZShit.Msg("xStore", Color(55, 55, 55), "Wait a moment before trying to buy another item!", ply)
    	return
    end

	local item = net.ReadString()
	item = xStore.Config.Items[item]

	if not item then return end

	local quickItems = {}
	for k, v in pairs(xStore.Users[ply:SteamID64()].items) do
		quickItems[v.item] = true
	end

    if item.canPurchase and not item.canPurchase(ply, quickItems) then return end
    if item.canSee and not item.canSee(ply, quickItems) then return end
    if item.legacy then return end
    
    local price = (isfunction(item.price) and item.price(ply)) or item.price
    if item.sale then
    	price = price*(1-item.sale)
    end

    xStore.Database.GetUsersCredits(ply:SteamID64(), function(myCredits)
    	xStore.Users[ply:SteamID64()].credits = myCredits
		if not (xStore.Users[ply:SteamID64()].credits >= price) then
			XYZShit.Msg("xStore", Color(55, 55, 55), "You cannot afford this item. Buy more credits at https://store.thexyznetwork.xyz.", ply)
			return
		end
	
		xStore.Database.GiveUserCredits(ply, -price)
	
		-- Add the item to the cache
		xStore.Database.GiveUserItem(ply:SteamID64(), item.id, price)
		table.insert(xStore.Users[ply:SteamID64()].items, {item = item.id, paid = price, active = true, created = os.time()})
	
		if item.instantAction then
			item.instantAction(ply)
		end
	
		xStore.Database.LogCreditChange(ply:SteamID64(), "Item Purchase", -price, 0)
		ply:GiveBadge("baller")

		XYZShit.Msg("xStore", Color(55, 55, 55), "You have purchased "..item.name.." for "..string.Comma(price).." credits.", ply)
		xLogs.Log(xLogs.Core.Player(ply).." has purchased "..xLogs.Core.Color(item.name, Color(0, 0, 200)).." for "..xLogs.Core.Color(DarkRP.formatMoney(price), Color(0, 200, 0)), "Purchase")
    end)
end)

net.Receive("xStoreToggleItem", function(_, ply)
	local item = net.ReadString()
	local state = net.ReadBool()
	item = xStore.Config.Items[item]

	if not item then return end
	if not item.disabable then return end

	local owns = false
	for k, v in pairs(xStore.Users[ply:SteamID64()].items) do
		if v.item == item.id then 
			if v.active == state then continue end
			owns = k
			break
		end
	end
	if not owns then return end

	xStore.Users[ply:SteamID64()].items[owns].active = state
	xStore.Database.SetItemState(ply:SteamID64(), item.id, state)

	if state then
		XYZShit.Msg("xStore", Color(55, 55, 55), "You have enabled your item named: "..item.name, ply)
	else
		XYZShit.Msg("xStore", Color(55, 55, 55), "You have disabled your item named: "..item.name, ply)
	end
end)

net.Receive("xStoreCreateListing", function(_, ply)
	if XYZShit.CoolDown.Check("xStoreCreateListing:"..ply:SteamID64(), 5, ply) then return end

	local creditAmount = net.ReadInt(32)
	local moneyAmount = net.ReadInt(32)

	if creditAmount < 10 then return end
	if creditAmount > 10000 then return end
	if moneyAmount < 1000 then return end
	if moneyAmount > 100000000 then return end

	if table.Count(xStore.Listings) >= 30 then
		XYZShit.Msg("xStore", Color(55, 55, 55), "Sorry, the market is currently full. Try again later.", ply)
		return
	end

    xStore.Database.GetUsersCredits(ply:SteamID64(), function(myCredits)
    	if not IsValid(ply) then return end

    	xStore.Users[ply:SteamID64()].credits = myCredits

		if not (xStore.Users[ply:SteamID64()].credits >= creditAmount) then
			XYZShit.Msg("xStore", Color(55, 55, 55), "You do not have enough credits to make this listing... Buy more credits at https://store.thexyznetwork.xyz.", ply)
			return
		end

		if XYZShit.CoolDown.Check("xStoreListingCooldown:"..ply:SteamID64(), 300, ply) then XYZShit.Msg("xStore", Color(55, 55, 55), "You can only create a listing every 5 minutes, please try again later", ply) return end

		xStore.Database.GiveUserCredits(ply, -creditAmount)
		xStore.Database.CreateListing(ply:SteamID64(), creditAmount, moneyAmount)
		table.insert(xStore.Listings, {lister = ply:SteamID64(), credits = creditAmount, cost = moneyAmount, created = os.time()})

		xStore.Database.LogCreditChange(ply:SteamID64(), "Market Listing Creation", -creditAmount, 0)
		xLogs.Log(xLogs.Core.Player(ply).." has created a listing of "..xLogs.Core.Color(string.Comma(creditAmount), Color(0, 0, 200)).." credits for "..xLogs.Core.Color(DarkRP.formatMoney(moneyAmount), Color(0, 200, 0)), "Listings")

		XYZShit.Msg("xStore", Color(55, 55, 55), ply:Name().." has listed "..string.Comma(creditAmount).." credits for $"..string.Comma(moneyAmount).."!")
    end)
end)

net.Receive("xStorePurchaseListing", function(_, ply)
	if XYZShit.CoolDown.Check("xStorePurchaseListing:"..ply:SteamID64(), 5, ply) then return end

	local key = net.ReadInt(32)
	local listing = xStore.Listings[key]
	if not listing then return end

	if (listing.lister == ply:SteamID64()) then return end
	if not ply:canAfford(listing.cost) then return end

	ply:addMoney(-listing.cost)

	xStore.Database.RemoveListing(listing.lister, listing.created)
	xStore.Database.GiveUserCredits(ply, listing.credits)
	xStore.Database.ArchiveListing(listing.lister, ply:SteamID64(), listing.credits, listing.cost, listing.created)
	xStore.Database.LogCreditChange(ply:SteamID64(), "Market Listing Purchase", listing.credits, 0)

	XYZShit.Msg("xStore", Color(55, 55, 55), "You have purchased "..string.Comma(listing.credits).." credits for $"..string.Comma(listing.cost).."!", ply)

	local lister = player.GetBySteamID64(listing.lister)
	local earnings = listing.cost*0.95
	if lister then
		lister:addMoney(earnings)
		XYZShit.Msg("xStore", Color(55, 55, 55), "One of your listings was purchased, $"..string.Comma(earnings).." has been added to your wallet!", lister)
		xLogs.Log(xLogs.Core.Player(ply).." has purchased "..xLogs.Core.Color(string.Comma(listing.credits), Color(0, 0, 200)).." credits for "..xLogs.Core.Color(DarkRP.formatMoney(listing.cost), Color(0, 200, 0))..". The lister was "..xLogs.Core.Player(lister), "Listings")
	else
		DarkRP.offlinePlayerData(util.SteamIDFrom64(listing.lister), function(data)
			DarkRP.storeOfflineMoney(listing.lister, data[1].wallet+earnings)
		end)
		xLogs.Log(xLogs.Core.Player(ply).." has purchased "..xLogs.Core.Color(string.Comma(listing.credits), Color(0, 0, 200)).." credits for "..xLogs.Core.Color(DarkRP.formatMoney(listing.cost), Color(0, 200, 0))..". The lister was "..xLogs.Core.Color(listing.lister, Color(100, 100, 100)), "Listings")
	end

	xStore.Listings[key] = nil
end)

net.Receive("xStoreRemoveListing", function(_, ply)
	if XYZShit.CoolDown.Check("xStoreRemoveListing:"..ply:SteamID64(), 5, ply) then return end

	local key = net.ReadInt(32)
	local listing = xStore.Listings[key]
	if not listing then return end

	if not (listing.lister == ply:SteamID64()) then return end

	xStore.Database.RemoveListing(listing.lister, listing.created)
	xStore.Database.GiveUserCredits(ply, listing.credits)
	xStore.Database.LogCreditChange(ply:SteamID64(), "Market Listing Removal", listing.credits, 0)

	XYZShit.Msg("xStore", Color(55, 55, 55), "Your listing has been removed. Your "..string.Comma(listing.credits).." credits have been refunded.", ply)
	xLogs.Log(xLogs.Core.Player(ply).." has removed their listing of "..xLogs.Core.Color(string.Comma(listing.credits), Color(0, 0, 200)).." credits for "..xLogs.Core.Color(DarkRP.formatMoney(listing.cost), Color(0, 200, 0)), "Listings")
	xStore.Listings[key] = nil
end)

net.Receive("xStoreCreateClass", function(_, ply)
	if XYZShit.CoolDown.Check("xStoreCreateClass", 5, ply) then return end

	-- Validate name 
	local className = net.ReadString()
	className = string.gsub(className, "[^%w ]", "")
	className = string.Trim(className, " ")
	className = string.sub(className, 1, 64)

	if string.len(className) <= 3 then
		XYZShit.Msg("xStore", Color(55, 55, 55), "Your custom class job name must be longer!", ply)
		return
	end

	-- Validate model
	local classModel = net.ReadString()
	local premiumModel = false
	if (not table.HasValue(xStore.Config.CC.Models, classModel)) and (not table.HasValue(xStore.Config.CC.PremiumModels, classModel)) then
		classModel = xStore.Config.CC.Models[1]
	end
	if table.HasValue(xStore.Config.CC.PremiumModels, classModel) then
		premiumModel = true
	end

	-- Validate slots
	local slotCount = net.ReadUInt(3)
	slotCount = math.Clamp(slotCount, 1, 5)

	-- Validate weapons
	local classWeps = net.ReadTable()
	for k, v in pairs(classWeps) do
		if not xStore.Config.CC.Weapons[k] then
			classWeps[k] = nil
		end
	end

	local grandTotal = xStore.Config.CC.BasePrice
	if slotCount > 1 then
		grandTotal = grandTotal + ((slotCount - 1) * xStore.Config.CC.SlotPrice)
	end
	
	local usableWeps = {}
	for k, v in pairs(classWeps) do
		grandTotal = grandTotal + xStore.Config.CC.Weapons[k]
		table.insert(usableWeps, k)
	end

	if premiumModel then 
		grandTotal = grandTotal + xStore.Config.CC.PremiumCost
	end

	print("Total cost:", grandTotal)
    xStore.Database.GetUsersCredits(ply:SteamID64(), function(myCredits)
    	if not IsValid(ply) then return end

    	xStore.Users[ply:SteamID64()].credits = myCredits

		if xStore.Users[ply:SteamID64()].credits < grandTotal then
			XYZShit.Msg("xStore", Color(55, 55, 55), "You do not have enough credits to create this custom class... Buy more credits at https://store.thexyznetwork.xyz.", ply)
			return
		end

		if XYZShit.CoolDown.Check("xStoreClassCreatedCooldown", 300, ply) then
			XYZShit.Msg("xStore", Color(55, 55, 55), "You just made a class, take a second to enjoy it before making another one!", ply)
			return
		end

		xStore.Database.GiveUserCredits(ply, -grandTotal)
		xStore.Database.LogCreditChange(ply:SteamID64(), "Custom Class Creation", -grandTotal, 0)

		xStore.Database.CreateCustomClass(ply:SteamID64(), className, classModel, slotCount, usableWeps, function(data)
			xStore.CustomClasses[data[1]["LAST_INSERT_ID()"]] = {owner = ply:SteamID64(), access = {}, name = className, model = classModel, slots = slotCount, weps = usableWeps}
			xStore.Users[ply:SteamID64()].activeCC = data[1]["LAST_INSERT_ID()"]
		end)
		XYZShit.Msg("xStore", Color(55, 55, 55), "You have purchased a custom class!", ply)
 		xLogs.Log(xLogs.Core.Player(ply).." has purchased a custom class called "..xLogs.Core.Color(className, Color(0, 0, 200)).." for "..xLogs.Core.Color(string.Comma(grandTotal), Color(0, 200, 0)).." credits", "Custom Class")
   end)
end)

net.Receive("xStoreEditClass", function(_, ply)
	if XYZShit.CoolDown.Check("xStoreEditClass", 5, ply) then return end

	local key = net.ReadUInt(10)
	if not xStore.CustomClasses[key] then return end
	if not (xStore.CustomClasses[key].owner == ply:SteamID64()) then return end

	-- Validate name 
	local className = net.ReadString()
	className = string.gsub(className, "[^%w ]", "")
	className = string.Trim(className, " ")
	className = string.sub(className, 1, 64)

	if string.len(className) <= 3 then
		XYZShit.Msg("xStore", Color(55, 55, 55), "Your custom class job name must be longer!", ply)
		return
	end

	-- Validate model
	local classModel = net.ReadString()
	local premiumModel = false
	if (not table.HasValue(xStore.Config.CC.Models, classModel)) and (not table.HasValue(xStore.Config.CC.PremiumModels, classModel)) then
		classModel = xStore.Config.CC.Models[1]
	end
	if table.HasValue(xStore.Config.CC.PremiumModels, classModel) then
		premiumModel = true
	end

	-- Validate slots
	local slotCount = net.ReadUInt(3)
	slotCount = math.Clamp(slotCount, 1, 5)

	-- Validate weapons
	local classWeps = net.ReadTable()
	for k, v in pairs(classWeps) do
		if not xStore.Config.CC.Weapons[k] then
			classWeps[k] = nil
		end
	end

	local grandTotal = 0

	grandTotal = grandTotal + ((slotCount - xStore.CustomClasses[key].slots) * xStore.Config.CC.SlotPrice)
	
	local usableWeps = {}
	for k, v in pairs(classWeps) do
		table.insert(usableWeps, k)
		if table.HasValue(xStore.CustomClasses[key].weps, k) then continue end
		grandTotal = grandTotal + xStore.Config.CC.Weapons[k]
	end

	if (not (xStore.CustomClasses[key].model == classModel)) and premiumModel then 
		grandTotal = grandTotal + xStore.Config.CC.PremiumCost
	end

	if (grandTotal > 0) or not (className == xStore.CustomClasses[key].name) or not (classModel == xStore.CustomClasses[key].model) then
		grandTotal = grandTotal + xStore.Config.CC.EditFee -- Edit fee
	end

	print("Total cost:", grandTotal)
    xStore.Database.GetUsersCredits(ply:SteamID64(), function(myCredits)
    	if not IsValid(ply) then return end

    	xStore.Users[ply:SteamID64()].credits = myCredits

		if xStore.Users[ply:SteamID64()].credits < grandTotal then
			XYZShit.Msg("xStore", Color(55, 55, 55), "You do not have enough credits to edit this custom class... Buy more credits at https://store.thexyznetwork.xyz.", ply)
			return
		end

		if XYZShit.CoolDown.Check("xStoreClassEditedCooldown", 30, ply) then
			XYZShit.Msg("xStore", Color(55, 55, 55), "You just edited a class, take a second to enjoy it before editing another one!", ply)
			return
		end

		if grandTotal > 0 then
			xStore.Database.GiveUserCredits(ply, -grandTotal)
			xStore.Database.LogCreditChange(ply:SteamID64(), "Custom Class Edit", -grandTotal, 0)
		end
		xStore.Database.EditCustomClass(key, className, classModel, slotCount, usableWeps)
		-- Update the cache
		xStore.CustomClasses[key].name = className
		xStore.CustomClasses[key].model = classModel
		xStore.CustomClasses[key].slots = slotCount
		xStore.CustomClasses[key].weps = usableWeps
		
		xStore.Users[ply:SteamID64()].activeCC = key

		XYZShit.Msg("xStore", Color(55, 55, 55), "You have edited a custom class!", ply)
 		xLogs.Log(xLogs.Core.Player(ply).." has edited a custom class called "..xLogs.Core.Color(className, Color(0, 0, 200)).." for "..xLogs.Core.Color(string.Comma(grandTotal), Color(0, 200, 0)).." credits", "Custom Class")
    end)
end)

net.Receive("xStoreGiveClassAccess", function(_, ply)
	if XYZShit.CoolDown.Check("xStoreGiveClassAccess", 5, ply) then return end

	local key = net.ReadUInt(10)
	if not xStore.CustomClasses[key] then return end
	if not (xStore.CustomClasses[key].owner == ply:SteamID64()) then return end

	local id = net.ReadString()
	local idToAdd = xStore.Core.ValidateToID64(id)
	if not idToAdd then return end
	if idToAdd == ply:SteamID64() then return end

	if xStore.CustomClasses[key].access[idToAdd] then return end
	if table.Count(xStore.CustomClasses[key].access) >= (xStore.CustomClasses[key].slots - 1) then return end

	xStore.Database.GiveClassAccess(key, idToAdd)
	xStore.CustomClasses[key].access[idToAdd] = true

	local plyOnline = player.GetBySteamID64(idToAdd)
	if plyOnline then
		XYZShit.Msg("xStore", Color(55, 55, 55), ply:Name().." has granted you access to their custom class!", plyOnline)
	end
	XYZShit.Msg("xStore", Color(55, 55, 55), "You have granted "..(plyOnline and plyOnline:Name() or idToAdd).." access to your custom class!", ply)
 	xLogs.Log(xLogs.Core.Player(ply).." has given the ID "..xLogs.Core.Color(idToAdd, Color(200, 200, 0)).." access to the custom class called "..xLogs.Core.Color(xStore.CustomClasses[key].name, Color(0, 0, 200)), "Custom Class")
end)

net.Receive("xStoreRemoveClassAccess", function(_, ply)
	if XYZShit.CoolDown.Check("xStoreRemoveClassAccess", 5, ply) then return end

	local key = net.ReadUInt(10)
	if not xStore.CustomClasses[key] then return end
	if not (xStore.CustomClasses[key].owner == ply:SteamID64()) then return end

	local id = net.ReadString()
	local idToRemove = xStore.Core.ValidateToID64(id)
	if not idToRemove then return end
	if idToRemove == ply:SteamID64() then return end

	if not xStore.CustomClasses[key].access[idToRemove] then return end

    xStore.Database.GetUsersCredits(ply:SteamID64(), function(myCredits)
    	if not IsValid(ply) then return end

    	xStore.Users[ply:SteamID64()].credits = myCredits

		if not (xStore.Users[ply:SteamID64()].credits >= xStore.Config.CC.RemoveAccessFee) then
			XYZShit.Msg("xStore", Color(55, 55, 55), "You do not have enough credits to remove their custom class... Buy more credits at https://store.thexyznetwork.xyz.", ply)
			return
		end

		xStore.Database.GiveUserCredits(ply, -xStore.Config.CC.RemoveAccessFee)
		xStore.Database.LogCreditChange(ply:SteamID64(), "Custom Class Removal Fee", -xStore.Config.CC.RemoveAccessFee, 0)

		xStore.Database.RemoveClassAccess(key, idToRemove)
		xStore.CustomClasses[key].access[idToRemove] = nil
	
		local plyOnline = player.GetBySteamID64(idToRemove)
		if plyOnline then
			XYZShit.Msg("xStore", Color(55, 55, 55), ply:Name().." has removed your access to their custom class!", plyOnline)
			if plyOnline:Team() == TEAM_CUSTOMCLASS then
				if xStore.Users[plyOnline:SteamID64()].activeCC == key then
					plyOnline:changeTeam(TEAM_CITIZEN, true, true)
					xStore.Users[plyOnline:SteamID64()].activeCC = nil
				end
			end
		end
		XYZShit.Msg("xStore", Color(55, 55, 55), "You have removed "..(plyOnline and plyOnline:Name() or idToRemove).."'s' access to your custom class!", ply)
 		xLogs.Log(xLogs.Core.Player(ply).." has removed the ID "..xLogs.Core.Color(idToRemove, Color(200, 200, 0)).."'s access to the custom class called "..xLogs.Core.Color(xStore.CustomClasses[key].name, Color(0, 0, 200)), "Custom Class")
	end)
end)

net.Receive("xStoreActiveClass", function(_, ply)
	if XYZShit.CoolDown.Check("xStoreActiveClass", 5, ply) then return end

	local key = net.ReadUInt(10)
	if not xStore.CustomClasses[key] then return end
	if not (xStore.CustomClasses[key].owner == ply:SteamID64()) and not (xStore.CustomClasses[key].access[ply:SteamID64()]) then return end

	xStore.Users[ply:SteamID64()].activeCC = key
	XYZShit.Msg("xStore", Color(55, 55, 55), "You have made "..xStore.CustomClasses[key].name.." your active custom class!", ply)
end)


hook.Add("PlayerSay", "xStoreOpenStoreMenu", function(ply, msg)
	local args = string.Split(msg, " ")
	if xStore.Config.Commands[string.lower(args[1])] then
		net.Start("xStoreOpenMenu")
			net.WriteInt(xStore.Users[ply:SteamID64()].credits, 32)
			net.WriteTable(xStore.Users[ply:SteamID64()].items)
			net.WriteTable(xStore.Listings)
			local myJobs = {}
			for k, v in pairs(xStore.CustomClasses) do
				if v.owner == ply:SteamID64() then
					myJobs[k] = v
				elseif v.access[ply:SteamID64()] then
					myJobs[k] = v
				end
			end
			net.WriteTable(myJobs)
		net.Send(ply)
	end
end)

concommand.Add("xstore_menu", function(ply)
	net.Start("xStoreOpenMenu")
		net.WriteInt(xStore.Users[ply:SteamID64()].credits, 32)
		net.WriteTable(xStore.Users[ply:SteamID64()].items)
		net.WriteTable(xStore.Listings)
		local myJobs = {}
		for k, v in pairs(xStore.CustomClasses) do
			if v.owner == ply:SteamID64() then
				myJobs[k] = v
			elseif v.access[ply:SteamID64()] then
				myJobs[k] = v
			end
		end
		net.WriteTable(myJobs)
	net.Send(ply)
end)

hook.Add("canDropWeapon", "xStoreBlockDropping", function(ply, wep)
	if wep.xStore then
		return false
	end
end)

hook.Add("PlayerLoadout", "xStorePlayerLoad", function(ply, block)
	if block then return end
	
	timer.Simple(0.1, function()
		if not IsValid(ply) then return end
		for k, v in pairs(xStore.Users[ply:SteamID64()].items) do
			if not v.active then continue end

			local item = xStore.Config.Items[v.item]
			if not item then continue end

			if not item.everyRepawnAction then continue end

			item.everyRepawnAction(ply)
		end
	end)
end)


hook.Add("playerCanChangeTeam", "xStoreCustomClassAccess", function(ply, newTeam, force)
	if force then return end
	if not (newTeam == TEAM_CUSTOMCLASS) then return end
	if ply.UCOriginalJob then return false, "You cannot switch jobs while you are undercover. Please end your undercover session first." end

	-- They do not have an active class set
	if not xStore.Users[ply:SteamID64()].activeCC then
		XYZShit.Msg("xStore", Color(55, 55, 55), "Please set an active class inside the !store menu.", ply)
		return false
	end

	local activeClass = xStore.CustomClasses[xStore.Users[ply:SteamID64()].activeCC]
	-- The class set is not a real class
	if not activeClass then
		XYZShit.Msg("xStore", Color(55, 55, 55), "There was an error loading your class. Please reset your active class inside !store.", ply)
		return false
	end

	-- The class set is not a real class
	if not (activeClass.owner == ply:SteamID64()) and not (activeClass.access[ply:SteamID64()]) then
		XYZShit.Msg("xStore", Color(55, 55, 55), "You do not have access to your active class, please change it inside !store", ply)
		return false
	end
end)

hook.Add("PlayerLoadout", "XstoreCustomClassSpawn", function(ply)
	if not (ply:Team() == TEAM_CUSTOMCLASS) then return end
	timer.Simple(0.3, function()
		local activeClass = xStore.CustomClasses[xStore.Users[ply:SteamID64()].activeCC]
		-- Set job name
		if not (ply:getDarkRPVar("job") == activeClass.name) then
			ply:setDarkRPVar("job", activeClass.name)
		end
		-- Set the model
		ply:SetModel(activeClass.model)
		-- Give them the weapons
		for k, v in pairs(activeClass.weps) do
			ply:Give(v).xStore = true
		end
	end)
end)