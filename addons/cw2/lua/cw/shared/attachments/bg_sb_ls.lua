local att = {}
att.name = "bg_sb_ls"
att.displayName = "Long slide"
att.displayNameShort = "Long"
att.isBG = true

att.statModifiers = {RecoilMult = 0.15,
DamageMult = 0.1,
DrawSpeedMult = 0.2}
--[[
"AimSpreadMult", "Decreases aim spread", "Increases aim spread"
"ClumpSpreadMult", "Decreases clump spread", "Increases clump spread"
"DamageMult", "Decreases damage", "Increases damage"
"DrawSpeedMult", "Decreases deploy speed", "Increases deploy speed"
"FireDelayMult", "Decreases firerate", "Increases firerate"
"HipSpreadMult", "Decreases hip spread", "Increases hip spread"
"MaxSpreadIncMult", "Decreases accumulative spread", "Increases accumulative spread"
"OverallMouseSensMult", "Decreases handling", "Increases handling"
"RecoilMult", "Decreases recoil", "Increases recoil"
"ReloadSpeedMult", "Decreases reload speed", "Increases reload speed"
"SpreadPerShotMult", "Decreases spread per shot", "Increases spread per shot"
"VelocitySensitivityMult", "Increases mobility", "Decreases mobility"
--]]

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/att_sb_ls")
end

function att:attachFunc() -- When this attachment is added to this SWep
	self:setBodygroup(1,1)
	self:updateSoundTo("CW_SILVERBALLER_FIRE_LS", CustomizableWeaponry.sounds.UNSUPPRESSED)	-- Changes current SWep's unsuppressed firing sound to something else.
	if self.WMEnt then
		self.WMEnt:SetBodygroup(0,1)
	end	
end

function att:detachFunc() -- When this attachment is removed from this SWep
	self:setBodygroup(1,0)
	self:restoreSound()	-- Restores current SWep's default sound.
	if self.WMEnt then
		self.WMEnt:SetBodygroup(0,0)
	end	
end

CustomizableWeaponry:registerAttachment(att)