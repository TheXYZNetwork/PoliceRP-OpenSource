ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Undercover NPC"
ENT.Author = "MilkGames"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.AutomaticFrameAdvance = true
 
function ENT:SetAutomaticFrameAdvance( UsingAnim )
	self.AutomaticFrameAdvance = UsingAnim
end