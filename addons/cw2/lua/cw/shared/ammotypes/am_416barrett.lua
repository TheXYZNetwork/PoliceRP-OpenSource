local att = {}
att.name = "am_416barrett"
att.displayName = ".416 Barrett Conversion"
att.displayNameShort = ".416"

att.statModifiers = {DamageMult = -.25,
	RecoilMult = -.3,
	AimSpreadMult = -.5,
	FireDelayMult = -.12}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/matchgradeammo")
	att.description = {[1] = {t = "Converts to .416 Barrett.", c = CustomizableWeaponry.textColors.POSITIVE}}
	--[2] = {t = "Increases muzzle velocity by 200 m/s", c = CustomizableWeaponry.textColors.VPOSITIVE}}
end

function att:attachFunc()
	self:unloadWeapon()
	self.Primary.Ammo			= ".416 Barrett"
end

function att:detachFunc()
	self:unloadWeapon()
	self.Primary.Ammo			= ".50 BMG"
end

CustomizableWeaponry:registerAttachment(att)