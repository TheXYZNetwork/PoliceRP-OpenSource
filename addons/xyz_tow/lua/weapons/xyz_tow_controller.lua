SWEP.PrintName = "Tow Controller"
SWEP.Author = "Smith Bob"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true

SWEP.UseHands = false
SWEP.ViewModelFOV = 95
SWEP.ViewModelFlip = false
SWEP.ViewModel			    = "models/sterling/mechanical_c_remotecontrol.mdl"
SWEP.WorldModel			    = "models/sterling/mechanical_w_remotecontrol.mdl"


SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize 	 = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.UseHands = true

SWEP.DrawAmmo = false
SWEP.Base = "weapon_base"

SWEP.Secondary.Ammo = "none"
SWEP.HoldType = "normal"

function SWEP:SetupDataTables()
    self:NetworkVar("Int", 0, "Mode" )
end

local modes = {
	[1] = {
		name = "(Un)lock trailer",
		func = function(truck, ply)
		-- Unlock (ID 1)
		local entTrailer = truck.trailer

		if ( not IsValid(entTrailer) ) then return end 

		local bool = truck:MSystem_Lock(not entTrailer.boolLocked)

		if ( bool ) then
			if ( entTrailer.boolLocked ) then
				XYZShit.Msg("Mechanic", Color(213, 195, 30), "Trailer locked", ply)
				xLogs.Log(xLogs.Core.Player(ply).." locked their Tow Truck's trailer", "Tow Truck")
			else
				XYZShit.Msg("Mechanic", Color(213, 195, 30), "Trailer unlocked", ply)
				xLogs.Log(xLogs.Core.Player(ply).." unlocked their Tow Truck's trailer", "Tow Truck")
			end
		else
			XYZShit.Msg("Mechanic", Color(213, 195, 30), "Trailer needs to be up for you to be able to lock it", ply)
		end
	end
},
[2] = {
	name = "Move Trailer",
	func = function(truck, ply)
		-- Move truck down
		local entTrailer = truck.trailer

		if ( not IsValid(entTrailer) ) then return end 

		if ( entTrailer.boolLocked ) then
			XYZShit.Msg("Mechanic", Color(213, 195, 30), "Trailer is locked!", ply)
			return
		end
		xLogs.Log(xLogs.Core.Player(ply).." made their Tow Truck move", "Tow Truck")
		entTrailer:SetGoingDown(not entTrailer.boolGoingDown)
	end
},
[3] = {
	name = "Shrink Rope",
	func = function(truck, ply)
		local boolCan = truck:MSystem_HasRope()

		if ( not boolCan ) then
			XYZShit.Msg("Mechanic", Color(213, 195, 30), "You need to link the rope!", ply)
			return
		end 

		local entHook = truck.hook.hook
		if ( entHook.boolRopeSizing and entHook.boolGettingBigger ) then
			entHook:SetRopeConfig(true, false)
		else
			entHook:SetRopeConfig(not entHook.boolRopeSizing, false)
		end
		xLogs.Log(xLogs.Core.Player(ply).." made their Tow Truck's rope shrink", "Tow Truck")
	end
},
[4] = {
	name = "Enlarge Rope",
	func = function(truck, ply)
		local boolCan = truck:MSystem_HasRope()

		if ( not boolCan ) then
			XYZShit.Msg("Mechanic", Color(213, 195, 30), "You need to link the rope!", ply)
			return
		end

		local entHook = truck.hook.hook
		if ( entHook.boolRopeSizing and not entHook.boolGettingBigger ) then
			entHook:SetRopeConfig(true, true)
		else
			entHook:SetRopeConfig(not entHook.boolRopeSizing, true)
		end
		xLogs.Log(xLogs.Core.Player(ply).." made their Tow Truck's rope enlarge", "Tow Truck")
	end
}
}

function SWEP:Initialize()
    self:SetHoldType("normal")
    self:SetMode(1)
end 

function SWEP:Reload()
	if CLIENT then return end
	if self.NextReload and self.NextReload > CurTime() then return end
	self.NextReload = CurTime() + .5
    local newmode = self:GetMode() + 1
    if newmode > #modes then newmode = 1 end
    self:SetMode(newmode)
    XYZShit.Msg("Mechanic", Color(213, 195, 30), "Mode set to "..modes[newmode].name, self.Owner)
end 

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 2)
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK_1)
	timer.Simple(1.1, function()
        if not IsValid(self) then return end

        if CLIENT and (self.intNextSound or 0) < CurTime() then
            surface.PlaySound("buttons/button15.wav")
        end
        
        if CLIENT then return end
        if not IsValid(self.Owner.TowTruck) then return end

        modes[self:GetMode()].func(self.Owner.TowTruck, self.Owner)
    end)
end

if SERVER then return end

local w = 300
local h = 170

function SWEP:PostDrawViewModel( vm )
	local pos = vm:GetPos()
	pos = pos + vm:GetForward() * 12.8 + vm:GetRight() * 6.45 + vm:GetUp() * 2
	local ang = vm:GetAngles()

	ang:RotateAroundAxis( ang:Up(), 90)
	ang:RotateAroundAxis( ang:Right(), 180)
	ang:RotateAroundAxis( ang:Forward(), -95)



	cam.Start3D2D( pos, ang, 0.01 )
        -- draw.RoundedBox(0, 0, 0, intW, intH, Color(44, 62, 80))
        XYZUI.DrawShadowedBox(0, 0, w, h)
        XYZUI.DrawScaleText(modes[self:GetMode()].name, "19", w * 0.5, h * 0.5 , color_white, 1)
        XYZUI.DrawScaleText("R: Switch Action", "15", w * 0.5, h * 0.8 , color_white, 1)
	cam.End3D2D()
end