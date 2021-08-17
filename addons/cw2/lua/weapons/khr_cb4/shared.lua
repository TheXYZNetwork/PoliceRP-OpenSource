if CustomizableWeaponry then


AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
	SWEP.PrintName = "CB4 Elephant Gun"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1
	SWEP.NoShells = true
	SWEP.HUD_MagText = "BREECH: "
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_cb4", "icons/killicons/khr_cb4", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_cb4")
	
	SWEP.MuzzleEffect = "muzzle_center_M82"
	SWEP.NoSilMuz = true
	SWEP.PosBasedMuz = false
	SWEP.NoDistance = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = 3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = .7
	SWEP.ForeGripOffsetCycle_Reload_Empty = .7
	SWEP.SightWithRail = true
	SWEP.AimBreathingEnabled = false
	SWEP.DisableSprintViewSimulation = false
	
	SWEP.EffectiveRange_Orig = 125.7 * 39.37
	SWEP.DamageFallOff_Orig = .5
	
	SWEP.IronsightPos = Vector(-1.955, -0.805, 1.40)
	SWEP.IronsightAng = Vector(-.2, 1.99, 0)
	
	SWEP.CSGOACOGPos = Vector(-2.0593, -4, .97)
	SWEP.CSGOACOGAng = Vector(-.2, 1.99, 0)
	
	SWEP.NXSPos = Vector(-2.0802, -4, .9842)
	SWEP.NXSAng = Vector(-.2, 1.99, 0)
	
	SWEP.ShortDotPos = Vector(-2.064, -4, 1.06)
	SWEP.ShortDotAng = Vector(-.2, 1.99, 0)
	
	SWEP.AlternativePos = Vector(.2, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.AttachmentModelsVM = {
	
		["md_makeshift"] = { type = "Model", model = "models/props_c17/tools_wrench01a.mdl", bone = "Pump", rel = "", pos = Vector(0.03, -2.597, 0.518), angle = Angle(0, 180, -90), size = Vector(0.107, 0.107, 0.107), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_cblongbarrel"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "Pump", rel = "", pos = Vector(0, -43.901, -1.879), angle = Angle(0, 0, 0), size = Vector(0.625, 1.728, 0.625), color = Color(40, 40, 40, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_cblongerbarrel"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "Pump", rel = "", pos = Vector(0, -64.901, -1.879), angle = Angle(0, 0, 0), size = Vector(0.625, 2.5, 0.625), color = Color(40, 40, 40, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_foregrip"] = { type = "Model", model = "models/weapons/w_khri_cb4el.mdl", bone = "Reciever", rel = "", pos = Vector(-0.151, -6.753, -1.058), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bg_cbstock"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "Reciever", rel = "", pos = Vector(-0.101, 3.536, 0.671), angle = Angle(-90, 0, -90), size = Vector(0.432, 0.432, 0.237), color = Color(40, 40, 40, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "Reciever", rel = "", pos = Vector(0.17, -2.971, -0.51), angle = Angle(0, 90, 0), size = Vector(0.949, 0.949, 0.949), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_nightforce_nxs"] = { type = "Model", model = "models/cw2/attachments/l96_scope.mdl", bone = "Reciever", rel = "", pos = Vector(0.019, -2.991, 2.109), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "Reciever", rel = "", pos = Vector(0.17, 1.258, -2.431), angle = Angle(0, 90, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "Reciever", rel = "", pos = Vector(-0.11, 2.299, -1.701), angle = Angle(0, 90, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
		}
		
	SWEP.ForeGripHoldPos = {
		["Bip01 L Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(18.888, 18.888, 16.666) },
	["Bip01 L Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 56.666, 21.111) },
	["Bip01 L ForeTwist1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -10) },
	["Bip01 L ForeTwist"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 10) },
	["Bip01 L Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5.556, 30, 18.888) },
	["Bip01 L Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(25.555, 1.11, 45.555) },
	["Bip01 L UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-3.889, 3.888, -1.297), angle = Angle(-17.889, 3.132, 27.777) },
	["Bip01 L Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(7.777, 56.666, 27.777) },
	["Bip01 L Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 54.444, 0) },
	["Bip01 L Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10, 5.556, 21.111) },
	["Bip01 L Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -5.557, 3.332) },
	["Bip01 L Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-7.778, 47.777, 0) },
	["Bip01 L Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-14.445, 65.555, -1.111) },
	["Bip01 L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-5.557, 7.777, 0) },
	["Bip01 L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(18.888, 5.556, 7.777) }
		}
		
	SWEP.ACOGAxisAlign = {right = 0.2, up = 0, forward = 0}
	SWEP.NXSAlign = {right = 0.35, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0.2, up = 0, forward = 0}
	
end

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false
SWEP.FullAimViewmodelRecoil = true
SWEP.ADSFireAnim = false
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.GlobalDelayOnShoot = 0.5
SWEP.CustomizationMenuScale = 0.018
SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 1.5, pitch = 1}

SWEP.Attachments = {[3] = {header = "Sight", offset = {-350, -550},  atts = {"md_makeshift", "md_schmidt_shortdot", "md_uecw_csgo_acog", "md_nightforce_nxs"}},
	[1] = {header = "Barrel", offset = {-550, -150},  atts = {"md_cblongbarrel","md_cblongerbarrel"}},
	[4] = {header = "Stock", offset = {500, -120}, atts = {"bg_cbstock"}},
	[2] = {header = "Grip", offset = {-350, 300}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {300, -550}, atts = {"am_4borehp", "am_4borebs"}}}
	
--SWEP.AttachmentDependencies = {} -- this is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY

SWEP.Animations = {fire = "FUCK_Shoot",
	reload = "FUCK_reload",
	idle = "FUCK_Idle",
	draw = "FUCK_draw"}
	
SWEP.Sounds = {FUCK_reload = {[1] = {time = 0.65, sound = "CB4_BOpen"},
	[2] = {time = 0.8, sound = "CB4_SEject"},
	[3] = {time = 1.50, sound = "CB4_SFutz"},
	[4] = {time = 1.6, sound = "CB4_SInsert"},
	[5] = {time = 1.9, sound = "CB4_BClose"}},
	}

SWEP.SpeedDec = 60

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"break"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Special"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.AimViewModelFOV = 60
SWEP.CrosshairEnabled = true
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_khri_cb4el.mdl"
SWEP.WorldModel		= "models/weapons/w_khri_cb4el.mdl"
SWEP.OverallMouseSens = .8

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 2
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Four-Bore Cartridge"
SWEP.Chamberable = false

SWEP.FireDelay = 0.1
SWEP.FireSound = "CB4_FIRE"
SWEP.Recoil = 9

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.011
SWEP.VelocitySensitivity = 2.4
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 20
SWEP.ClumpSpread = .045
SWEP.Damage = 15
SWEP.DeployTime = 0.5
SWEP.ForcedHipWaitTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.2
SWEP.ReloadTime_Empty = 2.2
SWEP.ReloadHalt = 2.2
SWEP.ReloadHalt_Empty = 2.2
SWEP.SnapToIdlePostReload = true

end

SWEP.Offset = {
Pos = {
Up = 1,
Right = 0,
Forward = 0,
},
Ang = {
Up = 0,
Right = -10,
Forward = 180,
}
}

function SWEP:DrawWorldModel( )
        local hand, offset, rotate

        local pl = self:GetOwner()

        if IsValid( pl ) then
                        local boneIndex = pl:LookupBone( "ValveBiped.Bip01_R_Hand" )
                        if boneIndex then
                                local pos, ang = pl:GetBonePosition( boneIndex )
                                pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up

                                ang:RotateAroundAxis( ang:Up(), self.Offset.Ang.Up)
                                ang:RotateAroundAxis( ang:Right(), self.Offset.Ang.Right )
                                ang:RotateAroundAxis( ang:Forward(),  self.Offset.Ang.Forward )

                                self:SetRenderOrigin( pos )
                                self:SetRenderAngles( ang )
                                self:DrawModel()
                        end
        else
                self:SetRenderOrigin( nil )
                self:SetRenderAngles( nil )
                self:DrawModel()
        end
end

function SWEP:IndividualThink()
	self.EffectiveRange = 125.7 * 39.37
	self.DamageFallOff = .5
	self.ClumpSpread = .045
	
	if self.ActiveAttachments.md_cblongbarrel then
	self.EffectiveRange = ((self.EffectiveRange + 18.855 * 39.37))
	self.ClumpSpread = ((self.ClumpSpread - .003))
	end
	if self.ActiveAttachments.md_cblongerbarrel then
	self.EffectiveRange = ((self.EffectiveRange + 37.71 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .05))
	self.ClumpSpread = ((self.ClumpSpread - .006))
	end
	if self.ActiveAttachments.am_4borehp then
	self.EffectiveRange = ((self.EffectiveRange + 62.85 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .06))
	self.ClumpSpread = nil
	end
	if self.ActiveAttachments.am_4borebs then
	self.EffectiveRange = ((self.EffectiveRange + 125.7 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .12))
	self.ClumpSpread = nil
	end
end