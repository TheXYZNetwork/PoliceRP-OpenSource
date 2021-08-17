SWEP.PrintName = "User Info"
SWEP.Author = "Owain Owjo"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 5
SWEP.SlotPos = 4

SWEP.Spawnable = true
SWEP.ViewModel			    = "models/props_lab/clipboard.mdl"
SWEP.WorldModel			    = ""
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

function SWEP:Initialize()
    self:SetHoldType("")
end 

function SWEP:PrimaryAttack()
	if CLIENT then return end
	self:SetNextPrimaryFire(CurTime()+2)

	local trace = self.Owner:GetEyeTrace().Entity
	local target = (IsValid(trace) and trace:IsPlayer() and trace) or nil

	if target then
		local _, teamType = XYZTracker.Core.GetJobInfo(target:Team())
		if not teamType then return end
		XYZTracker.Database.GetSessionsByID(target:SteamID64(), teamType, function(data, error)
			if not data then
				XYZShit.Msg("Tracker", Color(200, 255, 0), error, self.Owner)
				return
			end
			net.Start("JobTrackerSearchPlayer")
				net.WriteString(target:SteamID64())
				net.WriteTable(data)
			net.Send(self.Owner)
		end)
	else
		XYZShit.Msg("Tracker", Color(200, 255, 0), "Target not valid", self.Owner)
		return
	end
end

function SWEP:SecondaryAttack()
	if CLIENT then return end
	self:SetNextSecondaryFire(CurTime()+2)

	local _, teamType = XYZTracker.Core.GetJobInfo(self.Owner:Team())
	if not teamType then return end
	XYZTracker.Database.GetSessionsByID(self.Owner:SteamID64(), teamType, function(data, error)
		if not data then
			XYZShit.Msg("Tracker", Color(200, 255, 0),  error, self.Owner)
			return
		end
		net.Start("JobTrackerSearchPlayer")
			net.WriteString(self.Owner:SteamID64())
			net.WriteTable(data)
		net.Send(self.Owner)
	end)
end


function SWEP:Reload()
end

function SWEP:GetViewModelPosition(pos, ang)
    pos = pos + ang:Right() * 8 + ang:Forward() * 10 + ang:Up() * -5

    ang:RotateAroundAxis(ang:Forward(), 180)
    ang:RotateAroundAxis(ang:Right(), 90)

    return pos, ang
end