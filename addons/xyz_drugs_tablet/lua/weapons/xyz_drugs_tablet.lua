SWEP.PrintName = "Drugs Tablet"
SWEP.Author = "Owain"
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

    self.lastHolster = 0
end 

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime()+2)
	if SERVER then return end
    if XYZShit.CoolDown.Check("DrugsTable:Primary", 2) then return end

    if not XYZDrugsTable.ActiveItem then return end

    net.Start("Cocaine:BuyItem")
        net.WriteString(XYZDrugsTable.ActiveItem)
    net.SendToServer()
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime()+2)
	if SERVER then return end
    if XYZShit.CoolDown.Check("DrugsTable:Secondary", 2) then return end

	XYZDrugsTable.Core.OpenMenu()
end

function SWEP:Reload()
end



if CLIENT then
    local currentEnt
    function SWEP:Think()
        if not XYZDrugsTable.ActiveItem then self:Holster() return end
        local entData = scripted_ents.Get(XYZDrugsTable.ActiveItem)

        if (not XYZDrugsTable.ActiveItem) or (not entData) or (not entData.Model) then
            self:Holster()
            return
        end
    
        if (not IsValid(currentEnt)) and (self.lastHolster < (CurTime() - 0.5)) then
            currentEnt = ents.CreateClientProp()
            currentEnt:SetModel(entData.Model)
            currentEnt:SetMaterial("models/wireframe")
            currentEnt:Spawn()
        end

        if not IsValid(currentEnt) then return end -- We're in the process of holstering
        
        if not (currentEnt:GetModel() == entData.Model) then
            currentEnt:SetModel(entData.Model)
        end
        trace = LocalPlayer():GetEyeTrace()
        plyAngle = LocalPlayer():GetAngles()
        currentEnt:SetPos(trace.HitPos + plyAngle:Forward() + plyAngle:Up())
        currentEnt:SetAngles(Angle(0, math.Round(plyAngle.y/10)*10 + 180, plyAngle.z))
    end

    function SWEP:Reload()
        XYZDrugsTable.ActiveItem = nil
        self:Holster()
    end


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

        if IsValid(currentEnt) then
            currentEnt:Remove()
            currentEnt = nil
            self.lastHolster = CurTime()
        end
    end

	local backPlate = Color(100, 40, 40)
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
	
		cam.Start3D2D(pos + (ang:Up()*-22.3) + (ang:Forward()*4.5) + (ang:Right()*-13.8), ang, 0.01)
		    draw.RoundedBox(0, -460, -290, 940, 600, backPlate)
		    XYZUI.DrawText("Buy Drugs", 70, 0, 0, XYZDrugsTable.Config.Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		    XYZUI.DrawText("How to Sell Drugs Online (Fast)", 35, 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		    XYZUI.DrawText("Left Click - Purchase Selected Item | Right Click - Buy Drug Equipment, Find Drug Guides", 25, 0, 305, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		cam.End3D2D()
	end
	
	function SWEP:GetViewModelPosition(pos, ang)
		pos = pos + (ang:Forward() * -12) + (ang:Up() * -13) + (ang:Right() * -2)
		ang:RotateAroundAxis(ang:Right(), 30)
	
	    return pos, ang
	end
end