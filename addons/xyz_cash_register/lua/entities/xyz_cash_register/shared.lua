ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Cash Register"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = true
ENT.AdminSpawnable = true

ENT.Model = "models/props_interiors/cashregister01.mdl"

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
end