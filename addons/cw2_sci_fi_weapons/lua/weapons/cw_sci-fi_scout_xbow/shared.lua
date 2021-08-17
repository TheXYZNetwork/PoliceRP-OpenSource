AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.PrintName = "Crossbow"
if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "a"
	killicon.AddFont("cw2_sci-fi_scout_xbow", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.ZoomTextures = {{tex = surface.GetTextureID("sprites/scope_leo"), offset = {0, 1}}}
	SWEP.SimpleTelescopicsFOV = 75

	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellDelay = 0.7
	SWEP.ShellPosOffset = {x = 0, y = -2, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6
	SWEP.OverrideAimMouseSens = 0.2
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_snip_xxbow.mdl"
	SWEP.WMPos = Vector(0, 0, -2)
	SWEP.WMAng = Vector(-10, 0, 180)
	
	SWEP.IronsightPos = Vector(0, 0, 0) --Vector(5.1, 0, 1.3)
	SWEP.IronsightAng = Angle(0, 0, 0) --Angle(0, 0, -2)
	
	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-20, -10, 0)
	
	SWEP.AlternativePos = Vector(0.2, 0, -1)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.AimBreathingEnabled = true
	SWEP.CrosshairEnabled = false
	
	SWEP.HipFireFOVIncrease = false

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.RTAlign = {right = 1.2, up = 0.25, forward = 0}
	
	SWEP.OverallMouseSens = 0.7
end

SWEP.MuzzleVelocity = 936 -- in meter/s

SWEP.SightBGs = {main = 2, none = 1}
SWEP.ADSFireAnim = true
SWEP.PreventQuickScoping = true
SWEP.QuickScopeSpreadIncrease = 0.2

SWEP.Attachments = {}

SWEP.Animations = {
	fire = {"2"},
	reload = "3",
	idle = "1",
	draw = "4"
}
	
SWEP.Sounds = {
	["4"] = {
		{time = 0.2, sound = "CW_SCIFI_SCOUT_XBOW_DEPLOY"}
	},

	["3"] = {
		[1] = {time = 0.5, sound = "CW_SCIFI_SCOUT_XBOW_RELOAD"},
		[2] = {time = 2.4, sound = "CW_SCIFI_SCOUT_XBOW_RELOAD"}
	}
}

SWEP.SpeedDec = 40

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "CW 2.0 - Sci-Fi"

SWEP.Author			= "Owain"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_snip_xxbow.mdl"
SWEP.WorldModel		= "models/weapons/w_snip_xxbow.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 60
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 0.3
SWEP.FireSound = "CW_SCIFI_SCOUT_XBOW_FIRE"
SWEP.FireSoundSuppressed = "CW_SCIFI_SCOUT_XBOW_FIRE"
SWEP.Recoil = 1.5

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.002
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.17
SWEP.Shots = 1
SWEP.Damage = 45
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.5
SWEP.ReloadTime_Empty = 3.5
SWEP.ReloadHalt = 3.5
SWEP.ReloadHalt_Empty = 3.5

if CLIENT then
	local old, x, y, ang
	local reticle = surface.GetTextureID("sprites/scope_leo")

	local lens = surface.GetTextureID("cw2/gui/lense")
	local lensMat = Material("cw2/gui/lense")
	local cd, alpha = {}, 0.5
	local Ini = true

	-- render target var setup
	cd.x = 0
	cd.y = 0
	cd.w = 512
	cd.h = 512
	cd.fov = 3
	cd.drawviewmodel = false
	cd.drawhud = false
	cd.dopostprocess = false

	function SWEP:RenderTargetFunc()
		--PrintTable(self:GetMaterials())
		local complexTelescopics = self:canUseComplexTelescopics()
		
		-- if we don't have complex telescopics enabled, don't do anything complex, and just set the texture of the lens to a fallback 'lens' texture
		if not complexTelescopics then
			self.TSGlass:SetTexture("$basetexture", lensMat:GetTexture("$basetexture"))
			return
		end
		
		if self.dt.State == CW_AIMING then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
		end
		
		x, y = ScrW(), ScrH()
		old = render.GetRenderTarget()

		ang = LocalPlayer():EyeAngles() + LocalPlayer():GetPunchAngle()
		
		if self.ViewModelFlip then
			ang.r = -self.BlendAng.z
		else
			ang.r = self.BlendAng.z
		end
		
		if not self.freeAimOn then
			ang:RotateAroundAxis(ang:Right(), self.RTAlign.right)
			ang:RotateAroundAxis(ang:Up(), self.RTAlign.up)
			ang:RotateAroundAxis(ang:Forward(), self.RTAlign.forward)
		end
		
		local size = self:getRenderTargetSize()

		cd.w = size
		cd.h = size
		cd.angles = ang
		cd.origin = self.Owner:GetShootPos()
		render.SetRenderTarget(self.ScopeRT)
		render.SetViewPort(0, 0, size, size)
			if alpha < 1 or Ini then
				render.RenderView(cd)
				Ini = false
			end
			
			ang = self.Owner:EyeAngles()
			ang.p = ang.p + self.BlendAng.x
			ang.y = ang.y + self.BlendAng.y
			ang.r = ang.r + self.BlendAng.z
			ang = -ang:Forward()

			local light = render.ComputeLighting(self.Owner:GetShootPos(), ang)
			
			cam.Start2D()
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(reticle)
				surface.DrawTexturedRect(0, 0, size, size)
				XYZUI.DrawCircle(0, 0, size, 1)
				
				surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], 255 * alpha)
				surface.SetTexture(lens)
				surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size, size, 90)
			cam.End2D()
		render.SetViewPort(0, 0, x, y)
		render.SetRenderTarget(old)
		
		if self.TSGlass then
			self.TSGlass:SetTexture("$basetexture", self.ScopeRT)
		end
	end
end

--SWEP.AimPos = 
--SWEP.AimAng = `