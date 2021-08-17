local att = {}
att.name = "md_cz52barrel"
att.displayName = "9MM Barrel"
att.displayNameShort = "9MM"

att.statModifiers = {DamageMult = -.15,
AimSpreadMult = -.1,
RecoilMult = -.25}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/md_cz52barrel")
		att.description = {[1] = {t = "Conversion to a more common caliber.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
    self:unloadWeapon()
self.Primary.Ammo			= "9x19MM"
self.MuzzleEffect = "muzzleflash_pistol"
end

function att:detachFunc()
    self:unloadWeapon()
self.Primary.Ammo			= "7.62x25MM"
self.MuzzleEffect = "muzzleflash_6"
end

CustomizableWeaponry:registerAttachment(att)