--[[------------------------------------------

	============================
	GHOSTING/UNGHOSTING MODULE
	============================

	Developer informations :
	---------------------------------
	Used variables :
		ghostColor = { value = Color(34, 34, 34, 220), desc = "Color set on ghosted props" }
		badEnts = {
			value = {
				["prop_physics"] = true,
				["wire_"] = false,
				["gmod_"] = false },
			desc = "Entities to ghost/control/secure"}
		alwaysFrozen = { value = false, desc = "Set to true to auto freeze props on physgun drop" }

]]--------------------------------------------

local mod = "ghosting"

--[[ Override base functions ]]
local ENT = FindMetaTable( "Entity" )
APG._SetCollisionGroup = APG._SetCollisionGroup or ENT.SetCollisionGroup

function ENT:SetCollisionGroup( group )
	local group = group

	local isBadEnt = APG.isBadEnt( self )
	local hasValidOwner = APG.getOwner( self )
	local groupIsNone = group == COLLISION_GROUP_NONE
	local isNotFrozen = not self.APG_Frozen
	local isWhitelistedEnt = APG.isWhitelistedEnt(self)

	local shouldMakeInteractable = isBadEnt and hasValidOwner and groupIsNone and isNotFrozen and not isWhitelistedEnt

	if shouldMakeInteractable then
		group = COLLISION_GROUP_INTERACTIVE
	end

	APG._SetCollisionGroup( self, group )
end

APG._SetColor = APG._SetColor or ENT.SetColor

function ENT:SetColor( color, ... )
	local color = color
	local r, g, b, a
	
	if type(color) == "number" then
		color = Color(color, select(1, ...) or 255, select(2, ...) or 255, select(3, ...) or 255)
	elseif type(color) == "table" and not IsColor(color) then
		r = color.r or 255
		g = color.g or 255
		b = color.b or 255
		a = color.a or 255
		color = Color(r, g, b, a)
	end

	if not IsColor(color) then
		ErrorNoHalt( "Invalid color passed to SetColor!\nThis error prevents stuff from turning purple/pink." )
	else
		APG._SetColor( self, color )
	end
end

local PhysObj = FindMetaTable( "PhysObj" )
APG._EnableMotion = APG._EnableMotion or PhysObj.EnableMotion
function PhysObj:EnableMotion( bool )
	local ent = self:GetEntity()
	if APG.isBadEnt( ent ) and APG.getOwner( ent ) then
		ent.APG_Frozen = not bool
		if not ent.APG_Frozen then
			ent:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
		end
	end
	return APG._EnableMotion( self, bool )
end

