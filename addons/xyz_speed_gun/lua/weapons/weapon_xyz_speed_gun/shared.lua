SWEP.PrintName = "Speedgun"
SWEP.Author = "Owain Owjo"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true

SWEP.HoldType = "pistol"
SWEP.UseHands = true
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/freeman/c_owain_radargun.mdl"
SWEP.WorldModel = "models/freeman/w_owain_radargun.mdl"
SWEP.IronSightsPos = Vector(-6.85, -13.9, 3.96)
SWEP.IronSightsAng = Vector(0.5, -2, 0)


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

function SWEP:Initialize()
	self:SetWeaponHoldType("pistol")
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)

	self.curSpeed = 0
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
        pos = pos + (ang:Forward()*5.5) + (ang:Right()*-1) + (ang:Up()*2)
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

    function SWEP:PostDrawViewModel(entity, weapon, ply)
		local ply = self.Owner
		local pos, ang = entity:GetBonePosition(23)
		if not pos then return end
		if not ang then return end
		ang:RotateAroundAxis(ang:Forward(), 88)
		ang:RotateAroundAxis(ang:Right(), 95)
		ang:RotateAroundAxis(ang:Up(), 180)

		cam.Start3D2D(pos + (ang:Right()*-7.5) + (ang:Up()*-0.8) + (ang:Forward()*-3), ang, 0.028)
--		    draw.RoundedBox(0, 0, 0, 100, 60, Color(0, 255, 0))
		    draw.SimpleText(self.curSpeed.." MPH", "xyz_font_30_static", 50, 30, Color(255, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		cam.End3D2D()
    end
	
	function SWEP:Think()
		self:SetNextClientThink(CurTime()+1)

		local ply = self.Owner
		local car = ply:GetEyeTrace().Entity
		if not car:IsVehicle() then self.curSpeed = 0 return end
		self.curSpeed = math.Round(car:VC_getSpeedKmH()*0.6)

		if not (car == PNC.SelectedVehicle) then
			XYZShit.Msg("PNC", PNC.Config.Color, "The vehicle you're looking at has been pulled up on your PNC!")
			PNC.SelectedVehicle = car
			PNC.SelectedVehicleHasLicense = "error"
		end

		return true
	end
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime()+1)
	self.curSpeed = 0
end