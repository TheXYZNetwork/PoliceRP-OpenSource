AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/odessa.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()

	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)
	
	self.coolDown = 0
end

function ENT:OnTakeDamage()        
	return 0    
end

function ENT:AcceptInput(name, activator, caller)
	if activator:IsPlayer() == false then return end
	if not (activator:Team() == TEAM_MECHANIC) then XYZShit.Msg("Mechanic", Color(213, 195, 30), "Hey now, you need to be a mechanic to spawn a tow truck...", activator) return end

	net.Start("towtruck_menu")
		net.WriteEntity(self)
	net.Send(activator)
end
