Rewards.Config.Color = Color(40, 163, 70)

Rewards.Config.Commands = {}
Rewards.Config.Commands["!rewards"] = true
Rewards.Config.Commands["/rewards"] = true
Rewards.Config.Commands["!reward"] = true
Rewards.Config.Commands["/reward"] = true
Rewards.Config.Commands["!steam"] = true
Rewards.Config.Commands["/steam"] = true
Rewards.Config.Commands["!steamgroup"] = true
Rewards.Config.Commands["/steamgroup"] = true
Rewards.Config.Commands["!discord"] = true
Rewards.Config.Commands["/discord"] = true

Rewards.Config.Rewards = {}

Rewards.Config.Rewards["steam"] = { -- The key is the unique ID for the reward
	name = "Steam Group", -- The display name
	desc = "Join the steam group", -- The display description
	icon = "steam_logo", -- The image hotload icon name
	-- ply is the player we're checking
	-- progress is the number stored in the database, you can use this to track rewards that require multiple steps
	-- updated is the last time the entry was edited in the database
	-- callback is what you run with the arg of true/false to trigger the reward or not.
	method = function(ply, progress, updated, callback)
		if tonumber(progress) >= 1 then callback(false) return end

		http.Fetch("https://steamcommunity.com/groups/thexyznetwork/memberslistxml/?xml=1&c=%i", function(body)
			if string.find(body, "<steamID64>"..ply:SteamID64().."</steamID64>", nil, true) then
				Rewards.Database.SetProgress(ply, "steam", 1)
				return callback(true)
			else
				return callback(false)
			end
		end)
	end,
	-- ply is the player we're rewarding
	-- progress is the number stored in the database, you can use this to track rewards that require multiple steps
	-- updated is the last time the entry was edited in the database
	reward = function(ply, progress, updated)
		ply:addMoney(50000)
		ply:GiveBadge("steam")

    	XYZShit.Msg("Rewards", Rewards.Config.Color, "You have claimed the Steam Group reward, you have been given $50,000!", ply)
	end,
	fail = function() -- This is called if the use tries to claim a reward and they have not yet done the action needed. It is ran client side
		gui.OpenURL("https://steamcommunity.com/groups/thexyznetwork")
	end,
	claimed = function(ply, progress, update) -- Used for UI to show the claim button or not
		return (progress >= 1)
	end
}
Rewards.Config.Rewards["discord"] = { -- The key is the unique ID for the reward
	name = "Discord", -- The display name
	desc = "Verify in the Discord", -- The display description
	icon = "discord_logo", -- The image hotload icon name
	-- ply is the player we're checking
	-- progress is the number stored in the database, you can use this to track rewards that require multiple steps
	-- updated is the last time the entry was edited in the database
	-- callback is what you run with the arg of true/false to trigger the reward or not.
	method = function(ply, progress, updated, callback)
		if tonumber(progress) >= 1 then callback(false) return end

		XYZShit.DataBase.QueryDiscord(string.format("SELECT * FROM discord_link WHERE userid='%s'", ply:SteamID64()), function(data)
			if (not data) or (not data[1]) then 
				return callback(false)
			else
				Rewards.Database.SetProgress(ply, "discord", 1)
				return callback(true)
			end
		end)
	end,
	-- ply is the player we're rewarding
	-- progress is the number stored in the database, you can use this to track rewards that require multiple steps
	-- updated is the last time the entry was edited in the database
	reward = function(ply, progress, updated)
		ply:addMoney(50000)
    	XYZShit.Msg("Rewards", Rewards.Config.Color, "You have claimed the Discord reward, you have been given $50,000!", ply)
	end,
	fail = function() -- This is called if the use tries to claim a reward and they have not yet done the action needed. It is ran client side
		gui.OpenURL("https://discord.gg/xyz")
	end,
	claimed = function(ply, progress, update) -- Used for UI to show the claim button or not
		return (progress >= 1)
	end
}
Rewards.Config.Rewards["nitro_boost"] = { -- The key is the unique ID for the reward
	name = "Nitro Booster", -- The display name
	desc = "Boost the main Discord", -- The display description
	icon = "nitro_boost", -- The image hotload icon name
	-- ply is the player we're checking
	-- progress is the number stored in the database, you can use this to track rewards that require multiple steps
	-- updated is the last time the entry was edited in the database
	-- callback is what you run with the arg of true/false to trigger the reward or not.
	method = function(ply, progress, updated, callback)
		if progress >= 1628583559 then return callback(false) end

		XYZShit.DataBase.QueryDiscord(string.format("SELECT * FROM discord_booster WHERE userid='%s'", ply:SteamID64()), function(data)
			if (not data) or (not data[1]) then 
				return callback(false)
			else
				Rewards.Database.SetProgress(ply, "nitro_boost", os.time())
				return callback(true)
			end
		end)
	end,
	-- ply is the player we're rewarding
	-- progress is the number stored in the database, you can use this to track rewards that require multiple steps
	-- updated is the last time the entry was edited in the database
	reward = function(ply, progress, updated)
		-- Car Dealer item
		CarDealer.Core.Give(ply, "mclaren_mp4x")

		-- End Car Dealer item

		-- xStore item
--		local item = xStore.Config.Items["weapon_weapon_lego_saber"]
--	
--		xStore.Database.GiveUserItem(ply:SteamID64(), item.id, 0)
--		table.insert(xStore.Users[ply:SteamID64()].items, {item = item.id, paid = 0, active = true, created = os.time()})
--	
--		if item.instantAction then
--			item.instantAction(ply)
--		end
		-- End xStore item

		ply:GiveBadge("nitroboost")

    	XYZShit.Msg("Rewards", Rewards.Config.Color, "You have claimed the Nitro Booster reward, you have been given a vehicle and a booster badge!", ply)
	end,
	fail = function() -- This is called if the use tries to claim a reward and they have not yet done the action needed. It is ran client side
		gui.OpenURL("https://discord.gg/xyz")
	end,
	claimed = function(ply, progress, update) -- Used for UI to show the claim button or not
		return (progress >= 1628583559)
	end
}
Rewards.Config.Rewards["join_police"] = { -- The key is the unique ID for the reward
	name = "Police Force", -- The display name
	desc = "Join the police force", -- The display description
	icon = "police_force", -- The image hotload icon name
	-- ply is the player we're checking
	-- progress is the number stored in the database, you can use this to track rewards that require multiple steps
	-- updated is the last time the entry was edited in the database
	-- callback is what you run with the arg of true/false to trigger the reward or not.
	method = function(ply, progress, updated, callback)
		if tonumber(progress) >= 1 then callback(false) return end

		if xWhitelist.Users[ply:SteamID64()].whitelist["policeofficer"] then
			Rewards.Database.SetProgress(ply, "join_police", 1)
			return callback(true)
		else
			return callback(false)
		end
	end,
	-- ply is the player we're rewarding
	-- progress is the number stored in the database, you can use this to track rewards that require multiple steps
	-- updated is the last time the entry was edited in the database
	reward = function(ply, progress, updated)
		ply:addMoney(25000)
    	XYZShit.Msg("Rewards", Rewards.Config.Color, "You have claimed the Police Force reward, you have been given $25,000!", ply)
	end,
	fail = function() -- This is called if the use tries to claim a reward and they have not yet done the action needed. It is ran client side
		XYZShit.Msg("Rewards", Rewards.Config.Color, "Take the exam at the NPC!")
	end,
	claimed = function(ply, progress, update) -- Used for UI to show the claim button or not
		return (progress >= 1)
	end
}
Rewards.Config.Rewards["xsuite_signup"] = { -- The key is the unique ID for the reward
	name = "Join Website", -- The display name
	desc = "Sign up to the website", -- The display description
	-- ply is the player we're checking
	-- progress is the number stored in the database, you can use this to track rewards that require multiple steps
	-- updated is the last time the entry was edited in the database
	-- callback is what you run with the arg of true/false to trigger the reward or not.
	method = function(ply, progress, updated, callback)
		if tonumber(progress) >= 1 then return callback(false) end

		XYZShit.DataBase.QueryDiscord(string.format("SELECT * FROM users WHERE userid='%s'", ply:SteamID64()), function(data)
			if (not data) or (not data[1]) then 
				return callback(false)
			else
				Rewards.Database.SetProgress(ply, "xsuite_signup", 1)
				return callback(true)
			end
		end)
	end,
		-- ply is the player we're rewarding
	-- progress is the number stored in the database, you can use this to track rewards that require multiple steps
	-- updated is the last time the entry was edited in the database
	reward = function(ply, progress, updated)
		ply:addMoney(50000)
    	XYZShit.Msg("Rewards", Rewards.Config.Color, "You have claimed the Website Signup reward, you have been given $50,000!", ply)
	end,
	fail = function() -- This is called if the use tries to claim a reward and they have not yet done the action needed. It is ran client side
		gui.OpenURL("https://thexyznetwork.xyz/")
	end,
	claimed = function(ply, progress, update) -- Used for UI to show the claim button or not
		return (progress >= 1)
	end
}

