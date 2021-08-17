ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Racing Platform"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:Initialize()
	table.insert(XYZRacing.Platforms, self)
end

function ENT:OnRemove()
	table.RemoveByValue(XYZRacing.Platforms, self)
end