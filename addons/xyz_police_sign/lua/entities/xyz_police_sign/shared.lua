ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Police Sign"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.AdminSpawnable = true
ENT.Spawnable = true

-- This is a tabe of all networked variabes so Get and Set can be used on them
function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")

	self:NetworkVar("String", 0, "Head")
	self:NetworkVar("String", 1, "Body")

	--self:NetworkVar("Int", 0, "Mode")
end

--ENT.Modes = {}
--ENT.Modes[1] = {"Turn Around", imgDir = ""}