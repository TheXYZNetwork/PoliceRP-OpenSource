-- CREATE TABLE `policerp_1`.`auction_active_listings` ( `id` INT(255) NOT NULL AUTO_INCREMENT , `name` VARCHAR(255) NOT NULL , `model` VARCHAR(510) NOT NULL , `price` INT(255) NOT NULL , `quantity` INT(255) NOT NULL , `type` VARCHAR(255) NOT NULL , `class` VARCHAR(255) NOT NULL , `length` INT(255) NOT NULL , `data` TEXT NOT NULL , `server` INT(2) NULL , `current_bid` INT(255) NULL , `created` INT(255) NOT NULL , PRIMARY KEY (`id`));
-- CREATE TABLE `policerp_1`.`auction_bids` ( `id` INT(255) NOT NULL AUTO_INCREMENT , `listing` INT(255) NOT NULL , `userid` VARCHAR(255) NOT NULL , `amount` INT(255) NOT NULL , `created` INT(255) NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;
-- ALTER TABLE auction_active_listings ADD FOREIGN KEY (current_bid) REFERENCES auction_bids(id);
-- ALTER TABLE auction_bids ADD FOREIGN KEY (listing) REFERENCES auction_active_listings(id);
-- ALTER TABLE `auction_active_listings` ADD `userid` VARCHAR(255) NOT NULL AFTER `id`;
-- ALTER TABLE `auction_active_listings` ADD `ended` INT(1) AFTER `current_bid`;
-- CREATE TABLE `policerp_1`.`auction_notifications` ( `id` INT(255) NOT NULL AUTO_INCREMENT , `userid` VARCHAR(255) NOT NULL , `message` TEXT NOT NULL , `created` INT(255) NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;


function AuctionHouse.Database.Load()
	-- Enjoy changing this one future Owain, you fucking loser.
	XYZShit.DataBase.Query("SELECT auction_active_listings.id as listing_id, auction_active_listings.userid as lister, auction_active_listings.name, auction_active_listings.model, auction_active_listings.price, auction_active_listings.quantity, auction_active_listings.type, auction_active_listings.class, auction_active_listings.length, auction_active_listings.data, auction_active_listings.server, auction_active_listings.ended, auction_active_listings.created, auction_bids.userid as bidder, auction_bids.amount as bid_amount FROM `auction_active_listings` LEFT JOIN `auction_bids` ON auction_active_listings.current_bid = auction_bids.id WHERE ended IS NULL", function(data)
		for k, v in pairs(data) do
			local listing = {
				-- Creator
				lister = v.lister,
				-- Information
				name = v.name,
				model = v.model,
				quantity = v.quantity,
				itemType = v.type,
				class = v.class,
				data = util.JSONToTable(v.data),
				server = tobool(v.server),
				started = v.created,
				duration = v.length,
				id = v.listing_id,
				-- Bid info
				startingBid = v.price,
				currentBid = v.bid_amount or v.price,
				currentBidder = v.bidder or false,
			}
			
			local key = table.insert(AuctionHouse.ActiveListings, listing)
			AuctionHouse.ActiveListings[key].key = key
			print("[Auction]", "Listing registered with database ID:", v.listing_id, "Assigned key:", key)


			local timeLeft = (v.created + v.length) - os.time()
			if timeLeft < 60*60*12 then -- Less than 12 hours left on the auction, so it should close this restart
				timer.Create("AuctionHouse:ListingTimer:"..key, timeLeft, 1, function()
					print("[Auction]", "Attempting to close:", key)
					AuctionHouse.Core.CloseListing(key)
				end)
			end
		end
	end)
end

function AuctionHouse.Database.CloseListing(id)
	local query = string.format([[UPDATE `auction_active_listings` SET `ended`=1 WHERE `id`=%i;]],
		id
	)

	XYZShit.DataBase.Query(query)
end


function AuctionHouse.Database.CreateListing(ply, name, model, price, quantity, itemType, class, time, data, server, callback)
	local query = string.format([[INSERT INTO `auction_active_listings` (`userid`, `name`, `model`, `price`, `quantity`, `type`, `class`, `length`, `data`, `server`, `created`) VALUES ('%s', '%s', '%s', %i, %i, '%s', '%s', %i, '%s', %i, %i);]],
		ply:SteamID64(),
		XYZShit.DataBase.Escape(name),
		XYZShit.DataBase.Escape(model),
		price,
		quantity,
		XYZShit.DataBase.Escape(itemType),
		XYZShit.DataBase.Escape(class),
		time,
		XYZShit.DataBase.Escape(util.TableToJSON(data)),
		server and 1 or 0,
		os.time()
	)

	XYZShit.DataBase.Query(query, function()
		XYZShit.DataBase.Query("SELECT id FROM `auction_active_listings` ORDER BY id DESC LIMIT 1", function(data)
			callback(data[1]["id"])
		end)
	end)
end

function AuctionHouse.Database.CreateNotification(id, msg)
	local query = string.format([[INSERT INTO `auction_notifications` (`userid`, `message`, `created`) VALUES ('%s', '%s', %i);]],
		XYZShit.DataBase.Escape(tostring(id)),
		XYZShit.DataBase.Escape(msg),
		os.time()
	)
	XYZShit.DataBase.Query(query)
end

function AuctionHouse.Database.GetNotifications(id, callback)
	local query = string.format([[SELECT message, created FROM `auction_notifications` WHERE `userid`='%s';]],
		XYZShit.DataBase.Escape(tostring(id))
	)
	XYZShit.DataBase.Query(query, callback)
end

function AuctionHouse.Database.AddBid(ply, listing, amount)
	local query = string.format([[INSERT INTO `auction_bids` (`listing`, `userid`, `amount`, `created`) VALUES (%i, '%s', %i, %i);]],
		listing,
		ply:SteamID64(),
		amount,
		os.time()
	)

	XYZShit.DataBase.Query(query, function()
		XYZShit.DataBase.Query("SELECT id FROM `auction_bids` ORDER BY id DESC LIMIT 1", function(data)
			local id = data[1]["id"]
			local query = string.format([[UPDATE `auction_active_listings` SET `current_bid`=%i WHERE `id`=%i;]],
				id,
				listing
			)
			XYZShit.DataBase.Query(query)
		end)
	end)
end