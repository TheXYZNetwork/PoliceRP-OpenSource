ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Car Scrapper"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network"
ENT.Spawnable = true
ENT.AdminSpawnable = true


function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "SellPrice")
end
