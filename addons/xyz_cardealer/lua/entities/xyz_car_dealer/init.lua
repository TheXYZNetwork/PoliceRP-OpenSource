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

	XYZ_GLOBAL_CARDEALER = self
end

function ENT:OnTakeDamage()        
	return 0    
end

function ENT:AcceptInput(name, activator, caller)
    if XYZShit.CoolDown.Check("CarDealer:NPC", 1, ply) then return end

	if activator:IsPlayer() == false then return end

	local curVehicle = activator.currentVehicle
	if IsValid(curVehicle) and (curVehicle:GetPos():Distance(self:GetPos()) <= CarDealer.Config.ReturnDistance) then
		net.Start("CarDealer:UI:Return")
		net.Send(activator)
		
		return
	end

	-- Fuck CW
	activator:SetActiveWeapon(activator:GetWeapon("keys"))

	net.Start("CarDealer:UI")
		net.WriteEntity(self)
	net.Send(activator)
end
