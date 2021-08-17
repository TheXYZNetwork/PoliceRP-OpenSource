--[[------------------------------------------

	============================
	   STACK DETECTION MODULE
	============================

	Developer informations :
	---------------------------------
	Used variables :
		stackMax = { value = 15, desc = "Max amount of entities stacked on a small area"}
		stackArea = { value = 15, desc = "Sphere radius for stack detection (gmod units)"}
		fading

]]--------------------------------------------
local mod = "stack_detection"
local SafeRemoveEntity = SafeRemoveEntity

function APG.checkStack( ent, pcount )
	if not APG.isBadEnt( ent ) then return end

	local efound = ents.FindInSphere(ent:GetPos(), APG.cfg["stackArea"].value )
	local count = 0
	local max_count = APG.cfg["stackMax"].value
	for k, v in pairs (efound) do
		if APG.isBadEnt( v ) and APG.getOwner( v ) then
			count = count + 1
		end
	end
	if count >= (pcount or max_count) then
		local owner, _ = ent:CPPIGetOwner()
		ent:Remove()
		if not owner.APG_CantPickup then
			APG.blockPickup( owner, 10 )
			
			APG.notify( false, 2, owner, "You tried to unfreeze a stack of " .. count .. " props! >:(" )
			hook.Run("APG_stackCrashAttempt", owner, count)
			APG.notify( true, 2, APG.cfg["notifyLevel"].value, owner:Nick() .. " [" .. owner:SteamID() .. "]" .. " tried to unfreeze a stack of " .. count .. " props!" )
		end
	end
end

APG.hookAdd(mod, "PhysgunPickup", "APG_stackCheck",function(ply, ent)
	if not APG.canPhysGun( ent, ply, "APG_stackCheck" ) then return end
	if not APG.modules[ mod ] or not APG.isBadEnt( ent ) then return end
	APG.checkStack( ent )
end)

-- Requires Fading Door Hooks --
local notify = false
local curTime = 0
local lastCall = 0

APG.hookAdd(mod, "APG.FadingDoorToggle", "APG_fadingDoorStackCheck", function(ent, faded)
	curTime = CurTime()

	if IsValid(ent) and faded then
		local ply = APG.getOwner(ent)
		local pos = ent:GetPos()
		local doors = {}
		local count = 1 -- Start at 1 to include the original fading door

		for _,v in next, ents.FindInSphere(pos, APG.cfg["stackArea"].value) do
			if v ~= ent and IsValid(v) and v.isFadingDoor and APG.getOwner(v) == ply then
				table.insert(doors, v)
				count = count + 1
			end
		end

		if count >= APG.cfg["fadingDoorStackMax"].value then
			notify = true
			for _,v in next, doors do
				SafeRemoveEntity(v)
			end
		end

		if curTime > lastCall then
			if notify and APG.cfg["fadingDoorStackNotify"].value then
				notify = false
				APG.notification(ply:Nick() .. " had a stack of " .. count .. " fading doors that were removed.", APG.cfg["notifyLevel"].value, 2)
				APG.notification("Some of your fading doors were removed.", ply)
			end
		end
	end

	lastCall = curTime + 0.001
end)

--[[ Stacker Exploit Quick Fix ]]
hook.Add( "InitPostEntity", "APG_InitStackFix", function()
	timer.Simple(60, function()
		local TOOL = weapons.GetStored("gmod_tool")["Tool"][ "stacker" ] or weapons.GetStored("gmod_tool")["Tool"][ "stacker_v2" ]
		if not TOOL then return end

		-- Stacker improved (beta) fixed this by setting a maximum number of constraints
		-- See : https://git.io/vPvJK

		APG.dJobRegister( "weld", 0.3, 20, function( sents )
			if not IsValid( sents[1] ) or not IsValid( sents[2]) then return end
			constraint.Weld( sents[1], sents[2], 0, 0, 0 )
		end)

		function TOOL:ApplyWeld( lastEnt, newEnt )
			if ( not self:ShouldForceWeld() and not self:ShouldApplyWeld() ) then return end
			APG.startDJob( "weld", {lastEnt, newEnt} )
		end
	end)
end)

--[[ Load hooks and timers ]]

APG.updateHooks(mod)
APG.updateTimers(mod)
