CustomizableWeaponry.statDisplay = {}
CustomizableWeaponry.statDisplay.registered = {}
CustomizableWeaponry.statDisplay.highest = {}
CustomizableWeaponry.statDisplay.totalCount = 0
CustomizableWeaponry.statDisplay.descFont = "CW_HUD32"
CustomizableWeaponry.statDisplay.vertSpacing = 45

local orig = "_Orig"
local fallbackFuncs = {}
fallbackFuncs.roundValue = 0
fallbackFuncs.mulAmount = 1

-- this default comparator function compares values and returns color tables based on the result
function fallbackFuncs:compare(wep)
	if self.reverse then
		local var1, var2 = wep[self.varName], wep[self.origVarName]
		
		if var1 < var2 then
			return CustomizableWeaponry.textColors.POSITIVE
		elseif var1 > var2 then
			return CustomizableWeaponry.textColors.NEGATIVE
		end
	else
		local var1, var2 = wep[self.varName], wep[self.origVarName]
		
		if var1 > var2 then
			return CustomizableWeaponry.textColors.POSITIVE
		elseif var1 < var2 then
			return CustomizableWeaponry.textColors.NEGATIVE
		end
	end
	
	return CustomizableWeaponry.textColors.REGULAR
end

local percentage = "%"

function fallbackFuncs:textFunc(wep)
	local addition, finalText
	
	if self.percentage then
		addition = percentage
	end
	
	finalText = math.Round(wep[self.varName])

	if addition then
		finalText = finalText .. addition
	end
	
	return finalText
end

function fallbackFuncs:origTextFunc(wep)
	return wep[self.origVarName]
end

fallbackFuncs.mtindex = {__index = fallbackFuncs}

-- you can register stats to display by calling this function
-- take a look at the structure of already registered stats to see how it's done
function CustomizableWeaponry.statDisplay:addStat(tbl)
	-- add fallback functions
	setmetatable(tbl, fallbackFuncs.mtindex)
	
	-- setup fonts and var names
	tbl.origVarName = tbl.varName .. orig
	tbl.textFont = tbl.textFont or "CW_HUD40"
	tbl.statFont = tbl.statFont or "CW_HUD40"
	
	-- break up the line breaks into separate strings
	tbl.desc = string.Explode("\n", tbl.desc)
	
	-- increment amount of displayed stats by 1
	self.totalCount = self.totalCount + 1
	table.insert(self.registered, tbl)
end

local hud48 = "CW_HUD48"
local hud40 = "CW_HUD40"
local gradient = surface.GetTextureID("cw2/gui/gradient")

