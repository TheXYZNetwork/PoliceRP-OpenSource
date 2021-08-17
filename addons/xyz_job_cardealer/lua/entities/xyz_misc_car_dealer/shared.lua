ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Utility Cars"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true

ENT.CarSpawner = true
ENT.Config = {}
ENT.Config.Vehicles = {
	-- Taxi
	{
		class = "crownvic_taxitdm",
		canAccess = function(ply)
			return ply:Team() == TEAM_TAXI
		end,
		postSpawn = function(car)
		end
	},
	-- Bus
	{
		class = "bustdm",
		canAccess = function(ply)
			return ply:Team() == TEAM_BUS
		end,
		postSpawn = function(car, ply)
			if CLIENT then return end
			car.isBus = true
			car.busDriver = ply
			car.busPrice = 500
			car.passengers = {}
			ply.busEnt = car
			XYZShit.Msg("Bus", Color(200, 0, 200), "You have spawned your bus. Type `/busprice <amount>` in order to change your ride fare.", ply)
		end
	}
}