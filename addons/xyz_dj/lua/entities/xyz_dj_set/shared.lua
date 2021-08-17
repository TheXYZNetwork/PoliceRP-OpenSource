ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "DJ Set"
ENT.Author = "Smith Bob"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
end