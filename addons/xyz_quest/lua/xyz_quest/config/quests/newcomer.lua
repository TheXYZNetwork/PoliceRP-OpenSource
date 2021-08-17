Quest.Config.Storylines["new_comer"] ={
	name = "New Comer",
	id = "new_comer",
	desc = "Welcome to the city, let me give you a hand in getting started!",
	quests = {
		[1] = {
			name = "Write a chat message",
			desc = "Introduce yourself to everyone with a chat message",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Browse your Server Settings",
			desc = "Access and browse the settings found in the 'S' button at the top of the chat box",
			clientProgress = true,
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Do an Emote",
			desc = "Access the Emote Wheel with F and do an Emote",
			clientProgress = true,
			func = function(ply, data)
				return true
			end
		},
		[4] = {
			name = "Open your phone",
			desc = "Open your phone with the up arrow",
			clientProgress = true,
			func = function(ply, data)
				return true
			end
		},
		[5] = {
			name = "Purchase a Medkit",
			desc = "Buy a Medkit from the Hospital",
			func = function(ply, data)
				return true
			end
		},
		[6] = {
			name = "Place the Medkit in your Locker",
			desc = "Go to the bank and put your Medkit in your Locker",
			func = function(ply, data)
				return true
			end,
			reward = function(ply)
				Quest.Core.GiveStoryline(ply, "boys_in_blue")
				Quest.Core.GiveStoryline(ply, "snoop_puppy")
				Quest.Core.GiveStoryline(ply, "joyrider")
				Quest.Core.GiveStoryline(ply, "trash_man")
				Quest.Core.GiveStoryline(ply, "rigged_elections")
				Quest.Core.GiveStoryline(ply, "life_of_crime")
			end
		},
	}
}

-- Write a chat message
hook.Add("PlayerSay", "Quest:Progress:new_comer", function(ply, text)
	Quest.Core.ProgressQuest(ply, "new_comer", 1)
end)
-- Purchase a Medkit
hook.Add("DoctorPurchaseEntity", "Quest:Progress:new_comer", function(ply, itemClass)
	if not (itemClass == "xyz_medkit") then return end
	Quest.Core.ProgressQuest(ply, "new_comer", 5)
end)
-- Move item to locker
hook.Add("Inventory.MoveToLocker", "Quest:Progress:new_comer", function(ply, itemClass)
	if not (itemClass == "xyz_medkit") then return end
	Quest.Core.ProgressQuest(ply, "new_comer", 6)
end)