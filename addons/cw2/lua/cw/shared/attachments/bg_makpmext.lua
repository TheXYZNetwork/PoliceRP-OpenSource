local att = {}
att.name = "bg_makpmext"
att.displayName = "Extended Magazine"
att.displayNameShort = "Ext. Mag"

att.statModifiers = {ReloadSpeedMult = -.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_makpmext")
	att.description = {[1] = {t = "Increases mag capacity to 14.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
    self:unloadWeapon()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.pm14rnd)
					if self.WMEnt then
		self.WMEnt:SetBodygroup(self.MagBGs.main, self.MagBGs.pm14rnd)
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
	self:setBodygroup(self.MagBGs.main, self.MagBGs.pm8rnd)
					if self.WMEnt then
		self.WMEnt:SetBodygroup(self.MagBGs.main, self.MagBGs.pm8rnd)
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