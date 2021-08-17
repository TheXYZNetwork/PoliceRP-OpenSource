WepSkins.Core.MySkins = WepSkins.Core.MySkins or {}

net.Receive("WepSkin:Initial", function()
	local skinData = net.ReadTable()

	for k, v in pairs(skinData) do
		WepSkins.Core.MySkins[k] = v
	end
end)


net.Receive("WepSkin:Update", function()
	local wepClass = net.ReadString()
	local newSkin = net.ReadString()

	WepSkins.Core.MySkins[wepClass] = newSkin

	local curWep = LocalPlayer():GetActiveWeapon()
	if curWep:GetClass() == wepClass then
		WepSkins.Core.ApplyViewModelSkin(curWep)
	end
end)

net.Receive("WepSkin:WorldModel", function()
	local entIndex = net.ReadInt(16)
	local skin = net.ReadString()

	local wep = Entity(entIndex)
	if not wep then return end
	if not wep.WMEnt then return end
	WepSkins.Core.ApplyWorldModelSkin(wep.WMEnt, skin)
end)


hook.Add("PreDrawViewModel", "WepSkin:ApplyViewModelSkin", function(vm, ply, wep)
	if not wep then return end
	if wep.WepSkinApplied then return end 
	
	WepSkins.Core.ApplyViewModelSkin(wep)

    wep.WepSkinApplied = true
end)

function WepSkins.Core.ApplyViewModelSkin(wep)
	local wepClass = wep:GetClass()

	if not WepSkins.Config.Weps[wepClass] then return end -- Not a skinable weapon
	if not WepSkins.Core.MySkins[wepClass] then return end -- No skin to give to the weapon

    local wepModel = wep.CW_VM
    if not wepModel or not IsValid(wepModel) then return end

	wepModel:SetSubMaterial(WepSkins.Config.Weps[wepClass], WepSkins.Config.Skins[WepSkins.Core.MySkins[wepClass]].path)
end

function WepSkins.Core.ApplyWorldModelSkin(wep, skin)
	if not IsValid(wep) then return end
	wep:SetMaterial(skin)
end