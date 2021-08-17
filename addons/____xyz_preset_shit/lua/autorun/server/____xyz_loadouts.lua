XYZShit = XYZShit or {}
XYZShit.Loadouts = {}

-- Jobs that will not be included (Within the categories below
XYZShit.Loadouts.Blacklist = {
	["Police Cadet"] = true,
	["Sheriff K9 Dog"] = true
}

-- These items are given to every job that is inside the departments below. That way, you don't need to
-- add things like cuffs to every department
XYZShit.Loadouts.All = {
}
XYZShit.Loadouts.Deparments = {
	["Police Force"] = {
		"weapon_handcuffs",
		"xyz_ticketbook",
		"xyz_pnc_tablet",
		"xyz_weaponchecker",
		"weapon_xyz_baton",
		"xyz_breathalyzer",

		"cw_g18"
	},
	["Sheriff's Department"] = {
		"weapon_handcuffs",
		"xyz_ticketbook",
		"xyz_pnc_tablet",
		"xyz_weaponchecker",
		"weapon_xyz_baton",
		"xyz_breathalyzer",

		"vc_spikestrip_wep",
		"xyz_impound_clamp",
		"vc_wrench",
		"weapon_xyz_speed_gun",

		"khr_model29",
		"khr_m620"
	},
	["FBI"] = {
		"weapon_handcuffs",
		"xyz_ticketbook",
		"xyz_pnc_tablet",
		"xyz_weaponchecker",
		"weapon_xyz_baton",
		"xyz_breathalyzer",

		"pass_fbi",
		"door_ram",

		"cw_fiveseven"
	},
	["Swat"] = {
		"weapon_handcuffs",
		"xyz_ticketbook",
		"xyz_pnc_tablet",
		"xyz_weaponchecker",
		"weapon_xyz_baton",
		"xyz_breathalyzer",

		"car_bomb_defuser",
		"door_ram",

		"cw_flash_grenade",
		"cw_p99"
	},
	["Fire & Rescue"] = {
		"xyz_extinguisher",
		"xyz_defibs",
		"xyz_syringe"
	},
	["Terrorist"] = {
		"lockpick",
		"keypad_cracker",

		"khr_cz75"
	},
	["The Mafia"] = {
		"lockpick",
		"keypad_cracker",

		"cw_silverballer",
		"cw_mac11"
	}
}

hook.Add("PlayerLoadout", "XYZShit:Loadouts", function(ply)
	local jobData = RPExtraTeams[ply:Team()]

	if not jobData then return end

	local loadoutData = XYZShit.Loadouts.Deparments[jobData.category]
	if not loadoutData then return end

	if XYZShit.Loadouts.Blacklist[jobData.name] then return end

	print("[Loadout]", "Giving", ply, jobData.category, " loadout!")

	for k, v in pairs(loadoutData) do
		ply:Give(v).blockDrop = true
	end
	for k, v in pairs(XYZShit.Loadouts.All) do
		ply:Give(v).blockDrop = true
	end
end)


hook.Add("canDropWeapon", "XYZShit:Loadouts", function(ply, wep)
	if wep.blockDrop then
		return false
	end
end)

hook.Add("Inventory.CanHolster", "XYZShit:Loadouts", function(ply, wep, command)
	if ply:GetWeapon(wep) and ply:GetWeapon(wep).blockDrop then
		return false
	end
end)

hook.Add("Inventory.CanEquip", "XYZShit:Loadouts:Block", function(ply, item)
	if not XYZShit.IsGovernment(ply:Team()) then return end

	return false
end)