AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


-- Sets the players model and basic physics ect..
function ENT:Initialize()
	self:SetModel("models/gman_high.mdl")
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

function ENT:AcceptInput(name, ply, caller)
	-- Basic checks
	if !ply:IsPlayer() then return end
	if ply:GetPos():Distance(self:GetPos()) > 100 then return end

	if Election.Core.IsVoting then return end

	-- Opens derma
	if ply:Team() == TEAM_PRESIDENT then
		net.Start("Election:UI:Pres")
			net.WriteEntity(self)
		net.Send(ply)
	else
		net.Start("Election:UI")
			net.WriteEntity(self)
		net.Send(ply)
	end
end