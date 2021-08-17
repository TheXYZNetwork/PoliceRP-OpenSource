AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/anthon/safebox.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self.storing = 0
end

function ENT:StartTouch(ent)
	if not IsValid(ent) then return end
	if not (ent:GetClass() == "pvault_moneybag") then return end
	
	self.storing = self.storing + ent:GetValue()
	ent:Remove()
end

function ENT:Use(ply)
	if ply:Team() == G4S.Config.Job then 
		if self.storing < 1 then 
			XYZShit.Msg("Gruppe 6", G4S.Config.Color, "This deposit point doesn't have any money for you to take.", ply)
		else
			local amount = math.Round(self.storing*G4S.Config.MoneyCutOnDeposit)
			ply:addMoney(amount)
			XYZShit.Msg("Gruppe 6", G4S.Config.Color, "Of the "..DarkRP.formatMoney(self.storing).." stored, you received "..DarkRP.formatMoney(amount), ply)
			self.storing = 0

			Quest.Core.ProgressQuest(ply, "money_guard", 5)
		end
	end
end