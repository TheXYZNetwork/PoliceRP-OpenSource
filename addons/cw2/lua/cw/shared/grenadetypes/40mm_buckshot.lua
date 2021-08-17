local gren = {}
gren.name = "40mm_buckshot"
gren.display = " - 40MM BUCK"
gren.pelletCount = 20
gren.pelletDamage = 12
gren.spread = 0.03
gren.clumpSpread = 0.04
gren.fireSound = "CW_M203_FIRE_BUCK"
gren.allowSights = true

function gren:fireFunc()
	if self:filterPrediction() then
		self:FireBullet(gren.pelletDamage, gren.spread, gren.clumpSpread, gren.pelletCount)
	end
end

CustomizableWeaponry.grenadeTypes:addNew(gren)