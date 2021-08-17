local att = {}
att.name = "am_svmag"
att.displayName = "Enhanced Penetration"
att.displayNameShort = "7N13"

att.statModifiers = {DamageMult = 0.10,
	RecoilMult = 0.20}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/matchgradeammo")
	att.description = {}
end

function att:attachFunc()
	self:unloadWeapon()
end

function att:detachFunc()
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)