-- Rewards.Config.Rewards["easter_2021"] = { -- The key is the unique ID for the reward
-- 	name = "Easter 2021", -- The display name
-- 	desc = "Thanks for playing!", -- The display description
-- 	icon = "easter_2021", -- The image hotload icon name
-- 	-- ply is the player we're checking
-- 	-- progress is the number stored in the database, you can use this to track rewards that require multiple steps
-- 	-- updated is the last time the entry was edited in the database
-- 	-- callback is what you run with the arg of true/false to trigger the reward or not.
-- 	method = function(ply, progress, updated, callback)
-- 		if tonumber(progress) >= 1 then callback(false) return end

-- 		Rewards.Database.SetProgress(ply, "easter_2021", 1)
-- 		return callback(true)
-- 	end,
-- 	-- ply is the player we're rewarding
-- 	-- progress is the number stored in the database, you can use this to track rewards that require multiple steps
-- 	-- updated is the last time the entry was edited in the database
-- 	reward = function(ply, progress, updated)
-- 		ply:GiveBadge("easter2021")
--    	XYZShit.Msg("Rewards", Rewards.Config.Color, "You have been given the Easter 2021 badge!", ply)
-- 	end,
-- 	fail = function() -- This is called if the use tries to claim a reward and they have not yet done the action needed. It is ran client side
-- 		return
-- 	end,
-- 	claimed = function(ply, progress, update) -- Used for UI to show the claim button or not
-- 		if progress >= 1 then return true end

-- 		return false
-- 	end
-- }


