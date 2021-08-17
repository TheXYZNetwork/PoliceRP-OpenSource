function CustomizableWeaponry.InitPostEntity()
	local ply = LocalPlayer()

	CustomizableWeaponry.initCWVariables(ply)
end

hook.Add("InitPostEntity", "CustomizableWeaponry.InitPostEntity", CustomizableWeaponry.InitPostEntity)