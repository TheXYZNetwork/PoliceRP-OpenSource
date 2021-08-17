if (SERVER) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.PrintName			= "Snowballs! (no damage)"	
SWEP.Slot				= 1
SWEP.Author				= "BlackJackit, Edited from IceAxe Realistic Weapon, Bugs Fixing by Wood, all credits to the creators"
SWEP.DrawAmmo 			= false
SWEP.DrawCrosshair 		= false
SWEP.ViewModelFOV		= 62
SWEP.ViewModelFlip		= false
SWEP.CSMuzzleFlashes	= false
SWEP.SlotPos			= 1
SWEP.IconLetter			= "S"
SWEP.Weight				= 0 --was 5, to remove all the damage
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.HoldType			= "grenade"
SWEP.Instructions 		= "Left click to launch a snowball \nReload to take another one\nUSE key to change trails color\n"
SWEP.Category			= "Snowballs! (no damage)"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ViewModel 			= "models/weapons/v_snowball.mdl"
SWEP.WorldModel 		= "models/weapons/w_snowball.mdl" 
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Primary.ClipSize		= 1
SWEP.Primary.Damage			= 0 -- was 60000, to remove all the damage
SWEP.Primary.Delay 			= 0
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Secondary.ClipSize		= 1
SWEP.Secondary.DefaultClip	= 1
SWEP.Secondary.Damage		= 0
SWEP.Secondary.Delay 		= 2
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.ReloadSound 			= "none.wav"
SWEP.DrawSound              = "pinpull.wav"

SWEP.IronSightsPos 			= Vector(-15, 0, 15) -- Comment out this line of you don't want ironsights.  This variable must be present if your SWEP is to use a scope.
SWEP.IronSightsAng 			= Vector(0, 0, 0)
SWEP.IronSightZoom			= 1.0 -- How much the player's FOV should zoom in ironsight mode. 

function SWEP:Think()
end

local currentnumber = 0
local white = Color(255,255,255,255)
local green = Color(50,205,50,255)
local blue = Color(72,118,255,255)
local red = Color(255,48,48,255)
local yellow = Color(255,255,0,255)
local pink = Color(255,182,193,255)
local damageactivated = 0; -- was 1, default there's no damage
local currentcolor = white
	

function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
 	self:SetIronsights(false,self.Owner)
 	util.PrecacheSound("weapons/iceaxe/iceaxe_swing1.wav")
	util.PrecacheSound("hit.wav")
	self.Weapon:SetClip1(1)
	hook.Add( "KeyPress", "KeyPressedHook", colorchange )
end

function SWEP:Holster()	
	hook.Remove("KeyPress", "colorchange")
	return true
end

function colorchange (ply, key)
    if (ply:KeyPressed( IN_USE )) then
        currentnumber = currentnumber + 1		
		if(currentnumber == 7) then
			currentnumber = 1
		end
		if currentnumber == 1 then
			//Msg("Current trail color: white\n")
			currentcolor = white
		end
		if currentnumber == 2 then
			//Msg("Current trail color: green\n")
			currentcolor = green
		end
		if currentnumber == 3 then
			//Msg("Current trail color: blue\n")
			currentcolor = blue
		end
		if currentnumber == 4 then
			//Msg("Current trail color: red\n")
			currentcolor = red
		end
		if currentnumber == 5 then
			//Msg("Current trail color: yellow\n")
			currentcolor = yellow
		end
		if currentnumber == 6 then
			//Msg("Current trail color: pink\n")
			currentcolor = pink
		end
    end
    
end

