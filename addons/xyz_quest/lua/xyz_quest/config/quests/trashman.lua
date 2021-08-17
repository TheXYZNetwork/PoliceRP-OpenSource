Quest.Config.Storylines["trash_man"] ={
	name = "Trash Man",
	id = "trash_man",
	desc = "Hard work always pays off",
	quests = {
		[1] = {
			name = "Become a Trash Collector",
			desc = "Become a Trash Collector from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[2] = {
			name = "Purchase a Trash Burner",
			desc = "Purchase a Trash Burner from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[3] = {
			name = "Burn 50KG of trash",
			desc = function(data) return string.format("Burn 50KG of trash. You have burned %iKG/50KG", tonumber(data) or 0) end,
			func = function(ply, data, increase)
				local burned = data or 0
				burned = burned + increase

				return (burned >= 50), burned, true
			end
		},
		[4] = {
			name = "Purchase a Trash Recycler",
			desc = "Purchase a Trash Recycler from the F4 menu",
			func = function(ply, data)
				return true
			end
		},
		[5] = {
			name = "Recycle 50KG of trash",
			desc = function(data) return string.format("Recycle 50KG of trash. You have recycled %iKG/50KG", tonumber(data) or 0) end,
			func = function(ply, data, increase)
				local recyled = data or 0
				recyled = recyled + increase

				return (recyled >= 50), recyled, true
			end,
			reward = function(ply)
				Quest.Core.GiveStoryline(ply, "minecraft")
				Quest.Core.GiveStoryline(ply, "delivery_boy")
				Quest.Core.GiveStoryline(ply, "he_fix_it_falafel")
				Quest.Core.GiveStoryline(ply, "news")
			end
		},
	}
}

-- Become a trash collector
hook.Add("PlayerChangedTeam", "Quest:Progress:trash_man", function(ply, oldTeam, newTeam)
	if not (newTeam == TEAM_TRASHCOLLECTOR) then return end

	Quest.Core.ProgressQuest(ply, "trash_man", 1)
end)
-- Purchase a Trash Burner
hook.Add("playerBoughtCustomEntity", "Quest:Progress:trash_man", function(ply, entTable, ent)
	if (ent:GetClass() == "xyz_trashburner") then
		Quest.Core.ProgressQuest(ply, "trash_man", 2)
	elseif (ent:GetClass() == "xyz_trashrecycler") then
		Quest.Core.ProgressQuest(ply, "trash_man", 4)
	end
end)