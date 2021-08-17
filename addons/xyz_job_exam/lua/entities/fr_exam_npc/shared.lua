ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "F&R Training NPC"
ENT.Author = "Smith Bob"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.AutomaticFrameAdvance = true
 
function ENT:SetAutomaticFrameAdvance( UsingAnim )
	self.AutomaticFrameAdvance = UsingAnim
end

ENT.Chances = {}

ENT.Config = {}
ENT.Config.LimitToJob = nil
ENT.Config.Team = TEAM_FR_CF
ENT.Config.Training = "https://docs.google.com/document/d/1EdiefA4UVLxuG2LI3JF9IKVEIxBsFlINFJsC6JuPBV4"
ENT.Config.Whitelist = "frcf"
ENT.Config.Webhook = "fr_exam"
ENT.Config.DInvite = "fK7tvYn8SG"
ENT.Config.Questions = {
	[1] = {
		Question = "What is a defibrillator used for?",
		Answers = {
			[1] = "Reviving a person",
			[2] = "Healing a person",
			[3] = "Giving someone an electric shock"
		},
		CorrectAnswer = 1
	},
	[2] = {
		Question = "At which rank can you use the Ambulance?",
		Answers = {
			[1] = "Candidate Firefighter",
			[2] = "Deputy Chief",
			[3] = "Firefighter"
		},
		CorrectAnswer = 3
	},
	[3] = {
		Question = "When do fires start spawning?",
		Answers = {
			[1] = "When there's 20 people on",
			[2] = "When 3 Fire & Rescue are on",
			[3] = "When a high ranking member turns them on"
		},
		CorrectAnswer = 2
	},
	[4] = {
		Question = "When do you enter a scene such as a bank or PD Raid?",
		Answers = {
			[1] = "When the shooting has stopped",
			[2] = "When everything looks safe",
			[3] = "When a government official declares it clear or Code 4"
		},
		CorrectAnswer = 3
	},
	[5] = {
		Question = "Can you block off traffic?",
		Answers = {
			[1] = "No",
			[2] = "Yes"
		},
		CorrectAnswer = 1
	},
}
ENT.Config.AmountCorrectToPass = 5