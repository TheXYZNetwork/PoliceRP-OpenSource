local att = {}
att.name = "bg_makpmm"
att.displayName = "Makarov PMM"
att.displayNameShort = "PMM"
att.isBG = true

att.statModifiers = {AimSpreadMult = -.05,
FireDelayMult = -.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_makpmm")
end

function att:attachFunc()
	self:setBodygroup(self.BodyBGs.main, self.BodyBGs.pmm)
					if self.WMEnt then
		self.WMEnt:SetBodygroup(self.BodyBGs.main, self.BodyBGs.pmm)
	end
				if not self:isAttachmentActive("sights") then
		self:updateIronsights("MakPMM")
	end
end

function att:detachFunc()
	self:setBodygroup(self.BodyBGs.main, self.BodyBGs.pm)
					if self.WMEnt then
		self.WMEnt:SetBodygroup(self.BodyBGs.main, self.BodyBGs.pm)
	end
	self:revertToOriginalIronsights()
end

CustomizableWeaponry:registerAttachment(att)