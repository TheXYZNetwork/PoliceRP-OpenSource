TicketBook.Config.Color = Color(200, 100, 40)
TicketBook.Config.Distribute = 0.5 -- Percentage to distribute to the officer (the rest will go to Gov Funds)
TicketBook.Config.Reasons = {
	{name = "Speeding (5-10 mph over limit)", ticket = 1000, points = 0},
	{name = "Speeding (10-15 mph over limit)", ticket = 2500, points = 0},
	{name = "Speeding (15-20 mph over limit)", ticket = 5000, points = 1},
	{name = "Speeding (20+ mph over limit)", ticket = 10000, points = 2},
	{name = "Reckless Driving", ticket = 7500, points = 1},
	{name = "Careless Driving", ticket = 7500, points = 0},
	{name = "Failure to Stop", ticket = 5000, points = 0},
	{name = "Failure to Yield", ticket = 5000, points = 0},
	{name = "Road Rage", ticket = 5000, points = 0},
	{name = "Jaywalking", ticket = 100, points = 0},
	{name = "Illegal Parking", ticket = 1000, points = 1},
	{name = "Excessive Use of a Vehicle's Horn", ticket = 2500, points = 1},
	{name = "Brandishing a firearm with a license", ticket = 5000, points = 0},
	{name = "Wearing a Mask", ticket = 10000, points = 0},
	{name = "Failure to Maintain Lanes", ticket = 4000, points = 0},
	{name = "Failing to use Turn Signals", ticket = 1000, points = 0},
	{name = "Illegal U-turn", ticket = 3000, points = 0},
	{name = "Vandalism", ticket = 25000, points = 0},
}

TicketBook.Config.MaxTicketTotalSize = 50000

-- {name = "Violation Name", ticket = Price in number, points = Points in number},