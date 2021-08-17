SWEP.PrintName = "Cuffed"
SWEP.Author = "Owain Owjo"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true
SWEP.ViewModel = ""
SWEP.WorldModel = "models/freeman/w_owain_speedcuffs.mdl"
SWEP.ViewModelFOV = 85
SWEP.UseHands = true

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

SWEP.RenderGroup = RENDERGROUP_BOTH

function SWEP:Initialize()
    self:SetHoldType("normal")
end 

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime()+3)
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime()+5)
end


function SWEP:Reload()
end

if CLIENT then
    function SWEP:DrawWorldModel()
        local ply = self.Owner
        if ply == LocalPlayer() then return end
        if LocalPlayer():GetPos():DistToSqr(ply:GetPos()) > 200000 then return end

        local ang = ply:EyeAngles() + Angle(0, (CurTime()*100)%360, 90)
        local pos = ply:GetPos()
        pos = pos + Vector(0, 0, 70)
        cam.Start3D2D(pos, ang, 0.1)
            draw.SimpleText("Cuffed", "xyz_font_16", 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
        cam.End3D2D()
        cam.Start3D2D(pos, ang-Angle(0, -180, 0), 0.1)
            draw.SimpleText("Cuffed", "xyz_font_16", 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
        cam.End3D2D()
    end

    function SWEP:Holster()
        if self.WeaponModel then
            self.WeaponModel:Remove()
            self.WeaponModel = nil
        end
    end

    function SWEP:DrawHUD()
        if not self.Owner == LocalPlayer() then return end

        XYZUI.DrawText("You are cuffed", 60, ScrW()/2, 20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end
end