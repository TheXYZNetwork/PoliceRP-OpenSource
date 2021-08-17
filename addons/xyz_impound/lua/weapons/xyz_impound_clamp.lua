SWEP.PrintName = "Clamp"
SWEP.Author = "Owain"
SWEP.Category = "The XYZ Network"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true

SWEP.HoldType = "pistol"
SWEP.UseHands = true
SWEP.ViewModelFOV = 85
SWEP.ViewModelFlip = false
SWEP.ViewModel			    = "models/freeman/c_wheelclamp.mdl"
SWEP.WorldModel			    = "models/freeman/wheel_clamp.mdl"


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
end 

function SWEP:Holster()
	return true
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
	self:SetNextPrimaryFire(CurTime()+3)
	local ply = self:GetOwner()

	local car = ply:GetEyeTrace().Entity
	if not car:IsVehicle() then return end

	if ply:GetPos():Distance(car:GetPos()) > 300 then return end

	if not car:getDoorOwner() then
		XYZShit.Msg("Impound", Impound.Config.Color, "You cannot clamp an unowned car!")
		return
	end

	if XYZShit.IsGovernment(car:getDoorOwner():Team(), true) then
		XYZShit.Msg("Impound", Impound.Config.Color, "You cannot clamp a government car!", ply)
		return
	end

	if car.isClamped then
		XYZShit.Msg("Impound", Impound.Config.Color, "This is already clamped.", ply)
		return
	end

	if Impound.Config.Blacklist[car:GetVehicleClass()] then
		XYZShit.Msg("Impound", Impound.Config.Color, "You cannot clamp this vehicle.", ply)
		return
	end

	local canClamp, reason = hook.Run("ImpoundCanClamp", ply, car)

	if (canClamp == false) and reason then
		XYZShit.Msg("Impound", Impound.Config.Color, reason, ply)
		return
	end

	ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("throw"))

	timer.Simple(1.5, function()
		if not car then return end
		if ply:GetPos():Distance(car:GetPos()) > 300 then return end

		if car:GetSpeed() > 10 then
			XYZShit.Msg("Impound", Color(200, 60, 120), "The vehicle is moving.", ply)
			return
		end

		Impound.Core.Clamp(car, ply, (ply:Team() == TEAM_MECHANIC) and ply.mechprice or Impound.Config.ClampFee)
	end)
end

function SWEP:SecondaryAttack()
	if CLIENT then return end
	self:SetNextSecondaryFire(CurTime()+3)
	local ply = self:GetOwner()

	local car = ply:GetEyeTrace().Entity
	if not car:IsVehicle() then return end

	if ply:GetPos():Distance(car:GetPos()) > 300 then return end

	if not IsValid(car.isClamped) then
		XYZShit.Msg("Impound", Impound.Config.Color, "This vehicle is not clamped.", ply)
		return
	end

	car.isClamped:Remove()
	car.isClamped = nil
	
	timer.Remove("Impound:Clamp:"..car:EntIndex())
	xLogs.Log(xLogs.Core.Player(ply).." has unclamped "..xLogs.Core.Color(car:GetVehicleClass(), Color(0, 0, 200))..".", "Impound")

	XYZShit.Msg("Impound", Color(200, 60, 120), "You have removed the clamp from this vehicle.", ply)
end

function SWEP:Reload()
end