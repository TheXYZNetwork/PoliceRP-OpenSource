--[[---------------------------------------------------------------------------
DarkRP custom entities
---------------------------------------------------------------------------

This file contains your custom entities.
This file should also contain entities from DarkRP that you edited.

Note: If you want to edit a default DarkRP entity, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the entity to this file and edit it.

The default entities can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua#L111

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomEntityFields

Add entities under the following line:
---------------------------------------------------------------------------]]

---
--- AMMO
---
DarkRP.createEntity("Small Ammo Crate", {
  ent = "cw_ammo_kit_small",
  model = "models/items/boxsrounds.mdl",
  price = 1000,
  max = 2,
  cmd = "buysmallammocreat",
  category = "Ammo",
})

DarkRP.createEntity("Revolver Ammo", {
  ent = "item_ammo_357_large",
  model = "models/Items/357ammo.mdl",
  price = 1500,
  max = 1,
  cmd = "buyrevolverammo",
  category = "Ammo",
})

DarkRP.createEntity("SMG Ammo", {
  ent = "item_ammo_smg1",
  model = "models/Items/BoxMRounds.mdl",
  price = 1500,
  max = 1,
  cmd = "buysmgammo",
  category = "Ammo",
})

DarkRP.createEntity("Pistol Ammo", {
  ent = "item_ammo_pistol",
  model = "models/Items/BoxSRounds.mdl",
  price = 1500,
  max = 1,
  cmd = "buypistolammo",
  category = "Ammo",
})

---
--- PRINTERS
---
DarkRP.createEntity("Printer", {
    ent = "tierp_printer",
    model = "models/freeman/money_printer.mdl",
    price = 5000,
    max = 2,
    cmd = "buytierprinter",
    category = "Printers"
})

DarkRP.createEntity("Printer Battery", {
    ent = "tierp_battery",
    model = "models/freeman/giant_battery.mdl",
    price = 500,
    max = 2,
    cmd = "buytierbattery",
    category = "Printers"
})

---
--- OTHER SHIT
---
/*
DarkRP.createEntity("Sign", {
    ent = "xyz_sign",
    model = "models/props_trainstation/TrackSign02.mdl",
    price = 0,
    max = 1,
    cmd = "buymapsign",
    category = "Other"
})
*/

DarkRP.createEntity("Music Radio", {
    ent = "xyz_portable_radio",
    model = "models/props_lab/citizenradio.mdl",
    price = 1000,
    max = 1,
    cmd = "buyportableradio",
    category = "Other"
})
DarkRP.createEntity("TV", {
    ent = "xyz_news_screen",
    model = "models/props_phx/rt_screen.mdl",
    price = 1000,
    max = 1,
    cmd = "buynewstv",
    category = "Other"
})

DarkRP.createEntity("Donation Box", {
    ent = "vs_donationbox",
    model = "models/props/CS_militia/footlocker01_closed.mdl",
    price = 0,
    max = 1,
    cmd = "buydonationbox",
    category = "Other",
    allowed = {TEAM_HOBO}
})

DarkRP.createEntity("Mask", {
    ent = "pvault_mask",
    model = "models/freeman/vault/owain_hockeymask_prop.mdl",
    price = 10000,
    max = 1,
    cmd = "buymask",
    category = "Other"
})

DarkRP.createEntity("DJ Set", {
    ent = "xyz_dj_set",
    model = "models/uc/props_club/dj_set.mdl",
    price = 10000,
    max = 1,
    cmd = "buydjset",
    category = "Other",
    allowed = {TEAM_DJ}
})

DarkRP.createEntity("Trash Burner", {
    ent = "xyz_trashburner",
    model = "models/zerochain/props_trashman/ztm_trashburner.mdl",
    price = 10000,
    max = 1,
    cmd = "buytrashburner",
    category = "Other",
    allowed = {TEAM_TRASHCOLLECTOR}
})

DarkRP.createEntity("Trash Recycler", {
    ent = "xyz_trashrecycler",
    model = "models/zerochain/props_trashman/ztm_recycler.mdl",
    price = 17000,
    max = 1,
    cmd = "buytrashrecycler",
    category = "Other",
    allowed = {TEAM_TRASHCOLLECTOR}
})
DarkRP.createEntity("Panic Button", {
   ent = "bens_communications_panic_button",
   model = "models/freeman/bcomms/ben_panicbutton.mdl",
   price = 2000,
   max = 1,
   cmd = "buypanicbutton",
   category = "Other",
   allowed = {TEAM_GUND, TEAM_PD_KER}
})
DarkRP.createEntity("Sign", {
    ent = "minimap_sign",
    model = "models/props_trainstation/tracksign02.mdl",
    price = 10000,
    max = 1,
    cmd = "buyminimapsign",
    category = "Other"
})
DarkRP.createEntity("Cash Register", {
    ent = "xyz_cash_register",
    model = "models/props_interiors/cashregister01.mdl",
    price = 5000,
    max = 1,
    cmd = "buycashregister",
    category = "Other"
})

