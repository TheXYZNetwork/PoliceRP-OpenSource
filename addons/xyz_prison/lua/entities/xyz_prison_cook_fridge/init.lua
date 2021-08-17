AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT.Initialize(self)
	self:SetModel("models/uc/props_fastfood/fridge.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetStock(5)
end

function ENT:Use(activator, caller)
    if XYZShit.CoolDown.Check("PrisonSystem:Fridge", 2, activator) then return end

	if not (activator:Team() == PrisonSystem.Config.Prisoner) then
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "You must be a prisoner to use this.", activator)
		return
	end

	if (not PrisonSystem.ActiveJobs[activator:SteamID64()]) or (not (PrisonSystem.ActiveJobs[activator:SteamID64()].name == "cook")) then
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "Your current job does not allow this!", activator)
		return
	end

	if self:GetStock() <= 0 then
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "The fridge is currently empty", activator)
		return
	end

	self:SetStock(self:GetStock() - 1)

	local ent = ents.Create("xyz_prison_cook_food")
	ent:SetPos(activator:GetPos() - (activator:GetUp() * -20) - (activator:GetForward() * -40))
	ent:Spawn()

	timer.Simple(math.random(PrisonSystem.Config.Cook.RestockMin, PrisonSystem.Config.Cook.RestockMax), function()
		if not IsValid(self) then return end
		if self:GetStock() >= PrisonSystem.Config.Cook.RestockLimit then return end
		self:SetStock(self:GetStock() + 1)
	end)
end


function ENT:StartTouch(ent)
	-- Check the ent is clothes
	if not (ent:GetClass() == "xyz_prison_cook_food") then return end
	-- Check if already prepped for deleting
	if ent.prepDelete then return end

	-- Only restock if not cooked
	if not ent.isCooked then
		self:SetStock(self:GetStock() + 1)
	end

	ent.prepDelete = true
	ent:Remove()
end