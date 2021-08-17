local att = {}
att.name = "md_m203"
att.displayName = "M203"
att.displayNameShort = "M203"
att.isGrenadeLauncher = true

att.statModifiers = {DrawSpeedMult = -0.2,
OverallMouseSensMult = -0.2,
RecoilMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/m203")
	att.description = {[1] = {t = "Allows the user to fire 40MM rounds.", c = CustomizableWeaponry.textColors.POSITIVE}}
	
	function att:attachFunc()
		self:resetM203Anim()
	end
	
	function att:detachFunc()
		self:resetM203Anim()
		self.dt.M203Active = false
		self.M203AngDiff = Angle(0, 0, 0)
	end
end

CustomizableWeaponry:registerAttachment(att)

CustomizableWeaponry:addReloadSound("CW_M203_OPEN", "weapons/cw_m203/open.wav")
CustomizableWeaponry:addReloadSound("CW_M203_CLOSE", "weapons/cw_m203/close.wav")
CustomizableWeaponry:addReloadSound("CW_M203_REMOVE", "weapons/cw_m203/remove.wav")
CustomizableWeaponry:addReloadSound("CW_M203_INSERT", "weapons/cw_m203/insert.wav")
CustomizableWeaponry:addFireSound("CW_M203_FIRE", "weapons/cw_m203/fire.wav", 1, 90, CHAN_STATIC)
CustomizableWeaponry:addFireSound("CW_M203_FIRE_BUCK", "weapons/cw_m203/fire_buck.wav", 1, 100, CHAN_STATIC)