AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Eli.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetTrigger(true)

	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)
	
	self.coolDown = 0
end

function ENT:OnTakeDamage()        
	return 0    
end

function ENT:AcceptInput(name, activator)
	if self.coolDown > CurTime() then
		XYZShit.Msg("Trucking Agency", Color(140, 140, 200), "Hold up there cowboy. Looks like we don't have any jobs open right now. Come back in "..math.Round(self.coolDown-CurTime(), 0).." seconds.", activator)
		return
	end
	self.coolDown = CurTime() + 0.1

	-- Team check here
	if not (activator:Team() == TEAM_TRUCKER) then
		XYZShit.Msg("Trucking Agency", Color(140, 140, 200), "We only hire true truckers here...", activator)
		return
	end

	if activator.truck_activeJob then
		XYZShit.Msg("Trucking Agency", Color(140, 140, 200), "You already have an active job!", activator)
	    return
	end

	net.Start("xyz_trucker_menu")
		net.WriteEntity(self)
	net.Send(activator)
end