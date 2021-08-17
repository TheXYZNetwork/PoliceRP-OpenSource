xStore.Config.Items = xStore.Config.Items or {}

--[[
	-|- The key should be the same as id -|-
	id: The identification name
	name: The display name
	(optional) desc: A description of the item with FULL html/css support. This will be overwridden with model/image if either of those are set.
	(optional) model: A model used as a display
	(optional) image: An image used as a display
	(optional) category: The category it's listed under
	price: The price in credits. Can be a function returning a value. If it is a function, it will have 1 argument. That being the purchaser's object (a player)
	(optional) sale: Used to start a sale on an item. This value should be the % that is TAKEN OFF the base price. For example, if sale is 0.1, then it has a 10% off value. 0.01 = 1%, 0.5 = 50%, 1 = 100%, ect...

	(optional) canPurchase: A custom check to allow the item to be purchased. Return true/false. This function has 1 argument. That being the purchaser's object (a player)
	(optional) canSee: A custom check on if the item should be shown as buyable (If returned false, this will also block purchasing). Return true/false. This function has 1 argument. That being the purchaser's object (a player)

	(optional) instantAction: Called as soon as the item is purchased. This function has 1 argument. That being the purchaser's object (a player)
	(optional) everyRepawnAction: Called every time the user respawns (PlayerSpawn). This function has 1 argument. That being the purchaser's object (a player)
	(optional) everyLoadInAction`: Called every time the user loads into the server (PlayerInitialSpawn). This function has 1 argument. That being the purchaser's object (a player)

	(optional) dermaOverride: Used to override the derma card for this item. This function has 1 argument. That being the card in the store (a derma)

	(optional) legacy: Set this to true to disable being able to buy this item.
	(optional) disabable: Can the purchaser disable the item? (Mainly used for things like knives/weapons)
]]

---- Testing coded
--for i=2, 40 do
--	xStore.Config.Items['example_package_'..i] = {
--		id = "example_package_"..i,
--		name = "Example Package "..i,
--		desc = [[A package used for testing
--- This is a list of items
--- We're adding more to the list :D
--- And even more?? o.0
--
--This concludes my TEDx talk, thanks for listening guys!]],
--		model = table.Random({"models/weapons/w_pist_fiveseven.mdl", "models/weapons/w_rif_m4a1_silencer.mdl", false}),
--		category = table.Random({"Examples", "Examples 2", "Boop"}),
--		price = 100,
--		instantAction = function(ply)
--			print("Called as soon as purchased", os.time())
--		end,
--		everyRepawnAction = function(ply)
--			print("Called every time the user respawns (PlayerSpawn)", os.time())
--		end,
--		everyLoadInAction = function(ply)
--			print("Called every time the user loads in (PlayerInitialSpawn)", os.time())
--		end,
--		disabable = true
--	}
--end



xStore.Config.Featured = {}
xStore.Config.Featured[1] = "wos_fn_infinidab_emote"
xStore.Config.Featured[2] = "weapon_xyz_spraycan"
xStore.Config.Featured[3] = "wos_fn_takethel_emote"

xStore.Config.Commands = {}
xStore.Config.Commands["!store"] = true
xStore.Config.Commands["/store"] = true
xStore.Config.Commands["!xstore"] = true
xStore.Config.Commands["/xstore"] = true
xStore.Config.Commands["!donate"] = true
xStore.Config.Commands["/donate"] = true
xStore.Config.Commands["!credits"] = true
xStore.Config.Commands["/credits"] = true


local wepSciFi = {}
wepSciFi["ak47_beast"] = true
wepSciFi["g36_balrog"] = true
wepSciFi["mac_lara"] = true
wepSciFi["m4a1_beast"] = true
wepSciFi["47_ethereal"] = true
wepSciFi["tmp_dragon"] = true

local function loadItems()
	for k, v in pairs(weapons.GetList()) do
		-- CSGO Knives
		if v.Category == "CS:GO Knives" and not (v.ClassName == "csgo_baseknife") then
			xStore.Config.Items[v.ClassName.."_knife"] = {
				id = v.ClassName.."_knife",
				name = v.PrintName,
				model = v.WorldModel,
				category = "Permanent CSGO Knives",
				price = 95,
	
				canPurchase = function(ply, ownedItems)
					if ownedItems[v.ClassName.."_knife"] then return false end
					return true
				end,
				canSee = function(ply, ownedItems)
					return true
				end,
	
				instantAction = function(ply)
					if ply:XYZIsArrested() then return end
					ply:Give(v.ClassName).xStore = true
				end,
				everyRepawnAction = function(ply)
					ply:Give(v.ClassName).xStore = true
				end,
				everyLoadInAction = function(ply)
					ply:Give(v.ClassName).xStore = true
				end,
	
				disabable = true
			}
		-- Handy Pack

			local emotes = {
				buyable = {
					"wos_fn_infinidab",
					"wos_fn_boneless",
					"wos_fn_discofever",
					"wos_fn_floss",
					"wos_fn_fresh",
					"taunt_laugh",
					"wos_fn_takethel",
					"sit_zen",
					"wos_fn_hype"
				},
				other = {
					"wos_fn_bestmates",
					"pose_standing_01",
					"pose_standing_02",
					"taunt_robot",
					"gesture_bow",
					"death_04"
				}
			}
			for k, v in pairs(emotes) do
				for n, m in ipairs(v) do
					local emoteData = Emote.Config.Animations[m]
					xStore.Config.Items[emoteData.id.."_emote"] = {
						id = emoteData.id.."_emote",
						name = emoteData.name,
						desc = "<p style='text-align: center;'>This is a permanent emote, express yourself!</p>",
						category = "Emote",
						price = 110,
			
						canPurchase = function(ply, ownedItems)
							if ownedItems[emoteData.id.."_emote"] then return false end
							return (k == "buyable")
						end,
						canSee = function(ply, ownedItems)
							return (k == "buyable")
						end,
			
						instantAction = function(ply)
							Emote.Core.GiveAnimation(ply, m)
						end,
						everyRepawnAction = function(ply)
						end,
						everyLoadInAction = function(ply)
							Emote.Core.GiveAnimation(ply, m)
						end,
			
						disabable = true
					}	
				end
			end
		end
	end
	-- Sci-Fi Weapons
	local scifiWeps = {
		{oClass = "47_ethereal", nClass = "cw_sci-fi_47_ethereal"},
		{oClass = "ak47_beast", nClass = "cw_sci-fi_ak47_beast"},
		{oClass = "g36_balrog", nClass = "cw_sci-fi_g36_balrog"},
		{oClass = "m4a1_beast", nClass = "cw_sci-fi_m4a1_transformer"},
		{oClass = "mac_lara", nClass = "cw_sci-fi_mac_lara"},
		{oClass = "scout_xbow", nClass = "cw_sci-fi_scout_xbow", nitro = true},
		{oClass = "tmp_dragon", nClass = "cw_sci-fi_tmp_dragon"}
	}
	for k, v in pairs(scifiWeps) do
		xStore.Config.Items[v.oClass.."_sci-fi"] = {
			id = v.oClass.."_sci-fi",
			name = weapons.Get(v.nClass).PrintName,
			model = weapons.Get(v.nClass).WorldModel,
			category = "Permanent Sci-Fi Weapons",
			price = 250,
		
			canPurchase = function(ply, ownedItems)
				if v.nitro then return false end
				if ownedItems[v.oClass.."_sci-fi"] then return false end
				return true
			end,
			canSee = function(ply, ownedItems)
				if v.nitro then return false end
				return true
			end,
		
			instantAction = function(ply)
				if ply:XYZIsArrested() then return end
				ply:Give(v.nClass).xStore = true
			end,
			everyRepawnAction = function(ply)
				ply:Give(v.nClass).xStore = true
			end,
			everyLoadInAction = function(ply)
				ply:Give(v.nClass).xStore = true
			end,
		
			disabable = true
		}
	end
	-- Bug Bait
	xStore.Config.Items["weapon_bugbait_perma"] = {
		id = "weapon_bugbait_perma",
		name = "Bug Bait",
		desc = "<p style='text-align: center;'>Throw a ball of meat at anyone you pass.</p>",
		category = "Permanent SWEPs/Weapons",
		price = 110,
	
		canPurchase = function(ply, ownedItems)
			if ownedItems["weapon_bugbait_perma"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return true
		end,
	
		instantAction = function(ply)
			if ply:XYZIsArrested() then return end
			ply:Give("weapon_bugbait").xStore = true
		end,
		everyRepawnAction = function(ply)
			ply:Give("weapon_bugbait").xStore = true
		end,
		everyLoadInAction = function(ply)
			ply:Give("weapon_bugbait").xStore = true
		end,
	
		disabable = true
	}
	
	-- M249
	xStore.Config.Items["cw_m249_official_perma"] = {
		id = "cw_m249_official_perma",
		name = "CW:2 M249",
		model = "models/weapons/cw2_0_mach_para.mdl",
		category = "Permanent SWEPs/Weapons",
		price = 250,
	
		canPurchase = function(ply, ownedItems)
			if ownedItems["cw_m249_official_perma"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return true
		end,
	
		instantAction = function(ply)
			if ply:XYZIsArrested() then return end
			ply:Give("cw_m249_official").xStore = true
		end,
		everyRepawnAction = function(ply)
			ply:Give("cw_m249_official").xStore = true
		end,
		everyLoadInAction = function(ply)
			ply:Give("cw_m249_official").xStore = true
		end,
	
		disabable = true
	}
	-- Fists
	xStore.Config.Items["weapon_fists_perma"] = {
		id = "weapon_fists_perma",
		name = "Fists",
		desc = "<p style='text-align: center;'>Throw hands with anyone who wants to catch them or maybe just beat up your local homeless man.</p>",
		category = "Permanent SWEPs/Weapons",
		price = 110,
	
		canPurchase = function(ply, ownedItems)
			if ownedItems["weapon_fists_perma"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return true
		end,
	
		instantAction = function(ply)
			if ply:XYZIsArrested() then return end
			ply:Give("weapon_fists").xStore = true
		end,
		everyRepawnAction = function(ply)
			ply:Give("weapon_fists").xStore = true
		end,
		everyLoadInAction = function(ply)
			ply:Give("weapon_fists").xStore = true
		end,
	
		disabable = true
	}
	
	-- Grappling hook
	xStore.Config.Items["weapon_grappling_hook"] = {
		id = "weapon_grappling_hook",
		name = "Grappling Hook",
		model = "models/weapons/w_crossbow.mdl",
		category = "Permanent SWEPs/Weapons",
		price = 350,
	
		canPurchase = function(ply, ownedItems)
			if ownedItems["weapon_grappling_hook"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return true
		end,
	
		instantAction = function(ply)
			if ply:XYZIsArrested() then return end
			ply:Give("weapon_grapplehook").xStore = true
		end,
		everyRepawnAction = function(ply)
			ply:Give("weapon_grapplehook").xStore = true
		end,
		everyLoadInAction = function(ply)
			ply:Give("weapon_grapplehook").xStore = true
		end,
	
		disabable = true
	}
	
	-- Grappling hook
	xStore.Config.Items["weapon_xyz_spraycan"] = {
		id = "weapon_xyz_spraycan",
		name = "Spray Can",
		model = "models/unconid/spray_can/spray_can.mdl",
		category = "Permanent SWEPs/Weapons",
		price = 250,
	
		canPurchase = function(ply, ownedItems)
			if ownedItems["weapon_xyz_spraycan"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return true
		end,
	
		instantAction = function(ply)
			if ply:XYZIsArrested() then return end
			ply:Give("xyz_spraycan").xStore = true
		end,
		everyRepawnAction = function(ply)
			ply:Give("xyz_spraycan").xStore = true
		end,
		everyLoadInAction = function(ply)
			ply:Give("xyz_spraycan").xStore = true
		end,
	
		disabable = true
	}
	
	
	-- Raid kit
	xStore.Config.Items["weapon_raid_kit"] = {
		id = "weapon_raid_kit",
		name = "Raid Kit",
		desc = [[<p style='text-align: center;'>
	<b style="font-color: red;">!!Government jobs will not spawn with these items!!</b><br>
	Includes the following permanent weapons:<br>
	- Pro Lockpick<br>
	- Pro Keypad Cracker
	</p>]],
		category = "Permanent SWEPs/Weapons",
		price = 250,
	
		canPurchase = function(ply, ownedItems)
			if ownedItems["weapon_raid_kit"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return true
		end,
	
		instantAction = function(ply)
			if XYZShit.IsGovernment(ply:Team(), true) then return end
			if ply:XYZIsArrested() then return end
			ply:Give("pro_lockpick_update").xStore = true
			ply:Give("prokeypadcracker").xStore = true
		end,
		everyRepawnAction = function(ply)
			if XYZShit.IsGovernment(ply:Team(), true) then return end
			ply:Give("pro_lockpick_update").xStore = true
			ply:Give("prokeypadcracker").xStore = true
		end,
		everyLoadInAction = function(ply)
			if XYZShit.IsGovernment(ply:Team(), true) then return end
			ply:Give("pro_lockpick_update").xStore = true
			ply:Give("prokeypadcracker").xStore = true
		end,
	
		disabable = true
	}
	
	
	-- Lua system
	xStore.Config.Items["rainbow_physgun_code"] = {
		id = "rainbow_physgun_code",
		name = "Rainbow Physgun",
		desc = "<p style='text-align: center;'>Flex your <span style='color: #ff0000;'>r</span><span style='color: #ff6600;'>a</span><span style='color: #ffff00;'>i</span><span style='color: #339966;'>n</span><span style='color: #00ff00;'>b</span><span style='color: #33cccc;'>o</span><span style='color: #3366ff;'>w</span> phys gun on everyone!</p>",
		price = 250,
	
		canPurchase = function(ply, ownedItems)
			if ownedItems["rainbow_physgun_code"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return true
		end,
	
		instantAction = function(ply)
			ply:SetNWBool("XYZRainbowPhysGun", true)
		end,
		everyLoadInAction = function(ply)
			ply:SetNWBool("XYZRainbowPhysGun", true)
		end
	}
	
	
	local ammoTypes = {".380 ACP", "4.6x30mm", "9x17MM", "9x18MM", "9x19MM", "9x21MM", "9x39MM", "40MM", "5.7x28MM", ".44 Magnum", ".45 ACP", ".45 Auto ACP", ".50 AE", "12 Gauge", ".338 Lapua", "5.45x39MM", "7.62x51MM", "5.56x45MM", "SMG1", "pistol", "357", "7.62x54mmR", "SniperPenetratedRound", ".22LR", ".32 ACP", ".50 BMG", ".416 Barrett"}
	xStore.Config.Items["inf_ammo_code"] = {
		id = "inf_ammo_code",
		name = "Infinite Ammo",
		desc = "<p style='text-align: center;'>Not actually infinite, but close enough.</p>",
		price = 250,
	
		canPurchase = function(ply, ownedItems)
			if ownedItems["inf_ammo_code"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return true
		end,
	
		instantAction = function(ply)
			for k, v in pairs(ammoTypes) do
				ply:GiveAmmo(9999, v)
			end
		end,
		everyRepawnAction = function(ply)
			for k, v in pairs(ammoTypes) do
				ply:GiveAmmo(9999, v)
			end
		end,
		everyLoadInAction = function(ply)
			for k, v in pairs(ammoTypes) do
				ply:GiveAmmo(9999, v)
			end
		end
	}
	
	xStore.Config.Items["100_armor_code"] = {
		id = "100_armor_code",
		name = "100% Armor",
		desc = "<p style='text-align: center;'>Spawn with 100% armor every time!<br>Works on all jobs.</p>",
		price = 250,
	
		canPurchase = function(ply, ownedItems)
			if ownedItems["100_armor_code"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return true
		end,
	
		instantAction = function(ply)
			ply:SetArmor(100)
		end,
		everyRepawnAction = function(ply)
			ply:SetArmor(100)
		end,
		everyLoadInAction = function(ply)
			ply:SetArmor(100)
		end
	}
	
	-- Ranks
	xStore.Config.Items["vip_rank"] = {
		id = "vip_rank",
		name = "VIP",
		desc = [[<p style='text-align: center;'>
	<b>This rank is permanent</b><br>
	- VIP Rank in-game<br>
	- VIP Rank on discord<br>
	- $250,000 in-game money<br>
	- Access to VIP jobs<br>
	- Access to VIP cars<br>
	- Access to VIP printer tiers<br>
	- Access to Advance Dupe 2<br>
	- 30 prop limit<br>
	- And more...
	</p>]],
		category = "Ranks",
		price = 500,
	
		canPurchase = function(ply, ownedItems)
			if ownedItems["vip_rank"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return ply:GetUserGroup() == "user"
		end,
	
		instantAction = function(ply)
			ply:SetUserGroup("vip")
			xAdmin.Users[ply:SteamID64()] = "vip"
			net.Start("xAdminNetworkIDRank")
				net.WriteString(ply:SteamID64())
				net.WriteString(xAdmin.Users[ply:SteamID64()])
			net.Broadcast()
			xAdmin.Database.UpdateUsersGroup(ply:SteamID64(), "vip")

			ply:addMoney(250000)
		end
	}
	
	xStore.Config.Items["elite_rank"] = {
		id = "elite_rank",
		name = "Elite",
		desc = [[<p style='text-align: center;'>
	<b>This rank is permanent</b><br>
	- With this rank, you get access to all VIP perks + everything below.<br>
	- Elite Rank in-game<br>
	- Elite Rank on discord<br>
	- $600,000 in-game money<br>
	- Access to Elite jobs<br>
	- Access to Elite cars<br>
	- Access to Elite printer tiers<br>
	- 40 prop limit<br>
	- And much more...
	</p>]],
		category = "Ranks",
		price = 1000,
	
		canPurchase = function(ply, ownedItems)
			if ownedItems["vip_rank"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return ply:GetUserGroup() == "user"
		end,
	
		instantAction = function(ply)
			ply:SetUserGroup("elite")
			xAdmin.Users[ply:SteamID64()] = "elite"
			net.Start("xAdminNetworkIDRank")
				net.WriteString(ply:SteamID64())
				net.WriteString(xAdmin.Users[ply:SteamID64()])
			net.Broadcast()
			xAdmin.Database.UpdateUsersGroup(ply:SteamID64(), "elite")
			
			ply:addMoney(600000 + 250000)
		end
	}
	xStore.Config.Items["elite_upgrade_rank"] = {
		id = "elite_upgrade_rank",
		name = "Elite VIP Upgrade",
		desc = [[<p style='text-align: center;'>
	<b>This rank is permanent</b><br>
	- With this rank, you get access to all VIP perks + everything below.<br>
	- Elite Rank in-game<br>
	- Elite Rank on discord<br>
	- $600,000 in-game money<br>
	- Access to Elite jobs<br>
	- Access to Elite cars<br>
	- Access to Elite printer tiers<br>
	- 40 prop limit<br>
	- And much more...
	</p>]],
		category = "Ranks",
		price = 500,
	
		canPurchase = function(ply, ownedItems)
			if not ownedItems["vip_rank"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return ply:GetUserGroup() == "vip"
		end,
	
		instantAction = function(ply)
			ply:SetUserGroup("elite")
			xAdmin.Users[ply:SteamID64()] = "elite"
			net.Start("xAdminNetworkIDRank")
				net.WriteString(ply:SteamID64())
				net.WriteString(xAdmin.Users[ply:SteamID64()])
			net.Broadcast()
			xAdmin.Database.UpdateUsersGroup(ply:SteamID64(), "elite")

			ply:addMoney(600000)
		end
	}
	
	xStore.Config.Items["chat_tag_code"] = {
		id = "chat_tag_code",
		name = "In-game Chat Tag",
		desc = [[<p style='text-align: center;'>
	<b>You can only have one chat tag!</b><br>
	Get a cool custom prefix tag on your name in-game. After purchasing this package type !tag and you can access all the cool customization features of your tag!
	</p>]],
		price = 175,
	
		canPurchase = function(ply, ownedItems)
			if ownedItems["chat_tag_code"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return true
		end,
	
		instantAction = function(ply)
			XYZ_TAG[ply:SteamID64()] = true
		end,
		everyLoadInAction = function(ply)
			XYZ_TAG[ply:SteamID64()] = true
		end
	}
	
	local randomWeps = {"cw_ak74", "cw_ar15", "cw_fiveseven", "cw_scarh", "cw_g3a3", "cw_g18", "cw_g36c", "cw_ump45", "cw_mp5", "cw_deagle", "cw_l115", "cw_l85a2", "cw_m14", "cw_m1911", "cw_m3super90", "cw_mac11", "cw_mr96", "cw_p99", "cw_makarov", "cw_shorty", "cw_silverballer", "cw_sv98", "cw_vss"}
	xStore.Config.Items["weapon_random_on_spawn"] = {
		id = "weapon_random_on_spawn",
		name = "Random Weapon on Spawn",
		desc = [[<p style='text-align: center;'>
		Start with a random weapon every respawn.
		</p>]],
		price = 250,
	
		canPurchase = function(ply, ownedItems)
			if ownedItems["weapon_random_on_spawn"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return true
		end,
	
		instantAction = function(ply)
			if ply:XYZIsArrested() then return end
			ply:Give(table.Random(randomWeps)).xStore = true
		end,
		everyRepawnAction = function(ply)
			ply:Give(table.Random(randomWeps)).xStore = true
		end,
		everyLoadInAction = function(ply)
			ply:Give(table.Random(randomWeps)).xStore = true
		end,
	
		disabable = true
	}
	
	xStore.Config.Items["vehicle_atv_buggy"] = {
		id = "vehicle_atv_buggy",
		name = "ATV Buggy",
		model = "models/freeman/vehicles/atv.mdl",
		price = 380,
		category = "Vehicles",
	
		canPurchase = function(ply, ownedItems)
			if ownedItems["vehicle_atv_buggy"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return true
		end,
	
		instantAction = function(ply)
			CarDealer.Core.Give(ply, "atv_buggy")
		end
	}

	xStore.Config.Items["vehicle_go_kart"] = {
		id = "vehicle_go_kart",
		name = "Go-Kart",
		model = "models/freeman/vehicles/electric_go-kart.mdl",
		price = 380,
		category = "Vehicles",
	
		canPurchase = function(ply, ownedItems)
			if ownedItems["vehicle_go_kart"] then return false end
			return true
		end,
		canSee = function(ply, ownedItems)
			return true
		end,
	
		instantAction = function(ply)
			CarDealer.Core.Give(ply, "electric_gokart")
		end
	}
	-- Nitro items
	xStore.Config.Items["weapon_chainsaw_new_perma"] = {
		id = "weapon_chainsaw_new_perma",
		name = "Chainsaw",
		model = "",
		price = 0,
		category = "Nitro",

		canPurchase = function(ply, ownedItems)
			return false
		end,
		canSee = function(ply, ownedItems)
			return false
		end,

		instantAction = function(ply)
			ply:Give("weapon_chainsaw_new").xStore = true
		end,
		everyRepawnAction = function(ply)
			ply:Give("weapon_chainsaw_new").xStore = true
		end,
		everyLoadInAction = function(ply)
			ply:Give("weapon_chainsaw_new").xStore = true
		end,

		disabable = true
	}
	xStore.Config.Items["weapon_cbox_perma"] = {
		id = "weapon_cbox_perma",
		name = "Cardboard Box",
		model = "",
		price = 0,
		category = "Nitro",

		canPurchase = function(ply, ownedItems)
			return false
		end,
		canSee = function(ply, ownedItems)
			return false
		end,

		instantAction = function(ply)
			ply:Give("weapon_cbox").xStore = true
		end,
		everyRepawnAction = function(ply)
			ply:Give("weapon_cbox").xStore = true
		end,
		everyLoadInAction = function(ply)
			ply:Give("weapon_cbox").xStore = true
		end,

		disabable = true
	}

	-- Bat Weapon
	xStore.Config.Items["weapon_weapon_baseballbat"] = {
		id = "weapon_weapon_baseballbat",
		name = "Baseball Bat",
		model = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl",
		category = "Nitro Reward",
		price = 0,
	
		canPurchase = function(ply, ownedItems)
			return false
		end,
		canSee = function(ply, ownedItems)
			return false
		end,
	
		instantAction = function(ply)
			if ply:XYZIsArrested() then return end
			ply:Give("weapon_baseballbat").xStore = true
		end,
		everyRepawnAction = function(ply)
			ply:Give("weapon_baseballbat").xStore = true
		end,
		everyLoadInAction = function(ply)
			ply:Give("weapon_baseballbat").xStore = true
		end,
	
		disabable = true
	}

	-- Bat Weapon
	xStore.Config.Items["weapon_weapon_hammer"] = {
		id = "weapon_weapon_hammer",
		name = "Hammer",
		model = "models/weapons/tfa_nmrih/w_tool_barricade.mdl",
		category = "Nitro Reward",
		price = 0,
	
		canPurchase = function(ply, ownedItems)
			return false
		end,
		canSee = function(ply, ownedItems)
			return false
		end,
	
		instantAction = function(ply)
			if ply:XYZIsArrested() then return end
			ply:Give("weapon_hammer").xStore = true
		end,
		everyRepawnAction = function(ply)
			ply:Give("weapon_hammer").xStore = true
		end,
		everyLoadInAction = function(ply)
			ply:Give("weapon_hammer").xStore = true
		end,
	
		disabable = true
	}

	-- Nitro Lego Lightsaber Weapon
	xStore.Config.Items["weapon_weapon_lego_saber"] = {
		id = "weapon_weapon_lego_saber",
		name = "Lego Lightsaber",
		model = "models/lego/lego star wars/lightsaber.mdl",
		category = "Nitro Reward",
		price = 0,
	
		canPurchase = function(ply, ownedItems)
			return false
		end,
		canSee = function(ply, ownedItems)
			return false
		end,
	
		instantAction = function(ply)
			if ply:XYZIsArrested() then return end
			ply:Give("weapon_lego_saber").xStore = true
		end,
		everyRepawnAction = function(ply)
			ply:Give("weapon_lego_saber").xStore = true
		end,
		everyLoadInAction = function(ply)
			ply:Give("weapon_lego_saber").xStore = true
		end,
	
		disabable = true
	}
end

if CLIENT then
	hook.Add("HUDPaint", "xStoreLoadItems", function()
		loadItems()
		hook.Remove("HUDPaint", "xStoreLoadItems")
	end)
else
	hook.Add("Initialize", "xStoreLoadItems", function()
		loadItems()
	end)
end


xStore.Config.CC = {}
xStore.Config.CC.BasePrice = 1000
xStore.Config.CC.Models = {
	"models/player/alyx.mdl",
	"models/player/p2_chell.mdl",
	"models/player/kleiner.mdl",
	"models/player/mossman.mdl",
	"models/player/police.mdl",
	"models/player/police_fem.mdl",
	"models/player/combine_soldier.mdl",
	"models/player/charple.mdl",
	"models/player/skeleton.mdl",
	"models/player/zombie_classic.mdl",
	"models/player/zombie_fast.mdl",
	"models/player/zombie_soldier.mdl",
	"models/player/Group03/female_01.mdl",
	"models/player/Group03/female_02.mdl",
	"models/player/Group03/female_03.mdl",
	"models/player/Group03/female_04.mdl",
	"models/player/Group03/female_05.mdl",
	"models/player/Group03/female_06.mdl",
	"models/player/Group03/male_01.mdl",
	"models/player/Group03/male_02.mdl",
	"models/player/Group03/male_03.mdl",
	"models/player/Group03/male_04.mdl",
	"models/player/Group03/male_05.mdl",
	"models/player/Group03/male_06.mdl",
	"models/player/Group03/male_07.mdl",
	"models/player/Group03/male_08.mdl",
	"models/player/Group03/male_09.mdl",
	"models/player/hostage/hostage_01.mdl",
	"models/player/hostage/hostage_02.mdl",
	"models/player/hostage/hostage_03.mdl",
	"models/player/hostage/hostage_04.mdl",
	"models/player/arctic.mdl",
	"models/player/gasmask.mdl",
	"models/player/guerilla.mdl",
	"models/player/leet.mdl",
	"models/player/phoenix.mdl",
	"models/player/dod_american.mdl",
	"models/player/dod_german.mdl"
}
xStore.Config.CC.PremiumModels = {
	"models/player/suits/robber_tuckedtie.mdl",
	"models/code_gs/vendetta/vendettaplayer.mdl",
	"models/oldbill/rasta_male.mdl",
	"models/player/Terroriser/Brian.mdl",
	"models/player/john_marston.mdl"
}
xStore.Config.CC.PremiumCost = 200
xStore.Config.CC.MaxSlots = 5
xStore.Config.CC.SlotPrice = 500

xStore.Config.CC.Weapons = {}
xStore.Config.CC.Weapons["weapon_zipties"] = 500
xStore.Config.CC.Weapons["cw_sv98"] = 500
xStore.Config.CC.Weapons["cw_l115"] = 400
xStore.Config.CC.Weapons["cw_ak74"] = 400
xStore.Config.CC.Weapons["cw_ar15"] = 400
xStore.Config.CC.Weapons["cw_scarh"] = 400
xStore.Config.CC.Weapons["cw_vss"] = 300
xStore.Config.CC.Weapons["cw_m14"] = 300
xStore.Config.CC.Weapons["cw_l85a2"] = 300
xStore.Config.CC.Weapons["cw_mp5"] = 300
xStore.Config.CC.Weapons["cw_ump45"] = 300
xStore.Config.CC.Weapons["cw_g36c"] = 300
xStore.Config.CC.Weapons["cw_g3a3"] = 300
xStore.Config.CC.Weapons["cw_m3super90"] = 300
xStore.Config.CC.Weapons["cw_shorty"] = 300
xStore.Config.CC.Weapons["cw_mac11"] = 200
xStore.Config.CC.Weapons["cw_deagle"] = 150
xStore.Config.CC.Weapons["cw_mr96"] = 150
xStore.Config.CC.Weapons["cw_fiveseven"] = 100
xStore.Config.CC.Weapons["cw_m1911"] = 100
xStore.Config.CC.Weapons["cw_p99"] = 100
xStore.Config.CC.Weapons["cw_makarov"] = 100

xStore.Config.CC.EditFee = 25
xStore.Config.CC.RemoveAccessFee = 5