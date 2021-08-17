AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.magType = "smgMag"

SWEP.PrintName = "KRISS Vector"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_vector", "icons/killicons/khr_vector", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_vector")
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.43
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2.5, y = -2, z = 0}
	SWEP.SightWithRail = false
	SWEP.DisableSprintViewSimulation = false
	
	SWEP.EffectiveRange_Orig = 42.3 * 39.37
	SWEP.DamageFallOff_Orig = .47
	
	SWEP.IronsightPos = Vector(-2.741, -4, 0.81)
	SWEP.IronsightAng = Vector(-0.6, -0.476, 0)
	
	SWEP.MicroT1Pos = Vector(-2.74, -4, 1.032)
	SWEP.MicroT1Ang = Vector(0, -0.5, 0)
	
    SWEP.EoTech553Pos = Vector(-2.745, -4, .73)
	SWEP.EoTech553Ang = Vector(0, -0.5, 0)
	
	SWEP.KR_CMOREPos =  Vector(-2.751, -4, .93)
	SWEP.KR_CMOREAng =  Vector(0, -0.5, 0)
	
	SWEP.FAS2AimpointPos = Vector(-2.73, -4, 1.035)
	SWEP.FAS2AimpointAng = Vector(0, -0.5, 0)
	
	SWEP.SprintPos = Vector(3.92, 0, -1.321)
	SWEP.SprintAng = Vector(-14.07, 24.622, -4.926)
	
	SWEP.AlternativePos = Vector(-.4, 0, -0.24)
	SWEP.AlternativeAng = Vector(0, 0.703, 0)

	SWEP.CustomizationMenuScale = 0.02
	SWEP.ViewModelMovementScale = 1
	
	SWEP.AttachmentModelsVM = {
	
	    ["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "KrissBodyPart", rel = "", pos = Vector(-0.11, 0, 2.22), angle = Angle(0, 90, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "KrissBodyPart", rel = "", pos = Vector(0, -3, 2.599), angle = Angle(0, -90, 0), size = Vector(0.439, 0.439, 0.439), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "KrissBodyPart", rel = "", pos = Vector(-0.116, 3, 2.759), angle = Angle(0, 0, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "KrissBodyPart", rel = "", pos = Vector(-0.12, 0.5, 2.065), angle = Angle(0, 90, 0), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "KrissBodyPart", rel = "", pos = Vector(-0.04, 3, 2.72), angle = Angle(0, 90, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_cobram22"] = { type = "Model", model = "models/cw2/attachments/cobra_m2.mdl", bone = "KrissBodyPart", rel = "", pos = Vector(-0.101, -9, 1), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rearsight"] = { type = "Model", model = "models/bunneh/rearsight.mdl", bone = "KrissBodyPart", rel = "", pos = Vector(2.14, 10.399, 3.799), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["frontsight"] = { type = "Model", model = "models/bunneh/frontsight.mdl", bone = "KrissBodyPart", rel = "", pos = Vector(2.14, 3, 3.799), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
		function SWEP:RenderTargetFunc()

	
	if self.AimPos != self.IronsightPos then -- if we have a sight/scope equiped, hide the front and rar sights
	self.AttachmentModelsVM.frontsight.active = false
	self.AttachmentModelsVM.rearsight.active = false
	else
	self.AttachmentModelsVM.frontsight.active = true
	self.AttachmentModelsVM.rearsight.active = true
	end
	
end
	
	
end

SWEP.LaserPosAdjust = Vector(.5, 0, 0)--{x = 1, y = 0, z = 0}
SWEP.LaserAngAdjust = Angle(0, 179.8, 0) --{p = 2, y = 180, r = 0}

SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = .5, roll = 1, forward = .75, pitch = 1.2}
SWEP.MuzzleVelocity = 270 -- in meter/s
SWEP.LuaViewmodelRecoil = true


SWEP.Attachments = {[3] = {header = "Sight", offset = {500, -350}, atts = {"md_microt1kh", "odec3d_cmore_kry", "md_fas2_eotech", "md_fas2_aimpoint"}},
[1] = {header = "Barrel", offset = {-500, -250}, atts = {"md_cobram22"}},
[2] = {header = "Rail", offset = {-150, -520}, atts = {"md_anpeq15"}},
["+reload"] = {header = "Ammo", offset = {-300, 200}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {	draw = {{time = 0, sound = "KRISS_Deploy"}},

	reload = {[1] = {time = .8, sound = "KRISS_Magout"},
	[2] = {time = 1.9, sound = "KRISS_Magin"},
	[3] = {time = 2.5, sound = "KRISS_Maghit"},
	[4] = {time = 3, sound = "KRISS_Shoulder"}}}

SWEP.HoldBoltWhileEmpty = true
SWEP.DontHoldWhenReloading = false
SWEP.Chamberable = false

SWEP.SpeedDec = 35

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto","2burst","semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - SMGs"
SWEP.BurstRecoilMul = 0.75

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.OverallMouseSens = .9
SWEP.ViewModelFOV	= 70
SWEP.AimViewModelFOV = 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khr_kriss.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_ump45.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 25
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ".45 ACP"

SWEP.FireDelay = 0.086
SWEP.FireSound = "KRISS_Fire"
SWEP.FireSoundSuppressed = "KRISS_Firesup"
SWEP.Recoil = .8

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.4
SWEP.MaxSpreadInc = 0.055
SWEP.SpreadPerShot = 0.0045
SWEP.SpreadCooldown = 0.14
SWEP.Shots = 1
SWEP.Damage = 29
SWEP.DeployTime = 0.3

SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 3.2
SWEP.ReloadTime_Empty = 3.2
SWEP.ReloadHalt = 3.2
SWEP.ReloadHalt_Empty = 3.2

function SWEP:IndividualThink()
	self.EffectiveRange = 42.3 * 39.37
	self.DamageFallOff = .47
	
	if self.ActiveAttachments.md_cobram22 then
	self.EffectiveRange = ((self.EffectiveRange - 10.575 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .1175))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 6.345 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .0705))
	end
end