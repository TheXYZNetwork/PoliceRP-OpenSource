local att = {}
att.name = "bg_makpmmext"
att.displayName = "Extended Magazine"
att.displayNameShort = "Ext. Mag"

att.statModifiers = {ReloadSpeedMult = -.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_makpmmext")
	att.description = {[1] = {t = "Increases mag capacity to 18.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.pmm18rnd)
					if self.WMEnt then
		self.WMEnt:SetBodygroup(self.MagBGs.main, self.MagBGs.pmm18rnd)
	end
    self:unloadWeapon()
	self.Primary.ClipSize = 18
	self.Primary.ClipSize_Orig = 18
	
	self.Animations = {fire = {"base_fire","base_fire2","base_fire3"},
    fire_dry = "base_firelast",
	reload_empty = "base_reloadempty_extmag",
	reload = "base_reload_extmag",
	idle = "base_idle",
	draw = "base_ready"}
end

function att:detachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.pm8rnd)
					if self.WMEnt then
		self.WMEnt:SetBodygroup(self.MagBGs.main, self.MagBGs.pm8rnd)
	end
    self:unloadWeapon()
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