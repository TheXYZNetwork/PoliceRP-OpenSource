ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Cadet Training NPC"
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
ENT.Config.Team = TEAM_POFFICER
ENT.Config.Training = "https://docs.google.com/document/d/19roAE8mG_3axYYxpP5DQW-4z1Tqi26P154NAf777whI"
ENT.Config.Whitelist = "policeofficer"
ENT.Config.Webhook = "pd_exam"
ENT.Config.DInvite = "vSRxCRX"
ENT.Config.Questions = {
	[1] = {
		Question = "What does PTS stand for?",
		Answers = {
			[1] = "Permission to slap",
			[2] = "Permission to stop",
			[3] = "Permission to speak"
		},
		CorrectAnswer = 3
	},
	[2] = {
		Question = "At which rank can you join Sub Departments?",
		Answers = {
			[1] = "Lance Corporal",
			[2] = "Corporal",
			[3] = "Sergeant"
		},
		CorrectAnswer = 2
	},
	[3] = {
		Question = "What do you do during a bank raid?",
		Answers = {
			[1] = "Set up roadblocks",
			[2] = "Run in, lets get em bois!",
			[3] = "Shout BANK RAID over radio and drive away"
		},
		CorrectAnswer = 1
	},
	[4] = {
		Question = "What does 10-4 mean?",
		Answers = {
			[1] = "Shut Up",
			[2] = "Clear comms",
			[3] = "OK"
		},
		CorrectAnswer = 3
	},
	[5] = {
		Question = "What do you do in a traffic stop?",
		Answers = {
			[1] = "Pull out a gun and shoot them",
			[2] = "Pull up behind them, go to their window and proceed as normal",
			[3] = "Ram them until their car explodes"
		},
		CorrectAnswer = 2
	},
	[6] = {
		Question = "If an officer disrespects you in any way, what would you do?",
		Answers = {
			[1] = "Shoot them",
			[2] = "Report them to a higher up",
			[3] = "Disrespect them back"
		},
		CorrectAnswer = 2
	},
	[7] = {
		Question = "When arresting someone, what would you do?",
		Answers = {
			[1] = "Jail them straight away",
			[2] = "Shoot them",
			[3] = "Read them their rights and jail them"
		},
		CorrectAnswer = 3
	},
	[8] = {
		Question = "When do you read the miranda rights?",
		Answers = {
			[1] = "When you fine someone",
			[2] = "When you baton someone",
			[3] = "When you are arresting someone"
		},
		CorrectAnswer = 3
	},
}
ENT.Config.AmountCorrectToPass = 7