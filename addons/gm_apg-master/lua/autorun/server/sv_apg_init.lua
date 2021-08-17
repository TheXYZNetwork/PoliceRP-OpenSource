--[[ INITIALIZE APG ]]
APG = {}
APG.modules =  APG.modules or {}

--[[ Micro Optimization ]]
local timer = timer
local table = table

--[[ CLIENT related ]]
AddCSLuaFile("apg/sh_config.lua")
AddCSLuaFile("apg/cl_utils.lua")
AddCSLuaFile("apg/cl_menu.lua")

--[[ REGISTER Modules ]]
local modules, _ = file.Find("apg/modules/*.lua","LUA")
for _,v in next, modules do
	if v then
		niceName = string.gsub(tostring(v),"%.lua","")
		APG.modules[ niceName ] = false
		APG[ niceName ] = { hooks = {}, timers = {}}
	end
end

	--[[
		Add's a hook to the module table
		@param {string} module
		@param {string} event
		@param {string} identifier
		@param {function} function
		@void
	]]


function APG.hookAdd( module, event, identifier, func )
	table.insert( APG[ module ][ "hooks"], { event = event, identifier = identifier, func = func })
end

--[[
	Adds all the hooks that the module needs
	@param {string} module
	@void
]]

function APG.updateHooks( module )
	for k, v in next, APG[module]["hooks"] do
		hook.Add( v.event, v.identifier, v.func )
	end
end

--[[
	Add's a timer to the module table
	@param {string} module
	@param {string} identifier
	@param {number} delay
	@param {number} repetitions
	@param {function} function
	@void
]]

function APG.timerAdd( module, identifier, delay, repetitions, func )
	table.insert( APG[ module ][ "timers"], { identifier = identifier, delay = delay, repetitions = repetitions, func = func } )
end

--[[
	Add's a the timers a module needs.
	@param {string} module
	@void
]]
function APG.updateTimers(module)
	for k, v in next, APG[module]["timers"] do
		timer.Create( v.identifier, v.delay, v.repetitions, v.func )
	end
end

--[[
	Load's a APG module
	@param {string} module
	@void
]]

function APG.load( module )
	APG.modules[ module ] = true
	include( "apg/modules/" .. module .. ".lua" )
	print("[APG] " .. module .. " loaded.")
end

--[[
	Unload's a APG module
	@param {string} module
	@void
]]

function APG.unLoad( module )
	APG.modules[module] = false

	if not (istable(APG[module]) and next(APG[module])) then return end

	local hooks = APG[ module ]["hooks"]
	for k, v in next, hooks do
		hook.Remove(v.event, v.identifier)
	end

	local timers = APG[ module ]["timers"]
	for k, v in next, timers do
		timer.Remove(v.identifier)
	end

	print("[APG] " .. module .. " unloaded.")
end

function APG.reload()
	for k, v in next, APG.modules do
		if APG.modules[ k ] == true then
			APG.unLoad( k )
			APG.load( k )
		else
			APG.unLoad( k )
		end
	end
end

--[[ local settings = {}
function APG.sampleServerSettings()

end

function APG.getServerSettings()

end ]]

function APG.initialize()
	for k, v in next, APG.modules do
		if APG.modules[k] == true then
			APG.load(k)
		end
	end
end

--[[ LOADING ]]
-- Loading config first
include( "apg/sh_config.lua" )
-- Loading APG main functions
include( "apg/sv_apg.lua") -- Modules loaded at the bottom
-- Loading APG menu
include( "apg/sv_menu.lua" )

--[[ CVars INIT ]]

concommand.Add("apg_set", function( ply, cmd, args, argStr )
	if not ply:IsSuperAdmin() then return end

	if args[1] == "module" then
		local _module = APG.modules[ args[2] ]
		if _module != nil then
			if _module == true then
				APG.unLoad( args[2] )
				APG.notification( "[APG] Module " .. args[2] .. " disabled.", ply)
			else
				APG.load( args[2] )
				APG.notification( "[APG] Module " .. args[2] .. " enabled.", ply)
			end
		else
			APG.notification( "[APG] This module does not exist", ply)
		end

	elseif args[1] == "help" then
		local cfg = APG.cfg[ args[2] ]
		if cfg then
			APG.notification( cfg.desc, ply)
		else
			APG.notification( "[APG] Help: This setting does not exist", ply)
		end
	else
		APG.notification( ply, "Error: unknown setting")
	end
end)
