if not file.Exists("xyzcommunity", "DATA") then
	file.CreateDir("xyzcommunity")
end	
if not file.Exists("xyzcommunity/badges", "DATA") then
	file.CreateDir("xyzcommunity/badges")
end  

local function saveImage(data, name)
	file.Write( "xyzcommunity/badges/"..name..".png", data )
	print(name..".png saved.")
end

local function checkImage(name)
	if file.Exists( "xyzcommunity/badges/"..name..".png", "DATA" ) then
		return true
	else
		return false
	end
end

local function registerIcon(name)
	http.Fetch("https://i.thexyznetwork.xyz/badges/"..name..".png",
		function(body, len, headers, code)
			saveImage(body, name)
		end
	)
end

hook.Add("HUDPaint", "xyz_load_badges", function()
	for k, v in pairs(XYZBadges.Config.Badges) do
		if checkImage(v.icon) then continue end
		registerIcon(v.icon)
	end

	hook.Remove("HUDPaint", "xyz_load_badges")
end) 


net.Receive("xyz_badge_network_specific", function()
	local ply = net.ReadString()
	local id_name = net.ReadString()

	if not XYZBadges.Core.UsersBadges[ply] then 
		XYZBadges.Core.UsersBadges[ply] = {}
	end

	XYZBadges.Core.UsersBadges[ply][id_name] = true
end)

net.Receive("xyz_badge_network_general", function()
	local ply = net.ReadString()
	local badges = net.ReadTable()

	if not XYZBadges.Core.UsersBadges[ply] then 
		XYZBadges.Core.UsersBadges[ply] = {}
	end

	for k, v in pairs(badges) do
		XYZBadges.Core.UsersBadges[ply][k] = true
	end
end)


-- XYZBadges.Core.UsersBadges[self:SteamID64()][id_name]
net.Receive("xyz_badge_network_join", function()
	local badges = net.ReadTable() or {}

	for k, v in pairs(badges) do
		if not XYZBadges.Core.UsersBadges[k] then 
			XYZBadges.Core.UsersBadges[k] = {}
		end
		for n, m in pairs(v) do
			XYZBadges.Core.UsersBadges[k][n] = true
		end
	end
end)