function CustomizableWeaponry.statDisplay:draw(wep, tab)
	local baseY = -self.totalCount * self.vertSpacing * 0.5 + 100
	local baseX = -100
	
	surface.SetTexture(gradient)
	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawTexturedRect(baseX, baseY - 170, 500, 100)
	
	draw.ShadowText(wep:getKeyBind("+attack") .. " - cycle descriptions forward", hud48, baseX + 2, baseY - 147, wep.HUDColors.white, wep.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.ShadowText(wep:getKeyBind("+attack2") .. " - cycle descriptions back", hud48, baseX + 2, baseY - 96, wep.HUDColors.white, wep.HUDColors.black, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		
	draw.ShadowText("STAT", hud48, baseX, baseY, CustomizableWeaponry.textColors.REGULAR, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.ShadowText("BASE", hud48, baseX + 400, baseY, CustomizableWeaponry.textColors.REGULAR, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.ShadowText("CUR", hud48, baseX + 580, baseY, CustomizableWeaponry.textColors.REGULAR, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
	surface.SetDrawColor(0, 0, 0, 150)
	
	baseY = baseY + self.vertSpacing
	
	surface.DrawRect(baseX + 340, baseY - self.vertSpacing * 0.5, 120, self.totalCount * self.vertSpacing)
	surface.DrawRect(baseX + 520, baseY - self.vertSpacing * 0.5, 120, self.totalCount * self.vertSpacing)
	
	for k, v in ipairs(self.registered) do
		-- draw stat name
		
		if tab.descOfStat == k then
			draw.ShadowText(">", v.textFont, baseX - 50, baseY + (k - 1) * self.vertSpacing, CustomizableWeaponry.textColors.POSITIVE, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.ShadowText(v.display, v.textFont, baseX, baseY + (k - 1) * self.vertSpacing, CustomizableWeaponry.textColors.POSITIVE, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			
			if v.desc then
				local lines = #v.desc
				surface.SetDrawColor(0, 0, 0, 200)
				surface.DrawTexturedRect(baseX + 695, baseY - 20, 500, lines * self.vertSpacing)

				for k2, v2 in pairs(v.desc) do
					draw.ShadowText(v2, self.descFont, baseX + 700, baseY + (k2 - 1) * self.vertSpacing, CustomizableWeaponry.textColors.REGULAR, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) 
				end
			end
		else
			draw.ShadowText(v.display, v.textFont, baseX, baseY + (k - 1) * self.vertSpacing, CustomizableWeaponry.textColors.REGULAR, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		
		-- draw original stat value
		draw.ShadowText(v:origTextFunc(wep), v.statFont, baseX + 400, baseY + (k - 1) * self.vertSpacing, CustomizableWeaponry.textColors.GRAY, CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		
		-- draw current stat value, with cock :)
		draw.ShadowText(v:textFunc(wep), v.statFont, baseX + 580, baseY + (k - 1) * self.vertSpacing, v:compare(wep), CustomizableWeaponry.textColors.BLACK, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
end

-- below is the registration of all displayed stats

local stat = {}
stat.varName = "Damage"
stat.display = "DAMAGE"
stat.desc = "Damage each shot deals within half its effective range."

function stat:textFunc(wep)
	return math.Round(wep.Damage) .. "x" .. wep.Shots
end

function stat:origTextFunc(wep)
	return math.Round(wep.Damage_Orig) .. "x" .. wep.Shots_Orig
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "Damage"
stat.display = "DAMAGE PER MAG"
stat.desc = "Damage that can be dealt from a single magazine within\nhalf the weapon's effective range."

function stat:compare(wep)
	if wep.Damage * wep.Primary.ClipSize_Orig * wep.Shots > wep.Damage_Orig * wep.Primary.ClipSize_ORIG_REAL * wep.Shots_Orig then 
		return CustomizableWeaponry.textColors.POSITIVE
	elseif wep.Damage * wep.Primary.ClipSize_Orig * wep.Shots < wep.Damage_Orig * wep.Primary.ClipSize_ORIG_REAL * wep.Shots_Orig then
		return CustomizableWeaponry.textColors.NEGATIVE
	end
	
	return CustomizableWeaponry.textColors.REGULAR
end

function stat:textFunc(wep)
	return math.Round(wep.Damage * wep.Primary.ClipSize_Orig * wep.Shots)
end

function stat:origTextFunc(wep)
	return math.Round(wep.Damage_Orig * wep.Primary.ClipSize_ORIG_REAL * wep.Shots_Orig)
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "Damage"
stat.display = "DAMAGE PER SEC"
stat.desc = "Damage that can be dealt in a single second\nwithin half the weapon's effective range."

function stat:compare(wep)
	if wep.Damage * wep.Shots / wep.FireDelay > wep.Damage_Orig * wep.Shots_Orig / wep.FireDelay_Orig  then 
		return CustomizableWeaponry.textColors.POSITIVE
	elseif wep.Damage * wep.Shots / wep.FireDelay < wep.Damage_Orig * wep.Shots_Orig / wep.FireDelay_Orig then
		return CustomizableWeaponry.textColors.NEGATIVE
	end
	
	return CustomizableWeaponry.textColors.REGULAR
end

function stat:textFunc(wep)
	return math.Round(wep.Damage * wep.Shots / wep.FireDelay)
end

function stat:origTextFunc(wep)
	return math.Round(wep.Damage_Orig * wep.Shots_Orig / wep.FireDelay_Orig)
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "EffectiveRange"
stat.display = "EFFECTIVE RANGE"
stat.statFont = "CW_HUD36"
stat.desc = "The effective range of this weapon.\nOnce the bullet's flight distance surpasses 50% of this value,\nthe damage will slowly start falling off.\nDistance in meters."

function stat:compare(wep)
	if wep.EffectiveRange > wep.EffectiveRange_Orig then 
		return CustomizableWeaponry.textColors.POSITIVE
	elseif wep.EffectiveRange < wep.EffectiveRange_Orig then
		return CustomizableWeaponry.textColors.NEGATIVE
	end
	
	return CustomizableWeaponry.textColors.REGULAR
end

function stat:textFunc(wep)
	return math.Round(wep.EffectiveRange / 39.37, 1) .. "M"
end

function stat:origTextFunc(wep)
	return math.Round(wep.EffectiveRange_Orig / 39.37, 1) .. "M"
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "DamageFallOff"
stat.display = "DAMAGE FALL OFF"
stat.statFont = "CW_HUD36"
stat.desc = "The shot's damage will be decreased by this much\nonce it has traveled past it's effective range.\nThe damage also lowers past 50% of the effective range."

function stat:compare(wep)
	if wep.EffectiveRange > wep.EffectiveRange_Orig then 
		return CustomizableWeaponry.textColors.POSITIVE
	elseif wep.EffectiveRange < wep.EffectiveRange_Orig then
		return CustomizableWeaponry.textColors.NEGATIVE
	end
	
	return CustomizableWeaponry.textColors.REGULAR
end

function stat:textFunc(wep)
	return math.Round(wep.DamageFallOff * 100) .. "%"
end

function stat:origTextFunc(wep)
	return math.Round(wep.DamageFallOff_Orig * 100) .. "%"
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "FireDelay"
stat.display = "FIRERATE"
stat.reverse = true
stat.desc = "The weapon's rate of fire.\nThe weapon can fire this many rounds in 60 seconds."

function stat:textFunc(wep)
	return math.Round(60 / wep.FireDelay)
end

function stat:origTextFunc(wep)
	return math.Round(60 / wep.FireDelay_Orig)
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "HipSpread"
stat.display = "HIP SPREAD"
stat.reverse = true
stat.desc = "The weapon's inaccuracy when firing from the hip.\nGenerally should be low for CQC weapons."

function stat:textFunc(wep)
	return math.Round(wep.HipSpread * 1000) .. "%"
end

function stat:origTextFunc(wep)
	return math.Round(wep.HipSpread_Orig * 1000) .. "%"
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "AimSpread"
stat.display = "AIM ACCURACY"
stat.statFont = "CW_HUD36"
stat.reverse = true
stat.desc = "The weapon's accuracy when firing while aiming.\nAcceptable percentage for mid-range: 87% and up\nAcceptable percentage for long range: 95% and up"

function stat:textFunc(wep)
	return math.Round((100 - wep.AimSpread * 1000), 1) .. "%"
end

function stat:origTextFunc(wep)
	return math.Round((100 - wep.AimSpread_Orig * 1000), 1) .. "%"
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "ClumpSpread"
stat.display = "CLUMP SPREAD"
stat.statFont = "CW_HUD36"
stat.reverse = true
stat.desc = "The shot's clump spread.\nEach buckshot's clump has a maximum spread of this value."

function stat:compare(wep)
	-- if the weapon has clump spread now, but originally had none, that's a bad thing
	if wep.ClumpSpread and not wep.ClumpSpread_Orig then
		return CustomizableWeaponry.textColors.NEGATIVE
	end
	
	-- if it does not have clump spread now, but it had originally, that's a good thing
	if not wep.ClumpSpread and wep.ClumpSpread_Orig then
		return CustomizableWeaponry.textColors.POSITIVE
	end
	
	if wep.ClumpSpread and wep.ClumpSpread_Orig then
		-- if it has clump spread, and it's lower than the original clump spread - it's good; otherwise - it's bad
		if wep.ClumpSpread < wep.ClumpSpread_Orig then
			return CustomizableWeaponry.textColors.POSITIVE
		elseif wep.ClumpSpread > wep.ClumpSpread_Orig then
			return CustomizableWeaponry.textColors.NEGATIVE
		end
	end
	
	-- none of the conditions match, that means there is no difference between now and then
	return CustomizableWeaponry.textColors.REGULAR
end

function stat:textFunc(wep)
	if wep.ClumpSpread then
		return math.Round(wep.ClumpSpread * 1000) .. "%"
	end
	
	return "N/A"
end

function stat:origTextFunc(wep)
	if wep.ClumpSpread_Orig then
		return math.Round(wep.ClumpSpread_Orig * 1000) .. "%"
	end
	
	return "N/A"
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "SpreadPerShot"
stat.display = "SPREAD PER SHOT"
stat.statFont = "CW_HUD36"
stat.reverse = true
stat.desc = "Spread added per each shot."

function stat:textFunc(wep)
	return "+" .. math.Round(wep.SpreadPerShot * 1000, 1) .. "%"
end

function stat:origTextFunc(wep)
	return "+" .. math.Round(wep.SpreadPerShot_Orig * 1000, 1) .. "%"
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "MaxSpreadInc"
stat.display = "MAX SPREAD INC"
stat.statFont = "CW_HUD36"
stat.reverse = true
stat.desc = "How much additional spread can the weapon accumulate\nfrom continuous fire.\nLower percentages allow for more rounds to be fired without\nhaving to take breaks from firing to normalize the spread."

function stat:textFunc(wep)
	return "+" .. math.Round(wep.MaxSpreadInc * 1000, 1) .. "%"
end

function stat:origTextFunc(wep)
	return "+" .. math.Round(wep.MaxSpreadInc_Orig * 1000, 1) .. "%"
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "Recoil"
stat.display = "RECOIL"
stat.reverse = true
stat.desc = "The weapon's recoil from each shot.\nWeapon recoil increases as your weapon's accuracy\nlowers from continuous fire."

function stat:textFunc(wep)
	return math.Round(wep.Recoil / 3 * 100) .. "%"
end

function stat:origTextFunc(wep)
	return math.Round(wep.Recoil_Orig / 3 * 100) .. "%"
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "VelocitySensitivity"
stat.display = "MOBILITY"
stat.reverse = true
stat.desc = "Defines how much spread will be added to the weapon\nwhen moving. Higher values mean less spread.\nTaking aim while moving greatly reduces the spread increase."

function stat:textFunc(wep)
	return math.Round(100 - wep.VelocitySensitivity / 3 * 100) .. "%"
end

function stat:origTextFunc(wep)
	return math.Round(100 - wep.VelocitySensitivity_Orig / 3 * 100) .. "%"
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "OverallMouseSens"
stat.display = "HANDLING"
stat.desc = "Affects mouse sensitivity.\nLower means less sensitivity.\nIn general should be as high as possible for CQC weapons."

function stat:textFunc(wep)
	return math.Round((wep.OverallMouseSens / 1) * 100) .. "%"
end

function stat:origTextFunc(wep)
	return math.Round((wep.OverallMouseSens_Orig / 1) * 100) .. "%"
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "DeployTime"
stat.display = "DEPLOY TIME"
stat.desc = "Time it takes in seconds to have the weapon be combat-ready upon deploying."

function stat:compare(wep)
	local orig = wep.DeployTime_Orig / wep.DrawSpeed_Orig
	local cur = wep.DeployTime / wep.DrawSpeed
	
	if cur < orig then
		return CustomizableWeaponry.textColors.POSITIVE
	elseif cur > orig then
		return CustomizableWeaponry.textColors.NEGATIVE
	end

	-- none of the conditions match, that means there is no difference between now and then
	return CustomizableWeaponry.textColors.REGULAR
end

function stat:textFunc(wep)
	return math.Round(wep.DeployTime / wep.DrawSpeed, 2) .. "s"
end

function stat:origTextFunc(wep)
	return math.Round(wep.DeployTime_Orig / wep.DrawSpeed_Orig, 2) .. "s"
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "ReloadHalt"
stat.display = "RELOAD TIME"
stat.desc = "Time it takes in seconds to do a partial weapon reload.\nFor shotguns it indicates the amount of time taken to bring the gun up\nand insert one shell."

function stat:compare(wep)
	if wep.ShotgunReload then
		local time = self:shotgunTextFunc(wep)
		
		if time / wep.ReloadSpeed < time / wep.ReloadSpeed_Orig then
			return CustomizableWeaponry.textColors.POSITIVE
		elseif time / wep.ReloadSpeed > time / wep.ReloadSpeed_Orig then
			return CustomizableWeaponry.textColors.NEGATIVE
		end
		
		return CustomizableWeaponry.textColors.REGULAR
	end
	
	local orig = wep.ReloadHalt_Orig / wep.ReloadSpeed_Orig
	local cur = wep.ReloadHalt / wep.ReloadSpeed
	
	if cur < orig then
		return CustomizableWeaponry.textColors.POSITIVE
	elseif cur > orig then
		return CustomizableWeaponry.textColors.NEGATIVE
	end

	-- none of the conditions match, that means there is no difference between now and then
	return CustomizableWeaponry.textColors.REGULAR
end

function stat:shotgunTextFunc(wep)
	return (wep.ReloadStartTime + wep.InsertShellTime)
end

function stat:textFunc(wep)
	if wep.ShotgunReload then
		return math.Round(self:shotgunTextFunc(wep) / wep.ReloadSpeed, 2) .. "s"
	end
	
	return math.Round(wep.ReloadHalt / wep.ReloadSpeed, 2) .. "s"
end

function stat:origTextFunc(wep)
	if wep.ShotgunReload then
		return math.Round(self:shotgunTextFunc(wep) / wep.ReloadSpeed_Orig, 2) .. "s"
	end
	
	return math.Round(wep.ReloadHalt_Orig / wep.ReloadSpeed_Orig, 2) .. "s"
end

CustomizableWeaponry.statDisplay:addStat(stat)

local stat = {}
stat.varName = "ReloadHalt_Empty"
stat.display = "FULL RELOAD TIME"
stat.desc = "Time it takes in seconds to do a full weapon reload.\nFor shotguns it indicates the time it takes to fully reload an empty weapon."

function stat:compare(wep)
	if wep.ShotgunReload then
		local time = self:shotgunTextFunc(wep)
		
		if time / wep.ReloadSpeed < time / wep.ReloadSpeed_Orig then
			return CustomizableWeaponry.textColors.POSITIVE
		elseif time / wep.ReloadSpeed > time / wep.ReloadSpeed_Orig then
			return CustomizableWeaponry.textColors.NEGATIVE
		end
		
		return CustomizableWeaponry.textColors.REGULAR
	end
	
	local orig = wep.ReloadHalt_Empty_Orig / wep.ReloadSpeed_Orig
	local cur = wep.ReloadHalt_Empty / wep.ReloadSpeed
	
	if cur < orig then
		return CustomizableWeaponry.textColors.POSITIVE
	elseif cur > orig then
		return CustomizableWeaponry.textColors.NEGATIVE
	end

	-- none of the conditions match, that means there is no difference between now and then
	return CustomizableWeaponry.textColors.REGULAR
end

function stat:shotgunTextFunc(wep)
	return (wep.ReloadStartTime + wep.InsertShellTime * wep.Primary.ClipSize + wep.ReloadFinishWait)
end

function stat:textFunc(wep)
	if wep.ShotgunReload then
		return math.Round(self:shotgunTextFunc(wep) / wep.ReloadSpeed, 2) .. "s"
	end
	
	return math.Round(wep.ReloadHalt_Empty / wep.ReloadSpeed, 2) .. "s"
end

function stat:origTextFunc(wep)
	if wep.ShotgunReload then
		return math.Round(self:shotgunTextFunc(wep) / wep.ReloadSpeed_Orig, 2) .. "s"
	end
	
	return math.Round(wep.ReloadHalt_Empty_Orig / wep.ReloadSpeed_Orig, 2) .. "s"
end

CustomizableWeaponry.statDisplay:addStat(stat)