--- #
--- # SOD
--- #

local weps = {"xyz_syringe", "unarrest_stick", "weapon_keypadchecker", "xyz_weaponchecker", "weapon_handcuffs", "xyz_fire_axe", "xyz_extinguisher"}
local oldWeps = {}
xAdmin.Core.RegisterCommand("sod", "Set yourself on duty", 30, function(admin, args)
	if admin.isConsole then return end
	if admin.isSOD then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "You are already on duty..."}, admin)
		return
	end

	admin.isSOD = true
	admin.SODOldModel = admin:GetModel()
	admin:SetModel("models/player/crow/crow.mdl")

	oldWeps[admin:SteamID64()] = {}
	for k, v in ipairs(admin:GetWeapons()) do
		table.insert(oldWeps[admin:SteamID64()], v:GetClass())
	end

	for k, v in ipairs(weps) do
		admin:Give(v).blockDrop = true
	end

	admin:setDarkRPVar("job", "Staff On Duty")

	xAdmin.Commands["god"].func(admin, {"^"})

	xAdmin.Core.Msg({admin, " is now on duty"})
end)

--- #
--- # UNSOD
--- # 
xAdmin.Core.RegisterCommand("unsod", "Set yourself on duty", 30, function(admin, args)
	if admin.isConsole then return end
	if not admin.isSOD then
		xAdmin.Core.Msg({Color(46, 170, 200), "[xAdmin] ", Color(255, 255, 255), "You're not on duty..."}, admin)
		return
	end

	admin.isSOD = false
	local jobData = admin:getJobTable()

	admin:SetModel(admin.SODOldModel)
	admin.SODOldModel = nil

	admin:setDarkRPVar("job", jobData.name)

	if (admin:Team() == TEAM_CUSTOMCLASS) and (xStore.Users[admin:SteamID64()].activeCC) then
		local activeClass = xStore.CustomClasses[xStore.Users[admin:SteamID64()].activeCC]

		admin:setDarkRPVar("job", activeClass.name)
		admin:SetModel(activeClass.model)
	end

	for k, v in ipairs(admin:GetWeapons()) do
		if not table.HasValue(weps, v:GetClass()) then continue end
		if table.HasValue(oldWeps[admin:SteamID64()], v:GetClass()) then continue end

		admin:StripWeapon(v:GetClass())
	end

	oldWeps[admin:SteamID64()] = nil

	xAdmin.Commands["ungod"].func(admin, {"^"})

	xAdmin.Core.Msg({admin, " is no longer on duty"})
end)

hook.Add("playerCanChangeTeam", "xAdmin:SODBlock", function(ply, team, forced)
	if not ply.isSOD then return end

	return false
end)