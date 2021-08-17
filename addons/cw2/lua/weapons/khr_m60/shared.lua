AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
	SWEP.PrintName = "M-60"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.25
	SWEP.HUD_MagText = "BOX: "
	SWEP.Chamberable = false
	SWEP.OverallMouseSens = .6
	
	SWEP.EffectiveRange_Orig = 138.6 * 39.37
	SWEP.DamageFallOff_Orig = .26
	
	SWEP.IconLetter = "z"
	killicon.Add( "khr_m60", "icons/killicons/khr_m60", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_m60")
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.4
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Reload = 1
	SWEP.ForeGripOffsetCycle_Reload_Empty = 1
	SWEP.FireMoveMod = 2
	SWEP.CustomizationMenuScale = 0.023
	
	SWEP.IronsightPos = Vector(-2.87, -2, 0.66)
	SWEP.IronsightAng = Vector(0.01, 0.04, 0)

	SWEP.SprintPos = Vector(2.813, -4.624, -2.613)
	SWEP.SprintAng = Vector(-7.035, 36.583, -11.961)

	SWEP.SightWithRail = false
	SWEP.ADSFireAnim = true
	
	SWEP.AlternativePos = Vector(0, 0, 0)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.AttachmentModelsVM = {
	    ["md_saker222"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "M60_Body", pos = Vector(0, 5.714, -2.1), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "M60_Body", rel = "", pos = Vector(0.105, 9.359, -2.06), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), bodygroup = {1,1}},
	    ["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "M60_Body", pos = Vector(-0.92, 8.831, -0.519), angle = Angle(0, 90, -90), size = Vector(0.5, 0.5, 0.5)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "M60_Body", pos = Vector(-0.341, -2.597, -3.636), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6)}
	}

	SWEP.ForeGripHoldPos = {
	["Bip01 L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(7.777, 7.777, -27.778) },
	["Bip01 L Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 32.222) },
	["Bip01 L Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 18.888, 5.556) },
	["Bip01 L Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-16.667, 5.556, -10) },
	["Bip01 L UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-0.186, -0.926, 2.407), angle = Angle(-16.667, 5.556, 34.444) }
	}
	
 
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = .1, roll = .25, forward = .1, pitch = 1}
end

SWEP.MuzzleVelocity = 853 -- in meter/s

SWEP.LaserPosAdjust = Vector(0.1, 0, 0)--{x = 1, y = 0, z = 0}
SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}

SWEP.BipodInstalled = true
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.CanRestOnObjects = true

SWEP.Attachments = {[1] = {header = "Rail", offset = {-350, -600}, atts = {"md_anpeq15"}},
	[2] = {header = "Barrel", offset = {400, -700}, atts = {"md_saker222"}},
	--[3] = {header = "Handguard", offset = {0, 0}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {1000, 150}, atts = {"am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1","shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "KM60.Draw"}},

	
	reload = {[1] = {time = 0, sound = "KHRPKM.Cloth"},
	[2] = {time = 0.68, sound = "KM60.Bolt"},
	[3] = {time = 2, sound = "KM60.CoverUp"},
	[4] = {time = 2.6, sound = "KM60.Boxout"},
	[5] = {time = 3.9, sound = "KM60.Chain"},
	[6] = {time = 4.1, sound = "KM60.Boxin"},
	[7] = {time = 4.7, sound = "KM60.CoverDown"}}}
	
SWEP.SpeedDec = 45

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
SWEP.ViewModel		= "models/khrcw2/v_khri_m60machi.mdl"
SWEP.WorldModel		= "models/khrcw2/w_khri_m60machi.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true


SWEP.Primary.ClipSize		= 200
SWEP.Primary.DefaultClip	= 200
SWEP.Primary.Automatic		= true
SWEP.BipodFireAnim = true
SWEP.ADSFireAnim = false
SWEP.Primary.Ammo			= "7.62x51MM"
SWEP.Chamberable = false

SWEP.FireDelay = 60/600
SWEP.FireSound = "KM60_FIRE"
SWEP.FireSoundSuppressed = "KM60_FIRE_SUPPRESSED"
SWEP.Recoil = 1.6
SWEP.BipodRecoilModifier = .25
SWEP.FOVPerShot = 4

SWEP.HipSpread = 0.082
SWEP.AimSpread = 0.0037
SWEP.VelocitySensitivity = 2.5
SWEP.MaxSpreadInc = 0.080
SWEP.SpreadPerShot = 0.0085
SWEP.SpreadCooldown = 0.14
SWEP.RecoilToSpread = .8
SWEP.Shots = 1
SWEP.Damage = 49
SWEP.DeployTime = .5

SWEP.ReloadSpeed = 1.02
SWEP.ReloadTime = 6.4
SWEP.ReloadTime_Empty = 6.4
SWEP.ReloadHalt = 6.4
SWEP.ReloadHalt_Empty = 6.4

SWEP.Offset = {
Pos = {
Up = -1,
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
	self.EffectiveRange = 138.6 * 39.37
	self.DamageFallOff = .26
	
	if self.ActiveAttachments.md_saker222 then
	self.EffectiveRange = ((self.EffectiveRange - 45.738 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff + .078))
	end
	if self.ActiveAttachments.am_matchgrade then
	self.EffectiveRange = ((self.EffectiveRange + 20.79 * 39.37))
	self.DamageFallOff = ((self.DamageFallOff - .039))
	end
end
