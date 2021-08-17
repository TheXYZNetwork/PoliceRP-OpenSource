ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Police Barricade"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.AdminSpawnable = true
ENT.Spawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
end