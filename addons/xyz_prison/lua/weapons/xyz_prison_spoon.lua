SWEP.PrintName = "Prison Spoon"
SWEP.Author = "Owain"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true

SWEP.HoldType = "pistol"
SWEP.UseHands = true
SWEP.ViewModelFOV = 85
SWEP.ViewModelFlip = false
SWEP.ViewModel			    = "models/freeman/c_owain_prisonspoon.mdl"
SWEP.WorldModel			    = "models/freeman/w_owain_prisonspoon.mdl"


SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize 	 = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false
SWEP.Base = "weapon_base"

SWEP.Secondary.Ammo = "none"

SWEP.HoldType = ""

function SWEP:Initialize()
    self:SetHoldType("")

    self.lastHolster = 0
end 

function SWEP:PrimaryAttack()
    if CLIENT then return end
    local ply = self.Owner
	if not (ply:Team() == PrisonSystem.Config.Prisoner) then return end
	self:SetNextPrimaryFire(CurTime()+3)

	local placement = ply:GetEyeTrace()
	-- Progress an existing hole
	local hole
	if (placement.Entity:GetClass() == "xyz_prison_escape_hole") then
		hole = placement.Entity
		if hole:GetProgress() >= 100 then return end

		hole:MakeProgress(ply)

	-- Create a new hole
	elseif not IsValid(self.hasMadeHole) then
		if placement.HitPos:DistToSqr(ply:GetPos()) > 100000 then return end
		-- Check it's the bottom floor
		if not (math.floor(placement.HitPos.z) == PrisonSystem.Config.EscapeLevel) then return end

		-- Create the hole
		hole = ents.Create("xyz_prison_escape_hole")
		hole:SetPos(Vector(placement.HitPos.x, placement.HitPos.y, placement.HitPos.z + 1))
		hole:Spawn()
		hole:GetPhysicsObject():EnableMotion(false)

		hole:MakeProgress(ply)

		self.hasMadeHole = hole
	else
		XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "You've already started digging a hole!", ply)
		return
	end

    local viewmodel = ply:GetViewModel()
    viewmodel:SendViewModelMatchingSequence(viewmodel:LookupSequence("dig"..math.random(1, 2)))

    self.isDigging = true
    timer.Simple(3, function()
    	if not IsValid(self) then return end
    	if not IsValid(hole) then return end

		if hole:GetProgress() >= 100 then 
			self:Break()
			return
		end
    	self.isDigging = false
    	if math.random(1, 10) <= PrisonSystem.Config.EscapeBreakChance then
    		self:Break()
    	end
    end)
end

function SWEP:Holster()
	return not self.isDigging
end

function SWEP:Break()
	if CLIENT then return end
	local ply = self.Owner

	XYZShit.Msg("Prisoner", PrisonSystem.Config.Color, "Your spoon broke!", ply)

	ply:EmitSound("npc/barnacle/neck_snap2.wav", 40)
	self:Remove()
end

function SWEP:SecondaryAttack()
end


function SWEP:Reload()
end