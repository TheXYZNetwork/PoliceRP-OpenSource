hook.Add("PlayerSay", "AuctionHouse:AdminCommand", function(ply, msg)
	if not (msg == AuctionHouse.Config.AdminCommand) then return end
	if not ply:HasPower(AuctionHouse.Config.AdminPower) then return end

	net.Start("AuctionHouse:UI:Admin")
	net.Send(ply)
end)

net.Receive("AuctionHouse:RequestListings", function(_, ply)
	if XYZShit.CoolDown.Check("AuctionHouse:RequestListings", 1, ply) then return end
	net.Start("AuctionHouse:RequestListings")
		net.WriteTable(AuctionHouse.ActiveListings)
	net.Send(ply)
end)

net.Receive("AuctionHouse:Create:Admin", function(_, ply)
	if not ply:HasPower(AuctionHouse.Config.AdminPower) then return end
	if XYZShit.CoolDown.Check("AuctionHouse:Create:Admin", 1, ply) then return end

	local name = net.ReadString()
	local model = net.ReadString()
	local quantity = net.ReadUInt(7)
	local price = net.ReadUInt(32)
	local itemType = net.ReadString()
	local class = net.ReadString()
	local time = net.ReadUInt(32)

	local data = AuctionHouse.Config.Types[itemType].baseData and AuctionHouse.Config.Types[itemType].baseData(class) or {}

	AuctionHouse.Core.CreateListing(ply, name, model, price, quantity, itemType, class, time, data, true)
end)
net.Receive("AuctionHouse:PlaceBid", function(_, ply)
	if XYZShit.CoolDown.Check("AuctionHouse:PlaceBid", 2, ply) then return end
	local npc = net.ReadEntity()
	local key = net.ReadUInt(32)
	local amount = net.ReadUInt(32)

	-- Check over then NPC
	if not (npc:GetClass() == "xyz_auction_house") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end

	local listing = AuctionHouse.ActiveListings[key]
	if not listing then return end

	if listing.currentBid + 10000 > amount then return end
	if not ply:canAfford(amount) then
		XYZShit.Msg("Auction House", AuctionHouse.Config.Color, "You can't afford to make this bid...", ply)
		return
	end

	if listing.currentBidder == ply:SteamID64() then
		XYZShit.Msg("Auction House", AuctionHouse.Config.Color, "You are already the highest bidder!", ply)
		return
	end
	if listing.lister == ply:SteamID64() then
		XYZShit.Msg("Auction House", AuctionHouse.Config.Color, "You can't bid on your own listing!", ply)
		return
	end

	AuctionHouse.Core.PlaceBid(ply, key, amount)
end)

net.Receive("AuctionHouse:Create", function(_, ply)
	if XYZShit.CoolDown.Check("AuctionHouse:Create", 1, ply) then return end

	local npc = net.ReadEntity()
	local itemType = net.ReadString()
	local class = net.ReadString()
	local price = net.ReadUInt(32)
	local quantity = net.ReadUInt(32)
	local time = net.ReadUInt(32)

	-- Check over then NPC
	if not (npc:GetClass() == "xyz_auction_house") then return end
	if npc:GetPos():Distance(ply:GetPos()) > 500 then return end

	local itemData = AuctionHouse.Config.Types[itemType]
	if not itemData then return end

    if itemData.adminOnly then return end

	local listables = itemData.getListable(ply)
	if table.IsEmpty(listables) then return end

	local item = nil
	for k, v in pairs(listables) do
		if v.class == class then
			item = v
			break
		end
	end
	if not item then return end

	if price > 1000000 then return end
	if price < 10000 then return end

	if quantity > item.quantity then return end
	if quantity < 1 then return end

	if time > 60*60*24*3 then return end
	if time < 60*60*12 then return end

	if AuctionHouse.Core.HasActiveListing(ply:SteamID64()) then
		XYZShit.Msg("Auction House", AuctionHouse.Config.Color, "You already have an active listing...", ply)
		return
	end

	AuctionHouse.Core.CreateListing(ply, item.name, item.model, price, quantity, itemType, item.class, time, item.data)
	AuctionHouse.Database.CreateNotification(ply:SteamID64(), item.name..(quantity > 1 and (" x"..quantity) or "").." has been listed to the auction house.")

	Quest.Core.ProgressQuest(ply, "the_great_bid_off", 2)

	for i=1, quantity do
		itemData.remove(ply:SteamID64(), item.class, item.data)
	end
end)
net.Receive("AuctionHouse:RequestActivity", function(_, ply)
	if XYZShit.CoolDown.Check("AuctionHouse:RequestActivity", 1, ply) then return end

	AuctionHouse.Database.GetNotifications(ply:SteamID64(), function(data)
		net.Start("AuctionHouse:RequestActivity")
			net.WriteTable(data)
		net.Send(ply)
	end)
end)
function AuctionHouse.Core.HasActiveListing(plyID)
	if not plyID then return true end

	for k, v in pairs(AuctionHouse.ActiveListings) do
		if v.server then continue end
		if v.lister == plyID then
			return true
		end
	end

	return false
