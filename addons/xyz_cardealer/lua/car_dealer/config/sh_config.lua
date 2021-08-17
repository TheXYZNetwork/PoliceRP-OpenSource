CarDealer.Config.Cars = {}

--list.Get("Vehicles")
local function addCar(class, category, price, sellable, restricted, block)
	local car = list.Get("Vehicles")[class]
	if not car then return end
	CarDealer.Config.Cars[class] = {
		name = car.Name,
		class = class,
		model = car.Model,
		category = category,
		price = price,
		sellable = sellable,
		restricted = restricted,
		script = car.KeyValues.vehiclescript,
		block = block or {skins = {}, bodygroups = {}}
	}
end


-- Name, 		section, 	price, 	sellable, 	restriction, 					isvip, 		package
--addCar("",		"",			0,		true,		function(ply) return true end,	false)
--addCar("",		"",			0,		true,		function(ply) return (ply:GetUserGroup() == "vip" or ply:IsSecondaryUserGroup( "vip" )) end,	true, 		"vip")
--(ply:GetUserGroup() == "vip" or ply:IsSecondaryUserGroup( "vip" ))

--
-- User
-- 
-- If a block is given it must be formatted with both a skin and bodygroup field. Example:
/*
{skins = {2, 5, 6}, bodygroups = {["front bumper"] = {1}}}
*/
-- Alternatively you can just pass true for a bodygroup and block all elements for that section
addCar("volvo_s60", "Volvo", 400000, true, function(ply) return true end)
addCar("zentornogtav", "Other", 12000000, true, function(ply) return true end)
addCar("rebelgtav", "Other", 350000, true, function(ply) return true end)
addCar("futogtav", "Other", 35000, true, function(ply) return true end)
addCar("alfa_giuliettatdm", "Alfa Romeo", 100000, true, function(ply) return true end)
addCar("bowlexrstdm", "Bowler", 300000, true, function(ply) return true end)
addCar("che_blazertdm", "Chevrolet", 40000, true, function(ply) return true end)
addCar("che_c10tdm", "Chevrolet", 40000, true, function(ply) return true end)
addCar("che_camarozl1tdm", "Chevrolet", 750000, true, function(ply) return true end)
addCar("che_stingray427tdm", "Chevrolet", 300000, true, function(ply) return true end)
addCar("che_impala96tdm", "Chevrolet", 20000, true, function(ply) return true end)
addCar("che_sparktdm", "Chevrolet", 55000, true, function(ply) return true end)
addCar("f100tdm", "Ford", 45000, true, function(ply) return true end)
addCar("coupe40tdm", "Ford", 50000, true, function(ply) return true end)
addCar("focusrstdm", "Ford", 25000, true, function(ply) return true end)
addCar("for_she_gt500tdm", "Ford", 1000000, true, function(ply) return true end)
addCar("hsvgtstdm", "Holdon", 100000, true, function(ply) return true end)
addCar("hsvw427tdm", "Holdon", 150000, true, function(ply) return true end)
addCar("civic97tdm", "Honda", 15000, true, function(ply) return true end)
addCar("hon_crxsirtdm", "Honda", 25000, true, function(ply) return true end)
addCar("grandchetdm", "Jeep", 3000000, true, function(ply) return true end)
addCar("speed3tdm", "Mazda", 350000, true, function(ply) return true end)
addCar("rx7tdm", "Mazda", 300000, true, function(ply) return true end)
addCar("mx5tdm", "Mazda", 250000, true, function(ply) return true end)
addCar("clubmantdm", "Mini Cooper", 475000, true, function(ply) return true end)
addCar("cooper65tdm", "Mini Cooper", 7500000, true, function(ply) return true end)
addCar("mitsu_eclipgttdm", "Mitsubishi", 450000, true, function(ply) return true end)
addCar("tesmodelstdm", "Tesla", 1000000, true, function(ply) return true end)
addCar("toyfjtdm", "Toyota", 300000, true, function(ply) return true end)
addCar("mr2gttdm", "Toyota", 350000, true, function(ply) return true end)
addCar("toyrav4tdm", "Toyota", 175000, true, function(ply) return true end)
addCar("242turbotdm", "Volvo", 20000, true, function(ply) return true end)
addCar("vol850rtdm", "Volvo", 25000, true, function(ply) return true end)
addCar("vols60tdm", "Volvo", 100000, true, function(ply) return true end)
addCar("volxc70tdm", "Volvo", 150000, true, function(ply) return true end)
addCar("volxc90tdm", "Volvo", 150000, true, function(ply) return true end)
addCar("918spydtdm", "Porsche", 3500000, true, function(ply) return true end)
addCar("997gt3tdm", "Porsche", 1750000, true, function(ply) return true end)
addCar("cayenne12tdm", "Porsche", 600000, true, function(ply) return true end)
addCar("350ztdm", "Nissan", 500000, true, function(ply) return true end)
addCar("nis_leaftdm", "Nissan", 10000000, true, function(ply) return true end)
addCar("nissilvs15tdm", "Nissan", 80000, true, function(ply) return true end)
addCar("diablotdm", "Lamborghini", 900000, true, function(ply) return true end)
addCar("gallardotdm", "Lamborghini", 800000, true, function(ply) return true end)
addCar("fer_250gtotdm", "Ferrari", 800000, true, function(ply) return true end)
addCar("fer_512trtdm", "Ferrari", 999000, true, function(ply) return true end)
addCar("ferf430tdm", "Ferrari", 2500000, true, function(ply) return true end)
addCar("fer_f50tdm", "Ferrari", 1350000, true, function(ply) return true end)
addCar("audir8tdm", "Audi", 1200000, true, function(ply) return true end)
addCar("rs4avanttdm", "Audi", 680000, true, function(ply) return true end)
addCar("auds4tdm", "Audi", 500000, true, function(ply) return true end)
addCar("auds5tdm", "Audi", 450000, true, function(ply) return true end)
addCar("auditttdm", "Audi", 675000, true, function(ply) return true end)
addCar("crsk_ford_bronco_1982", "Ford", 178000, true, function(ply) return true end)
addCar("syclonetdm", "GMC", 78000, true, function(ply) return true end)

