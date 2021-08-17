local att = {}
att.name = "bg_hcarfoldsight"
att.displayName = "Folding Ironsights"
att.displayNameShort = "Foldsight"
att.isBG = true
att.aimPos = {"FoldsightPos", "FoldsightAng"}
att.withoutRail = true


if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/foldsight")
	att.description = {[1] = {t = "Basic folding sight.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self:setBodygroup(self.SightBGs.main, self.SightBGs.sg1)
end

function att:detachFunc()
end

CustomizableWeaponry:registerAttachment(att)