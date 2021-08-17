local gren = {}
gren.name = "40mm_smoke"
gren.display = " - 40MM SMOKE"
gren.grenadeEntity = "cw_40mm_smoke"

function gren:fireFunc()
	if SERVER then
		CustomizableWeaponry.grenadeTypes.createGrenadeEntity(self, gren.grenadeEntity)
	end
end

CustomizableWeaponry.grenadeTypes:addNew(gren)