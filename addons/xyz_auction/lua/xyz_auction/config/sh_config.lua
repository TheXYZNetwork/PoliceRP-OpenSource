-- The chat and UI colors
AuctionHouse.Config.Color = Color(22, 120, 22)
-- The command to open the admin menu
AuctionHouse.Config.AdminCommand = "!auction"
-- Needed power to make an admin listing
AuctionHouse.Config.AdminPower = 95
-- Disable player listed auctions
AuctionHouse.Config.DisablePlayerAuctions = false
-- The server's % cut
AuctionHouse.Config.ServersFee = 0.1
-- When a bid is placed with this many seconds left, it will reset the time left to this.
AuctionHouse.Config.Buffer = 60

-- The different types
AuctionHouse.Config.Types = {
	["weapon"] = {
		name = "Weapon",
		-- This function may be ran multiple times for a multi quantity item.
		assign = function(plyID, class, data)
			Inventory.Core.GiveItem(plyID, class, data)
		end, 
		remove = function(plyID, class, data)
			local ply = player.GetBySteamID64(plyID)
			if IsValid(ply) then
				Inventory.Core.RemoveItemFromInv(ply, class)
			else
				Inventory.Database.RemoveItem(plyID, class)
			end
		end,
		getListable = function(ply)
			local tbl = {}
			for k, v in pairs(SERVER and Inventory.SavedInvs[ply:SteamID64()] or Inventory.SavedInvs) do
				if AuctionHouse.Config.Types["weapon"].restricted[v.class] then continue end
				if not v.data.type.isWeapon then continue end

				local data = v
				data.model = v.data.info.displayModel
				data.name = weapons.Get(v.class) and weapons.Get(v.class).PrintName or v.class

				data.quantity = 1

				table.insert(tbl, data)
			end

			local stacks = {}
			local stacked = {}
			for k, v in pairs(tbl) do
				if not stacked[v.class] then
					stacked[v.class] = table.insert(stacks, v)
					continue
				end

				stacks[stacked[v.class]].quantity = stacks[stacked[v.class]].quantity + 1
			end

			return stacks
		end,
		restricted = {
			["cw_sci-fi_ak47_beast"] = true,
			["cw_sci-fi_g36_balrog"] = true,
			["cw_sci-fi_scout_xbow"] = true,
			["cw_sci-fi_mac_lara"] = true,
			["cw_sci-fi_m4a1_transformer"] = true,
			["cw_sci-fi_47_ethereal"] = true,
			["cw_sci-fi_tmp_dragon"] = true
		},
		baseData = function(class)
			local data = Inventory.ItemTypes['default_weapon'].dataFormat(class)

			return data
		end,
		formatName = function(class)


		end
	},
	["entity"] = {
		name = "Entity",
		-- This function may be ran multiple times for a multi quantity item.
		assign = function(plyID, class, data)
			Inventory.Core.GiveItem(plyID, class, data)
		end, 
		remove = function(plyID, class, data)
			local ply = player.GetBySteamID64(plyID)
			if IsValid(ply) then
				Inventory.Core.RemoveItemFromInv(ply, class)
			else
				Inventory.Database.RemoveItem(plyID, class)
			end
		end,
		getListable = function(ply)
			local tbl = {}
			for k, v in pairs(SERVER and Inventory.SavedInvs[ply:SteamID64()] or Inventory.SavedInvs) do
				if AuctionHouse.Config.Types["entity"].restricted[v.class] then continue end
				if v.data.type.isWeapon then continue end

				local data = v
				data.model = v.data.info.displayModel
				data.name = v.data.info.displayName or v.class

				data.quantity = 1

				table.insert(tbl, data)
			end

			local stacks = {}
			local stacked = {}
			for k, v in pairs(tbl) do
				if not stacked[v.class] then
					stacked[v.class] = table.insert(stacks, v)
					continue
				end

				stacks[stacked[v.class]].quantity = stacks[stacked[v.class]].quantity + 1
			end

			return stacks
		end,
		restricted = {
			["xyz_alcohol_am_beer"] = true,
			["xyz_alcohol_bleuter_champagne"] = true,
			["xyz_alcohol_cava_champagne"] = true,
			["xyz_alcohol_vodka"] = true,
			["xyz_alcohol_vodka"] = true,
			["xyz_alcohol_coke"] = true,
			["xyz_alcohol_patriot_beer"] = true,
			["xyz_alcohol_pepsi"] = true,
			["xyz_alcohol_pisswasser_beer"] = true,
			["xyz_alcohol_rum"] = true,
			["xyz_alcohol_red_wine"] = true,
			["xyz_alcohol_rose_wine"] = true,
			["xyz_alcohol_tequila"] = true,
			["xyz_alcohol_tequila"] = true,
			["xyz_alcohol_tequila"] = true,
			["xyz_alcohol_white_wine"] = true
		}
	},
	["vehicle"] = {
		name = "Garage (Vehicle)",
		-- This function may be ran multiple times for a multi quantity item.
		assign = function(plyID, class, data)
			local ply = player.GetBySteamID64(plyID)
			if IsValid(ply) then
				CarDealer.Core.Give(ply, class, data.color, data.skin, data.bodygroups, data.mods, data.performance)
			else
				CarDealer.Database.GiveID(plyID, class, data.color or color_white, data.skin or 0, data.bodygroups or {}, data.mods or {}, data.performance or {})
			end
		end, 
		remove = function(plyID, class, data)
			local ply = player.GetBySteamID64(plyID)
			if IsValid(ply) then
				CarDealer.Core.Remove(ply, data.id)
			else
				CarDealer.Database.RemoveVehicleID(data.id)
			end
		end,
		getListable = function(ply)
			local tbl = {}
			for k, v in pairs(SERVER and CarDealer.Vehicles[ply:SteamID64()] or CarDealer.Vehicles) do
				if AuctionHouse.Config.Types["vehicle"].restricted[v.class] then continue end

				local car = list.Get("Vehicles")[v.class]

				local data = {}
				data.class = v.class
				data.data = v
				data.name = car and car.Name or k
				data.model = car and car.Model or ""
				data.quantity = 1

				table.insert(tbl, data)
			end

			return tbl
		end,
		restricted = {
			["atv_buggy"] = true,
			["electric_gokart"] = true,
			["cooper4x4tdm"] = true,
			["rv"] = true,
			["l4dapc_sgm"] = true,
			
			["djm_mercedes_slr_stirling_moss"] = true
		},
		modelMods = function(model, data)
			if data.color then
				model:SetColor(data.color)
			end
			if data.bodygroups then
				for k, v in pairs(data.bodygroups) do
					model.Entity:SetBodygroup(k, v)
				end
			end
			if data.skin then
				model.Entity:SetSkin(data.skin)
			end
		end
	},
	["pcasino_spin"] = {
		name = "Mystery Wheel Spin (pCasino)",
		-- This function may be ran multiple times for a multi quantity item.
		assign = function(plyID, class, data)
			local ply = player.GetBySteamID64(plyID)
			if IsValid(ply) then
				local amount = tonumber(class)
				for i=1, (amount or 1) do
					PerfectCasino.Core.GiveFreeSpin(ply)
				end
			end
		end, 
		remove = function(plyID, class, data)
		end,
		getListable = function(ply)
		end,
		restricted = {},
		adminOnly = true
	},
	["usergroup"] = {
		name = "Usergroup",
		-- This function may be ran multiple times for a multi quantity item.
		assign = function(plyID, class, data)
			local ply = player.GetBySteamID64(plyID)

			if IsValid(ply) then
				xAdmin.Users[plyID] = class
				xAdmin.Core.Msg({"Your usergroup has been updated to the following: "..args[2]}, ply)

				net.Start("xAdminNetworkIDRank")
					net.WriteString(plyID)
					net.WriteString(xAdmin.Users[plyID])
				net.Broadcast()
			end

			xAdmin.Database.UpdateUsersGroup(plyID, class)
		end, 
		remove = function(plyID, class, data)
		end,
		getListable = function(ply)
		end,
		restricted = {},
		adminOnly = true
	},
	["emote"] = {
		name = "Emote",
		-- This function may be ran multiple times for a multi quantity item.
		assign = function(plyID, class, data)
			local ply = player.GetBySteamID64(plyID)
			local item = xStore.Config.Items[class.."_emote"]
			xStore.Database.GiveUserItem(plyID, item.id, 0)

			if IsValid(ply) then
				table.insert(xStore.Users[plyID].items, {item = item.id, paid = 0, active = true, created = os.time()})
			
				if item.instantAction then
					item.instantAction(ply)
				end
			end
		end, 
		remove = function(plyID, class, data)
		end,
		getListable = function(ply)
		end,
		restricted = {},
		adminOnly = true
	}
}