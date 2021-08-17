local att = {}

att.name = "bg_g18_30rd_mag"
att.displayName = "Extended Magazine"
att.displayNameShort = "33rd Mag"
att.isBG = true

att.statModifiers = {
  ReloadSpeedMult = -0.1,
  OverallMouseSensMult = -0.05,
  RecoilMult = -0.1,
  SpreadPerShotMult = -0.2,
  VelocitySensitivityMult = 0.15,
}

if CLIENT then
  att.displayIcon = surface.GetTextureID("atts/mp530rnd")
  att.description = {
    [1] = {t = "Increases mag size to 30 rounds.", c = CustomizableWeaponry.textColors.POSITIVE},
    [6] = {t = "Looks 20% more gangsta!", c = CustomizableWeaponry.textColors.COSMETIC}
  }
end

function att:attachFunc()
  //self:setBodygroup(self.MagBGs.main, self.MagBGs.round30)
  self:unloadWeapon()
  self.Primary.ClipSize = 33
  self.Primary.ClipSize_Orig = 33
end

function att:detachFunc()
  //self:setBodygroup(self.MagBGs.main, self.MagBGs.round15)
  self:unloadWeapon()
  self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
  self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)