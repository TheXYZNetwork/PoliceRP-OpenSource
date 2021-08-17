SWEP.PrintName = "Baton"
SWEP.Author = "Owain Owjo"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true
SWEP.ViewModel = Model("models/freeman/c_compact_baton.mdl")
SWEP.WorldModel = "models/freeman/w_compact_baton.mdl"
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

if SERVER then
	util.AddNetworkString('xyz_baton_stun_start')
end

function SWEP:Deploy()
	local ply = self.Owner
	self:SetNextPrimaryFire(CurTime()+1.4)
	self:SetNextSecondaryFire(CurTime()+1.4)
	ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("draw"))
	timer.Simple(1.4, function()
		ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("idle"))
	end)
	return true
end

function SWEP:Initialize()
	self:SetWeaponHoldType("melee")
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
end 

function SWEP:PrimaryAttack()
	local ply = self.Owner
	local target = ply:GetEyeTrace().Entity
	if not target:IsPlayer() then return end

	if ply:GetPos():Distance(target:GetPos()) > 250 then return end
	if SERVER then if target:XYZIsArrested() then return end end

	if target.xAdminIsFrozen then return end -- Is xAdmin frozen
	if target.xyz_activeFreeze then return end -- Is baton frozen
	if target.isSOD then return end -- Is SOD

	if SERVER and IsValid(target:GetVehicle()) then
		if not (target:GetVehicle().SIMPSit) then return end
		target:ExitVehicle()
	end

	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	ply:EmitSound("physics/body/body_medium_impact_hard1.wav", 100, 100, 0.3)
	ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("swing"..math.random(3)))

	target.xyz_activeFreeze = true
	target:SetMoveType(MOVETYPE_FLYGRAVITY)
	if SERVER then
		target:Lock()
		target:Freeze(true)
		net.Start("xyz_baton_stun_start")
		net.Send(target)
		hook.Call("XYZBatonHit", nil, ply, target)
	end
	timer.Simple(6 ,function()
		if IsValid(target) then
			target.xyz_activeFreeze = false
			target:SetMoveType(2)
			if SERVER then
				if target:XYZIsArrested() then return end
				target:UnLock()
				target:Freeze(false)
			end
		end
	end)

	self:SetNextPrimaryFire(CurTime()+10)
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime()+5)
	local ply = self.Owner
	local target = ply:GetEyeTrace().Entity
	if not target:IsVehicle() then return end

	if ply:GetPos():Distance(target:GetPos()) > 200 then return end

	self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	ply:EmitSound( "physics/body/body_medium_impact_hard1.wav", 100, 100, 0.3 )
	ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("swing"..math.random(3)))
	if SERVER then
		if target:GetSpeed() > 10 then return end

		-- Kick the driver out
		local driver = target:GetDriver()
		if not IsValid(driver) then return end
		driver:ExitVehicle()
		target:VC_clearSeats()
		target:keysLock()

		hook.Call("XYZBatonHitVehicle", nil, ply, driver, target)
	end
end


function SWEP:Reload()
end

if CLIENT then
	net.Receive("xyz_baton_stun_start", function()
		hook.Add('HUDPaint', 'xyz_stun_show', function()	
			local tab = {}
			tab[ "$pp_colour_addr" ] = (60*0.0025)
			tab[ "$pp_colour_addg" ] = (60*(-0.001))
			tab[ "$pp_colour_addb" ] = (60*(-0.002))
			tab[ "$pp_colour_brightness" ] = (60*(-0.001))
			tab[ "$pp_colour_contrast" ] = 1+(0.6/2)
			tab[ "$pp_colour_colour" ] = 1-0.6
			tab[ "$pp_colour_mulr" ] = (60*(0))
			tab[ "$pp_colour_mulg" ] = (60*(0))
			tab[ "$pp_colour_mulb" ] = (60*(0))
			DrawColorModify( tab )
		end)
		timer.Simple(6, function()
			hook.Remove('HUDPaint', 'xyz_stun_show')
		end)
	end)
	concommand.Add("xyz_stun_effect_clean", function()
		hook.Remove('HUDPaint', 'xyz_stun_show')
	end, nil, "Used to clear the red effect when bugged.")


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
    	ang:RotateAroundAxis(ang:Forward(), -35)
		local pos
    	if not (ply:LookupBone("ValveBiped.Bip01_R_Hand") == nil) then
    		pos = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_R_Hand"))
    	else 
    		pos = ply:GetPos()
    	end

    	if not self.GunModel then
    		self.GunModel = ClientsideModel(self.WorldModel)
    		self.GunModel:SetBodygroup(1, 1	)
    		timer.Simple(5, function() -- Used to prevent the floating batons lol
    			if self.GunModel then
    				self.GunModel:Remove()
					self.GunModel = nil
    			end
    		end)
    	end
        pos = pos + (ang:Forward()*0.2) + (ang:Right()*3.5) + (ang:Up()*1)
    	self.GunModel:SetPos(pos)
    	self.GunModel:SetAngles(ang)
    end

	function SWEP:Holster()
        if self.GunModel then
            self.GunModel:Remove()
            self.GunModel = nil
        end
    end
end