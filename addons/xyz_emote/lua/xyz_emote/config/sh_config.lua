-- The addon color
Emote.Config.Color = Color(0, 132, 182)

-- The button to show the menu
Emote.Config.MenuKey = KEY_F

-- The weapon to switch to when starting an animation
Emote.Config.Weapon = "keys"

-- Animations
Emote.Config.Animations = {
	["surrender"] = {
		id = "surrender",
		name = "Surrender",
		icon = "emote_surrender",

		-- The option stuff
		loop = true, -- If the animation should loop or not.
		movementSpeed = 60 -- Their max move speed. Setting this to 0 blocks movement
	},
	["taunt_robot"] = {
		id = "taunt_robot",
		name = "Robot",
		icon = "emote_robot",

		movementSpeed = 0
	},
	["gesture_agree"] = {
		id = "gesture_agree",
		name = "Agree",
		icon = "emote_agree"
	},
	["pose_standing_01"] = {
		id = "pose_standing_01",
		name = "Badass",
		icon = "emote_badass",
		
		loop = true,
		movementSpeed = 0
	},
	["wos_fn_bestmates"] = {
		id = "wos_fn_bestmates",
		name = "Best Mates",
		icon = "emote_bestmates",

		movementSpeed = 120,
		loop = true
	},
	["wos_fn_boneless"] = {
		id = "wos_fn_boneless",
		name = "Boneless",
		icon = "emote_boneless",

		movementSpeed = 0
	},
	["gesture_bow"] = {
		id = "gesture_bow",
		name = "Bow",
		icon = "emote_bow"
	},
	["wos_fn_infinidab"] = {
		id = "wos_fn_infinidab",
		name = "Dab",
		icon = "emote_dab",

		movementSpeed = 0,
		loop = true
	},
	["death_04"] = {
		id = "death_04",
		name = "Death 1",
		icon = "emote_death_01",

		movementSpeed = 0
	},
	["gesture_disagree"] = {
		id = "gesture_disagree",
		name = "Disagree",
		icon = "emote_disagree"
	},
	["wos_fn_discofever"] = {
		id = "wos_fn_discofever",
		name = "Disco",
		icon = "emote_disco",
		
		loop = true,
		movementSpeed = 0
	},
	["wos_fn_floss"] = {
		id = "wos_fn_floss",
		name = "Floss",
		icon = "emote_floss",
		
		loop = true,
		movementSpeed = 0
	},
	["wos_fn_fresh"] = {
		id = "wos_fn_fresh",
		name = "Fresh",
		icon = "emote_fresh",
		
		movementSpeed = 0
	},
	["pose_standing_02"] = {
		id = "pose_standing_02",
		name = "Hands on Hip",
		icon = "emote_handsonhip",
		
		loop = true,
		movementSpeed = 0
	},
	["wos_fn_hype"] = {
		id = "wos_fn_hype",
		name = "Hype",
		icon = "emote_hype",

		movementSpeed = 0,
		loop = true
	},
	["taunt_laugh"] = {
		id = "taunt_laugh",
		name = "Laugh",
		icon = "emote_laugh",

		movementSpeed = 0
	},
	["gesture_salute"] = {
		id = "gesture_salute",
		name = "Salute",
		icon = "emote_salute"
	},
	["pose_ducking_02"] = {
		id = "pose_ducking_02",
		name = "Sit",
		icon = "emote_sit",

		movementSpeed = 0,
		loop = true
	},
	["wos_fn_takethel"] = {
		id = "wos_fn_takethel",
		name = "Take The L",
		icon = "emote_takethel",

		movementSpeed = 120,
		loop = true
	},
	["gesture_wave"] = {
		id = "gesture_wave",
		name = "Wave",
		icon = "emote_wave"
	},
	["sit_zen"] = {
		id = "sit_zen",
		name = "Zen",
		icon = "emote_zen",

		movementSpeed = 0,
		loop = true
	},
	["fingergun"] = {
		id = "fingergun",
		name = "Finger Gun",
		icon = "emote_fingergun",
	}, 
	["taunt_dance"] = {
		id = "taunt_dance",
		name = "Dance",
		icon = "emote_dance",

		movementSpeed = 0
	}, 
	["wos_fn_eagle"] = {
		id = "wos_fn_eagle",
		name = "Eagle",
		icon = "emote_eagle",

		movementSpeed = 0,
		loop = true
	}, 
	["smithbobspecial"] = {
		id = "smithbobspecial",
		name = "Smith Bob Special",
		icon = "emote_smithbobspecial",

		movementSpeed = 120,
		loop = true
	}, 
	["pose_ducking_01"] = {
		id = "pose_ducking_01",
		name = "Kneel",
		icon = "emote_kneel",

		movementSpeed = 0,
		loop = true
	}
}

if CLIENT then return end

hook.Add("PlayerInitialSpawn", "Emote:Default", function(ply)
	-- Wipe table
	Emote.Users[ply:SteamID64()] = {}

	-- The basic animations
	Emote.Core.GiveAnimation(ply, "surrender")
	Emote.Core.GiveAnimation(ply, "gesture_agree")
	Emote.Core.GiveAnimation(ply, "gesture_disagree")
	Emote.Core.GiveAnimation(ply, "pose_ducking_02")
	Emote.Core.GiveAnimation(ply, "gesture_salute")
	Emote.Core.GiveAnimation(ply, "taunt_dance")

	-- Rank emotes
	-- We wait a few seconds to let their rank load
	timer.Simple(10, function()
		-- Smith bob special
		if ply:SteamID64() == "76561198104867238" then
			Emote.Core.GiveAnimation(ply, "smithbobspecial")
		end
		-- Staff
		if ply:HasPower(95) then
			Emote.Core.GiveAnimation(ply, "wos_fn_fresh")
		end
		-- Staff
		if ply:IsStaff() then
			Emote.Core.GiveAnimation(ply, "fingergun")
		end
		-- VIP
		if ply:IsVIP() then
			Emote.Core.GiveAnimation(ply, "gesture_wave")
		end
		-- Elite
		if ply:IsElite() then
			Emote.Core.GiveAnimation(ply, "taunt_laugh")
		end
	end)
end)