-- Hacker Equipment
DarkRP.createEntity("Laptop", {
    ent = "bens_communications_radio_hacking_station",
    model = "models/freeman/bcomms/ben_laptop.mdl",
    price = 10000,
    max = 1,
    cmd = "buyhackerlaptop",
    category = "Hacker Equipment",
    allowed = {TEAM_HACKER}
})
DarkRP.createEntity("Headset", {
    ent = "bens_communications_headset",
    model = "models/freeman/bcomms/ben_headset.mdl",
    price = 2500,
    max = 1,
    cmd = "buyhackerheadset",
    category = "Hacker Equipment",
    allowed = {TEAM_HACKER}
})
DarkRP.createEntity("Jammer", {
    ent = "bens_radio_jammer",
    model = "models/freeman/bcomms/w_ben_jammer.mdl",
    price = 5000,
    max = 1,
    cmd = "buyhackerjammer",
    category = "Hacker Equipment",
    allowed = {TEAM_HACKER}
})



DarkRP.createEntity("Medkit", {
    ent = "xyz_medkit",
    model = "models/freeman/owain_medkit.mdl",
    price = 15000,
    max = 1,
    cmd = "buymedkit",
    category = "EMS",
    allowed = {TEAM_FR_FC, TEAM_FR_AC, TEAM_FR_DC, TEAM_FR_BC, TEAM_FR_CPT, TEAM_FR_LT, TEAM_FR_SUP}
})

DarkRP.createEntity("Armour Box", {
    ent = "xyz_armour_box",
    model = "models/freeman/owain_hardigg_armour.mdl",
    price = 20000,
    max = 1,
    cmd = "buyarmourbox",
    category = "EMS",
    allowed = {TEAM_FR_FC, TEAM_FR_AC, TEAM_FR_DC, TEAM_FR_BC, TEAM_FR_CPT, TEAM_FR_LT, TEAM_FR_SUP}
})


DarkRP.createEntity("Car Battery", {
    ent = "vc_pickup_fuel_electricity",
    model = "models/items/car_battery01.mdl",
    price = 500,
    max = 1,
    cmd = "carbattery",
    category = "Mechanic",
    allowed = {TEAM_MECHANIC}
})
DarkRP.createEntity("Repair Kit", {
    ent = "vc_pickup_healthkit_25",
    model = "models/vcmod/vcmod_wrenchset.mdl",
    price = 1500,
    max = 1,
    cmd = "repairkit",
    category = "Mechanic",
    allowed = {TEAM_MECHANIC}
})
DarkRP.createEntity("Engine", {
    ent = "vc_pickup_engine",
    model = "models/gibs/airboat_broken_engine.mdl",
    price = 100,
    max = 1,
    cmd = "engine",
    category = "Mechanic",
    allowed = {TEAM_MECHANIC}
})
DarkRP.createEntity("Exhaust", {
    ent = "vc_pickup_exhaust",
    model = "models/props_vehicles/carparts_muffler01a.mdl",
    price = 100,
    max = 1,
    cmd = "exhaust",
    category = "Mechanic",
    allowed = {TEAM_MECHANIC}
})
DarkRP.createEntity("Tire", {
    ent = "vc_pickup_tire",
    model = "models/props_phx/normal_tire.mdl",
    price = 100,
    max = 1,
    cmd = "tire",
    category = "Mechanic",
    allowed = {TEAM_SHERIFFTROOPER, TEAM_SHERIFFFIRSTCLASS, TEAM_SHERIFFMASTER, TEAM_SHERIFFCORPORAL, TEAM_SHERIFFSERGEANT, TEAM_SHERIFFLIEUTENANT, TEAM_SHERIFFCAPTAIN, TEAM_SHERIFFMAJOR, TEAM_CHIEFDEPUTY, TEAM_UNDERSHERIFF, TEAM_SHERIFF, TEAM_MECHANIC}
})

-- Government shit
--AddEntity("Police Barricade", {
--  ent = "xyz_police_barricade",
--  model = "models/freeman/owain_barricade.mdl",
--  price = 0,
--  max = 3,
--  cmd = "/police_barricade",
--  category = "Government",
--  allowed = {TEAM_PLIUTENANT, TEAM_PCAPTAIN, TEAM_PSUP, TEAM_PMAJ, TEAM_PLTC, TEAM_PCOL, TEAM_PDCOM, TEAM_PCOM, TEAM_SHERIFFTROOPER, TEAM_SHERIFFFIRSTCLASS, TEAM_SHERIFFMASTER, TEAM_SHERIFFCORPORAL, TEAM_SHERIFFSERGEANT, TEAM_SHERIFFLIEUTENANT, TEAM_SHERIFFCAPTAIN, TEAM_SHERIFFMAJOR, TEAM_CHIEFDEPUTY, TEAM_UNDERSHERIFF, TEAM_SHERIFF}
--})

AddEntity("Police Sign", {
  ent = "xyz_police_sign",
  model = "models/freeman/owain_roadsign.mdl",
  price = 0,
  max = 1,
  cmd = "/police_sign",
  category = "Government",
  allowed = {TEAM_PLIUTENANT, TEAM_PCAPTAIN, TEAM_PSUP, TEAM_PMAJ, TEAM_PLTC, TEAM_PCOL, TEAM_PDCOM, TEAM_PCOM, TEAM_SHERIFFTROOPER, TEAM_SHERIFFFIRSTCLASS, TEAM_SHERIFFMASTER, TEAM_SHERIFFCORPORAL, TEAM_SHERIFFSERGEANT, TEAM_SHERIFFLIEUTENANT, TEAM_SHERIFFCAPTAIN, TEAM_SHERIFFMAJOR, TEAM_CHIEFDEPUTY, TEAM_UNDERSHERIFF, TEAM_SHERIFF}
})