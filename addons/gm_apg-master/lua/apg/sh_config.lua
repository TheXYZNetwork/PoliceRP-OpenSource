--[[------------------------------------------
	====================================================================================
				/!\ READ ME /!\		/!\ READ ME /!\		/!\ READ ME /!\
	====================================================================================

	This file is the default config file.
	If you want to configure APG to fit your server needs, you can edit the config
	ingame using the chat command : !apg or apg in console.

]]--------------------------------------------
APG.cfg = APG.cfg or {}
APG.modules = APG.modules or {}

--[[----------
	Your very own custom function
	This function will run whenever lag is detected on your server!
]]------------
function APG.customFunc( notification )
	-- Do something
end

--[[----------
	Avalaible premade functions - THIS IS INFORMATIVE PURPOSE ONLY !
]]------------
if CLIENT then
	APG_lagFuncs = { -- THIS IS INFORMATIVE PURPOSE ONLY !
		"cleanup_all", -- Cleanup every props/ents protected by APG (not worldprops nor vehicles)
		"cleanup_unfrozen", -- Cleanup only unfrozen stuff
		"ghost_unfrozen", -- Ghost unfrozen stuff
		"freeze_unfrozen", -- Freeze unfrozen stuff
		"smart_cleanup", -- Cleanup unfrozen fading doors, freeze unfrozens, remove large stacks
		"custom_function" -- Your custom function (see APG.customFunc)
	} -- THIS IS INFORMATIVE PURPOSE ONLY !

	APG_notifyLevels = {
		"everyone",
		"admin",
		"superadmin"
	}
end

--[[------------------------------------------
			DEFAULT SETTINGS -- You CAN edit this part, but you SHOULDN'T
]]--------------------------------------------

local defaultSettings = {}
defaultSettings.modules = { -- Set to true to enable and false to disable module.
	["home"] = true, -- Essential, do not disable.
	["ghosting"] = true,
	["stack_detection"] = true,
	["lag_detection"] = true,
	["notification"] = true,
	["canphysgun"] = true, -- Essential, do not disable.
	["misc"] = true,
	["tools"] = true,
	["logs"] = true,
	["advdupe"] = true
}

