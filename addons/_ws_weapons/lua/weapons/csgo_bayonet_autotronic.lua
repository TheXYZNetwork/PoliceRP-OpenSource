if not file.Exists( "weapons/csgo_baseknife.lua", "LUA" ) then
  SWEP.Spawnable = false
  print( "csgo_bayonet_autotronic failed to initialize: csgo_baseknife.lua not found. Did you install the main part?" )
  return
end

local TTT = ( GAMEMODE_NAME == "terrortown" or cvars.Bool("csgo_knives_force_ttt", false) )

DEFINE_BASECLASS( "csgo_baseknife" )

if ( SERVER ) then
  SWEP.Weight         = 5
  SWEP.AutoSwitchTo   = false
  SWEP.AutoSwitchFrom = false

  if TTT then
    SWEP.EquipMenuData = nil
  end
end

if ( CLIENT ) then
  SWEP.Slot         = TTT and 6 or 2
  SWEP.SlotPos      = 0
end

SWEP.PrintName      = "Bayonet Knife" .. " | " .. "Autotronic"
SWEP.Category       = "CS:GO Knives"

SWEP.Spawnable      = true
SWEP.AdminSpawnable = true

SWEP.ViewModel      = "models/weapons/v_csgo_bayonet.mdl"
SWEP.WorldModel     = "models/weapons/w_csgo_bayonet.mdl"

SWEP.SkinIndex      = 14
SWEP.PaintMaterial  = nil
SWEP.AreDaggers     = false

util.PrecacheModel( SWEP.ViewModel )
util.PrecacheModel( SWEP.WorldModel )

-- TTT config values

-- Kind specifies the category this weapon is in. Players can only carry one of
-- each. Can be: WEAPON_... MELEE, PISTOL, HEAVY, NADE, CARRY, EQUIP1, EQUIP2 or ROLE.
-- Matching SWEP.Slot values: 0      1       2     3      4      6       7        8
SWEP.Kind = WEAPON_EQUIP

-- If AutoSpawnable is true and SWEP.Kind is not WEAPON_EQUIP1/2, then this gun can
-- be spawned as a random weapon.
SWEP.AutoSpawnable = false

-- The AmmoEnt is the ammo entity that can be picked up when carrying this gun.
-- SWEP.AmmoEnt = "item_ammo_smg1_ttt"

-- CanBuy is a table of ROLE_* entries like ROLE_TRAITOR and ROLE_DETECTIVE. If
-- a role is in this table, those players can buy this.
SWEP.CanBuy = nil

-- InLoadoutFor is a table of ROLE_* entries that specifies which roles should
-- receive this weapon as soon as the round starts. In this case, none.
SWEP.InLoadoutFor = nil

-- If LimitedStock is true, you can only buy one per round.
SWEP.LimitedStock = false

-- If AllowDrop is false, players can't manually drop the gun with Q
SWEP.AllowDrop = true

-- If IsSilent is true, victims will not scream upon death.
SWEP.IsSilent = true

-- If NoSights is true, the weapon won't have ironsights
SWEP.NoSights = true

-- This sets the icon shown for the weapon in the DNA sampler, search window,
-- equipment menu (if buyable), etc.
SWEP.Icon = "vgui/entities/csgo_bayonet_autotronic.vmt"
