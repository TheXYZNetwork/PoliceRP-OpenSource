AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT.Initialize(self)

	self:SetModel("models/meekal/lg_22ea53.mdl")
	self:SetSkin(4)
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
end

function ENT:Use(ply, activator)
	if (not (ply:Team() == TEAM_PRESIDENT)) and (not (ply:Team() == TEAM_PCOM)) and (not (ply:Team() == TEAM_PDCOM)) then return end
		
	net.Start("XYZ_PRES_OPEN_TAX")
		net.WriteInt(XYZPresident.TaxRate,16)
	net.Send( ply )

end