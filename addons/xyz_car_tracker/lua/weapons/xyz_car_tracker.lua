SWEP.PrintName = "Car Tracker"
SWEP.Author = "Owain"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 2
SWEP.SlotPos = 1

SWEP.Spawnable = true

SWEP.HoldType = "pistol"
SWEP.UseHands = true
SWEP.ViewModelFOV = 40
SWEP.ViewModelFlip = false
SWEP.ViewModel			    = "models/navigation/gps/v_gps.mdl"
SWEP.WorldModel			    = Model("models/navigation/gps/w_gps.mdl")


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
    if CLIENT then return end
	if XYZShit.CoolDown.Check("CarTracker:Primary", 3) then return end

    local ply = self.Owner

    local car = ply:GetEyeTrace().Entity
    if not car:IsVehicle() then return end

    local owner = car:getDoorOwner()
    if not IsValid(owner) then return end

    if ply:GetPos():Distance(car:GetPos()) > 300 then return end

    local viewmodel = ply:GetViewModel()
    viewmodel:SendViewModelMatchingSequence(viewmodel:LookupSequence("button"))

	timer.Simple(1, function()
		net.Start("CarTracker:AddTracking")
			net.WriteEntity(owner)
			net.WriteEntity(car)
		net.Send(ply)

		XYZShit.Msg("Car Tracker", CarTracker.Config.Color, "You have placed a tracker on "..owner:Name().."'s car.", ply)
		xLogs.Log(xLogs.Core.Player(ply).." has placed a tracker on "..xLogs.Core.Player(owner).."'s car", "Car Tracker")

		self:Remove()
	end)
end

function SWEP:SecondaryAttack()
end

function SWEP:Holster()
	return true
end

function SWEP:Reload()
end