XYZSettings.SettingsCache = {} -- or XYZSettings.SettingsCache or {}
XYZSettings.RegisteredSettings = {} -- or XYZSettings.SettingsCache or {}



-- Manage settings
function XYZSettings.GetSetting(setting, default)
	if XYZSettings.SettingsCache[setting] ~= nil then
		return XYZSettings.SettingsCache[setting]
	end

	return default or false
end

function XYZSettings.SetSetting(setting, value)
	XYZSettings.Database.UpdateSetting(setting, value)
	XYZSettings.SettingsCache[setting] = value
end

function XYZSettings.IsSetting(setting)
	if XYZSettings.SettingsCache[setting] then
		return true
	end

	return false
end

-- Types: 1 = text, 2 = number, 3 = dropdown options, 4 = toggle


-- Register settings
function XYZSettings.RegisterSetting(category, setting, type, name, desc, default, check, onComplete, options)
	if not XYZSettings.RegisteredSettings[category] then
		XYZSettings.RegisteredSettings[category] = {}
	end

	local cat = XYZSettings.RegisteredSettings[category]

	if cat[setting] then return end

	cat[setting] = {}
	cat[setting].name = name
	cat[setting].desc = desc
	cat[setting].type = type
	if type == 3 then
		cat[setting].options = options
	end
	cat[setting].setting = setting
	cat[setting].default = default
	cat[setting].check = check
	cat[setting].onComplete = onComplete
end

-- Extra stuff
list.Set("DesktopWindows", "Settings", {
	title = "Settings Alias",
	icon = "icon32/zoom_extend.png",
	init = function()
		XYZSettings.UI()
	end
})

concommand.Add("xyz_settings_set", function(ply, cmd, args)
	if not args[2] then return end

    local value = args[2]
    if value == "true" then
    	value = true
    elseif value == "false" then
    	value = false
    elseif isnumber(args[2]) then
    	value = tonumber(args[2])
    elseif args[3] then
        for k, v in pairs(args) do
            if k < 3 then continue end
            value = value.." "..v
        end
    end

	XYZSettings.SetSetting(args[1], value)
end)

