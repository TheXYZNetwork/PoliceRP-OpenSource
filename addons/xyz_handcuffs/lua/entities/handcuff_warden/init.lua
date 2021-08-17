AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/breen.mdl")
	self:SetHullType(HULL_HUMAN);
	self:SetHullSizeNormal();
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()

	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)
end

function ENT:OnTakeDamage()        
	return 0    
end

function ENT:AcceptInput(name, activator, caller)
	if activator:IsPlayer() == false then return end

	if XYZShit.CoolDown.Check("hc_front_desk", 1, activator) then return end

	if activator:isCP() or activator.UCOriginalJob then
		if not IsValid(activator.XYZdragging) then XYZShit.Msg("Prison", Color(200, 100, 40), "Please bring someone to arrest before attempting to talk to me...", activator) return end
		net.Start("hc_front_desk")
			net.WriteEntity(self)
			net.WriteEntity(activator.XYZdragging)
		net.Send(activator)
	else return end
end
