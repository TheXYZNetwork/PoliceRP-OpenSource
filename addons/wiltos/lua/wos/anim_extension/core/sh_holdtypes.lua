--[[-------------------------------------------------------------------
	wiltOS Hold Type Register:
		The core files needed to make your own hold types
			Powered by
						  _ _ _    ___  ____  
				__      _(_) | |_ / _ \/ ___| 
				\ \ /\ / / | | __| | | \___ \ 
				 \ V  V /| | | |_| |_| |___) |
				  \_/\_/ |_|_|\__|\___/|____/ 
											  
 _____         _                 _             _           
|_   _|__  ___| |__  _ __   ___ | | ___   __ _(_) ___  ___ 
  | |/ _ \/ __| '_ \| '_ \ / _ \| |/ _ \ / _` | |/ _ \/ __|
  | |  __/ (__| | | | | | | (_) | | (_) | (_| | |  __/\__ \
  |_|\___|\___|_| |_|_| |_|\___/|_|\___/ \__, |_|\___||___/
                                         |___/             
-------------------------------------------------------------------]]--[[
							  
	Lua Developer: King David
	Contact: http://steamcommunity.com/groups/wiltostech
		
----------------------------------------]]--

wOS.AnimExtension.HoldTypes = wOS.AnimExtension.HoldTypes or {}
wOS.AnimExtension.TranslateHoldType = wOS.AnimExtension.TranslateHoldType or {}

wOS.AnimExtension.ActIndex = {
	[ "pistol" ] 		= ACT_HL2MP_IDLE_PISTOL,
	[ "smg" ] 			= ACT_HL2MP_IDLE_SMG1,
	[ "grenade" ] 		= ACT_HL2MP_IDLE_GRENADE,
	[ "ar2" ] 			= ACT_HL2MP_IDLE_AR2,
	[ "shotgun" ] 		= ACT_HL2MP_IDLE_SHOTGUN,
	[ "rpg" ]	 		= ACT_HL2MP_IDLE_RPG,
	[ "physgun" ] 		= ACT_HL2MP_IDLE_PHYSGUN,
	[ "crossbow" ] 		= ACT_HL2MP_IDLE_CROSSBOW,
	[ "melee" ] 		= ACT_HL2MP_IDLE_MELEE,
	[ "slam" ] 			= ACT_HL2MP_IDLE_SLAM,
	[ "normal" ]		= ACT_HL2MP_IDLE,
	[ "fist" ]			= ACT_HL2MP_IDLE_FIST,
	[ "melee2" ]		= ACT_HL2MP_IDLE_MELEE2,
	[ "passive" ]		= ACT_HL2MP_IDLE_PASSIVE,
	[ "knife" ]			= ACT_HL2MP_IDLE_KNIFE,
	[ "duel" ]			= ACT_HL2MP_IDLE_DUEL,
	[ "camera" ]		= ACT_HL2MP_IDLE_CAMERA,
	[ "magic" ]			= ACT_HL2MP_IDLE_MAGIC,
	[ "revolver" ]		= ACT_HL2MP_IDLE_REVOLVER
}

function wOS.AnimExtension:RegisterHoldtype( data )

	self.TranslateHoldType[ data.HoldType ] = data
    self.HoldTypeMeta:CreateMetaType( self.TranslateHoldType[ data.HoldType ] )
	
	if data.BaseHoldType then
		if prone then
			if prone.animations then
				if prone.animations.WeaponAnims then
					prone.animations.WeaponAnims.moving[ data.HoldType ] = prone.animations.WeaponAnims.moving[ data.BaseHoldType ]
					prone.animations.WeaponAnims.idle[ data.HoldType ] = prone.animations.WeaponAnims.idle[ data.BaseHoldType ]
				end
			end
		end
	end

	print( "[wOS] Registered new Hold Type: " .. data.Name )
	
end

local meta = FindMetaTable( "Player" )
local ENTITY = FindMetaTable( "Entity" )

local AttackTable = {
[ ACT_MP_ATTACK_STAND_PRIMARYFIRE  ] = true,
[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE  ] = true,
[ ACT_MP_ATTACK_STAND_SECONDARYFIRE  ] = true,
[ ACT_MP_ATTACK_CROUCH_SECONDARYFIRE  ] = true,
}

local _TranslateWeaponActivity = meta.TranslateWeaponActivity
function meta:TranslateWeaponActivity( act )

	if AttackTable[ act ] then
		local wep = self:GetActiveWeapon()
		if IsValid( wep ) then  
			local holdtype = wep:GetHoldType()
			if wOS.AnimExtension.TranslateHoldType[ holdtype ] then
				local ATTACK_DATA = wOS.AnimExtension.TranslateHoldType[ holdtype ]:GetActData( act )
				if ATTACK_DATA then
					local anim = self:LookupSequence( ATTACK_DATA.Sequence )
					self:AddVCDSequenceToGestureSlot( GESTURE_SLOT_VCD, anim, 0, true ) //Figure out weight to make it balanced!
					self:AnimSetGestureWeight( GESTURE_SLOT_VCD, ATTACK_DATA.Weight or 1 )
				end
			end
		end
	end
	
	return _TranslateWeaponActivity( self, act )

end


-- local _DoAnimationEvent = meta.DoAnimationEvent
-- function meta:DoAnimationEvent( ply, event, data )

-- 	local act = _DoAnimationEvent( self, ply, event, data )
-- 	print( act )
-- 	local wep = self:GetActiveWeapon()
-- 	if IsValid( wep ) then  
-- 		local holdtype = wep:GetHoldType()
-- 		if wOS.AnimExtension.TranslateHoldType[ holdtype ] then
-- 			local result = wOS.AnimExtension.TranslateHoldType[ holdtype ][ act ]
-- 			if result then
-- 				if istable( result ) then
-- 					result = table.Random( result )
-- 				end
-- 				if isstring( result ) then
-- 					local anim = ply:LookupSequence( result )	
-- 					ply.ActOverrider = act
-- 					ply.SequenceTime = CurTime() + ply:SequenceDuration( anim )
-- 				end
-- 			end
-- 		end
-- 	end
	
-- 	return act
-- end

hook.Add( "DoAnimationEvent", "wOS.AnimExtension.CustomTriggers", function( ply, event, data ) 

	local wep = ply:GetActiveWeapon()
	if !IsValid( wep ) then return end
	local holdtype = wep:GetHoldType()
	if !wOS.AnimExtension.TranslateHoldType[ holdtype ] then return end

	local act = 9999
	local crouch = ply:Crouching()
	if event == PLAYERANIMEVENT_RELOAD then
		act = ( crouch and ACT_MP_RELOAD_CROUCH ) or ACT_MP_RELOAD_STAND
	elseif event == PLAYERANIMEVENT_ATTACK_SECONDARY then
		act = ( crouch and ACT_MP_ATTACK_CROUCH_SECONDARYFIRE ) or ACT_MP_ATTACK_STAND_SECONDARYFIRE
	end

	local ATTACK_DATA = wOS.AnimExtension.TranslateHoldType[ holdtype ]:GetActData( act )
	if !ATTACK_DATA then return end

	local anim = ply:LookupSequence( ATTACK_DATA.Sequence )
	ply:AddVCDSequenceToGestureSlot( GESTURE_SLOT_VCD, anim, 0, true ) //Figure out weight to make it balanced!
	ply:AnimSetGestureWeight( GESTURE_SLOT_VCD, ATTACK_DATA.Weight or 1 )

	return ACT_INVALID
end )

hook.Add( "Initialize", "wOS.AnimExtension.CustomSequenceHoldtypes", function()

	local _CalcMainActivity = GAMEMODE.CalcMainActivity
	function GAMEMODE:CalcMainActivity( ply, vel )
		
		local act, seq = _CalcMainActivity( self, ply, vel )
		local pr = false
		if prone then
			if ply.IsProne then
				pr = ply:IsProne()
			end
		end

		if not pr then
			local wep = ply:GetActiveWeapon()
			if IsValid( wep ) then  
				local holdtype = wep:GetHoldType()
				if wOS.AnimExtension.TranslateHoldType[ holdtype ] then
					local ATTACK_DATA = wOS.AnimExtension.TranslateHoldType[ holdtype ]:GetActData( act )
					if act == ACT_MP_RUN and ply:KeyDown( IN_SPEED ) then
						ATTACK_DATA = wOS.AnimExtension.TranslateHoldType[ holdtype ]:GetActData( ACT_MP_SPRINT ) or ATTACK_DATA
					end
					if ATTACK_DATA then
						seq = ply:LookupSequence( ATTACK_DATA.Sequence )
					end
				end
			end

			
			if act != ply.LastAct then
				ply:SetCycle( 0 )
			end
		end
		
		ply.LastAct = act
		
		return act, seq
		
	end
	
end )

if SERVER then return end

concommand.Add( "wos_base_help", function( ply, cmd, args )
	MsgC( Color( 255, 255, 255 ), "------------------ ", Color( 133, 173, 219 ), "wiltOS HELP PRINT", Color( 255, 255, 255 ), " ----------------------\n" )
	MsgC( Color( 255, 255, 255 ), "Addon Path Check: " )
	LocalPlayer():ConCommand( "whereis models/m_anm.mdl" )
	timer.Simple( 0.01, function()
	
		MsgC( color_white, "\nPlease ensure the addon path above points to ", Color( 0, 255, 0 ), "'[wOS] Animation Extension - Base'\n")
		MsgC( color_white, "If it does not, unsubscribe to the addon it does point to and get the Animation Base\n")
		print("\n")

		local seq = LocalPlayer():LookupSequence( "_base_wiltos_enabled_" )
		local resp = ( seq >= 0 and Color( 0, 255, 0 ) ) or Color( 255, 0, 0 )
		MsgC( color_white, "Sequence Check: ", resp, "\t", seq, "\n" )
		MsgC( color_white, "If the above sequence check is ", Color( 255, 0, 0 ), -1, color_white, " and the addon above points to the correct location,\nensure your model is a ", Color( 0, 255, 0 ), "PLAYER MODEL", color_white, " and not an ", Color( 255, 0, 0 ), "NPC MODEL\n" )
		MsgC( color_white, "Run this commmand again as a default GMod player model. If it still prints ", Color( 255, 0, 0 ), -1, color_white, " your Animation Base may be outdated\n" )

		print( "\n" )
		MsgC( color_white, "You can find the link here: https://steamcommunity.com/sharedfiles/filedetails/?id=757604550\n")
		MsgC( Color( 255, 255, 255 ), "-----------------------------------------------------------\n" )
	end )
end )