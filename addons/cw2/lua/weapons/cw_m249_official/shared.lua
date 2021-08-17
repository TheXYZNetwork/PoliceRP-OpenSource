-- decided to give it an "_official" suffix because there may be a lot more m249s out there

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.PrintName = "M249"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	SWEP.CustomizationMenuScale = 0.015
	
	SWEP.IconLetter = "i"
	killicon.AddFont("cw_m249_official", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0.8
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.93
	SWEP.FireMoveMod = 0.6
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/cw2_0_mach_para.mdl"
	SWEP.WMPos = Vector(-1.5, 2, 0.5)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.IronsightPos = Vector(-2.05, -1.964, 0.972)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.05, -0.993, -0.093)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-2.043, -2.5, 0.115)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.043, -0.993, 0.236)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-2.02, -2.869, -0.124)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-2.02, -2.869, 0.123)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.02, -2.869, -1.132), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = true
	SWEP.ACOGAxisAlign = {right = 0.03, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.AlternativePos = Vector(-0.2, 0, -0.4)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "LidCont", pos = Vector(-0.427, -8.511, -4.505), angle = Angle(0, 0, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "LidCont", pos = Vector(0.079, -13.825, -10.714), angle = Angle(3.329, -90, 0), size = Vector(1, 1, 1)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "Weapon", pos = Vector(0.014, 3.732, 1.504), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "LidCont", pos = Vector(-0.51, -8.903, -4.573), angle = Angle(0, 0, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "LidCont", pos = Vector(-0.181, -4.047, 0.69), angle = Angle(0, 180, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_bipod"] = {model = "models/wystan/attachments/bipod.mdl", bone = "Weapon", pos = Vector(0.138, 6.619, 0.601), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699), bodygroup = {[1] = 1}},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "LidCont", pos = Vector(-0.515, -9.205, -4.549), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Weapon", pos = Vector(10.583, 5.614, -0.951), angle = Angle(0, -90, 0), size = Vector(0.699, 0.699, 0.699)}
	}

	SWEP.ForeGripHoldPos = {
		["L Finger1"] = {pos = Vector(0, 0, 0), angle = Angle(13.88, 90.466, 18.638) },
		["l_upperarm"] = {pos = Vector(0, 0, 0), angle = Angle(18.875, 0, 0) },
		["L Finger12"] = {pos = Vector(0, 0, 0), angle = Angle(0, 28.931, 0) },
		["L Clavicle"] = {pos = Vector(0, 4.344, 0), angle = Angle(-49.645, 0, -11.665) },
		["L Hand"] = {pos = Vector(0, 0, 0), angle = Angle(16.122, 18.378, 43.624) },
		["L Finger3"] = {pos = Vector(0, 0, 0), angle = Angle(0.972, 44.411, 13.453) },
		["L Finger01"] = {pos = Vector(0, 0, 0), angle = Angle(0, 26.996, 0) },
		["L Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(11.201, -6.533, -19.001) },
		["L Finger42"] = {pos = Vector(0, 0, 0), angle = Angle(0, 78.379, 0) },
		["L UpperArm"] = {pos = Vector(-12.985, -0.987, -0.308), angle = Angle(0, 31.971, 6.557) },
		["L Finger22"] = {pos = Vector(0, 0, 0), angle = Angle(0, 43.025, 0) },
		["L Finger41"] = {pos = Vector(0, 0, 0), angle = Angle(0, -20.861, 0) },
		["L Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(0, 73.864, 0) },
		["L Finger4"] = {pos = Vector(0, 0, 0), angle = Angle(-8.929, 26.59, 0) },
		["L Finger32"] = {pos = Vector(0, 0, 0), angle = Angle(0, 53.505, 0) },
		["L Finger2"] = {pos = Vector(0, 0, 0), angle = Angle(3, 69.235, 21.884) },
		["L Finger21"] = {pos = Vector(0, 0, 0), angle = Angle(0, -20.979, 0) },
		["L Finger11"] = {pos = Vector(0, 0, 0), angle = Angle(0, -19.306, 0) }
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 1, pitch = 1}
	
	SWEP.LaserPosAdjust = Vector(0.5, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0) 
	
	SWEP.OverallMouseSens = 0.7
	
	SWEP.Trivia = {text = "Accurate aimed fire is not possible without the use of a bipod with this weapon.", x = -500, y = -360, textFormatFunc = function(self, wep) if wep.ActiveAttachments.md_bipod then return "" else return self.text end end}
end

SWEP.MuzzleVelocity = 915

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", offset = {-500, -300}, atts = {"md_saker"}},
	[3] = {header = "Handguard", offset = {-500, 100}, atts = {"md_foregrip", "md_bipod"}},
	["+reload"] = {header = "Ammo", offset = {800, 300}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	reload_empty = "reload2",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0.1, sound = "CW_FOLEY_LIGHT"},
	{time = 0.65, sound = "CW_M249_OFFICIAL_BOLTBACK"},
	{time = 0.82, sound = "CW_M249_OFFICIAL_BOLTRELEASE"}},

	reload = {{time = 0.2, sound = "CW_FOLEY_LIGHT"},
	{time = 0.85, sound = "CW_M249_OFFICIAL_COVEROPEN"},
	{time = 1.8, sound = "CW_M249_OFFICIAL_MAGOUT"},
	{time = 2.1, sound = "CW_FOLEY_LIGHT"},
	{time = 2.62, sound = "CW_M249_OFFICIAL_MAGDRAW"},
	{time = 4, sound = "CW_M249_OFFICIAL_MAGIN"},
	{time = 4.2, sound = "CW_FOLEY_LIGHT"},
	{time = 4.65, sound = "CW_M249_OFFICIAL_BULLETIN"},
	{time = 5.2, sound = "CW_FOLEY_LIGHT"},
	{time = 5.9, sound = "CW_M249_OFFICIAL_COVERCLOSE"},
	{time = 6.7, sound = "CW_FOLEY_LIGHT"}},
	
	reload2 = {{time = 0.2, sound = "CW_FOLEY_LIGHT"},
	{time = 0.8, sound = "CW_M249_OFFICIAL_BOLTBACK"},
	{time = 1, sound = "CW_M249_OFFICIAL_BOLTRELEASE"},
	{time = 2.53, sound = "CW_M249_OFFICIAL_COVEROPEN"},
	{time = 3.58, sound = "CW_M249_OFFICIAL_MAGOUT"},
	{time = 3.9, sound = "CW_FOLEY_LIGHT"},
	{time = 4.3, sound = "CW_M249_OFFICIAL_MAGDRAW"},
	{time = 5.9, sound = "CW_M249_OFFICIAL_MAGIN"},
	{time = 6.2, sound = "CW_FOLEY_LIGHT"},
	{time = 6.52, sound = "CW_M249_OFFICIAL_BULLETIN"},
	{time = 7.6, sound = "CW_M249_OFFICIAL_COVERCLOSE"},
	{time = 8.3, sound = "CW_FOLEY_LIGHT"}}}

SWEP.SpeedDec = 50

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/machineguns/m249.mdl"
SWEP.WorldModel		= "models/weapons/cw2_0_mach_para.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 100
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 0.075
SWEP.FireSound = "CW_M249_OFFICIAL_FIRE"
SWEP.FireSoundSuppressed = "CW_M249_OFFICIAL_FIRE_SUPPRESSED"
SWEP.Recoil = 1.8

SWEP.HipSpread = 0.065
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 2.4
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 26
SWEP.DeployTime = 2

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 5
SWEP.ReloadTime_Empty = 6.2
SWEP.ReloadHalt = 7.3
SWEP.ReloadHalt_Empty = 8.9

SWEP.Chamberable = false

if CLIENT then
	SWEP.RoundBeltBoneNames = {
		"SAW_BULLET_MAIN",
		"SAW_BULLET_00",
		"SAW_BULLET_02",
		"SAW_BULLET_03",
		"SAW_BULLET_04",
		"SAW_BULLET_05",
		"SAW_BULLET_06",
		"SAW_BULLET_07",
		"SAW_BULLET_08",
		"SAW_BULLET_09",
		"SAW_BULLET_10",
		"SAW_BULLET_11",
		"SAW_BULLET_12",
		"SAW_BULLET_13",
		"SAW_BULLET_14",
		"SAW_BULLET_15"
	}
	
	local function removeRoundMeshes(wep) -- we hide all rounds left in the belt on a non-empty reload because if we don't we're left with ghost meshes moving around (bullets with no link to the mag get moved back to it)
		wep:adjustVisibleRounds(0)
	end
	
	local function adjustMeshByMaxAmmo(wep)
		wep:adjustVisibleRounds(wep.Owner:GetAmmoCount(wep.Primary.Ammo) + wep:Clip1())
	end
	
	SWEP.animCallbacks = {
		reload = removeRoundMeshes
	}
	
	SWEP.Sounds.reload[5].callback = adjustMeshByMaxAmmo
	SWEP.Sounds.reload2[7].callback = adjustMeshByMaxAmmo
end

function SWEP:IndividualInitialize()
	if CLIENT then
		self:initBeltBones()
	end
end

function SWEP:initBeltBones()
	local vm = self.CW_VM
	self.roundBeltBones = {}

	for key, boneName in ipairs(self.RoundBeltBoneNames) do
		local bone = vm:LookupBone(boneName)
		self.roundBeltBones[key] = bone
	end
end

function SWEP:postPrimaryAttack()
	if CLIENT then
		self:adjustVisibleRounds()
	end
end

function SWEP:beginReload()
	self.BaseClass.beginReload(self)
	
	if CLIENT then
		self:adjustVisibleRounds(0)
	end
end

local fullSize = Vector(1, 1, 1)
local invisible = Vector(0, 0, 0)

function SWEP:adjustVisibleRounds(curMag)
	if not self.roundBeltBones then
		self:initBeltBones()
	end
	
	local curMag = curMag or self:Clip1()
	local boneCount = #self.roundBeltBones
	local vm = self.CW_VM
	
	for i = 1, boneCount do
		local roundID = boneCount - (i - 1)
		local element = self.roundBeltBones[roundID]
		
		local scale = curMag >= roundID and fullSize or invisible
		vm:ManipulateBoneScale(element, scale)
	end
end

SWEP.badAccuracyModifier = 5

function SWEP:hasBadAccuracy()
	return self.dt.State == CW_AIMING and not self.dt.BipodDeployed
end

function SWEP:getBaseCone()
	local baseCone, maxSpreadMod = self.BaseClass.getBaseCone(self)
	
	if self:hasBadAccuracy() then
		return baseCone * self.badAccuracyModifier, maxSpreadMod
	end
	
	return baseCone, maxSpreadMod
end

function SWEP:getMaxSpreadIncrease(maxSpreadMod)
	if self:hasBadAccuracy() then
		return self.BaseClass.getMaxSpreadIncrease(self, maxSpreadMod) * self.badAccuracyModifier
	end
	
	return self.BaseClass.getMaxSpreadIncrease(self, maxSpreadMod)
end