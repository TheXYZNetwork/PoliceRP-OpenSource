WepSkins.Core.UsersSkins = WepSkins.Core.UsersSkins or {}

hook.Add("PlayerInitialSpawn", "WepSkin:LoadSkins", function(ply)
	WepSkins.Core.UsersSkins[ply:SteamID64()] = {}

	WepSkins.Database.LoadUsersSkins(ply:SteamID64(), function(data)
		if not data then return end

		for k, v in pairs(data) do
			-- Check if everything is still valid
			if not WepSkins.Config.Weps[v.wep] then continue end
			if not WepSkins.Config.Skins[v.skin] then continue end

			WepSkins.Core.UsersSkins[ply:SteamID64()][v.wep] = v.skin
		end

		net.Start("WepSkin:Initial")
			net.WriteTable(WepSkins.Core.UsersSkins[ply:SteamID64()])
		net.Send(ply)
	end)
end)

net.Receive("WepSkin:BuySkin", function(_, ply)
    if XYZShit.CoolDown.Check("WepSkin:BuySkin", 5, ply) then
		XYZShit.Msg("Weapon Skins", Color(200, 100, 0), "Wait a moment before buying another skin!", ply)
    	return
    end

	local npc = net.ReadEntity()

    if not (npc:GetClass() == "xyz_wep_skins") then return end
    if npc:GetPos():Distance(ply:GetPos()) > 500 then return end


	local wepClass = net.ReadString()
	local newSkin = net.ReadString()
	local skinData = WepSkins.Config.Skins[newSkin]

	-- Not a valid wep class
	if not WepSkins.Config.Weps[wepClass] then return end
	-- Not a valid skin
	if not skinData then return end


	if not ply:canAfford(skinData.price) then
		XYZShit.Msg("Weapon Skins", Color(200, 100, 0), "You can't afford this weapon skin...", ply)
		return
	end

	-- Set their active skin in the cache
	WepSkins.Core.UsersSkins[ply:SteamID64()] = WepSkins.Core.UsersSkins[ply:SteamID64()] or {}
	WepSkins.Core.UsersSkins[ply:SteamID64()][wepClass] = newSkin
	-- Update the db
	WepSkins.Database.SetWeaponSkin(ply:SteamID64(), wepClass, newSkin)
	-- Take the money
	ply:addMoney(-skinData.price)
	-- Update the user
	net.Start("WepSkin:Update")
		net.WriteString(wepClass)
		net.WriteString(newSkin)
	net.Send(ply)
	-- Update the world model
	local activeWep = ply:GetWeapon(wepClass)
	if IsValid(activeWep) then
		WepSkins.Core.ApplyWorldModelSkin(ply, activeWep)
	end

	XYZShit.Msg("Weapon Skins", Color(200, 100, 0), "You have painted your gun for $"..string.Comma(skinData.price), ply)
	xLogs.Log(xLogs.Core.Player(ply).." has purchased skin "..xLogs.Core.Color(skinData.name, Color(0, 200, 200)).." for "..xLogs.Core.Color(DarkRP.formatMoney(skinData.price), Color(0, 200, 0)).." for "..xLogs.Core.Color(wepClass, Color(200, 200, 0)), "Weapon Skins")
end)


hook.Add("WeaponEquip", "WepSkin:ApplyWorldModelSkin", function(wep, ply)
	if not wep then return end

    if XYZShit.CoolDown.Check("WepSkin:WeaponEquip:"..wep:GetClass(), 1, ply) then return end -- To prevent weapon skin spamming

    WepSkins.Core.ApplyWorldModelSkin(ply, wep)
end)

function WepSkins.Core.ApplyWorldModelSkin(ply, wep)
	local wepClass = wep:GetClass()

	if not WepSkins.Config.Weps[wepClass] then return end -- Not a skinable weapon
	if not WepSkins.Core.UsersSkins[ply:SteamID64()] then return end -- User has no skins at all
	if not WepSkins.Core.UsersSkins[ply:SteamID64()][wepClass] then return end -- No skin to give to the weapon


	timer.Simple(1, function() -- Cus gmod
		if not IsValid(wep) then return end
		
		if WepSkins.Config.ClientWorldModels[wepClass] then
			net.Start("WepSkin:WorldModel")
				net.WriteInt(wep:EntIndex(), 16)
				net.WriteString(WepSkins.Config.Skins[WepSkins.Core.UsersSkins[ply:SteamID64()][wepClass]].path)
			net.Broadcast()
		else
			wep:SetMaterial(WepSkins.Config.Skins[WepSkins.Core.UsersSkins[ply:SteamID64()][wepClass]].path)
		end
	end)
end