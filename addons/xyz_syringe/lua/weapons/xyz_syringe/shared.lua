SWEP.PrintName = "Syringe"
SWEP.Author = "Owain Owjo"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true

SWEP.HoldType = "pistol"
SWEP.UseHands = true
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/freeman/c_owain_syringe.mdl"
SWEP.WorldModel = "models/freeman/w_owain_syringe.mdl"
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
end 

function SWEP:Deploy()
    local ply = self.Owner
    self:SetNextPrimaryFire(CurTime()+5)
    self:SetNextSecondaryFire(CurTime()+5)
    ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("draw"))
    timer.Simple(2.5, function()
        ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("idle"))
    end)
    return true
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
    ang:RotateAroundAxis(ang:Right(), 60)

	local pos
	if not (ply:LookupBone("ValveBiped.Bip01_R_Hand") == nil) then
		pos = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_R_Hand"))
	else 
		pos = ply:GetPos()
	end

	if not self.GunModel then
		self.GunModel = ClientsideModel("models/freeman/w_owain_syringe.mdl")
        timer.Simple(5, function() -- Used to prevent the floating model lol
            if self.GunModel then
                self.GunModel:Remove()
                self.GunModel = nil
            end
        end)
	end
    pos = pos + (ang:Forward()*3.3) + (ang:Right()*-1.5) + (ang:Up()*-3)
	self.GunModel:SetPos(pos)
	self.GunModel:SetAngles(ang)
end

function SWEP:Holster()
	if self.GunModel then
		self.GunModel:Remove()
		self.GunModel = nil
	end

    return true
end

function SWEP:PrimaryAttack()
    if CLIENT then return end

    local ply = self.Owner
    local target = ply:GetEyeTrace().Entity
    if not target:IsPlayer() then return end

    if ply:GetPos():Distance(target:GetPos()) > 250 then return end

    if target:Health() >= 100 then return end

    target:SetHealth(math.Clamp(0, 100, target:Health()+25))

    self:SetNextPrimaryFire(CurTime()+2.5)
    self:SetNextSecondaryFire(CurTime()+2.5)

    ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("inject_"..math.random(2)))
    timer.Simple(2.5, function()
        ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("idle"))
    end)
end


function SWEP:SecondaryAttack()
    if CLIENT then return end

    local ply = self.Owner

    if ply:Health() >= 100 then return end

    ply:SetHealth(math.Clamp(0, 100, ply:Health()+25))

    self:SetNextPrimaryFire(CurTime()+5)
    self:SetNextSecondaryFire(CurTime()+5)

    ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("inject_self"))
    timer.Simple(5, function()
        ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("idle"))
    end)
end