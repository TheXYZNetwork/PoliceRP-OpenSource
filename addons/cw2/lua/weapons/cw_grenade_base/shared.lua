AddCSLuaFile()
AddCSLuaFile("cl_player_funcs.lua")
AddCSLuaFile("cl_umsgs.lua")

if CLIENT then
	include("cl_umsgs.lua")
	include("cl_player_funcs.lua")
	
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Grenade base"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "f"
	killicon.AddFont("cw_deagle", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.ViewModelMovementScale = 0.8
	SWEP.DisableSprintViewSimulation = true
end

SWEP.CanRestOnObjects = false
	
SWEP.Attachments = {}
SWEP.Sounds = {}

SWEP.SpeedDec = 5

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "grenade"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= ""
SWEP.WorldModel		= ""

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ""

SWEP.SprintingEnabled = false
SWEP.AimingEnabled = false
SWEP.CanCustomize = false

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.045
SWEP.VelocitySensitivity = 0
SWEP.MaxSpreadInc = 0
SWEP.SpreadPerShot = 0
SWEP.SpreadCooldown = 0
SWEP.Shots = 1
SWEP.Damage = 112
SWEP.DeployTime = 0.5

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.98
SWEP.ReloadHalt = 2.49

SWEP.ReloadTime_Empty = 1.98
SWEP.ReloadHalt_Empty = 3.4

SWEP.timeToThrow = 0.75
SWEP.swapTime = 0.4
SWEP.fuseTime = 3

function SWEP:Reload()
end

function SWEP:IndividualThink()
	local curTime = CurTime()
	
	if self.pinPulled then
		if curTime > self.throwTime then
			if not self.Owner:KeyDown(IN_ATTACK) then
				if not self.animPlayed then
					self.entityTime = CurTime() + 0.15
					self:sendWeaponAnim("throw")
					self.Owner:SetAnimation(PLAYER_ATTACK1)
				end
				
				if curTime > self.entityTime then
					if SERVER then
						local grenade = ents.Create(self.grenadeEnt)
						grenade:SetPos(self.Owner:GetShootPos() + CustomizableWeaponry.quickGrenade:getThrowOffset(self.Owner))
						grenade:SetAngles(self.Owner:EyeAngles())
						grenade:Spawn()
						grenade:Activate()
						grenade:Fuse(self.fuseTime)
						grenade:SetOwner(self.Owner)
						CustomizableWeaponry.quickGrenade:applyThrowVelocity(self.Owner, grenade)
						self:TakePrimaryAmmo(1)
					end
					
					self:SetNextPrimaryFire(curTime + 5)
					
					timer.Simple(self.swapTime, function()
						if IsValid(self) then
							if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then -- we're out of ammo, strip this weapon
								self.Owner:ConCommand("lastinv")
							else
								self:sendWeaponAnim("draw")
							end
						end
					end)
					
					self.pinPulled = false
				end
				
				self.animPlayed = true
			end
		end
	end
end

function SWEP:PrimaryAttack()
	if self.Owner:GetAmmoCount(self.Primary.Ammo) == 0 and self:Clip1() == 0 then
		return
	end

	if self.pinPulled then
		return
	end
	
	for i = 1, 3 do
		if not self:canFireWeapon(i) then
			return
		end
	end
	
	self.pinPulled = true
	self.animPlayed = false
	self.throwTime = CurTime() + self.timeToThrow
	self:sendWeaponAnim("pullpin")
end

function SWEP:SecondaryAttack()
end