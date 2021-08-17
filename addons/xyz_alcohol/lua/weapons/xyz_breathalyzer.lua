SWEP.PrintName = "Breathalyzer"
SWEP.Author = "Owain"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 5
SWEP.SlotPos = 4

SWEP.Spawnable = true

SWEP.HoldType = "pistol"
SWEP.UseHands = true
SWEP.ViewModelFOV = 40
SWEP.ViewModelFlip = false
SWEP.ViewModel			    = "models/weapons/c_breathalyzer.mdl"
SWEP.WorldModel			    = "models/weapons/w_breathalyzer.mdl"


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
    self:SetHoldType("")

    self.lastHolster = 0
end 

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime()+2)
	if CLIENT then return end

	local target = self:GetOwner():GetEyeTrace().Entity
	if (not IsValid(target)) or (not target:IsPlayer()) then return end
	if target:GetPos():DistToSqr(self:GetOwner():GetPos()) > 9000 then return end


	net.Start("Alcohol:Breathalyzer:Request")
		net.WriteUInt(Alcohol.Units[target:SteamID64()] or 0, 7)
	net.Send(self:GetOwner())
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime()+2)
	if SERVER then return end

	self.curValue = 0
end

function SWEP:Reload()
end

if CLIENT then
	net.Receive("Alcohol:Breathalyzer:Request", function()
		local wep = LocalPlayer():GetActiveWeapon()
		if not (wep:GetClass() == "xyz_breathalyzer") then return end

		wep.curValue = net.ReadUInt(7)
	end)

	local red = Color(100, 0, 0)
	function SWEP:PostDrawViewModel(entity, weapon, ply)
		local pos, ang = entity:GetBonePosition(24)
		if not pos then return end
		if not ang then return end
		ang:RotateAroundAxis(ang:Forward(), 90)
		ang:RotateAroundAxis(ang:Up(), -4)
		ang:RotateAroundAxis(ang:Right(), 95)
		ang:RotateAroundAxis(ang:Up(), 6)
		ang:RotateAroundAxis(ang:Forward(), -5.5)
		ang:RotateAroundAxis(ang:Right(), 1)
	
		cam.Start3D2D(pos + (ang:Up()*-23) + (ang:Forward()*-0.1) + (ang:Right()*-1.3), ang, 0.01)
		    XYZUI.DrawText(self.curValue or 0, 70, 0, 0, ((self.curValue or 0) < Alcohol.Config.DrunkAmount) and color_black or red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		cam.End3D2D()
	end
end