--
-- VIP
-- 

addCar("h1tdm", "Hummer", 1300000, true, function(ply) return (ply:IsVIP()) end)
addCar("alfa_stradaletdm", "Alfa Romeo", 450000, true, function(ply) return (ply:IsVIP()) end)
addCar("veyrontdm", "Bugatti", 1200000, true, function(ply) return false end)
addCar("eb110tdm", "Bugatti", 1000000, true, function(ply) return false end)
addCar("che_69camarotdm", "Chevrolet", 350000, true, function(ply) return (ply:IsVIP()) end)
addCar("che_chevellesstdm", "Chevrolet", 250000, true, function(ply) return (ply:IsVIP()) end)
addCar("for_focus_rs16tdm", "Ford", 850000, true, function(ply) return (ply:IsVIP()) end)
addCar("focussvttdm", "Ford", 40000, true, function(ply) return (ply:IsVIP()) end)
addCar("transittdm", "Ford", 75000, true, function(ply) return (ply:IsVIP()) end)
addCar("civictypertdm", "Honda", 45000, true, function(ply) return (ply:IsVIP()) end)
addCar("s2000tdm", "Honda", 100000, true, function(ply) return (ply:IsVIP()) end)
addCar("wranglertdm", "Jeep", 100000, true, function(ply) return (ply:IsVIP()) end)
addCar("coopercoupetdm", "Mini Cooper", 500000, true, function(ply) return (ply:IsVIP()) end)
addCar("coopers11tdm", "Mini Cooper", 500000, true, function(ply) return (ply:IsVIP()) end)
addCar("colttdm", "Mitsubishi", 400000, true, function(ply) return (ply:IsVIP()) end)
addCar("mit_eclipsegsxtdm", "Mitsubishi", 400000, true, function(ply) return (ply:IsVIP()) end)
addCar("scionfrstdm", "Scion", 850000, true, function(ply) return (ply:IsVIP()) end)
addCar("sciontctdm", "Scion", 250000, true, function(ply) return (ply:IsVIP()) end)
addCar("scionxdtdm", "Scion", 30000, true, function(ply) return (ply:IsVIP()) end)
addCar("priustdm", "Toyota", 400000, true, function(ply) return (ply:IsVIP()) end)
addCar("c12tdm", "Porsche", 2500000, true, function(ply) return (ply:IsVIP()) end)
addCar("carreragttdm", "Porsche", 1500000, true, function(ply) return (ply:IsVIP()) end)
addCar("cayennetdm", "Porsche", 600000, true, function(ply) return (ply:IsVIP()) end)
addCar("370ztdm", "Nissan", 600000, true, function(ply) return (ply:IsVIP()) end)
addCar("r34tdm", "Nissan", 4000000, true, function(ply) return (ply:IsVIP()) end)
addCar("miuracontdm", "Lamborghini", 1500000, true, function(ply) return (ply:IsVIP()) end)
addCar("miurap400tdm", "Lamborghini", 1500000, true, function(ply) return (ply:IsVIP()) end)
addCar("murcielagotdm", "Lamborghini", 2000000, true, function(ply) return (ply:IsVIP()) end)
addCar("fer_enzotdm", "Lamborghini", 1700000, true, function(ply) return (ply:IsVIP()) end)
addCar("audir8tdm", "Audi", 1560000, true, function(ply) return (ply:IsVIP()) end)
addCar("crsk_wmotors_fenyr_ss", "Other", 6500000, true, function(ply) return (ply:IsVIP()) end)
addCar("toytundratdm", "Toyota", 340000, true, function(ply) return (ply:IsVIP()) end)
addCar("sierralowtdm", "GMC", 110000, true, function(ply) return (ply:IsVIP()) end)

