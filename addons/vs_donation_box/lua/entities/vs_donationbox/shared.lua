ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "The Box"
ENT.Author = "Owain Owjo"
ENT.Category = "Vitality Servers Custom Addons"
ENT.Spawnable = true
ENT.AdminSpawnable = true


function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("Int", 0, "CurMoney")
	self:NetworkVar("Bool", 0, "Open")
end