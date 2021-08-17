function RobbableNPC.Core.Load()
	for k, v in pairs(RobbableNPC.Config.Stores) do
		print("Attempting to register", k)

		local ENT = {}
		ENT.Base = "_xyz_raid_base"
		ENT.Type = "ai"
		ENT.ClassName = "xyz_raid_"..k
		ENT.Category = "Robbable Stores"
		ENT.Spawnable = true

		ENT.PrintName = v.name

		ENT.StoreName = "Store"
		ENT.StoreColor = RobbableNPC.Config.Color
		ENT.StoreNameDisplay = v.name
		ENT.NeededCops = v.neededPolice
		ENT.NeededPlayers = v.neededPlayers
		ENT.RobTime = v.robTime
		ENT.CooldownTime = v.cooldownTime
		ENT.MinEarning = v.minEarn
		ENT.MaxEarning = v.maxEarn

		ENT.AllowedBases = RobbableNPC.Config.AllowedBases

		ENT.Model = v.model


		ENT.config = v
		
		scripted_ents.Register(ENT, "xyz_raid_"..k)
	end
end
