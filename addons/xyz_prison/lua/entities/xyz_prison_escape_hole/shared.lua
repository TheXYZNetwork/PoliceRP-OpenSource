ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Escape Hole"
ENT.Author = "Owain"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Progress")
end
