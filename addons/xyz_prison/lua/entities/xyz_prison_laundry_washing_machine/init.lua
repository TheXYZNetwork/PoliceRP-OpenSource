AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT.Initialize(self)
	self:SetModel("models/props_wasteland/laundry_dryer002.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
end

function ENT:Use(activator, caller)
    if XYZShit.CoolDown.Check("PrisonSystem:WashingMachine", 2, activator) then return end

	if not (activator:Team() == PrisonSystem.Config.Prisoner) then
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "You must be a prisoner to use this.", activator)
		return
	end

	if (not PrisonSystem.ActiveJobs[activator:SteamID64()]) or (not (PrisonSystem.ActiveJobs[activator:SteamID64()].name == "laundry")) then
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "Your current job does not allow this!", activator)
		return
	end

	if self:GetIsActive() then
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "This washing machine is currently running...", activator)
		return
	end

	if self:GetHoldingClothes() <= 0 then
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "This washing machine is empty...", activator)
		return
	end

	self:StartWashing(activator)
end


function ENT:StartTouch(ent)
	-- Check the ent is clothes
	if not (ent:GetClass() == "xyz_prison_laundry_clothes") then return end
	-- Check if dirty
	if not ent.isDirty then return end
	-- Check if already prepped for deleting
	if ent.prepDelete then return end
	-- Check if active
	if self:GetIsActive() then return end

	-- Check the cart space
	if self:GetHoldingClothes() >= PrisonSystem.Config.Laundry.WashingMachineLimit then return end

	self:SetHoldingClothes(self:GetHoldingClothes() + 1)

	ent.prepDelete = true
	ent:Remove()
end

function ENT:StartWashing(ply)
	self:SetIsActive(true)
	timer.Create("PrisonSystem:StartWashing:"..self:EntIndex(), PrisonSystem.Config.Laundry.WashingMachineTime, 1, function()
		if not IsValid(self) then return end

		self:EndWashing(ply)
	end)
end

function ENT:EndWashing(ply)
	local payout = self:GetHoldingClothes()*PrisonSystem.Config.Laundry.WashingMachinePayout
	if IsValid(ply) then
		ply:addMoney(payout)
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "You received a payout of "..DarkRP.formatMoney(payout).." from a washing machine!", ply)
	end

	self:SetHoldingClothes(0)
	self:SetIsActive(false)
end