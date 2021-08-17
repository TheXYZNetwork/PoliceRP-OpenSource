AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT.Initialize(self)
	self:SetModel("models/props_junk/PlasticCrate01a.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
end

function ENT:Use(activator, caller)
	if XYZShit.CoolDown.Check("PrisonSystem:CookStorage", 2, activator) then return end

	if not (activator:Team() == PrisonSystem.Config.Prisoner) then
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "You must be a prisoner to use this.", activator)
		return
	end

	if (not PrisonSystem.ActiveJobs[activator:SteamID64()]) or (not (PrisonSystem.ActiveJobs[activator:SteamID64()].name == "cook")) then
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "Your current job does not allow this!", activator)
		return
	end

	if self:GetHoldingFood() <= 0 then
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "This storage container is empty..", activator)
		return
	end

	local payout = self:GetHoldingFood()*PrisonSystem.Config.Cook.FoodPayout

	activator:addMoney(payout)
	XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "You received a payout of "..DarkRP.formatMoney(payout).." from the food storage!", activator)

	self:SetHoldingFood(0)
end


function ENT:StartTouch(ent)
	-- Check the ent is clothes
	if not (ent:GetClass() == "xyz_prison_cook_food") then return end
	-- Check if cooked
	if not ent.isCooked then return end
	-- Check if already prepped for deleting
	if ent.prepDelete then return end

	ent.prepDelete = true

	ent:Remove()
	self:SetHoldingFood(self:GetHoldingFood() + 1)
end