AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

	SWEP.magType = "pistolMag"
	
	CustomizableWeaponry.shells:addNew("9x18mak", "models/shells/9x18mm.mdl", "CW_SHELL_SMALL")
	SWEP.PrintName = "Makarov PM"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "y"
	killicon.Add( "khr_cz52", "icons/killicons/khr_cz52", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_cz52")
	
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = true
	
    SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/khrcw2/pistols/w_makarov.mdl"
	SWEP.WMPos = Vector(-1.5, 4.5, 1.6)
	SWEP.WMAng = Vector(0, 0, 180)
	
	SWEP.Shell = "9x18mak"
	SWEP.ShellScale = .675
	SWEP.ShellOffsetMul = 0
	SWEP.ShellPosOffset = {x = -2, y = .25, z = -.15}
	
	SWEP.EffectiveRange_Orig = 35.4 * 39.37
	SWEP.DamageFallOff_Orig = .46

	SWEP.IronsightPos = Vector(-1.65, 0, 0.288)
	SWEP.IronsightAng = Vector(0.31, 0.034, 0)
	
	SWEP.PB6P9Pos = Vector(-1.661, 0, -0.103)
	SWEP.PB6P9Ang = Vector(0.58, 0.044, 0)
	
	SWEP.MakPMMPos = Vector(-1.65, 0, 0.314)
	SWEP.MakPMMAng = Vector(0.32, 0.079, 0)

	SWEP.CustomizePos = Vector(5.1111, -3.5556, -1.2)
	SWEP.CustomizeAng = Vector(14, 30, 14)
	
	SWEP.AlternativePos = Vector(-.25, -1, -.555)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0.5556, 0.5556, -0.5556)
	SWEP.SprintAng = Vector(-18, 14, -10)

	
	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 1
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(0, .83, 0)
	SWEP.BoltBonePositionRecoverySpeed = 15
	SWEP.EmptyBoltHoldAnimExclusion = "base_firelast"
    SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 1, pitch = 1.5}
	SWEP.CustomizationMenuScale = 0.014
	
		function SWEP:RenderTargetFunc()
		if self.ActiveAttachments.md_tritiumis then
					self.AttachmentModelsVM.tritfront.active = true
					self.AttachmentModelsVM.tritback.active = true
					else
					self.AttachmentModelsVM.tritfront.active = false
					self.AttachmentModelsVM.tritback.active = false
				end			
					if self.ActiveAttachments.md_tritiumispmm then
					self.AttachmentModelsVM.tritfrontpmm.active = true
					self.AttachmentModelsVM.tritbackpmm.active = true
					else
					self.AttachmentModelsVM.tritfrontpmm.active = false
					self.AttachmentModelsVM.tritbackpmm.active = false
				end
					if self.ActiveAttachments.md_tritiumispb then
					self.AttachmentModelsVM.tritfrontpb.active = true
					self.AttachmentModelsVM.tritbackpb.active = true
					else
					self.AttachmentModelsVM.tritfrontpb.active = false
					self.AttachmentModelsVM.tritbackpb.active = false
				end
        end
	end
	
	SWEP.AttachmentDependencies = { 
	["bg_makpmmext"] = {"bg_makpmm"},
	["bg_makpmm12rnd"] = {"bg_makpmm"},
	["bg_makpbsup"] = {"bg_makpb6"},
	["md_tritiumispb"] = {"bg_makpb6"},
	["md_tritiumispmm"] = {"bg_makpmm"},
}
SWEP.AttachmentExclusions = {
	["md_gemtechmm"] = {"bg_makpb6"},
	["bg_makpmext"] = {"bg_makpmm"},
	["md_tritiumis"] = {"bg_makpmm","bg_makpb6"},
}
	
	SWEP.AttachmentModelsVM = {
	["md_gemtechmm"] = { type = "Model", model = "models/khrcw2/attachments/9mmsuppressor.mdl", bone = "Weapon", rel = "", pos = Vector(2.132, -17.7, 3.18), angle = Angle(0, -90, 0), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["tritfront"] = { type = "Model", model = "models/khrcw2/attachments/tritfront.mdl", bone = "Slide", rel = "", pos = Vector(1.731, -12.978, 0.577), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["tritback"] = { type = "Model", model = "models/khrcw2/attachments/tritback.mdl", bone = "Slide", rel = "", pos = Vector(1.731, -12.681, -1.87), angle = Angle(12.857, -90, .45), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["tritfrontpmm"] = { type = "Model", model = "models/khrcw2/attachments/tritfront.mdl", bone = "Slide", rel = "", pos = Vector(1.726, -13.07, 0.54), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["tritbackpmm"] = { type = "Model", model = "models/khrcw2/attachments/tritback.mdl", bone = "Slide", rel = "", pos = Vector(1.731, -12.69, -1.9), angle = Angle(12.857, -90, .45), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["tritbackpb"] = { type = "Model", model = "models/khrcw2/attachments/tritback.mdl", bone = "Slide", rel = "", pos = Vector(1.723, -12.57, -1.547), angle = Angle(12.857, -90, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["tritfrontpb"] = { type = "Model", model = "models/khrcw2/attachments/tritfront.mdl", bone = "Weapon", rel = "", pos = Vector(1.69, -13.4, 1.269), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	

SWEP.MuzzleVelocity = 315 -- in meter/s
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false

SWEP.SuppBGs = {main = 1, none = 0, pb = 1}
SWEP.BodyBGs = {main = 0, pm = 0, pmm = 1, pb = 2}
SWEP.MagBGs = {main = 2, pm8rnd = 0, pm14rnd = 1, pmm12rnd = 2, pmm18rnd = 3}

SWEP.Attachments = {[3] = {header = "Suppressor", offset = {-150, -500}, atts = {"md_gemtechmm","bg_makpbsup"}},
[4] = {header = "Ironsight", offset = {400, -250}, atts = {"md_tritiumis","md_tritiumispmm","md_tritiumispb"}},
[1] = {header = "Body", offset = {-550, -300}, atts = {"bg_makpmm","bg_makpb6"}},
[2] = {header = "Magazine", offset = {-200, 150}, atts = {"bg_makpmm12rnd","bg_makpmext","bg_makpmmext"}},
["+reload"] = {header = "Ammo", offset = {400, 150}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"base_fire","base_fire2","base_fire3"},
    fire_dry = "base_firelast",
	reload_empty = "base_reloadempty",
	reload = "base_reload",
	idle = "base_idle",
	draw = "base_ready"}
	
SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_FOLEY_LIGHT"},
		{time = 7/30, sound = "KHRMAK_SAFETY"},
		{time = 12/30, sound = "KHRMAK_BOLTBACK"},
		{time = 19/30, sound = "KHRMAK_BOLTRELEASE"},
	},

	base_draw = {
		{time = 0, sound = "CW_FOLEY_LIGHT"},
	},

	base_reload = {
		{time = 17/30, sound = "KHRMAK_MAGRELEASE"},
		{time = 24/30, sound = "KHRMAK_MAGOUT"},
		{time = 58/30, sound = "KHRMAK_MAGIN"},
		{time = 62/30, sound = "KHRMAK_MAGHIT"},
	},

	base_reloadempty = {
		{time = 17/30, sound = "KHRMAK_MAGRELEASE"},
		{time = 24/30, sound = "KHRMAK_MAGOUT"},
		{time = 58/30, sound = "KHRMAK_MAGIN"},
		{time = 62/30, sound = "KHRMAK_MAGHIT"},
		{time = 71/30, sound = "KHRMAK_BOLTRELEASE"},
	},
	
	base_reload_extmag = {
		{time = 17/30, sound = "KHRMAK_MAGRELEASE"},
		{time = 24/30, sound = "KHRMAK_MAGOUT"},
		{time = 58/30, sound = "KHRMAK_MAGIN"},
		{time = 62/30, sound = "KHRMAK_MAGHIT"},
	},
	
	base_reloadempty_extmag = {
		{time = 17/30, sound = "KHRMAK_MAGRELEASE"},
		{time = 24/30, sound = "KHRMAK_MAGOUT"},
		{time = 58/30, sound = "KHRMAK_MAGIN"},
		{time = 62/30, sound = "KHRMAK_MAGHIT"},
		{time = 71/30, sound = "KHRMAK_BOLTRELEASE"},
	},
}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Pistols"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= "Removing kebab"
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 80
SWEP.AimViewModelFOV = 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/pistols/makarov.mdl"
SWEP.WorldModel		= "models/khrcw2/pistols/w_makarov.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x18MM"

SWEP.FireDelay = 0.109
SWEP.FireSound = "KHRMAK_FIRE"
SWEP.FireSoundSuppressed = "KHRMAK_FIRE_SUPPRESSED"
SWEP.Recoil = .76
SWEP.FOVPerShot = 0.2

SWEP.HipSpread = 0.04
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.1
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.008
SWEP.SpreadCooldown = 0.24
SWEP.Shots = 1
SWEP.Damage = 21
SWEP.DeployTime = 1
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 2.45
SWEP.ReloadHalt = 2.45

SWEP.ReloadTime_Empty = 2.75
SWEP.ReloadHalt_Empty = 2.75

SWEP.SnapToIdlePostReload = false

function SWEP:IndividualThink()
	self.EffectiveRange = 35.4 * 39.37
	self.DamageFallOff = .46
	
	if self.ActiveAttachments.md_gemtechmm then
	self.EffectiveRange = ((self.EffectiveRange - 10.62 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .138))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 5.31 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .069))
	end
	if self.ActiveAttachments.bg_makpb6 then
	self.EffectiveRange = ((self.EffectiveRange + 3.54 * 39.37))
	end
	if self.ActiveAttachments.bg_makpbsup then
	self.EffectiveRange = ((self.EffectiveRange - 7.08 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .092))
	end
end