defaultSettings.cfg = {
	--[[----------
		Ghosting module
	]]------------
	ghostColor = {
		value = Color(34, 34, 34, 220),
		desc = "Color set on ghosted props"
	},

	ghostColorToggle = {
		value = true,
		desc = "Toggle ghosting color."
	},

	badEnts = {
		value = {
			["prop_physics"] = true,
			["wire_"] = false,
			["gmod_"] = false,
			["keypad"] = false,
		},
		desc = "Entities to ghost/control/secure (true if exact name, false if it is a pattern"
	},

	unGhostingWhitelist = {
		value = {
			["zmlab_"] = false,
		},
		desc = "Entities that should be set back to their original (spawned) collision group when frozen/dropped."
	},

	removeInvalidPhysics = {
		value = false,
		desc = "Should we attempt to detect and remove invalid physics objects? (Entities with bad or no physics objects/Physics objects without models.)"
	},

	invalidPhysicsWhitelist = {
		value = {},
		desc = "Entities that shouldn't be removed if they don't have proper physics"
	},

	alwaysFrozen = {
		value = true,
		desc = "Set to true to auto freeze props on physgun drop (aka APG_FreezeOnDrop)"
	},

	--[[----------
		Stack detection module
	]]------------
	stackMax = {
		value = 15,
		desc = "Max amount of entities stacked in a small area"
	},

	stackArea = {
		value = 15,
		desc = "Sphere radius for stack detection (gmod units)"
	},
	fadingDoorStackMax = {
		value = 5,
		desc = "Maximum amount of fading doors that can be stacked in stackArea."
	},
	fadingDoorStackNotify = {
		value = false,
		desc = "Notify the players when their fading doors were removed"
	},

	--[[----------
		Lag detection module
	]]------------
	lagTrigger = {
		value = 75,
		desc = "[Default: 75%] Differential threshold between current lag and average lag."
	},

	lagsCount = {
		value = 8,
		desc = "Number of consectuives laggy frames in order to run a cleanup."
	},

	bigLag = {
		value = 2,
		desc = "Maximum time (seconds) between 2 frames to trigger a cleanup"
	},

	lagFunc = {
		value = "ghost_unfrozen",
		desc = "Function ran on lag detected, see APG_lagFuncs."
	},

	lagFuncTime = {
		value = 8,
		desc = "Time (seconds) between 2 anti lag function (avoid spam)"
	},



	--[[ Notifications ]] --

	notifySounds = {
		value = false, -- Might make it where certain ones run sound
		desc = "When notifications run do you want the sounds to play?"
	},

	notifyLevel = {
		value = "admin",
		desc = "Notification levels, refer to APG_notifyLevels"
	},

	notifyLagFunc = {
		value = false,
		desc = "Do you want the notifyLevel to see the lagFunc that ran? (refer to APG_lagFuncs)"
	},

	-- TODO: Make a ULX/ULIB module
	-- notifyULibInheritance = {
	-- 	value = true,
	-- 	desc = "Do you want to use inheritance for notifyRanks? (only works with ULIB/ULX)"
	-- },

	-- notifyRanks = {
	-- 	value = { "trialmod", "moderator", "admin", "superadmin", "owner" },
	-- 	desc = "The ranks that you want to see the notification" -- If you have notifyULibInheritance you only need to do the lowest rank(s)
	-- },

	--[[ Override Server Settings? ]]
	touchServerSettings = {
		value = false,
		desc = "Should we override Server Settings? (Used for setting ConVars)"
	},

	--[[ Vehicles ]]--

	vehDamage = {
		value = false,
		desc = "True to disable vehicles damages, false to enable."
	},

	vehNoCollide = {
		value = false,
		desc = "True to disable collisions between vehicles and players"
	},

	vehIncludeWAC = {
		value = true,
		desc = "Check for WAC vehicles."
	},

	vehAntiGhost = {
		value = false,
		desc = "Toggle vehicle ghosting"
	},

	blockGravGunThrow = {
		value = true,
		desc = "Toggle GravGun throwing."
	},

	setTurboPhysics = {
		value = false,
		desc = "Toggle sv_turbophysics."
	},

	--[[ Tool Control ]]--

	checkCanTool = {
		value = true,
		desc = "Should tools be blocked on APG_CantPickup?"
	},

	blockToolSpam = {
		value = true,
		desc = "Block players from spamming the toolgun."
	},

	blockToolRate = {
		value = 5,
		desc = "How fast can we use the toolgun before it gets blocked? (Clicks per second(s))"
	},

	blockToolDelay = {
		value = 1,
		desc = "How many seconds should we wait after we were stopped? (The aforementioned second(s))"
	},

	blockToolWorld = {
		value = false,
		desc = "Prevent using the toolgun on the world."
	},

	blockToolUnfreeze = {
		value = true,
		desc = "Prevent the toolgun from unfreezing props."
	},

	blockCreatorTool = {
		value = true,
		desc = "Should we block the creator tool?"
	},

	checkTooledEnts = {
		value = true,
		desc = "Review entities near tool use."
	},

	physGunMaxRange = {
		value = 700,
		desc = "Max range a physics gun can go"
	},

	--[[ Logs ]]--

	logStackCrashAttempt = {
		value = true,
		desc = "Log when someone tries to lag/crash the server with stacker"
	},

	logLagDetected = {
		value = true,
		desc = "Log when the server lags"
	},

	--[[ Props related ]]--

	blockPhysgunReload = {
		value = true,
		desc = "Block players from using physgun reload"
	},

	blockContraptionMove = {
		value = true,
		desc = "Block players from moving contraptions"
	},

	autoFreeze = {
		value = false,
		desc = "Freeze every unfrozen prop each X seconds"
	},

	autoFreezeTime = {
		value = 120,
		desc = "Auto freeze timer (seconds)"
	},

	fadingDoorHook = {
		value = true,
		desc = "Inject custom hooks into Fading Doors"
	},

	fadingDoorGhosting = {
		value = true,
		desc = "Activate fading door ghosting"
	},

	sleepyPhys = {
		value = false,
		desc = "Activate FRZR9K (Sleepy Physics)"
	},

	sleepyPhysHook = {
		value = false,
		desc = "Hook FRZR9K into collision (Experimental)"
	},

	allowPK = {
		value = false,
		desc = "Allow prop killing"
	},

	developerDebug = {
		value = false,
		desc = "Dev Logs (prints stuff)"
	},
	--[[ Advanced Dupe ]]--
	maxScale = {
		value = 1,
		desc = "The maximum scale a prop can be. Keep this at 1 if you don't know what you're doing."
	},
	ropeSpam = {
		value = true,
		desc = "Fixes rope spam on the map."
	},
	-- Fading Door material fuckery
	fdMat = {
		value = true,
		desc = "Enable / disable the prevention of using materials not listed in the UI (recommended to have enabled)"
	}
}

--[[------------------------------------------
		LOADING SAVED SETTINGS -- DO NOT EDIT THIS PART
]]--------------------------------------------
if SERVER and file.Exists( "apg/settings.txt", "DATA" ) then
	table.Merge( APG, defaultSettings ) -- Load the default settings first!

	local settings = file.Read( "apg/settings.txt", "DATA" )
	settings = util.JSONToTable( settings )

	if not settings.modules or not settings.cfg then
		ErrorNoHalt("Your custom settings have not been loaded because you have a misconfigured settings file! The default settings were used instead!")
		return
	end

	local removedSetting = {}

	for k, v in next, settings.modules do
		if defaultSettings.modules[k] == nil then
			settings.modules[k] = nil
			table.insert(removedSetting, k)
		end
	end

	for k, v in next, settings.cfg do
		if defaultSettings.cfg[k] == nil then
			settings.cfg[k] = nil
			table.insert(removedSetting, k)
		end
	end

	if next(removedSetting) then
		print("[APG] Settings File Updated. (Conflicts Resolved)")
		print("[APG] The Following Settings Have Been Removed: ")
		for _,v in next, removedSetting do
			print("\t> \"" .. tostring(v) .. "\" has been removed.")
		end

		removedSetting = nil
		file.Write("apg/settings.txt", util.TableToJSON(settings))
	end

	table.Merge( APG, settings )
else
	table.Merge( APG, defaultSettings )
end
