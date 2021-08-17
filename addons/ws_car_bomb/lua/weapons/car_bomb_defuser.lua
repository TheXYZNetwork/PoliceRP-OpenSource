----------------------------------------
--Name: "car_bomb_defuser.lua"
--By: "Sir Francis Billard"
----------------------------------------

SWEP.PrintName = "Bomb Defuser"
SWEP.Author = "Sir Francis Billard"
SWEP.Instructions = "Left click to defuse a car bomb.\nRight click to check if a car has a bomb."
SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/c_arms.mdl"
SWEP.UseHands = false
SWEP.ViewModelFOV = 60
SWEP.WorldModel = ""

SWEP.SwayScale = 1
SWEP.DrawAmmo = false
SWEP.Slot = 4

SWEP.Primary.Ammo = "None"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "None"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

function SWEP:CanSecondaryAttack()
	return self:GetNextSecondaryFire() < CurTime()
end

function SWEP:CanPrimaryAttack()
	self.Owner:LagCompensation(true)
	local trent = self.Owner:GetEyeTrace().Entity
	self.Owner:LagCompensation(false)
	return 
		(trent.HasCarBombPlanted and IsValid(trent) and trent:IsVehicle() and self.Owner:GetPos():Distance(trent:GetPos()) < 512)
		or
		(IsValid(trent) and trent:IsPlayer() and IsValid(trent:GetActiveWeapon()) and (trent:GetActiveWeapon():GetClass() == "xyz_suicide_vest") and trent:GetActiveWeapon().forced)
end

function SWEP:Deploy()
	self:SetHoldType("normal")
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	return true
end

function SWEP:Reload() end

function SWEP:SecondaryAttack()
	if !self:CanSecondaryAttack() then return end
	self:SetNextSecondaryFire(CurTime() + 0.5)
	self.Owner:LagCompensation(true)
	local trent = self.Owner:GetEyeTrace().Entity
	self.Owner:LagCompensation(false)
	if trent.HasCarBombPlanted then
		self:EmitSound(Sound("buttons/blip1.wav"))
		if SERVER then
			XYZShit.Msg("Car Bomb", Color(200, 200, 200), "Car bomb detected", self.Owner)
		end
	end
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + 3)
	if SERVER then
		XYZShit.Msg("Bomb Defuser", Color(200, 200, 200), "Bomb defused", self.Owner)
	end
	self:EmitSound(Sound("weapons/c4/c4_disarm.wav"))
	timer.Simple(3, function()
		if self:CanPrimaryAttack() and IsValid(self.Owner) then
			self:EmitSound(Sound("weapons/c4/c4_disarm.wav"))
			self.Owner:LagCompensation(true)
			local trent = self.Owner:GetEyeTrace().Entity
			self.Owner:LagCompensation(false)
			if trent:IsVehicle() then
				trent.HasCarBombPlanted = nil
				if SERVER then
					XYZShit.Msg("Bomb Defuser", Color(200, 200, 200), "Bomb defused", self.Owner)
					self.Owner:StripWeapon(self.ClassName)
				end
			elseif trent:IsPlayer() then
				if SERVER then
					XYZShit.Msg("Bomb Defuser", Color(200, 200, 200), "Bomb defused", self.Owner)
					trent:StripWeapon("xyz_suicide_vest")
					self.Owner:StripWeapon(self.ClassName)
				end
			end
		else
			if SERVER then
				XYZShit.Msg("Bomb Defuser", Color(200, 200, 200), "Defusing failed", self.Owner)
			end
		end
	end)
end
