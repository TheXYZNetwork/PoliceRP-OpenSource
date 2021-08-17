----------------------------------------
--Name: "car_bomb.lua"
--By: "Sir Francis Billard"
----------------------------------------

SWEP.PrintName = "Car Bomb"
SWEP.Author = "Sir Francis Billard"
SWEP.Instructions = "Left click to plant bomb.\nRight click to change bomb type.\nReload to change bomb timer."
SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/cstrike/c_c4.mdl"
SWEP.UseHands = true
SWEP.ViewModelFOV = 60
SWEP.WorldModel = "models/weapons/w_c4.mdl"

SWEP.SwayScale = 1
SWEP.DrawAmmo = false
SWEP.Slot = 4

SWEP.DetonateTime = 0
SWEP.BombType = false
SWEP.ReloadSpamTime = 0

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
	return !trent.HasCarBombPlanted and IsValid(trent) and trent:IsVehicle() and self.Owner:GetPos():Distance(trent:GetPos()) < 512
end

function SWEP:Deploy()
	self:SetHoldType("slam")
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	return true
end

function SWEP:Reload()
	if self.ReloadSpamTime < CurTime() then
		self.ReloadSpamTime = CurTime() + 0.5
		self:EmitSound(Sound("weapons/c4/c4_beep1.wav"))
		if self.DetonateTime < 26 then
			self.DetonateTime = self.DetonateTime + 5
		else
			self.DetonateTime = 5
		end
		if SERVER then
			XYZShit.Msg("Car Bomb", Color(200, 200, 200), "Timer set to "..self.DetonateTime.." seconds", self.Owner)
		end
	end
end

function SWEP:SecondaryAttack()
	if !self:CanSecondaryAttack() then return end
	self:SetNextSecondaryFire(CurTime() + 0.5)
	self:EmitSound(Sound("weapons/c4/c4_beep1.wav"))
	self.BombType = !self.BombType
	if SERVER then
		XYZShit.Msg("Car Bomb", Color(200, 200, 200), self.BombType and "Bomb type switched to timed" or "Bomb type switched to ignition", self.Owner)
	end
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + 10)
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	timer.Simple(self:SequenceDuration() + 0.1, function()
		if !self:CanPrimaryAttack() then return end
		if IsValid(self.Owner) then
			self:EmitSound(Sound("weapons/c4/c4_plant.wav"))
			if self.Owner:IsPlayer() then
				self.Owner:LagCompensation(true)
			end
			local veh = util.TraceLine(util.GetPlayerTrace(self.Owner)).Entity
			if self.Owner:IsPlayer() then
				self.Owner:LagCompensation(false)
			end

			veh.CarBombPlanter = self.Owner

			if SERVER then
				self.Owner:StripWeapon(self.ClassName)
			end

			if self.BombType then
				if self.DetonateTime < 1 then
					self.DetonateTime = 5
				end
				timer.Simple(self.DetonateTime, function()
					if !IsValid(veh) then return end
					if SERVER then
						CarBombApplyDamage(veh, nil)
					end
				end)
			else
				veh.HasCarBombPlanted = true
			end
		end
	end)
end
