local att = {}
att.name = "am_svmatch"
att.displayName = "Enhanced Accuracy"
att.displayNameShort = "7N1"

att.statModifiers = {AimSpreadMult = -0.10,
	RecoilMult = 0.05}

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