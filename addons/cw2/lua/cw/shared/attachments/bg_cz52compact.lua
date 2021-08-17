local att = {}
att.name = "bg_cz52compact"
att.displayName = "CZ Compact"
att.displayNameShort = "Compact"
att.isBG = true

att.statModifiers = {RecoilMult = .1,
DrawSpeedMult = .1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_cz52compact")
	att.description = {[1] = {t = "Now you can be the Czech 007.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.BodyBGs.main, self.BodyBGs.compact)
					if self.WMEnt then
		self.WMEnt:SetBodygroup(self.BodyBGs.main, self.BodyBGs.compact)
	end
				if not self:isAttachmentActive("sights") then
		self:updateIronsights("Compact")
	end
end

function att:detachFunc()
	self:setBodygroup(self.BodyBGs.main, self.BodyBGs.full)
					if self.WMEnt then
		self.WMEnt:SetBodygroup(self.BodyBGs.main, self.BodyBGs.full)
	end
	self:revertToOriginalIronsights()
end

CustomizableWeaponry:registerAttachment(att)