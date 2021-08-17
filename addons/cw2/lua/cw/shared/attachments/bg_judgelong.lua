local att = {}
att.name = "bg_judgelong"
att.displayName = "4'' Judge Barrel"
att.displayNameShort = "4''"
att.isBG = true

att.statModifiers = {RecoilMult = 0.05,
AimSpreadMult = -0.25,
DrawSpeedMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_judgelong")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.two)
		if not self:isAttachmentActive("sights") then
		self:updateIronsights("JudgeLong")
	end
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.one)
	self:revertToOriginalIronsights()
end

CustomizableWeaponry:registerAttachment(att)