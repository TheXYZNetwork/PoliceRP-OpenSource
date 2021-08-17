AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/mossman.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	
	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)
end

function ENT:OnTakeDamage()        
	return 0    
end

function ENT:Use(activator, caller)
	if not activator:IsPlayer() then return end
	if activator:GetPos():Distance( self:GetPos() ) > 95 then return end
	if not xUndercover.Config.AllowedJobs[activator:Team()] then XYZShit.Msg("Undercover System", Color(105, 110, 117), "You can't use this NPC.", activator) return end

	net.Start("undercover_ui")
	net.Send(activator)
end