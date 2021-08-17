-- convert permaprop to this system
--[[
local tbl = sql.Query("SELECT * FROM permaprops")
for k, v in pairs(tbl) do
	json = util.JSONToTable(v.content)
	print(string.format("{ent = '%s', pos = %s, ang = %s},", json.Class, "Vector("..json.Pos.x..", "..json.Pos.y..", "..json.Pos.z..")", "Angle("..json.Angle.p..", "..json.Angle.y..", "..json.Angle.r..")"))
end
]]--

-- TODO
-- Patrols
-- UPS
-- Trucker
-- Racing
-- Trash/Dumpsters
-- Fire

local propsToSpawn = {
	["rp_rockford_v2b_xyz_v1a"] = {
		-- Spawn text screens
		{ent = 'lite_text', pos = Vector(-5219.1875, -6003.78125, 57.812496185303), ang = Angle(0, 0, 90), custom = function(ent) ent.data.text = {"SPAWN ENDS HERE", "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"} ent.data.color = {Color(255, 255, 255), Color(255, 0, 0)} ent.data.size = {100, 100} end},
		{ent = 'lite_text', pos = Vector(-4643, -6001.8125, 56.65625), ang = Angle(0, -0.10986328125, 90), custom = function(ent) ent.data.text = {"SPAWN ENDS HERE", "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"} ent.data.color = {Color(255, 255, 255), Color(255, 0, 0)} ent.data.size = {100, 100} end},
		{ent = 'lite_text', pos = Vector(-4066.6560058594, -6004.09375, 58.09375), ang = Angle(0, 0.0054931640625, 90), custom = function(ent) ent.data.text = {"SPAWN ENDS HERE", "‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"} ent.data.color = {Color(255, 255, 255), Color(255, 0, 0)} ent.data.size = {100, 100} end},
		-- City Hall / Spawn
		{ent = 'xyz_auction_house', pos = Vector(-4542.40625, -4597.3125, 64.125), ang = Angle(0, -88.319091796875, 0)},
		{ent = 'xyz_dmv', pos = Vector(-4607.375, -4595.5, 64.375), ang = Angle(0, -90.28564453125, 0)},
		{ent = 'xyz_wep_skins', pos = Vector(-4671.8125, -4598.96875, 64.59375), ang = Angle(0, -99.860229492188, 0)},
		{ent = 'xyz_election', pos = Vector(-4737.8125, -4598.96875, 64.78125), ang = Angle(0, -90.313110351563, 0)},
		-- Bank
		{ent = 'xyz_banker_npc', pos = Vector(-3959, -3094.625, 67.9375), ang = Angle(0, 0, 0)},
		-- President Office
		{ent = 'xyz_president_tax', pos = Vector(-3995.5, -4725.84375, 768.65625), ang = Angle(-0.2691650390625, 122.50854492188, 0.1153564453125)},
		{ent = 'prop_physics', pos = Vector(-4024.1875, -4721.15625, 720.4375), ang = Angle(0, 0, 0), model = "models/props/cs_militia/wood_table.mdl"},
		{ent = 'xyz_president_comp', pos = Vector(-3869.5, -5063.46875, 720.46875), ang = Angle(0.0274658203125, 134.18151855469, 0)},
		-- Cardealership
		{ent = 'xyz_misc_car_dealer', pos = Vector(-2795.53125, -1481.03125, 0.625), ang = Angle(0, 180, 0)},
		{ent = 'xyz_dmv', pos = Vector(-4201.28125, -668, 0.1875), ang = Angle(0, -90, 0)},
		{ent = 'xyz_car_dealer', pos = Vector(-4636.90625, -668.84375, 0.1875), ang = Angle(0, -90, 0)},

		-- Police Department
		{ent = 'police_exam_npc', pos = Vector(-8766.78125, -5586.78125, 8.0625), ang = Angle(0, -89.18701171875, 0)},
		{ent = 'handcuff_front_desk', pos = Vector(-8833.78125, -5587.96875, 8.125), ang = Angle(0, -90.115356445313, 0)},
		{ent = 'xyz_undercover_npc', pos = Vector(-8266.03125, -4953, 9.34375), ang = Angle(0, -89.247436523438, 0)},
		{ent = 'xyz_podium', pos = Vector(-7229.59375, -5117.34375, 57.65625), ang = Angle(-0.076904296875, 90.038452148438, 0.0054931640625)},
		{ent = 'xyz_badge_id', pos = Vector(-8347.09375, -4956.625, 8.125), ang = Angle(0, -90.230712890625, 0)},
		{ent = 'cw_ammo_crate_unlimited', pos = Vector(-7847.6875, -4779.34375, 24.34375), ang = Angle(0.0439453125, -0.0274658203125, 0.0054931640625)},
		{ent = 'xyz_armory', pos = Vector(-7700.96875, -4616.59375, 69.3125), ang = Angle(-0.0274658203125, -90.692138671875, 0.010986328125)},
		{ent = 'xyz_weapon_armory', pos = Vector(-7566.78125, -4629.1875, 8.34375), ang = Angle(0, -135, 0)},
		{ent = 'xyz_seized_box', pos = Vector(-7568.375, -4894.09375, 24.34375), ang = Angle(-0.0054931640625, -179.99450683594, 0.0823974609375)},
		{ent = 'xyz_gov_car_dealer', pos = Vector(-8484.78125, -5801.34375, 1.4375), ang = Angle(0, -0.17578125, 0)},
		{ent = 'xyz_gov_car_dealer', pos = Vector(-7589.84375, -5618.5625, 1.03125), ang = Angle(0, -178.50036621094, 0)},
		{ent = 'xyz_gundealer_npc', pos = Vector(-8690.78125, -5584.875, 8.15625), ang = Angle(0, -64.62158203125, 0)},
		-- Sub Department
		{ent = 'handcuff_warden', pos = Vector(-5803.875, -3345.28125, 8.25), ang = Angle(0, -179.82971191406, 0)},
		{ent = 'xyz_undercover_npc', pos = Vector(-5724.625, -3704.6875, 272.03125), ang = Angle(0, 57.85400390625, 0)},
		{ent = 'xyz_badge_id', pos = Vector(-5800.1875, -3159.125, 8.90625), ang = Angle(0, 177.47863769531, 0)},
		-- Robbable Stores
		{ent = 'xyz_raid_shell', pos = Vector(-14646.9375, 2629.0625, 400.03125), ang = Angle(0, 0.0054931640625, 0)},
		{ent = 'xyz_raid_taco', pos = Vector(752.9375, 2036.8125, 544.03125), ang = Angle(0, -178.7255859375, 0)},
		{ent = 'xyz_raid_supermarket', pos = Vector(1606.4375, 6067.0625, 574.03125), ang = Angle(0, -90.142822265625, 0)},
		-- Prison
		{ent = 'handcuff_warden', pos = Vector(-8413.34375, -4954.0625, 9.375), ang = Angle(0, -92.422485351563, 0)},
		{ent = 'xyz_prison_escape_box', pos = Vector(-7123.875, -5864.09375, -1372.65625), ang = Angle(0, 89.994506835938, -0.0384521484375)},
		{ent = 'xyz_prison_escape_box', pos = Vector(-7212.25, -5864.125, -1372.625), ang = Angle(0.06591796875, 89.989013671875, -0.0384521484375)},
		{ent = 'xyz_prison_escape_box', pos = Vector(-7564.03125, -5864.15625, -1372.78125), ang = Angle(-0.0164794921875, 89.5166015625, -0.06591796875)},
		{ent = 'xyz_prison_escape_box', pos = Vector(-7660.15625, -5864.1875, -1372.78125), ang = Angle(0.0164794921875, 89.972534179688, 0.1043701171875)},
		{ent = 'xyz_prison_escape_box', pos = Vector(-7660.15625, -5608.09375, -1372.65625), ang = Angle(0.0604248046875, 90.19775390625, -0.032958984375)},
		{ent = 'xyz_prison_escape_box', pos = Vector(-7563.84375, -5607.4375, -1372.84375), ang = Angle(0.032958984375, 90.170288085938, -0.0274658203125)},
		{ent = 'xyz_prison_escape_box', pos = Vector(-7212.21875, -5608.15625, -1372.65625), ang = Angle(-0.120849609375, 89.945068359375, -0.0823974609375)},
		{ent = 'xyz_prison_escape_box', pos = Vector(-7123.9375, -5608.28125, -1372.8125), ang = Angle(0.0274658203125, 89.972534179688, 0)},
		-- Hospital
		{ent = 'xyz_doctor_npc', pos = Vector(-78.96875, -5856.9375, 64.65625), ang = Angle(0, 179.70886230469, 0)},
		{ent = 'fr_exam_npc', pos = Vector(-157.375, -6021.9375, 64.46875), ang = Angle(0, 135.95031738281, 0)},
		{ent = 'xyz_gov_car_dealer', pos = Vector(338.6875, -4589.09375, 65.5625), ang = Angle(0, -93.543090820313, 0)},
		-- Hitman Phones
		{ent = 'xyz_hitman_phone', pos = Vector(-3602.59375, -2735.65625, 45.09375), ang = Angle(0.0494384765625, 90.005493164063, -0.0054931640625)},
		{ent = 'xyz_hitman_phone', pos = Vector(-7085.6875, -157.1875, 35.781246185303), ang = Angle(0, 0.0054931640625, 0)},
		{ent = 'xyz_hitman_phone', pos = Vector(1778.1875, 5932.1875, 609.4375), ang = Angle(0, 0, 0)},
		-- Mine
		{ent = 'xyz_mining_npc', pos = Vector(10524.0625, -4228.15625, -447.125), ang = Angle(0, -90.104370117188, 0)},
		{ent = 'xyz_mining_ore_node', pos = Vector(11822.28125, -2288.0625, -425.28125), ang = Angle(0, -43.368530273438, 0)},
		{ent = 'xyz_mining_ore_node', pos = Vector(11849.21875, -2637.84375, -425.1875), ang = Angle(0, -58.95263671875, -0.032958984375)},
		{ent = 'xyz_mining_ore_node', pos = Vector(11994.71875, -2868.3125, -425.25), ang = Angle(-0.0274658203125, 172.02941894531, 0.010986328125)},
		{ent = 'xyz_mining_ore_node', pos = Vector(11822.625, -3324.375, -425.125), ang = Angle(0.0164794921875, -57.980346679688, 0.142822265625)},
		{ent = 'xyz_mining_ore_node', pos = Vector(11988.71875, -3920.53125, -425.21875), ang = Angle(-0.0823974609375, -114.521484375, -0.02197265625)},
		{ent = 'xyz_mining_ore_node', pos = Vector(11829.59375, -4013.40625, -425.25), ang = Angle(0, -43.203735351563, 0)},
		{ent = 'xyz_mining_ore_node', pos = Vector(11900.4375, -4439.90625, -425.28125), ang = Angle(0, 168.38195800781, 0)},
		{ent = 'xyz_mining_ore_node', pos = Vector(11298.15625, -4424.0625, -425.28125), ang = Angle(0, 9.1571044921875, 0)},
		{ent = 'xyz_mining_ore_node', pos = Vector(10372.96875, -4404.09375, -425.03125), ang = Angle(-0.0604248046875, 81.353759765625, -0.2911376953125)},
		-- UPS
		{ent = 'ups_npc', pos = Vector(-1378.59375, 3918.84375, 552.34375), ang = Angle(0, 90, 0)},
		{ent = 'ups_platform', pos = Vector(1666.71875, 9695.28125, 530.375), ang = Angle(0, -89.989013671875, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Appartments" ent.reward = 2000 end},
		{ent = 'ups_platform', pos = Vector(-5891.28125, -1892.78125, -5.6875), ang = Angle(-0.0164794921875, 89.994506835938, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Car Dealer" ent.reward = 2000 end},
		{ent = 'ups_platform', pos = Vector(-1651.40625, -5632.28125, -5.65625), ang = Angle(0, 89.945068359375, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Hospital" ent.reward = 2000 end},
		{ent = 'ups_platform', pos = Vector(-5444.5625, -7407.6875, -5.625), ang = Angle(0, 90.225219726563, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Town Hall" ent.reward = 2000 end},
		{ent = 'ups_platform', pos = Vector(-8930.8125, -3865.78125, -5.71875), ang = Angle(0, 0.3515625, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Police Department" ent.reward = 2000 end},
		{ent = 'ups_platform', pos = Vector(-7806.0625, 7640.5, -5.71875), ang = Angle(0, -0.076904296875, 0), ang = Angle(0, 0.3515625, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Industrial" ent.reward = 2000 end},
		{ent = 'ups_platform', pos = Vector(-1974.71875, 6296.21875, 530.3125), ang = Angle(0, -179.53308105469, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Tavern" ent.reward = 2000 end},
		{ent = 'ups_platform', pos = Vector(14056.84375, 14187.9375, 1530.25), ang = Angle(0, -178.68713378906, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Bridge" ent.reward = 2000 end},
		{ent = 'ups_platform', pos = Vector(9953.96875, 3560.875, 1530.21875), ang = Angle(0, 179.36828613281, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Park" ent.reward = 2000 end},
		{ent = 'ups_platform', pos = Vector(-14047.78125, 2716.96875, 378.28125), ang = Angle(0, -0.6646728515625, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Shell Gas Station" ent.reward = 2000 end},
		-- Trucker
		{ent = 'trucker_npc', pos = Vector(-1446.125, 3918.125, 552.34375), ang = Angle(0, 90, 0)},
		{ent = 'trucker_platform', pos = Vector(1725.5, 9024.78125, 530.25), ang = Angle(0.0054931640625, 0, -0.0054931640625), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) end}, -- Apartments
		{ent = 'trucker_platform', pos = Vector(-4129, -1892.34375, -5.71875), ang = Angle(-0.0054931640625, 89.6923828125, -0.010986328125), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) end}, -- Car Dealer
		{ent = 'trucker_platform', pos = Vector(13380.5, -3155.8125, 314.3125), ang = Angle(0.0274658203125, 0.0164794921875, -0.010986328125), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) end}, -- Mine
		{ent = 'trucker_platform', pos = Vector(7392.4375, 3401.625, 1530.21875), ang = Angle(0, -0.0274658203125, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) end}, -- Park
		{ent = 'trucker_platform', pos = Vector(-2576.4375, 14014.15625, 506.21875), ang = Angle(0, 0.5767822265625, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) end}, -- Bridge
		{ent = 'trucker_platform', pos = Vector(-1555.875, -4987.6875, -5.71875), ang = Angle(0.0164794921875, -89.571533203125, -0.0054931640625), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) end}, -- Hospital
		-- Racing
		
		{ent = 'racing_platform', pos = Vector(-3348.21875, -5828.4375, -5.78125), ang = Angle(0, 0.4998779296875, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) end},
		{ent = 'racing_platform', pos = Vector(13098.0625, -8624.1875, 314.34375), ang = Angle(-0.032958984375, -121.79992675781, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) end},
		{ent = 'racing_platform', pos = Vector(11295.9375, 6410.1875, 1530.34375), ang = Angle(0.0274658203125, 89.994506835938, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) end},
		{ent = 'racing_platform', pos = Vector(-2520.84375, 15035.3125, 506.3125), ang = Angle(0.0054931640625, -0.208740234375, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) end},
		{ent = 'racing_platform', pos = Vector(697.5625, 2729.65625, 530.25), ang = Angle(0, 89.939575195313, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) end},
		{ent = 'racing_platform', pos = Vector(-4792.9375, -1635.53125, -5.71875), ang = Angle(0.0274658203125, 0.054931640625, 0.0054931640625), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) end},
		{ent = 'racing_platform', pos = Vector(-9358.8125, -5349.15625, -5.71875), ang = Angle(0, 0.2197265625, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) end},
		{ent = 'racing_platform', pos = Vector(-7896.09375, 9460.53125, -5.71875), ang = Angle(0, -89.923095703125, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) end},
		{ent = 'racing_platform', pos = Vector(-13168.5, -11863.28125, -5.71875), ang = Angle(0, 89.3408203125, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) end},

		-- Foot Patrol
		{ent = 'xyz_patrol_waypoint_foot', pos = Vector(-358.03125, -5353.875, 58.25), ang = Angle(-0.0054931640625, -89.346313476563, -0.0054931640625), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Hospital" end},
		{ent = 'xyz_patrol_waypoint_foot', pos = Vector(-4909.28125, -6112.28125, 2.25), ang = Angle(-0.0054931640625, 0.1373291015625, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Town Hall" end},
		{ent = 'xyz_patrol_waypoint_foot', pos = Vector(-3899.84375, -877.71875, -5.78125), ang = Angle(0.0054931640625, -179.08264160156, -0.0054931640625), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Car Dealer" end},
		{ent = 'xyz_patrol_waypoint_foot', pos = Vector(-6423.28125, 3615.28125, 2.25), ang = Angle(-0.0054931640625, 90.19775390625, 0.0054931640625), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Industrial" end},
		{ent = 'xyz_patrol_waypoint_foot', pos = Vector(-8753.84375, -5079.375, 2.21875), ang = Angle(-0.0054931640625, -4.9273681640625, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Police Station" end},
		{ent = 'xyz_patrol_waypoint_foot', pos = Vector(-5974.59375, -2987.96875, 2.25), ang = Angle(0, 90.362548828125, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Sub Department HQ" end},
		{ent = 'xyz_patrol_waypoint_foot', pos = Vector(423.15625, 1850.15625, 538.25), ang = Angle(-0.0054931640625, 90.510864257813, 0.0054931640625), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Taco Bell" end},
		{ent = 'xyz_patrol_waypoint_foot', pos = Vector(-3635.9375, -3067.6875, 26.1875), ang = Angle(0, 89.994506835938, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Bank" end},
		-- Patrol
		{ent = 'xyz_patrol_waypoint', pos = Vector(-5437.28125, -7562.46875, -5.59375), ang = Angle(0.0274658203125, -89.97802734375, -0.0054931640625), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Town Hall" end},
		{ent = 'xyz_patrol_waypoint', pos = Vector(-8092.5, 6980.28125, -5.71875), ang = Angle(0, 0.032958984375, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Industrial" end},
		{ent = 'xyz_patrol_waypoint', pos = Vector(-13186.0625, 14193.8125, 506.25), ang = Angle(0, -0.1483154296875, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Bridge" end},
		{ent = 'xyz_patrol_waypoint', pos = Vector(-13697.75, 2583.34375, 378.34375), ang = Angle(0.0164794921875, -0.087890625, 0.0054931640625), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Shell Gas Station" end},
		{ent = 'xyz_patrol_waypoint', pos = Vector(2515.9375, 5694.96875, 530.25), ang = Angle(0, 0.7525634765625, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Rockford Foods" end},
		{ent = 'xyz_patrol_waypoint', pos = Vector(8195.0625, 2261.8125, 1530.21875), ang = Angle(0, 90.115356445313, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Park" end},
		{ent = 'xyz_patrol_waypoint', pos = Vector(13354.15625, -3702.40625, 314.375), ang = Angle(0, 179.73083496094, -0.0054931640625), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Mine" end},
		{ent = 'xyz_patrol_waypoint', pos = Vector(-5440.4375, -1720.75, -5.65625), ang = Angle(0.0164794921875, 0.3790283203125, 0), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Car Dealer" end},
		{ent = 'xyz_patrol_waypoint', pos = Vector(-1580.90625, -5877.71875, -5.71875), ang = Angle(0.0054931640625, -90.368041992188, 0.0164794921875), custom = function(ent) ent:SetColor(Color(0, 0, 0, 0)) ent:SetRenderMode(RENDERMODE_TRANSALPHA) ent.name = "Hospital" end},
		-- Misc
		{ent = 'xyz_dumpster', pos = Vector(-4879.875, -7951.09375, 25.5625), ang = Angle(0.0494384765625, 90.587768554688, 0)},
		{ent = 'xyz_dumpster', pos = Vector(-7077.5625, 2334.25, 34.65625), ang = Angle(0, 0.7086181640625, 0)},
		{ent = 'xyz_dumpster', pos = Vector(-720.46875, 5452.15625, 561.71875), ang = Angle(-0.0933837890625, 0.28564453125, -0.0439453125)},
		{ent = 'xyz_dumpster', pos = Vector(10273.46875, 4966.15625, 1569.46875), ang = Angle(0, -135.56030273438, -0.0054931640625)},
		{ent = 'xyz_car_scrapper', pos = Vector(14216.5, 15196.25, 1536.03125), ang = Angle(0, -135, 0)},
		{ent = 'xyz_drug_hustler', pos = Vector(-2521.59375, 13776.46875, 252.5), ang = Angle(0, 90, 0)},
		{ent = 'xyz_drug_hustler', pos = Vector(10333.96875, 2176.5625, 1544.03125), ang = Angle(0, 141.21276855469, 0)},
		{ent = 'xyz_smuggler_npc', pos = Vector(-3653, 322.90625, 52.3125), ang = Angle(0, -45, 0)},
		{ent = 'xyz_tow_truck_agency', pos = Vector(-7027.4375, 1435.71875, 0.03125), ang = Angle(0, 0, 0)},
		{ent = 'xyz_recycleseller', pos = Vector(-5710.71875, -8127.625, 8.28125), ang = Angle(0.010986328125, 0, 0)},
		{ent = 'xyz_manhole', pos = Vector(-2706.5, -6120.96875, 9.46875), ang = Angle(-0.0604248046875, -135.54382324219, -0.0054931640625)},
		{ent = 'xyz_manhole', pos = Vector(-6395.9375, -1253.3125, 9.34375), ang = Angle(0, -46.554565429688, 0)},
		{ent = 'xyz_manhole', pos = Vector(-7534.875, 8508.1875, 1.53125), ang = Angle(0.340576171875, -10.92041015625, 0.1483154296875)},
		{ent = 'xyz_manhole', pos = Vector(778.84375, 4674.375, 545.59375), ang = Angle(-0.2581787109375, 55.134887695313, -0.1153564453125)},
		{ent = 'xyz_manhole', pos = Vector(8448.8125, 2753.3125, 1545.5), ang = Angle(0.252685546875, 120.60791015625, 0.120849609375)},
		{ent = 'g4s_npc', pos = Vector(-2790.03125, -1583.40625, 0), ang = Angle(0, 180, 0)},
		{ent = 'g4s_deposit', pos = Vector(7069.71875, 3146.78125, -1488.625), ang = Angle(-1.0272216796875, 0.0714111328125, 0.4779052734375)},
	},
	["map_name"] = {

	}
}

-- These should be used for plates that detect vehicles / player colliding on them
-- They should not be networked, any info the client needs will be networked via net.
local toNoDraw = {
	["ups_platform"] = true,
	["trucker_platform"] = true,
	["racing_platform"] = true,
	["xyz_patrol_waypoint_foot"] = true,
	["xyz_patrol_waypoint"] = true
}

hook.Add("InitPostEntity", "xyz_perma_start", function()
	local entsToSpawn = propsToSpawn[game.GetMap()]
	if !entsToSpawn then
		for i=1, 10 do
			print("[Perma Entities]", "There are no perma ents found for this map:", game.GetMap())
		end
		return
	end

	for k, v in pairs(entsToSpawn) do
		print("[Perma Entities]", "Spawning", v.ent, "at", v.pos)
		local ent = ents.Create(v.ent)
		print(ent)
		if not IsValid(ent) then continue end
		ent:SetPos(v.pos)
		ent:SetAngles(v.ang)
		if v.model then
			ent:SetModel(v.model)
		end
		if toNoDraw[v.ent] then
			ent:SetNoDraw(true)
		end
		ent:Spawn()
		local phys = ent:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableMotion(false)
		end
		if v.custom then
			v.custom(ent)
		end
	end
end)

concommand.Add("xyz_perma_world", function(ply, cmd, args)
	if not ply:IsSuperAdmin() then return end
	local target = ply:GetEyeTrace().Entity
	
	local worldEnt = ents.Create(target:GetClass())
	if not IsValid(worldEnt) then return end
	worldEnt:SetModel(target:GetModel())
	worldEnt:SetPos(target:GetPos())
	worldEnt:SetAngles(target:GetAngles())
	
	worldEnt:Spawn()
	worldEnt:GetPhysicsObject():EnableMotion(false)
	target:Remove()
end)