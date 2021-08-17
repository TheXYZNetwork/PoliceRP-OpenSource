-- More basic setup
ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Drug Hustler NPC"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Holding")
end
