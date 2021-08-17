XYZDoctor.Config.Color = Color(200, 200, 200)

function XYZDoctor.Config.Discount(ply, price, isExamination)
	-- Only give government free healthcare, not free items.
	if isExamination and (XYZShit.IsGovernment(ply:Team(), true) or ply.UCOriginalJob) then
		return 0
	end

	if ply:IsVIP() then
		return math.Round(price * 0.75)
	end

	return price
end

XYZDoctor.Config.Examinations = {
	{
		name = "Health (100%)",
		desc = "Take a poke and a prod",
		price = 2500,
		action = function(ply)
			if ply:Health() >= 100 then return end

			ply:SetHealth(100)
			return true
		end
	},
	{
		name = "Armour (100%)",
		desc = "A quick lookover, just to be safe...",
		price = 5000,
		action = function(ply)
			if ply:Armor() >= 100 then return end

			ply:SetArmor(100)
			return true
		end
	},
	{
		name = "Health & Armour (100%)",
		desc = "Get a full checkup!",
		price = 6000,
		action = function(ply)
			if ply:Health() >= 100 then return end
			if ply:Armor() >= 100 then return end

			ply:SetHealth(100)
			ply:SetArmor(100)
			return true
		end
	},
}
XYZDoctor.Config.Entities = {
	{
		name = "Medkit",
		desc = "A box of needles and bandages",
		model = "models/freeman/owain_medkit.mdl",
		max = 5,
		bulkBuy = true,
		price = 10000,
		entity = "xyz_medkit" 
	},
	{
		name = "Armour Box",
		desc = "A stash of adrenaline needles",
		model = "models/freeman/owain_hardigg_armour.mdl",
		max = 3,
		bulkBuy = true,
		price = 15000,
		entity = "xyz_armour_box" 
	},
}