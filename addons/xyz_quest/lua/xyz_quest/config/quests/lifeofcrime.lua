Quest.Config.Storylines["life_of_crime"] ={
	name = "Life of Crime",
	id = "life_of_crime",
	desc = "Take a ride on the wild side",
	quests = {
		[1] = {
			name = "Purchase a Property",
			desc = "Purchase a Property so you can set up a base of operations",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Purchase a Money Printer",
			desc = "Purchase a Money Printer from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Lockpick and steal a vehicle",
			desc = "Lockpick a vehicle and steal it. Don't forget to advert Carjack",
			func = function(ply, data)
				return true
			end
		},
		[4] = {
			name = "Scrap the vehicle",
			desc = "Take the vehicle to the Car Scrapper and sell it",
			func = function(ply, data)
				return true
			end
		},
		[5] = {
			name = "Purchase a firearm from the Black Market Dealer",
			desc = "Find the Black Market Dealer and purchase a fire arm",
			func = function(ply, data)
				return true
			end
		},
		[6] = {
			name = "Purchase a Mask",
			desc = "Purchase a Mask from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[7] = {
			name = "Rob a store",
			desc = "Rob a Gas Station",
			func = function(ply, data)
				return true
			end
		},
		[8] = {
			name = "Sell the Money Bag",
			desc = "Find the corrupt banker and sell your Money Bag to him",
			func = function(ply, data)
				return true
			end,
			reward = function(ply)
				Quest.Core.GiveStoryline(ply, "hitman69")
				Quest.Core.GiveStoryline(ply, "jail_break")
				Quest.Core.GiveStoryline(ply, "gang_warfare")
			end
		},
	}
}

if CLIENT then return end

-- Purchase a property
hook.Add("PropertyPurchase", "Quest:Progress:life_of_crime", function(ply)
	Quest.Core.ProgressPartyQuest(ply, "life_of_crime", 1)
end)
-- Purchase a money printer/mask
hook.Add("playerBoughtCustomEntity", "Quest:Progress:life_of_crime", function(ply, entTable, ent)
	if ent:GetClass() == "tierp_printer" then
		Quest.Core.ProgressQuest(ply, "life_of_crime", 2)
	elseif ent:GetClass() == "pvault_mask" then
		Quest.Core.ProgressQuest(ply, "life_of_crime", 6)
	end
end)
-- Lockpick and steal a vehicle
hook.Add("onLockpickCompleted", "Quest:Progress:life_of_crime", function(ply, success, ent)
	if not success then return end
	if not (ent:IsVehicle()) then return end

	Quest.Core.ProgressPartyQuest(ply, "life_of_crime", 3)
end)
-- Cleaned some money
hook.Add("pVaultMoneyCleaned", "Quest:Progress:life_of_crime", function(ply)
	Quest.Core.ProgressPartyQuest(ply, "life_of_crime", 8)
end)