--
-- Elite
--

addCar("tractorgtav", "Other", 20000000, true, function(ply) return (ply:IsElite()) end)
addCar("h1opentdm", "Hummer", 1000000, true, function(ply) return (ply:IsElite()) end)
addCar("veyronsstdm", "Bugatti", 5000000, true, function(ply) return false end)
addCar("che_corv_gsctdm", "Chevrolet", 1500000, true, function(ply) return (ply:IsElite()) end)
addCar("deloreantdm", "Other", 3500000, true, function(ply) return (ply:IsElite()) end)
addCar("gt05tdm", "Ford", 1250000, true, function(ply) return (ply:IsElite()) end)
addCar("mustanggttdm", "Ford", 800000, true, function(ply) return (ply:IsElite()) end)
addCar("wrangler_fnftdm", "Jeep", 6000000, true, function(ply) return (ply:IsElite()) end, {skins = {2, 5, 6}, bodygroups = {["front bumper"] = {1}}})
addCar("jeewillystdm", "Jeep", 4000000, true, function(ply) return (ply:IsElite()) end)
addCar("wrangler88tdm", "Jeep", 350000, true, function(ply) return (ply:IsElite()) end)
addCar("furaitdm", "Mazda", 15000000, true, function(ply) return (ply:IsElite()) end)
addCar("xbowtdm", "KTM", 3500000, true, function(ply) return (ply:IsElite()) end)
addCar("morgaerosstdm", "Other", 10000000, true, function(ply) return (ply:IsElite()) end)
addCar("mitsu_evo8tdm", "Other", 175000, true, function(ply) return (ply:IsElite()) end)
addCar("noblem600tdm", "Other", 8000000, true, function(ply) return (ply:IsElite()) end)
addCar("zondagrtdm", "Pagani", 12500000, true, function(ply) return (ply:IsElite()) end)
addCar("c12tdm", "Pagani", 11500000, true, function(ply) return (ply:IsElite()) end)
addCar("supratdm", "Toyota", 4000000, true, function(ply) return (ply:IsElite()) end)
addCar("st1tdm", "Other", 4000000, true, function(ply) return (ply:IsElite()) end)
addCar("porgt3rsrtdm", "Porsche", 4500000, true, function(ply) return (ply:IsElite()) end)
addCar("gtrtdm", "Nissan", 6000000, true, function(ply) return (ply:IsElite()) end)
addCar("gallardospydtdm", "Lamborghini", 3000000, true, function(ply) return (ply:IsElite()) end)
addCar("murcielagosvtdm", "Lamborghini", 2500000, true, function(ply) return (ply:IsElite()) end)
addCar("reventonrtdm", "Lamborghini", 3000000, true, function(ply) return (ply:IsElite()) end)
addCar("fer_250gttdm", "Ferrari", 2000099, true, function(ply) return (ply:IsElite()) end)
addCar("fer_458spidtdm", "Ferrari", 2200000, true, function(ply) return (ply:IsElite()) end)
addCar("ferf12tdm", "Ferrari", 3800000, true, function(ply) return (ply:IsElite()) end)
addCar("fer_lafertdm", "Ferrari", 8888888, true, function(ply) return (ply:IsElite()) end)
addCar("audir8plustdm", "Audi", 1750000, true, function(ply) return (ply:IsElite()) end)
addCar("smc_mustang_gt_15", "Ford", 2750000, true, function(ply) return (ply:IsElite()) end)
addCar("lam_huracan_lw", "Lamborghini", 5500000, true, function(ply) return (ply:IsElite()) end)
addCar("sierratdm", "GMC", 430000, true, function(ply) return (ply:IsElite()) end)
addCar("raptorsvttdm", "Ford", 720000, true, function(ply) return (ply:IsElite()) end)
addCar("f350tdm", "Ford", 580000, true, function(ply) return (ply:IsElite()) end)

