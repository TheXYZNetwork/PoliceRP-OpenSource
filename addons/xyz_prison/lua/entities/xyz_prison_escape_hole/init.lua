AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT.Initialize(self)
	self:SetModel("models/freeman/owain_prisonhole_top.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetRenderMode(RENDERMODE_TRANSCOLOR)

	timer.Create("PrisonSystem:DestroyHole:"..self:EntIndex(), PrisonSystem.Config.EscapeTimeout, 1, function()
		if not IsValid(self) then return end

		self:Remove()
	end)
end

function ENT:Use(activator, caller)
	if not (self:GetProgress() >= 100) then return end
    if XYZShit.CoolDown.Check("PrisonSystem:EscapeHole", 2) then return end
	activator:SetPos(table.Random(PrisonSystem.Config.EscapePositions))

	if activator:Team() == PrisonSystem.Config.Prisoner then
		activator:wanted(NULL, "Prison break")
	end

	Quest.Core.ProgressPartyQuest(activator, "jail_break", 4)

	xLogs.Log(xLogs.Core.Player(activator).." went down an escape hole.", "Prison")
end


function ENT:MakeProgress(ply)
	if self:GetProgress() >= 100 then return end

	self:SetProgress(self:GetProgress() + math.random(PrisonSystem.Config.EscapeProgressMin, PrisonSystem.Config.EscapeProgressMax))

	self:SetColor(Color(255, 255, 255, 255 * (math.Clamp(self:GetProgress(), 0, 100)/100))) 
	self:EmitSound("physics/concrete/concrete_break2.wav")

	if self:GetProgress() >= 100 then
		Quest.Core.ProgressPartyQuest(ply, "jail_break", 3)
	end
	timer.Adjust("PrisonSystem:DestroyHole:"..self:EntIndex(), PrisonSystem.Config.EscapeTimeout)
end


function ENT:OnTakeDamage(dmg)
	self:Destruct()
	self:Remove()
end

function ENT:Destruct()
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
end