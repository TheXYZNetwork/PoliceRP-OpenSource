AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

SWEP.PrintName = "Stevens M620"

if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	
	SWEP.IconLetter = "k"
	killicon.Add( "khr_m620", "icons/select/khr_m620", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_m620")
	
	SWEP.EffectiveRange_Orig = 34 * 39.37
	SWEP.DamageFallOff_Orig = .48
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.35
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	SWEP.ShellDelay = 0.4
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/khrcw2/w_khri_stevenm62.mdl"
	SWEP.WMPos = Vector(-1, 1.5, 0)
	SWEP.WMAng = Vector(-5, 0, 180)
	
	SWEP.ShellPosOffset = {x = 1.2, y = -3, z = 0}
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true
		
	SWEP.IronsightPos = Vector(-1.821, -.5, 1)
	SWEP.IronsightAng = Vector(.7, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-1.821, -1.5, 0.549)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTech553Pos = Vector(-1.823, -.5, 0.26)
	SWEP.EoTech553Ang = Vector(0, 0, 0)	
	
	SWEP.CSGOACOGPos = Vector(-1.8112, -1.5, 0.465)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.KR_CMOREPos =  Vector(-1.821, -1.5, 0.44)
	SWEP.KR_CMOREAng =  Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(-1.817, -1.5, 0.5045)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(-1.818, 0, 0.482)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
		
	SWEP.CustomizePos = Vector(5.711, -1.482, -1.5)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)
	
	SWEP.AlternativePos = Vector(-0, 1.2, -.4)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.019
	SWEP.ReticleInactivityPostFire = .8

	SWEP.AttachmentModelsVM = {
	
	["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "body", rel = "", pos = Vector(3.599, 0.029, -.8), angle = Angle(0, 180, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1kh"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "body", rel = "", pos = Vector(0.518, 0, 1.565), angle = Angle(0, 90, 0), size = Vector(0.24, 0.24, 0.24), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "body", rel = "", pos = Vector(-1.4, 0, .97), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "body", rel = "", pos = Vector(-1, 0.175, 0.1), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["odec3d_cmore_kry"] = { type = "Model", model = "models/weapons/krycek/sights/odec3d_cmore_reddot.mdl", bone = "body", rel = "", pos = Vector(0, -0.051, 1.557), angle = Angle(0, 180, 0), size = Vector(0.16, 0.16, 0.16), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "body", rel = "", pos = Vector(3.099, -.2, -1.535), angle = Angle(0, -180, 0), size = Vector(0.53, 0.53, 0.53), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "body", rel = "", pos = Vector(-1.75, .00, 1.13), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_mchoke"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "body", rel = "", pos = Vector(-16.4, 0.014, 0.529), angle = Angle(0, -90, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_fchoke"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "body", rel = "", pos = Vector(-16.4, 0.014, 0.529), angle = Angle(0, -90, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 0, pitch = 1.5}
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 1.5, forward = 0}
end

SWEP.MuzzleVelocity = 350 -- in meter/s

SWEP.LuaViewmodelRecoil = true
SWEP.FullAimViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.ADSFireAnim = true
SWEP.ForceBackToHipAfterAimedShot = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {600, -250},  atts = {"md_microt1kh", "odec3d_cmore_kry", "md_fas2_eotech", "md_fas2_aimpoint", "md_schmidt_shortdot", "md_uecw_csgo_acog"}},
	[2] = {header = "Barrel", offset = {-300, -400}, atts = {"md_mchoke", "md_fchoke"}},
	["+reload"] = {header = "Ammo", offset = {-400, 50}, atts = {"am_slugrounds2k", "am_birdshot", "am_flechetterounds2", "am_shortbuck"}}}

SWEP.Animations = {fire = {"shoot1"},
	reload_start = "start_reload",
	insert = "insert",
	reload_end = "after_reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.AttachmentExclusions = {
["md_mchoke"] = {"am_slugrounds2k"},
["md_fchoke"] = {"am_slugrounds2k", "am_birdshot"},
["am_slugrounds2k"] = {"md_mchoke", "md_fchoke"},
["am_birdshot"] = {"md_fchoke"}
}


SWEP.Sounds = {shoot1 = {{time = 0.1, sound = "K620_PUMP"}},
	
	start_reload = {{time = 0.05, sound = "CW_FOLEY_LIGHT"}},
	insert = {{time = 0.1, sound = "K620_INSERT"}},
	
	after_reload = {{time = 0.1, sound = "K620_PUMP"}},
	
	draw = {{time = 0.1, sound = "K620_PUMP"}}}
	

SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Shotguns"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_stevenm62.mdl"
SWEP.WorldModel		= "models/khrcw2/w_khri_stevenm62.mdl"
SWEP.OverallMouseSens = .9

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 60/74
SWEP.FireSound = "K620_FIRE"
SWEP.Recoil = 5

SWEP.HipSpread = 0.07
SWEP.AimSpread = 0.012
SWEP.VelocitySensitivity = 1.45
SWEP.MaxSpreadInc = 0.08
SWEP.ClumpSpread = .024
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.75
SWEP.Shots = 9
SWEP.Damage = 13
SWEP.DeployTime = .6

SWEP.ReloadStartTime = 0.5
SWEP.InsertShellTime = 0.8
SWEP.ReloadFinishWait = .9
SWEP.ShotgunReload = true

SWEP.Chamberable = true

function SWEP:IndividualThink()
	self.EffectiveRange = 34 * 39.37
	self.DamageFallOff = .48
	self.ClumpSpread = .024
	self.Primary.ClipSize = 5
	self.Primary.ClipSize_Orig = 5
	
	if self.ActiveAttachments.am_slugrounds2k then
	self.EffectiveRange = ((self.EffectiveRange + 8.5 * 39.37))
	self.ClumpSpread = nil
	end
	if self.ActiveAttachments.am_birdshot then
	self.ClumpSpread = ((self.ClumpSpread + .01))
	self.EffectiveRange = ((self.EffectiveRange - 14.2 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .42))
	self.Shots = 70
	end
	if self.ActiveAttachments.am_flechetterounds2 then
	self.ClumpSpread = ((self.ClumpSpread - .0092))
	self.EffectiveRange = ((self.EffectiveRange - 2.84 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .048))
	end
	if self.ActiveAttachments.md_mchoke then
	self.ClumpSpread = ((self.ClumpSpread * .9))
	end
	if self.ActiveAttachments.md_fchoke then
	self.ClumpSpread = ((self.ClumpSpread * .8))
	end
	if self.ActiveAttachments.am_shortbuck then
	self.Primary.ClipSize = 7
	self.Primary.ClipSize_Orig = 7
	end
end