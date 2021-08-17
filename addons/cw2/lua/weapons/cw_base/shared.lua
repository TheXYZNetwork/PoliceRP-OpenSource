--[[ You'll see a mish-mash of CamelCase and camelBack in here, since I used my SWB as the base for this and built on top of it
This is since when I coded SWB I was using CamelCase, over time I got used to camelBack, which is the reason for this inconsistency
But hey, as long as it's OOP, it shouldn't be that big of a problem
]]--

CW_IDLE = 0
CW_RUNNING = 1
CW_AIMING = 2
CW_ACTION = 3
CW_CUSTOMIZE = 4
CW_HOLSTER_START = 5
CW_HOLSTER_END = 6
CW_PRONE_BUSY = 7 -- entering/leaving prone state
CW_PRONE_MOVING = 8 -- crawling while prone

-- rather than a lot of 'or' statements, just make a table containing numeric indexes as keys that dictate when the weapon cannot be used
SWEP.InactiveWeaponStates = {[CW_RUNNING] = true,
	[CW_ACTION] = true,
	[CW_CUSTOMIZE] = true,
	[CW_HOLSTER_START] = true,
	[CW_HOLSTER_END] = true,
	[CW_PRONE_BUSY] = true,
	[CW_PRONE_MOVING] = true}
	
-- conditions in which the player can't customize his weapon
SWEP.NoCustomizeStates = {[CW_RUNNING] = true,
	[CW_ACTION] = true,
	[CW_HOLSTER_START] = true,
	[CW_HOLSTER_END] = true,
	[CW_PRONE_BUSY] = true,
	[CW_PRONE_MOVING] = true}
	
SWEP.ToggleM203States = {[CW_IDLE] = true,
	[CW_RUNNING] = true}
	
SWEP.M203ReloadSounds = {[1] = {time = 0.3, sound = "CW_M203_OPEN"},
	[2] = {time = 0.4, sound = "CW_M203_REMOVE"},
	[3] = {time = 1.4, sound = "CW_M203_INSERT"},
	[4] = {time = 1.9, sound = "CW_M203_CLOSE"}}
	
SWEP.AttachmentEligibilityEnum = {
	ACTIVE_ATTACHMENT_EXCLUSION = -1,
	NEED_ATTACHMENTS = -2
}

SWEP.UnavailableAttachmentEnum = {
	NEED_ATTACHMENTS = -1,
	INCOMPATIBILITY = -2,
	INCOMPATIBLE_ATTACHMENT_PRESENT = -3,
	DEPENDENT_ATTACHMENT_NOT_PRESENT = -4,
	INCOMPATIBLE_CATEGORY_PRESENT = -5,
	DEPENDENT_CATEGORY_NOT_PRESENT = -6,
	PLAYER_DOES_NOT_HAVE_ATTACHMENT = -7,
	MISC_FAILURE = -8
}

SWEP.M203Anims = {idle_to_ready = "Idle2Fire",
ready_to_idle = "Fire2Idle",
reload = "reload"}

if SERVER then
	include("sv_filestodownload.lua")
end

AddCSLuaFile()
AddCSLuaFile("sh_bullets.lua")
AddCSLuaFile("cl_model.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_hooks.lua")
AddCSLuaFile("cl_calcview.lua")
AddCSLuaFile("sh_ammotypes.lua")
AddCSLuaFile("sh_move.lua")
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_anims.lua")
AddCSLuaFile("cl_playerbindpress.lua")
AddCSLuaFile("sh_attachments.lua")
AddCSLuaFile("sh_general.lua")
AddCSLuaFile("cl_umsgs.lua")
AddCSLuaFile("cl_cvars.lua")
AddCSLuaFile("sh_mixins.lua")
AddCSLuaFile("sh_stats.lua")
AddCSLuaFile("sh_plugininit.lua")
AddCSLuaFile("sh_hooks.lua")

include("sh_bullets.lua")
include("sh_ammotypes.lua")
include("sh_move.lua")
include("sh_sounds.lua")
include("sh_anims.lua")
include("sh_attachments.lua")
include("sh_general.lua")
include("sh_mixins.lua")
include("sh_stats.lua")
include("sh_plugininit.lua")
include("sh_hooks.lua")

if CLIENT then
	include("cl_calcview.lua")
	include("cl_playerbindpress.lua")
	include("cl_model.lua")
	include("cl_hud.lua")
	include("cl_hooks.lua")
	include("cl_umsgs.lua")
	include("cl_cvars.lua")
	
	SWEP.CustomizePos = Vector(5.488, -1.627, -1.821)
	SWEP.CustomizeAng = Vector(17.009, 29.971, 16.669)
	
	SWEP.SprintPos = Vector(1.786, 0, 0)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.PronePos = Vector(6.717, -6.273, -6.577)
	SWEP.ProneAng = Vector(5.618, 49.055, -15.311)
	
	SWEP.DrawCrosshair = false
	SWEP.BounceWeaponIcon = false
	SWEP.DrawWeaponInfoBox = false
	SWEP.CurFOVMod = 0
	SWEP.BobScale = 0
	SWEP.SwayScale = 0
	SWEP.ZoomAmount = 15
	SWEP.FadeCrosshairOnAim = true
	SWEP.DrawAmmo = true
	SWEP.DrawTraditionalWorldModel = true
	SWEP.CrosshairEnabled = true
	SWEP.ViewbobEnabled = true
	SWEP.ViewbobIntensity = 1
	SWEP.ReloadViewBobEnabled = true
	SWEP.RVBPitchMod = 1
	SWEP.RVBYawMod = 1
	SWEP.RVBRollMod = 1
	SWEP.BulletDisplay = 0
	SWEP.Shell = "mainshell"
	SWEP.ShellScale = 1
	SWEP.CSMuzzleFlashes  = true
	SWEP.ZoomWait = 0
	SWEP.CrosshairParts = {left = true, right = true, upper = true, lower = true}
	SWEP.FireModeDisplayPos = "middle"
	SWEP.SelectFont = "CW_SelectIcons"
	SWEP.SwimPos = Vector(0, 0, -3)
	SWEP.SwimAng = Vector(-29.921, 38.909, 0)
	SWEP.ShellOffsetMul = 1
	SWEP.MuzzleAttachment = 1
	SWEP.CustomizeMenuAlpha = 0
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.6
	SWEP.ForeGripOffsetCycle_Reload = 0.6
	SWEP.ForeGripOffsetCycle_Draw = 0.5
	SWEP.MuzzleEffectSupp = "muzzleflash_suppressed"
	SWEP.BipodAngleLimitYaw = 30
	SWEP.BipodAngleLimitPitch = 10
	SWEP.BipodSensitivity = {x = -0.3, z = -0.3, p = 0.1, r = 0.1}
	SWEP.LuaVMRecoilIntensity = 0
	SWEP.LuaVMRecoilLowerSpeed = 0
	SWEP.LuaVMRecoilMod = 1 -- modifier of overall intensity for the code based recoil
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 1, pitch = 1} -- modifier for intensity of the recoil on varying axes
	SWEP.OffsetBoltOnBipodShoot = true
	SWEP.AimViewModelFOV = 60
	SWEP.CustomizationTab = 1
	SWEP.PresetPosition = 1
	SWEP.CustomizationMenuScale = 0.015
	SWEP.CanRestOnObjects = true
	SWEP.FireMoveMod = 1
	SWEP.M203Time = 0
	SWEP.FOVPerShot = 1
	SWEP.WorldMuzzleAttachmentID = 1
	SWEP.WorldShellEjectionAttachmentID = 2
	SWEP.HipFireFOVIncrease = true
	
	SWEP.MuzzleAttachmentName = "1"
	
	SWEP.AimBreathingIntensity = 1
	SWEP.CurBreatheIntensity = 1
	SWEP.BreathLeft = 1
	SWEP.BreathRegenRate = 0.2
	SWEP.BreathDrainRate = 0.1
	SWEP.BreathIntensityDrainRate = 1
	SWEP.BreathIntensityRegenRate = 2
	SWEP.BreathHoldVelocityMinimum = 30 -- if our velocity surpasses this, we can't hold our breath
	SWEP.BreathDelay = 0.8
	SWEP.BreathRegenDelay = 0.5
	SWEP.MinimumBreathPercentage = 0.5 -- we can only hold our breath if our breath meter surpasses this
	SWEP.BreathIntensityOnRest = 0.5
	SWEP.BreathIntensityOnBipod = 0.2
	SWEP.BreathIntensitySwitchRate = 2 -- speed at which it switches from regular state to resting-weapon-on-something state (resting weapon/deployed bipod)
	SWEP.ReloadBoltBonePositionRecoverySpeed = 1
	SWEP.ReloadBoltBonePositionMoveSpeed = 25
	
	SWEP.SprintViewNormals = {x = 1, y = 1, z = 1}
	
	SWEP.breathWait = 0
	SWEP.breathRegenWait = 0
	SWEP.breathReleaseWait = 0
	
	SWEP.SwayIntensity = 1
	SWEP.AimSwayIntensity = 0.6
	SWEP.HUD_3D2DScale = 0.015
	
	SWEP.PresetResults = {}
	SWEP.elementRender = {}
	
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
end

