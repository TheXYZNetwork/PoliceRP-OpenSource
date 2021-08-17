--[[---------------------------------------------------------------------------
DarkRP custom jobs
---------------------------------------------------------------------------

This file contains your custom jobs.
This file should also contain jobs from DarkRP that you edited.

Note: If you want to edit a default DarkRP job, first disable it in darkrp_config/disabled_defaults.lua
  Once you've done that, copy and paste the job to this file and edit it.
F
The default jobs can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/jobrelated.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomJobFields


Add jobs under the following line:
---------------------------------------------------------------------------]]

---
--- CITIZEN JOBS
---

TEAM_CITIZEN = DarkRP.createJob("Citizen", {
    color = Color(20, 150, 20, 255),
    model = {
        "models/player/Group01/Female_01.mdl",
        "models/player/Group01/Female_02.mdl",
        "models/player/Group01/Female_03.mdl",
        "models/player/Group01/Female_04.mdl",
        "models/player/Group01/Female_06.mdl",
        "models/player/group01/male_01.mdl",
        "models/player/Group01/Male_02.mdl",
        "models/player/Group01/male_03.mdl",
        "models/player/Group01/Male_04.mdl",
        "models/player/Group01/Male_05.mdl",
        "models/player/Group01/Male_06.mdl",
        "models/player/Group01/Male_07.mdl",
        "models/player/Group01/Male_08.mdl",
        "models/player/Group01/Male_09.mdl"
    },
    description = [[The Citizen is the most basic level of society you can hold besides being a hobo. You have no specific role in city life.]],
    weapons = {},
    command = "citizen",
    max = 0,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})


TEAM_HOBO = DarkRP.createJob("Hobo", {
   color = Color(127, 74, 12),
   model = {"models/player/corpse1.mdl"},
   description = [[You are a homeless hobo. You have no job or are aloud to own anything including cars or a house. You can build on the pavements but not on the street. You must also obey the laws.]],
   weapons = {"weapon_bugbait"},
   command = "hobon",
   max = 0,
   salary = 0,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = true,
   -- CustomCheck
   medic = false,
   chief = false,
   mayor = false,
   hobo = false,
   cook = false,
  category = "Citizens"
})


TEAM_GUND = DarkRP.createJob("Gun Dealer", {
    color = Color(255, 140, 0, 255),
    model = "models/player/monk.mdl",
    description = [[You are the gun dealer, supply the great people of darkrp with weapons to do whatever they wish.]],
    weapons = {},
    command = "gund",
    max = 3,
    salary = 40,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens",
})

TEAM_GUARD = DarkRP.createJob("Guard", {
   color = Color(15, 100, 178, 255),
   model = {"models/player/barney.mdl"},
   description = [[You are a Guard, you must protect what you were told to protect for a period of time at the cost of some cash. You may not break any laws other than killing to protect and having a printer if they are with Citizens or gun dealers.]],
   weapons = {"stunstick", "xyz_weaponchecker"},
   command = "guard",
   max = 6,
   salary = 45,
   admin = 0,
   vote = false,
   hasLicense = true,
   candemote = true,
   -- CustomCheck
   medic = false,
   chief = false,
   mayor = false,
   hobo = false,
   cook = false,
    category = "Citizens"
})

TEAM_PD_KER = DarkRP.createJob("Banker", {
    color = Color(60, 190, 30, 255),
    model = {
        "models/player/Group01/Female_01.mdl",
        "models/player/Group01/Male_01.mdl"
    },
    description = [[Store and keep money safe for others.]],
    weapons = {"vault_key"},
    command = "pdbanker",
    max = 2,
    salary = 50,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Citizens"
})

TEAM_LAWYER = DarkRP.createJob("Lawyer", {
  color = Color(155, 155, 0),
  model = {"models/player/gman_high.mdl"},
  description = [[As a lawyer of the city, it is your job to protect the citizens when they come face to face with the law.]],
  weapons = {},
  command = "lawyer",
  max = 4,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = false,
  candemote = true,
  -- CustomCheck
  medic = false,
  chief = false,
  mayor = false,
  hobo = false,
  cook = false,
  category = "Citizens"
})

TEAM_JUDGE = DarkRP.createJob("Judge", {
  color = Color(155, 0, 0),
  model = {"models/player/breen.mdl"},
  description = [[As a judge it is your job to ensure that justice is served.]],
  weapons = {},
  command = "judge",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = false,
  candemote = true,
  -- CustomCheck
  medic = false,
  chief = false,
  mayor = false,
  hobo = false,
  cook = false,
  category = "Citizens"
})

TEAM_TRASHCOLLECTOR = DarkRP.createJob("Trash Collector", {
    color = Color(20, 150, 20, 255),
    model = "models/player/Group01/Male_02.mdl",
    description = [[trashman]],
    weapons = {"weapon_trashcollector"},
    command = "trashman",
    max = 0,
    salary = GAMEMODE.Config.normalsalary,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})

TEAM_PRESIDENT = DarkRP.createJob("President", {
   color = Color(163, 15, 15, 255),
   model = {"models/player/donald_trump.mdl"},
   description = [[You are the President and you can control the law. You may change the rules to your liking. The government can be manipulated to suit your needs. You may not own any homes other than the Police Department. You can not brake your own laws. (laws may not interfere with server rules)]],
   weapons = {"unarrest_stick"},
   command = "president",
   max = 1,
   salary = 1000,
   admin = 0,
   vote = false,
   hasLicense = true,
   candemote = false,
   -- CustomCheck
   medic = false,
   chief = false,
   mayor = true,
   hobo = false,
   cook = false,   
   PlayerSpawn = function(ply) ply:SetArmor(100) end,
   customCheck = function(ply) return false end,
    category = "Citizens"
})

TEAM_VICE_PRESIDENT = DarkRP.createJob("Vice President", {
   color = Color(163, 15, 15, 255),
   model = {"models/obama/obama.mdl"},
   description = [[You are the Vice President. Follow what your president says and be his right hand man. ]],
   weapons = {"unarrest_stick"},
   command = "vicepresident",
   max = 1,
   salary = 1000,
   admin = 0,
   vote = false,
   hasLicense = true,
   candemote = false,
   -- CustomCheck
   medic = false,
   chief = false,
   mayor = false,
   hobo = false,
   cook = false,
   PlayerSpawn = function(ply) ply:SetArmor(100) end,
   customCheck = function(ply) return false end,
    category = "Citizens"
})

---
--- POLICE DEPARTMENT
---

