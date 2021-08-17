AddCSLuaFile()

// I never was about creating big weapon packs so
// Ill use this one to host content shared between my sweps
CustomizableWeaponry_KK_HK416 = true

if CLIENT then
	//meh, I still dont get why they need extra init
	CustomizableWeaponry_KK_ReflexSightRT = GetRenderTarget("ReflexSightRTKK", 512, 512, false) //why GetRenderTarget does not initialize them?
	CustomizableWeaponry_KK_ReflexSightRT_Ini = true // or am I doing it wrong?
	CustomizableWeaponry_KK_MagnifyingRT = GetRenderTarget("MagnifyingRTKK", 512, 512, false)
	CustomizableWeaponry_KK_MagnifyingRT_Ini = true
	CustomizableWeaponry_KK_SimpleTelescopeRT = GetRenderTarget("SimpleTelescopeRTKK", 1024, 1024, false)
	CustomizableWeaponry_KK_SimpleTelescopeRT_Ini = true
	CustomizableWeaponry_KK_HoloSightRT = GetRenderTarget("HoloSightRTKK", 512, 512, false)
	CustomizableWeaponry_KK_HoloSightRT_Ini = true
	
	local function CW20_KK_ExtraRenderScene()
		local ply = LocalPlayer()
		local wep = ply:GetActiveWeapon()
		
		if IsValid(wep) and wep.CW20Weapon then
			// ...amazing, isn't it?
			// - it sure is 			
			if wep.KKRenderTargetFunc then
				wep.KKRenderTargetFunc(wep)
			end
		end
	end

	hook.Add("RenderScene", "CW20_KK_ExtraRenderScene", CW20_KK_ExtraRenderScene)
	
end

if CustomizableWeaponry_KK and CustomizableWeaponry_KK.HOME then 
	if CLIENT then
		CreateClientConVar("cw_kk_freeze_reticles", 0, false, false) // for positioning
	end
else
	CreateConVar("cw_kk_freeze_reticles", 0, {FCVAR_CHEAT}, "Freezes reticles in optics, intended for use when creating swep aimpositions." )
end



