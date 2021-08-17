AddCSLuaFile()

SWEP.PrintName = "M3 Super 90 (Beanbag)"

CustomizableWeaponry:registerAmmo("Bean Bag", "Bean Bag Rounds", 0, 0)

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = false 	--true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "k"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	SWEP.ShellDelay = 0.3
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_cstm_m3super90.mdl"
	SWEP.WMPos = Vector(-1, 1.5, 0)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true
		
	SWEP.IronsightPos = Vector(-2.603, -3, 1.088)
	SWEP.IronsightAng = Vector(0.026, 0.079, 0)
	
	SWEP.MicroT1Pos = Vector(-2.618, 0, 0.25)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.613, -4.803, -0.06)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.613, -4.803, 0.064)
	SWEP.AimpointAng = Vector(0, 0, 0)
			
	SWEP.ACOGPos = Vector(-2.599, -4.803, -0.109)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
		
	SWEP.CustomizePos = Vector(7.711, -0.482, -2)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)
		
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.593, -4.803, -1.12), [2] = Vector(0, 0, 0)}}

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(-0.64, 0.294, -0.978)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Spas_Body", pos = Vector(-2.589, -4.256, 6.44), angle = Angle(0, 0, 180), size = Vector(1, 1, 1)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Spas_Body", pos = Vector(-2.053, 0.184, 12.067), angle = Angle(-3.333, 90, 180), size = Vector(1, 1, 1)},
		["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "Spas_Body", pos = Vector(-2.064, -11.19, 2.654), angle = Angle(0, -90, 180), size = Vector(0.6, 1.1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Spas_Body", pos = Vector(-2.32, -9.9, 0.635), angle = Angle(0, -180, -180), size = Vector(0.4, 0.4, 0.4), adjustment = {min = -11, max = -9.9, inverse = true, axis = "y"}},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Spas_Body", pos = Vector(-2.646, -4.941, 5.907), angle = Angle(0, 0, 180), size = Vector(0.899, 0.899, 0.899)}
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
end

SWEP.MuzzleVelocity = 90 --381 -- in meter/s

