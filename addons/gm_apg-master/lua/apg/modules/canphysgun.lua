--[[------------------------------------------

	============================
	Physgun Permissions Module
	============================

	Developer informations :
	---------------------------------
	Used variables : 

]]--------------------------------------------
local mod = "canphysgun"

--[[ Entity pickup part ]]
local GM = GM or GAMEMODE
APG._PhysgunPickup = APG._PhysgunPickup or GM.PhysgunPickup

APG.hookAdd(mod, "PhysgunPickup","APG_PhysgunPickup", function(ply, ent)
	if not APG.isBadEnt( ent ) then return end
	if not APG.canPhysGun( ent, ply ) then return false end
end)

function GM:PhysgunPickup( ply, ent )
	local canPickup = APG._PhysgunPickup( self, ply, ent )
	hook.Run("APG_PostPhysgunPickup", ply, ent, canPickup)

	if not canPickup then return canPickup end -- Assumed as `false` but returning just incase.

	ent.APG_HeldBy = ent.APG_HeldBy or {}
	ent.APG_HeldBy.plys = ent.APG_HeldBy.plys or {}
	ent.APG_Picked = true
	ent.APG_Frozen = false

	if ent.APG_HeldBy and ent.APG_HeldBy.plys and not ent.APG_HeldBy.plys[sid] then
		local HasHolder = (#ent.APG_HeldBy.plys > 0)
		local HeldByLast = ent.APG_HeldBy.last

		if HasHolder then
			if HeldByLast then
				for _, ply in next, ent.APG_HeldBy.plys do
					APG.ForcePlayerDrop(ply, ent)
				end
			else
				return false
			end
		end
	end

	ent.APG_HeldBy.plys[ply:SteamID()] = ply
	ent.APG_HeldBy.last = {ply = ply, id = ply:SteamID()}
	ply.APG_CurrentlyHolding = ent

	if APG.cfg["blockContraptionMove"].value then
		local count = 0
		local noFrozen = true

		for _,v in next, constraint.GetAllConstrainedEntities(ent) do
			count = count + 1
			if v.APG_Frozen then
				noFrozen = false
				break
			end
		end

		if noFrozen and ( count > 1 ) then
			timer.Simple(0, function()
				APG.freezeIt(ent, true)
			end)
		end
	end

	return canPickup -- Assumed as `true`
end

--[[ PhysGun Drop and Anti Throw Props ]]
APG.hookAdd(mod, "PhysgunDrop", "APG_physGunDrop", function( ply, ent )
	ent.APG_HeldBy = ent.APG_HeldBy or {}

	if ent.APG_HeldBy.plys then
		ent.APG_HeldBy.plys[ply:SteamID()] = nil -- Remove the holder.
	end

	ply.APG_CurrentlyHolding = nil

	if #ent.APG_HeldBy > 0 then return end

	ent.APG_Picked = false

	if APG.isBadEnt( ent ) and not APG.cfg["allowPK"].value then
		APG.killVelocity(ent,true,false,true) -- Extend to constrained props, and wake target.
	end
end)

--[[ Load hooks and timers ]]

APG.updateHooks(mod)
APG.updateTimers(mod)