-- Daily rewards go brrr
-- Calculating the rewards
local dailyRewards = {}
local dailyRewardsPool = {}
local function addReward(item, chance, priority, func)
	dailyRewards[item] = {f = func, p = priority}

	for i=1, chance do
		table.insert(dailyRewardsPool, item)
	end
end

addReward("nothing", 30, 1, function(ply)
	return "Nothing"
end)
addReward("10000", 30, 2, function(ply)
	ply:addMoney(10000)
	return "$10,000"
end)
addReward("50000", 20, 3, function(ply)
	ply:addMoney(50000)
	return "$50,000"
end)
addReward("100000", 10, 4, function(ply)
	ply:addMoney(100000)
	return "$100,000"
end)

addReward("xyz_medkit", 6, 4, function(ply)
	local itemData = {
		type = {
			isWeapon = false,
			isShipment = false
		},
		info = {
			displayName = "Medkit",
			displayModel = "models/freeman/owain_medkit.mdl",
			class = "xyz_medkit"
		},
		data = {
			sID = 26,
			dataTable = {
				FirstSpawn = true,
				UsesLeft = 5
			},
			skin = 0,
			renderGroup = 9
		}
	}

	if table.Count(Inventory.SavedInvs[ply:SteamID64()]) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
        XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
        return "Medkit"
    end

	Inventory.Core.GiveItem(ply:SteamID64(), "xyz_medkit", itemData)

	return "Medkit"
end)
addReward("xyz_medkitx5", 3, 5, function(ply)
	local itemData = {
		type = {
			isWeapon = false,
			isShipment = false
		},
		info = {
			displayName = "Medkit",
			displayModel = "models/freeman/owain_medkit.mdl",
			class = "xyz_medkit"
		},
		data = {
			sID = 26,
			dataTable = {
				FirstSpawn = true,
				UsesLeft = 5
			},
			skin = 0,
			renderGroup = 9
		}
	}

	if table.Count(Inventory.SavedInvs[ply:SteamID64()]) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
        XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
        return "Medkit x5"
    end

	for i=1, 5 do
		Inventory.Core.GiveItem(ply:SteamID64(), "xyz_medkit", itemData)
	end
	return "Medkit x5"
end)
addReward("xyz_armour_box", 6, 4, function(ply)
	local itemData = {
		type = {
			isWeapon = false,
			isShipment = false
		},
		info = {
			displayName = "Armour Box",
			displayModel = "models/freeman/owain_hardigg_armour.mdl",
			class = "xyz_armour_box"
		},
		data = {
			sID = 343,
			dataTable = {
				FirstSpawn = true,
				UsesLeft = 10
			},
			skin = 0,
			renderGroup = 9
		}
	}

	if table.Count(Inventory.SavedInvs[ply:SteamID64()]) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
        XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
        return "Armour Box"
    end

	Inventory.Core.GiveItem(ply:SteamID64(), "xyz_armour_box", itemData)
	return "Armour Box"
end)
addReward("xyz_armour_boxx5", 3, 5, function(ply)
	local itemData = {
		type = {
			isWeapon = false,
			isShipment = false
		},
		info = {
			displayName = "Armour Box",
			displayModel = "models/freeman/owain_hardigg_armour.mdl",
			class = "xyz_armour_box"
		},
		data = {
			sID = 343,
			dataTable = {
				FirstSpawn = true,
				UsesLeft = 10
			},
			skin = 0,
			renderGroup = 9
		}
	}

	if table.Count(Inventory.SavedInvs[ply:SteamID64()]) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
        XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
        return "Armour Box x5"
    end

	for i=1, 5 do
		Inventory.Core.GiveItem(ply:SteamID64(), "xyz_armour_box", itemData)
	end
	return "Armour Box x5"
end)

