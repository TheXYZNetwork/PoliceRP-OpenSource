ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Black Market"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true

-- How many random items to pool
ENT.TotalRandomItems = 4
ENT.Items = {
	-- if the field "func" exists, ent is used as a display name
	{ent = "New Identity", price = 100000, max = 5, func = function(ply)
		XYZShit.Msg("Black Market", Color(200, 200, 200), "Enjoy your new identity!", ply)
		if PrisonSystem.IsArrested(ply) then
			PrisonSystem.UnArrest(ply)
		else
			ply:unWarrant()
			ply:unWanted()
		end
	end},
	{
		ent = "Zip ties",
		price = 15000,
		max = 15,
		random = false,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("weapon_zipties")
		end
	},
	{
		ent = "Fake Drivers License",
		price = 15000,
		max = 5,
		random = false,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("weapon_drivers_license")
		end
	},

	-- Weapons
	{
		ent = "Ak-74",
		price = 68000,
		max = 10,
		random = true, -- To be included in the random pool
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("cw_ak74")
		end
	},
	{
		ent = "AR-15",
		price = 74000,
		max = 10,
		random = true,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("cw_ar15")
		end
	},
	{
		ent = "SV-98",
		price = 82000,
		max = 5,
		random = true,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("cw_sv98")
		end
	},
	{
		ent = "Radio Jammer",
		price = 15000,
		max = 1,
		random = true,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("bens_radio_jammer")
		end
	},
	{
		ent = "Orsis T-5000",
		price = 66000,
		max = 5,
		random = true,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("khr_t5000")
		end
	},
	{
		ent = "SVT-40",
		price = 59000,
		max = 5,
		random = true,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("khr_svt40")
		end
	},
	{
		ent = "KRISS Vector",
		price = 54000,
		max = 10,
		random = true,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("khr_vector")
		end
	},
	{
		ent = "TOZ-194",
		price = 47000,
		max = 10,
		random = true,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("khr_toz194")
		end
	},
	{
		ent = "MP-153",
		price = 39000,
		max = 5,
		random = true,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("khr_mp153")
		end
	},
	{
		ent = "SR-2 Veresk",
		price = 45000,
		max = 5,
		random = true,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("khr_veresk")
		end
	},
	{
		ent = "FMG-9",
		price = 42000,
		max = 10,
		random = true,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("khr_fmg9")
		end
	},
	{
		ent = "VSS Vintorez",
		price = 64000,
		max = 5,
		random = true,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("cw_vss")
		end
	},
	{
		ent = "Micro Desert Eagle",
		price = 41000,
		max = 5,
		random = true,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("khr_microdeagle")
		end
	},
	{
		ent = "GSh-18",
		price = 41000,
		max = 5,
		random = true,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("khr_gsh18")
		end
	},
	{
		ent = "M-60",
		price = 5000000,
		max = 1,
		random = true,
		func = function(ply)
			XYZShit.Msg("Black Market", Color(200, 200, 200), "Don't get caught with this!", ply)
			ply:Give("khr_m60")
		end
	},
}

