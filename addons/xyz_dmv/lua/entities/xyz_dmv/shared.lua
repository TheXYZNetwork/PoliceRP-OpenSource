-- More basic setup
ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "DMV"
ENT.Author = "Owain Owjo"
ENT.Category = "The XYZ Network Custom Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true

ENT.Questions = {}
ENT.Questions[1] = {
	q = "You pull up to a red light",
	o = {
		[1] = "You go",
		[2] = "You get out",
		[3] = "You stop"
	},
	a = 3
}
ENT.Questions[2] = {
	q = "An officer pulls you over",
	o = {
		[1] = "Drive away as fast as you can.",
		[2] = "You pull over at the next safe curb.",
		[3] = "Keep on driving, he must be after someone else."
	},
	a = 2
}
ENT.Questions[3] = {
	q = "You have crashed into another car",
	o = {
		[1] = "Get out and exchange information.",
		[2] = "Drive away, aint no body got time for that.",
		[3] = "How dare he hit your car, pull out a gun and shoot him."
	},
	a = 1
}
ENT.Questions[4] = {
	q = "You come across a roadblock",
	o = {
		[1] = "Sit and wait for the roadblock to clear.",
		[2] = "Make a safe U turn, leave the roadblock and go round.",
		[3] = "Attempt to drive through the roadblock." 
	},
	a = 2
}
ENT.Questions[5] = {
	q = "Someone tries to force you out your car",
	o = {
		[1] = "Fight back and attempt to disarm him.",
		[2] = "Let them take the car, calling the police when it is safe.",
		[3] = "Floor it, he's probably a bad aim."
	},
	a = 2
}
ENT.Questions[6] = {
	q = "You pull up to a police checkpoint",
	o = {
		[1] = "Wait untill you are called into a bay, following the instructions of the officer.",
		[2] = "Ram through the checkpoint, hitting everything in the process.",
		[3] = "Do an illegal U turn and drive away."
	},
	a = 1
}
ENT.Questions[7] = {
	q = "There is a reckless driver in front of you",
	o = {
		[1] = "Call the police and inform them of the driver.",
		[2] = "Ram the car, attempting to stop yourself.",
		[3] = "Shout out the window 'wanker' as you speed past him."
	},
	a = 1
}
ENT.Questions[8] = {
	q = "You've crashed and injured yourself",
	o = {
		[1] = "Sit on the road screaming.",
		[2] = "Call EMS.",
		[3] = "Cry and die."
	},
	a = 2
}
ENT.Questions[9] = {
	q = "You see an officer break a traffic law",
	o = {
		[1] = "Attempt to pull him over.",
		[2] = "Drive past and scream 'pig'.",
		[3] = "Report it to IA."
	},
	a = 3
}
ENT.Questions[10] = {
	q = "A police pursuit passes you",
	o = {
		[1] = "Pull to the side, waiting for all cars to pass.",
		[2] = "Continue driving, they can wait.",
		[3] = "Attempt to help the police and ram the car."
	},
	a = 1
}

-- You've crashed and injured yourself
--