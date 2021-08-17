AddCSLuaFile()

CustomizableWeaponry.ammoTypes = CustomizableWeaponry.ammoTypes or {}

-- base ammo registration function
function CustomizableWeaponry:registerAmmo(name, text, bulletDiameter, caseLength)
	CustomizableWeaponry.ammoTypes[name] = {bulletDiameter = bulletDiameter, caseLength = caseLength}
	
	game.AddAmmoType({name = name,
	dmgtype = DMG_BULLET})
	
	if CLIENT then
		language.Add(name .. "_ammo", text)
	end
end

-- aliases
CustomizableWeaponry.registerAmmoType = CustomizableWeaponry.registerAmmo
CustomizableWeaponry.registerNewAmmo = CustomizableWeaponry.registerAmmo

CustomizableWeaponry:registerAmmo("7.62x39MM", "7.62x39MM Rounds", 7.62, 39)
CustomizableWeaponry:registerAmmo("7.62x51MM", "7.62x51MM Rounds", 7.62, 51)
CustomizableWeaponry:registerAmmo("7.62x54MMR", "7.62x54MMR Rounds", 7.62, 39)
CustomizableWeaponry:registerAmmo("5.45x39MM", "5.45x39MM Rounds", 5.45, 39)
CustomizableWeaponry:registerAmmo("5.56x45MM", "5.56x45MM Rounds", 5.56, 45)
CustomizableWeaponry:registerAmmo("5.7x28MM", "5.7x28MM Rounds", 5.7, 28)
CustomizableWeaponry:registerAmmo(".44 Magnum", ".44 Magnum Rounds", 10.9, 32.6)
CustomizableWeaponry:registerAmmo(".45 ACP", ".45 ACP Rounds", 11.5, 22.8)
CustomizableWeaponry:registerAmmo(".50 AE", ".50 AE Rounds", 12.7, 32.6)
CustomizableWeaponry:registerAmmo("9x19MM", "9x19MM Rounds", 9, 19)
CustomizableWeaponry:registerAmmo("12 Gauge", "12 Gauge Rounds", 5, 10)
CustomizableWeaponry:registerAmmo("40MM", "40MM Grenades", 0, 0)
CustomizableWeaponry:registerAmmo("Frag Grenades", "Frag Grenades", 0, 0)
CustomizableWeaponry:registerAmmo("Smoke Grenades", "Smoke Grenades", 0, 0)
CustomizableWeaponry:registerAmmo("Flash Grenades", "Flash Grenades", 0, 0)