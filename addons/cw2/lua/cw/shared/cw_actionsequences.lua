AddCSLuaFile()

-- GMod's stock timers are clunky as all fuck, so I just made my own timer system
-- with less pointless shit and more straight to the point functionality
-- the :process function is called within the SWEP's Think function
-- this is not intended to be used as a replacement for the timer system in garry's mod, but rather to time specific actions that bring a global delay (to all actions) on the weapon
-- the action sequences are unique to each weapon, meaning that the moment the player dies/loses the weapon object, all active action sequences will not be processed
-- this is very useful to not do consistency checks
-- these are designed to be used when the holstering is temporarily disabled (holstering/throwing grenades, etc.)
-- this class is a critical part of CW 2.0, don't remove it

CustomizableWeaponry.actionSequence = {}

function CustomizableWeaponry.actionSequence:new(time, actionDelay, func)
	-- don't insert nil
	if not func or not time then
		return
	end
	
	local CT = UnPredictedCurTime()
	
	table.insert(self._activeSequences, {time = CT + time, func = func})
	
	if actionDelay then
		self:setGlobalDelay(actionDelay)
	end
end

function CustomizableWeaponry.actionSequence:process()
	local CT = UnPredictedCurTime()
	
	for k, v in pairs(self._activeSequences) do
		if CT >= v.time then
			v.func()
			self._activeSequences[k] = nil
		end
	end
	
	table.Sanitise(self._activeSequences)
end