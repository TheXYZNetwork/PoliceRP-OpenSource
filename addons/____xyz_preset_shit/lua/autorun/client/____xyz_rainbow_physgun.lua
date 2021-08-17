local curTime = CurTime
local player_getAll = player.GetAll
local pairs = pairs
local hsvToColor = HSVToColor
local rainbowColor

hook.Add("Think", "RainbowPhysGun", function()
	if not XYZSettings.GetSetting("rainbowphysgun_enable", true) then return end
	rainbowColor = nil

	for _, ply in pairs(player_getAll()) do
		if ply:GetNWBool("XYZRainbowPhysGun", false) then
			if not rainbowColor then
				rainbowColor = hsvToColor((curTime()*XYZSettings.GetSetting("rainbowphysgun_speed", 50))%360, 1, 1)
				rainbowColor = Color(rainbowColor.r, rainbowColor.g, rainbowColor.b)
				rainbowColor = rainbowColor:ToVector()
			end
			ply:SetWeaponColor(rainbowColor)
		end
	end
end)