local att = {}
att.name = "bg_sb_x300"
att.displayName = "SureFire X300"
att.displayNameShort = "X300"
att.isBG = true

att.statModifiers = {DrawSpeedMult = 0.05,
VelocitySensitivityMult = 0.05}
--[[
0.00 to 1.00		#-				   	#+
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
	att.displayIcon = surface.GetTextureID("atts/att_sb_x300")
end

function att:attachFunc()
	self:setBodygroup(2,1)	--Change BodyGroup. #1 is a set, #2 is an option. Any $model or $body lines are counted as BodyGroups as well. Both numbers use 0 and up. So if you want to change the 1st bodygroup to the 2nd option, first try 1,1.
	if self.WMEnt then
		self.WMEnt:SetBodygroup(2,1)
	end	
end

function att:detachFunc()
	self:setBodygroup(2,0)
	if self.WMEnt then
		self.WMEnt:SetBodygroup(2,0)
	end	
end

CustomizableWeaponry:registerAttachment(att)