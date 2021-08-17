/*
CrSkShared_VERSION = 20
CrSkShared_WVERSION = 0

if CLIENT then
	timer.Create("CL_CrSkShared_VersionCheck", 60, 0, function()
		http.Fetch("https://steamcommunity.com/workshop/filedetails/?id=935754808", function(body)
			local workshopVersion = tonumber(body:match('Version ([%d%.]+)%s') or "") or CrSkShared_VERSION
			local workshopVersion_Desc = tostring(body:match("%-%-%-.-Done") or "")
			if not CrSkShared_WasNotificated or CrSkShared_WVERSION < workshopVersion then
				if workshopVersion > CrSkShared_VERSION then
					CrSkShared_WVERSION = workshopVersion
					chat.AddText(Color(255,255,255),"CrSk Autos: Shared textures are outdated!\n", Color(0,255,255),"Workshop version: "..workshopVersion..". Your version: "..CrSkShared_VERSION..".\n"..workshopVersion_Desc.."\n")
					CrSkShared_WasNotificated = true
				end
			end
		end)
	end)
end
*/