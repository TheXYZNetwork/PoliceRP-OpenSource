ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "[Prison Job] Maintenance Node"
ENT.Author = "Owain"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "IsBroken")
	self:NetworkVar("Int", 0, "Progress")
end
