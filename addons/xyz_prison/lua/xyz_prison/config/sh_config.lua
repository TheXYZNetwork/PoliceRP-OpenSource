-- The chat and UI colors
PrisonSystem.Config.Color = Color(209, 134, 21)

hook.Add("loadCustomDarkRPItems", "PrisonSystem:LoadingConfig", function()
	-- The job that is used as prisoner
	PrisonSystem.Config.Prisoner = TEAM_PRISONER
end)

-- Ignore this
PrisonSystem.Config.RandomItem = {"xyz_prison_spoon", "csgo_stiletto", "xyz_prison_lockpick"}


PrisonSystem.Config.Prisoner = TEAM_PRISONER
PrisonSystem.Config.JailPositions = {
	Vector(-7165.295410, -5544.998047, -1400.968750),
	Vector(-7168.065918, -5766.768066, -1400.968750),
	Vector(-7608.265137, -5763.933594, -1400.968750),
	Vector(-7616.091309, -5541.776855, -1400.968750),
}

PrisonSystem.Config.EscapePositions = {
	Vector(-7526.321777, -4440.586426, 132.226776),
	Vector(-8675.111328, -4760.665527, 124.110832),
	Vector(-10036.241211, -5877.327637, 120.006287),
	Vector(-8522.936523, -7754.321289, 121.161781),
	Vector(-5965.022461, -5432.393555, 143.215729)
}



-- How long to add to their sentence if they're arrested while still a prisoner
PrisonSystem.Config.EscapeTimeout = 60 * 5
-- How long before the escape hole despawns?
PrisonSystem.Config.EscapeTimeout = 180
-- Min/max amount of progress makeable with each dig (100 = finished)
PrisonSystem.Config.EscapeProgressMin = 20
PrisonSystem.Config.EscapeProgressMax = 30
-- Placement level
PrisonSystem.Config.EscapeLevel = -1408
-- Change of the spoon breaking (max 10. 10 = 100%, 5 = 50%, 1 = 10%)
PrisonSystem.Config.EscapeBreakChance = 4
-- Change of finding the spoon when searching a box (max 10. 10 = 100%, 5 = 50%, 1 = 10%)
PrisonSystem.Config.EscapeFindChance = 2
-- Min and max of a box search cooldown
PrisonSystem.Config.EscapeBoxMin = 60
PrisonSystem.Config.EscapeBoxMax = 90

-- Ignore this
PrisonSystem.Config.Jobs = {}
PrisonSystem.Config.Jobs['laundry'] = "Laundry"
PrisonSystem.Config.Jobs['maintenance'] = "Maintenance"
PrisonSystem.Config.Jobs['cook'] = "Cooking"

-- Laundry Config
PrisonSystem.Config.Laundry = {}
-- Cart hold limit
PrisonSystem.Config.Laundry.CartLimit = 5
-- Washing Machine hold limit
PrisonSystem.Config.Laundry.WashingMachineLimit = 10
-- Washing Machine wash time (How long it takes to wash)
PrisonSystem.Config.Laundry.WashingMachineTime = 20
-- Washing Machine payout per item of clothing
PrisonSystem.Config.Laundry.WashingMachinePayout = 100
PrisonSystem.Config.Laundry.ClothePositions = {
	{pos = Vector(8389.25, 7986.4375, -151.34375), ang = Angle(0.714111328125, -120.04760742188, 90.346069335938)},
	{pos = Vector(8390.15625, 8211.96875, -151.46875), ang = Angle(0.36083781719208, -139.7625579834, 89.928588867188)},
	{pos = Vector(9061.625, 8286.65625, -15.40625), ang = Angle(0.4559326171875, 22.615356445313, 90.17578125)},
	{pos = Vector(9052.125, 8057.9375, -15.40625), ang = Angle(0.6536865234375, 45.005493164063, 90.247192382813)},
	{pos = Vector(9153.25, 7894, -153.5625), ang = Angle(-0.24169921875, -177.97302246094, 90.120849609375)},
	{pos = Vector(9154.9990234375, 8347.09375, -153.6875), ang = Angle(-0.0933837890625, -176.1767578125, 90.010986328125)}
}

-- Maintenance Config
PrisonSystem.Config.Maintenance = {}
-- Progress Min and Max
PrisonSystem.Config.Maintenance.MinProgress = 10
PrisonSystem.Config.Maintenance.MaxProgress = 25
-- Payout for repairing something
PrisonSystem.Config.Maintenance.Pay = 150
-- Maintenance regen (Seconds)
PrisonSystem.Config.Maintenance.MinRegen = 50
PrisonSystem.Config.Maintenance.MaxRegen = 60

-- Cook config
PrisonSystem.Config.Cook = {}
-- Different food models
PrisonSystem.Config.Cook.Models = {
	"models/griim/foodpack/sausage.mdl",
	"models/griim/foodpack/pepperonipizza.mdl",
	"models/griim/foodpack/toast.mdl",
	"models/griim/foodpack/pancakesingle.mdl"
}
-- Fridge restock timer
PrisonSystem.Config.Cook.RestockMin = 30
PrisonSystem.Config.Cook.RestockMax = 60
-- Fridge restock limit
PrisonSystem.Config.Cook.RestockLimit = 6
-- Oven cook time
PrisonSystem.Config.Cook.CookTime = 30
-- Sink clean time
PrisonSystem.Config.Cook.CleanTime = 20
-- Food sell value
PrisonSystem.Config.Cook.FoodPayout = 50