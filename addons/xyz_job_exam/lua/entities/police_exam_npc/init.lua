AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/humans/nypd1940/male_08.mdl")
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

function ENT:Use(activator, caller)
	if activator:IsPlayer() == false then return end
	if activator:GetPos():Distance( self:GetPos() ) > 95 then return end
	if self.Config.LimitToJob and activator:Team() ~= self.Config.LimitToJob then 
		XYZShit.Msg("Exam", Color(33, 80, 118), "You must be a "..team.GetName(self.Config.LimitToJob).." to use this.", activator)
		return
	end

	if not licensedUsers[activator:SteamID64()] then XYZShit.Msg("Exam", Color(33, 80, 118), "Please complete the DMV test first.", activator) return end

	if self.Chances[activator:SteamID64()] and self.Chances[activator:SteamID64()] >= 3 then XYZShit.Msg("Exam", Color(33, 80, 118), "You cannot take this exam at this time.", activator) activator:changeTeam(GAMEMODE.DefaultTeam) return end
	if xWhitelist.Users[activator:SteamID64()].whitelist[self.Config.Whitelist] then XYZShit.Msg("Exam", Color(33, 80, 118), "You're already a "..team.GetName(self.Config.Team)..".", activator) return end

	net.Start("job_exam_ui")
	net.WriteEntity(self)
	net.Send(activator)

	hook.Run("JobExamOpened", activator, self)
end