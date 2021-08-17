ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Delivery Platform"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:Initialize()
	table.insert(XYZTrucker.Platforms, self)
end

function ENT:OnRemove()
	table.RemoveByValue(XYZTrucker.Platforms, self)
end