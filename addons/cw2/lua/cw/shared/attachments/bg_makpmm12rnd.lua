local att = {}
att.name = "bg_makpmm12rnd"
att.displayName = "Double-Stack Magazine"
att.displayNameShort = "D.S Mag"

att.statModifiers = {ReloadSpeedMult = -.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_makpmm12rnd")
	att.description = {[1] = {t = "Increases mag capacity to 12.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.pmm12rnd)
					if self.WMEnt then
		self.WMEnt:SetBodygroup(self.MagBGs.main, self.MagBGs.pmm12rnd)
	end
    self:unloadWeapon()
	self.Primary.ClipSize = 12
	self.Primary.ClipSize_Orig = 12
end

function att:detachFunc()
    self:unloadWeapon()
	self:setBodygroup(self.MagBGs.main, self.MagBGs.pm8rnd)
					if self.WMEnt then
		self.WMEnt:SetBodygroup(self.MagBGs.main, self.MagBGs.pm8rnd)
	end
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)