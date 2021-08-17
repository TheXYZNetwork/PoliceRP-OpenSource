SWEP.PrintName = "Drill"
SWEP.Author = "Owain"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true

SWEP.HoldType = "pistol"
SWEP.UseHands = true
SWEP.ViewModelFOV = 85
SWEP.ViewModelFlip = false
SWEP.ViewModel              = "models/freeman/c_exhibition_jackhammer.mdl"
SWEP.WorldModel             = "models/freeman/w_exhibition_jackhammer.mdl"


SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize      = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false
SWEP.Base = "weapon_base"

SWEP.Secondary.Ammo = "none"

SWEP.HoldType = ""

function SWEP:Initialize()
    self:SetHoldType("")

    self.isDigging = false
    self.isRaised = false
    self.isMoving = false

    self:SetDeploySpeed(1)
end 

function SWEP:Holster()
	local ply = self.Owner

	return (not self.isDigging) and (not self.isMoving) and (not self.isRaised)
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
	if not self.isRaised then return end

	local ply = self.Owner
	local target = ply:GetEyeTrace().Entity

	-- Not a mining ore node
	if not target.isOreNode then return end
	-- Distance check
	if ply:GetPos():DistToSqr(target:GetPos()) > 8000 then return end

	target:Mine(ply)

	self:SetNextPrimaryFire(CurTime() + Mining.Config.DrillCooldown)
end

function SWEP:LowerDrill()
	local ply = self.Owner

	self.isMoving = true
	self.isRaised = false

	timer.Remove("Mining:HackyLoopFix:"..self:EntIndex())
	ply:StopSound("vehicles/Crane/crane_idle_loop3.wav")

	ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("mine_end"))

	timer.Simple(2.5, function()
		ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("idle"))

		self.isMoving = false
	end)
end

function SWEP:RaiseDrill()
	local ply = self.Owner
	local viewModel = ply:GetViewModel()

	self.isMoving = true
	viewModel:SendViewModelMatchingSequence(viewModel:LookupSequence("mine_ready"))

	timer.Simple(2, function()
		viewModel:SendViewModelMatchingSequence(viewModel:LookupSequence("mine_loop"))

		-- A hacky workaround for the animation not looping :/
		timer.Create("Mining:HackyLoopFix:"..self:EntIndex(), viewModel:SequenceDuration(viewModel:LookupSequence("mine_loop")), 0, function()
			viewModel:SendViewModelMatchingSequence(viewModel:LookupSequence("mine_loop"))
		end)

		-- ambient/machines/diesel_engine_idle1.wav
		ply:EmitSound("vehicles/Crane/crane_idle_loop3.wav", 100, 100, 1)

		self.isMoving = false

		self.isRaised = true
	end)
end

function SWEP:OnRemove()
	timer.Remove("Mining:HackyLoopFix:"..self:EntIndex())
end

-- Think hook goes brrr
function SWEP:Think()
	if CLIENT then return end

	-- Check if mid move
	if self.isMoving then return end

	local isHoldingLeftClick = self.Owner:KeyDown(IN_ATTACK)

	-- Lower the drill
	if self.isRaised and (not isHoldingLeftClick) then
		self:LowerDrill()

	-- Raise the drill
	elseif (not self.isRaised) and isHoldingLeftClick then
		self:RaiseDrill()
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end