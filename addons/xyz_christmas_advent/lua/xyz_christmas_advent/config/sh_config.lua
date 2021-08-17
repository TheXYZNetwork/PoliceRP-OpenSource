XYZChristmasAdvent.Config.DoorOrder = {15, 19, 21, 5, 8, 7, 2, 3, 9, 11, 1, 17, 18, 20, 24, 13, 22, 6, 25, 16, 12, 23, 4, 14, 10}

XYZChristmasAdvent.Config.Rewards = {
	{
		name = "Coal",
		action = function(ply)
			
		end,
		chance = 35
	},
	{
		name = "Explosion",
		action = function(ply)
			local vPoint = ply:GetPos()
			local effectdata = EffectData()
			effectdata:SetStart(vPoint)
			effectdata:SetOrigin(vPoint)
			effectdata:SetScale(1)
			util.Effect("Explosion", effectdata)
			ply:Kill()
		end,
		chance = 25
	},
	{
		name = "50 Christmas credits",
		action = function(ply)
			XYZChristmasCredits.Database.GiveCredits(ply, 50)
		end,
		chance = 40
	},
	{
		name = "100 Christmas credits",
		action = function(ply)
			XYZChristmasCredits.Database.GiveCredits(ply, 100)
		end,
		chance = 25
	},
	{
		name = "$15,000",
		action = function(ply)
			ply:addMoney(15000)
		end,
		chance = 40
	},
	{
		name = "$40,000",
		action = function(ply)
			ply:addMoney(40000)
		end,
		chance = 25
	},
	{
		name = "Snowball",
		action = function(ply)
			ply:Give("snowball_thrower_nodamage")
		end,
		chance = 15
	},
	{
		name = "Candy Cane",
		action = function(ply)
			local ent = ents.Create("xyz_candy_cane")
			ent:SetPos(ply:GetPos() + (ply:GetForward()*5) + (ply:GetUp()*5))
			ent:Spawn()
		
			-- Adds the item to their inv
			Inventory.Core.PickupItem(ply, ent)
		end,
		chance = 15
	},
	{
		name = "1,000 Christmas credits",
		action = function(ply)
			XYZChristmasCredits.Database.GiveCredits(ply, 1000)
		end,
		chance = 5
	},
	{
		name = "1927 Ford Model T",
		action = function(ply)
			XYZcarDealer.Database.AddCar(ply, "modelt_sgm", {})
		end,
		chance = 1,
		canGet = function(ply)
			if XYZcarDealer.Core.UsersCars[ply:SteamID64()]["modelt_sgm"] then
				return false
			end
			return true
		end
	},
}
