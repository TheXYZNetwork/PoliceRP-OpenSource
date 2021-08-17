XYZChristmasCredits.Config.Items = {
	{
		name = "Snowball",
		action = function(ply, npc)
			ply:Give("snowball_thrower_nodamage")
		end,
		price = 250,
		model = "models/weapons/w_snowball.mdl"
	},
	{
		name = "Candy Cane",
		action = function(ply, npc)
			local ent = ents.Create("xyz_candy_cane")
			ent:SetPos(npc:GetPos() + (npc:GetForward()*5) + (npc:GetUp()*5))
			ent:Spawn()
		
			-- Adds the item to their inv
			Inventory.Core.PickupItem(ply, ent)
		end,
		price = 500,
		model = "models/cloudstrifexiii/candycane/candycane.mdl"
	},
	{
		name = "Christmas Badge",
		action = function(ply, npc)
			ply:GiveBadge("christmas2020")
		end,
		canBuy = function(ply)
			return not ply:HasBadge("christmas2020")
		end,
		price = 2000
	},
	{
		name = "1927 Ford Model T",
		action = function(ply, npc)
			XYZcarDealer.Database.AddCar(ply, "modelt_sgm", {})
		end,
		canBuy = function(ply)
			if XYZcarDealer.Core.UsersCars[ply:SteamID64()]["modelt_sgm"] then
				return false
			end
			return true
		end,
		price = 5000,
		model = "models/sentry/modelt.mdl"
	}
}