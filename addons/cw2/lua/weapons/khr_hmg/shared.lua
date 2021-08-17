AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo(".50 BMG", ".50 BMG", 12.7, 99)
	SWEP.PrintName = ".50 HMG"

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.5
	SWEP.HUD_MagText = "BOX: "
	SWEP.Chamberable = false
	
	SWEP.IconLetter = "z"
	killicon.Add( "khr_hmg", "icons/killicons/khr_hmg", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_hmg")
	
	SWEP.MuzzleEffect = "muzzle_center_M82"
	SWEP.PosBasedMuz = false
	SWEP.ShellScale = 1
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.FireMoveMod = 1
	SWEP.CustomizationMenuScale = 0.045
	
	SWEP.IronsightPos = Vector(-1, -3, 1.039)
	SWEP.IronsightAng = Vector(0, 2.406, 0)

	SWEP.SightWithRail = false
	
	SWEP.AlternativePos = Vector(1.44, 0, -1.281)
	SWEP.AlternativeAng = Vector(0, 2, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "BODY", rel = "", pos = Vector(.4, 2.359, 15.06), angle = Angle(180, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), bodygroup = {1,1}}
	}
 
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = .5, roll = .5, forward = 1.4, pitch = 1.5}
end

SWEP.MuzzleVelocity = 880

SWEP.BipodInstalled = true
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.FullAimViewmodelRecoil = true
SWEP.BipodFireAnim = true
SWEP.CanRestOnObjects = true

SWEP.Attachments = {}

SWEP.Animations = {fire = {"shoot1"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0.5, sound = "KM60.Draw"}},

	
	reload = {[1] = {time = .8, sound = "HMG.Down"},
	[2] = {time = 2.3, sound = "HMG.Up"}}}
	
SWEP.SpeedDec = 90
SWEP.Chamberable = false
SWEP.Slot = 4
SWEP.CrosshairEnabled = false
SWEP.AimingEnabled = false
SWEP.ADSFireAnim = true
SWEP.SlotPos = 0
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Special"

SWEP.Author			= "Khris"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 80
SWEP.AimViewModelFOV = 80
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_crysihmgpara.mdl"
SWEP.WorldModel		= "models/khrcw2/w_khri_crysihmgpara.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.OverallMouseSens = .4
SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 100
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ".50 BMG"

SWEP.FireDelay = 0.15
SWEP.RecoilToSpread = 0.8
SWEP.FireSound = "HMG_FIRE"
SWEP.Recoil = 2.5
SWEP.BipodRecoilModifier = .25
SWEP.FOVPerShot = 3
SWEP.HipSpread = 0.04
SWEP.AimSpread = 0.02
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.075
SWEP.SpreadPerShot = 0.006
SWEP.SpreadCooldown = 0.18
SWEP.Shots = 1
SWEP.Damage = 100
SWEP.DeployTime = 1.5

SWEP.ReloadSpeed = .8
SWEP.ReloadTime = 3.2
SWEP.ReloadTime_Empty = 3.2
SWEP.ReloadHalt = 3.2
SWEP.ReloadHalt_Empty = 3.2

SWEP.Offset = {
Pos = {
Up = 1,
Right = 0,
Forward = 12,
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