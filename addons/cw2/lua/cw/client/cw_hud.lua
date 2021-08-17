CustomizableWeaponry.ITEM_PACKS_TOP_COLOR = Color(0, 200, 255, 255)

local noDraw = {CHudAmmo = true,
	CHudSecondaryAmmo = true,
	CHudHealth = true,
	CHudBattery = true}

local noDrawAmmo = {CHudAmmo = true,
	CHudSecondaryAmmo = true}
	
local wep, ply

local function CW_HUDShouldDraw(n)
	local customHud = GetConVarNumber("cw_customhud") >= 1
	local customAmmo = GetConVarNumber("cw_customhud_ammo") >= 1
	
	if customAmmo or customHud then
		ply = LocalPlayer()
		
		if IsValid(ply) and ply:Alive() then
			wep = ply:GetActiveWeapon()
		end
	else
		ply, wep = nil, nil
	end
	
	if customAmmo then
		if IsValid(ply) and ply:Alive() then
			if IsValid(wep) and wep.CW20Weapon then
				if noDrawAmmo[n] then
					return false
				end
			end
		end
	end
	
	if customHud then
		if IsValid(ply) and ply:Alive() then
			if IsValid(wep) and wep.CW20Weapon then
				if noDraw[n] then
					return false
				end
			end
		end
	end
end

hook.Add("HUDShouldDraw", "CW_HUDShouldDraw", CW_HUDShouldDraw)