end

function AuctionHouse.Core.PlaceBid(ply, key, amount)
	local listing = AuctionHouse.ActiveListings[key]
	if not listing then return end

	if listing.currentBidder then
		local lastBidder = player.GetBySteamID64(listing.currentBidder)
		if lastBidder then
			lastBidder:addMoney(listing.currentBid)
			XYZShit.Msg("Auction House", AuctionHouse.Config.Color, "Your bid for "..listing.name.." was outbid. You have been refunded "..DarkRP.formatMoney(listing.currentBid), lastBidder)
			xLogs.Log(xLogs.Core.Player(lastBidder).." has been outbid on "..xLogs.Core.Color(listing.name, Color(0, 200, 200))..", their bid price of "..xLogs.Core.Color(DarkRP.formatMoney(listing.currentBid), Color(0, 200, 0)).." has been refunded", "Auction House")
		else
			-- We store the old bid as the callback will be ran after we update the new bidder.
			local oldBid = listing.currentBid
			local oldBidder = listing.currentBidder
			DarkRP.offlinePlayerData(util.SteamIDFrom64(listing.currentBidder), function(data)
				DarkRP.storeOfflineMoney(oldBidder, data[1].wallet + oldBid)
			end)
			xLogs.Log(xLogs.Core.Color(listing.currentBidder, Color(0, 0, 200)).." has bid outbid on "..xLogs.Core.Color(listing.name, Color(0, 200, 200)).." at thier bid price of "..xLogs.Core.Color(DarkRP.formatMoney(listing.currentBid), Color(0, 200, 0)), "Auction House")
		end
		AuctionHouse.Database.CreateNotification(listing.currentBidder, "Your bid for "..listing.name.." was outbid. You have been refunded "..DarkRP.formatMoney(listing.currentBid))
	end

	listing.currentBid = amount
	listing.currentBidder = ply:SteamID64()

	ply:addMoney(-amount)
	AuctionHouse.Database.AddBid(ply, listing.id, amount)
	XYZShit.Msg("Auction House", AuctionHouse.Config.Color, "Your bid for "..listing.name.." with the amount "..DarkRP.formatMoney(listing.currentBid).." has been placed!", ply)
	AuctionHouse.Database.CreateNotification(listing.currentBidder, "Your bid for "..listing.name.." with the amount "..DarkRP.formatMoney(listing.currentBid).." has been placed!")

	xLogs.Log(xLogs.Core.Player(ply).." has bid on "..xLogs.Core.Color(listing.name, Color(0, 200, 200)).." at the price of "..xLogs.Core.Color(DarkRP.formatMoney(listing.currentBid), Color(0, 200, 0)), "Auction House")

	Quest.Core.ProgressQuest(ply, "the_great_bid_off", 1)

	local timeLeft = (listing.started + listing.duration) - os.time()
	if timeLeft <= AuctionHouse.Config.Buffer then
		timer.Adjust("AuctionHouse:ListingTimer:"..key, AuctionHouse.Config.Buffer)
		listing.duration = (os.time() - listing.started) + AuctionHouse.Config.Buffer
	end
end

