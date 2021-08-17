local att = {}
att.name = "bg_judgelonger"
att.displayName = "6'' Judge Barrel"
att.displayNameShort = "6''"
att.isBG = true

att.statModifiers = {RecoilMult = 0.1,
AimSpreadMult = -0.4,
DrawSpeedMult = -0.2,
OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_judgelonger")
end

function att:attachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.three)
		if not self:isAttachmentActive("sights") then
		self:updateIronsights("JudgeLonger")
	end
end

function att:detachFunc()
	self:setBodygroup(self.BarrelBGs.main, self.BarrelBGs.one)
	self:revertToOriginalIronsights()
end

CustomizableWeaponry:registerAttachment(att)