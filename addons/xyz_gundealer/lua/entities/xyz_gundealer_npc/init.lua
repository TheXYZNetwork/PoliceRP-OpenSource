AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

-- Sets the players model and basic physics ect..
function ENT:Initialize()
	self:SetModel("models/monk.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_NONE)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	
	self:CapabilitiesAdd(CAP_ANIMATEDFACE + CAP_TURN_HEAD)

	self.stock = {}
	
	for catName, catWeps in pairs(GunDealer.Config.Weapons) do
		self.stock[catName] = {}
		for k, v in ipairs(catWeps) do
			self.stock[catName][k] = v.stock
		end
	end
end

function ENT:AcceptInput(name, ply, caller)
	if XYZShit.CoolDown.Check("GunDealer:AcceptInput", 1, ply) then return end
	-- Basic checks
	if not ply:IsPlayer() then return end
	if ply:GetPos():Distance(self:GetPos()) > 100 then return end
	
	if not ply:getDarkRPVar("HasGunlicense") then
		XYZShit.Msg("Gun Dealer", GunDealer.Config.Color, "I can only sell to people with a Weapon License!", ply)
		return
	end
	if ply:isWanted() then
		XYZShit.Msg("Gun Dealer", GunDealer.Config.Color, "Are you crazy? You're wanted by the police!", ply)
		return
	end
	if ply.warranted then
		XYZShit.Msg("Gun Dealer", GunDealer.Config.Color, "There's currently a warrant out in your name, I can't be seen selling to you!", ply)
		return
	end

	net.Start("GunDealer:UI")
		net.WriteEntity(self)
		net.WriteTable(self.stock)
	net.Send(ply)
end

function ENT:OnTakeDamage()        
	return 0    
end