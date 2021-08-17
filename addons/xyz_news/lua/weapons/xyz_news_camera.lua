SWEP.PrintName = "News Camera"
SWEP.Author = "Owain"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true

SWEP.HoldType = "pistol"
SWEP.UseHands = true
SWEP.ViewModelFOV = 85
SWEP.ViewModelFlip = false
SWEP.ViewModel			    = ""
SWEP.WorldModel			    = "models/weapons/w_camera.mdl"


SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize 	 = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false
SWEP.Base = "weapon_base"

SWEP.Secondary.Ammo = "none"

SWEP.HoldType = ""

function SWEP:Initialize()
	self:SetHoldType("rpg")
end 

function SWEP:Holster()
	if SERVER then
		NewsSystem.Core.StopStreaming()
	end

	return true
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
		
	if NewsSystem.Data.IsLive then
		NewsSystem.Core.StopStreaming()
	else
		NewsSystem.Core.StartStreaming(self.Owner)
	end

	self:SetNextPrimaryFire(CurTime()+2)
end

function SWEP:SecondaryAttack()
	if SERVER then return end
	if XYZShit.CoolDown.Check("NewsSystem:Menu", 2) then return end

	self:SetNextSecondaryFire(CurTime()+2)
	NewsSystem.Core.Menu()
end

function SWEP:Reload()
	self:SetHoldType("rpg")
end

local red = Color(155, 0, 0)
local boarder = Color(255, 255, 255, 155)
local buffer = 100
function SWEP:DrawHUD()
	local scrW, scrH = ScrW(), ScrH()


	local widthLength = (scrW*0.25) - 15
	local widthHeight = 10

	local tallLength = 10
	local tallHeight = (scrH*0.25) - 15

	-- Top left
	draw.RoundedBox(0, buffer, buffer, widthLength - buffer, widthHeight, boarder)
	draw.RoundedBox(0, buffer, buffer + tallLength, tallLength, tallHeight, boarder)

	-- Top right
	draw.RoundedBox(0, scrW - widthLength - buffer, buffer, widthLength, widthHeight, boarder)
	draw.RoundedBox(0, scrW - buffer - tallLength, tallLength + buffer, tallLength, tallHeight, boarder)

	-- Bottom left
	draw.RoundedBox(0, buffer, scrH - widthHeight - buffer, widthLength - buffer, widthHeight, boarder)
	draw.RoundedBox(0, buffer, scrH - widthHeight - tallHeight - buffer, tallLength, tallHeight, boarder)

	-- Bottom right
	draw.RoundedBox(0, scrW - widthLength - buffer, scrH - widthHeight - buffer, widthLength, widthHeight, boarder)
	draw.RoundedBox(0, scrW - buffer - tallLength, scrH - tallHeight - tallLength - buffer, tallLength, tallHeight, boarder)

	if NewsSystem.Data.IsLive then
		draw.RoundedBox(0, buffer + buffer, buffer + buffer, 200, 100, boarder)
		XYZUI.DrawScaleText("Live", 30, buffer + buffer + 100, buffer + buffer + 50, red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end


function SWEP:HUDShouldDraw(name)
	-- So we can change weapons
	if ( name == "CHudWeaponSelection" ) then return true end
	if ( name == "CHudChat" ) then return true end
	if ( name == "CHudGMod" ) then return true end

	return false
end