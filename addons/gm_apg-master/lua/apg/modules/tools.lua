--[[------------------------------------------

	============================
		TOOLS MODULE
	============================

	Developer informations :
	---------------------------------
	Used variables :

]]--------------------------------------------
local mod = "tools"

function APG.canTool( ply, tool, ent )
	if IsValid(ent) then
		if ent.ToolDisabled == false then
			return false
		end

		if ent.CPPICanTool then
			return ent:CPPICanTool(ply, tool)
		end -- Let CPPI handle things from here.
	end

	if APG.cfg[ "checkCanTool" ].value and ply.APG_CantPickup == true then-- If we can't pickup we can't tool either.
		return false
	end

	return 0 -- return 0 so if all of the check's don't return anything then it doesn't default to disabling toolgun.
end

--[[ APG CanTool Check ]]

APG.hookAdd(mod, "CanTool", "APG_ToolMain", function(ply, tr, tool)
	if not APG.canTool(ply, tool, tr.Entity) then
		return false
	end
end)

--[[ Tool Spam Control ]]

APG.hookAdd(mod, "CanTool", "APG_ToolSpamControl", function(ply)
	if not APG.cfg[ "blockToolSpam" ].value then return end

	ply.APG_ToolCTRL = ply.APG_ToolCTRL or {}

	local ply = ply
	local data = ply.APG_ToolCTRL
	local delay = 0
	local diff = 0

	data.curTime = CurTime()
	data.toolDelay = data.toolDelay or 0
	data.toolUseTimes = data.toolUseTimes or 0

	diff = data.curTime - data.toolDelay
	delay = APG.cfg[ "blockToolDelay" ].value

	if data.toolUseTimes <= 0 or diff > delay then
		data.toolUseTimes = 0
		data.toolDelay = 0
		data.wasNotified = false
	end

	if diff > 0 then
		data.toolUseTimes = math.max( data.toolUseTimes - 1, 0 )
	else
		data.toolUseTimes = math.min( data.toolUseTimes + 1, APG.cfg[ "blockToolRate" ].value )
		if data.toolUseTimes >= APG.cfg[ "blockToolRate" ].value then
			data.toolDelay = data.curTime + delay
			if not data.wasNotified then
				data.wasNotified = true
				APG.notify( false, 1, ply, "You are using the toolgun too fast, slow down!" )
			end
			return false
		end
	end

	if data.toolDelay == 0 then
		data.toolDelay = data.curTime + delay
	end
end)

--[[ Block Tool World ]]

APG.hookAdd(mod, "CanTool", "APG_ToolWorldControl", function(ply, tr)
	if not APG.cfg[ "blockToolWorld" ].value then return end
	if tr.HitWorld then
		if not timer.Exists("APG-" .. ply:UniqueID() .. "-Notify") then
			APG.notify( false, 1, ply, "You may not use the toolgun on the world." )
			timer.Create("APG-" .. ply:UniqueID() .. "-Notify", 5, 1, function() end)
		end
		return false
	end
end)

--[[ Block Tool Unfreeze ]]

APG.hookAdd(mod, "CanTool", "APG_ToolUnfreezeControl", function(ply, tr)
	if not APG.cfg[ "blockToolUnfreeze" ].value then return end
	timer.Simple(0.003, function()
		local ent = tr.Entity
		local phys = NULL

		if IsValid(ent) then
			phys = ent:GetPhysicsObject()
			if IsValid(phys) and phys:IsMotionEnabled() then
				phys:EnableMotion( false )
			end
		end
	end)
end)

if APG.cfg[ "touchServerSettings" ].value then
	local conVar = GetConVar("toolmode_allow_creator")
	if conVar then
		if APG.cfg[ "blockCreatorTool" ].value then
			conVar:SetBool(false)
		else
			conVar:SetBool(true)
		end
	end
end

--[[ Load hooks and timers ]]

APG.updateHooks(mod)
APG.updateTimers(mod)
