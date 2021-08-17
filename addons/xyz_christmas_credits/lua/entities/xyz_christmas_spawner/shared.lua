ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Christmas Gift Platform"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "IsActive")
end

ENT.ViewTypes = {
	{
		model = "models/freeman/owain_candycane.mdl",
		action = function(ent)
			ent:SetSkin(math.random(0, 2))
		end
	},
	{
		model = "models/freeman/owain_present_large.mdl",
		action = function(ent)
			ent:SetBodygroup(1, math.random(0, 5))
			ent:SetBodygroup(2, math.random(0, 3))
			ent:SetSkin(math.random(0, 4))
		end
	},
	{
		model = "models/freeman/owain_present_medium.mdl",
		action = function(ent)
			ent:SetBodygroup(1, math.random(0, 5))
			ent:SetBodygroup(2, math.random(0, 3))
			ent:SetSkin(math.random(0, 4))
		end
	},
	{
		model = "models/freeman/owain_present_small.mdl",
		action = function(ent)
			ent:SetBodygroup(1, math.random(0, 5))
			ent:SetBodygroup(2, math.random(0, 3))
			ent:SetSkin(math.random(0, 4))
		end
	},
}