TEAM_POFFICER = DarkRP.createJob("Police Officer", {
  color = Color(27, 87, 136, 255),
  model = {"models/taggart/police01/male_01.mdl"},
  description = [[You shouldn't be reading this...]],
  weapons = {},
  command = "policeofficer",
  max = 0,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

TEAM_PSENOFFICER = DarkRP.createJob("Senior Police Officer", {
  color = Color(20, 83, 134, 255),
  model = {"models/taggart/police01/male_02.mdl"},
  description = [[You shouldn't be reading this...]],
  weapons = {"cw_ump45"},
  command = "policeseniorofficer",
  max = 0,
  salary = 150,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

TEAM_PLANCORP = DarkRP.createJob("Police Lance Corporal", {
  color = Color(20, 83, 134, 255),
  model = {"models/taggart/police01/male_03.mdl"},
  description = [[You shouldn't be reading this...]],
  weapons = {"cw_ump45"},
  command = "policelancecorporal",
  max = 0,
  salary = 200,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

TEAM_PCORP = DarkRP.createJob("Police Corporal", {
  color = Color(11, 76, 129, 255),
  model = {"models/taggart/police01/male_04.mdl"},
  description = [[You shouldn't be reading this...]],
  weapons = {"cw_m3super90", "cw_ump45"},
  command = "policecorporal",
  max = 0,
  salary = 450,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

TEAM_SERGEANT = DarkRP.createJob("Police Sergeant", {
  color = Color(33, 7, 76, 255),
  model = {"models/taggart/police01/male_05.mdl"},
  description = [[You shouldn't be reading this...]],
  weapons = {"cw_mp5", "door_ram", "xyz_impound_clamp"},
  command = "policesergeant",
  max = 0,
  salary = 500,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

TEAM_MASSERGEANT = DarkRP.createJob("Police Master Sergeant", {
  color = Color(44, 10, 99, 255),
  model = {"models/taggart/police01/male_06.mdl"},
  description = [[You shouldn't be reading this...]],
  weapons = {"cw_mp5", "door_ram", "xyz_impound_clamp"},
  command = "policemastersergeant",
  max = 0,
  salary = 550,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

TEAM_PSERGEANTMAJOR = DarkRP.createJob("Police Sergeant Major", {
  color = Color(41, 6, 97, 255),
  model = {"models/taggart/police01/male_07.mdl"},
  description = [[You shouldn't be reading this...]],
  weapons = {"cw_mp5", "door_ram", "xyz_impound_clamp"},
  command = "policesergeantmajor",
  max = 0,
  salary = 600,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

TEAM_PLIUTENANT = DarkRP.createJob("Police Lieutenant", {
  color = Color(0, 127, 255, 255),
  model = {"models/humans/nypd1940/male_01.mdl"},
  description = [[You are the Lieutenant, manage the police force and keep the streets safe!]],
  weapons = {"cw_ar15", "door_ram", "xyz_impound_clamp", "xyz_user_info"},
  command = "policeleutenant",
  max = 9,
  salary = 650,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

TEAM_PCAPTAIN = DarkRP.createJob("Police Captain", {
  color = Color(0, 127, 255, 255),
  model = {"models/humans/nypd1940/male_02.mdl"},
  description = [[You are the Captain, manage the police force and keep the streets safe!]],
  weapons = {"cw_ar15", "door_ram", "xyz_impound_clamp", "xyz_user_info"},
  command = "policecaptain",
  max = 5,
  salary = 700,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

TEAM_PSUP = DarkRP.createJob("Police Superintendent", {
  color = Color(0, 127, 255, 255),
  model = {"models/humans/nypd1940/male_03.mdl"},
  description = [[You are a superindentent Keep the streets safe!]],
  weapons = {"cw_ar15", "door_ram", "xyz_impound_clamp", "xyz_user_info"},
  command = "policesuperindentent",
  max = 6,
  salary = 750,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

TEAM_PMAJ = DarkRP.createJob("Police Major", {
  color = Color(0, 127, 255, 255),
  model = {"models/humans/nypd1940/male_04.mdl"},
  description = [[You are a Major, keep the streets safe!]],
  weapons = {"cw_ar15", "door_ram", "xyz_impound_clamp", "xyz_user_info"},
  command = "policeMajor",
  max = 6,
  salary = 800,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

TEAM_PLTC = DarkRP.createJob("Police Deputy District Chief", {
  color = Color(0, 140, 255, 255),
  model = {"models/humans/nypd1940/male_05.mdl"},
  description = [[You are a Lieutenant Colonel Keep the streets safe!]],
  weapons = {"cw_ar15", "door_ram", "xyz_impound_clamp", "xyz_user_info", "xyz_megaphone"},
  command = "policelieucorporal",
  max = 6,
  salary = 850,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

TEAM_PCOL = DarkRP.createJob("Police District Chief", {
  color = Color(255, 0, 0, 255),
  model = {"models/humans/nypd1940/male_06.mdl"},
  description = [[You are a Corporal Keep the streets safe!]],
  weapons = {"cw_ar15", "door_ram", "xyz_impound_clamp", "xyz_user_info", "xyz_megaphone"},
  command = "policecolonel",
  max = 5,
  salary = 900,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

TEAM_PASSCOM = DarkRP.createJob("Police Assistant Commissioner", {
  color = Color(255, 0, 0, 255),
  model = {"models/humans/nypd1940/male_07.mdl"},
  description = [[You are part of the Police Force]],
  weapons = {"cw_ar15", "door_ram", "xyz_impound_clamp", "xyz_user_info", "xyz_megaphone"},
  command = "policeass",
  max = 2,
  salary = 1000,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

TEAM_PDCOM = DarkRP.createJob("Police Deputy Commissioner", {
  color = Color(255, 0, 0, 255),
  model = {"models/humans/nypd1940/male_08.mdl"},
  description = [[You are part of the police force]],
  weapons = {"cw_ar15", "door_ram", "xyz_impound_clamp", "xyz_user_info", "xyz_megaphone"},
  command = "policedeputycomissioner",
  max = 2,
  salary = 1000,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

TEAM_PCOM = DarkRP.createJob("Police Commissioner", {
  color = Color(255, 0, 0, 255),
  model = {"models/humans/nypd1940/male_09.mdl"},
  description = [[You are the highest rank on the PD Force]],
  weapons = {"cw_ar15", "door_ram", "xyz_impound_clamp", "xyz_user_info", "xyz_megaphone"},
  command = "policecomissioner",
  max = 1,
  salary = 1000,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Police Force",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    end,
})

---
--- SHERIFF DEPARTMENT
---

TEAM_SHERIFFTROOPER = DarkRP.createJob("Sheriff's Department Deputy", {
  color = Color(148, 115, 39, 255),
  model = {"models/player/gpd/sheriff_ancient/male_05.mdl"},
  description = [[You are a Highway Patrol, protect the city.]],
  weapons = {"cw_g3a3"},
  command = "sheriffdeputy",
  max = 10,
  salary = 500,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Sheriff's Department",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end,
})

TEAM_SHERIFFFIRSTCLASS = DarkRP.createJob("Sheriff's Department Deputy First Class", {
  color = Color(148, 115, 39, 255),
  model = {"models/player/gpd/sheriff_ancient/female_04.mdl"},
  description = [[You are a Highway Patrol First Class, protect the city.]],
  weapons = {"cw_g3a3"},
  command = "sherifffirstclass",
  max = 10,
  salary = 550,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Sheriff's Department",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end,
})

TEAM_SHERIFFMASTER = DarkRP.createJob("Sheriff's Department Master Deputy", {
  color = Color(148, 115, 39, 255),
  model = {"models/player/gpd/sheriff_ancient/male_05.mdl"},
  description = [[You are a Master Highway Patrol, protect the city.]],
  weapons = {"cw_g3a3"},
  command = "sheriffmaster",
  max = 6,
  salary = 600,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Sheriff's Department",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end,
})

TEAM_SHERIFFCORPORAL = DarkRP.createJob("Sheriff's Department Corporal", {
  color = Color(148, 115, 39, 255),
  model = {"models/player/gpd/sheriff_ancient/male_06.mdl"},
  description = [[You are a Highway Patrol Corporal, protect the city.]],
  weapons = {"cw_g3a3"},
  command = "sheriffcorporal",
  max = 6,
  salary = 650,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Sheriff's Department",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end,
})

TEAM_SHERIFFSERGEANT = DarkRP.createJob("Sheriff's Department Sergeant", {
  color = Color(148, 115, 39, 255),
  model = {"models/player/gpd/sheriff_ancient/female_02.mdl"},
  description = [[You are a Highway Patrol Sergeant, protect the city.]],
  weapons = {"cw_g3a3"},
  command = "sheriffsergeant",
  max = 5,
  salary = 700,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Sheriff's Department",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end,
})
-- I removed the SV on purpose, no job needs 3 primarys by default.
TEAM_SHERIFFLIEUTENANT = DarkRP.createJob("Sheriff's Department Lieutenant", {
  color = Color(148, 115, 39, 255),
  model = {"models/player/gpd/sheriff_ancient/male_01.mdl"},
  description = [[You are a Highway Patrol Lieutenant, protect the city.]],
  weapons = {"cw_scarh", "xyz_user_info", "door_ram"},
  command = "sherifflieutenant",
  max = 5,
  salary = 750,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Sheriff's Department",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end,
})

TEAM_SHERIFFCAPTAIN = DarkRP.createJob("Sheriff's Department Captain", {
  color = Color(148, 115, 39, 255),
  model = {"models/player/gpd/sheriff_ancient/male_09.mdl"},
  description = [[You are a Highway Patrol Captain, protect the city and command the other Highway Patrols.]],
  weapons = {"cw_scarh", "xyz_user_info", "door_ram"},
  command = "sheriffrcaptain",
  max = 5,
  salary = 800,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Sheriff's Department",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end,
})

TEAM_SHERIFFMAJOR = DarkRP.createJob("Sheriff's Department Major", {
  color = Color(148, 115, 39, 255),
  model = {"models/player/gpd/sheriff_ancient/female_07.mdl"},
  description = [[You are a Highway Patrol Major, protect the city and command the other Highway Patrols.]],
  weapons = {"cw_scarh", "xyz_user_info", "door_ram", "xyz_megaphone"},
  command = "sheriffmajor",
  max = 5,
  salary = 850,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Sheriff's Department",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end,
})

TEAM_CHIEFDEPUTY = DarkRP.createJob("Sheriff's Department Chief Deputy", {
  color = Color(148, 115, 39, 255),
  model = {"models/player/gpd/sheriff_ancient/male_03.mdl"},
  description = [[You are a Sheriff, protect the city and command the other Sheriff's.]],
  weapons = {"cw_scarh", "xyz_user_info", "door_ram", "xyz_megaphone"},
  command = "chiefdeputy",
  max = 1,
  salary = 900,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Sheriff's Department",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end,
})

TEAM_UNDERSHERIFF = DarkRP.createJob("Undersheriff", {
  color = Color(148, 115, 39, 255),
  model = {"models/player/gpd/sheriff_ancient/male_gta_02.mdl"},
  description = [[]],
  weapons = {"cw_scarh", "xyz_user_info", "door_ram", "xyz_megaphone"},
  command = "Undersheriff",
  max = 1,
  salary = 950,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Sheriff's Department",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end,
})

TEAM_SHERIFF = DarkRP.createJob("Sheriff", {
  color = Color(148, 115, 39, 255),
  model = {"models/player/gpd/sheriff_ancient/male_gta_02.mdl"},
  description = [[You are a Sheriff, protect the city and command the other Sheriff's.]],
  weapons = {"cw_scarh", "xyz_user_info", "door_ram", "xyz_megaphone"},
  command = "Sheriff",
  max = 1,
  salary = 950,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Sheriff's Department",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end,
})

TEAM_SHERIFFK9 = DarkRP.createJob("Sheriff K9 Dog", {
  color = Color(148, 115, 39, 255),
  model = {"models/pierce/police_k9.mdl"},
  description = [[ ]],
  weapons = {"weapon_dogswep", "xyz_weaponchecker"}, -- Dont set weapons here\addons\xyz_dog\lua\autorun\server\xyz_dog_setup.lua
  command = "k9dogsh",
  max = 4,
  salary = 400,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Sheriff's Department",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end,
})

---
--- FBI
---

TEAM_FBIPA = DarkRP.createJob("FBI Probationary Agent", {
  color = Color(105, 110, 117, 255),
  model = {"models/fbi_pack/fbi_01.mdl"},
  description = [[FBI]],
  weapons = {"cw_mp5"},
  command = "fbipa",
  max = 0,
  salary = 500,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "FBI",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end
})

TEAM_FBISA = DarkRP.createJob("FBI Special Agent", {
  color = Color(105, 110, 117, 255),
  model = {"models/fbi_pack/fbi_02.mdl"},
  description = [[FBI]],
  weapons = {"cw_mp5"},
  command = "fbisa",
  max = 5,
  salary = 550,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "FBI",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end
})

TEAM_FBISSA = DarkRP.createJob("FBI Senior Special Agent", {
  color = Color(105, 110, 117, 255),
  model = {"models/fbi_pack/fbi_03.mdl"},
  description = [[FBI]],
  weapons = {"xyz_car_tracker", "cw_mp5"},
  command = "fbissa",
  max = 5,
  salary = 550,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "FBI",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end
})

TEAM_FBIASAIC = DarkRP.createJob("FBI Assistant Special Agent In-Charge", {
  color = Color(105, 110, 117, 255),
  model = {"models/fbi_pack/fbi_04.mdl"},
  description = [[FBI]],
  weapons = {"xyz_car_tracker", "cw_g36c"},
  command = "fbiasaic",
  max = 5,
  salary = 550,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "FBI",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end
})

TEAM_FBISAIC = DarkRP.createJob("FBI Special Agent In-Charge", {
  color = Color(105, 110, 117, 255),
  model = {"models/fbi_pack/fbi_05.mdl"},
  description = [[FBI]],
  weapons = {"xyz_car_tracker", "cw_g36c", "cw_m1014", "heavy_shield"},
  command = "fbisaic",
  max = 5,
  salary = 550,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "FBI",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end
})

TEAM_FBISSAIC = DarkRP.createJob("FBI Senior Special Agent In-Charge", {
  color = Color(105, 110, 117, 255),
  model = {"models/fbi_pack/fbi_06.mdl"},
  description = [[FBI]],
  weapons = {"xyz_car_tracker", "cw_g36c", "cw_m1014", "heavy_shield"},
  command = "fbissaic",
  max = 5,
  salary = 600,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "FBI",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end
})

TEAM_FBIDAD = DarkRP.createJob("FBI Deputy Assistant Director", {
  color = Color(105, 110, 117, 255),
  model = {"models/player/fbi/fbi_04.mdl"},
  description = [[FBI]],
  weapons = {"xyz_car_tracker", "cw_g36c", "cw_m1014", "xyz_user_info", "heavy_shield"},
  command = "fbidad",
  max = 6,
  salary = 650,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "FBI",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end
})

TEAM_FBIEAD = DarkRP.createJob("FBI Executive Assistant Director", {
  color = Color(105, 110, 117, 255),
  model = {"models/player/fbi/fbi_04.mdl"},
  description = [[FBI]],
  weapons = {"xyz_car_tracker", "cw_g36c", "cw_m1014", "xyz_user_info", "heavy_shield"},
  command = "fbiead",
  max = 4,
  salary = 750,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "FBI",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end
})

TEAM_FBIADD = DarkRP.createJob("FBI Associate Deputy Director", {
  color = Color(105, 110, 117, 255),
  model = {"models/player/fbi/fbi_03.mdl"},
  description = [[FBI]],
  weapons = {"xyz_car_tracker", "cw_g36c", "cw_m1014", "xyz_user_info", "heavy_shield"},
  command = "fbiadd",
  max = 2,
  salary = 800,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "FBI",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end
})

TEAM_FBICOS = DarkRP.createJob("FBI Chief of Staff", {
  color = Color(105, 110, 117, 255),
  model = {"models/player/fbi/fbi_02.mdl"},
  description = [[FBI]],
  weapons = {"xyz_car_tracker", "cw_g36c", "cw_m1014", "xyz_user_info", "heavy_shield"},
  command = "fbicos",
  max = 1,
  salary = 850,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "FBI",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end
})

TEAM_FBIDD = DarkRP.createJob("FBI Deputy Director", {
  color = Color(105, 110, 117, 255),
  model = {"models/player/fbi/fbi_01.mdl"},
  description = [[FBI]],
  weapons = {"xyz_car_tracker", "cw_g36c", "cw_m1014", "xyz_user_info", "heavy_shield"},
  command = "fbidd",
  max = 1,
  salary = 900,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "FBI",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end
})

TEAM_FBID = DarkRP.createJob("FBI Director", {
  color = Color(105, 110, 117, 255),
  model = {"models/player/fbi/fbi_01.mdl"},
  description = [[FBI]],
  weapons = {"xyz_car_tracker", "cw_g36c", "cw_m1014", "xyz_user_info", "heavy_shield"},
  command = "fbid",
  max = 1,
  salary = 950,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "FBI",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end
})

---
--- SWAT
---

TEAM_SWATRIFLE = DarkRP.createJob("SWAT Rifleman", {
  color = Color(0, 0, 139, 255),
  model = {"models/mw2/skin_04/mw2_soldier_01.mdl"},
  description = [[SWAT]],
  weapons = {"cw_ar15"},
  command = "swatrifle",
  max = 12,
  salary = 500,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Swat",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    ply:SetBodygroup(0, 0)
    ply:SetBodygroup(1, 4)
    ply:SetBodygroup(2, 0)
    ply:SetBodygroup(3, 0)
  end
})

TEAM_SWATCQC = DarkRP.createJob("SWAT CQC", {
  color = Color(0, 0, 139, 255),
  model = {"models/mw2/skin_04/mw2_soldier_01.mdl"},
  description = [[SWAT]],
  weapons = {"cw2_mp7", "khr_ns2000"},
  command = "swatqcq",
  max = 4,
  salary = 500,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Swat",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    ply:SetBodygroup(0, 0)
    ply:SetBodygroup(1, 4)
    ply:SetBodygroup(2, 0)
    ply:SetBodygroup(3, 0)
  end
})

TEAM_SWATMED = DarkRP.createJob("SWAT Medic", {
  color = Color(0, 0, 139, 255),
  model = {"models/mw2/skin_04/mw2_soldier_01.mdl"},
  description = [[SWAT]],
  weapons = {"cw_ar15", "xyz_syringe", "cw_smoke_grenade"},
  command = "swatmedic",
  max = 6,
  salary = 500,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Swat",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    ply:SetBodygroup(0, 0)
    ply:SetBodygroup(1, 4)
    ply:SetBodygroup(2, 0)
    ply:SetBodygroup(3, 0)
  end
})

TEAM_SWATBRE = DarkRP.createJob("SWAT Breacher", {
  color = Color(0, 0, 139, 255),
  model = {"models/mw2/skin_04/mw2_soldier_01.mdl"},
  description = [[SWAT]],
  weapons = {"cw_ar15", "cw_shorty", "heavy_shield"},
  command = "swatbre",
  max = 4,
  salary = 500,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Swat",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    ply:SetBodygroup(0, 1)
    ply:SetBodygroup(1, 4)
    ply:SetBodygroup(2, 0)
    ply:SetBodygroup(3, 0)
  end
})

TEAM_SWATMRK = DarkRP.createJob("SWAT Marksman", {
  color = Color(0, 0, 139, 255),
  model = {"models/mw2/skin_04/mw2_soldier_05.mdl"},
  description = [[SWAT]],
  weapons = {"khr_sr338"},
  command = "swatmrk",
  max = 4,
  salary = 500,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Swat",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    ply:SetBodygroup(0, 1)
    ply:SetBodygroup(1, 4)
    ply:SetBodygroup(2, 0)
    ply:SetBodygroup(3, 0)
    ply:SetBodygroup(4, 0)
  end
})

TEAM_SWATSNP = DarkRP.createJob("SWAT Sniper", {
  color = Color(0, 0, 139, 255),
  model = {"models/mw2/skin_04/mw2_soldier_05.mdl"},
  description = [[SWAT]],
  weapons = {"khr_m82a3", "deployable_shield"},
  command = "swatsnp",
  max = 6,
  salary = 500,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Swat",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    ply:SetBodygroup(0, 1)
    ply:SetBodygroup(1, 4)
    ply:SetBodygroup(2, 0)
    ply:SetBodygroup(3, 0)
    ply:SetBodygroup(4, 0)
  end
})

TEAM_SWATCTU = DarkRP.createJob("SWAT CTU", {
  color = Color(0, 0, 139, 255),
  model = {"models/mw2/skin_04/mw2_soldier_02.mdl"},
  description = [[SWAT]],
  weapons = {"xyz_car_tracker", "cw_sv98", "cw_ar15"},
  command = "swatctu",
  max = 6,
  salary = 850,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Swat",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    ply:SetBodygroup(0, 0)
    ply:SetBodygroup(1, 4)
    ply:SetBodygroup(2, 1)
    ply:SetBodygroup(3, 1)
  end
})

TEAM_SWATSUP = DarkRP.createJob("SWAT Lieutenant", {
  color = Color(0, 0, 128, 255),
  model = {"models/mw2/skin_04/mw2_soldier_05.mdl"},
  description = [[SWAT]],
  weapons = {"xyz_car_tracker", "cw_ar15", "xyz_user_info"},
  command = "swatsup",
  max = 4,
  salary = 500,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Swat",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    ply:SetBodygroup(0, 0)
    ply:SetBodygroup(1, 4)
    ply:SetBodygroup(2, 1)
    ply:SetBodygroup(3, 5)
    ply:SetBodygroup(4, 0)
  end
})

TEAM_SWATLEADER = DarkRP.createJob("SWAT Captain", {
  color = Color(0, 0, 128, 255),
  model = {"models/mw2/skin_04/mw2_soldier_05.mdl"},
  description = [[SWAT]],
  weapons = {"xyz_car_tracker", "cw_ar15", "xyz_user_info", "xyz_megaphone"},
  command = "swatleader",
  max = 2,
  salary = 850,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Swat",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    ply:SetBodygroup(0, 0)
    ply:SetBodygroup(1, 4)
    ply:SetBodygroup(2, 1)
    ply:SetBodygroup(3, 5)
    ply:SetBodygroup(4, 0)
  end
})

TEAM_SWATMAJOR = DarkRP.createJob("SWAT Major", {
  color = Color(0, 0, 128, 255),
  model = {"models/mw2/skin_04/mw2_soldier_05.mdl"},
  description = [[SWAT]],
  weapons = {"xyz_car_tracker", "cw_ar15", "xyz_user_info", "xyz_megaphone"},
  command = "swatmajor",
  max = 2,
  salary = 850,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Swat",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    ply:SetBodygroup(0, 0)
    ply:SetBodygroup(1, 4)
    ply:SetBodygroup(2, 1)
    ply:SetBodygroup(3, 5)
    ply:SetBodygroup(4, 0)
  end
})

TEAM_SWATLTCOL = DarkRP.createJob("SWAT Lieutenant Colonel", {
  color = Color(0, 0, 128, 255),
  model = {"models/mw2/skin_04/mw2_soldier_05.mdl"},
  description = [[SWAT]],
  weapons = {"xyz_car_tracker", "cw_scarh", "xyz_user_info", "xyz_megaphone"},
  command = "swatltcol",
  max = 1,
  salary = 900,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Swat",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    ply:SetBodygroup(0, 0)
    ply:SetBodygroup(1, 4)
    ply:SetBodygroup(2, 1)
    ply:SetBodygroup(3, 5)
    ply:SetBodygroup(4, 0)
  end
})

TEAM_SWATCOL = DarkRP.createJob("SWAT Colonel", {
  color = Color(0, 0, 128, 255),
  model = {"models/mw2/skin_04/mw2_soldier_05.mdl"},
  description = [[SWAT]],
  weapons = {"xyz_car_tracker", "cw_scarh", "xyz_user_info", "xyz_megaphone"},
  command = "swatcol",
  max = 1,
  salary = 950,
  admin = 0,
  vote = false,
  hasLicense = true,
  candemote = false,
  category = "Swat",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
    ply:SetBodygroup(0, 0)
    ply:SetBodygroup(1, 4)
    ply:SetBodygroup(2, 1)
    ply:SetBodygroup(3, 5)
    ply:SetBodygroup(4, 0)
  end
})

---
--- CRIMINALS
---

TEAM_BLOODzL = DarkRP.createJob("Bloodz Leader", {
    color = Color( 200, 35, 35 ),
    model = {"models/player/bloodz/slow_2.mdl"},
    description = [[You're a Blood, fight against the Crips and help keep up your gangs street cred!]],
    weapons = {"cw_silverballer", "lockpick", "keypad_cracker"},
    command = "bloodsleader",
    max = 1,
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = true,
    category = "Criminals"
})

TEAM_BLOODz = DarkRP.createJob("Bloodz Member", {
    color = Color( 200, 35, 35 ),
    model = {"models/player/bloodz/slow_2.mdl"},
    description = [[Follow the command of the Bloodz Leader.]],
    weapons = {"lockpick", "keypad_cracker"},
    command = "bloodsmember",
    max = 4,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = true,
    category = "Criminals"
})

TEAM_CRIPSL = DarkRP.createJob("Crips Leader", {
    color = Color( 35, 35, 200 ),
    model = {"models/player/cripz/slow_1.mdl"},
    description = [[You're a Crip, fight against the Bloodz and help keep up your gangs street cred!]],
    weapons = {"cw_silverballer", "lockpick", "keypad_cracker"},
    command = "cripsleader",
    max = 1,
    salary = 200,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = true,
    category = "Criminals"
})

TEAM_CRIPS = DarkRP.createJob("Crips Member", {
    color = Color( 35, 35, 200 ),
    model = {"models/player/cripz/slow_1.mdl"},
    description = [[Follow the command of the Crips Leader.]],
    weapons = {"lockpick", "keypad_cracker"},
    command = "cripzmember",
    max = 4,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = true,
    category = "Criminals"
})

TEAM_THIEF = DarkRP.createJob("Thief", {
    color = Color( 144, 2, 2 ),
    model = {"models/player/phoenix.mdl"},
    description = [[You're a thief, the basic kind of criminal.]],
    weapons = {"lockpick", "keypad_cracker"},
    command = "thief",
    max = 15,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = true,
    category = "Criminals"
})

TEAM_DRUGDEALER = DarkRP.createJob("Drug Dealer", {
   color = Color(0, 143, 255, 196),
   model = {"models/player/soldier_stripped.mdl"},
   description = [[Cook stuff and things and make the drugs and stuff and sell it and things]],
   weapons = {"xyz_drugs_tablet"},
   command = "drugdealer",
   max = 3,
   salary = 45,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = true,
   -- CustomCheck
   medic = false,
   chief = false,
   mayor = false,
   hobo = false,
   cook = false,
   category = "Criminals"
})

TEAM_HITMAN = DarkRP.createJob("Hitman", {
   color = Color(209, 143, 143, 255),
   model = {"models/player/leet.mdl"},
   description = [[You are a Hitman your job is to carry out the dirty jobs people put you up to for a fee. Each hit you receive must have a reason except  for government members.]],
   weapons = {},
   command = "hitman",
   max = 3,
   salary = 45,
   admin = 0,
   vote = false,
   hasLicense = true,
   candemote = true,
   -- CustomCheck
   medic = false,
   chief = false,
   mayor = false,
   hobo = false,
   cook = false,
   category = "Criminals"
})

---
--- VIP
---

TEAM_MECHANIC = DarkRP.createJob("Mechanic", {
  color = Color(213, 195, 30),
  model = "models/player/odessa.mdl",
  description = [[ Tow cars and shit ]],        
  weapons = {"vc_wrench", "vc_jerrycan", "xyz_tow_controller", "xyz_impound_clamp"},
  command = "mechanic", -- Command to become the job
  max = 2,
  salary = 120, -- Salary
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "VIP",
  customCheck = function(ply) return ply:IsVIP() end
})

TEAM_PTHIEF = DarkRP.createJob("Pro Thief", {
  color = Color(226, 130, 130, 255),
  model = {"models/deepalley/alley_thug.mdl"},
  description = [[You are the pro thief, you are the proest of thiefs, a real swag sweeper, loot ninja, BANK BUSTER!]],
  weapons = {"pro_lockpick_update", "keypad_cracker", "khr_fmg9", "lockpick"},
  command = "prothief",
  max = 10,
  salary = 60,
  admin = 0,
  vote = false,
  hasLicense = false,
  candemote = false,
  customCheck = function(ply) return ply:IsVIP() end,
  medic = false,
  chief = false,
  mayor = false,
  hobo = false,
  cook = false,
  category = "VIP"
})

TEAM_ELITEHITMAN = DarkRP.createJob("Bounty Hunter", {
   color = Color(209, 143, 143, 255),
   model = {"models/player/agent_47.mdl"},
   description = [[You are a Hitman your job is to carry out the dirty jobs people put you up to for a fee. Each hit you receive must have a reason except  for government members.]],
   weapons = {"cw_makarov", "cw_l115"},
   command = "elitehitman",
   max = 2,
   salary = 45,
   admin = 0,
   vote = false,
   hasLicense = true,
   candemote = true,
   customCheck = function(ply) return ply:IsVIP() end,
   medic = false,
   chief = false,
   mayor = false,
   hobo = false,
   cook = false,
   category = "VIP"
})

TEAM_KINGBLOODZ = DarkRP.createJob("Kingpin Bloodz Member", {
    color = Color( 255, 35, 35 ),
    model = {"models/player/bloodz/slow_3.mdl"},
    description = [[Kingpin Bloodz member]],
    weapons = {"pro_lockpick_update", "lockpick", "keypad_cracker", "cw_mac11"},
    command = "kingbloodsmember",
    max = 2,
    salary = 120,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = true,
    category = "VIP",
    customCheck = function(ply) return ply:IsVIP() end
})

TEAM_KINGCRIPS = DarkRP.createJob("Kingpin Crips Member", {
    color = Color( 35, 35, 255 ),
    model = {"models/player/cripz/slow_3.mdl"},
    description = [[Kingpin Crips member]],
    weapons = {"pro_lockpick_update", "lockpick", "keypad_cracker", "cw_mac11"},
    command = "kingcripzmember",
    max = 2,
    salary = 120,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = true,
    category = "VIP",
    customCheck = function(ply) return ply:IsVIP() end
})

TEAM_BTHIEF = DarkRP.createJob("Bank Thief", {
  color = Color(0, 0, 0),
  model = {"models/player/arctic.mdl"},
  description = [[You steal all the money from the bank!]],
  weapons = {"pro_lockpick_update", "lockpick", "keypad_cracker", "khr_m620"},
  command = "bthief",
  max = 4,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "VIP",
  customCheck = function(ply) return ply:IsVIP() end
})

TEAM_TRUCKER = DarkRP.createJob("Trucker", {
   color = Color(255, 255, 100, 255),
   model = {"models/player/eli.mdl"},
   description = [[ ]],
   weapons = {},
   command = "trucker",
   max = 2,
   salary = 60,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
    category = "VIP",
    customCheck = function(ply) return ply:IsVIP() end
})

TEAM_UPSDRIVER = DarkRP.createJob("UPS Driver", {
   color = Color(252, 180, 21),
   model = {"models/player/eli.mdl"},
   description = [[ ]],
   weapons = {},
   command = "upsdriver",
   max = 4,
   salary = 60,
   admin = 0,
   vote = false,
   hasLicense = false,
   candemote = false,
    category = "VIP",
    customCheck = function(ply) return ply:IsVIP() end
})

TEAM_G4SDRIVER = DarkRP.createJob("Gruppe 6 Driver", {
   color = Color(46, 204, 113),
   model = {"models/kerry/gruppe/male_01_security.mdl"},
   description = [[ ]],
   weapons = {},
   command = "gruppe6driver",
   max = 2,
   salary = 60,
   admin = 0,
   vote = false,
   hasLicense = true,
   candemote = false,
    category = "VIP",
    customCheck = function(ply) return ply:IsVIP() end
})


TEAM_TAXI = DarkRP.createJob("Taxi Driver", {
  color = Color(100, 100, 250, 255),
  model = {"models/player/Group01/male_01.mdl"},
  description = [[ Get a bus, drive it! ]],
  weapons = {},
  command = "taxidriver",
  max = 3,
  salary = 120,
  admin = 0,
  vote = false,
  hasLicense = false,
  candemote = false,
    category = "VIP",
    customCheck = function(ply) return ply:IsVIP() end
})

TEAM_HACKER = DarkRP.createJob("Hacker", {
  color = Color(100, 100, 100),
  model = {"models/playermodel/sterling/mr_robot.mdl"},
  description = [[ Hacking on the hacker job! ]],
  weapons = {"pro_lockpick_update", "keypad_cracker", "khr_vector", "lockpick", "bens_radio_jammer"},
  command = "hacker",
  max = 2,
  salary = 50,
  admin = 0,
  vote = false,
  hasLicense = false,
  candemote = false,
  customCheck = function(ply) return ply:IsVIP() end,
  medic = false,
  chief = false,
  mayor = false,
  hobo = false,
  cook = false,
  category = "VIP"
})

--- 
--- Elite
--- 

TEAM_BOUNTYHUNTER = DarkRP.createJob("Assassin", {
  color = Color(80, 80, 80),
  model = {"models/player/ratdock/ceiling_spiders_armored.mdl"},
  description = [[ . ]],
  weapons = {"lockpick", "pro_lockpick_update", "prokeypadcracker", "khr_t5000", "khr_ots33"},
  command = "assassin",
  max = 3,
  salary = 175,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "Elite",
  customCheck = function(ply) return ply:IsElite() end,
})

TEAM_ELITETHIEF = DarkRP.createJob("Elite Thief", {
  color = Color(255, 170, 170),
  model = {"models/player/spike/robber.mdl"},
  description = [[ . ]],
  weapons = {"lockpick", "pro_lockpick_update", "prokeypadcracker", "khr_p90"},
  command = "elitethief",
  max = 10,
  salary = 200,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Elite",
  customCheck = function(ply) return ply:IsElite() end,
})

TEAM_OVERLORDBLOODZ = DarkRP.createJob("Overlord Bloodz Member", {
    color = Color( 255, 80, 80 ),
    model = {"models/player/bloodz/slow_1.mdl"},
    description = [[Kingpin Bloodz member]],
    weapons = {"lockpick", "pro_lockpick_update", "prokeypadcracker", "cw_shorty"},
    command = "overloadbloodzmember",
    max = 2,
    salary = 120,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = true,
    category = "Elite",
    customCheck = function(ply) return ply:IsElite() end
})

TEAM_OVERLORDCRIPS = DarkRP.createJob("Overlord Crips Member", {
    color = Color( 80, 80, 255 ),
    model = {"models/player/cripz/slow_2.mdl"},
    description = [[Kingpin Crips member]],
    weapons = {"lockpick", "pro_lockpick_update", "prokeypadcracker", "cw_shorty"},
    command = "overlordcripzmember",
    max = 2,
    salary = 120,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = true,
    category = "Elite",
    customCheck = function(ply) return ply:IsElite() end
})

TEAM_DRUGLORD = DarkRP.createJob("Drug Lord", {
    color = Color(0, 143, 255, 196),
    model = {"models/player/soldier_stripped.mdl"},
    description = [[Drug Lord fam]],
    weapons = {"lockpick", "pro_lockpick_update", "prokeypadcracker", "khr_fmg9", "xyz_drugs_tablet"},
    command = "druglord",
    max = 3,
    salary = 120,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = true,
    category = "Elite",
    customCheck = function(ply) return ply:IsElite() end
})

TEAM_BUS = DarkRP.createJob("Bus Driver", {
    color = Color(100, 100, 250, 255),
    model = {"models/player/Group01/male_01.mdl"},
    description = [[ Get a bus, drive it! ]],
    weapons = {},
    command = "busdriver",
    max = 1,
    salary = 120,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Elite",
    customCheck = function(ply) return ply:IsElite() end
})

TEAM_NEWSR = DarkRP.createJob("News Reporter", {
    color = Color(255, 56, 41),
    model = {"models/player/mossman_arctic.mdl"},
    description = [[ Tell the world what's happening! ]],
    weapons = {},
    command = "newsreporter",
    max = 1,
    salary = 120,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Elite",
    customCheck = function(ply) return ply:IsElite() end
})

TEAM_NEWSC = DarkRP.createJob("News Crew", {
    color = Color(255, 56, 41),
    model = {"models/player/magnusson.mdl"},
    description = [[ Record the worlds events! ]],
    weapons = {"xyz_news_camera"},
    command = "newscrew",
    max = 1,
    salary = 120,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Elite",
    customCheck = function(ply) return ply:IsElite() end
})

TEAM_DJ = DarkRP.createJob("DJ", {
    color = Color(255, 21, 41),
    model = {"models/lordvipes/daftpunk/player/dp_t_01_player.mdl"},
    description = [[ Play LOUD MUSIC ]],
    weapons = {},
    command = "dj",
    max = 1,
    salary = 120,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Elite",
    customCheck = function(ply) return ply:IsElite() end
})

---
--- TERRORISTS
---

TEAM_TERRORIST_RECRUIT = DarkRP.createJob("Terrorist Recruit", {
  color = Color(169, 169, 169),
  model = {"models/csgoanarchist1pm.mdl"},
  description = [[!]],
  weapons = {"khr_veresk"},
  command = "terroristrecruit",
  max = 5,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Terrorist",
})

TEAM_TERRORIST_AGITATOR = DarkRP.createJob("Terrorist Agitator", {
  color = Color(169, 169, 169),
  model = {"models/csgoanarchist3pm.mdl"},
  description = [[!]],
  weapons = {"khr_veresk"},
  command = "terroristagitator",
  max = 5,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Terrorist",
})

TEAM_TERRORIST_FANATIC = DarkRP.createJob("Terrorist Fanatic", {
  color = Color(169, 169, 169),
  model = {"models/csgoanarchist4pm.mdl"},
  description = [[!]],
  weapons = {"khr_aek971"},
  command = "terroristfanatic",
  max = 5,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Terrorist",
})

TEAM_TERRORIST_INS = DarkRP.createJob("Terrorist Insurgent", {
  color = Color(169, 169, 169),
  model = {"models/csgopheonix1pm.mdl"},
  description = [[!]],
  weapons = {"khr_aek971", "cw_frag_grenade"},
  command = "terroristins",
  max = 5,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Terrorist",
})

TEAM_TERRORIST_EXE = DarkRP.createJob("Terrorist Executioner", {
  color = Color(169, 169, 169),
  model = {"models/csgopheonix3pm.mdl"},
  description = [[!]],
  weapons = {"khr_aek971", "khr_ns2000", "car_bomb", "cw_frag_grenade"},
  command = "terroristexe",
  max = 5,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Terrorist",
})

TEAM_TERRORIST_GOVNR = DarkRP.createJob("Terrorist Governor", {
  color = Color(169, 169, 169),
  model = {"models/csgoleet2pm.mdl"},
  description = [[!]],
  weapons = {"cw_ak74", "cw_deagle", "cw_frag_grenade", "car_bomb", "xyz_user_info"},
  command = "terroristgovnr",
  max = 6,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Terrorist",
})

TEAM_TERRORIST_CMDR = DarkRP.createJob("Terrorist Commander", {
  color = Color(169, 169, 169),
  model = {"models/csgoleet4pm.mdl"},
  description = [[!]],
  weapons = {"cw_ak74", "cw_deagle", "cw_frag_grenade", "car_bomb", "xyz_user_info", "xyz_suicide_vest", "xyz_suicide_vest_detonator"},
  command = "terroristcmd",
  max = 4,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Terrorist",
})

TEAM_TERRORIST_SNRCMDR = DarkRP.createJob("Terrorist Senior Commander", {
  color = Color(169, 169, 169),
  model = {"models/csgopirate3pm.mdl"},
  description = [[!]],
  weapons = {"cw_ak74", "cw_deagle", "cw_frag_grenade", "car_bomb", "xyz_user_info", "xyz_suicide_vest", "xyz_suicide_vest_detonator"},
  command = "terroristsnrcmd",
  max = 2,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Terrorist",
})

TEAM_TERRORIST_CHIEF = DarkRP.createJob("Terrorist Chief", {
  color = Color(169, 169, 169),
  model = {"models/csgopirate4pm.mdl"},
  description = [[!]],
  weapons = {"cw_ak74", "cw_deagle", "cw_frag_grenade", "car_bomb", "xyz_user_info", "xyz_suicide_vest", "xyz_suicide_vest_detonator"},
  command = "terroristchief",
  max = 1,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Terrorist",
})

TEAM_TERRORIST_COLEAD = DarkRP.createJob("Terrorist Co-Leader", {
  color = Color(169, 169, 169),
  model = {"models/csgopirate2pm.mdl"},
  description = [[!]],
  weapons = {"cw_ak74", "cw_deagle", "cw_frag_grenade", "car_bomb", "xyz_user_info", "xyz_suicide_vest", "xyz_suicide_vest_detonator"},
  command = "terroristcolead",
  max = 1,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Terrorist",
})

TEAM_TERRORIST_LEAD = DarkRP.createJob("Terrorist Leader", {
  color = Color(169, 169, 169),
  model = {"models/csgopirate1pm.mdl"},
  description = [[!]],
  weapons = {"cw_ak74", "cw_deagle", "cw_frag_grenade", "car_bomb", "xyz_user_info", "xyz_suicide_vest", "xyz_suicide_vest_detonator"},
  command = "terroristlead",
  max = 1,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Terrorist",
})

--
-- MAFIA
--

TEAM_SCJRASSOCIATE = DarkRP.createJob("The Mafia Junior Associate", {
  color = Color(0, 175, 130),
  model = {"models/player/suits/male_01_open_waistcoat.mdl"},
  description = [[You are part of the Sinaloa Cartel, follow your godfather and do as he says!]],
  weapons = {},
  command = "scjrassociate",
  max = 5,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "The Mafia",
})

TEAM_SCASSOCIATE = DarkRP.createJob("The Mafia Associate", {
  color = Color(0, 175, 130),
  model = {"models/player/suits/male_02_open_waistcoat.mdl"},
  description = [[You are part of the Sinaloa Cartel, follow your godfather and do as he says!]],
  weapons = {},
  command = "scassociate",
  max = 5,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "The Mafia",
})

TEAM_SCSASSOCIATE = DarkRP.createJob("The Mafia Senior-Associate", {
  color = Color(0, 175, 130),
  model = {"models/player/suits/male_03_open_waistcoat.mdl"},
  description = [[You are part of the Sinaloa Cartel, follow your godfather and do as he says!]],
  weapons = {"cw_mac11", "xyz_drugs_tablet"},
  command = "scsassociate",
  max = 5,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "The Mafia",
})

TEAM_SCHASSOCIATE = DarkRP.createJob("The Mafia Head-Associate", {
  color = Color(0, 175, 130),
  model = {"models/player/suits/male_04_open_waistcoat.mdl"},
  description = [[You are part of the Sinaloa Cartel, follow your godfather and do as he says!]],
  weapons = {"cw_mac11", "xyz_drugs_tablet"},
  command = "schassociate",
  max = 3,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "The Mafia",
})

TEAM_SJRSICARIO = DarkRP.createJob("The Mafia Junior Sicario", {
  color = Color(0, 175, 130),
  model = {"models/player/suits/male_05_open_waistcoat.mdl"},
  description = [[You are part of the Sinaloa Cartel, follow your godfather and do as he says!]],
  weapons = {"cw_mac11", "xyz_drugs_tablet"},
  command = "jrsicario",
  max = 3,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "The Mafia",
})

TEAM_SPOREGIME = DarkRP.createJob("The Mafia Sicario", {
  color = Color(0, 175, 130),
  model = {"models/player/suits/male_06_open_waistcoat.mdl"},
  description = [[You are part of the Sinaloa Cartel, follow your godfather and do as he says!]],
  weapons = {"cw_thompson", "xyz_drugs_tablet"},
  command = "sporegime",
  max = 3,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "The Mafia",
})

TEAM_SSPOREGIME = DarkRP.createJob("The Mafia Senior Sicario", {
  color = Color(0, 175, 130),
  model = {"models/player/suits/male_07_open_waistcoat.mdl"},
  description = [[You are part of the Sinaloa Cartel, follow your godfather and do as he says!]],
  weapons = {"cw_thompson", "xyz_drugs_tablet"},
  command = "ssporegime",
  max = 3,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "The Mafia",
})

TEAM_SCHSPOREGIME = DarkRP.createJob("The Mafia Head Sicario", {
  color = Color(0, 175, 130),
  model = {"models/player/suits/male_08_open_waistcoat.mdl"},
  description = [[You are part of the Sinaloa Cartel, follow your godfather and do as he says!]],
  weapons = {"cw_thompson", "xyz_drugs_tablet"},
  command = "schsaporegime",
  max = 3,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "The Mafia",
})

TEAM_SCCAPOREGIME = DarkRP.createJob("The Mafia Caporegime", {
  color = Color(0, 175, 130),
  model = {"models/player/suits/male_09_closed_coat_tie.mdl"},
  description = [[You are part of the Sinaloa Cartel, follow your godfather and do as he says!]],
  weapons = {"cw_thompson", "xyz_drugs_tablet", "xyz_user_info"},
  command = "sccaporegime",
  max = 3,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "The Mafia",
})

TEAM_LTBOSS = DarkRP.createJob("The Mafia Lieutenant", {
  color = Color(0, 175, 130),
  model = {"models/player/suits/male_01_closed_coat_tie.mdl"},
  description = [[You are part of the Sinaloa Cartel, follow your godfather and do as he says!]],
  weapons = {"cw_thompson", "xyz_drugs_tablet", "xyz_user_info"},
  command = "ltboss",
  max = 2,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "The Mafia",
})

TEAM_SCUNDERBOSS = DarkRP.createJob("The Mafia Underboss", {
  color = Color(0, 175, 130),
  model = {"models/player/suits/male_02_closed_coat_tie.mdl"},
  description = [[You are part of the Sinaloa Cartel, follow your godfather and do as he says!]],
  weapons = {"cw_thompson", "xyz_drugs_tablet", "xyz_user_info"},
  command = "scunderboss",
  max = 1,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "The Mafia",
})

TEAM_SCBOSS = DarkRP.createJob("The Mafia Boss", {
  color = Color(0, 175, 130),
  model = {"models/player/suits/male_03_closed_coat_tie.mdl"},
  description = [[You are part of the Sinaloa Cartel, follow your godfather and do as he says!]],
  weapons = {"cw_thompson", "cw_mr96", "xyz_drugs_tablet", "xyz_user_info"},
  command = "scboss",
  max = 1,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "The Mafia",
})

TEAM_SCCONSIGLIERE = DarkRP.createJob("The Mafia Consigliere", {
  color = Color(0, 175, 130),
  model = {"models/player/suits/male_04_closed_coat_tie.mdl"},
  description = [[You are part of the Sinaloa Cartel, follow your godfather and do as he says!]],
  weapons = {"cw_thompson", "cw_mr96", "xyz_drugs_tablet", "xyz_user_info"},
  command = "sccon",
  max = 1,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "The Mafia",
})

TEAM_SCGODFATHER = DarkRP.createJob("The Mafia Godfather", {
  color = Color(0, 175, 130),
  model = {"models/vito.mdl"},
  description = [[You run the cartel!]],
  weapons = {"cw_thompson", "cw_mr96", "xyz_drugs_tablet", "xyz_user_info"},
  command = "scgodboss",
  max = 1,
  salary = 75,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "The Mafia",
})

--
-- Fire & Rescue
--

TEAM_FR_CF = DarkRP.createJob("Candidate Firefighter", {
  color = Color(222, 9, 9),
  model = {"models/gta5/fire1.mdl"},
  description = [[ . ]],
  weapons = {},
  command = "frcf",
  max = 0,
  salary = 400,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Fire & Rescue",
})

TEAM_FR_JF = DarkRP.createJob("Junior Firefighter", {
  color = Color(222, 9, 9),
  model = {"models/gta5/fire1.mdl"},
  description = [[ . ]],
  weapons = {"xyz_fire_axe"},
  command = "frjf",
  max = 0,
  salary = 400,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Fire & Rescue",
})

TEAM_FR_F = DarkRP.createJob("Firefighter", {
  color = Color(222, 9, 9),
  model = {"models/gta5/fire1.mdl"},
  description = [[ . ]],
  weapons = {"xyz_fire_axe"},
  command = "frf",
  max = 0,
  salary = 400,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Fire & Rescue",
})

TEAM_FR_SF = DarkRP.createJob("Senior Firefighter", {
  color = Color(222, 9, 9),
  model = {"models/gta5/fire1.mdl"},
  description = [[ . ]],
  weapons = {"xyz_fire_axe"},
  command = "frsf",
  max = 0,
  salary = 400,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Fire & Rescue",
})

TEAM_FR_E = DarkRP.createJob("Engineer", {
  color = Color(222, 9, 9),
  model = {"models/gta5/fire6.mdl"},
  description = [[ . ]],
  weapons = {"xyz_fire_axe", "xyz_hose"},
  command = "fre",
  max = 0,
  salary = 400,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Fire & Rescue",
})

TEAM_FR_SE = DarkRP.createJob("Senior Engineer", {
  color = Color(222, 9, 9),
  model = {"models/gta5/fire6.mdl"},
  description = [[ . ]],
  weapons = {"xyz_fire_axe", "xyz_hose"},
  command = "frse",
  max = 0,
  salary = 400,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Fire & Rescue",
})

TEAM_FR_SUP = DarkRP.createJob("Supervisor", {
  color = Color(222, 9, 9),
  model = {"models/gta5/fire5.mdl"},
  description = [[ . ]],
  weapons = {"xyz_fire_axe", "xyz_user_info", "xyz_hose"},
  command = "frsup",
  max = 0,
  salary = 400,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Fire & Rescue",
})

TEAM_FR_LT = DarkRP.createJob("Lieutenant", {
  color = Color(222, 9, 9),
  model = {"models/gta5/fire5.mdl"},
  description = [[ . ]],
  weapons = {"xyz_fire_axe", "xyz_user_info", "xyz_hose"},
  command = "frlt",
  max = 0,
  salary = 400,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Fire & Rescue",
})

TEAM_FR_CPT = DarkRP.createJob("Captain", {
  color = Color(222, 9, 9),
  model = {"models/gta5/fire5.mdl"},
  description = [[ . ]],
  weapons = {"xyz_fire_axe", "xyz_user_info", "xyz_hose"},
  command = "frcpt",
  max = 0,
  salary = 400,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Fire & Rescue",
})

TEAM_FR_BC = DarkRP.createJob("Battalion Chief", {
  color = Color(222, 9, 9),
  model = {"models/gta5/fire4.mdl"},
  description = [[ . ]],
  weapons = {"xyz_fire_axe", "xyz_user_info", "xyz_hose"},
  command = "frbc",
  max = 0,
  salary = 400,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Fire & Rescue",
})

TEAM_FR_DC = DarkRP.createJob("Deputy Chief", {
  color = Color(222, 9, 9),
  model = {"models/gta5/fire3.mdl"},
  description = [[ . ]],
  weapons = {"xyz_fire_axe", "xyz_user_info", "xyz_hose"},
  command = "frdc",
  max = 0,
  salary = 400,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Fire & Rescue",
})

TEAM_FR_AC = DarkRP.createJob("Assistant Chief", {
  color = Color(222, 9, 9),
  model = {"models/gta5/fire2.mdl"},
  description = [[ . ]],
  weapons = {"xyz_fire_axe", "xyz_user_info", "xyz_hose"},
  command = "frac",
  max = 0,
  salary = 400,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Fire & Rescue",
})

TEAM_FR_FC = DarkRP.createJob("Fire Chief", {
  color = Color(222, 9, 9),
  model = {"models/gta5/fire1.mdl"},
  description = [[ . ]],
  weapons = {"xyz_fire_axe", "xyz_user_info", "xyz_hose"},
  command = "frfc",
  max = 0,
  salary = 400,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Fire & Rescue",
})


--
-- Custom Job
--

-- TEAM_DARTH_VADER = DarkRP.createJob("Darth Vader", {
--   color = Color(0,0,0,255),
--   model = {"models/player/darth_vader.mdl"},
--   description = [[ The Dark Lord Has come to find your Kids! ]],
--   weapons = {"keypad_cracker", "lockpick", "pro_lockpick_update"},
--   command = "Darth",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

-- TEAM_SPECIALSNOWFLAKE = DarkRP.createJob("SpecialSnowFlake", {
--   color = Color(255,255,255,255),
--   model = {"models/jazzmcfly/rwby/weiss_schnee.mdl"},
--   description = [[ You just had to go and be the special snow flake in the group so go be special.]],
--   weapons = {"keypad_cracker", "lockpick", "pro_lockpick_update"},
--   command = "sspecialsf",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

-- TEAM_ANONYMOUS_OWNER = DarkRP.createJob("Anonymous OWNER", {
--   color = Color(60,255,0,255),
--   model = {"models/player/anonymous_hacktivist.mdl"},
--   description = [[ ANONYMOUS  leader ]],
--   weapons = {"keypad_cracker", "lockpick", "pro_lockpick_update", "cw_m3super90","weapon_handcuffs"},
--   command = "anonymous_owner",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

-- TEAM_FALCON_LEADER = DarkRP.createJob("Falcon Leader", {
--   color = Color(199,50,142,255),
--   model = {"models/player/pmc_1/pmc__01.mdl"},
--   description = [[ You lead the group, Falcon. All Falcons must follow your every command or elts you can kill them. You can team with any group and you bring the full force of Falcon ]],
--   weapons = {"keypad_cracker", "lockpick", "pro_lockpick_update", "cw_l85a2"},
--   command = "Falcon",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })


-- TEAM_SPEEDY_GONZALES = DarkRP.createJob("Speedy Gonzales", {
--   color = Color(0,21,247,255),
--   model = {"models/player/rick/rick.mdl"},
--   description = [[ It's a mix of speedy gonzales and a drug dealr cooks meth and can sell it and can help other mexicans i.e crips to help them make money or assist in raids. ]],
--   weapons = {"keypad_cracker", "lockpick", "pro_lockpick_update"},
--   command = "sp2001",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })


-- TEAM_DAFFY_DUCK = DarkRP.createJob("Daffy Duck", {
--   color = Color(255,128,0,255),
--   model = {"models/player/dduck/daffyduck.mdl"},
--   description = [[ The dangerous Duck will hunt you in your sleep ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_vss","weapon_handcuffs"},
--   command = "daffy",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

-- TEAM_DFC_COL = DarkRP.createJob("DFC COL", {
--   color = Color(0,255,55,255),
--   model = {"models/player/ncrreddeathranger/reddeathranger/red_death_ranger.mdl"},
--   description = [[ DELTA FORCE COMMANDO COL you are delta force the most elite around you will work random jobs for money with other delta force.]],
--   weapons = {"keypad_cracker", "lockpick", "cw_l85a2","cw_g18"},
--   command = "DFC",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

-- TEAM_LORD = DarkRP.createJob("Lord", {
--   color = Color(77,50,199,255),
--   model = {"models/player/demon_violinist/demon_violinist.mdl"},
--   description = [[ A lord from the underworld ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_l115","weapon_handcuffs","weapon_handcuffs"},
--   command = "Lord",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

-- TEAM_FREELANCER = DarkRP.createJob("Cross Knight", {
--   color = Color(202,0,252,255),
--   model = {"models/player/suits/male_01_closed_coat_tie.mdl"},
--   description = [[ Your a FreeLancer, A man who can be brought to Assist. ]],
--   weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick"},
--   command = "FreeLancer",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

-- TEAM_HAN_SOLO = DarkRP.createJob("Han Solo", {
--   color = Color(100,0,176,255),
--   model = {"models/player/han_solo.mdl"},
--   description = [[ Han Solo, captain of the Millennium Falcon, was one of the great leaders of the Rebel Alliance. Then crashed his ship into the XZY community to rape kids with his co-pilot, Chewbacca]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ar15","cw_m3super90"},
--   command = "hansolo",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

-- TEAM_WARFRAME = DarkRP.createJob("Warframe", {
--   color = Color(0,0,0,255),
--   model = {"models/excalibur/excalibur.mdl"},
--   description = [[ Warframe is an alien, can print are like an prothief some times nice, but not always m]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ar15", "cw_m3super90", "cw_l115"},
--   command = "warframe69",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

-- TEAM_CARTEL_ENFORCER = DarkRP.createJob("Cartel Enforcer", {
--   color = Color(50,80,199,255),
--   model = {"models/joshers/badasses/playermodels/barney.mdl"},
--   description = [[ A Cartel Enforcer Who Helps The Cartel]],
--   weapons = {"pro_lockpick_update", "keypad_cracker", "lockpick", "cw_mr96", "weapon_handcuffs", "cw_m3super90"},
--   command = "123LK",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

-- TEAM_KIDNAPPER_WITH_GUN_LICENSE = DarkRP.createJob("Kidnapper with gun license", {
--   color = Color(0,0,0,255),
--   model = {"models/player/lulsec.mdl"},
--   description = [[ Kidnapper witha gun ]],
--   weapons = {"keypad_cracker", "lockpick", "weapon_handcuffs"},
--   command = "kidnapcc",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })


-- TEAM_VOLDEMORT = DarkRP.createJob("Voldemort", {
--   color = Color(240,0,84,255),
--   model = {"models/player/lord_voldemort.mdl"},
--   description = [[ Do bad stuff ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_m3super90","weapon_handcuffs"},
--   command = "vold123",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

-- TEAM_MERCENARY = DarkRP.createJob("Mercenary", {
--   color = Color(100,100,100,255),
--   model = {"models/player/lordvipes/rerc_vector/vector_cvp.mdl"},
--   description = [[ A deadly mercenary with a trained eye to hit every shot he takes! ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_deagle", "cw_g3a3", "cw_m3super90"},
--   command = "mercenary",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

-- TEAM_RUSSIANSPETZNAZCOMMANDER = DarkRP.createJob("Russian Spetznaz Commander", {
--   color = Color(0,0,0,255),
--   model = {"models/omonup/rus/soldier_a.mdl"},
--   description = [[ A highly trained commando that has access to heavy Weapon and Equipment to handle most problems that may arrise and Soldiers below him will follow without question ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_deagle", "cw_ak74", "cw_vss"},
--   command = "spetznaz",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

-- TEAM_PICKLE_RICK = DarkRP.createJob("Pickle Rick", {
--   color = Color(250,7,64,255),
--   model = {"models/player/rick/rick.mdl"},
--   description = [[ I'm pickle rick! ]],
--   weapons = {"keypad_cracker", "lockpick", "weapon_handcuffs","weapon_handcuffs"},
--   command = "kesla",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })


-- TEAM__AGENT_BHK = DarkRP.createJob("Agent BHK", {
--   color = Color(240,5,44,255),
--   model = {"models/joshers/badasses/playermodels/gman_closed.mdl"},
--   description = [[ Agent BHK is a criminal mastermind. ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ak74","cw_ar15"},
--   command = "becomeBHK",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

-- TEAM_SPECIAL_FORCES_OPERATOR = DarkRP.createJob("Military Police", {
--   color = Color(0,0,0,255),
--   model = {"models/sentry/mp01.mdl"},
--   description = [[ Military Police ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ar15","cw_m3super90","cw_p99"},
--   command = "maxd_operator",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })


-- TEAM_REAPER = DarkRP.createJob("Reaper", {
--   color = Color(0,0,0,255),
--   model = {"models/player/ncrreddeathranger/reddeathranger/red_death_ranger.mdl"},
--   description = [[ The reaper is coming! You better hide... ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_m3super90"},
--   command = "reaper_job",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

-- TEAM_STARLORD = DarkRP.createJob("Star Lord", {
--     color = Color(200,86,23,255),
--     model = {"models/player/x227man/starlord.mdl"},
--     description = [[ I am the Star Lord. Obey me or you will die or something like that.. ]],
--     weapons = {"keypad_cracker", "lockpick", "cw_l85a2", "cw_m3super90"},
--     command = "starlord",
--     max = 1,
--     salary = 100,
--     admin = 0,
--     vote = false,
--     hasLicense = false,
--     category = "Custom Job"
-- })

TEAM_OLAF = DarkRP.createJob("Olaf", {
    color = Color(255,0,238,255),
    model = {"models/player/x227man/olaf.mdl"},
    description = [[ Olaf lads! ]],
    weapons = {"keypad_cracker", "lockpick", "cw_scarh","cw_m1911"},
    command = "olaf",
    max = 1,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Custom Job"
})

-- TEAM_TONY_SCARFACE_MONTANA = DarkRP.createJob("Tony Scarface Montana", {
--   color = Color(255,204,0,255),
--   model = {"models/player/korka007/tony.mdl"},
--   description = [[ In the spring of 1980, the port at Cuba's Mariel Harbor was opened, and thousands set sail for the United States. They came in search of the American Dream. One of them found it on the sun-washed avenues of Miami -- wealth, power and passion beyond his wildest dreams. He was Tony Montana. The world will remember him by another name -- Scarface.]],
--   weapons = {"pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15","cw_mac11","cw_makarov"},
--   command = "sf",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

-- TEAM_EXPLOITER = DarkRP.createJob("Exploiter", {
--   color = Color(0,255,242,255),
--   model = {"models/player/x227man/starlord.mdl"},
--   description = [[ Kill, Destroy, and Thrive to take control. ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_m3super90"},
--   command = "exploiter",
--   max = 3,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

-- TEAM_VETERAN = DarkRP.createJob("Veteran", {
--   color = Color(99,99,99,255),
--   model = {"models/player/eli.mdl"},
--   description = [[ You're so old, geez ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_l115","cw_mr96","cw_vss"},
--   command = "veteran",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

TEAM_DEAMON = DarkRP.createJob("Deamon", {
  color = Color(255,0,238,255),
  model = {"models/fearless/sru01.mdl"},
  description = [[ You're a deamon. ]],
  weapons = {"keypad_cracker", "lockpick", "cw_scarh","cw_mr96","weapon_handcuffs"},
  command = "deamon",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "Custom Job"
})



TEAM_TERMINATOR_KANE = DarkRP.createJob("Terminator", {
  color = Color(255,255,255,255),
  model = {"models/player/t-831/t831.mdl"},
  description = [[ South Side init bruv ]],
  weapons = {"keypad_cracker", "lockpick", "weapon_handcuffs", "cw_ar15"},
  command = "terminatork",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Custom Job"
})

-- TEAM_ASTABOI = DarkRP.createJob("RASTABOI", {
--   color = Color(67,199,50,255),
--   model = {"models/oldbill/rasta_male.mdl"},
--   description = [[ I get high and fuck people up ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ak74","weapon_handcuffs","weapon_handcuffs"},
--   command = "Blazeup",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

-- TEAM_FRANKLIN = DarkRP.createJob("Franklin", {
--   color = Color(0,255,4,255),
--   model = {"models/grandtheftauto5/franklin.mdl"},
--   description = [[ Young gangster from the hood 'bout to clap bunch of paigans ]],
--   weapons = {"keypad_cracker", "lockpick", "weapon_handcuffs"},
--   command = "Franklin1967",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

TEAM_HAN_SOLO = DarkRP.createJob("Trevor", {
  color = Color(100,0,176,255),
  model = {"models/grandtheftauto5/trevor.mdl"},
  description = [[ From the city of Los Santos Michael has decide to move to the XYZ community to help Franklin and Michael RAPE little kids ]],
  weapons = {"keypad_cracker", "lockpick", "cw_ar15", "cw_sv98", "weapon_handcuffs"},
  command = "trevor",
  max = 2,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Custom Job"
})

-- TEAM_CHEWBACCA = DarkRP.createJob("Chewbacca", {
--   color = Color(148,82,6,255),
--   model = {"models/player/chewie.mdl"},
--   description = [[ help han solo ]],
--   weapons = {"keypad_cracker", "lockpick"},
--   command = "Chewie",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

-- TEAM_CARTEL_INFORMANT = DarkRP.createJob("Cartel Informant", {
--   color = Color(64,201,10,255),
--   model = {"models/sentry/mp01.mdl"},
--   description = [[ Cartel informant infiltrates gangs and the PD ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_fiveseven"},
--   command = "scinfo",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

-- TEAM_CARTEL_KIDNAPPER = DarkRP.createJob("Cartel Kidnapper", {
--   color = Color(84,99,99,255),
--   model = {"models/joshers/badasses/playermodels/gordon.mdl"},
--   description = [[ This is a member of the Cartel De Sinaloa which is tasked with taking hostages and holding them for ransom. ]],
--   weapons = {"keypad_cracker", "lockpick", "weapon_handcuffs","cw_m3super90"},
--   command = "sckidnapper",
--   max = 2,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

TEAM_THE_PLAGUE_DOCTOR = DarkRP.createJob("Vector", {
  color = Color(255,0,0,255),
  model = {"models/player/suits/male_09_closed_coat_tie.mdl"},
  description = [[ Some Crazy Doctors. ]],
  weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_scarh","weapon_handcuffs","cw_sv98"},
  command = "tpd",
  max = 2,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "Custom Job"
})

-- TEAM_KILLER = DarkRP.createJob("killer", {
--   color = Color(50,199,82,255),
--   model = {"models/player/corpse1.mdl"},
--   description = [[ lol123 ]],
--   weapons = {"keypad_cracker", "lockpick"},
--   command = "killer",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })


-- TEAM_OODY = DarkRP.createJob("Woody", {
--   color = Color(255,128,0,255),
--   model = {"models/player/woody.mdl"},
--   description = [[ I am woody ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ak74","cw_l115","weapon_handcuffs"},
--   command = "woody",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

-- TEAM_DC_DENTON = DarkRP.createJob("JC Denton", {
--   color = Color(0,140,255,255),
--   model = {"models/player/lordvipes/de_jc/jcplayer.mdl"},
--   description = [[ A Nano-Augmented UNATCO Agent, combating the NSF terrorists that plague the streets. ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_shorty","cw_vss","weapon_handcuffs"},
--   command = "deusex",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_VIGILANTE = DarkRP.createJob("Vigilante", {
--   color = Color(65,123,125,255),
--   model = {"models/player/corpse1.mdl"},
--   description = [[ Hand out raw justice when there's no justice left. ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_g3a3","cw_l85a2","cw_mr96"},
--   command = "jobvigilante",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })


TEAM_NONCE = DarkRP.createJob("Nonce", {
  color = Color(161,61,186,255),
  model = {"models/player/lord_voldemort.mdl"},
  description = [[.]],
  weapons = {"keypad_cracker", "lockpick", "weapon_handcuffs", "cw_m3super90"},
  command = "BecomeNonce",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Custom Job"
})


-- TEAM_PETER_GRIFFIN = DarkRP.createJob("Peter Griffin", {
--   color = Color(255,0,0,255),
--   model = {"models/peterg/peterg.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ak74","cw_l115"},
--   command = "petergriffin",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })


-- TEAM_NONCE_FOLLOWER = DarkRP.createJob("Nonce Follower", {
--   color = Color(145,0,255,255),
--   model = {"models/kerry/merriweather3.mdl"},
--   description = [[ A nonce follower job is to follow the nonce ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ar15","weapon_handcuffs","cw_m3super90"},
--   command = "nfollow",
--   max = 2,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })


TEAM_SAINSBURYS_FOOD_MANAGER = DarkRP.createJob("Sainsburys Food Manager", {
  color = Color(6,13,18,255),
  model = {"models/player/woody.mdl"},
  description = [[ For the big man ting Melt init. ]],
  weapons = {"keypad_cracker", "lockpick", "cw_scarh","weapon_handcuffs","cw_m3super90"},
  command = "FoodManager",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Custom Job"
})

TEAM_AGENT_LEGEND = DarkRP.createJob("Morgan Freeman", {
  color = Color(255, 0, 0),
  model = {"models/rottweiler/freeman.mdl"},
  description = [[ . ]],
  weapons = {"keypad_cracker", "lockpick", "cw_ar15", "cw_sv98", "weapon_handcuffs", "pro_lockpick_update", "prokeypadcracker"},
  command = "agentlegend",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "Custom Job"
})

-- TEAM_76561198355765163_FROG = DarkRP.createJob("Frog", {
--   color = Color(33,153,17,255),
--   model = {"models/player/lord_voldemort.mdl"},
--   description = [[ A beautiful little fella, its strong but also really cute. ]],
--   weapons = {"keypad_cracker", "lockpick"},
--   command = "frogsfrog",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })


-- TEAM_GRIM_REAPER = DarkRP.createJob("Grim Reaper", {
--   color = Color(122,32,171,255),
--   model = {"models/grim.mdl"},
--   description = [[ The Death Reaper that Will Murder every 5 minutes and will Kill Anyone that dare shoot a weapon at him or his Family. Model Wanted Is ]],
--   weapons = {"keypad_cracker", "lockpick"},
--   command = "GrimReaper",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

-- TEAM_PRIVATE_SECURITY_DIRECTOR = DarkRP.createJob("Private Security Director", {
--   color = Color(0,0,0,255),
--   model = {"models/kerry/merriweather8.mdl"},
--   description = [[ You are Private Security Director. Go protect some people. This model: The one with weapon and vest etc. ]],
--   weapons = {"keypad_cracker", "lockpick"},
--   command = "psd",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })


TEAM_JEFF_THE_KILLER = DarkRP.createJob("Jeff The Killer", {
  color = Color(255,0,0,255),
  model = {"models/newinfec/newhun.mdl"},
  description = [[ Kidnap, Take hostages and do everything illegal ]],
  weapons = {"keypad_cracker", "lockpick", "cw_deagle", "weapon_handcuffs"},
  command = "Jeff",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Custom Job"
})


-- TEAM_EXTRA_THIEF = DarkRP.createJob("Extra Thief", {
--   color = Color(138,28,138,255),
--   model = {"models/player/phoenix.mdl"},
--   description = [[ xd ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_scarh", "cw_shorty", "cw_vss"},
--   command = "extrathief",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })


-- TEAM_MEXICAN_MURDERER = DarkRP.createJob("Mexican Murderer", {
--   color = Color(255,0,0,255),
--   model = {"models/player/corpse1.mdl"},
--   description = [[ Kill All Da Mexicans And Build Big Walls ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_p99"},
--   command = "mexicanmurderer",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

-- TEAM_SATAN = DarkRP.createJob("Kingpin", {
--   color = Color(150,0,0,255),
--   model = {"models/player/slow/jamis/kingpin/slow_v2.mdl"},
--   description = [[ The devil himself. ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_shorty","weapon_handcuffs","cw_m3super90"},
--   command = "satan",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_MERRYWEATHER_SECURITY = DarkRP.createJob("Merryweather Security", {
--   color = Color(112,0,0,255),
--   model = {"models/kerry/merriweather4.mdl"},
--   description = [[ Merryweather Security is a mercenary/covert operations group mostly with ex-criminals, ex-military, or people looking for a high paying yet risk-setting job. Merryweather are mostly looked at as criminals for their undercover illegal activities such as drug trafficking, illegal money printing, so on. They are able to host street races and make car meets. They can raid, mug, carjack, kidnap, and steal as well. So if Merryweather is on you, ya better start running! ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ar15","cw_m3super90","weapon_handcuffs"},
--   command = "mws",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_DWAD = DarkRP.createJob("Dwad", {
--     color = Color(61, 123, 168, 255),
--   model = {"models/player/phoenix.mdl"},
--   description = [[ dwad ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_vss", "cw_ak74", "cw_ar15"},
--   command = "dwadaw",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_SPIDERMAN = DarkRP.createJob("Spiderman", {
--     color = Color(255,0,255,255),
--     model = {"models/kryptonite/spiderman_2/spiderman_2.mdl"},
--     description = [[ . ]],
--     weapons = {"keypad_cracker", "lockpick", "cw_scarh","weapon_handcuffs"},
--     command = "spide",
--     max = 2,
--     salary = 100,
--     admin = 0,
--     vote = false,
--     hasLicense = false,
--     category = "Custom Job",
--     PlayerSpawn = function(ply)
--       ply:SetArmor(100)
--     end
-- })

-- TEAM_BELGIAN_IMMIGRANT = DarkRP.createJob("Belgian Immigrant", {
--   color = Color(82,77,26,255),
--   model = {"models/csgobalkan2pm.mdl"},
--   description = [[ You are a rich immigrant from Belgium ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_scarh","cw_l85a2"},
--   command = "BelgianImmigrant",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_PHAT_KINGPIN = DarkRP.createJob("Phat Kingpin", {
--   color = Color(0,217,255,255),
--   model = {"models/grim.mdl"},
--   description = [[ We are the phat rule of the city. ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ak74","cw_m3super90","weapon_handcuffs"},
--   command = "phat",
--   max = 2,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_IRISH_REPUBLICAN_ARMY = DarkRP.createJob("Irish Republican Army", {
--   color = Color(21,255,0,255),
--   model = {"models/mfc_new.mdl"},
--   description = [[ irish republican army fights for the freedom of the irish people ]],
--   weapons = {"cw_scarh","cw_l85a2","weapon_handcuffs"},
--   command = "IRA",
--   max = 3,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_SCAR_FACE = DarkRP.createJob("Cult Leader", {
--   color = Color(0,247,255,255),
--   model = {"models/grim.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick", "weapon_handcuffs"},
--   command = "scarface",
--   max = 2,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })


-- TEAM_JESUS = DarkRP.createJob("Jesus", {
--   color = Color(172,199,50,255),
--   model = {"models/player/jesus/jesus.mdl"},
--   description = [[ Become the son of God! ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ak74", "weapon_handcuffs"},
--   command = "Jesus",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_ARCHER = DarkRP.createJob("Archer", {
--   color = Color(43,51,44,255),
--   model = {"models/winningrook/archer/archer/archer.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ar15","cw_makarov","weapon_handcuffs"},
--   command = "MRArcher",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_SPEEDY_GONZALES = DarkRP.createJob("Sonora Cartel", {
--   color = Color(0,21,247,255),
--   model = {"models/sd/players/[dbs_quick]-head_quick_dbs_2.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick"},
--   command = "sp2001",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

TEAM_TERRORIST_JUGGERNAUT = DarkRP.createJob("Terrorist Juggernaut", {
  color = Color(0,0,0,255),
  model = {"models/player/gasmask.mdl"},
  description = [[76561198158871562]],
  weapons = {"keypad_cracker", "lockpick", "cw_l85a2","cw_mr96"},
  command = "TerroristJug",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Custom Job",
  PlayerSpawn = function(ply)
    ply:SetArmor(100)
  end
})

-- TEAM_ILLEGAL_MEXICAN_IMMIGRANT = DarkRP.createJob("Illegal Mexican Immigrant", {
--   color = Color(255,166,0,255),
--   model = {"models/Humans/Group03/male_08.mdl"},
--   description = [[ An illegal Mexican immigrant. male17 ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ak74"},
--   command = "mexican",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })        

-- TEAM_PRIVATE_SECURITY = DarkRP.createJob("Private Security", {
--   color = Color(0,2,3,255),
--   model = {"models/player/gasmask.mdl"},
--   description = [[ This job make Security to the peopleSkin: Juggernaut ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_l85a2","cw_mr96"},
--   command = "Security",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_GOD = DarkRP.createJob("God", {
--   color = Color(150,150,150,255),
--   model = {"models/koz/lotr/gandalf/gandalf.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ar15", "weapon_handcuffs"},
--   command = "godjobfam",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_VETERAN = DarkRP.createJob("Veteran", {
--   color = Color(99,99,99,255),
--   model = {"models/player/eli.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_l115","cw_mr96","cw_vss"},
--   command = "veteran",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_76561198183380306_MATTS_SMALL_INSIDE = DarkRP.createJob("Matts Small Inside", {
--   color = Color(255,0,255,255),
--   model = {"models/dawn/dawn_player.mdl"},
--   description = [[ OOF https://steamcommunity.com/sharedfiles/filedetails/?id=311927049 ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_scarh","cw_fiveseven","weapon_handcuffs"},
--   command = "mattstiny",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_POPE_FRANCIS = DarkRP.createJob("Pope Francis", {
--   color = Color(0,4,8,255),
--   model = {"models/t37/papaj.mdl"},
--   description = [[ your mom is big religion lol ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_m3super90"},
--   command = "pope",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })


-- TEAM_COCONUT = DarkRP.createJob("Coconut", {
--   color = Color(72,0,255,255),
--   model = {"models/jazzmcfly/nekopara/coco/coco_player.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_l85a2","cw_shorty","weapon_handcuffs"},
--   command = "Coconut",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })


-- TEAM_COW = DarkRP.createJob("Cow", {
--   color = Color(112,112,112,255),
--   model = {"models/tsbb/animals/cow.mdl"},
--   description = [[ The Cow Goes Moo ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ak74","cw_p99"},
--   command = "moo",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_ICE_CUBE = DarkRP.createJob("ice cube", {
--   color = Color(0,0,0,255),
--   model = {"models/player/Group01/male_03.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ak74","cw_p99", "cw_ak74","cw_makarov","weapon_handcuffs"},
--   command = "nwa",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })


-- TEAM_BORDER_PATROL = DarkRP.createJob("Border Patrol", {
--    color = Color(255,0,0,255),
--   model = {"models/mfc_new.mdl"},
--   description = [[ Works with the pd ]],
--   weapons = {"keypad_cracker", "lockpick", "weapon_handcuffs"},
--   command = "borderpatrol",
--   max = 2,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_ENFORCER = DarkRP.createJob("Enforcer", {
--   color = Color(0,175,130,255),
--   model = {"models/mark2580/payday2/pd2_swat_shield_zeal_player.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ak74", "cw_deagle"},
--   command = "enforcer",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_EXPLOITER = DarkRP.createJob("Exploiter", {
--   color = Color(0,255,242,255),
--     model = {"models/player/x227man/starlord.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_m3super90"},
--   command = "exploiter",
--   max = 2,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

-- TEAM_MAFIA_COMMANDER = DarkRP.createJob("Mafia commander", {
--   color = Color(0,17,250,255),
--   model = {"models/player/suits/male_08_closed_tie.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ak74"},
--   command = "commander",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

-- TEAM_KIDNAPPERS_OF_ROCKFORD = DarkRP.createJob("Kidnappers Of Rockford", {
--   color = Color(199,50,50,255),
--   model = {"models/player/pd2_chains_p.mdl"},
--   description = [[ We Kidnap The People Of Rockford. Steal Cars. Get Money By Money Printing. What. A Criminal Does And I Want The Pro Thief Skin Model ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ar15","cw_shorty","weapon_handcuffs"},
--   command = "JobKidnapper",
--   max = 2,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })

-- TEAM_SUPREME_THIEF = DarkRP.createJob("Supreme Thief", {
--   color = Color(0,149,255,255),
--   model = {"models/player/arctic.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick", "weapon_handcuffs"},
--   command = "supreme",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

TEAM_DEATHBRINGER = DarkRP.createJob("German Obergruppenführer Death", {
  color = Color(255,0,0,255),
  model = {"models/player/dod_german.mdl"},
  description = [[Death is gay]],
  weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15", "cw_vss", "cw_l115", "weapon_handcuffs", "cw_shorty", "cw_sv98", "cw_ak74"},
  command = "deathbringer",
  max = 3,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "Custom Job"
})

-- TEAM_CROWBAR_BOI = DarkRP.createJob("Baby Driver", {
--   color = Color(182,0,199,255),
--   model = {"models/player/Group01/male_02.mdl"},
--   description = [[ . ]],
--   weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_sv98","cw_l85a2","weapon_handcuffs"},
--   command = "Crowbarboi",
--   max = 2,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })
    
-- TEAM_GNOMEHELPER = DarkRP.createJob("Gnome Helper", {
--   color = Color(219,116,7,255),
--   model = {"models/bellkiller.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_l115","cw_m3super90","weapon_handcuffs"},
--   command = "gnomehelper",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job",
--   PlayerSpawn = function(ply)
--     ply:SetArmor(100)
--   end
-- })
          
-- TEAM_THE_PROFESSIONAL = DarkRP.createJob("The Professional", {
--     color = Color(240,0,252,255),
--     model = {"models/player/suits/robber_open.mdl"},
--     description = [[ models/player/suits/robber_open.mdl ]],
--     weapons = {"keypad_cracker", "lockpick", "cw_ar15","cw_shorty","weapon_handcuffs"},
--     command = "profess",
--     max = 1,
--     salary = 100,
--     admin = 0,
--     vote = false,
--     hasLicense = true,
-- 	category = "Custom Job",
-- 	PlayerSpawn = function(ply)
-- 		ply:SetArmor(100)
-- 	end
-- })

TEAM_LOGAN_PAUL = DarkRP.createJob("Logan Paul", {
	color = Color(255,0,200,255),
	model = {"models/player/suits/robber_open.mdl"},
	description = [[ Dab on the haters ]],
	weapons = {"keypad_cracker", "lockpick", "weapon_handcuffs"},
	command = "yayeet",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Custom Job"
})

-- TEAM_DEATH_cc = DarkRP.createJob("Death", {
--   color = Color(232,0,46,255),
--   model = {"models/dawson/death_a_grim_bundle_pms/death/death.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ar15","cw_vss","weapon_handcuffs"},
--   command = "death",
--   max = 2,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

TEAM_PEEN = DarkRP.createJob("Peen", {
	color = Color(0,247,255,255),
	model = {"models/player/skeleton.mdl"},
	description = [[ . ]],
	weapons = {"keypad_cracker", "lockpick", "cw_ar15","cw_deagle","cw_l115"},
	command = "peen",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

TEAM_ANTIMINGE = DarkRP.createJob("Anti-Minge", {
	color = Color(0,247,255,255),
	model = {"models/player/charple.mdl"},
	description = [[ . ]],
	weapons = {"prokeypadcracker", "keypad_cracker", "pro_lockpick_update", "lockpick", "cw_ar15", "weapon_handcuffs"},
	command = "antiminge",
	max = 5,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

TEAM_PUSSAY_PATROL = DarkRP.createJob("Pussay Patrol", {
  color = Color(114,45,179,255),
  model = {"models/player/suits/male_09_closed_coat_tie.mdl"},
  description = [[ Description: Our character will have a Mafia Godfather skin, with a Light Subtle Purple color, Our job is gonna be a criminal who can do all activities that a thief can. ]],
  weapons = {"keypad_cracker", "lockpick", "cw_ar15", "weapon_handcuffs"},
  command = "pussaypatrol",
  max = 2,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = false,
  PlayerSpawn = function(ply) ply:SetSkin(14) end,
  category = "Custom Job"
})

TEAM_SNOWMAN = DarkRP.createJob("Chicken Nugget", {
	color = Color(58,160,232,255),
  model = {"models/freeman/giant_mcnugget.mdl"},
	description = [[ SNOWMAN ]],
	weapons = {"weapon_handcuffs","prokeypadcracker", "keypad_cracker", "pro_lockpick_update", "lockpick", "cw_ar15","cw_sv98","cw_ak74"},
	command = "snowman",
	max = 5,
	salary = 200,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Custom Job"
})


-- TEAM_ORANGE = DarkRP.createJob("Orange", {
-- 	color = Color(255,106,0,255),
-- 	model = {"models/player/kmx/jellik/jellik.mdl"},
-- 	description = [[ Its So Orange ]],
-- 	weapons = {"keypad_cracker", "lockpick", "cw_p99"},
-- 	command = "becomeorange",
-- 	max = 1,
-- 	salary = 100,
-- 	admin = 0,
-- 	vote = false,
-- 	hasLicense = false,
-- 	category = "Custom Job"
-- })

TEAM_HARD_BREXIT = DarkRP.createJob("Zero Two", {
	color = Color(255,133,247,255),
	model = {"models/cyanblue/darlingfranxx/zerotwo/zerotwo.mdl"},
	description = [[ Brexit Means Brexit ]],
	weapons = {"prokeypadcracker", "keypad_cracker", "pro_lockpick_update", "lockpick", "cw_ar15","cw_deagle","weapon_handcuffs"},
	command = "brexit",
	max = 4,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

TEAM_GEERTJUH_W = DarkRP.createJob("James Charles", {
	color = Color(53,66,189,255),
	model = {"models/player/charple.mdl"},
	description = [[ Minder marokannen Skin from Anit-Minge ]],
	weapons = {"prokeypadcracker", "keypad_cracker", "pro_lockpick_update", "lockpick", "cw_vss","weapon_handcuffs", "cw_scarh", "cw_mr96"},
	command = "pvv",
	max = 7,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Custom Job"
})

-- TEAM_MASTER_CHIEF = DarkRP.createJob("Master Chief", {
-- 	color = Color(5,56,0,255),
-- 	model = {"models/player/Rottweiler/mc.mdl"},
-- 	description = [[ Saving Earth ]],
-- 	weapons = {"prokeypadcracker", "keypad_cracker", "pro_lockpick_update", "lockpick", "cw_ak74","cw_deagle","weapon_handcuffs"},
-- 	command = "masterchief",
-- 	max = 1,
-- 	salary = 100,
-- 	admin = 0,
-- 	vote = false,
-- 	hasLicense = false,
-- 	category = "Custom Job"
-- })
            
-- TEAM_EX_MILITARY_VETERAN = DarkRP.createJob("Ex Military Veteran", {
-- 	color = Color(247,0,0,255),
-- 	model = {"models/mfc_new.mdl"},
-- 	description = [[ you have spent 15 years in the military it is now time to switch sides. ]],
--     weapons = {"prokeypadcracker", "keypad_cracker", "pro_lockpick_update", "lockpick", "cw_scarh","cw_l115","weapon_handcuffs"},
--     command = "exvet",
--     max = 1,
--     salary = 100,
--     admin = 0,
--     vote = false,
--     hasLicense = true,
-- 	category = "Custom Job"
-- })

TEAM_ALPHA_GOPNIK = DarkRP.createJob("Alpha Gopnik", {
	color = Color(255,0,0,255),
	model = {"models/player/comradebear/comradebear_gopnik.mdl"},
	description = [[ . ]],
	weapons = {"keypad_cracker", "lockpick", "cw_deagle","cw_vss"},
	command = "alphagopnik",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

TEAM_MR_BLOB = DarkRP.createJob("Mr Blob", {
	color = Color(58,148,74,255),
	model = {"models/player/meeseeks/meeseeks.mdl"},
	description = [[ . ]],
	weapons = {"prokeypadcracker", "keypad_cracker", "pro_lockpick_update", "lockpick", "cw_scarh","cw_vss","weapon_handcuffs"},
	command = "blobman",
	max = 2,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Custom Job"
})


-- TEAM_KLUX_KLAN_MEMBER = DarkRP.createJob("Klux klan member", {
-- 	color = Color(255,255,255,255),
-- 	model = {"models/player/charple.mdl"},
-- 	description = [[ you go around finding people to burn ]],
-- 	weapons = {"keypad_cracker", "lockpick"},
-- 	command = "killem1",
-- 	max = 1,
-- 	salary = 100,
-- 	admin = 0,
-- 	vote = false,
-- 	hasLicense = false,
-- 	category = "Custom Job"
-- })

-- TEAM_KIDNAPPERS = DarkRP.createJob("Kidnappers", {
--   color = Color(13,133,219,255),
--   model = {"models/player/suits/robber_tie.mdl"},
--   description = [[ . ]],
--   weapons = {"prokeypadcracker", "keypad_cracker", "pro_lockpick_update", "lockpick", "cw_ar15", "weapon_handcuffs"},
--   command = "kidnap_custom",
--   max = 3,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

-- TEAM_WAR_MARAUDER = DarkRP.createJob("War Marauder", {
--   color = Color(0,0,0,255),
--   model = {"models/csgoleet2pm.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick", "cw_ak74", "cw_m3super90", "cw_vss"},
--   command = "warmarauder",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })


-- TEAM_FREELANCER = DarkRP.createJob("F.S.U Actual", {
--   color = Color(202,0,252,255),
--   model = {"models/vanquish/player/augmented_reaction_suit.mdl"},
--   description = [[ . ]],
--   weapons = {"keypad_cracker", "lockpick"},
--   command = "fsu_actual",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

TEAM_XXXTENTACION = DarkRP.createJob("XXXTentacion", {
  color = Color(202,0,252,255),
  model = {"models/player/skeleton.mdl"},
  description = [[ . ]],
  weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15", "cw_sv98", "cw_m3super90", "weapon_handcuffs", "cw_deagle" },
  command = "xxx",
  max = 5,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "Custom Job"
})

TEAM_SHOCK_RAIDER = DarkRP.createJob("Shock Raider", {
	color = Color(255,175,0,255),
	model = {"models/player/arctic.mdl"},
	description = [[ . ]],
	weapons = {"keypad_cracker", "lockpick", "cw_scarh", "cw_ar15", "cw_shorty","weapon_handcuffs", "prokeypadcracker", "pro_lockpick_update"},
	command = "sraider",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

-- TEAM_SHAGGY = DarkRP.createJob("Shaggy", {
-- 	color = Color(159,232,12,255),
-- 	model = {"models/shaggypm/shaggypm.mdl"},
-- 	description = [[ Will use 5% of my power if I have to ]],
-- 	weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15", "cw_sv98", "weapon_handcuffs"},
-- 	command = "shaggy",
-- 	max = 1,
-- 	salary = 100,
-- 	admin = 0,
-- 	vote = false,
-- 	hasLicense = true,
-- 	category = "Custom Job"
-- })

-- TEAM_GUCCI_SUPREME = DarkRP.createJob("Gucci Supreme", {
-- 	color = Color(255,0,0,255),
-- 	model = {"models/player/suits/robber_open.mdl"},
-- 	description = [[ Hella Thick Robber_1 ]],
-- 	weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_m3super90","cw_scarh","weapon_handcuffs"},
-- 	command = "gucci",
-- 	max = 1,
-- 	salary = 100,
-- 	admin = 0,
-- 	vote = false,
-- 	hasLicense = true,
-- 	category = "Custom Job"
-- })

-- TEAM_KIDDIE_TAKERS = DarkRP.createJob("Kiddie Takers", {
--   color = Color(0,143,245,255),
--   model = {"models/player/group01/cookies114.mdl"},
--   description = [[ Kid nappers model Elite thief player model ]],
--   weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15","cw_l115","weapon_handcuffs"},
--   command = "kiddietakers",
--   max = 3,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

TEAM_SUICIDE_SQUAD = DarkRP.createJob("Jesus", {
  color = Color(95,79,156,255),
  model = {"models/ninja/pm/lugo_pm.mdl"},
  description = [[ https://steamcommunity.com/sharedfiles/filedetails/?id=500247187 ]],
  weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15","cw_deagle","weapon_handcuffs"},
  command = "suicidesquad",
  max = 5,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "Custom Job"
})

-- TEAM_PUNISHER = DarkRP.createJob("punisher", {
-- 	color = Color(0,0,0,255),
-- 	model = {"models/player/corpse1.mdl"},
-- 	description = [[ not a friendly dude dont get on the wrong side of him ]],
-- 	weapons = {"keypad_cracker", "lockpick", "cw_deagle","cw_l85a2","weapon_handcuffs"},
-- 	command = "punisher99",
-- 	max = 1,
-- 	salary = 100,
-- 	admin = 0,
-- 	vote = false,
-- 	hasLicense = true,
-- 	category = "Custom Job"
-- })

-- TEAM_IRISH_ARMY_RANGER = DarkRP.createJob("Garda", {
-- 	color = Color(20,224,37,255),
-- 	model = {"models/fearless/sru01.mdl"},
-- 	description = [[ The guy in camo or the guy with the fancy hat your call
-- 	thanks <3 ]],
-- 	weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_mr96", "weapon_handcuffs"},
-- 	command = "irisharmyranger",
-- 	max = 1,
-- 	salary = 100,
-- 	admin = 0,
-- 	vote = false,
-- 	hasLicense = false,
-- 	category = "Custom Job"
-- })

TEAM_V4 = DarkRP.createJob("V4", {
	color = Color(20,138,222,255),
  model = {"models/player/smith.mdl"},
	description = [[ agent ]],
	weapons = {"keypad_cracker", "lockpick", "cw_m9"},
	command = "volvo",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Custom Job"
})

TEAM_KNOX = DarkRP.createJob("knox", {
  color = Color(0,0,0,255),
  model = {"models/player/pd2_wolf_p.mdl"},
  description = [[ -wolf model boi xxx ]],
  weapons = {"keypad_cracker", "lockpick", "cw_ar15","cw_makarov"},
  command = "knox",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Custom Job"
})

-- TEAM_AGENT_DOV = DarkRP.createJob("Agent Dov", {
--   color = Color(0,111,230,255),
--   model = {"models/player/suits/male_07_closed_tie.mdl"},
--   description = [[ . ]],
--   weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_m3super90", "cw_vss", "weapon_handcuffs"},
--   command = "dov",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

-- TEAM_BIG_SMOKE = DarkRP.createJob("Dallas", {
--   color = Color(10,69,0,255),
--   model = {"models/player/pd2_dallas_p.mdl"},
--   description = [[ . ]],
--   weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ak74", "cw_ar15", "cw_sv98", "cw_scarh", "weapon_handcuffs", "cw_m3super90", "cw_g3a3", "cw_m14", "cw_g36c", "cw_ump45", "cw_deagle", "cw_vss", "cw_fiveseven", "cw_l85a2"},
--   command = "dallas",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

TEAM_GXNG_SHIT = DarkRP.createJob("Gxng Shit", {
  color = Color(255,0,0,255),
  model = {"models/player/charple.mdl"},
  description = [[ mafia consilgure job ]],
  weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_scarh", "cw_sv98", "weapon_handcuffs", "cw_ar15", "cw_g36c"},
  command = "gang",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "Custom Job"
})

TEAM_CORRUPT_BUSINESSMAN = DarkRP.createJob("School Shooter", {
  color = Color(255,0,0,255),
  model = {"models/player/suits/robber_tuckedtie.mdl"},
  description = [[ Playermodel = Suit7d Mafia Siciario Model ]],
  weapons = {"keypad_cracker", "lockpick", "cw_deagle", "weapon_handcuffs", "cw_sv98"},
  command = "cbusinessman",
  max = 3,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Custom Job"
})

TEAM_NIKO_BELLIC = DarkRP.createJob("Lambda Resistance", {
  color = Color(255,165,0,255),
  model = {"models/fearless/cr.mdl"},
  description = [[ Roman: Heey cousin you want to go bowlin?
  Niko: no roman not now!
  ]],
  weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_mac11", "cw_l115", "weapon_handcuffs"},
  command = "Bellic",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "Custom Job"
})


TEAM_FORSAKEN = DarkRP.createJob("Forsaken", {
  color = Color(234,0,255,255),
  model = {"models/player/mossman.mdl"},
  description = [[ Nikhil forsaken Kumawat is a Banned Counter-Strike: Global Offensive player from India who previously played for OpTic India. ]],
  weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ak74","cw_sv98","weapon_handcuffs"},
  command = "ezfrag",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "Custom Job"
})


-- TEAM_BELLIC_GOPNIK = DarkRP.createJob("Bellic Gopnik", {
--   color = Color(140,100,59,255),
--   model = {"models/csgobalkan3pm.mdl"},
--   description = [[ https://steamcommunity.com/sharedfiles/filedetails/?id=1444854893&searchtext=adidas ]],
--   weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ak74","cw_l115","weapon_handcuffs"},
--   command = "bellicm",
--   max = 3,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

TEAM_LIL_REDEMPTION = DarkRP.createJob("Lil Redemption", {
  color = Color(255,0,136,255),
  model = {"models/player/skeleton.mdl"},
  description = [[  ]],
  weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15", "cw_m14", "weapon_handcuffs"},
  command = "axua",
  max = 2,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = true,
  hasLicense = true,
  category = "Custom Job"
})

TEAM_7BIG_SCOTTISH_JUNKIE = DarkRP.createJob("Big Scottish Junkie", {
	color = Color(64,0,153,255),
	model = {"models/player/woody.mdl"},
	description = [[  ]],
	weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15","cw_mr96"},
	command = "starburst",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

TEAM_PRIVATE_ASSAULT_SQUAD = DarkRP.createJob("Toe Eater", {
	color = Color(255,0,13,255),
	model = {"models/player/skeleton.mdl"},
	description = [[ we are a private criminal assault squad and the model i want is the same as the military police custom job. private military look ]],
	weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_sv98","cw_ak74","weapon_handcuffs", "cw_mr96"},
	command = "privateassaultsquad",
	max = 2,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

-- TEAM_POLISH_THIEF = DarkRP.createJob("Polish Thief", {
--   color = Color(21,194,39,255),
--   model = {"models/player/arctic.mdl"},
--   description = [[ skin: Bank Thief ]],
--   weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_scarh","cw_l115","cw_m3super90"},
--   command = "pt",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

TEAM_RUSSIAN_ALPHA_ONE = DarkRP.createJob("russian alpha one", {
	color = Color(5,148,250,255),
	model = {"models/player/pmc_2/pmc__05.mdl"},
	description = [[ russian special force used in hostage situations bank raid and other important and dangerous missions
	C.E.L.L Soldiers NPCs and Playermodels the 3th picture is the model i want ]],
	weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15","cw_l115","weapon_handcuffs"},
	command = "alphaone",
	max = 2,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

TEAM_THE_MANDEM = DarkRP.createJob("The Mandem", {
    color = Color(181,14,151,255),
    model = {"models/player/skeleton.mdl"},
    description = [[ same skin as Lil redemption's  job the one with no hit box ]],
    weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15","cw_m3super90","weapon_handcuffs"},
    command = "mandem",
    max = 1,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Custom Job"
})

TEAM_THE_ULTIMATE_WARRIOR = DarkRP.createJob("The Ultimate Warrior", {
    color = Color(24,140,222,255),
    model = {"models/player/suits/robber_tuckedtie.mdl"},
    description = [[ The warrior of XYZ, no one can stop him! Please DM me if you cannot use the following playermodel at William Morris#8982 player model : agent_47 ]],
    weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15","cw_scarh","weapon_handcuffs"},
    command = "ultimatewarrior",
    max = 3,
    salary = 100,
	admin = 0,
    vote = false,
    hasLicense = true,
    category = "Custom Job"
})

TEAM_AGENT_47 = DarkRP.createJob("Agent 47", {
  color = Color(255,0,0,255),
   model = {"models/player/agent_47.mdl"},
  description = [[ Hitman Agent 47 model ]],
  weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_deagle","cw_vss","weapon_handcuffs"},
  command = "go47",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = true,
    category = "Custom Job"
})

-- TEAM_TRASHPANDA = DarkRP.createJob("trashpanda", {
--   color = Color(18,19,20,255),
--   model = {"models/player/pd2_hoxton_p.mdl"},
--   description = [[ likes eating pussy and fucking your mom  https://steamcommunity.com/sharedfiles/filedetails/?id=504598681&searchtext=hoxton]],
--   weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ak74","cw_deagle","weapon_handcuffs"},
--   command = "pandaclass",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = true,
--   category = "Custom Job"
-- })

-- TEAM_RONALD_THE_KIDNAPPER = DarkRP.createJob("Ronald The Kidnapper", {
--   color = Color(255,38,0,255),
--   model = {"models/player/skeleton.mdl"},
--   description = [[ . ]],
--   weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_scarh","weapon_handcuffs"},
--   command = "ronalsthekidnapper",
--   max = 1,
--   salary = 100,
--   admin = 0,
--   vote = false,
--   hasLicense = false,
--   category = "Custom Job"
-- })

TEAM_IRA_BOYO = DarkRP.createJob("IRA boyo", {
    color = Color(9,255,0,255),
    model = {"models/player/skeleton.mdl"},
    description = [[ Do knee cappings kill people fight for a republic of ireland  skin lil redemption ]],
    weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15","weapon_handcuffs"},
    command = "iraboyo",
    max = 2,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Custom Job"
})
            
TEAM_LIL_TENACIOUS = DarkRP.createJob("Lil Tenacious", {
    color = Color(255,82,116,255),
    model = {"models/fearless/cr.mdl"},
    description = [[ models/fearless/cr.mdl ]],
    weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15"},
    command = "lilstarzz",
    max = 1,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Custom Job"
})

TEAM_LIL_RELENTLESS = DarkRP.createJob("Lil Relentless", {
    color = Color(145,0,255,255),
    model = {"models/kryptonite/spiderman_2/spiderman_2.mdl"},
    description = [[ models/kryptonite/spiderman/spiderman.mdl ]],
    weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15"},
    command = "starzz",
    max = 1,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    category = "Custom Job"
})

TEAM_LIL_SACRIFICE = DarkRP.createJob("Lil Sacrifice", {
    color = Color(255,0,119,255),
    model = {"models/player/charple.mdl"},
    description = [[ models/Humans/Charple01.mdl ]],
    weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15"},
    command = "starz",
    max = 1,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = true,
    category = "Custom Job"
})
         
TEAM_MASTER_THIEF = DarkRP.createJob("Master Thief", {
  color = Color(191,0,255,255),
  model = {"models/player/pd2_wolf_p.mdl"},
  description = [[ He is a master in all aspects of thiefing. He has spent 50 years perfecting his techniques. He destroys clans, Splits up mafias & robs banks. He is undetectable and unreachable. You will never be able to catch him All you can do is hope Hope he wont see you.

PM:
https://steamcommunity.com/sharedfiles/filedetails/?id=915353728
 ]],
  weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15","cw_g3a3","weapon_handcuffs"},
  command = "masterthief",
  max = 2,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "Custom Job"
})

TEAM_JORDAN_COSTELLO = DarkRP.createJob("Jordan Costello", {
  color = Color(199,0,0,255),
  model = {"models/player/charple.mdl"},
  description = [[ Jordan Costello was a American Mobster from the City of Rockford. Cause Havoc and Lead the Police on a wild chase. Skin: The The Militia Shatai one please ]],
  weapons = {"keypad_cracker", "lockpick", "weapon_handcuffs"},
  command = "jordan",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "Custom Job"
})

TEAM_AGENT_47_RETURNS = DarkRP.createJob("Agent 47 Returns", {
	color = Color(0,255,26,255),
	model = {"models/player/tmnt.mdl"},
	description = [[ no desription needed
https://steamcommunity.com/sharedfiles/filedetails/?id=158351769&searchtext=player+models ]],
	weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "weapon_handcuffs"},
	command = "AGENTAJ",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

TEAM_BENJIE = DarkRP.createJob("Benjie Bug", {
	color = Color(49, 255, 8,255),
	model = {"models/player/skeleton.mdl"},
	description = [[ no desription needed]],
	weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_ar15", "weapon_handcuffs"},
	command = "4242",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

TEAM_HOBO1 = DarkRP.createJob("Hobo", {
	color = Color(0,0,0,255),
	model = {"models/player/corpse1.mdl"},
	description = [[ no desription needed]],
	weapons = {"keypad_cracker", "lockpick"},
	command = "hobo1",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Custom Job"
})

TEAM_SKELETONGHOST2 = DarkRP.createJob("SkeletonGhost2", {
	color = Color(181,38,224,255),
	model = {"models/player/charple.mdl"},
	description = [[ no desription needed]],
	weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_scarh","cw_m3super90","weapon_handcuffs"},
	command = "skeletonghost2",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

TEAM_TRA = DarkRP.createJob("TRA", {
	color = Color(181,38,224,255),
	model = {"models/bala/gangboi.mdl"},
	description = [[ 76561198165573091 ]],
	weapons = {"keypad_cracker", "lockpick", "weapon_handcuffs"},
	command = "tra",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Custom Job"
})

TEAM_POTNOODLES = DarkRP.createJob("Pot Noodles", {
	color = Color(181,38,224,255),
	model = {"models/bala/gangboi.mdl"},
	description = [[ 76561198831566944 ]],
	weapons = {"keypad_cracker", "lockpick", "weapon_handcuffs", "cw_scarh"},
	command = "potnoodles",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Custom Job"
})

TEAM_76561198083566925_BUSINESS = DarkRP.createJob("The Ultimate Business Man", {
	color = Color(133,16,37,255),
	model = {"models/fearless/wsuit09.mdl"},
	description = [[]],
	weapons = {"keypad_cracker", "lockpick", "cw_m3super90","cw_vss","weapon_handcuffs"},
	command = "business",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

TEAM_76561198433733992_CUCUMBER = DarkRP.createJob("Cucumber", {
	color = Color(77,255,0,255),
	model = {"models/player/pd2_chains_p.mdl"},
	description = [[76561198433733992]],
	weapons = {"keypad_cracker", "lockpick", "cw_ak74","weapon_handcuffs"},
	command = "cucumber",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

TEAM_76561198409758519_VIKINGS = DarkRP.createJob("Vikings", {
	color = Color(0,51,255,255),
	model = {"models/player/pd2_chains_p.mdl"},
	description = [[76561198409758519]],
	weapons = {"keypad_cracker", "lockpick", "cw_deagle"},
	command = "danmark",
	max = 3,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Custom Job"
})

TEAM_76561198993305941_BATMAN = DarkRP.createJob("Batman", {
	color = Color(0,0,0,255),
	model = {"models/player/pd2_chains_p.mdl"},
	description = [[76561198993305941]],
	weapons = {"keypad_cracker", "lockpick", "cw_scarh","cw_deagle","weapon_handcuffs"},
	command = "batman06",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

TEAM_76561198986064420_GUSTAVACHTERBERG = DarkRP.createJob("Gustav Achterberg", {
	color = Color(123,15,247,255),
	model = {"models/player/PMC_2/PMC__07.mdl"},
	description = [[76561198986064420]],
	weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "cw_l85a2","cw_ar15","cw_shorty","weapon_handcuffs","cw_sv98"},
	command = "gustav",
	max = 3,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

TEAM_76561198176776957_LILPEEP = DarkRP.createJob("Lil Peep", {
	color = Color(255,0,0,255),
	model = {"models/player/skeleton.mdl"},
	description = [[76561198176776957]],
	weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick"},
	command = "lilp",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Custom Job"
})

TEAM_76561198969208485_BADSANTA = DarkRP.createJob("Bad Santa", {
	color = Color(255,0,0,255),
	model = {"models/player/christmas/santa.mdl"},
	description = [[76561198969208485]],
	weapons = {"weapon_handcuffs", "keypad_cracker", "lockpick"},
	command = "customjob1",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Custom Job"
})

TEAM_ID_HELLBOY = DarkRP.createJob("Hellboy", {
	color = Color(139,81,201,255),
	model = {"models/player/suits/robber_tuckedtie.mdl"},
	description = [[Kiro VRO]],
	weapons = {"prokeypadcracker", "pro_lockpick_update","weapon_handcuffs", "keypad_cracker", "lockpick", "cw_ar15", "cw_sv98", "cw_scarh"},
	command = "hellboy",
	max = 8,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = true,
	category = "Custom Job"
})

TEAM_76561198826758243_GABE = DarkRP.createJob("The Gabinator", {
	color = Color(139,81,201,255),
	model = {"models/mw2/skin_05/mw2_soldier_06.mdl"},
	description = [[The Gabinator]],
	weapons = {"keypad_cracker", "lockpick", "khr_vector"},
	command = "badboitime",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Custom Job"
})

TEAM_76561198986214883_METHIL = DarkRP.createJob("Methil", {
  color = Color(255,165,0,255),
  model = {"models/player/hellinspector/southpark/kenny_pm.mdl"},
  description = [[76561198986214883 - Wakey]],
  weapons = {"prokeypadcracker", "pro_lockpick_update", "keypad_cracker", "lockpick", "weapon_handcuffs"},
  command = "methil",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = false,
  category = "Custom Job"
})

TEAM_NORWEGIAN_SNIPER = DarkRP.createJob("Norwegian Sniper", {
  color = Color(255,0,0,255),
  model = {"models/mw2/skin_09/mw2_soldier_06.mdl"},
  description = [[]],
  weapons = {"keypad_cracker", "lockpick", "weapon_handcuffs", "cw_sv98", "cw_ak74"},
  command = "norwegian_sniper",
  max = 1,
  salary = 100,
  admin = 0,
  vote = false,
  hasLicense = true,
  category = "Custom Job"
})


--
-- Other stuff
--

TEAM_PRISONER = DarkRP.createJob("Prisoner", {
    color = Color(242, 167, 69),
    model = {
      "models/rako/player/prisoners/jumpsuit_male_01.mdl",
      "models/rako/player/prisoners/jumpsuit_male_02.mdl",
      "models/rako/player/prisoners/jumpsuit_male_03.mdl",
      "models/rako/player/prisoners/jumpsuit_male_04.mdl",
      "models/rako/player/prisoners/jumpsuit_male_05.mdl",
      "models/rako/player/prisoners/jumpsuit_male_06.mdl",
      "models/rako/player/prisoners/jumpsuit_male_07.mdl",
      "models/rako/player/prisoners/jumpsuit_male_08.mdl",
      "models/rako/player/prisoners/jumpsuit_male_09.mdl",
    },
    description = [[Monopoly can't help you now...]],
    weapons = {},
    command = "prisoner",
    max = 0,
    salary = 0,
    customCheck = function(ply) return false end,
   -- CustomCheck
    admin =  0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Other"
})

TEAM_EVENT = DarkRP.createJob("Event Member", {
    color = Color(118, 246, 255),
    model = { "models/player/combine_super_soldier.mdl", },
    description = [[fuck off.]],
    weapons = {},
    command = "eventmember",
    max = 0,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    customCheck = function(ply) return false end,
    category = "Other"
})

TEAM_EVENTTEAM = DarkRP.createJob("Gamemaster", {
    color = Color(0, 237, 252, 255),
    model = { "models/player/dod_american.mdl", },
    description = [[fuck off.]],
    weapons = {"weapon_xyz_event_gamemaster", "xyz_megaphone"},
    command = "eventteam",
    max = 0,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    customCheck = function(ply) return ply:IsEventTeam() end,
    category = "Other"
})

TEAM_CUSTOMCLASS = DarkRP.createJob("Custom Class", {
  color = Color(150, 150, 150, 255),
  model = {"models/player/skeleton.mdl"},
  description = [[The job that can only be used with a custom class]],
  weapons = {"lockpick", "keypad_cracker"},
  command = "customclass",
  max = 0,
  salary = 300,
  admin =  0,
  vote = false,
  hasLicense = false,
  candemote = false,
  category = "Other"
})

--[[---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------]]
GAMEMODE.DefaultTeam = TEAM_CITIZEN

--[[---------------------------------------------------------------------------
Define which teams belong to civil protection
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------]]
GAMEMODE.CivilProtection = {
	[TEAM_POFFICER] = true,
	[TEAM_PSENOFFICER] = true,
	[TEAM_PLANCORP] = true,
	[TEAM_PCORP] = true,
	[TEAM_SERGEANT] = true,
	[TEAM_MASSERGEANT] = true,
	[TEAM_PSERGEANTMAJOR] = true,
	[TEAM_PLIUTENANT] = true,
	[TEAM_PCAPTAIN] = true,
	[TEAM_PSUP] = true,
	[TEAM_PMAJ] = true,
	[TEAM_PLTC] = true,
	[TEAM_PCOL] = true,
	[TEAM_PDCOM] = true,
	[TEAM_PCOM] = true,
  [TEAM_PASSCOM] = true,

	[TEAM_SHERIFFTROOPER] = true,
	[TEAM_SHERIFFFIRSTCLASS] = true,
	[TEAM_SHERIFFMASTER] = true,
	[TEAM_SHERIFFCORPORAL] = true,
	[TEAM_SHERIFFSERGEANT] = true,
	[TEAM_SHERIFFLIEUTENANT] = true,
	[TEAM_SHERIFFCAPTAIN] = true,
	[TEAM_SHERIFFMAJOR] = true,
	[TEAM_CHIEFDEPUTY] = true,
  [TEAM_UNDERSHERIFF] = true,
	[TEAM_SHERIFF] = true,

	[TEAM_SWATRIFLE] = true,
	[TEAM_SWATMED] = true,
	[TEAM_SWATBRE] = true,
	[TEAM_SWATMRK] = true,
  [TEAM_SWATSNP] = true,
  [TEAM_SWATCQC]  = true,
  [TEAM_SWATCTU] = true,
	[TEAM_SWATSUP] = true,
  [TEAM_SWATLEADER] = true,
  [TEAM_SWATMAJOR]  = true,
	[TEAM_SWATLTCOL] = true,
	[TEAM_SWATCOL] = true,

  [TEAM_FBIPA]	= true,
	[TEAM_FBISA] 	= true,
  [TEAM_FBISSA] 	= true,
	[TEAM_FBIASAIC] = true,
	[TEAM_FBISAIC]	= true,
	[TEAM_FBISSAIC] = true,
	[TEAM_FBIDAD] 	= true,
	[TEAM_FBIEAD] 	= true,
	[TEAM_FBIADD] 	= true,
	[TEAM_FBICOS] 	= true,
	[TEAM_FBIDD]	= true,
	[TEAM_FBID]		= true,
  
  [TEAM_VICE_PRESIDENT] = true,
	[TEAM_PRESIDENT] = true,

}