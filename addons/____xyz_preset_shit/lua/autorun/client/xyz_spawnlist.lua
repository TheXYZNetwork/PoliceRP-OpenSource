local freemanModels = {
	"models/freeman/owain_podium.mdl",
	"models/freeman/vault/owain_hockeymask.mdl",
	"models/freeman/vault/owain_hockeymask_prop.mdl",
	"models/freeman/owain_hardigg_armour.mdl",
	"models/freeman/owain_medkit.mdl",
	"models/freeman/owain_body_bag.mdl",
	"models/freeman/owain_barricade.mdl",
	"models/freeman/wheel_clamp.mdl"
}
local oldBill = {
	"models/oldbill/pumpkin2017.mdl",
	"models/oldbill/easteregg.mdl"
}
local cipro = {
	"models/cipro/owain_owjo/heart.mdl"
}
local other = {
	"models/gmod_tower/suite/imac.mdl"
}
hook.Add("PopulatePropMenu", "XYZCustomModels", function()
	local contents = {}
	-- Free-man
	table.insert(contents, {
		type = "header",
		text = "Free-man"
	})
	for k, v in pairs(freemanModels) do
		table.insert(contents, {
			type = "model",
			model = v
		})
	end

	-- Old Bill
	table.insert(contents, {
		type = "header",
		text = "Old Bill"
	})
	for k, v in pairs(oldBill) do
		table.insert(contents, {
			type = "model",
			model = v
		})
	end

	-- Cipro
	table.insert(contents, {
		type = "header",
		text = "Cipro"
	})
	for k, v in pairs(cipro) do
		table.insert(contents, {
			type = "model",
			model = v
		})
	end

	-- Other
	table.insert(contents, {
		type = "header",
		text = "Other"
	})
	for k, v in pairs(other) do
		table.insert(contents, {
			type = "model",
			model = v
		})
	end

	spawnmenu.AddPropCategory("XYZModels", "XYZ Models", contents, "icon16/box.png", 1000, 0)
end)