function AuctionHouse.Core.CreateListing(ply, name, model, price, quantity, itemType, class, time, data, server)
	-- Validate everything
	name = name or "Unknown Name"
	modle = model or "models/props_borealis/bluebarrel001.mdl"
	price = price or 10000
	quantity = quantity or 1
	itemType = itemType or "weapon"
	class = class or "cw_ak74"
	time = time or 60*60*24
	data = data or {}
	server = server or false

	local listing = {
		-- Creator
		lister = ply:SteamID64(),
		-- Information
		name = name,
		model = model,
		quantity = quantity,
		itemType = itemType,
		class = class,
		data = data,
		server = server,
		started = os.time(),
		duration = time,
		-- Bid info
		startingBid = price,
		currentBid = price,
		currentBidder = false,
	}

	local key = table.insert(AuctionHouse.ActiveListings, listing)
	AuctionHouse.ActiveListings[key].key = key

	AuctionHouse.Database.CreateListing(ply, name, model, price, quantity, itemType, class, time, data, server, function(id)
		AuctionHouse.ActiveListings[key].id = id
		print("[Auction]", "Listing registered with database ID:", id, "Assigned key:", key)
	end)

	if time < 60*60*12 then
		print("[Auction]", "Creating timer for:", key)
		timer.Create("AuctionHouse:ListingTimer:"..key, time, 1, function()
			print("[Auction]", "Timer triggered for:", key)
			AuctionHouse.Core.CloseListing(key)
		end)
	end

	if server then
		XYZShit.Msg("Auction House", AuctionHouse.Config.Color, "A rare item has just been listed on the auction house!")
	else
		XYZShit.Msg("Auction House", AuctionHouse.Config.Color, ply:Name().." has just listed "..name.." to the auction house.")
	end

	XYZShit.Webhook.PostEmbed("auction_house", {
		author = {
		    name = server and "Server" or ply:Name(),
		    url = server and "https://thexyznetwork.xyz" or "https://thexyznetwork.xyz/lookup/"..ply:SteamID64(),
		    icon_url = server and "https://d.ibtimes.co.uk/en/full/1658510/sex-doll-without-skin.jpg" or ("https://extra.thexyznetwork.xyz/steamProfileByID?id="..ply:SteamID64())
		},
		title = "Auction Listing",
		color = "12118406",
        fields = { 
            { 
                name = "Name", 
                value = name
            }, 
            { 
                name = "Starting Price", 
                value = DarkRP.formatMoney(price), 
                inline = true, 
            }, 
            { 
                name = "Quantity", 
                value = string.Comma(quantity), 
                inline = true, 
            }, 
            { 
                name = "Length", 
                value = string.NiceTime(time), 
                inline = true, 
            } 
        }, 
	})

	xLogs.Log(xLogs.Core.Player(ply).." has created a server listing of "..xLogs.Core.Color(name, Color(0, 200, 200)).." with a starting price of "..xLogs.Core.Color(DarkRP.formatMoney(price), Color(0, 200, 0)), "Auction House")
end

