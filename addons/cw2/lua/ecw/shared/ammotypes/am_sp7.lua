AddCSLuaFile()

local att = {}
att.name = "am_sp7"
att.displayName = "SP-7 Rounds"
att.displayNameShort = "SP-7"
att.isBG = true

att.statModifiers = {DamageMult = 0.15,
	RecoilMult = 0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/sp-7")
end

function att:attachFunc()
	self:unloadWeapon()
end

function att:detachFunc()
	self:unloadWeapon()
end

CustomizableWeaponry:registerAttachment(att)