function APG.isTrap( ent, fullscan )
	local check = false
	local center = ent:LocalToWorld( ent:OBBCenter() )
	local bRadius = ent:BoundingRadius()
	local cache = {}

	for _,v in next, ents.FindInSphere( center, bRadius ) do
		if v:IsPlayer() and v:Alive() then
			local pos = v:GetPos()
			local trace = { start = pos, endpos = pos, filter = v }
			local tr = util.TraceEntity( trace, v )

			if tr.Entity == ent then
				if fullscan then
					table.insert( cache, v )
				else
					check = v
				end
			end
		elseif APG.IsVehicle(v) then
			-- Check if the distance between the spheres centers is less than the sum of their radius.
			local vCenter = v:LocalToWorld( v:OBBCenter() )
			if center:Distance( vCenter ) < v:BoundingRadius() then
				check = v
			end
	end

		if check then break end
	end

	if fullscan and ( #cache > 0 ) then
		return cache
	else
		return check or false
	end
end

function APG.entGhost( ent, noCollide, enforce )
	if not APG.modules[ mod ] or not APG.isBadEnt( ent ) then return end
	if APG.cfg["vehAntiGhost"].value and APG.IsVehicle( ent ) then return end
	if ent.jailWall then return end

	if not ent.APG_Ghosted then
		ent.FPPAntiSpamIsGhosted = nil -- Override FPP Ghosting.

		DropEntityIfHeld( ent )
		ent:ForcePlayerDrop()

		ent.APG_oldCollisionGroup = ent:GetCollisionGroup()

		if not enforce then
			-- If and old collision group was set get it.
			if ent.OldCollisionGroup then ent.APG_oldCollisionGroup = ent.OldCollisionGroup end -- For FPP
			if ent.DPP_oldCollision then ent.APG_oldCollisionGroup = ent.DPP_oldCollision end -- For DPP

			ent.OldCollisionGroup = nil
			ent.DPP_oldCollision = nil
		end

		ent.APG_Ghosted = true
		if APG.cfg["ghostColorToggle"].value then
			timer.Simple(0, function()
				if not IsValid( ent ) then return end

				if not ent.APG_oldColor then
					ent.APG_oldColor = ent:GetColor()

					if not enforce then
						if ent.OldColor then ent.APG_oldColor = ent.OldColor end -- For FPP
						if ent.__DPPColor then ent.APG_oldColor = ent.__DPPColor end -- For DPP

						ent.OldColor = nil
						ent.__DPPColor = nil
					end
				end

				ent:SetColor( APG.cfg[ "ghostColor" ].value )
			end)
		end

		ent.APG_oldRenderMode = ent:GetRenderMode()
		ent:SetRenderMode( RENDERMODE_TRANSALPHA )
		ent:DrawShadow( false )

		if noCollide then
			ent:SetCollisionGroup( COLLISION_GROUP_WORLD )
		else
			ent:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
		end

		do -- Fix magic surfing
			local phys = ent:GetPhysicsObject()
			if IsValid(phys) then
				phys:EnableCollisions( false )
				timer.Simple(0, function()
					phys:EnableCollisions( true )
				end)
			end
		end

		ent:CollisionRulesChanged()
	end
end

function APG.entUnGhost( ent, ply, failmsg )
	if not APG.modules[ mod ] or not APG.isBadEnt( ent ) then return end
	if ent.APG_Picked or (ent.APG_HeldBy and #ent.APG_HeldBy > 1) then return end

	if ent.APG_Ghosted == true then
		ent.APG_isTrap = APG.isTrap(ent)
		if not ent.APG_isTrap then
			ent.APG_Ghosted = false
			ent:DrawShadow( true )

			ent:SetRenderMode( ent.APG_oldRenderMode or RENDERMODE_NORMAL )
			if APG.cfg["ghostColorToggle"].value then
				ent:SetColor( ent.APG_oldColor or Color( 255, 255, 255, 255) )
			end
			ent.APG_oldColor = false

			local newCollisionGroup = COLLISION_GROUP_INTERACTIVE
			if APG.isWhitelistedEnt(ent) then
				newCollisionGroup = ent.APG_spawnedCollisionGroup
			elseif ent.APG_oldCollisionGroup == COLLISION_GROUP_WORLD then
				newCollisionGroup = ent.APG_oldCollisionGroup
			elseif ent.APG_Frozen then
				newCollisionGroup = COLLISION_GROUP_NONE
			end

			ent:SetCollisionGroup( newCollisionGroup )

			ent:CollisionRulesChanged()
			return true
		else
			APG.notify( false, 1, ply, failmsg or "There is something in this prop!" )
			ent:SetCollisionGroup( COLLISION_GROUP_WORLD )

			ent:CollisionRulesChanged()

			return false
		end
	end
end

function APG.ConstraintApply( ent, callback )
	local constrained = constraint.GetAllConstrainedEntities(ent)
	for _,v in next, constrained do
		if IsValid( v ) and v ~= ent then
			callback( v )
		end
	end
end

--[[------------------------------------------
		Hooks/Timers
]]--------------------------------------------

APG.hookAdd( mod, "APG_PostPhysgunPickup", "APG_makeGhost", function( ply, ent, canPickup )
	if not canPickup then return end
	if not APG.modules[ mod ] or not APG.isBadEnt( ent ) then return end

	ent.APG_Picked = true

	if not APG.cfg[ "allowPK" ].value then
		APG.entGhost( ent )
		APG.ConstraintApply( ent, function( _ent )
			if not _ent.APG_Frozen then
				_ent.APG_Picked = true
				APG.entGhost( _ent )
			end
		end) -- Apply ghost to all constrained ents
	end
end)

APG.hookAdd( mod, "PlayerUnfrozeObject", "APG_unFreezeInteract", function (ply, ent, pObj)
	if not APG.canPhysGun( ent, ply, "APG_unFreezeInteract" ) then return end
	if not APG.modules[ mod ] or not APG.isBadEnt( ent ) then return end
	if APG.cfg[ "alwaysFrozen" ].value then
		return false
	end -- Do not unfreeze if Always Frozen is enabled !
	if ent:GetCollisionGroup( ) ~= COLLISION_GROUP_WORLD then
		ent:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
	end
end)

APG.dJobRegister( "unghost", 0.1, 50, function( ent )
	if IsValid(ent) then
		APG.entUnGhost( ent )
	end
end)

APG.hookAdd( mod, "PhysgunDrop", "APG_pGunDropUnghost", function( ply, ent )
	if not APG.modules[ mod ] or not APG.isBadEnt( ent ) then return end
	ent.APG_Picked = false

	if APG.cfg[ "alwaysFrozen" ].value then
		APG.freezeIt( ent )
	end

	APG.entUnGhost( ent, ply )

	APG.ConstraintApply( ent, function( _ent )
		_ent.APG_Picked = false
		APG.startDJob( "unghost", _ent )
	end) -- Apply unghost to all constrained ents
end)

local function SafeSetCollisionGroup( ent, colgroup, pObj )
	-- If the entity is being held by a player or is ghosted abort.
	if ent:IsPlayerHolding() then return end
	if ent.APG_Ghosted then return end

	if pObj then pObj:Sleep() end
	ent:SetCollisionGroup(colgroup)
	ent:CollisionRulesChanged()
end

APG.hookAdd( mod, "OnEntityCreated", "APG_noCollideOnCreate", function( ent )
	if not APG.modules[ mod ] or not APG.isBadEnt( ent ) then return end
	if not IsValid( ent ) then return end
	if ent:GetClass() == "gmod_hands" then return end -- Fix shadow glitch

	ent.APG_spawnedCollisionGroup = ent:GetCollisionGroup() -- have to set it before it's ghosted

	timer.Simple( 0, function()
		if not ent then return end
		if not ent:IsSolid() then return end -- Don't ghost ghosts.

		local spawnedEnt = tostring(ent)
		local owner = ""
		if APG.getOwner(ent) ~= nil then -- incase getowner return's nil (like on reloading)
			owner = APG.getOwner(ent):Nick()
		else 
			owner = "console"
		end

		APG.entGhost( ent )		
	end)

	timer.Simple( 0, function()
		if not ent then return end
		if not ent:IsSolid() then return end -- Don't ghost ghosts.

		local owner = APG.getOwner( ent )
		DropEntityIfHeld( ent )
		ent:ForcePlayerDrop()

		if IsValid( owner ) and owner:IsPlayer() then
			local pObj = ent:GetPhysicsObject()
			if IsValid(pObj) then
				if APG.cfg[ "alwaysFrozen" ].value then
					ent.APG_Frozen = true
					pObj:EnableMotion( false )
				elseif pObj:IsMoveable() then
					ent.APG_Frozen = false
					SafeSetCollisionGroup( ent, COLLISION_GROUP_INTERACTIVE )
				end
			end
		end

		APG.startDJob( "unghost", ent )
	end)
end)

local BlockedProperties = { "collision", "persist", "editentity", "drive", "ignite", "statue" }
APG.hookAdd( mod, "CanProperty", "APG_canProperty", function(ply, property, ent)
	local property = tostring( property )
	if ( table.HasValue(BlockedProperties, property) and ent.APG_Ghosted ) then
		APG.notify( false, 1, ply, "Cannot set", property, "properties on ghosted entities!" )
		return false
	end
end)

-- Custom Hooks --
local function checkDoor(ply, ent)
	local isTrap = APG.isTrap(ent, true)

	if isTrap and istable(isTrap) then
		ent.APG_Ghosted = true
		ent:SetCollisionGroup(COLLISION_GROUP_WORLD)

		for _,v in next, isTrap do
			if v:IsPlayer() then
				local push = v:GetForward()
				push = push * 1200
				push.z = 60

				v:SetVelocity(push)
			end
		end

		timer.Simple(1, function()
			if IsValid(ply) and IsValid(ent) then
				ent.APG_Ghosted = false
				ent:oldFadeDeactivate()
				ent:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )

				if IsValid(isTrap) then
					APG.notify( false, 1, ply, "Unable to unstuck objects from fading door!" )
					APG.entGhost(ent)
				end
			end
		end)
	end
end

APG.hookAdd(mod, "APG.FadingDoorToggle", "APG_FadingDoor", function(ent, isFading)
	if APG.isBadEnt(ent) and APG.cfg["fadingDoorGhosting"].value then
		local ply = APG.getOwner( ent )

		if (IsValid(ply) and ply:IsPlayer() and not isFading) then
			-- Delay slightly, this is needed to wait for other things happen before it works.
			timer.Simple(0.001, function()
				checkDoor(ply, ent)
			end)
		end
	end
end)

--[[ Load hooks and timers ]]

APG.updateHooks(mod)
APG.updateTimers(mod)
