SWEP.PrintName = "PNC Tablet"
SWEP.Author = "Smith Bob And Then Owain"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 5
SWEP.SlotPos = 4

SWEP.Spawnable = true

SWEP.HoldType = "pistol"
SWEP.UseHands = true
SWEP.ViewModelFOV = 85
SWEP.ViewModelFlip = false
SWEP.ViewModel			    = "models/stim/venatuss/car_dealer/tablet/c_tablet.mdl"
SWEP.WorldModel			    = "models/stim/venatuss/car_dealer/tablet/tablet.mdl"


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
end 

function SWEP:PrimaryAttack()
	if CLIENT then return end
	self:SetNextPrimaryFire(CurTime()+2)
	
	local trace = self.Owner:GetEyeTrace().Entity
	local target = (IsValid(trace) and trace:IsVehicle() and trace) or nil

	if not target then
		XYZShit.Msg("PNC", PNC.Config.Color, "No vehicle found", self.Owner)
		return
	end

	if not target then return end

	if target:GetPos():Distance(self.Owner:GetPos()) > 215 then return end

	local owner = target:getDoorOwner()
	net.Start("xyz_pnc_select")
		net.WriteEntity(target)
		net.WriteBool(isnumber(licensedUsers[owner:SteamID64()]))
	net.Send(self.Owner)
end

function SWEP:SecondaryAttack()
	if CLIENT then return end
	self:SetNextSecondaryFire(CurTime()+2)
	net.Start("xyz_pnc_open")
		net.WriteBool(true)
	net.Send(self.Owner)
end

function SWEP:Reload()
	if SERVER then return end
	
	PNC.SelectedVehicle = nil
end



if CLIENT then
    function SWEP:DrawWorldModel()
    	local ply = self.Owner
        if ply == LocalPlayer() then return end
        if LocalPlayer():GetPos():DistToSqr(ply:GetPos()) > 200000 then
            if self.GunModel then
                self.GunModel:Remove()
                self.GunModel = nil
            end
            return
        end
    	local ang = ply:EyeAngles()
		ang:RotateAroundAxis(ang:Right(), 90)
		ang:RotateAroundAxis(ang:Up(), 180)
		local pos
    	if not (ply:LookupBone("ValveBiped.Bip01_R_Hand") == nil) then
    		pos = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_R_Hand"))
    	else 
    		pos = ply:GetPos()
    	end

    	if not self.GunModel then
    		self.GunModel = ClientsideModel(self.WorldModel)
            timer.Simple(5, function() -- Used to prevent the floating model lol
                if self.GunModel then
                    self.GunModel:Remove()
                    self.GunModel = nil
                end
            end)
    	end
        pos = pos + (ang:Forward()*-4) + (ang:Right()*10) + (ang:Up()*-4)
    	self.GunModel:SetPos(pos)
    	self.GunModel:SetAngles(ang)
    end

    function SWEP:Holster()
        if self.GunModel then
            self.GunModel:Remove()
            self.GunModel = nil
        end
        self.curSpeed = 0
    end

	local grey = Color(40, 40, 40)
	function SWEP:PostDrawViewModel(entity, weapon, ply)
		local pos, ang = entity:GetBonePosition(24)
		if not pos then return end
		if not ang then return end
		ang:RotateAroundAxis(ang:Forward(), 90)
		ang:RotateAroundAxis(ang:Up(), -35)
		ang:RotateAroundAxis(ang:Right(), 95)
		ang:RotateAroundAxis(ang:Up(), -4.5)
		ang:RotateAroundAxis(ang:Forward(), -5.5)
		ang:RotateAroundAxis(ang:Right(), 1)
	
		cam.Start3D2D(pos + (ang:Up()*-22.3) + (ang:Forward()*4.55) + (ang:Right()*-13.8), ang, 0.01)
		    draw.RoundedBox(0, -460, -290, 940, 600, grey)
		    XYZUI.DrawText("Police National Computer", 70, 0, 0, PNC.Config.Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		    XYZUI.DrawText("Logged in as: "..LocalPlayer():Name(), 35, 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		    XYZUI.DrawText("Left Click - Select Vehicle | Right Click - Open PNC | R - Reset Vehicle", 25, 0, 305, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		cam.End3D2D()
	end
	
	function SWEP:GetViewModelPosition(pos, ang)
		pos = pos + (ang:Forward() * -12) + (ang:Up() * -12) + (ang:Right() * -3)
		ang:RotateAroundAxis(ang:Right(), 30)
	
	    return pos, ang
	end
	
end