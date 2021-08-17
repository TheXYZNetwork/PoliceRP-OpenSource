-- We really need to make a lib for this. This code is in like 5 addons now...

if not file.Exists("xyzcommunity", "DATA") then
	file.CreateDir("xyzcommunity")
end	

local function saveImage(data, name)
	file.Write( "xyzcommunity/"..name..".png", data )
	print(name..".png saved.")
end

local function checkImage(name)
	if file.Exists( "xyzcommunity/"..name..".png", "DATA" ) then
		return true
	else
		return false
	end
end

local function registerIcon(name)
	http.Fetch("https://i.thexyznetwork.xyz/"..name..".png",
		function(body, len, headers, code)
			saveImage(body, name)
		end
	)
end

hook.Add("HUDPaint", "xstore_loadmats", function()
	if not checkImage("refresh") then
		registerIcon("refresh")
	end

	hook.Remove("HUDPaint", "xstore_loadmats")
end) 
