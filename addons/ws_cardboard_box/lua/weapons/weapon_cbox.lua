//Edited & Optimized by AeroMatix || https://www.youtube.com/channel/UCzA_5QTwZxQarMzwZFBJIAw || http://steamcommunity.com/profiles/76561198176907257

SWEP.PrintName = "Cardboard Box"
SWEP.Instructions = "Crouch while having the SWEP out to activate your box, blend into the surroundings like a ninja"
SWEP.Category = "AeroMatix's SWEPS"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel = "models/weapons/v_hands.mdl"
SWEP.WorldModel = "models/gmod_tower/stealth box/box.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

if CLIENT then
	SWEP.Slot = 2
	SWEP.SlotPos = 3
	SWEP.DrawCrosshair = false

	SWEP.WepSelectIcon = surface.GetTextureID( "cbox/select" )
	SWEP.BounceWeaponIcon = false
end

SWEP.m_WeaponDeploySpeed = 10 -- very fast, so we don't wind up waiting for the hands animation to play

function SWEP:SecondaryAttack()
end

function SWEP:PrimaryAttack()
end

function SWEP:Initialize()
	self:SetWeaponHoldType( "normal" )
	self:DrawShadow( false )
end

function SWEP:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Stealth" )
end

function SWEP:IsUnderBox()
	-- IsOnGround is buggy and doesn't always return the right value in mp
	return self.Owner:Crouching()-- and self.Owner:IsOnGround()
end

function SWEP:EquipNoise()
	self.Owner:EmitSound( "" )
end

if SERVER then return end

function SWEP:Holster()
	if IsFirstTimePredicted() then
		if self:IsUnderBox() then
			self:EquipNoise()
		end
		
		self.UnderBox = false
		self.LerpMul = 1
	end
	
	return true
end

function SWEP:IsHiding()
	return self:GetStealth() and self:IsUnderBox() and self.LerpMul < 0.1
end

SWEP.LerpMul = 1
local vecOrigin, angOrigin = Vector(0, 0, 0), Angle(0, 0, 0)
function SWEP:DrawWorldModel()
	if not IsValid( self.Owner ) then self:DrawModel() return end
	if not self:IsUnderBox() and self.LerpMul > 0.8 then return end

	local pos = self.Owner:GetPos()
	local ang = Angle( 0, self.Owner:EyeAngles().y, 0 )
	
	pos = pos + ( ang:Forward() * 10 )
	
	local bone_pos, bone_ang = vecOrigin, angOrigin

	local spine = self.Owner:LookupBone("ValveBiped.Bip01_Spine1")
	if spine then
		bone_pos, bone_ang = self.Owner:GetBonePosition(spine)
	end
	
	bone_pos = bone_pos + ( ang:Forward() * 10 )
	bone_pos.z = bone_pos.z - 15
	
	bone_ang:RotateAroundAxis( bone_ang:Forward(), 90 )
	bone_ang:RotateAroundAxis( bone_ang:Right(), -40 )
	bone_ang.y = ang.y -- box will spin around really fast in certain angles unless we make it the same in both
	
	if self:IsUnderBox() then
		local vel = self.Owner:GetVelocity():Length2D()
		local mul = math.Clamp( vel / 40, 0, 1 )
		self.LerpMul = Lerp( FrameTime() * 10, self.LerpMul, mul )
	else
		self.LerpMul = Lerp( FrameTime() * 10, self.LerpMul, 1 )
	end
	
	self:SetRenderOrigin( pos * ( 1 - self.LerpMul ) + bone_pos * self.LerpMul )
	self:SetRenderAngles( ang * ( 1 - self.LerpMul ) + bone_ang * self.LerpMul )
	self:SetModelScale( 1.2, 0 )
	
	if not self:IsHiding() then
		self:DrawModel()
	end
end

-- SWEP:Think only gets called serverside and clientside with the owner.
-- We need it to fire on all players. Garry is stupid.
hook.Add( "Think", "CBoxThink", function()
	for _, pl in ipairs( player.GetAll() ) do
		local wep = pl:GetActiveWeapon()
		
		if IsValid( wep ) and wep:GetClass() == "weapon_cbox" and
			wep:IsUnderBox() ~= wep.UnderBox then

			wep:EquipNoise()
			wep.UnderBox = wep:IsUnderBox()
			
			if wep.UnderBox then
				wep.LerpMul = 1
			end
		end
	end
end )

hook.Add( "PrePlayerDraw", "CBoxStealth", function( pl )
	local wep = pl:GetActiveWeapon()
	
	if IsValid( wep ) and wep:GetClass() == "weapon_cbox" and wep:IsHiding() then
		pl:DrawShadow( false )
		return true
	end
	
	pl:DrawShadow( true )
end )

hook.Add( "HUDDrawTargetID", "CBoxTargetID", function()
	local pl = LocalPlayer():GetEyeTrace().Entity
	
	if not IsValid( pl ) then return end
	if not pl:IsPlayer() then return end

	local wep = pl:GetActiveWeapon()
	
	if IsValid( wep ) and wep:GetClass() == "weapon_cbox" and wep:IsUnderBox() then
		return false
	end
end )