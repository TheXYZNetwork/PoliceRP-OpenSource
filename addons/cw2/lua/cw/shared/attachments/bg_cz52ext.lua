local att = {}
att.name = "bg_cz52ext"
att.displayName = "Extended Magazine"
att.displayNameShort = "Ext. Mag"

att.statModifiers = {ReloadSpeedMult = -.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_cz52ext")
	att.description = {[1] = {t = "Increases mag capacity to 14.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
    self:unloadWeapon()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.ext)
				if self.WMEnt then
		self.WMEnt:SetBodygroup(self.MagBGs.main, self.MagBGs.ext)
	end
	self.Primary.ClipSize = 14
	self.Primary.ClipSize_Orig = 14
	
	self.Animations = {fire = {"base_fire","base_fire2","base_fire3"},
    fire_dry = "base_firelast",
	reload_empty = "base_reloadempty_extmag",
	reload = "base_reload_extmag",
	idle = "base_idle",
	draw = "base_ready"}
end

function att:detachFunc()
    self:unloadWeapon()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.none)
					if self.WMEnt then
		self.WMEnt:SetBodygroup(self.MagBGs.main, self.MagBGs.none)
	end
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
	
	self.Animations = {fire = {"base_fire","base_fire2","base_fire3"},
    fire_dry = "base_firelast",
	reload_empty = "base_reloadempty",
	reload = "base_reload",
	idle = "base_idle",
	draw = "base_ready"}
end

CustomizableWeaponry:registerAttachment(att)