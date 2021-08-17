XYZFire.Config.HealthMin = 5 -- Min health of a fire node
XYZFire.Config.HealthMax = 8 -- Max health of a fire node

-- The origin positions for fire nodes to start at.
XYZFire.Config.Origin = {
	Vector(-4779.130859, -7699.229980, 64.031250),
	Vector(428.216278, 1732.939697, 608.031250),
	Vector(-1389.313965, 8015.013672, 608.117004),
	Vector(-8875.038086, 7039.611328, 64.031250),
	Vector(-12741.712891, 12923.732422, 576.036011),
	Vector(-7957.887207, -5961.782227, 64.031250),
}

XYZFire.Config.OriginArea = 300 -- The area around the origin that the fire can spawn
XYZFire.Config.MinimumFD = 3 -- Minimum amount of people on as Fire Department to spawn a new fire?

XYZFire.Config.StartFire = 60*2 -- How often should a new fire be started?
XYZFire.Config.MaxActiveFires = 10 -- The amount of active fires allowed before it stops creating new ones

XYZFire.Config.SpreadSpeedMin = 10 -- Min time before a fire spreads
XYZFire.Config.SpreadSpeedMax = 30 -- Max time before a fire spreads

XYZFire.Config.MinDamage = 3 -- Min amount of damage fire does
XYZFire.Config.MaxDamage = 10 -- Max amount of damage fire does
