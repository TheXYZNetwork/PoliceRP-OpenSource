AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props/cs_office/offcorkboarda.mdl")
    self:SetMaterial("models/debug/debugwhite")
    self:SetColor(Color(103, 103, 103))
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetModelScale(self:GetModelScale() * 5.5)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:EnableMotion(false)
    end
end

function ENT:OnRemove()
    XYZPresident.Core.numlaws = XYZPresident.Core.numlaws - 1
end