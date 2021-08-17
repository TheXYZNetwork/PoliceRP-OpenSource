AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
	SWEP.PrintName = "PKM"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.25
	SWEP.HUD_MagText = "BOX: "
	SWEP.OverallMouseSens = .55
	
	SWEP.IconLetter = "z"
	killicon.Add( "khr_pkm", "icons/killicons/khr_pkm", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_pkm")
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.32
	SWEP.ShellDelay = .05
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = .26
	SWEP.ForeGripOffsetCycle_Reload_Empty = .26
	SWEP.FireMoveMod = 2.2
	SWEP.CustomizationMenuScale = 0.024
	
	SWEP.EffectiveRange_Orig = 132.9 * 39.37
	SWEP.DamageFallOff_Orig = .24
	
	SWEP.IronsightPos = Vector(-2.215, -2, 0.37)
	SWEP.IronsightAng = Vector(-0.3, 0.056, 0)
	
    SWEP.EoTech553Pos = Vector(-2.221, -3, -0.25)
	SWEP.EoTech553Ang = Vector(0, 0, 0)	
	
	SWEP.CSGOACOGPos = Vector(-2.215, -3, -0.17)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(-2.221, -3, -0.07)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(2.813, -4.624, -2.613)
	SWEP.SprintAng = Vector(-7.035, 36.583, -11.961)

	SWEP.SightWithRail = false
	SWEP.BipodFireAnim = true
	SWEP.ADSFireAnim = false
	
	SWEP.AlternativePos = Vector(0, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.AttachmentModelsVM = {
	    ["md_pbs12"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "PKM", pos = Vector(0.379, -21.299, -0.44), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699)},
	    ["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "PKM", pos = Vector(-0.32, -2.597, 0.2), angle = Angle(0, -90, 90), size = Vector(0.5, 0.5, 0.5)},
		["md_fas2_aimpoint"] = {model = "models/c_fas2_aimpoint.mdl", bone = "back", pos = Vector(-0.26, -0, 0.09), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "PKM", rel = "", pos = Vector(0.105, 9.359, -2.06), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), bodygroup = {1,1}},
		["md_uecw_csgo_acog"] = {model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "back", pos = Vector(-0.301, 8.831, -2.971), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_fas2_eotech"] = {model = "models/c_fas2_eotech.mdl", bone = "back", pos = Vector(-0.25, 0.518, 0.342), angle = Angle(0, 90, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "PKM", pos = Vector(0, -16.105, -2.597), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6)}
	}

	SWEP.ForeGripHoldPos = {
	["Bip01 L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(34.444, 10, 0) },
	["Bip01 L UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-5.557, 5.556, 14.444) },
	["Bip01 L Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 45.555) }
	
	}
	
 
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = .1, roll = .25, forward = .1, pitch = 1}
end

SWEP.MuzzleVelocity = 825 -- in meter/s
	
SWEP.LaserPosAdjust = Vector(0.1, 0, 0)--{x = 1, y = 0, z = 0}
SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}

SWEP.BipodInstalled = true
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true

SWEP.CanRestOnObjects = true

SWEP.Attachments = {[4] = {header = "Optic", offset = {700, -350},  atts = {"md_fas2_eotech", "md_fas2_aimpoint", "md_uecw_csgo_acog"}},
    [2] = {header = "Laser", offset = {-650, -300}, atts = {"md_anpeq15"}},
	[3] = {header = "Barrel", offset = {200, -400}, atts = {"md_pbs12"}},
	[1] = {header = "Handguard", offset = {-600, 200}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {1000, 100}, atts = {"am_matchgrade"}}
	}

SWEP.Animations = {fire = {"shoot1","shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "KHRPKM.Draw"}},

	
	reload = {[1] = {time = 0, sound = "KHRPKM.Cloth"},
	[2] = {time = 0.8, sound = "KHRPKM.Coverup"},
	[3] = {time = 1.2, sound = "KHRPKM.Bullet"},
	[4] = {time = 2.4, sound = "KHRPKM.Boxout"},
	[5] = {time = 3.7, sound = "KHRPKM.Boxin"},
	[6] = {time = 4.2, sound = "KHRPKM.Chain"},
	[7] = {time = 4.8, sound = "KHRPKM.Coverdown"},
	[8] = {time = 5.2, sound = "KHRPKM.Coversmack"},
	[9] = {time = 5.8, sound = "KHRPKM.Bolt"}}}
	
SWEP.SpeedDec = 55

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Special"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.AimViewModelFOV = 70
SWEP.ViewModelFlip	= false
SWEP.ADSFireAnim = false
SWEP.BipodFireAnim = true
SWEP.ViewModel		= "models/khrcw2/v_khri_pkmmachi.mdl"
SWEP.WorldModel		= "models/khrcw2/w_khri_pkmmachi.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true


SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x54MMR"
SWEP.Chamberable = false

SWEP.FireDelay = 60/625
SWEP.FireSound = "KHRPKM_FIRE"
SWEP.FireSoundSuppressed = "KHRPKM_FIRE_SUPPRESSED"
SWEP.Recoil = 1.78
SWEP.BipodRecoilModifier = .25
SWEP.FOVPerShot = 4

SWEP.HipSpread = 0.095
SWEP.AimSpread = 0.0032
SWEP.VelocitySensitivity = 2.8
SWEP.MaxSpreadInc = 0.085
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.14
SWEP.RecoilToSpread = 1
SWEP.Damage = 54
SWEP.DeployTime = .8

SWEP.ReloadSpeed = 1.02
SWEP.ReloadTime = 7
SWEP.ReloadTime_Empty = 7
SWEP.ReloadHalt = 7
SWEP.ReloadHalt_Empty = 7

SWEP.Offset = {
Pos = {
Up = 0,
Right = 0,
Forward = 3.5,
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
	self.EffectiveRange = 132.9 * 39.37
	self.DamageFallOff = .24
	
	if self.ActiveAttachments.md_pbs12 then
	self.EffectiveRange = ((self.EffectiveRange - 39.87 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .072))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 19.935 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .036))
	end
end