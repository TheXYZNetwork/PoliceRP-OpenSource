AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT.Initialize(self)
	self:SetModel("models/props_wasteland/controlroom_filecabinet002a.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
end

function ENT:Use(activator, caller)
	if self:GetNextUse() > CurTime() then return end
	if not (activator:Team() == PrisonSystem.Config.Prisoner) then return end
    if XYZShit.CoolDown.Check("PrisonSystem:Search", 2, activator) then return end

    self:SetNextUse(CurTime() + math.random(PrisonSystem.Config.EscapeBoxMin, PrisonSystem.Config.EscapeBoxMax))
	self:EmitSound("vehicles/atv_ammo_open.wav")

    if math.random(1, 10) > PrisonSystem.Config.EscapeFindChance then
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "You didn't find anything of value...", activator)
    else
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "You found something of value!", activator)

		local foundItem = table.Random(PrisonSystem.Config.RandomItem)
    	activator:Give(foundItem).blockDrop = true

    	if foundItem == "xyz_prison_spoon" then
			Quest.Core.ProgressQuest(activator, "jail_break", 2)
    	end
    end
end

