--[[------------------------------------------

	============================
			LAG DETECTION MODULE
	============================

	Developer informations :
	---------------------------------
	Used variables :
		lagTrigger = { value = 75, desc = "% difference between current lag and average lag."}
		lagsCount = { value = 8, desc = "Number of consectuives laggy frames in order to run a cleanup."}
		bigLag = { value = 2, desc = "Time (seconds) between 2 frames to trigger a cleanup"}
		lagFunc = { value = "cleanUp_unfrozen", desc = "Function ran on lag detected" }
		lagFuncTime = { value = 20, desc = "Time (seconds) between 2 cleanup (avoid spam)"}

	Ready to hook :
		APG_lagDetected = Ran on lag detected by the server.
		Example : hook.Add( "APG_lagDetected", "myLagDetectHook", function() print("[APG] Lag detected (printed from my very own hook)")  end)

]]--------------------------------------------
local mod = "lag_detection"
local table = table

--[[ Lag fixing functions ]]

local lagFix = {
	cleanup_all = function( ) APG.cleanUp( "all" ) end,
	cleanup_unfrozen = function( ) APG.cleanUp( "unfrozen" ) end,
	ghost_unfrozen = APG.ghostThemAll,
	freeze_unfrozen = APG.freezeProps,
	smart_cleanup = APG.smartCleanup,
	custom_function = APG.customFunc,
}

--[[ Lag detection vars ]]

local lastTick = 0
local tickDelta = 0
local tickRate = 0

local lagCount = 0
local lagThreshold = math.huge

local processHault = false
local processFunc = false
local processExecs = 0

local sampleData = {}
local sampleCount = 0

local function addSample( data )
	local index = (sampleCount%66)+1
	local data = tonumber(data)

	sampleCount = sampleCount + 1
	if sampleCount >= 66 then
		sampleCount = 0
	end

	table.insert(sampleData, index, data)
end

function APG.resetLag(dontResetData)
	lastTick = 0
	tickDelta = 0

	lagCount = 0
	lagThreshold = tickRate

	processHault = false
	processFunc = false
	processExecs = 0
end

function APG.calculateLagAverage()
	local count = 0
	local total = 0
	local sampleData = sampleData

	for _, v in next, sampleData do
		total = total + v
		count = count + 1
	end

	if count < 12 then
		return false -- Not enough data, yet.
	end

	return (total/count)
end

hook.Add("Think", "APG_initLagDetection", function()
	tickRate = FrameTime()
	lagThreshold = tickRate
	hook.Remove("Think", "APG_initLagDetection")
end)

APG.timerAdd( mod, "APG_process", 3, 0, function()
	if not APG.modules[ mod ] then return end

	if sampleCount < 12 or tickDelta < lagThreshold then
		addSample(tickDelta)
	end

	local average = APG.calculateLagAverage()

	if average then
		lagThreshold = average * ( 1 + ( APG.cfg[ "lagTrigger" ].value / 100 ) )
	end

	processExecs = 0
end)

APG.hookAdd( mod, "Tick", "APG_lagDetection", function()
	if not APG.modules[ mod ] then return end

	local sysTime = SysTime()
	tickDelta = sysTime - lastTick

	if lagThreshold > tickRate and tickDelta >= lagThreshold then

		lagCount = lagCount + 1

		if (lagCount >= APG.cfg[ "lagsCount" ].value) or ( tickDelta > APG.cfg[ "bigLag" ].value ) then

			lagCount = 0

			if ( not processHault ) and ( not processFunc ) then

				processHault = true

				timer.Simple(APG.cfg["lagFuncTime"].value, function()
					processHault = false
				end)

				hook.Run( "APG_lagDetected" )

			end

		end

	else
		lagCount = lagCount - 0.5
		if lagCount < 0 then
			lagCount = 0
		end
	end

	lastTick = sysTime
end)

--[[ Utils ]]

hook.Remove( "APG_lagDetected", "main") -- Sometimes, I dream about cheese.
hook.Add( "APG_lagDetected", "main", function()
	if not APG then return end

	APG.notify( true, 2, APG.cfg["notifyLevel"].value, "!WARNING LAG DETECTED!" )

	local funcName = APG.cfg[ "lagFunc" ].value
	local func = lagFix[ funcName ]

	if not func then return end

	hook.Run("APG_logsLagDetected") -- put it here so it doesn't spam

	processFunc = true

	func(false, function()
		processFunc = false
		processExecs = processExecs + 1
	end)

	if processExecs > 3 then
		-- If the lag cleanup process runs more then 3 times in 3 seconds, then
		-- reset our data.
		APG.resetLag()
	end
end)

--[[ Load hooks and timers ]]

APG.updateHooks(mod)
APG.updateTimers(mod)
