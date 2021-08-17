ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Minimap Sign"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "DisplayName")
	self:NetworkVar("Int", 0, "DisplayImage")
	self:NetworkVar("Entity", 0, "owning_ent")
end