/*---------------------------------------------------------
SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime()+4)
	
	//uncomment those lines to reenable damage
	//if(damageactivated == 0) then
	// 	Msg("Snowballs damage activated!\n")
	// 	damageactivated = 1
	// else
	// 	Msg("Snowballs damage deactivated!\n")
	// 	damageactivated = 0
	// end
end

/*---------------------------------------------------------
PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:EmitSound("weapons/iceaxe/iceaxe_swing1.wav")
	
	local trace = {}
	trace.start = self.Owner:GetShootPos()
	trace.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 10^14
	trace.filter = self.Owner
	local tr = util.TraceLine(trace)

	local vAng = (tr.HitPos-self.Owner:GetShootPos()):GetNormal():Angle()
	--tr.Entity:SetKeyValue("targetname", "disTarg")
	
	if SERVER then
		local Front = self.Owner:GetAimVector();
		local Up = self.Owner:EyeAngles():Up();
		
		if ( SERVER ) then -- only spawn things on server to prevent issues
			local ball = ents.Create("ent_snowball_nodamage");

			if IsValid(ball) then

				ball:SetPos(self.Owner:GetShootPos() + Front * 10 + Up * 10 * -1);
				ball:SetAngles(Front:Angle());
				ball:Spawn();
				ball:Activate();
				ball:SetOwner(self.Owner)
				local Physics = ball:GetPhysicsObject();

				if IsValid(Physics) then
		
				local Random = Front:Angle();
						
					Random = Random:Forward();
					Physics:ApplyForceCenter(Random * 850); -- Fixes masive throw (wood)
				end
			end
		end
	end
	self:SetIronsights(true,self.Owner)
	timer.Simple(0.6, function() self:Reload() end)
	self.Weapon:SetNextPrimaryFire(CurTime() + 1.5)
end

function SWEP:Reload()
	self:SetIronsights(false,self.Owner)
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	return true
end

local IRONSIGHT_TIME = 0.1 -- How long it takes to raise our rifle
function SWEP:SetIronsights(b,player)

if CLIENT or (not player) or player:IsNPC() then return end
	-- Send the ironsight state to the client, so it can adjust the player's FOV/Viewmodel pos accordingly
	self.Weapon:SetNetworkedBool("Ironsights", b)
end

function SWEP:OnRemove()
	return true
end

function SWEP:Holster()
	return true
end

function SWEP:ShootEffects()
end

-- mostly garry's code
function SWEP:GetViewModelPosition(pos, ang)

	if not self.IronSightsPos then return pos, ang end

	local bIron = self.Weapon:GetNetworkedBool("Ironsights")
	if bIron ~= self.bLastIron then -- Are we toggling ironsights?
	
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
		
		if bIron then 
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else 
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
		end
	
	end
	
	local fIronTime = self.fIronTime or 0

	if not bIron and (fIronTime < CurTime() - IRONSIGHT_TIME) then 
		return pos, ang 
	end
	
	local Mul = 1.0 -- we scale the model pos by this value so we can interpolate between ironsight/normal view
	
	if fIronTime > CurTime() - IRONSIGHT_TIME then
	
		Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)
		if not bIron then Mul = 1 - Mul end
	
	end

	local Offset	= self.IronSightsPos
	
	if self.IronSightsAng then
	
		ang = ang*1
		ang:RotateAroundAxis(ang:Right(), 		self.IronSightsAng.x * Mul)
		ang:RotateAroundAxis(ang:Up(), 			self.IronSightsAng.y * Mul)
		ang:RotateAroundAxis(ang:Forward(), 	self.IronSightsAng.z * Mul)
	
	end
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
	
end

-- This function handles player FOV clientside.  It is used for scope and ironsight zooming.
function SWEP:TranslateFOV(current_fov)

	local fScopeZoom = self.Weapon:GetNetworkedFloat("ScopeZoom")
	if self.Weapon:GetNetworkedBool("Scope") then return current_fov/fScopeZoom end
	
	local bIron = self.Weapon:GetNetworkedBool("Ironsights")
	if bIron ~= self.bLastIron then -- Do the same thing as in CalcViewModel.  I don't know why this works, but it does.
	
		self.bLastIron = bIron 
		self.fIronTime = CurTime()

	end
	
	local fIronTime = self.fIronTime or 0

	if not bIron and (fIronTime < CurTime() - IRONSIGHT_TIME) then 
		return current_fov
	end
	
	local Mul = 1.0 -- More interpolating shit
	
	if fIronTime > CurTime() - IRONSIGHT_TIME then
	
		Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)
		if not bIron then Mul = 1 - Mul end
	
	end

	current_fov = current_fov*(1 + Mul/self.IronSightZoom - Mul)

	return current_fov

end