AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.PrintName = "Flash Grenade"
if CLIENT then
	SWEP.DrawCrosshair = false
	
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IconLetter = "P"
	killicon.AddFont("cw_flash_grenade", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MoveType = 2
	SWEP.ViewModelMovementScale = 0.8
	SWEP.DisableSprintViewSimulation = true
end

SWEP.CanRestOnObjects = false
SWEP.grenadeEnt = "cw_flash_thrown"
SWEP.noResupply = true -- for ground control

local sounds = {{time = 0.33, sound = "CW_PINPULL"}}

SWEP.Animations = {throw = {"throw"},
	pullpin = {"pullpin", "pullpin2", "pullpin3", "pullpin4"},
	idle = "idle",
	draw = "deploy"}
	
SWEP.Sounds = {pullpin = sounds,
	pullpin2 = sounds,
	pullpin3 = sounds,
	pullpin4 = sounds}
	
SWEP.SpeedDec = 5

SWEP.NoFreeAim = true

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "grenade"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_grenade_base"
SWEP.Category = "CW 2.0"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_eq_flashbang.mdl"
SWEP.WorldModel		= "models/weapons/w_eq_flashbang.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Flash Grenades"

SWEP.fuseTime = 2.5