--
-- Special cars
--

addCar("crsk_mclaren_senna_2019", "Mclaren", 0, false, function(ply) return false end)
addCar("crsk_rolls-royce_phantom_viii_2018", "Rolls Royce", 0, false, function(ply) return false end)
addCar("crsk_chevrolet_corvette_c1_1957", "Chevrolet", 0, false, function(ply) return false end)
addCar("crsk_aston_db11_2017", "Aston Martin", 0, false, function(ply) return false end)
addCar("kuruma_sgm", "Sedan", 0, false, function(ply) return false end)
addCar("spacecar_sgm", "Other", 0, false, function(ply) return false end)
addCar("lego_f40", "Ferrari", 0, false, function(ply) return false end)
addCar("campergtav", "Other", 0, false, function(ply) return false end)
addCar("golfcart_sgm", "Other", 0, false, function(ply) return false end)
addCar("atv_buggy", "Other", 0, false, function(ply) return false end)
addCar("hot_twinmill_lw", "Other", 0, false, function(ply) return false end)
addCar("lego_senna", "Mclaren", 0, false, function(ply) return false end)
addCar("rcars_patty_wagon2", "Other", 0, false, function(ply) return false end)
addCar("porcycletdm", "Porsche", 0, false, function(ply) return false end)
addCar("polaris_6x6_lw", "Other", 0, false, function(ply) return false end)
addCar("lotus_exiges_roadster_lw", "Other", 0, false, function(ply) return false end)
addCar("electric_gokart", "Other", 0, false, function(ply) return false end)
addCar("polaris_4x4_lw", "Other", 0, false, function(ply) return false end)
addCar("crsk_dodge_charger_srt_hellcat_2015", "Dodge", 0, false, function(ply) return false end)


