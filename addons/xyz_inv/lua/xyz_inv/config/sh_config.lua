Inventory.Config.MaxSpace = {} -- How many slots each xAdmin rank has access to.
Inventory.Config.MaxSpace['default'] = 25 -- This one is required, it's the fallback value
Inventory.Config.MaxSpace['vip'] = 35
Inventory.Config.MaxSpace['elite'] = 45
Inventory.Config.MaxSpace['trial-mod'] = 50
Inventory.Config.MaxSpace['jr-mod'] = 50
Inventory.Config.MaxSpace['moderator'] = 50
Inventory.Config.MaxSpace['senior-moderator'] = 50
Inventory.Config.MaxSpace['jr-admin'] = 60
Inventory.Config.MaxSpace['admin'] = 60
Inventory.Config.MaxSpace['senior-admin'] = 60
Inventory.Config.MaxSpace['staff-lead'] = 60
Inventory.Config.MaxSpace['staff-supervisor'] = 60
Inventory.Config.MaxSpace['developer'] = 60
Inventory.Config.MaxSpace['superadmin'] = 60

-- MaxSpace * Multiplier = Locker space
Inventory.Config.InvMultiplier = 6


local function loadItems()
	Inventory.Config.AllowedItems = {} -- Allowed items in the inv
	for k, v in pairs(weapons.GetList()) do -- All the CW items
		if v.Base == "cw_base" then
			Inventory.Config.AllowedItems[v.ClassName] = true
		end
	end
	-- Medic stuff
	Inventory.Config.AllowedItems["xyz_armour_box"] = true
	Inventory.Config.AllowedItems["xyz_medkit"] = true

	-- Disable store purchased items
	Inventory.Config.AllowedItems["ak47_beast"] = false
	Inventory.Config.AllowedItems["g36_balrog"] = false
	Inventory.Config.AllowedItems["l96_dragon"] = false
	Inventory.Config.AllowedItems["mac_lara"] = false
	Inventory.Config.AllowedItems["m4a1_beast"] = false
	Inventory.Config.AllowedItems["47_ethereal"] = false
	Inventory.Config.AllowedItems["tempest_smg"] = false
	Inventory.Config.AllowedItems["tmp_dragon"] = false
	Inventory.Config.AllowedItems["cw_m249_official"] = false

	-- Alcohol
	Inventory.Config.AllowedItems["xyz_alcohol_am_beer"] = true
	Inventory.Config.AllowedItems["xyz_alcohol_bleuter_champagne"] = true
	Inventory.Config.AllowedItems["xyz_alcohol_cava_champagne"] = true
	Inventory.Config.AllowedItems["xyz_alcohol_vodka"] = true
	Inventory.Config.AllowedItems["xyz_alcohol_coke"] = true
	Inventory.Config.AllowedItems["xyz_alcohol_patriot_beer"] = true
	Inventory.Config.AllowedItems["xyz_alcohol_pepsi"] = true
	Inventory.Config.AllowedItems["xyz_alcohol_pisswasser_beer"] = true
	Inventory.Config.AllowedItems["xyz_alcohol_rum"] = true
	Inventory.Config.AllowedItems["xyz_alcohol_red_wine"] = true
	Inventory.Config.AllowedItems["xyz_alcohol_rose_wine"] = true
	Inventory.Config.AllowedItems["xyz_alcohol_tequila"] = true
	Inventory.Config.AllowedItems["xyz_alcohol_water"] = true
	Inventory.Config.AllowedItems["xyz_alcohol_whiskey"] = true
	Inventory.Config.AllowedItems["xyz_alcohol_white_wine"] = true
	
	-- Misc
	Inventory.Config.AllowedItems["pvault_mask"] = true
	Inventory.Config.AllowedItems["uweed_joint"] = true
	Inventory.Config.AllowedItems["uweed_bag"] = true
	Inventory.Config.AllowedItems["xyz_candy_cane"] = true
	Inventory.Config.AllowedItems["snowball_thrower_nodamage"] = true
	Inventory.Config.AllowedItems["xyz_cocaine_brick"] = true
	Inventory.Config.AllowedItems["xyz_recycled_block"] = true
end

if CLIENT then
	hook.Add("HUDPaint", "InventoryLoadItems", function()
		loadItems()
		hook.Remove("HUDPaint", "InventoryLoadItems")
	end)
else
	hook.Add("Initialize", "InventoryLoadItems", function()
		loadItems()
	end)
end

Inventory.Config.Tabs = {
	[1] = {
		name = "Favourites",
		filter = function(items)
			local filter = {}

			for k, v in pairs(items) do
				if not Inventory.Core.FavItems[v.data.info.class] then continue end
				table.insert(filter, v)
			end

			return filter
		end
	},
	[2] = {
		name = "All",
		filter = function(items)
			return items
		end
	},
	[3] = {
		name = "Weapons",
		filter = function(items)
			local filter = {}

			for k, v in pairs(items) do
				if not v.data.type.isWeapon then continue end
				if v.data.type.isShipment then continue end
				table.insert(filter, v)
			end

			return filter
		end
	},
	[4] = {
		name = "Entities",
		filter = function(items)
			local filter = {}

			for k, v in pairs(items) do
				if v.data.type.isWeapon then continue end
				if v.data.type.isShipment then continue end
				table.insert(filter, v)
			end

			return filter

		end
	},
}

-- These weapons will not be /invholster able, but instead need to be dropped and picked up
Inventory.Config.BlockInvHolster = {}
Inventory.Config.BlockInvHolster['ins2_atow_rpg7'] = true
Inventory.Config.BlockInvHolster['khr_m60'] = true
Inventory.Config.BlockInvHolster['cw_frag_grenade'] = true
Inventory.Config.BlockInvHolster['khr_cb4'] = true
