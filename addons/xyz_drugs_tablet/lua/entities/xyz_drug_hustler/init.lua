AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


-- Sets the players model and basic physics ect..
function ENT:Initialize()
	self:SetModel("models/Humans/Group03/male_07.mdl")
	self:SetHullType(HULL_HUMAN);
	self:SetHullSizeNormal();
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetTrigger(true)
	
	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)

	self:SetHolding(0)
end

function ENT:OnTakeDamage()        
	return 0    
end

function ENT:AcceptInput(name, ply, caller)
	-- Basic checks
	if !ply:IsPlayer() then return end
	if ply:GetPos():Distance(self:GetPos()) > 100 then return end

	if self:GetHolding() <= 0 then return end

	ply:addMoney(self:GetHolding())
	xLogs.Log(xLogs.Core.Player(ply).." took "..xLogs.Core.Color(DarkRP.formatMoney(self:GetHolding()), Color(0, 200, 0)).." from a Drug Hustler.", "Drug NPC")
	XYZShit.Msg("Drug Hustler", XYZDrugsTable.Config.Color, "You have sold drugs for: "..DarkRP.formatMoney(self:GetHolding()), ply)
	self:SetHolding(0)
end


function ENT:StartTouch(ent)
	local calcData = XYZDrugsTable.Config.SellValues[ent:GetClass()]

	if not calcData then return end

	local worth = calcData.calcPer(ent) * calcData.valuePer()

	self:SetHolding(self:GetHolding() + worth)

	hook.Run("DrugTabletDrugHustlerAdd",  ent, worth)

	ent:Remove()

	xLogs.Log(xLogs.Core.Color(DarkRP.formatMoney(worth), Color(0, 200, 0)).." has been added to a Drug Hustler.", "Drug NPC")
end