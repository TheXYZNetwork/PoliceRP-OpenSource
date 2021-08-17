-- Base respawn timer (Seconds)
XYZEMS.Config.BaseRespawn = 30
-- Time to add if EMS is online (Seconds)
XYZEMS.Config.EMSRespawn = 20
-- Time to add when Stabilized (Seconds)
XYZEMS.Config.EMSStabilize = 10
-- The cash reward for reviving someone
XYZEMS.Config.EMSReward = 5000

-- How long should the bodybags stay for? (Seconds)
XYZEMS.Config.BodyBagDespawn = 60
-- The % of server population needed to no longer spawn the bag (0 = 0%, 1 = 100%)
XYZEMS.Config.BodyBagPerCap = 0.5
-- A random value from 0-100 is generated, if it's higher than this it will spawn a bodybog
XYZEMS.Config.BodyBagPerCap = 70
-- The cash reward for collecting a bodybag
XYZEMS.Config.BodyBagReward = 2500
-- Weapons not to store when a player dies
XYZEMS.Config.Blacklist = {}
XYZEMS.Config.Blacklist["xyz_suicide_vest"] = true