addReward("free_pcasino_spin", 5, 4, function(ply)
	PerfectCasino.Core.GiveFreeSpin(ply)
	return "Free Casino Mystery Wheel Spin"
end)

addReward("cw_m3super90", 4, 4, function(ply)
	local wepData = {
		type = {
			isWeapon = true,
			isShipment = false
		},
		info = {
			displayName = "cw_m3super90",
			displayModel = "models/weapons/w_cstm_m3super90.mdl",
			class = "cw_m3super90"
		},
		data = {}
	}

	if table.Count(Inventory.SavedInvs[ply:SteamID64()]) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
        XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
        return "M3 Super 90"
    end

	Inventory.Core.GiveItem(ply:SteamID64(), "cw_m3super90", wepData)

	return "M3 Super 90"
end)
addReward("cw_g36c", 4, 4, function(ply)
	local wepData = {
		type = {
			isWeapon = true,
			isShipment = false
		},
		info = {
			displayName = "cw_g36c",
			displayModel = "models/weapons/cw20_g36c.mdl",
			class = "cw_g36c"
		},
		data = {}
	}

	if table.Count(Inventory.SavedInvs[ply:SteamID64()]) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
        XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
        return "H&K G36C"
    end

	Inventory.Core.GiveItem(ply:SteamID64(), "cw_g36c", wepData)

	return "H&K G36C"
end)
addReward("cw_m14", 4, 4, function(ply)
	local wepData = {
		type = {
			isWeapon = true,
			isShipment = false
		},
		info = {
			displayName = "cw_m14",
			displayModel = "models/weapons/w_cstm_m14.mdl",
			class = "cw_m14"
		},
		data = {}
	}

	if table.Count(Inventory.SavedInvs[ply:SteamID64()]) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
        XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
        return "M14 EBR"
    end

	Inventory.Core.GiveItem(ply:SteamID64(), "cw_m14", wepData)

	return "M14 EBR"
end)

