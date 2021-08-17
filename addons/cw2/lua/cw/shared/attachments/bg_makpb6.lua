local att = {}
att.name = "bg_makpb6"
att.displayName = "PB/6P9"
att.displayNameShort = "PB"
att.isBG = true

att.statModifiers = {DamageMult = .025,
RecoilMult = -.1,
DrawSpeedMult = -.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_makpb6")
end

function att:attachFunc()
	self:setBodygroup(self.BodyBGs.main, self.BodyBGs.pb)
					if self.WMEnt then
		self.WMEnt:SetBodygroup(self.BodyBGs.main, self.BodyBGs.pb)
	end
				if not self:isAttachmentActive("sights") then
		self:updateIronsights("PB6P9")
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