function AuctionHouse.Core.CloseListing(key)
	print("[Auction]", "Attempting to close:", key)
	local listing = AuctionHouse.ActiveListings[key]
	if not listing then print("[Auction]", key, "Could not be closed because the listing was not found") return end

	local typeData = AuctionHouse.Config.Types[string.lower(listing.itemType)]
	if not typeData then print("[Auction]", key, "Could not be closed because the item type was invalid:", string.lower(listing.itemType)) return end -- No clue what to do with the listing.
	
	if not listing.currentBidder then
		-- No one bid on it lol
		AuctionHouse.Database.CloseListing(listing.id)
		AuctionHouse.ActiveListings[key] = nil
		
		XYZShit.Msg("Auction House", AuctionHouse.Config.Color, listing.name.."'s auction has ended. There were no bidders.")
		if not listing.server then
			AuctionHouse.Database.CreateNotification(listing.lister, listing.name.."'s auction has closed. There were no bidders.")
			
			for i=1, listing.quantity do
				typeData.assign(listing.lister, listing.class, listing.data)
			end
		end

		xLogs.Log(xLogs.Core.Color(listing.lister or "_SERVER_", Color(0, 200, 200)).."'s listing of "..xLogs.Core.Color(listing.name, Color(0, 200, 200)).." has expired with no bidders", "Auction House")

		return
	end

	xLogs.Log(xLogs.Core.Color(listing.currentBidder, Color(0, 200, 200)).." has won the listing of "..xLogs.Core.Color(listing.name, Color(0, 200, 200)).." for the price of "..xLogs.Core.Color(DarkRP.formatMoney(listing.currentBid), Color(0, 200, 0)), "Auction House")

	for i=1, listing.quantity do
		typeData.assign(listing.currentBidder, listing.class, listing.data)
	end

	XYZShit.Msg("Auction House", AuctionHouse.Config.Color, listing.name.."'s auction has ended. It sold for "..DarkRP.formatMoney(listing.currentBid))
	local ply = player.GetBySteamID64(listing.currentBidder)
	if IsValid(ply) then
		XYZShit.Msg("Auction House", AuctionHouse.Config.Color, "You won the auction for "..listing.name, ply)
		Quest.Core.ProgressQuest(ply, "the_great_bid_off", 3)
	end
	AuctionHouse.Database.CreateNotification(listing.currentBidder, "You won the auction for "..listing.name)
	if not listing.server then
		AuctionHouse.Database.CreateNotification(listing.lister, listing.name.."'s auction has ended. It sold for "..DarkRP.formatMoney(listing.currentBid))

		local lister = player.GetBySteamID64(listing.lister)
		local takeAway = listing.currentBid * (1-AuctionHouse.Config.ServersFee)
		if lister then
			XYZShit.Msg("Auction House", AuctionHouse.Config.Color, listing.name.."'s auction has ended. It sold for "..DarkRP.formatMoney(listing.currentBid), lister)

			lister:addMoney(takeAway)
			xLogs.Log(xLogs.Core.Player(lister).."'s listing of "..xLogs.Core.Color(listing.name, Color(0, 200, 200)).." has ended at the final bid of "..xLogs.Core.Color(DarkRP.formatMoney(listing.currentBid), Color(0, 200, 0)), "Auction House")
		else
			DarkRP.offlinePlayerData(util.SteamIDFrom64(listing.lister), function(data)
				DarkRP.storeOfflineMoney(listing.lister, data[1].wallet + takeAway)
			end)
			xLogs.Log(xLogs.Core.Color(listing.lister, Color(0, 200, 200)).."'s listing of "..xLogs.Core.Color(listing.name, Color(0, 200, 200)).." has ended at the final bid of "..xLogs.Core.Color(DarkRP.formatMoney(listing.currentBid), Color(0, 200, 0)), "Auction House")
		end

		XYZShit.Webhook.PostEmbed("auction_house", {
			author = {
			    name = lister and lister:Name() or listing.lister,
			    url = "https://thexyznetwork.xyz/lookup/"..listing.lister,
			    icon_url = "https://extra.thexyznetwork.xyz/steamProfileByID?id="..listing.lister
			},
			title = "Auction Listing Close",
			color = "5301186",
	        fields = { 
	            { 
	                name = "Name", 
	                value = listing.name
	            }, 
	            { 
	                name = "Ending Price", 
	                value = DarkRP.formatMoney(listing.currentBid), 
	                inline = true, 
	            },
	            { 
	                name = "Player's Take", 
	                value = DarkRP.formatMoney(takeAway), 
	                inline = true, 
	            },
	            { 
	                name = "Server's Take", 
	                value = DarkRP.formatMoney(listing.currentBid * AuctionHouse.Config.ServersFee), 
	                inline = true, 
	            }
	        }, 
		})
	else
		XYZShit.Webhook.PostEmbed("auction_house", {
			author = {
			    name = "Server",
			    url = "https://thexyznetwork.xyz",
			    icon_url = "https://d.ibtimes.co.uk/en/full/1658510/sex-doll-without-skin.jpg"
			},
			title = "Auction Listing Close",
			color = "9442302",
	        fields = { 
	            { 
	                name = "Name", 
	                value = listing.name
	            }, 
	            { 
	                name = "Ending Price", 
	                value = DarkRP.formatMoney(listing.currentBid), 
	                inline = true, 
	            },
	            { 
	                name = "Server's Take", 
	                value = DarkRP.formatMoney(listing.currentBid), 
	                inline = true, 
	            }
	        }, 
		})
	end

	AuctionHouse.Database.CloseListing(listing.id)
	AuctionHouse.ActiveListings[key] = nil
end


hook.Add("InitPostEntity", "AuctionHouse:Load", function()
	if ISDEV then 
		print("[SERVER]", "Blocked loading active Auction House items as Developer mode is active!")
		return
	end

	AuctionHouse.Database.Load()
end)