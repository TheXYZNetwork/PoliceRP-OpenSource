--[[---------------------------------------------------------------------------
DarkRP custom shipments and guns
---------------------------------------------------------------------------

This file contains your custom shipments and guns.
This file should also contain shipments and guns from DarkRP that you edited.

Note: If you want to edit a default DarkRP shipment, first disable it in darkrp_config/disabled_defaults.lua
  Once you've done that, copy and paste the shipment to this file and edit it.

The default shipments and guns can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomShipmentFields


Add shipments and guns under the following line:
---------------------------------------------------------------------------]]

--
-- Sniper
--

DarkRP.createShipment("L115", {
    model = "models/weapons/w_cstm_l96.mdl",
    entity = "cw_l115",
    amount = 10,
    price = 171000,
    separate = true,
    pricesep = 19000,
    noship = false,
    category = "Sniper",
    allowed = {TEAM_GUND}
})

-- DarkRP.createShipment("SV-98", {
--     model = "models/weapons/w_sv98.mdl",
--     entity = "cw_sv98",
--     amount = 10,
--     price = 288000,
--     separate = true,
--     pricesep = 32000,
--     noship = false,
--     category = "Sniper",
--     allowed = {TEAM_GUND}
-- })

--
-- Shotguns
--

DarkRP.createShipment("Serbu shorty", {
    model = "models/weapons/cw2_super_shorty.mdl",
    entity = "cw_shorty",
    amount = 10,
    price = 81000,
    separate = true,
    pricesep = 9000,
    noship = false,
    category = "Shotguns",
    allowed = {TEAM_GUND}
})

DarkRP.createShipment("M3 Super 90", {
    model = "models/weapons/w_cstm_m3super90.mdl",
    entity = "cw_m3super90",
    amount = 10,
    price = 90000,
    separate = true,
    pricesep = 10000,
    noship = false,
    category = "Shotguns",
    allowed = {TEAM_GUND}
})

--
-- Pistols
--

DarkRP.createShipment("P99", {
    model = "models/weapons/w_pist_p228.mdl",
    entity = "cw_p99",
    amount = 10,
    price = 27000,
    separate = true,
    pricesep = 3000,
    noship = false,
    category = "Pistols",
    allowed = {TEAM_GUND}
})

DarkRP.createShipment("FN Five-Seven", {
    model = "models/weapons/w_pist_fiveseven.mdl",
    entity = "cw_fiveseven",
    amount = 10,
    price = 18000,
    separate = true,
    pricesep = 2000,
    noship = false,
    category = "Pistols",
    allowed = {TEAM_GUND}
})

DarkRP.createShipment("IMI Desert Eagle", {
    model = "models/weapons/w_pist_deagle.mdl",
    entity = "cw_deagle",
    amount = 10,
    price = 45000,
    separate = true,
    pricesep = 5000,
    noship = false,
    category = "Pistols",
    allowed = {TEAM_GUND}
})

DarkRP.createShipment("M1911", {
    model = "models/weapons/cw_pist_m1911.mdl",
    entity = "cw_m1911",
    amount = 10,
    price = 9000,
    separate = true,
    pricesep = 1000,
    noship = false,
    category = "Pistols",
    allowed = {TEAM_GUND}
})

--
-- Rifles
--

-- DarkRP.createShipment("Ak-74", {
--     model = "models/weapons/w_rif_ak47.mdl",
--     entity = "cw_ak74",
--     amount = 10,
--     price = 270000,
--     separate = true,
--     pricesep = 30000,
--     noship = false,
--     category = "Rifles",
--     allowed = {TEAM_GUND}
-- })

-- DarkRP.createShipment("AR-15", {
--     model = "models/weapons/w_rif_m4a1.mdl",
--     entity = "cw_ar15",
--     amount = 10,
--     price = 297000,
--     separate = true,
--     pricesep = 33000,
--     noship = false,
--     category = "Rifles",
--     allowed = {TEAM_GUND}
-- })

DarkRP.createShipment("FN SCAR-H", {
    model = "models/cw2/rifles/w_scarh.mdl",
    entity = "cw_scarh",
    amount = 10,
    price = 252000,
    separate = true,
    pricesep = 28000,
    noship = false,
    category = "Rifles",
    allowed = {TEAM_GUND}
})

DarkRP.createShipment("M14 EBR", {
    model = "models/weapons/w_cstm_m14.mdl",
    entity = "cw_m14",
    amount = 10,
    price = 243000,
    separate = true,
    pricesep = 27000,
    noship = false,
    category = "Rifles",
    allowed = {TEAM_GUND}
})

DarkRP.createShipment("VSS", {
    model = "models/weapons/w_snip_scout.mdl",
    entity = "cw_vss",
    amount = 10,
    price = 216000,
    separate = true,
    pricesep = 24000,
    noship = false,
    category = "Rifles",
    allowed = {TEAM_GUND}
})

DarkRP.createShipment("G36C", {
    model = "models/weapons/cw20_g36c.mdl",
    entity = "cw_g36c",
    amount = 10,
    price = 225000,
    separate = true,
    pricesep = 25000,
    noship = false,
    category = "Rifles",
    allowed = {TEAM_GUND}
})

DarkRP.createShipment("G3A3", {
    model = "models/weapons/w_snip_g3sg1.mdl",
    entity = "cw_g3a3",
    amount = 10,
    price = 207000,
    separate = true,
    pricesep = 23000,
    noship = false,
    category = "Rifles",
    allowed = {TEAM_GUND}
})

--
-- SMG
--

DarkRP.createShipment("H&K UMP .45", {
    model = "models/weapons/w_smg_ump45.mdl",
    entity = "cw_ump45",
    amount = 10,
    price = 162000,
    separate = true,
    pricesep = 18000,
    noship = false,
    category = "SMG",
    allowed = {TEAM_GUND}
})

DarkRP.createShipment("HK MP5", {
    model = "models/weapons/w_smg_mp5.mdl",
    entity = "cw_mp5",
    amount = 10,
    price = 180000,
    separate = true,
    pricesep = 20000,
    noship = false,
    category = "SMG",
    allowed = {TEAM_GUND}
})

DarkRP.createShipment("MAC-11", {
    model = "models/weapons/w_cst_mac11.mdl",
    entity = "cw_mac11",
    amount = 10,
    price = 54000,
    separate = true,
    pricesep = 6000,
    noship = false,
    category = "SMG",
    allowed = {TEAM_GUND}
})
