Quest.Config.Storylines["minecraft"] ={
	name = "Minecraft",
	id = "minecraft",
	desc = "Steve isn't the only guy who knows his way around a Pickaxe",
	quests = {
		[1] = {
			name = "Purchase a Pickaxe/Drill",
			desc = "Purchase a Pickaxe/Drill from the miner",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Mine 10 Ore chunks",
			desc = function(data) return string.format("Mine 10 Ore chunks. You have currently mined %i/10", tonumber(data) or 0) end,
			func = function(ply, data)
				local mined = data or 0
				mined = mined + 1

				return (mined == 10), mined, true
			end
		},
		[3] = {
			name = "Sell $25,000 worth of Ores",
			desc = function(data) return string.format("Sell $25,000 worth of Ores. You have currently sold %s/$25,000", DarkRP.formatMoney(tonumber(data) or 0)) end,
			func = function(ply, data, other)
				local sold = tonumber(data) or 0
				sold = sold + (other or 0)

				return (sold >= 25000), sold, true
			end,
			reward = function(ply)
				Quest.Core.GiveStoryline(ply, "stable_income")
			end
		},
	}
}