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

	self:SetSellPrice(math.random(Scrapper.Config.PriceMin, Scrapper.Config.PriceMax))
end

function ENT:OnTakeDamage()        
	return 0    
end

function ENT:AcceptInput(name, ply, caller)
    if XYZShit.CoolDown.Check("Scrapper:NPC", 1, ply) then return end

	if ply:IsPlayer() == false then return end
	if XYZShit.IsGovernment(ply:Team(), true) then return end

	net.Start("Scrapper:UI")
		net.WriteEntity(self)
	net.Send(ply)
end