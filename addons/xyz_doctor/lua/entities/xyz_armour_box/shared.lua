ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Armour Box"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("Int", 0, "UsesLeft")
	self:NetworkVar("Bool", 0, "FirstSpawn")
end
