AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT.Initialize(self)
	self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self.cooldown = 0

	self:SetIsBroken(true)
end

function ENT:Use(activator, caller)
end

function ENT:ProgressRepair(ply)
	self:SetProgress(self:GetProgress() + math.random(PrisonSystem.Config.Maintenance.MinProgress, PrisonSystem.Config.Maintenance.MaxProgress))

	if self:GetProgress() < 100 then return end

	XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "You received a payout of "..DarkRP.formatMoney(PrisonSystem.Config.Maintenance.Pay).." from repairing something!", ply)

	ply:addMoney(PrisonSystem.Config.Maintenance.Pay)

	self:SetIsBroken(false)
	self:SetProgress(0)

	timer.Create("PrisonSystem:Maintenance:"..self:EntIndex(), math.random(PrisonSystem.Config.Maintenance.MinRegen, PrisonSystem.Config.Maintenance.MaxRegen), 1, function()
		if not IsValid(self) then return end

		self:SetIsBroken(true)
	end)
end
