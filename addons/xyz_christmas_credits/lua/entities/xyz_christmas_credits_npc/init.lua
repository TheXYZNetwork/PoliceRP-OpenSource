AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/humans/snow_man_pm_human/snow_man_pm_human.mdl")
	self:SetHullType(HULL_HUMAN);
	self:SetHullSizeNormal();
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()

	self.cooldown = 0
end

function ENT:AcceptInput(name, activator, caller)
	if activator:IsPlayer() == false then return end
	
	net.Start("ChristmasCredits:Derma")
		net.WriteEntity(self)
		net.WriteInt(XYZChristmasCredits.Core.PlyCredits[activator:SteamID64()], 32)
	net.Send(activator)
end