SWEP.SightBGs = {main = 2, none = 1}
SWEP.ADSFireAnim = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload_start = "start_reload",
	insert = "insert",
	reload_end = "after_reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {start_reload = {{time = 0.05, sound = "CW_FOLEY_LIGHT"}},
	insert = {{time = 0.1, sound = "CW_M3SUPER90_INSERT"}},
	
	after_reload = {{time = 0.1, sound = "CW_M3SUPER90_PUMP"},
	{time = 0.6, sound = "CW_FOLEY_LIGHT"}},
	
	draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"},
	{time = 0.55, sound = "CW_M3SUPER90_PUMP"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/shotguns/m3.mdl"
SWEP.WorldModel		= "models/weapons/w_cstm_m3super90.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Round 			= "cw_bullet_beanbag"
SWEP.Primary.Ammo			= "Bean Bag"

SWEP.FireDelay = 0.7
SWEP.FireSound = "CW_M3SUPER90_FIRE"

SWEP.Recoil = 1.0
-- Recoil vars for GDCW impacts
SWEP.Primary.Cone				= 0.0					// This is the variable	
SWEP.Primary.ConeSpray			= 0.95					// Hip fire accuracy
SWEP.Primary.ConeIncrement		= 0.0					// Rate of innacuracy
SWEP.Primary.ConeMax			= 0.0					// Maximum Innacuracy
SWEP.Primary.ConeDecrement		= 0.97					// Rate of accuracy	
SWEP.Primary.KickUp				= 0.4					// Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.1					// Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0					// Maximum side recoil (koolaid)	
SWEP.Primary.HitSpread = 0.5

SWEP.HipSpread = 0.025
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.006
SWEP.SpreadPerShot = 0.002
SWEP.SpreadCooldown = 0.32
SWEP.Shots = 1
SWEP.Damage = 40
SWEP.DeployTime = 1

SWEP.ReloadStartTime = 0.3
SWEP.InsertShellTime = 0.6
SWEP.ReloadFinishWait = 1
SWEP.PumpMidReloadWait = 0.6
SWEP.ShotgunReload = true

SWEP.Chamberable = true

--[[ 
CustomizableWeaponry.callbacks:addNew("deployWeapon", "setbeanbagmat", function(self)
	--self.CW_VM:SetSubMaterial(0, "models/cw2/shotguns/m3/m3_lesslethal")
	self:SetSubMaterial(0, "models/cw2/shotguns/m3/m3_lesslethal")
end)--]] 

-- GDCW --------------------------------
function SWEP:FireRocket() 

	if self.Owner:KeyDown(IN_ATTACK2) then
		aim = self.Owner:GetAimVector()+(VectorRand()*self.Primary.Cone/360)
	else 
		aim = self.Owner:GetAimVector()+(VectorRand()*math.Rand(0,0.04))
	end

	if !self.Owner:IsNPC() then
		pos = self.Owner:GetShootPos()
	else
		pos = self.Owner:GetShootPos()+self.Owner:GetAimVector()*50
	end

	if SERVER then
		local bullet = ents.Create(self.Primary.Round)
		if !bullet:IsValid() then return false end
		bullet:SetAngles(aim:Angle()+Angle(90,0,0))
		bullet:SetPos(pos)
		bullet:SetOwner(self.Owner)
		bullet:Spawn()
		bullet:Activate()
		end

		-- RECOIL FOR SINGLEPLAYER IS RIGHT BELOW THESE WORDS
		if SERVER and (self.Single) and !self.Owner:IsNPC() then
		local anglo = Angle(math.Rand(-self.Primary.KickDown,self.Primary.KickUp), math.Rand(-self.Primary.KickHorizontal,self.Primary.KickHorizontal), 0)
		self.Owner:ViewPunch(anglo)
		angle = self.Owner:EyeAngles() - anglo
		self.Owner:SetEyeAngles(angle)
		end

	if (!self.Single)  and !self.Owner:IsNPC() then		// RECOIL FOR MULTIPLAYER IS RIGHT BELOW THESE WORDS
	self.Primary.Cone = math.Clamp(self.Primary.Cone+self.Primary.ConeIncrement,0,self.Primary.ConeMax)
	local anglo = Angle(math.Rand(-self.Primary.KickDown,self.Primary.KickUp), math.Rand(-self.Primary.KickHorizontal,self.Primary.KickHorizontal), 0)
	self.Owner:ViewPunch(anglo)
	end
end

function SWEP:PrimaryAttack()
	if self.ShotgunReloadState != 0 then
		return
	end
	
	if self.ReloadDelay then
		return
	end
	
	if self.Owner:KeyDown(IN_USE) then
		if CustomizableWeaponry.quickGrenade.canThrow(self) then
			CustomizableWeaponry.quickGrenade.throw(self)
			return
		end
	end
	
	if CurTime() < self.GlobalDelay then
		return false
	end
	
	if self.dt.Safe then
		self:CycleFiremodes()
		return
	end
	
	local preFireResult = CustomizableWeaponry.callbacks.processCategory(self, "preFire")
	
	if preFireResult then
		return
	end
	
	if self:isNearWall() then
		return
	end
	
	if self.InactiveWeaponStates[self.dt.State] then
		return
	end
	
	if self.dt.State == CW_AIMING and self.dt.M203Active then
		if self.M203Chamber then
			self:fireM203(IsFirstTimePredicted())
			
			return
		end
	end
	
	mag = self:Clip1()
	
	if mag == 0 then
		self:EmitSound("CW_EMPTY", 100, 100)
		self:SetNextPrimaryFire(CT + 0.25)
		return
	end
	
	if self.BurstAmount and self.BurstAmount > 0 then
		if self.dt.Shots >= self.BurstAmount then
			return
		end
		
		self.dt.Shots = self.dt.Shots + 1
	end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	CT = CurTime()
	
	if IsFirstTimePredicted() then
		if self.dt.Suppressed then
			self:EmitSound(self.FireSoundSuppressed, 105, 100)
		else
			self:EmitSound(self.FireSound, 105, 100)
		end
		
		if self.fireAnimFunc then
			self:fireAnimFunc()
		else
			if self.dt.State == CW_AIMING then
				if self.ADSFireAnim then
					self:playFireAnim()
				end
			else
				self:playFireAnim()
			end
		end
		
		self:FireRocket(self.Damage, self.CurCone, self.ClumpSpread, self.Shots)
		self:makeFireEffects()
		self:MakeRecoil()
		self:addFireSpread(CT)

		
		if CLIENT then
			self:simulateRecoil()
		end
		
		if SP and SERVER then
			SendUserMessage("CW_Recoil", self.Owner)
		end
		
		-- apply a global delay after shooting, if there is one
		if self.GlobalDelayOnShoot then
			self.GlobalDelay = CT + self.GlobalDelayOnShoot
		end
	end
	
	CustomizableWeaponry.callbacks.processCategory(self, "postFire")
	
	local suppressAmmoUsage = CustomizableWeaponry.callbacks.processCategory(self, "shouldSuppressAmmoUsage")
	
	if not suppressAmmoUsage then
		self:TakePrimaryAmmo(self.AmmoPerShot)
	end
	
	self:SetNextPrimaryFire(CT + self.FireDelay)
	
	-- either force the weapon back to hip after firing, or don't
	if self.ForceBackToHipAfterAimedShot then
		self.dt.State = CW_IDLE
		self:SetNextSecondaryFire(CT + self.ForcedHipWaitTime)
	else
		self:SetNextSecondaryFire(CT + self.FireDelay)
	end
	
	self.ReloadWait = CT + (self.WaitForReloadAfterFiring and self.WaitForReloadAfterFiring or self.FireDelay)
	
	CustomizableWeaponry.callbacks.processCategory(self, "postConsumeAmmo")
end
