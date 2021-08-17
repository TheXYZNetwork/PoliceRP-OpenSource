SWEP.PrintName = "Ticket Book"
SWEP.Author = "Smith Bob"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 5
SWEP.SlotPos = 4

SWEP.Spawnable = true
SWEP.ViewModel = "models/freeman/c_police_citation.mdl"
SWEP.WorldModel = "models/freeman/w_police_citation.mdl"
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

	if not target then
		XYZShit.Msg("Ticket Book", TicketBook.Config.Color, "Could not find a player", self.Owner)
		return
	end

	if XYZShit.IsGovernment(target:Team(), true) then
		XYZShit.Msg("Ticket Book", TicketBook.Config.Color, "You cannot ticket government", self.Owner)
		return
	end

	if self.Owner:GetPos():DistToSqr(target:GetPos()) > 12500 then return end

	net.Start("ticketbook_open")
	net.WriteEntity(target)
	net.Send(self.Owner)
end

function SWEP:Reload()
end

function SWEP:SecondaryAttack()
end