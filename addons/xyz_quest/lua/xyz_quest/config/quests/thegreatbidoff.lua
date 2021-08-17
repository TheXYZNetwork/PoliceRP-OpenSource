Quest.Config.Storylines["the_great_bid_off"] ={
	name = "The Great Bid Off",
	id = "the_great_bid_off",
	desc = "Do whatever it takes to win the bid",
	quests = {
		[1] = {
			name = "Bid on an item",
			desc = "Bid on an item in the Auction House",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "List an item",
			desc = "List an item on the Auction House",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Win an item",
			desc = "Win an item from the Auction House",
			func = function(ply, data)
				return true
			end
		}
	}
}