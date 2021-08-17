local att = {}
att.name = "bg_sb_sup"
att.displayName = "Knight's Armament Suppressor"
att.displayNameShort = "KAC"
att.isBG = true
att.isSuppressor = true

att.statModifiers = {RecoilMult = -0.2,
DrawSpeedMult = 0.2,
DamageMult = -0.15}
--[[
"DamageMult", "Decreases damage", "Increases damage"
"RecoilMult", "Decreases recoil", "Increases recoil"
"FireDelayMult", "Decreases firerate", "Increases firerate"
"HipSpreadMult", "Decreases hip spread", "Increases hip spread"
"AimSpreadMult", "Decreases aim spread", "Increases aim spread"
"ClumpSpreadMult", "Decreases clump spread", "Increases clump spread"
"DrawSpeedMult", "Decreases deploy speed", "Increases deploy speed"
"ReloadSpeedMult", "Decreases reload speed", "Increases reload speed"
"OverallMouseSensMult", "Decreases handling", "Increases handling"
"VelocitySensitivityMult", "Increases mobility", "Decreases mobility"
"SpreadPerShotMult", "Decreases spread per shot", "Increases spread per shot"
"MaxSpreadIncMult", "Decreases accumulative spread", "Increases accumulative spread"
--]]

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/att_sb_sup")
	att.description = {[1] = {t = "Reduces firing noise", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(3,1)	
	if self.WMEnt then
		self.WMEnt:SetBodygroup(1,1)
	end	
	self.dt.Suppressed = true
end

function att:detachFunc()
	self:setBodygroup(3,0)	
	if self.WMEnt then
		self.WMEnt:SetBodygroup(1,0)
	end		
	
	self:restoreSound()
	self.dt.Suppressed = false	
end

CustomizableWeaponry:registerAttachment(att)