addReward("khr_fnfal", 3, 4, function(ply)
	local wepData = {
		type = {
			isWeapon = true,
			isShipment = false
		},
		info = {
			displayName = "khr_fnfal",
			displayModel = "models/weapons/w_rif_ak47.mdl",
			class = "khr_fnfal"
		},
		data = {}
	}

	if table.Count(Inventory.SavedInvs[ply:SteamID64()]) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
        XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
        return "FN FAL"
    end

	Inventory.Core.GiveItem(ply:SteamID64(), "khr_fnfal", wepData)

	return "FN FAL"
end)

addReward("khr_m95", 3, 4, function(ply)
	local wepData = {
		type = {
			isWeapon = true,
			isShipment = false
		},
		info = {
			displayName = "khr_m95",
			displayModel = "models/khrcw2/w_snip_m95.mdl",
			class = "khr_m95"
		},
		data = {}
	}

	if table.Count(Inventory.SavedInvs[ply:SteamID64()]) >= (Inventory.Config.MaxSpace[ply:GetUserGroup()] or Inventory.Config.MaxSpace['default']) then
        XYZShit.Msg("Inventory", Color(2, 108, 254), "Your inventory is full!", ply)
        return "M95"
    end

	Inventory.Core.GiveItem(ply:SteamID64(), "khr_m95", wepData)

	return "M95"
end)

addReward("15camaro_sgm", 1, 6, function(ply)
	CarDealer.Core.Give(ply, "15camaro_sgm")
	
	return "2015 Chevrolet Camaro SS"
end)

Rewards.Config.Rewards["daily"] = { -- The key is the unique ID for the reward
	name = "Daily Reward", -- The display name
	desc = "A random reward every day", -- The display description
	-- ply is the player we're checking
	-- progress is the number stored in the database, you can use this to track rewards that require multiple steps
	-- updated is the last time the entry was edited in the database
	-- callback is what you run with the arg of true/false to trigger the reward or not.
	method = function(ply, progress, updated, callback)
		local today = os.date("%Y-%m-%d", os.time())
		local lastClaimed = os.date("%Y-%m-%d", updated)
		today = string.Split(today, "-")
		lastClaimed = string.Split(lastClaimed, "-")

		-- Using it on the same month and day
		if (tonumber(today[3]) == tonumber(lastClaimed[3])) and (tonumber(today[2]) == tonumber(lastClaimed[2])) then
			return callback(false)
		end

		if updated < (os.time()-60*60*24) then
			Rewards.Database.SetProgress(ply, "daily", 1)
		else
			Rewards.Database.SetProgress(ply, "daily", tonumber(progress) + 1)
		end

		return callback(true)
	end,
	-- ply is the player we're rewarding
	-- progress is the number stored in the database, you can use this to track rewards that require multiple steps
	-- updated is the last time the entry was edited in the database
	reward = function(ply, progress, updated)
		local bestItem
		for i=1, (tonumber(progress)+1)%30 do
			local randomItem = table.Random(dailyRewardsPool)
			if not bestItem then
				bestItem = randomItem
			elseif dailyRewards[randomItem].p >= dailyRewards[bestItem].p then
				bestItem = randomItem
			end
		end

		local rewardText = dailyRewards[bestItem].f(ply)

    	XYZShit.Msg("Rewards", Rewards.Config.Color, "You have claimed todays reward, the reward is "..rewardText.."!", ply)
	end,
	fail = function() -- This is called if the use tries to claim a reward and they have not yet done the action needed. It is ran client side
    	XYZShit.Msg("Rewards", Rewards.Config.Color, "You have already claimed todays reward!", ply)
	end,
	claimed = function(ply, progress, updated) -- Used for UI to show the claim button or not
		local today = os.date("%Y-%m-%d", os.time())
		local lastClaimed = os.date("%Y-%m-%d", updated)
		today = string.Split(today, "-")
		lastClaimed = string.Split(lastClaimed, "-")

		-- Using it on the same month and day
		if (tonumber(today[3]) == tonumber(lastClaimed[3])) and (tonumber(today[2]) == tonumber(lastClaimed[2])) then
			return true
		end

		return false
	end
}