SWEP.FadeCrosshairOnAim = true
SWEP.CUSTOMIZATION_MENU_TOGGLE_WAIT = 0.2 -- the time to delay every action by when opening/closing the customization menu
SWEP.LoseAimVelocity = 1.35
SWEP.RunStateVelocity = 1.2
SWEP.ActiveAttachments = {}
SWEP._activeSequences = {}
SWEP.GlobalDelay = 0
SWEP.PresetLoadDelay = 0
SWEP.ForcedStateTime = 0
SWEP.BoltBonePositionRecoverySpeed = 40 -- how fast does the bolt bone move back into it's initial position after the weapon has fired

-- default values are 9x19MM, because we don't know what the user wants
SWEP.CaseLength = 19
SWEP.BulletDiameter = 9
SWEP.M203Chamber = true
SWEP.Grenade40MM = 0

SWEP.QuickScopeSpreadIncrease = 0.05

if SERVER then
	include("sv_hooks.lua")
	include("sv_attachments.lua")
end

SWEP.OverallMouseSens = 1
SWEP.AimMobilitySpreadMod = 3
SWEP.PenMod = 1
SWEP.AmmoPerShot = 1
SWEP.CW20Weapon = true
SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 50
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= ""
SWEP.WorldModel		= ""
SWEP.AnimPrefix		= "fist"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= -1				// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1				// Size of a clip
SWEP.Secondary.DefaultClip	= -1				// Default number of bullets in a clip
SWEP.Secondary.Automatic	= true				// Automatic/Semi Auto
SWEP.Secondary.Ammo			= "none"

SWEP.AddSpread = 0
SWEP.SpreadWait = 0
SWEP.AddSpreadSpeed = 1
SWEP.ReloadWait = 0
SWEP.ReloadSpeed = 1
SWEP.DrawSpeed = 1

SWEP.Chamberable = true
SWEP.UseHands = true
SWEP.CanPenetrate = true
SWEP.CanRicochet = true
SWEP.AddSafeMode = true
SWEP.SprintingEnabled = true
SWEP.NearWallEnabled = true
SWEP.AimingEnabled = true
SWEP.AccuracyEnabled = true
SWEP.HolsterUnderwater = true
SWEP.HolsterOnLadder = true
SWEP.HoldToAim = true
SWEP.FiremodesEnabled = true
SWEP.SuppressedOnEquip = false
SWEP.CanCustomize = true

-- bipod-related
SWEP.BipodRecoilModifier = 0.3
SWEP.BipodInstalled = false

SWEP.BurstCooldownMul = 1.75
SWEP.BurstSpreadIncMul = 0.5
SWEP.BurstRecoilMul = 0.85
SWEP.DeployTime = 1
SWEP.Shots = 1
SWEP.FromActionToNormalWait = 0
SWEP.ShotgunReloadState = 0
SWEP.ReloadSpeed = 1
SWEP.ReloadSpeed_Suppressed = 1
SWEP.FireAnimSpeed = 1
SWEP.FOVHoldTime = 0
SWEP.FOVTarget = 0
SWEP.BipodDeployTime = 0.25
SWEP.BipodUndeployTime = 0.25
SWEP.HolsterTime = 0.4
SWEP.BipodDelay = 0
SWEP.HolsterWait = 0
SWEP.recoilRestoreWait = 0
SWEP.ForcedHipWaitTime = 0.25 -- this is how much time the player will have to wait before being able to aim again after shooting with SWEP.ForceBackToHipAfterAimedShot set to true

-- height necessary to be able to deploy a bipod/rest a weapon on something
-- negative values to trace downwards
SWEP.BipodDeployHeightRequirement = -1
SWEP.WeaponRestHeightRequirement = -0.6

SWEP.RecoilToSpread = 0.5
SWEP.BusyProneVelocity = 30 -- max velocity after which we're considering the player to be crawling while prone
SWEP.ViewmodelProneVelocityMultiplier = 1

local math = math

function SWEP:CalculateEffectiveRange()
	self.EffectiveRange = self.CaseLength * 10 - self.BulletDiameter * 5 -- setup realistic base effective range
	self.EffectiveRange = self.EffectiveRange * 39.37 -- convert meters to units
	-- for the sake of authenticity and realism I decided to keep the quarter/half decrease of the effective range off
	--self.EffectiveRange = self.EffectiveRange * 0.5
	self.DamageFallOff = (100 - (self.CaseLength - self.BulletDiameter)) / 200
	self.PenStr = (self.BulletDiameter * 0.5 + self.CaseLength * 0.35) * (self.PenAdd and self.PenAdd or 1)
	self.PenetrativeRange = self.EffectiveRange * 0.5
	
	-- we need to save it once
	if not self.EffectiveRange_Orig then
		self.EffectiveRange_Orig = self.EffectiveRange
		self.DamageFallOff_Orig = self.DamageFallOff
		self.PenetrativeRange_Orig = self.PenetrativeRange
	end
end

function SWEP:getEffectiveRange()
	local EffectiveRange = self.CaseLength * 10 - self.BulletDiameter * 5 -- setup realistic base effective range
	EffectiveRange = EffectiveRange * 39.37 -- convert meters to units

	local DamageFallOff = (100 - (self.CaseLength - self.BulletDiameter)) / 200
	local PenStr = (self.BulletDiameter * 0.5 + self.CaseLength * 0.35) * (self.PenAdd and self.PenAdd or 1)
	local PenetrativeRange = EffectiveRange * 0.5
	
	return EffectiveRange, DamageFallOff, PenStr, PenetrativeRange
end

local SP = game.SinglePlayer()
local tbl, tbl2

function SWEP:IndividualInitialize()
end

local validPlayerProneFunction = function(self)
	return self.Owner:IsProne()
end

local invalidPlayerProneFunction = function(self)
	return false
end

local validPlayerBusyProneFunction = function(self)
	return self.Owner:ProneIsGettingUp() or self.Owner:ProneIsGettingDown()
end

local invalidPlayerBusyProneFunction = function(self)
	return false
end

