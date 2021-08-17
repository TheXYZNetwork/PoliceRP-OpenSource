local att = {}
att.name = "bg_bentbolt"
att.displayName = "Bent Bolt"
att.displayNameShort = "Bent"

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/bentbolt")
	att.description = {[1] = {t = "Bends the bolt, allowing over-bolt optics.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
    self:setBodygroup(self.BoltBGs.main, self.BoltBGs.bent)
				if self.WMEnt then
		self.WMEnt:SetBodygroup(self.BoltBGs.main, self.BoltBGs.bent)
	end
    self.Animations = {fire = "bent_fire_start",
	reload_start = "bent_reload_start",
	insert = "reload_insert",
	reload_end = "bent_reload_end",
	idle = "bent_reload_end",
	draw = "base_draw"}
end

function att:detachFunc()
    self:setBodygroup(self.BoltBGs.main, self.BoltBGs.straight)
				if self.WMEnt then
		self.WMEnt:SetBodygroup(self.BoltBGs.main, self.BoltBGs.straight)
	end
	self.Animations = {fire = "base_fire_start",
	reload_start = "reload_start",
	insert = "reload_insert",
	reload_end = "reload_end",
	idle = "reload_end",
	draw = "base_draw"}
end

CustomizableWeaponry:registerAttachment(att)