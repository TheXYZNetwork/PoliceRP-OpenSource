local att = {}
att.name = "bg_4inchsw29"
att.displayName = "Short Barrel"
att.displayNameShort = "Short"
att.isBG = true

att.statModifiers = {RecoilMult = 0.1,
AimSpreadMult = -0.22,
DrawSpeedMult = -0.10}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_4inchsw29")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.short)
		if not self:isAttachmentActive("sights") then
		self:updateIronsights("M29Short")
	end
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.snub)
	self:revertToOriginalIronsights()
end

CustomizableWeaponry:registerAttachment(att)