-- Existing configs
-- HUD
XYZSettings.RegisterSetting("HUD", "hud_show_master", 4, "Show HUD", "Show the entire HUD UI", true)
XYZSettings.RegisterSetting("HUD", "hud_show_license", 4, "Show License", "Show the license UI", true)
XYZSettings.RegisterSetting("HUD", "hud_show_wanted", 4, "Show Wanted", "Show the wanted UI", true)
XYZSettings.RegisterSetting("HUD", "hud_show_lockdown", 4, "Show Lockdown", "Show the lockdown UI", true)
XYZSettings.RegisterSetting("HUD", "hud_show_others", 4, "Show Player Overheads", "Show the overhead above players", true)
-- 911 System
XYZSettings.RegisterSetting("911", "911_show_marker", 4, "Show Marker", "Show the 911 location marker on screen", true)
XYZSettings.RegisterSetting("911", "911_show_minimap", 4, "Show Minimap", "Show the 911 location marker on minimap", true)
-- Cars
XYZSettings.RegisterSetting("Cars", "cars_customs_underglow", 4, "Render Underglow", "Show the underglow on cars", true)
-- EMS
XYZSettings.RegisterSetting("EMS", "ems_show_marker", 4, "Show Death Marker", "Show the death location marker on screen", true)
XYZSettings.RegisterSetting("EMS", "ems_show_bodybag_marker", 4, "Show Bodybag Marker", "Show the bodybag location marker on screen", true)
-- Event
XYZSettings.RegisterSetting("Event", "event_show_popup", 4, "Show Join Popup", "Show the join event popup", true)
-- Meeting
XYZSettings.RegisterSetting("Meeting", "meeting_show_overlay", 4, "Show Overlay", "Show the large meeting overlay", true)
-- Panic Button
XYZSettings.RegisterSetting("Panic Button", "panic_show_marker", 4, "Show Marker", "Show the panic location marker on screen", true)
XYZSettings.RegisterSetting("Panic Button", "panic_show_minimap", 4, "Show Minimap", "Show the panic location marker on minimap", true)
-- Partner System
XYZSettings.RegisterSetting("Partner", "partner_show_hud", 4, "Show HUD", "Show your partners HUD above your own", true)
XYZSettings.RegisterSetting("Partner", "partner_show_halo", 4, "Show Outline", "Show a outline around your partner", true)
XYZSettings.RegisterSetting("Partner", "partner_distance_halo", 2, "Outline Distance (Units)", "The point the outline stops rendering", 800000)
-- Robable NPC
XYZSettings.RegisterSetting("Robable Store", "rs_show_marker", 4, "Show Store Marker", "Show the store location marker on screen", true)
-- Playtime
XYZSettings.RegisterSetting("Playtime", "playtime_show_hud", 4, "Show Playtime HUD", "Show your playtime HUD", true)
XYZSettings.RegisterSetting("Playtime", "playtime_show_target_hud", 4, "Show Target's Playtime HUD", "Show the person you're looking at's playtime", true)
-- Voicechat
XYZSettings.RegisterSetting("Voice-Chat", "voicechat_show_hud", 4, "Show Voice-Chat HUD", "Show the voice-chat HUD", true)
-- Chat Box
XYZSettings.RegisterSetting("Chat Box", "textbox_show_rank_tags", 4, "Show Rank Tags", "Show user's rank tags on their messages (E.g: Staff, Elite, VIP...)", true)
XYZSettings.RegisterSetting("Chat Box", "textbox_show_custom_tags", 4, "Show Custom Tags", "Show user's custom tags on their messages", true)
XYZSettings.RegisterSetting("Chat Box", "textbox_history_length", 2, "Message History Length", "How many messages of history you can scroll back to", 50)
XYZSettings.RegisterSetting("Chat Box", "textbox_show_timestamps", 4, "Show Timestamps", "Show message timestamps", true)
-- Party
XYZSettings.RegisterSetting("Party", "party_show_hud", 4, "Show Party HUD", "Show your party's HUD", true)
XYZSettings.RegisterSetting("Party", "party_show_halo", 4, "Show Outline", "Show a outline around your party members", true)
XYZSettings.RegisterSetting("Party", "party_show_pings", 4, "Show Pings", "Show pings made by your party members (Concommand: xyz_party_ping)", true)
-- 3rd Person
XYZSettings.RegisterSetting("Camera", "cam_toggle", 4, "Toggle Third Person", "Toggles the third person view", false)
XYZSettings.RegisterSetting("Camera", "cam_type", 3, "Camera Type", "What type of camera to use", "Third Person", nil, nil, {"Third person", "Over the shoulder"})
XYZSettings.RegisterSetting("Camera", "cam_distance", 2, "Camera Distance", "The distance from the player", 50)
-- Rainbow Physgun
XYZSettings.RegisterSetting("Rainbow PhysGun", "rainbowphysgun_enable", 4, "Enable Rainbow", "Should physguns be rainbow (Where applicable)", true)
XYZSettings.RegisterSetting("Rainbow PhysGun", "rainbowphysgun_speed", 2, "Rainbow Speed", "The speed of the rainbow", 50)
-- NPC Overhead
XYZSettings.RegisterSetting("NPC Overhead", "overhead_toggle", 4, "Toggle Overhead", "Should NPC overheads be shown?", true)
XYZSettings.RegisterSetting("NPC Overhead", "overhead_position", 3, "Overhead Position", "The position style of NPC overheads", "Side", nil, nil, {"Side", "Top"})
XYZSettings.RegisterSetting("NPC Overhead", "overhead_distance", 2, "Overhead Distance", "The distance overhead shoudl stop rendering", 400000)
-- xAdmin
XYZSettings.RegisterSetting("xAdmin", "xadmin_chat_messages", 4, "Show Chat Messages", "Show chat messages like teleporting, cloaking ect...", true)
-- xSits
XYZSettings.RegisterSetting("xSits", "xsits_toggle_sound", 4, "Play Sound", "Show a sound play when a new sit is made", true)
XYZSettings.RegisterSetting("xSits", "xsits_sound", 3, "Alert Sound", "The sound to play when a sit comes in", "Voice 1", nil, nil, {"Voice 1", "Voice 2", "Voice 3", "Bell 1", "Bell 2", "Bell 3"})
XYZSettings.RegisterSetting("xSits", "xsits_show", 4, "Show Unclaimed Sits", "Show unclaimed sits menu (Staff-Lead+)", true)
-- Loading Intro
XYZSettings.RegisterSetting("Loading Intro", "intro_toggle_show", 4, "Show Loading Intro", "Show the loading card", true)
-- Rewards
XYZSettings.RegisterSetting("Rewards", "rewards_open_join", 4, "Show Rewards On Join", "Show the rewards UI on join", true)
-- Debug menu
XYZSettings.RegisterSetting("Staff", "staff_debug_menu", 4, "Show Debug Menu", "Show the debug menu when looking at items", true)
-- Speedometer
XYZSettings.RegisterSetting("Speedometer", "speedometer_toggle_show", 4, "Show Speedometer", "Show the speedometer", true)
-- Minimap
XYZSettings.RegisterSetting("Minimap", "minimap_toggle_hud", 4, "Show Minimap HUD", "Show the minimap on your HUD", true)
XYZSettings.RegisterSetting("Minimap", "minimap_show_overlay", 4, "Show Minimap Overlay", "Show the minimap on overlay when pressing M", true)
XYZSettings.RegisterSetting("Minimap", "minmap_show_icons", 4, "Show Minimap Icons", "Show the icons on the minimap", true)
XYZSettings.RegisterSetting("Minimap", "minmap_hud_zoom", 2, "HUD Minimap Zoom", "How zoomed the HUD minimap is", 4)
XYZSettings.RegisterSetting("Minimap", "minmap_clamp_icons", 4, "Clamp Minimap Icons", "Clamp Minimap icons to the edge", true)
-- Halloween
XYZSettings.RegisterSetting("Halloween", "halloween_pumpkin_show", 4, "Show Pumpkin Heads", "Show pumpkin heads on everyone", true)
-- Radio
XYZSettings.RegisterSetting("Car Radio", "cardradio_toggle_play", 4, "Play Car Radio", "Play the radio from a car", true)
XYZSettings.RegisterSetting("Car Radio", "cardradio_volume_cap", 2, "Max Volume", "The max volume to allow", 30)
-- PNC
XYZSettings.RegisterSetting("PNC", "pnc_pt_show_marker", 4, "Show Prisoner Transport Marker", "Show Prisoner Transport location marker on HUD", true)
XYZSettings.RegisterSetting("PNC", "pnc_pt_show_minimap", 4, "Show Prisoner Transport Minimap", "Show Prisoner Transport location marker on minimap", true)