addCar("caterham_r500_superlight_lw", "Caterham", 0, false, function(ply) return false end)
addCar("bentley_blower_lw", "Bentley", 0, false, function(ply) return false end)
addCar("suzuki_kingquad_lw", "Suzuki", 0, false, function(ply) return false end)
addCar("crsk_jawa_350_634", "Other", 0, false, function(ply) return false end)
addCar("gauntletgtav", "Other", 0, false, function(ply) return false end)
addCar("mesa3gtav", "Other", 0, false, function(ply) return false end)
addCar("airtugtdm", "Other", 0, false, function(ply) return false end)
addCar("dodge_daytona", "Dodge", 0, false, function(ply) return false end)
addCar("15camaro_sgm", "Chevrolet", 0, false, function(ply) return false end)
addCar("cybertruck_sgm", "Tesla", 0, false, function(ply) return false end)
addCar("modelt_sgm", "Ford", 0, false, function(ply) return false end)
addCar("jm_caddylimo", "Other", 0, false, function(ply) return false end)
addCar("ctv_bugatti_divo", "Bugatti", 0, false, function(ply) return false end)
addCar("crsk_landrover_series_IIa_stationwagon", "Bugatti", 0, false, function(ply) return false end)
addCar("crsk_rolls-royce_dawn", "Rolls Royce", 0, false, function(ply) return false end)
addCar("gmcvantdm", "GMC", 0, false, function(ply) return false end)
addCar("djm_mercedes_slr_stirling_moss", "Mercedes", 0, false, function(ply) return false end, false)
addCar("mclaren_mp4x", "Mclaren", 0, false, function(ply) return false end, false)



addCar("cooper4x4tdm", "Mini", 0, false, function(ply) return false end)
addCar("rv", "Other", 0, false, function(ply) return false end)
addCar("l4dapc_sgm", "Other", 0, false, function(ply) return false end)
addCar("addergtav", "Other", 0, false, function(ply) return false end)

-- Addon color
CarDealer.Config.Color = Color(100, 20, 40)

-- Sell % (1=100%, 0=0%)
CarDealer.Config.SellBack = 0.7

-- Spawn protection (seconds)
CarDealer.Config.SpawnProtection = 3

-- Max return distance
CarDealer.Config.ReturnDistance = 2000

-- Vehicle cam pos
CarDealer.Config.VehPos = Vector(-841.713989, 2479.703613, -2150)
CarDealer.Config.VehAng = Angle(0, 90, 0)

-- Damage needed to kill the engine
CarDealer.Config.KillEngineDamage = 100

-- The max amount of cars you can have in your garage
CarDealer.Config.GarageSize = function(ply)
	return 30
end

-- The max amount of cars you can have in your garage
CarDealer.Config.RepairCost = function(ply)
	return 30000
end

-- The spawn pads
CarDealer.Config.Spawns = {
	{
		pos = Vector(-4403, -1232, 65),
		ang = Angle(0, 0, 0)
	},
	{
		pos = Vector(-4557, -1232, 65),
		ang = Angle(0, 0, 0)
	},
	{
		pos = Vector(-4724, -1232, 65),
		ang = Angle(0, 0, 0)
	},
	{
		pos = Vector(-4872, -1232, 65),
		ang = Angle(0, 0, 0)
	},
	{
		pos = Vector(-5026, -1232, 65),
		ang = Angle(0, 0, 0)
	},
	{
		pos = Vector(-5508, -1232, 65),
		ang = Angle(0, 0, 0)
	},
	{
		pos = Vector(-5662, -1232, 65),
		ang = Angle(0, 0, 0)
	},
	{
		pos = Vector(-5835, -1232, 65),
		ang = Angle(0, 0, 0)
	},
	{
		pos = Vector(-5995, -1232, 65),
		ang = Angle(0, 0, 0)
	},
	{
		pos = Vector(-6153, -1232, 65),
		ang = Angle(0, 0, 0)
	}
}