function SWEP:Initialize()
	self:SetHoldType(self.NormalHoldType)
	self:setupBallisticsInformation()
	self:CalculateEffectiveRange()
	self.CHoldType = self.NormalHoldType
	
	if CLIENT then
		if not self.ScopeRT then
			local base = weapons.GetStored("cw_base") -- we only need to init the render target on the base
			base:initRenderTarget(CustomizableWeaponry:getRenderTargetSize(GetConVarNumber("cw_rt_scope_quality")))
			self.ScopeRT = base.ScopeRT
		end
	end
	
	-- a global that will surely never be misnamed
	if PRONE_GETTINGDOWN then -- we check whether prone mod exists this way, and then assign a valid prone check function to avoid a ton of ifs
		self.isPlayerProne = validPlayerProneFunction
		self.isPlayerEnteringProne = validPlayerBusyProneFunction
	else
		self.isPlayerProne = invalidPlayerProneFunction
		self.isPlayerEnteringProne = invalidPlayerBusyProneFunction
	end
	
	if not self.HoldToAim then
		self.Secondary.Automatic = false
	end
	
	if self.AddSafeMode then
		table.insert(self.FireModes, #self.FireModes + 1, "safe")
	end
	
	t = self.FireModes[1]
	self.FireMode = t
	t = CustomizableWeaponry.firemodes.registeredByID[t]
	
	self.Primary.Auto = t.auto
	self.BurstAmount = t.burstamt
	
	self.CurCone = self.HipSpread
	
	-- set up original weapon stats
	CustomizableWeaponry.originalValue.assign(self)
	
	self.Primary.ClipSize_Orig = self.Primary.ClipSize
	self.Primary.ClipSize_ORIG_REAL = self.Primary.ClipSize -- this is the 'real' real original mag size, it is necessary for mag-size changing attachments
	
	if self.MuzzleVelocity then -- ENTER ONLY IN METER/S
		self.MuzzleVelocityConverted = self.MuzzleVelocity * 39.37
	end
	
	if self.FireSound then
		self.FireSound = Sound(CustomizableWeaponry:findFireSound(self.FireSound))
		self.FireSound_Orig = self.FireSound
	end
	
	if self.FireSoundSuppressed then
		self.FireSoundSuppressed = Sound(CustomizableWeaponry:findFireSound(self.FireSoundSuppressed))
		self.FireSoundSuppressed_Orig = self.FireSoundSuppressed
	end

	if CLIENT then
		self.RunTime = 0
		self.shouldUpdateAngles = true
		self.lastEyeAngle = EyeAngles()
		self.CurVMFOV = self.ViewModelFOV
		self.ViewModelFOV_Orig = self.ViewModelFOV
		self.ZoomAmount_Orig = self.ZoomAmount
		self.AimViewModelFOV = self.AimViewModelFOV and self.AimViewModelFOV or self.ViewModelFOV
		self.AimViewModelFOV_Orig = self.AimViewModelFOV
		self.BulletDisplay = t.buldis
		self.FireModeDisplay = t.display
		self.OverallMouseSens_Orig = self.OverallMouseSens
		self.AimBreathingEnabled_Orig = self.AimBreathingEnabled
		
		self.AimPos = self.IronsightPos
		self.AimAng = self.IronsightAng
		
		self.AimPos_Orig = self.AimPos
		self.AimAng_Orig = self.AimAng
		
		if self.WM then
			self.WMEnt = self:createManagedCModel(self.WM, RENDERGROUP_BOTH)
			self.WMEnt:SetNoDraw(true)
		end
		
		if self.Owner and IsValid(self.Owner) then
			self.HUD_LastHealth = self.Owner:Health()
			self.HUD_LastArmor = self.Owner:Armor()
		else
			self.HUD_LastHealth = 0
			self.HUD_LastArmor = 0
		end
		
		for k, v in pairs(self.Attachments) do
			v.keyText = type(k) == "number" and "[" .. k .. "] " or self:getKeyBind(k) .. " "
		end
		
		self._shellTable = CustomizableWeaponry.shells:getShell(self.Shell)
		self:createCustomVM(self.ViewModel)
		self:createGrenadeModel()
		self:setupAttachmentModels()
		self:setupBoneTable()
		self:setupReticleColors()
		self:playAnim("draw", self.DrawSpeed)
		self:setupCurrentIronsights(self.IronsightPos, self.IronsightAng)
		
		CustomizableWeaponry.cmodels:validate()
		
		CustomizableWeaponry.sightAdjustment:loadDefaultOffsets(self)
		
		self.ActualSightPos = self.IronsightPos
		self.ActualSightAng = self.IronsightAng
	end
	
	CustomizableWeaponry.callbacks.processCategory(self, "initialize")
	
	self.holsterSound = true
	self.dt.Suppressed = self.SuppressedOnEquip
	
	self:IndividualInitialize()
end

function SWEP:Equip()
	if self.equipFunc then
		self:equipFunc()
	end
end

function SWEP:unloadWeapon()
	-- remove all ammo from mag and transfer to reserve
	
	local amt = self:Clip1()
	
	self.Owner:SetAmmo(self.Owner:GetAmmoCount(self.Primary.Ammo) + amt, self.Primary.Ammo)
	self:SetClip1(0)
end

function SWEP:setBodygroup(main, sub)
	if SERVER then
		return
	end

	if self.CW_VM then
		self.CW_VM:SetBodygroup(main, sub)
	end
end

function SWEP:SetupDataTables()
	self:DTVar("Int", 0, "State")
	self:DTVar("Int", 1, "Shots")
	self:DTVar("Float", 0, "HolsterDelay")
	self:DTVar("Bool", 0, "Suppressed")
	self:DTVar("Bool", 1, "Safe")
	self:DTVar("Bool", 2, "BipodDeployed")
	self:DTVar("Bool", 3, "M203Active")
	self:DTVar("Angle", 0, "ViewOffset")
end

-- we have to do THIS fucking garbage because there is no distinction between DTVars and NWVars (look above) and therefore upon duplication of a spawned weapon object
-- it errors the fuck out because it ASSUMES that the weapon uses ONLY NWVars and calls non-existent Set<varName> functions
-- THANKS TO WHOEVER DECIDED THAT THERE SHOULD BE NO DISTINCTION BETWEEN DT AND NW VARS, IT REALLY IS SOME GOOD CODE PRACTICE RIGHT THERE
function SWEP:SetState(val)
	self.dt.State = val
end

function SWEP:SetShots(val)
	self.dt.Shots = val
end

function SWEP:SetHolsterDelay(val)
	self.dt.HolsterDelay = val
end

function SWEP:SetSuppressed(val)
	self.dt.Suppressed = val
end

function SWEP:SetSafe(val)
	self.dt.Safe = val
end

function SWEP:SetBipodDeployed(val)
	self.dt.BipodDeployed = val
end

function SWEP:SetM203Active(val)
	self.dt.M203Active = val
end

function SWEP:SetViewOffset(val)
	self.dt.ViewOffset = val
end

local vm, CT, aim, cone, vel, CT, tr
local td = {}

function SWEP:GetDeployTime()
	return self.DeployTime
end

function SWEP:Deploy()
	self.holsterSound = true
	self.dt.State = CW_IDLE
	self.dt.HolsterDelay = 0
	CT = CurTime()
	
	local deployTime = CT + self:GetDeployTime() / self.DrawSpeed

	self:SetNextSecondaryFire(deployTime)
	self:SetNextPrimaryFire(deployTime)
	self.ReloadWait = deployTime
	self.HolsterWait = deployTime
	
	if IsFirstTimePredicted() then
		if CLIENT then
			self.CurSoundTable = nil
			self.CurSoundEntry = nil
			self.SoundTime = nil
			self.SoundSpeed = 1
		end

		if self.drawAnimFunc then
			self:drawAnimFunc()
		else
			self:sendWeaponAnim("draw", self.DrawSpeed)
		end
	end
	
	if (SP and SERVER) then
		SendUserMessage("CW20_DEPLOY", self.Owner)
	end
	
	if self.dt.M203Active then
		if SERVER and SP then
			SendUserMessage("CW20_M203OFF", self.Owner)
		end
		
		if CLIENT then
			self:resetM203Anim()
		end
	end
	
	if CLIENT then
		self.lastEyeAngle = self.Owner:EyeAngles()
	end
	
	CustomizableWeaponry.callbacks.processCategory(self, "deployWeapon")
	
	self.SwitchWep = nil
	self.dt.M203Active = false
	return true
end

function SWEP:Holster(wep)
	-- can't switch if neither the weapon we want to switch to or the wep we're trying to switch to are not valid
	if not IsValid(wep) and not IsValid(self.SwitchWep) then
		self.SwitchWep = nil
		return false
	end
	
	local CT = CurTime()
	
	-- can't holster if we have a global delay on the weapon
	if CT < self.GlobalDelay or CT < self.HolsterWait then
		return false
	end
	
	if self.dt.HolsterDelay ~= 0 and CT < self.dt.HolsterDelay then
		return false
	end
	
	-- can't holster if there are sequenced actions
	if #self._activeSequences > 0 then
		return false
	end
	
	if self.ReloadDelay then
		return false
	end
	
	if self.dt.State ~= CW_HOLSTER_START then
		self.dt.HolsterDelay = CurTime() + self.HolsterTime
	end
	
	self.dt.State = CW_HOLSTER_START
	
	-- if holster sequence is over, let us select the desired weapon
	if self.SwitchWep and self.dt.State == CW_HOLSTER_START and CurTime() > self.dt.HolsterDelay then
		self.dt.State = CW_IDLE
		self.dt.HolsterDelay = 0
		
		return true
	end
	
	-- if it isn't, make preparations for it
	self.ShotgunReloadState = 0
	self.ReloadDelay = nil
	
	if self:filterPrediction() then
		if self.holsterSound then -- quick'n'dirty prediction fix
			self:EmitSound("CW_HOLSTER", 70, 100)
			self.holsterSound = false
			
			if IsFirstTimePredicted() then
				if self.holsterAnimFunc then
					self:holsterAnimFunc()
				else
					if self.Animations.holster then
						self:sendWeaponAnim("holster")
					end
				end
			end
		end
	end
	
	self.SwitchWep = wep
	self.SuppressTime = nil
	
	if self.dt.M203Active then
		if SERVER and SP then
			SendUserMessage("CW20_M203OFF", self.Owner)
		end
		
		if CLIENT then
			self:resetM203Anim()
		end
	end

	self.dt.M203Active = false
end

local mag, ammo

function SWEP:Reload()
	CT = CurTime()
	
	if self.ReloadDelay or CT < self.ReloadWait or self.dt.State == CW_ACTION or self.ShotgunReloadState != 0 then
		return
	end
	
	if CT < self.GlobalDelay then
		return
	end
	
	if self.FiremodesEnabled and self.Owner:KeyDown(IN_USE) and self.dt.State != CW_RUNNING then
		self:CycleFiremodes()
		return
	end	
	
	if self.dt.M203Active then
		if not self.M203Chamber and self.Owner:GetAmmoCount("40MM") > 0 then
			if IsFirstTimePredicted() then
				self:reloadM203()
			end
			
			self.dt.State = CW_IDLE
			return
		end
	end
	
	mag = self:Clip1()
	
	local cantReload, overrideMagCheck, overrideAmmoCheck = CustomizableWeaponry.callbacks.processCategory(self, "canReload", mag == 0)
	
	if cantReload then
		return
	end
	
	if not overrideMagCheck then
		if (self.Chamberable and mag >= self.Primary.ClipSize_Orig + 1) then
			return
		end
	end
	
	if not overrideAmmoCheck then
		if self.Owner:GetAmmoCount(self.Primary.Ammo) == 0 then
			return
		end
	end
	
	if not self.Chamberable and mag >= self.Primary.ClipSize then
		return
	end
	
	if self.dt.M203Active then
		if SERVER and SP then
			SendUserMessage("CW20_M203OFF_RELOAD", self.Owner)
		end
		
		if CLIENT then
			self:resetM203Anim()
		end
	end
	
	self.dt.State = CW_IDLE
	self.dt.M203Active = false
	
	self:beginReload()
end

function SWEP:beginReload()
	mag = self:Clip1()
	
	if self.ShotgunReload then
		local time = CT + self.ReloadStartTime / self.ReloadSpeed
		
		self.WasEmpty = mag == 0
		self.ReloadDelay = time
		self:SetNextPrimaryFire(time)
		self:SetNextSecondaryFire(time)
		self.GlobalDelay = time
		self.ShotgunReloadState = 1
		self.ForcedReloadStop = false
		
		self:sendWeaponAnim("reload_start", self.ReloadSpeed)
	else	
		local reloadTime = nil
		local reloadHalt = nil
		
		if mag == 0 then
			if self.Chamberable then
				self.Primary.ClipSize = self.Primary.ClipSize_Orig
			end
			
			reloadTime = self.ReloadTime_Empty
			reloadHalt = self.ReloadHalt_Empty
		else
			reloadTime = self.ReloadTime
			reloadHalt = self.ReloadHalt
			
			if self.Chamberable then
				self.Primary.ClipSize = self.Primary.ClipSize_Orig + 1
			end
		end
		
		reloadTime = reloadTime / self.ReloadSpeed
		reloadHalt = reloadHalt / self.ReloadSpeed
		
		self.ReloadDelay = CT + reloadTime
		self:SetNextPrimaryFire(CT + reloadHalt)
		self:SetNextSecondaryFire(CT + reloadHalt)
		self.GlobalDelay = CT + reloadHalt
				
		if self.reloadAnimFunc then
			self:reloadAnimFunc(mag)
		else
			if self.Animations.reload_empty and mag == 0 then
				self:sendWeaponAnim("reload_empty", self.ReloadSpeed)
			else
				self:sendWeaponAnim("reload", self.ReloadSpeed)
			end
		end
	end
	
	CustomizableWeaponry.callbacks.processCategory(self, "beginReload", mag == 0)
	
	self.Owner:SetAnimation(PLAYER_RELOAD)
end

function SWEP:finishReload()
	mag, ammo = self:Clip1(), self.Owner:GetAmmoCount(self.Primary.Ammo)

	if mag > 0 then
		if self.SnapToIdlePostReload then
			self:sendWeaponAnim("idle", 1, 1)
		end
	end
	
	local suppressReloadLogic = CustomizableWeaponry.callbacks.processCategory(self, "defaultReloadLogic", mag == 0)
	
	if not suppressReloadLogic then
		if self.ReloadAmount then
			if SERVER then
				self:SetClip1(math.Clamp(mag + self.ReloadAmount, 0, self.Primary.ClipSize))
				self.Owner:RemoveAmmo(self.ReloadAmount, self.Primary.Ammo)
			end
		else
			if mag > 0 then
				if ammo >= self.Primary.ClipSize - mag then
					if SERVER then
						self:SetClip1(math.Clamp(self.Primary.ClipSize, 0, self.Primary.ClipSize))
						self.Owner:RemoveAmmo(self.Primary.ClipSize - mag, self.Primary.Ammo)
					end
				else
					if SERVER then
						self:SetClip1(math.Clamp(mag + ammo, 0, self.Primary.ClipSize))
						self.Owner:RemoveAmmo(ammo, self.Primary.Ammo)
					end
				end
			else
				if ammo >= self.Primary.ClipSize then
					if SERVER then
						self:SetClip1(math.Clamp(self.Primary.ClipSize, 0, self.Primary.ClipSize))
						self.Owner:RemoveAmmo(self.Primary.ClipSize, self.Primary.Ammo)
					end
				else
					if SERVER then
						self:SetClip1(math.Clamp(ammo, 0, self.Primary.ClipSize))
						self.Owner:RemoveAmmo(ammo, self.Primary.Ammo)
					end
				end
			end
		end
	end
	
	CustomizableWeaponry.callbacks.processCategory(self, "finishReload")
	
	self.ReloadDelay = nil
end

function SWEP:CycleFiremodes()
	t = self.FireModes
	
	if not t.last then
		t.last = 2
	else
		if not t[t.last + 1] then
			t.last = 1
		else
			t.last = t.last + 1
		end
	end
	
	if self.dt.State == CW_AIMING or self:isBipodDeployed() then
		if self.FireModes[t.last] == "safe" then
			t.last = 1
		end
	end
	
	if self.FireMode != self.FireModes[t.last] and self.FireModes[t.last] then
		CT = CurTime()
		
		if IsFirstTimePredicted() then
			self:SelectFiremode(self.FireModes[t.last])
		end
		
		self:SetNextPrimaryFire(CT + 0.25)
		self:SetNextSecondaryFire(CT + 0.25)
		self.ReloadWait = CT + 0.25
	end
end

-- utility funcs

function SWEP:isAiming()
	return self.dt.State == CW_AIMING
end

function SWEP:isRunning()
	return self.dt.State == CW_RUNNING
end

function SWEP:SelectFiremode(n)
	if CLIENT then
		return
	end
	
	t = CustomizableWeaponry.firemodes.registeredByID[n]
	self.Primary.Automatic = t.auto
	self.FireMode = n
	self.BurstAmount = t.burstamt
	
	if self.FireMode == "safe" then
		self.dt.Safe = true -- more reliable than umsgs
	else
		self.dt.Safe = false
	end
	
	if SERVER then
		umsg.Start("CW_FIREMODE")
			umsg.Entity(self.Owner)
			umsg.String(n)
		umsg.End()
	end
end

local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length
local GetAimVector = reg.Player.GetAimVector

local calculateAccuracy = "calculateAccuracy"

function SWEP:getBipodHipSpread()
	return self.AimSpread * 1.2
end

function SWEP:getBaseCone()
	-- call callbacks for the aim/hip spread calculation
	local aimSpreadMod, hipSpreadMod, maxSpreadMod = CustomizableWeaponry.callbacks.processCategory(self, calculateAccuracy)
	maxSpreadMod = maxSpreadMod or 1
	local finalSpread = nil
	
	if self.dt.State == CW_AIMING then
		finalSpread = self.AimSpread * (aimSpreadMod or 1)
	else
		if self.dt.BipodDeployed then
			finalSpread = self:getBipodHipSpread() * (aimSpreadMod or 1)
		else
			finalSpread = self.HipSpread * (hipSpreadMod or 1)
		end
	end
	
	return finalSpread, maxSpreadMod
end

function SWEP:getMaxSpreadIncrease(maxSpreadMod)
	return self.MaxSpreadInc * maxSpreadMod
end

function SWEP:getCrouchSpreadModifier()
	return self.dt.State == CW_AIMING and 0.9 or 0.75
end

function SWEP:CalculateSpread(vel, dt)
	if not self.AccuracyEnabled then
		return
	end
	
	aim = GetAimVector(self.Owner)
	CT = CurTime()
	
	if not self.Owner.LastView then
		self.Owner.LastView = aim
		self.Owner.ViewAff = 0
	else
		self.Owner.ViewAff = LerpCW20(dt * 10, self.Owner.ViewAff, (aim - self.Owner.LastView):Length() * 0.5)
		self.Owner.LastView = aim
	end
	
	local baseCone, maxSpreadMod = self:getBaseCone()
	self.BaseCone = baseCone
	
	if self.Owner:Crouching() then
		self.BaseCone = self.BaseCone * self:getCrouchSpreadModifier()
	end
	
	self.CurCone = self:getFinalSpread(vel, maxSpreadMod)
	
	if CT > self.SpreadWait then
		self.AddSpread = math.Clamp(self.AddSpread - 0.5 * self.AddSpreadSpeed * dt, 0, self:getMaxSpreadIncrease(maxSpreadMod))
		self.AddSpreadSpeed = math.Clamp(self.AddSpreadSpeed + 5 * dt, 0, 1)
	end
end

local mag, ammo

local IFTP
local wl, ws

function SWEP:Think()
	-- in vehicle? can't do anything, also prevent needless calculations of stuff
	if self.Owner:InVehicle() and not self.Owner:GetAllowWeaponsInVehicle() then
		self.dt.State = CW_ACTION
		return
	end
	
	CustomizableWeaponry.actionSequence.process(self)
	
	if self.dt.State == CW_HOLSTER_START then
		return
	end
	
	CT = CurTime()
	
	if CLIENT then
		if self.SubCustomizationCycleTime then
			if UnPredictedCurTime() > self.SubCustomizationCycleTime then
				CustomizableWeaponry.cycleSubCustomization(self)
			end
		end
	end
	
	if self.HoldToAim then
		if (SP and SERVER) or not SP then
			if self.dt.State == CW_AIMING then
				if not self.Owner:OnGround() or Length(GetVelocity(self.Owner)) >= self.Owner:GetWalkSpeed() * self.LoseAimVelocity or not self.Owner:KeyDown(IN_ATTACK2) then
					self.dt.State = CW_IDLE
					self:SetNextSecondaryFire(CT + 0.2)
					self:EmitSound("CW_LOWERAIM")
				end
			end
		end
	end
	
	if self.IndividualThink then
		self:IndividualThink()
		
		if not IsValid(self) or not IsValid(self.Owner) then
			return
		end
	end
	
	vel = Length(GetVelocity(self.Owner))
	IFTP = IsFirstTimePredicted()
	
	if (not SP and IFTP) or SP then
		self:CalculateSpread(vel, FrameTime())
	end
	
	if CT > self.GlobalDelay then
		wl = self.Owner:WaterLevel()

		if self.Owner:OnGround() then
			-- prone mod compatibility starts
			if self:isPlayerEnteringProne() then
				self.dt.State = CW_PRONE_BUSY
			elseif self:isPlayerProne() and vel >= self.BusyProneVelocity and not self.ShootWhileProne then
				self.dt.State = CW_PRONE_MOVING
			else
				-- prone mod compatibility ends
				if wl >= 3 and self.HolsterUnderwater then
					if self.ShotgunReloadState == 1 then
						self.ShotgunReloadState = 2
					end
					
					self.dt.State = CW_ACTION
					self.FromActionToNormalWait = CT + 0.3
				else
					ws = self.Owner:GetWalkSpeed()
					
					if ((vel > ws * self.RunStateVelocity and self.Owner:KeyDown(IN_SPEED)) or vel > ws * 3 or (self.ForceRunStateVelocity and vel > self.ForceRunStateVelocity)) and self.SprintingEnabled then
						self.dt.State = CW_RUNNING
					else
						if self.dt.State != CW_AIMING and self.dt.State != CW_CUSTOMIZE then
							if CT > self.FromActionToNormalWait then
								if self.dt.State != CW_IDLE then
									self.dt.State = CW_IDLE
									
									if not self.ReloadDelay then
										self:SetNextPrimaryFire(CT + 0.3)
										self:SetNextSecondaryFire(CT + 0.3)
										self.ReloadWait = CT + 0.3
									end
								end
							end
						end
					end
				end
			end
		else
			if (wl > 1 and self.HolsterUnderwater) or (self.Owner:GetMoveType() == MOVETYPE_LADDER and self.HolsterOnLadder) then
				if self.ShotgunReloadState == 1 then
					self.ShotgunReloadState = 2
				end
				
				self.dt.State = CW_ACTION
				self.FromActionToNormalWait = CT + 0.3
			else
				if CT > self.FromActionToNormalWait then
					if self.dt.State != CW_IDLE then
						self.dt.State = CW_IDLE
						self:SetNextPrimaryFire(CT + 0.3)
						self:SetNextSecondaryFire(CT + 0.3)
						self.ReloadWait = CT + 0.3
					end
				end
			end
		end
	end
	
	if SERVER then
		if self.CurSoundTable then
			local t = self.CurSoundTable[self.CurSoundEntry]
			
			--[[if CLIENT then
				if CT >= self.SoundTime + t.time / self.SoundSpeed then
					self:EmitSound(t.sound, 70, 100)
					if self.CurSoundTable[self.CurSoundEntry + 1] then
						self.CurSoundEntry = self.CurSoundEntry + 1
					else
						self.CurSoundTable = nil
						self.CurSoundEntry = nil
						self.SoundTime = nil
					end
				end
			else]]--
			if CT >= self.SoundTime + t.time / self.SoundSpeed then
				if t.sound and t.sound ~= "" then
					self:EmitSound(t.sound, 70, 100)
				end
				
				if t.callback then
					t.callback(self)
				end
				
				if self.CurSoundTable[self.CurSoundEntry + 1] then
					self.CurSoundEntry = self.CurSoundEntry + 1
				else
					self.CurSoundTable = nil
					self.CurSoundEntry = nil
					self.SoundTime = nil
				end
			end
			--end
		end
	end
	
	if self.dt.Shots > 0 then
		if not self.Owner:KeyDown(IN_ATTACK) then
			if self.BurstAmount and self.BurstAmount > 0 then
				self.dt.Shots = 0
				self:SetNextPrimaryFire(CT + self.FireDelay * self.BurstCooldownMul)
				self.ReloadWait = CT + self.FireDelay * self.BurstCooldownMul
			end
		end
	end
	
	if not self.ShotgunReload then
		if self.ReloadDelay and CT >= self.ReloadDelay then
			self:finishReload() -- more like finnishReload ;0
		end
	end
	
	if IFTP then
	--[[SWEP.AimBreathingIntensity = 1
	SWEP.CurBreatheIntensity = 1
	SWEP.BreathLeft = 1
	SWEP.BreathRegenRate = 10
	SWEP.BreathDrainRate = 5
	SWEP.BreathIntensityDrainRate = 10
	SWEP.BreathIntensityRegenRate = 10]]--
		
		if self.ShotgunReloadState == 1 then
			if self.Owner:KeyPressed(IN_ATTACK) and self:Clip1() ~= 0 then
				self.ShotgunReloadState = 2
				self.ForcedReloadStop = true
			end
			
			if CT > self.ReloadDelay then
				self:sendWeaponAnim("insert", self.ReloadSpeed)
				
				if SERVER and not SP then
					self.Owner:SetAnimation(PLAYER_RELOAD)
				end
				
				mag, ammo = self:Clip1(), self.Owner:GetAmmoCount(self.Primary.Ammo)
				
				if SERVER then
					self:SetClip1(mag + 1)
					self.Owner:SetAmmo(ammo - 1, self.Primary.Ammo)
				end
				
				self.ReloadDelay = CT + self.InsertShellTime / self.ReloadSpeed
				
				local maxReloadAmount = self.Primary.ClipSize 
				
				if self.Chamberable and not self.WasEmpty then  -- if the weapon is chamberable + we've cocked it - we can add another shell in there
					maxReloadAmount = self.Primary.ClipSize + 1
				end
				
				-- if we've filled up the weapon (or we have no ammo left), we go to the "end reload" state
				if mag + 1 == maxReloadAmount or ammo - 1 == 0 then
					self.ShotgunReloadState = 2
				end
			end
		elseif self.ShotgunReloadState == 2 then
			if self.Owner:KeyPressed(IN_ATTACK) then
				self.ShotgunReloadState = 2
				self.ForcedReloadStop = true
			end
			
			if CT > self.ReloadDelay then
				if not self.WasEmpty then
					self:sendWeaponAnim("idle", self.ReloadSpeed)
					self.ShotgunReloadState = 0
					
					local time = 0.25 / self.ReloadSpeed
					self:SetNextPrimaryFire(time)
					self:SetNextSecondaryFire(time)
					self.ReloadWait = time
					self.ReloadDelay = nil
				else
					local canInsertMore = false
					local waitTime = self.ReloadFinishWait
					
					if not self.ForcedReloadStop and self.Chamberable and self:Clip1() < self.Primary.ClipSize + 1 and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
						waitTime = self.PumpMidReloadWait or waitTime
						canInsertMore = true
					end
					
					self:sendWeaponAnim("reload_end", self.ReloadSpeed)
					self.ShotgunReloadState = 0
					
					local time = CT + waitTime / self.ReloadSpeed
					self:SetNextPrimaryFire(time)
					self:SetNextSecondaryFire(time)
					self.ReloadWait = time
					
					if not canInsertMore then
						self.ReloadDelay = nil
					else
						self.ReloadDelay = time
					end
					
					if canInsertMore then -- if we can chamber and we haven't chambered up fully + we have some ammo to spare
						self.ShotgunReloadState = 1 -- we add another shell in there
						self.WasEmpty = false
					
					end
				end
			end
		end
	end
	
	if SERVER then
		if self.dt.Safe then
			if self.CHoldType != self.RunHoldType then
				self:SetHoldType(self.RunHoldType)
				self.CHoldType = self.RunHoldType
			end
		else
			if self.dt.State == CW_RUNNING or self.dt.State == CW_ACTION then
				if self.CHoldType != self.RunHoldType then
					self:SetHoldType(self.RunHoldType)
					self.CHoldType = self.RunHoldType
				end
			else
				if self.CHoldType != self.NormalHoldType then
					self:SetHoldType(self.NormalHoldType)
					self.CHoldType = self.NormalHoldType
				end
			end
		end
	end
	
	if (SP and SERVER) or not SP then -- if it's SP, then we run it only on the server (otherwise shit gets fucked); if it's MP we predict it
		-- if the bipod DT var is true, or if we have a bipod deploy angle
		if self.dt.BipodDeployed or self.DeployAngle then
			-- check whether the bipod can be placed on the current surface (so we don't end up placing on nothing)
			
			if not self:CanRestWeapon(self.BipodDeployHeightRequirement) then
				self.dt.BipodDeployed = false
				self.DeployAngle = nil

				if not self.ReloadDelay then
					if CT > self.BipodDelay then
						self:performBipodDelay(self.BipodUndeployTime)
					else
						self.BipodUnDeployPost = true
					end
				else
					self.BipodUnDeployPost = true
				end
			end
		end
			
		if not self.ReloadDelay then
			if self.BipodUnDeployPost then
				if CT > self.BipodDelay then
					if not self:CanRestWeapon(self.BipodDeployHeightRequirement) then
						self:performBipodDelay(self.BipodUndeployTime)
						self.BipodUnDeployPost = false
					else
						self.dt.BipodDeployed = true
						
						self:setupBipodVars()
						self.BipodUnDeployPost = false
					end
				end
			end
			
			if self.Owner:KeyPressed(IN_USE) then
				if CT > self.BipodDelay and CT > self.ReloadWait then
					if self.BipodInstalled then
						if self.dt.BipodDeployed then
							self.dt.BipodDeployed = false
							self.DeployAngle = nil

							self:performBipodDelay(self.BipodUndeployTime)
						else
							self.dt.BipodDeployed = self:CanRestWeapon(self.BipodDeployHeightRequirement)
							
							if self.dt.BipodDeployed then
								self:performBipodDelay(self.BipodDeployTime)
								self:setupBipodVars()
							end
						end
					end
				end
			end
		end
	end
	
	if self.forcedState then
		if CT < self.ForcedStateTime then
			self.dt.State = self.forcedState
		else
			self.forcedState = nil
		end
	end
end

function SWEP:simulateRecoil()
	if self.dt.State == CW_AIMING or self.dt.BipodDeployed then
		self.FireMove = math.Clamp(self.Recoil * self.FireMoveMod, 1, 3)
	else
		self.FireMove = 0.4
	end
	
	if self.dt.State ~= CW_AIMING and not self.freeAimOn then
		self.FOVHoldTime = UnPredictedCurTime() + self.FireDelay * 2
		
		if self.HipFireFOVIncrease then
			self.FOVTarget = math.Clamp(self.FOVTarget + 8 / (self.Primary.ClipSize_Orig * 0.75) * self.FOVPerShot, 0, 7)
		end
	end
	
	if self.freeAimOn and not self.dt.BipodDeployed then -- we only want to add the 'roll' view shake when we're not using a bipod in free-aim mode
		self.lastViewRoll = math.Clamp(self.lastViewRoll + self.Recoil * 0.5, 0, 15)
		self.lastViewRollTime = UnPredictedCurTime() + FrameTime() * 3
	end
	
	self.lastShotTime = CurTime() + math.Clamp(self.FireDelay * 3, 0, 0.3) -- save the last time we shot
	
	if self.BoltBone then
		self:offsetBoltBone()
	end
	
	if self.LuaViewmodelRecoil then
		if (self.dt.State ~= CW_AIMING and not self.FullAimViewmodelRecoil) or self.FullAimViewmodelRecoil then
			-- increase intensity of the viewmodel recoil with each shot
			self.LuaVMRecoilIntensity = math.Approach(self.LuaVMRecoilIntensity, 1, self.Recoil * 0.15)
			self.LuaVMRecoilLowerSpeed = 0
			
			if not self.dt.BipodDeployed then
				self:makeVMRecoil()
			end
		end
	end
	
	if self.ReticleInactivityPostFire then
		self.reticleInactivity = UnPredictedCurTime() + self.ReticleInactivityPostFire
	end
end

function SWEP:addFireSpread(CT)
	self.SpreadWait = CT + self.SpreadCooldown
	local mul, mulMax = self:getSpreadModifiers()
	
	if self.BurstAmount > 0 then
		self.AddSpread = math.Clamp(self.AddSpread + self.SpreadPerShot * self.BurstSpreadIncMul * mul, 0, self.MaxSpreadInc * mulMax)
	else
		self.AddSpread = math.Clamp(self.AddSpread + self.SpreadPerShot * mul, 0, self.MaxSpreadInc * mulMax)
	end
	
	-- decrease spread restore speed per each shot
	self.AddSpreadSpeed = math.Clamp(self.AddSpreadSpeed - 0.2, 0, 1)
end

function SWEP:playFireAnim()
	if (self.dt.State == CW_AIMING and not self.ADSFireAnim) or (self.dt.BipodDeployed and not self.BipodFireAnim) then
		return
	end
	
	if self.dt.State ~= CW_AIMING and (not self.LuaViewmodelRecoilOverride and self.LuaViewmodelRecoil) then
		return
	end
	
	if self:Clip1() - self.AmmoPerShot <= 0 and self.Animations.fire_dry then
		self:sendWeaponAnim("fire_dry")
	else
		self:sendWeaponAnim("fire", self.FireAnimSpeed)
	end
end

function SWEP:getFireSound()
	return self.dt.Suppressed and self.FireSoundSuppressed or self.FireSound
end

function SWEP:getFireParticles()
	return self.dt.Suppressed and self.MuzzleEffectSupp or self.MuzzleEffect
end

local mul

function SWEP:canFireWeapon(checkType)
	if checkType == 1 then
		if self.ShotgunReloadState != 0 then
			return
		end
		
		if self.ReloadDelay then
			return
		end
		
		local preFireResult = CustomizableWeaponry.callbacks.processCategory(self, "preFire")
		
		if preFireResult then
			return
		end
	elseif checkType == 2 then
		if CurTime() < self.GlobalDelay then
			return false
		end
	elseif checkType == 3 then
		if self:isNearWall() then
			return
		end
		
		if self.InactiveWeaponStates[self.dt.State] then
			return
		end
	
	end
	
	return true
end

function SWEP:postPrimaryAttack()
	
end

function SWEP:PrimaryAttack()
	if not self:canFireWeapon(1) then
		return
	end
	
	if self.Owner:KeyDown(IN_USE) then
		if CustomizableWeaponry.quickGrenade.canThrow(self) then
			CustomizableWeaponry.quickGrenade.throw(self)
			return
		end
	end
	
	if self.dt.State == CW_AIMING and self.dt.M203Active then
		if self.M203Chamber then
			self:fireM203(IsFirstTimePredicted())
	
			return
		end
	end
	
	if not self:canFireWeapon(2) then
		return
	end
	
	if self.dt.Safe then
		self:CycleFiremodes()
		return
	end
	
	if not self:canFireWeapon(3) then
		return
	end
	
	mag = self:Clip1()
	CT = CurTime()
	
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
	
	if IsFirstTimePredicted() then
		local muzzleData = EffectData()
		muzzleData:SetEntity(self)
		util.Effect("cw_muzzleflash", muzzleData)
		
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
		
		self:FireBullet(self.Damage, self.CurCone, self.ClumpSpread, self.Shots)
		self:makeFireEffects()
		
		if CLIENT then
			self:simulateRecoil()
		end
		
		self:addFireSpread(CT)
		
		if SP and SERVER then
			SendUserMessage("CW_Recoil", self.Owner)
		end
		
		-- apply a global delay after shooting, if there is one
		if self.GlobalDelayOnShoot then
			self.GlobalDelay = CT + self.GlobalDelayOnShoot
		end
	end
	
	self:MakeRecoil()
	
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
	
	self:postPrimaryAttack()
	CustomizableWeaponry.callbacks.processCategory(self, "postConsumeAmmo")
	
	if SP and SERVER then
		SendUserMessage("CW_PostFire", self.Owner)
	end
end

function SWEP:fireM203(firstTimePrediction)
	if SERVER and SP then
		SendUserMessage("CW20_FIREM203", self.Owner)
	end
	
	CustomizableWeaponry.grenadeTypes.selectFireFunc(self, IsFirstTimePredicted())
	
	self.Owner:ViewPunch(Angle(math.Rand(-5, -4), math.Rand(-2, 2), math.Rand(-1, 1)))
	
	self.M203Chamber = false
	
	if CLIENT then
		self:makeVMRecoil(5)
		
		--local vm = self.AttachmentModelsVM.md_m203.ent
		--ParticleEffectAttach("muzzleflash_m79", PATTACH_POINT_FOLLOW, vm, vm:LookupAttachment("1"))
	end
	
	self:delayEverything(0.4)
	self:setGlobalDelay(0.4)
end

function SWEP:reloadM203()
	if SERVER and SP then
		SendUserMessage("CW20_RELOADM203", self.Owner)
	end
	
	if self:filterPrediction() then
		self:setCurSoundTable(self.M203ReloadSounds, 1, 0)
	end
	
	if CLIENT then
		self:setM203Anim(self.M203Anims.reload)
	end
	
	self:setGlobalDelay(2.6)
	
	CustomizableWeaponry.actionSequence.new(self, 2, nil, function()
		if SERVER then
			self.Owner:RemoveAmmo(1, "40MM")
		end
		
		self.M203Chamber = true
	end)
end

function SWEP:makeFireEffects()
	if SP and SERVER then
		-- god damn prediction disabled in SP
		SendUserMessage("CW20_EFFECTS")
		return
	end
	
	if CLIENT then
		if self.MuzzleEffect then
			self:CreateMuzzle()
		end
		
		if self.Shell then
			self:CreateShell()
		end
	end
end

local ang

function SWEP:GetRecoilModifier(mod)
	mod = mod and mod or 1
	
	if self.Owner:Crouching() then
		mod = mod * 0.75
	end
	
	if self.dt.State == CW_AIMING then
		mod = mod * 0.85
	end
	
	if self.dt.Suppressed then
		mod = mod * 0.85
	end
	
	if self:isPlayerProne() then
		mod = mod * 0.65
	end
	
	-- increase recoil by 20% if we're in M203 mode
	if self.dt.M203Active then
		mod = mod * 1.2
	end
	
	if self.dt.BipodDeployed then
		mod = mod * self.BipodRecoilModifier
	else
		-- if we don't have a bipod deployed, but we can rest our weapon on a surface, reduce recoil by a bit
		if self.dt.State == CW_AIMING then
			if self.CanRestOnObjects then
				if self:CanRestWeapon(self.WeaponRestHeightRequirement) then
					mod = mod * 0.85
				end
			end
		end
		
		if self.freeAimOn then -- compensate for the lack of ViewPunch by increasing the recoil modifier by 50%
			mod = mod * 1.5
		end
	end
	
	-- multiply recoil in case we have a burst fire firemode enabled
	if self.BurstAmount > 0 then
		mod = mod * self.BurstRecoilMul
	end
	
	-- pass the recoil to possible callbacks
	local finalMod = CustomizableWeaponry.callbacks.processCategory(self, "calculateRecoil", mod)
	
	mod = finalMod or mod
	
	-- increase recoil as weapon spread increases
	mod = mod * 1 + (self.AddSpread / self.MaxSpreadInc) * self.RecoilToSpread
	
	return mod
end

function SWEP:isFreeAimOn()
	if self.NoFreeAim then
		return false
	end
	
	local result = CustomizableWeaponry.callbacks.processCategory(self, "forceFreeAim")

	if result or self.Owner:GetInfoNum("cw_freeaim", 0) > 0 then
		return true
	end
	
	return false
end

function SWEP:MakeRecoil(mod)
	local mod = self:GetRecoilModifier(mod)
	local IFTP = IsFirstTimePredicted()
	
	if (SP and SERVER) or (not SP and CLIENT and IFTP) then
		ang = self.Owner:EyeAngles()
		ang.p = ang.p - self.Recoil * 0.5 * mod
		ang.y = ang.y + math.Rand(-1, 1) * self.Recoil * 0.5 * mod
	
		self.Owner:SetEyeAngles(ang)
	end

	local freeAimOn = self:isFreeAimOn()
	
	if not freeAimOn or (freeAimOn and self.dt.BipodDeployed) then
		self.Owner:ViewPunch(Angle(-self.Recoil * 1.25 * mod, 0, 0))
	end
	
	if CLIENT and IFTP then
		if self.AimBreathingEnabled then
			if self.holdingBreath then
				self:reduceBreathAmount(mod)
			else
				self:reduceBreathAmount(0)
			end
		end
	end
end

function SWEP:SecondaryAttack()
	if self.ShotgunReloadState != 0 then
		return
	end
	
	if self.ReloadDelay then
		return
	end
	
	if CurTime() < self.GlobalDelay then
		return false
	end
	
	if self.dt.Safe then
		self:CycleFiremodes()
		return
	end
	
	if self.InactiveWeaponStates[self.dt.State] or (self.dt.State == CW_AIMING and self.HoldToAim) then
		return
	end
	
	if self:isNearWall() then
		return
	end
	
	local IFTP = IsFirstTimePredicted()
	
	if self.Owner:KeyDown(IN_USE) then
		if self.ActiveAttachments.md_m203 then
			if self.ToggleM203States[self.dt.State] then
				if self.dt.M203Active then
					self.dt.M203Active = false
					
					if CLIENT and IFTP then
						self:disableM203(IFTP)
					end
					if SERVER and SP then
						SendUserMessage("CW20_M203OFF", self.Owner)
					end
				else
					self.dt.M203Active = true
					
					if IFTP then
						if CLIENT then
							self:enableM203()
						end
					end
					
					if SERVER and SP then
						SendUserMessage("CW20_M203ON", self.Owner)
					end
				end
				
				self:delayEverything(0.4)
				
				return
			end
		end
	end
	
	if not self.Owner:OnGround() or Length(GetVelocity(self.Owner)) >= self.Owner:GetWalkSpeed() * self.RunStateVelocity then
		return
	end
	
	CT = CurTime()
	
	if self.dt.State ~= CW_AIMING then
		self.dt.State = CW_AIMING
		
		if self:filterPrediction() then
			self:EmitSound("CW_TAKEAIM")
		end
	else
		self.dt.State = CW_IDLE
		
		if self:filterPrediction() then
			self:EmitSound("CW_LOWERAIM")
		end
	end
	
	if IFTP then
		self.AimTime = UnPredictedCurTime() + 0.25
		
		if self.PreventQuickScoping then
			self.AddSpread = math.Clamp(self.AddSpread + self.QuickScopeSpreadIncrease, 0, self.MaxSpreadInc)
			self.SpreadWait = CT + 0.3
		end
	end
	
	if SP and SERVER then
		SendUserMessage("CW_AimTime", self.Owner)
	end
	
	self:SetNextSecondaryFire(CT + 0.1)
end

function SWEP:enableM203()
	self:resetM203Anim()
	self:setM203Anim(self.M203Anims.idle_to_ready, 0.1)
	self:offsetM203ArmBone(false) -- move the arm bone away
end

function SWEP:disableM203(firstTimePrediction)
	self:resetM203Anim()
	self:offsetM203ArmBone(true) -- restore it

	if firstTimePrediction then
		self.M203Time = UnPredictedCurTime() + 0.25
	end
end

function SWEP:DoImpactEffect(traceData, damageType)
	local shouldSuppress, realm = CustomizableWeaponry.callbacks.processCategory(self, "suppressDefaultImpactEffect")
	
	if shouldSuppress then
		if CLIENT and realm == CLIENT then
			return true
		elseif SERVER and realm == SERVER then
			return true
		end
	end
end

if CLIENT then
	local EP, EA2, FT
	
	function SWEP:ViewModelDrawn()
		EP, EA2, FT = EyePos(), EyeAngles(), FrameTime()
		
		if IsValid(self.Hands) then
			self.Hands:SetRenderOrigin(EP)
			self.Hands:SetRenderAngles(EA2)
			self.Hands:FrameAdvance(FT)
			self.Hands:SetupBones()
			self.Hands:SetParent(self.Owner:GetViewModel())
			self.Hands:DrawModel()
		end
	end
	
	local wm, pos, ang
	local GetBonePosition = debug.getregistry().Entity.GetBonePosition
	
	local ply, wep
	
	local function GetRecoil()
		ply = LocalPlayer()
		
		if not ply:Alive() then
			return
		end
		
		wep = ply:GetActiveWeapon()
		
		if IsValid(wep) and wep.CW20Weapon then
			CT = CurTime()
			wep.SpreadWait = CT + wep.SpreadCooldown
			
			wep:MakeRecoil()
			wep:simulateRecoil()
			wep:addFireSpread(CT)
		end
	end
	
	usermessage.Hook("CW_Recoil", GetRecoil)
	
	local function PostFire()
		ply = LocalPlayer()
		
		if not ply:Alive() then
			return
		end
		
		wep = ply:GetActiveWeapon()
		
		if IsValid(wep) and wep.CW20Weapon then
			wep:postPrimaryAttack()
		end
	end
	
	usermessage.Hook("CW_PostFire", PostFire)
	
	local function AimTime()
		ply = LocalPlayer()
		
		if not ply:Alive() then
			return
		end
		
		wep = ply:GetActiveWeapon()
		
		if IsValid(wep) and wep.CW20Weapon then
			wep.AimTime = UnPredictedCurTime() + 0.25
			
			if wep.PreventQuickScoping then
				wep.AddSpread = math.Clamp(wep.AddSpread + wep.QuickScopeSpreadIncrease, 0, wep.MaxSpreadInc)
				wep.SpreadWait = CurTime() + 0.3
			end
		end
	end
	
	usermessage.Hook("CW_AimTime", AimTime)

	local function CW_ReceiveFireMode(um)
		ply = um:ReadEntity()
		Mode = um:ReadString()
		
		if IsValid(ply) then
			wep = ply:GetActiveWeapon()
			wep.FireMode = Mode
			
			if IsValid(ply) and IsValid(wep) and wep.CW20Weapon then
				if CustomizableWeaponry.firemodes.registeredByID[Mode] then
					t = CustomizableWeaponry.firemodes.registeredByID[Mode]
					
					wep.Primary.Automatic = t.auto
					wep.BurstAmount = t.burstamt
					wep.FireModeDisplay = t.display
					wep.BulletDisplay = t.buldis
					wep.CheckTime = CurTime() + 2
					
					if ply == LocalPlayer() then
						ply:EmitSound("weapons/smg1/switch_single.wav", 70, math.random(92, 112))
					end
				end
			end
		end
	end

	usermessage.Hook("CW_FIREMODE", CW_ReceiveFireMode)
end