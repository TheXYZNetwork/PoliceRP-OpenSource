-- The chat and UI colors
Impound.Config.Color = Color(200, 60, 120)

-- Clamp fee
Impound.Config.ClampFee = 10000
-- How long before the vehicle is impounded (Minutes)
Impound.Config.ClampTime = 10

-- Impound fee
Impound.Config.ImpoundFee = 20000

-- Vehicles that cannot be clamped
Impound.Config.Blacklist = {}
Impound.Config.Blacklist["tow_truck"] = true
Impound.Config.Blacklist["busgtav"] = true
Impound.Config.Blacklist["bustdm"] = true
Impound.Config.Blacklist["crownvic_taxitdm"] = true