CarDealer.Config.Price = {}
-- Used to give ranks discounts
CarDealer.Config.Price.Vehicle = function(ply, basePrice)
	return basePrice
end

-- Cost for a color change (Per bodygroup)
CarDealer.Config.Price.Color = function(ply)
	return 10000
end
-- Cost for a bodygroup change (Per bodygroup)
CarDealer.Config.Price.Bodygroup = function(ply)
	return 5000
end
-- Cost for a skin change 
CarDealer.Config.Price.Skin = function(ply)
	return 15000
end


CarDealer.Config.Mods = {}
CarDealer.Config.Mods['alarm'] = {
	name = "Alarm",
	price = function(ply)
		return 30000
	end,
	spawnAction = function(car)
		car.CarDealerAlarm = true
	end
}
-- Car alarms
sound.Add({name = "car_alarm", channel = CHAN_STREAM, volume = 1, level = 100, pitch = { 95, 110 }, sound = "ambient/levels/labs/teleport_alarm_loop1.wav"})
hook.Add("onLockpickCompleted", "CarDealer:CarAlarm", function(ply, bool, ent)
	if CLIENT then return end

	if (not ent:IsVehicle()) or (not bool) then return end
	if not ent.CarDealerAlarm then return end

	ent:EmitSound("car_alarm")
	ent:VC_setHazardLights(true)
	ent:VC_setHighBeams(true)
	ent:VC_setFogLights(true)
	ent:VC_setRunningLights(true)
	PNC.Core.StolenVehicles[ent:EntIndex()] = {true, ply}
	timer.Simple(20, function()
		if IsValid(ent) then
			ent:StopSound("car_alarm")
			ent:VC_setHazardLights(false)
			ent:VC_setHighBeams(false)
			ent:VC_setRunningLights(false)
			ent:VC_setFogLights(falsecaw)
		end
	end)
end)

CarDealer.Config.Mods['tracker'] = {
	name = "Tracker",
	price = function(ply)
		return 50000
	end,
	spawnAction = function(car, ply)
		XYZShit.ApplyTracker(car, ply)
	end
}
CarDealer.Config.Mods['radio'] = {
	name = "Radio",
	price = function(ply)
		return 30000
	end,
	spawnAction = function(car)
		car:SetNWBool("CarDealer:Radio", true)
	end
}

CarDealer.Config.Performance = {}
CarDealer.Config.Performance['armour'] = {
	name = "Armour",
	options = {
		{
			name = "20%",
			val = 20,
			price = 100000
		},
		{
			name = "40%",
			val = 40,
			price = 150000
		},
		{
			name = "60%",
			val = 60,
			price = 200000
		},
		{
			name = "80%",
			val = 80,
			price = 250000
		},
		{
			name = "100%",
			val = 100,
			price = 300000
		}
	},
	spawnAction = function(car, val)
		local healthMax = car:VC_getHealthMax()
		local newHealth = healthMax*(tonumber(val)/100)

		car:VC_setHealthMax(healthMax+newHealth)
		car:VC_setHealth(healthMax+newHealth)
	end
}
CarDealer.Config.Performance['puncture_prevention'] = {
	name = "Puncture Prevention",
	options = {
		{
			name = "10%",
			val = 10,
			price = 100000
		},
		{
			name = "15%",
			val = 15,
			price = 200000
		},
		{
			name = "20%",
			val = 20,
			price = 300000
		}
	},
	spawnAction = function(car, val)
		car.CarDealerPunctionPrevention = val
	end
}
hook.Add("VC_canDamagePart", "CarDealer:PunctionPrevention", function(ent, class)
	if not (class == "wheel") then return end
	if not ent.CarDealerPunctionPrevention then return end
	
	local chance = math.random(0, 100)
	if chance <= ent.CarDealerPunctionPrevention then return end
end)