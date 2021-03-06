-- The chat and UI colors
EventSystem.Config.Color = Color(155, 0, 255)
-- Chat command to open event menu
EventSystem.Config.EventCommand = {
	["!event"] = true,
	["!gamemaster"] = true,
	["!gm"] = true,
}

EventSystem.Config.TeamNames = {
	"Odin",
	"Thor",
	"Loki",
	"Frigg",
	"Sif",
	"Idunn",
	"Balder",
	"Forseti",
	"Heimdall",
	"Tyr",
	"Honir",
	"Bragi",
	"Ullr",
	"Skadi",
	"Nanna",
	"Modi",
	"Hod",
	"Ve",
	"Vidar",
	"Vil"
}
EventSystem.Config.MaxTeams = #EventSystem.Config.TeamNames

EventSystem.Config.SpawnBlacklist = {
	["cw_ammo_crate_regular"] = true,
	["cw_ammo_kit_regular"] = true,
	["cw_ammo_crate_small"] = true,
	["cw_ammo_kit_small"] = true,
	["cw_ammo_crate_unlimited"] = true,

	["item_ammo_357"] = true,
	["item_ammo_357_large"] = true,
	["item_ammo_ar2"] = true,
	["item_ammo_ar2_large"] = true,
	["item_ammo_ar2_altfire"] = true,
	["item_ammo_crossbow"] = true,
	["item_healthvial"] = true,
	["item_ammo_pistol"] = true,
	["item_ammo_pistol_large"] = true,
	["item_rpg_round"] = true,
	["item_box_buckshot"] = true,
	["item_box_buckshot"] = true,
	["item_ammo_smg1"] = true,
	["item_ammo_smg1_large"] = true,
	["item_ammo_smg1_grenade"] = true,
	["item_battery"] = true,

	["riot_shield"] = true,
	["heavy_shield"] = true,
	["deployable_shield"] = true,

	["cw_ak74"] = true,
	["cw_ar15"] = true,
	["cw_flash_grenade"] = true,
	["cw_fiveseven"] = true,
	["cw_scarh"] = true,
	["cw_frag_grenade"] = true,
	["cw_g3a3"] = true,
	["cw_g18"] = true,
	["cw_g36c"] = true,
	["cw_ump45"] = true,
	["cw_mp5"] = true,
	["cw_deagle"] = true,
	["cw_l115"] = true,
	["cw_l85a2"] = true,
	["cw_m14"] = true,
	["cw_m1911"] = true,
	["cw_m249_official"] = true,
	["cw_m3super90"] = true,
	["cw_mac11"] = true,
	["cw_mr96"] = true,
	["cw_p99"] = true,
	["cw_makarov"] = true,
	["cw_shorty"] = true,
	["cw_silverballer"] = true,
	["cw_smoke_grenade"] = true,
	["cw_sv98"] = true,
	["cw_vss"] = true,

	["khr_cz52"] = true,
	["khr_cz75"] = true,
	["khr_deagle"] = true,
	["khr_gsh18"] = true,
	["khr_m92fs"] = true,
	["khr_makarov"] = true,
	["khr_microdeagle"] = true,
	["khr_mp443"] = true,
	["khr_ots33"] = true,
	["khr_ruby"] = true,
	["khr_rugermk3"] = true,
	["khr_p345"] = true,
	["khr_p226"] = true,
	["khr_sr1m"] = true,
	["khr_tokarev"] = true,

	["khr_hcar"] = true,
	["khr_m82a3"] = true,
	["khr_m95"] = true,
	["khr_mosin"] = true,
	["khr_t5000"] = true,
	["khr_sr338"] = true,
	["khr_svt40"] = true,

	["khr_model29"] = true,
	["khr_38snub"] = true,
	["khr_swr8"] = true,
	["khr_410jury"] = true,
	["khr_ragingbull"] = true,

	["khr_aek971"] = true,
	["khr_ak103"] = true,
	["khr_cz858"] = true,
	["khr_delisle"] = true,
	["khr_fnfal"] = true,
	["khr_m1carbine"] = true,
	["khr_m4a4"] = true,
	["khr_simsks"] = true,
	["khr_sks"] = true,

	["khr_fmg9"] = true,
	["khr_p90"] = true,
	["khr_vector"] = true,
	["khr_mp40"] = true,
	["khr_mp5a4"] = true,
	["khr_mp5a5"] = true,
	["khr_veresk"] = true,
	["khr_l2a3"] = true,

	["cw_sci-fi_ak47_beast"] = true,
	["cw_sci-fi_g36_balrog"] = true,
	["cw_sci-fi_scout_xbow"] = true,
	["cw_sci-fi_mac_lara"] = true,
	["cw_sci-fi_m4a1_transformer"] = true,
	["cw_sci-fi_47_ethereal"] = true,
	["cw_sci-fi_tmp_dragon"] = true,

	["khr_mp153"] = true,
	["khr_ns2000"] = true,
	["khr_m620"] = true,
	["khr_toz194"] = true,

	["weapon_357"] = true,
	["weapon_pistol"] = true,
	["weapon_crossbow"] = true,
	["weapon_crowbar"] = true,
	["weapon_ar2"] = true,
	["weapon_rpg"] = true,
	["weapon_shotgun"] = true,
	["weapon_smg1"] = true,
	["weapon_stunstick"] = true,

	["rchainsaw"] = true,
	["weapon_chainsaw"] = true,
}

-- How long till the user is force respawned
EventSystem.Config.RespawnTimer = 2