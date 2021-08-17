CustomizableWeaponry:addFireSound("CW_VSS_FIRE", "weapons/cw_vss/fire.wav", 1, 85, CHAN_STATIC)
CustomizableWeaponry:addFireSound("CW_SR3M_FIRE", "weapons/cw_vss/sr3m_fire.wav", 1, 100, CHAN_STATIC) -- it's still relatively quiet due to the fact that the 9x39MM is a cold-loaded sub-sonic round
CustomizableWeaponry:addFireSound("CW_SR3M_FIRE_SUPPRESSED", "weapons/cw_ak74/fire_suppressed.wav", 1, 90, CHAN_STATIC) -- we need a separate sound script because suppressor + cold loaded = a lot quieter than some other round

CustomizableWeaponry:addReloadSound("CW_VSS_MAGOUT", "weapons/cw_vss/magout.wav")
CustomizableWeaponry:addReloadSound("CW_VSS_MAGIN", "weapons/cw_vss/magin.wav")
CustomizableWeaponry:addReloadSound("CW_VSS_BOLTBACK", "weapons/cw_vss/boltback.wav")
CustomizableWeaponry:addReloadSound("CW_VSS_BOLTFORWARD", "weapons/cw_vss/boltforward.wav")