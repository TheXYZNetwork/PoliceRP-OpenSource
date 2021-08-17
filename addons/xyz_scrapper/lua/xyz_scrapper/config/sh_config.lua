-- The chat and UI colors
Scrapper.Config.Color = Color(60, 120, 200)

-- Base sell price minimum
Scrapper.Config.PriceMin = 5000
Scrapper.Config.PriceMax = 15000

-- Use this to give some ranks increased % buffs
function Scrapper.Config.PriceMultiplier(ply, price)
	return price * 1.1
end

--The sell cooldown
function Scrapper.Config.SellCooldown(ply)
	return 10
end

-- How long the vehicle owner must wait before they can respawn their vehicle (seconds)
Scrapper.Config.SpawnCooldown = 60*15