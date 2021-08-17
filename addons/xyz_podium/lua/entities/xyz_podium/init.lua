AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/freeman/owain_podium.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:Activate()
	local phys = self:GetPhysicsObject()
	phys:Wake()
	self:SetBodygroup(1, 1)

	self:SetState(0)
	self:SetBackground(true)
end

function ENT:Use(ply)
	if not table.HasValue(XYZShit.Jobs.Government.PoliceMeetings, ply:Team()) and not XYZShit.Staff.All[ply:GetUserGroup()] then return end
	-- Basic checks
	local tr = ply:GetEyeTrace().HitPos
	local pos = self:WorldToLocal(tr)

	local key = nil
	for k=0, 5 do
		if pos.x < 0.82 + (-1.48*k) and pos.x > -0.68 + (-1.48*k) and pos.y < 10.87 and pos.y > 2.24 then
			key = k
		end
	end

	if key then
		self:SetState(key)
		return
	end

	if pos.x < 0.82 and pos.x > -0.69 and pos.y < -5.26 and pos.y > -10.86 then
		self:SetBackground(true)
		return
	end
	if pos.x < -0.65 and pos.x > -2.23 and pos.y < -5.27 and pos.y > -10.87 then
		self:SetBackground(false)
		return
	end

end