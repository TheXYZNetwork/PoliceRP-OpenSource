ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "[Store] Base"
ENT.Author = "Owain Owjo"
ENT.Category = "Robbable Stores"
ENT.Spawnable = false
ENT.AdminSpawnable = true

-- Config
ENT.StoreName = "Base NPC" -- The name of the NPC
ENT.StoreColor = Color(42, 172, 53) -- The color for the chat box ect

ENT.StoreNameDisplay = "Base Store" -- The name of the NPC

ENT.NeededCops = 1 -- how many cops need to be online in order to rob the store
ENT.NeededPlayers = 3 -- How many players need to be online in order to rob the store?
ENT.RobTime = 20 -- How long it takes to rob the store (in seconds)
ENT.CooldowmTime = 60*20 -- How long the cooldown till the next store rob is (in seconds)

ENT.MinEarning = 15000 -- The min earnings of the store rob
ENT.MaxEarning = 35000 -- The max earnings of the store rob

-- All the weapon bases that are considered weapons when robbing the store
ENT.AllowedBases = {}
ENT.AllowedBases["cw_base"] = true
ENT.AllowedBases["zekeou_gun_base"] = true
ENT.AllowedBases["zekeou_scoped_base"] = true