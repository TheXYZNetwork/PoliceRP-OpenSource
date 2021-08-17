AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT.Initialize(self)
	self:SetModel("models/props_interiors/corkboardverticle01.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
end

function ENT:Use(activator, caller)
    if XYZShit.CoolDown.Check("PrisonSystem:Board", 2, activator) then return end

	if not (activator:Team() == PrisonSystem.Config.Prisoner) then
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "You must be a prisoner to use the job board.", activator)
		return
	end

	net.Start("PrisonSystem:UI")
		net.WriteEntity(self)
	net.Send(activator)
end