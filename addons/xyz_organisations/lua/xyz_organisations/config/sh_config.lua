XYZ_ORGS.Config.Color = Color(255, 0, 102)
XYZ_ORGS.Config.ChatCommands = {
	["!crew"] = true,
	["!gang"] = true,
	["!organization"] = true,
	["!organisation"] = true,
}
XYZ_ORGS.Config.Permissions = {
	-- Thanks https://gist.github.com/ThomasBurleson/0ae1e9e30d9397da7110e595d21e18e3 <3
	NONE = 0,
	ALL = bit.lshift(1, 0),

	INVITE = bit.lshift(1, 1),
	KICK = bit.lshift(1, 2),
	--BAN = bit.lshift(1, 3),
	MANAGE_UPGRADES = bit.lshift(1, 3),
	WITHDRAW  = bit.lshift(1, 4),
	DEPOSIT  = bit.lshift(1, 5),
	MANAGE_PERMISSIONS = bit.lshift(1, 6),
}
XYZ_ORGS.Config.DefaultRoles = { -- Defaults for new Orgs
	[1] = {
		["name"] = "Owner",
		["perms"] = XYZ_ORGS.Config.Permissions.ALL
	},
	[2] = {
		["name"] = "Member",
		["perms"] = XYZ_ORGS.Config.Permissions.DEPOSIT
	}
}
XYZ_ORGS.Config.DefaultAchievements = { -- Defaults for new Orgs
	["5m"] = false,
	["10m"] = false,
	["25m"] = false,
	["50m"] = false,
	["10kCash"] = false,
	["100kCash"] = false,
	["1mCash"] = false,
}

hook.Add("loadCustomDarkRPItems", "xyz_orgs_achievements", function()
	XYZ_ORGS.Config.Achievements = {
		["5m"] = {
			["name"] = "5 Members",
			["xp"] = 50,
			["check"] = function(org)
				return table.Count(org.members) >= 5
			end
		},
		["10m"] = {
			["name"] = "10 Members",
			["xp"] = 150,
			["check"] = function(org)
				return table.Count(org.members) >= 10
			end
		},
		["25m"] = {
			["name"] = "25 Members",
			["xp"] = 250,
			["check"] = function(org)
				return table.Count(org.members) >= 25
			end
		},
		["50m"] = {
			["name"] = "50 Members",
			["xp"] = 10000,
			["check"] = function(org)
				return table.Count(org.members) >= 50
			end
		},
		["10kCash"] = {
			["name"] = DarkRP.formatMoney(10000),
			["xp"] = 100,
			["check"] = function(org)
				return org.funds >= 10000
			end
		},
		["100kCash"] = {
			["name"] = DarkRP.formatMoney(100000),
			["xp"] = 500,
			["check"] = function(org)
				return org.funds >= 100000
			end
		},
		["1mCash"] = {
			["name"] = DarkRP.formatMoney(1000000),
			["xp"] = 2500,
			["check"] = function(org)
				return org.funds >= 1000000
			end
		},
	}
end)

XYZ_ORGS.Config.Upgrades = { -- Defaults for new Orgs
	balanceLimit = 500000,
	storageLimit = 15,
	memberLimit = 5,
	cinv = 0,
}

XYZ_ORGS.Config.UpgradeValues = {
	balanceLimit = {"Balance Limit", 15000, 500000}, -- {"Upgrade Name", Price of 1 increase, Increase in value, true if it can only be enabled}
	storageLimit = {"Storage Limit", 25000, 50},
	memberLimit = {"Member Limit", 15000, 5},
	cinv = {"Custom Invite", 3000000, 1, true, function(k, frame)
		XYZUI.PromptInput("Set custom invite", XYZ_ORGS.Config.Color, "This cannot be edited later, choose wisely! Min 4 chars, max 16.", function(input)
			net.Start("xyz_orgs_upgrade")
			net.WriteString(k)
			net.WriteString(input)
			net.SendToServer()
			frame:Close()
		end)
	end},
}

XYZ_ORGS.Config.CreatePrice = 500000
XYZ_ORGS.Config.JoinPrice = 1000