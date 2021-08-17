ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Police Podium"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.AdminSpawnable = true
ENT.Spawnable = true

-- This is a tabe of all networked variabes so Get and Set can be used on them
function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "State")
	self:NetworkVar("Bool", 0, "Background")
end

if CLIENT then
	if not file.Exists("xyzcommunity", "DATA") then
		file.CreateDir("xyzcommunity")
	end	

	if file.Exists("xyzcommunity/bg_pd.jpg", "DATA") then
		if !IsValid(ENT) then return end
		ENT.Background = Material("data/xyzcommunity/bg_pd.jpg")
		return
	end
	http.Fetch("https://i.thexyznetwork.xyz/bg_pd.jpg",
		function(body, len, headers, code)
			file.Write("xyzcommunity/bg_pd.jpg", body)
			if !IsValid(ENT) then return end
			ENT.Background = Material("data/xyzcommunity/bg_pd.jpg")
		end
	)
end