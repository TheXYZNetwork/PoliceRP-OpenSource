PNC.Config.Color = Color(220,20,60)
PNC.Config.AllowedVehicles = {
    -- Police Department
    ["forcrownvicpoltdm"] = true,
    ["chargersrt8poltdm"] = true,
    ["charger12poltdm"] = true,
    ["jag_xfr_pol"] = true,
    ["mitsuevoxpoltdm"] = true,
    ["chev_suburban_pol"] = true,
    ["smc_mustang_lapd"] = true,
    -- Sheriff's Department
    ["smc_mustang_gp_15"] = true,
    ["crsk_ford_bronco_1982_police"] = true,
    -- FBI
    ["mereclasspoltdm"] = true,
    ["perryn_2009_bmw_750li"] = true,
    ["jag_xfr_pol_und"] = true,
    ["chev_suburban_pol_und"] = true,
    ["15camaro_cop_sgm"] = true,
    -- SWAT
    ["perryn_bearcat_g3"] = true,
    ["chev_tahoe_police_lw"] = true,
    ["17raptor_cop_sgm"] = true
}
PNC.Config.SpeedChecker = {
    -- Sheriff's Department
    ["smc_mustang_gp_15"] = true,
    ["crsk_ford_bronco_1982_police"] = true
}
PNC.Config.PatrolFinishMoney = 2500
PNC.Config.FootPatrolFinishMoney = 4000

PNC.Config.DepartmentToLog = {
    ["Police Force"] = "pd",
    ["Sheriff's Department"] = "sd",
    ["Swat"] = "swat",
    ["FBI"] = "fbi"
}

PNC.Config.TraceStart = Vector(0,125,45)
PNC.Config.TraceEnd = Vector(0,6000,0)
PNC.Config.TraceScanDistance = 1500
PNC.Config.PrisonerTransportRequestTime = 180