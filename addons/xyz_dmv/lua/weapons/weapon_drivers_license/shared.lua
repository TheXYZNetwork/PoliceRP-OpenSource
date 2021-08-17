SWEP.PrintName = "Drivers License"
SWEP.Author = "Owain Owjo"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 5
SWEP.SlotPos = 4

SWEP.Spawnable = true
SWEP.ViewModel = Model("models/freeman/c_owain_license.mdl")
SWEP.WorldModel = "models/freeman/w_owain_license.mdl"
SWEP.ViewModelFOV = 85
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false
SWEP.Base = "weapon_base"

SWEP.Secondary.Ammo = "none"

SWEP.HoldType = "pistol"

SWEP.isDriversLicense = true

SWEP.RenderGroup = RENDERGROUP_BOTH

function SWEP:Initialize()
	self:SetWeaponHoldType("pistol")
    self.isDriversLicense = true
end 

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

if CLIENT then
    function SWEP:DrawWorldModel()
    	local ply = self.Owner
        if not IsValid(ply) then return end
        
        if ply == LocalPlayer() then return end
        if LocalPlayer():GetPos():DistToSqr(ply:GetPos()) > 200000 then
            if self.LicenseModel then
                self.LicenseModel:Remove()
                self.LicenseModel = nil
            end
            return
        end
    	local ang = ply:EyeAngles()
		local pos
    	if not (ply:LookupBone("ValveBiped.Bip01_R_Hand") == nil) then
    		pos = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_R_Hand"))
    	else 
    		pos = ply:GetPos()
    	end

    	if not self.LicenseModel then
    		self.LicenseModel = ClientsideModel("models/freeman/w_owain_license.mdl")
            timer.Simple(5, function()
                if self.LicenseModel then
                    self.LicenseModel:Remove()
                    self.LicenseModel = nil
                end
            end)
    	end
        pos = pos + (ang:Forward()*4.5) + (ang:Right()*-2.5) + (ang:Up()*1.5)
    	self.LicenseModel:SetPos(pos)
    	self.LicenseModel:SetAngles(ang)
    end
    function SWEP:DrawWorldModelTranslucent()
        local ply = self.Owner
        if ply == LocalPlayer() then return end
        if LocalPlayer():GetPos():DistToSqr(ply:GetPos()) > 200000 then
            if self.LicenseFrame then
                self.LicenseFrame:Close()
                self.LicenseFrame = nil
            end
            return
        end
        local pos = self.LicenseModel:GetPos()
        local ang = self.LicenseModel:GetAngles()
        pos = pos + (ang:Forward()*0.1) + (ang:Right()*5.5) + (ang:Up()*1.5)
    
        if not self.LicenseFrame then
            local frame = vgui.Create("DFrame")
            frame:SetPos(120, 0)
            frame:SetSize(200, 120)
            frame:SetTitle("")
            frame:SetDraggable(false)
            frame:ShowCloseButton(false)
            frame.Paint = function(self, w, h)
                --draw.RoundedBox(0, 0, 0, w, h, Color(0, 255, 0))
                draw.SimpleText(ply:Name(), "xyz_font_11_static", 70, 35, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end

            avatar = vgui.Create("AvatarImage", frame)
            avatar:SetSize(42, 42)
            avatar:SetPos(12, 35)
            avatar:SetPlayer(ply, 64)
            self.LicenseFrame = frame

            timer.Simple(5, function()
                if self.LicenseFrame then
                    self.LicenseFrame:Close()
                    self.LicenseFrame = nil
                end
            end)
        end
        ang:RotateAroundAxis(ang:Up(), 90)
        ang:RotateAroundAxis(ang:Forward(), 90)
        vgui.Start3D2D(pos, ang, 0.025)
            self.LicenseFrame:Paint3D2D()
        vgui.End3D2D()
    end

    function SWEP:Holster()
    	if self.LicenseModel then
    		self.LicenseModel:Remove()
    		self.LicenseModel = nil
    	end
        if self.LicenseFrame then
            self.LicenseFrame:Close()
            self.LicenseFrame = nil
        end
    end

    function SWEP:PostDrawViewModel(entity, weapon, ply)
        local ply = self.Owner
        local pos, ang = entity:GetBonePosition(39)
        if not pos then return end
        if not ang then return end
    
        if not self.LicenseFrame then
            local frame = vgui.Create("DFrame")
            frame:SetPos(0, 0)
            frame:SetSize(200, 120)
            frame:SetTitle("")
            frame:SetDraggable(false)
            frame:ShowCloseButton(false)
            frame.Paint = function(self, w, h)
                --draw.RoundedBox(0, 0, 0, w, h, Color(0, 255, 0))
                draw.SimpleText(ply:Name(), "xyz_font_11_static", 70, 35, Color(0, 0, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end

            avatar = vgui.Create("AvatarImage", frame)
            avatar:SetSize(34, 34)
            avatar:SetPos(18, 35)
            avatar:SetPlayer(ply, 64)
            self.LicenseFrame = frame
        end
        ang:RotateAroundAxis(ang:Up(), 0)
        ang:RotateAroundAxis(ang:Forward(), 90)
        ang:RotateAroundAxis(ang:Right(), 105)
        -- 0, 91, 90
        --print(pos, ang)
        vgui.Start3D2D(pos + (ang:Up()*-14) - (ang:Forward()*3.3), ang, 0.028)
            self.LicenseFrame:Paint3D2D()
        vgui.End3D2D()
    end
end