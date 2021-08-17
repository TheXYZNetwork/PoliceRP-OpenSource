AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Items/ammocrate_ar2.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
end

function ENT:StartTouch(ent)
	if not self.AllowedItems[ent:GetClass()] then return end
	local forGovFunds = 0
	if ent:GetClass() == "pvault_moneybag" then
		forGovFunds = ent:GetValue()
	else
		forGovFunds = 2000
	end
	ent:Remove()

	local clamped = math.Clamp(XYZPresident.TotalMoney + forGovFunds, 0, XYZPresident.Config.HoldCap)
	local thrownaway = 0

	if clamped ~= (XYZPresident.TotalMoney + forGovFunds) then
	    thrownaway = ((XYZPresident.TotalMoney + forGovFunds) - XYZPresident.Config.HoldCap)
	    XYZPresident.Stats.ThrownAwayCap = XYZPresident.Stats.ThrownAwayCap + thrownaway
	end
    XYZPresident.Stats.AddedToFunds = XYZPresident.Stats.AddedToFunds + (forGovFunds - thrownaway or 0)
    XYZPresident.Stats.Seizures = XYZPresident.Stats.Seizures + (forGovFunds - thrownaway or 0)

	XYZPresident.TotalMoney = clamped
end