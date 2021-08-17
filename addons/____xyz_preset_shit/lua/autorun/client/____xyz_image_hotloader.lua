XYZShit = XYZShit or {}
XYZShit.Image = {}
XYZShit.Image.ToLoad = {}
XYZShit.Image.QuickAcces = {}

function XYZShit.Image.HotLoad(imageURL, uniqueName, extDir)
	print("[XYZShit]", "Adding", uniqueName, "to hotload. Pulling image from", imageURL)

	local imgType = string.Explode(".", imageURL)
	imgType = imgType[#imgType]

	print("[XYZShit]", "imgType detected as:", imgType)
	table.insert(XYZShit.Image.ToLoad, {name = uniqueName, url = imageURL, mat = Material("data/xyz/"..(extDir and extDir.."/" or "")..uniqueName.."."..imgType), format = imgType, extDir = extDir})
	XYZShit.Image.QuickAcces[uniqueName] = Material("data/xyz/"..(extDir and extDir.."/" or "")..uniqueName.."."..imgType)
end

function XYZShit.Image.GetMat(uniqueName)
	return XYZShit.Image.QuickAcces[uniqueName]
end

XYZShit.Image.FirstLoad = XYZShit.Image.FirstLoad or true
hook.Add("HUDPaint", "XYZShit.Image.Load", function()
	print("[XYZShit]", "Loading images from queued list")

	if not file.Exists("xyz", "DATA") then
		print("[XYZShit]", "Creating xyz directory")

	    file.CreateDir("xyz")
	end 

	for k, v in pairs(XYZShit.Image.ToLoad) do
		if file.Exists("xyz/"..v.name.."."..v.format, "DATA") then continue end
		print("[XYZShit]", v.name, "has not been pulled before")

		if v.extDir and not file.Exists("xyz/"..v.extDir, "DATA") then
			print("[XYZShit]", "Child directory found, creating directory", v.extDir)
		    file.CreateDir("xyz/"..v.extDir)
		end

		print("[XYZShit]", "Now pulling image from", v.url)
		http.Fetch(v.url, function(body, len, headers, code)
			file.Write("xyz/"..(v.extDir and v.extDir.."/" or "")..v.name.."."..v.format, body)
			v.mat = Material("data/xyz/"..(v.extDir and v.extDir.."/" or "")..v.name.."."..v.format)
			XYZShit.Image.QuickAcces[v.name] = v.mat
			print("[XYZShit]", "Image successfully pulled and saved")
		end)
	end

	print("[XYZShit]", "Full load complete")
	hook.Remove("HUDPaint", "XYZShit.Image.Load")
	-- Give a 2 second buffer to allow all of the materials to download
	timer.Simple(2, function()
		hook.Run("XYZPostImageLoad", XYZShit.Image.FirstLoad)
		XYZShit.Image.FirstLoad = false
	end)
end)

XYZShit.Image.HotLoad("https://thexyznetwork.xyz/assets/logo.png", "main_logo")
XYZShit.Image.HotLoad("https://thexyznetwork.xyz/assets/bg.jpg", "main_background")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/star.png", "main_star")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/pin.png", "waypoint_pin")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/911.png", "911_marker")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/ems.png", "ems_marker")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/bodybag.png", "bodybag_marker")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/panicbutton.png", "panicbutton_marker")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/prisonertransport.png", "prisonertransport_marker")
-- For reward system
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/badges/steam.png", "steam_logo")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/discord.png", "discord_logo")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/badges/nitroboost.png", "nitro_boost")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/icons/pd.png", "police_force")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/badges/halloween2020.png", "halloween_2020")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/badges/easter2021.png", "easter_2021")

-- Minimap
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/rp_rockford_v2b_xyz_v1a_overhead.png", "rp_rockford_v2b_xyz_v1a_overhead")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/localplayer.png", "minimap_localplayer")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/spawn.png", "minimap_spawn")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/pd.png", "minimap_pd")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/cardealer.png", "minimap_cardealer")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/ems.png", "minimap_ems")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/bank.png", "minimap_bank")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/towtruck.png", "minimap_towtruck")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/presoffice.png", "minimap_presoffice")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/truck.png", "minimap_truck")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/customs.png", "minimap_customs")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/partner.png", "minimap_partner")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/party.png", "minimap_party")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/mycar.png", "minimap_mycar")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/prison.png", "minimap_prison")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/party_waypoint.png", "minimap_party_waypoint")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/pickaxe.png", "minimap_pickaxe")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/shell.png", "minimap_shell")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/fire_station.png", "minimap_fire_station")
for i=1, 5 do
	XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/sign"..i..".png", "minimap_sign"..i)
end
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/house.png", "minimap_house")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/g4s_truck.png", "g4s_marker")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/casino.png", "minimap_casino")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/rockford_food.png", "minimap_rockford_food")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/rta.png", "minimap_rta")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/pickaxe.png", "minimap_pickaxe")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/minimap/tacobell.png", "minimap_tacobell")
-- Phone 
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/basic.png", "phone_frame_basic", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/knockoffia.png", "phone_frame_knockoffia", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/samsings.png", "phone_frame_samsings", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/uphone.png", "phone_frame_uphone", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/app_bubble.png", "phone_app_bubble", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/app_call.png", "phone_app_call", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/app_contacts.png", "phone_app_contacts", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/app_gallery.png", "phone_app_gallery", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/app_rocket.png", "phone_app_rocket", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/app_settings.png", "phone_app_settings", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/app_snapper.png", "phone_app_snapper", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/background_base.png", "phone_background_base", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/background_fish.png", "phone_background_fish", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/background_lego.png", "phone_background_lego", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/background_monkey.png", "phone_background_monkey", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/background_moon.png", "phone_background_moon", "phone")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/phone/background_space.png", "phone_background_space", "phone")
-- Emote icons
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/agree.png", "emote_agree", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/badass.png", "emote_badass", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/bestmates.png", "emote_bestmates", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/boneless.png", "emote_boneless", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/bow.png", "emote_bow", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/dab.png", "emote_dab", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/dance.png", "emote_dance", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/death_01.png", "emote_death_01", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/disagree.png", "emote_disagree", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/disco.png", "emote_disco", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/floss.png", "emote_floss", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/fresh.png", "emote_fresh", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/handsonhip.png", "emote_handsonhip", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/hype.png", "emote_hype", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/laugh.png", "emote_laugh", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/robot.png", "emote_robot", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/salute.png", "emote_salute", "emotes") 
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/sit.png", "emote_sit", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/surrender.png", "emote_surrender", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/takethel.png", "emote_takethel", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/wave.png", "emote_wave", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/zen.png", "emote_zen", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/fingergun.png", "emote_fingergun", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/dance.png", "emote_dance", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/eagle.png", "emote_eagle", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/smithbobspecial.png", "emote_smithbobspecial", "emotes")
XYZShit.Image.HotLoad("https://i.thexyznetwork.xyz/emote/kneel.png", "emote_kneel", "emotes")