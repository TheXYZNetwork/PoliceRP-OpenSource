Quest.Config.Storylines["joyrider"] ={
	name = "Joyrider",
	id = "joyrider",
	desc = "Take your love of cars to the next level",
	quests = {
		[1] = {
			name = "Get a Driver's License",
			desc = "Take the Driver's License test with the DMV",
			func = function(ply, data)
				return true
			end,
			check = function(ply)
				return ply:HasWeapon("weapon_drivers_license")
			end,
			reward = function(ply)
				CarDealer.Core.Give(ply, "f100tdm")
				XYZShit.Msg("Quests", Quest.Config.Color, "You have been given a vehicle as a reward!", ply)
			end
		},
		[2] = {
			name = "Tune a vehicle",
			desc = "Enter your Garage through the Car Dealer and Tune a car",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Enter a race",
			desc = "Start/Enter a race. You can start a race with /race",
			func = function(ply, data)
				return true
			end
		},
		[4] = {
			name = "Win the race",
			desc = "Win the race",
			func = function(ply, data)
				return true
			end
		},
		[5] = {
			name = "Purchase a Vehicle worth $50,000+",
			desc = "Purchase from the Car Dealer a Vehicle worth $50,000 or more",
			func = function(ply, data, other)
				local cost = other or 0

				return (cost >= 50000)
			end,
			reward = function(ply)
				Quest.Core.GiveStoryline(ply, "the_great_bid_off")
				Quest.Core.GiveStoryline(ply, "pocketaces")
			end
		},
	}
}