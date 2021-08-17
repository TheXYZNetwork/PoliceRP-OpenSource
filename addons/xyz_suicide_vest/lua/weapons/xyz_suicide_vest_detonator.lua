
SWEP.HoldType = ""
SWEP.ViewModelFOV = 90
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_radio_hands.mdl"
SWEP.WorldModel = ""
SWEP.ShowViewModel = true
SWEP.UseHands = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {}
SWEP.VElements = {}
SWEP.WElements = {}

SWEP.AutoSwitchTo = true
SWEP.Contact = ""
SWEP.Author = ""
SWEP.FiresUnderwater = true
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.Instructions = ""
SWEP.AutoSwitchFrom = false
SWEP.base = "weapon_base"
SWEP.Category = "The XYZ Network"
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.PrintName = "Suicide Vest Detonator"

SWEP.Primary.Recoil				= 0
SWEP.Primary.Damage				= 0
SWEP.Primary.NumShots			= 0
SWEP.Primary.Cone				= 0	
SWEP.Primary.ClipSize			= -1
SWEP.Primary.DefaultClip		= -1
SWEP.Primary.Automatic   		= true
SWEP.Primary.Ammo         		= "none"



function SWEP:Deploy()
	self:GetOwner():GetViewModel():SendViewModelMatchingSequence(self:GetOwner():GetViewModel():LookupSequence("idle"))
end 

function SWEP:PrimaryAttack()
	if CLIENT then return end
	local ply = self:GetOwner()
	if XYZShit.CoolDown.Check("SuicideVest:Detonator:Primary", 5, ply) then return end

	if not IsValid(self.activeVest) then print(1) return end
	self:GetOwner():GetViewModel():SendViewModelMatchingSequence(self:GetOwner():GetViewModel():LookupSequence("button_press"))

	self.active = true
	timer.Simple(0.7, function()
		self.active = false
		self.activeVest:Detonate()
	end)
end

function SWEP:SecondaryAttack()
	if CLIENT then return end
	if XYZShit.CoolDown.Check("SuicideVest:Detonator:Secondary", 1, ply) then return end
	if IsValid(self.activeVest) then return end

	local ply = self:GetOwner()
	local target = ply:GetEyeTrace().Entity

	if (not IsValid(target)) or (not target:IsPlayer()) then return end

	if target:GetPos():Distance(ply:GetPos()) > 250 then return end

	if IsValid(target:GetActiveWeapon()) and (target:GetActiveWeapon():GetClass() == "xyz_suicide_vest") then return end

	if XYZShit.CoolDown.Check("SuicideVest:Detonator:Place", SuicideVest.Cooldown, ply) then
		XYZShit.Msg("Server", Color(0, 255, 255), "There is currently a cooldown on your Suicide Vest!", ply)
		return
	end

	timer.Simple(1, function()
		if (not IsValid(ply)) or (not IsValid(target)) then return end

		if target:GetPos():Distance(ply:GetPos()) > 500 then return end
		if IsValid(target:GetActiveWeapon()) and (target:GetActiveWeapon():GetClass() == "xyz_suicide_vest") then return end

		self.activeVest = target:Give("xyz_suicide_vest")
		if not self.activeVest then return end

		self.activeVest.forced = true

		target:SetActiveWeapon(self.activeVest)
	end)
end

function SWEP:Initialize()
end

function SWEP:Holster()
	if self.active then return false end

	return true
end

function SWEP:OnRemove()
end

function SWEP:CalcViewModelView(ViewModel, OldEyePos, OldEyeAng, EyePos, EyeAng)
    return EyePos - (EyeAng:Forward() * 4) - (EyeAng:Up() * 5), EyeAng
end