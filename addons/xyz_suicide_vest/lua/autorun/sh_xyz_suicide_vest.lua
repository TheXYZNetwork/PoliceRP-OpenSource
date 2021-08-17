PrecacheParticleSystem("c4_explosion")
PrecacheParticleSystem("c4_explosion_air")

SuicideVest = {}
-- The per user cooldown in seconds
SuicideVest.Cooldown = 300
SuicideVest.TriggerSound = "xyz_suicide_vest/trigger.mp3"
SuicideVest.ExplosionSound = {
	"ambient/explosions/explode_1.wav",
	"ambient/explosions/explode_2.wav",
	"ambient/explosions/explode_3.wav",
	"ambient/explosions/explode_4.wav" 
}
SuicideVest.Range = 600
-- How many seconds before respawning the doors
SuicideVest.DoorRespawn = 30
if CLIENT then
	game.AddParticles("particles/gb_c4.pcf")
end