ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Cash Register Item"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network"
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "DisplayName")
	self:NetworkVar("Int", 0, "Price")
end