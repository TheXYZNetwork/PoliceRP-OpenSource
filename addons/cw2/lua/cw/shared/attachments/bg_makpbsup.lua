local att = {}
att.name = "bg_makpbsup"
att.displayName = "PB Suppressor"
att.displayNameShort = "PB"
att.isSuppressor = true
att.isBG = true

att.statModifiers = {OverallMouseSensMult = -0.2,
RecoilMult = -0.15}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bg_makpb6sup")
	att.description = {[1] = {t = "Reduces firing signature.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.SuppBGs.main, self.SuppBGs.pb)
					if self.WMEnt then
		self.WMEnt:SetBodygroup(self.SuppBGs.main, self.SuppBGs.pb)
	end
	self.dt.Suppressed = true
end

function att:detachFunc()
	self:setBodygroup(self.SuppBGs.main, self.SuppBGs.none)
					if self.WMEnt then
		self.WMEnt:SetBodygroup(self.SuppBGs.main, self.SuppBGs.none)
	end
	self.dt.Suppressed = false
end

CustomizableWeaponry:registerAttachment(att)