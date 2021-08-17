AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Police.mdl")
	self:SetHullType(HULL_HUMAN);
	self:SetHullSizeNormal();
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()


	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)

	self.cooldown = 0
end

function ENT:OnTakeDamage()        
	return 0    
end

function ENT:AcceptInput(name, activator, caller)
	if activator:IsPlayer() == false then return end

	if IsValid(activator.JobCarDealerCurCar) then 
		if activator.JobCarDealerCurCar:GetPos():Distance(self:GetPos()) <= 500 then
			activator.JobCarDealerCurCar:Remove()
			XYZShit.Msg(self.PrintName, Color(40, 40, 40), "Your vehicle has been returned to us.", activator)
			return
		else
			XYZShit.Msg(self.PrintName, Color(40, 40, 40), "Your vehicle is too far away to return.", activator)
			return
		end
	end

	if self.cooldown > CurTime() then
		XYZShit.Msg(self.PrintName, Color(40, 40, 40), "Please wait a moment before trying to collect a vehicle.", activator)
		return
	end

	net.Start("JobCarDealer:Derma")
		net.WriteEntity(self)
	net.Send(activator)
end
