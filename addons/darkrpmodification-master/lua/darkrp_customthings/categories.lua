--[[-----------------------------------------------------------------------
Categories
---------------------------------------------------------------------------
The categories of the default F4 menu.

Please read this page for more information:
http://wiki.darkrp.com/index.php/DarkRP:Categories

In case that page can't be reached, here's an example with explanation:

DarkRP.createCategory{
    name = "Citizens", 
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = function(ply) return true end,
    sortOrder = 100,
}


Add new categories under the next line!
---------------------------------------------------------------------------]]




---
--- JOBs
---

DarkRP.createCategory{
    name = "Criminals",
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 127, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 150,
}

DarkRP.createCategory{
    name = "Police Force",
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 127, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 200,
}

DarkRP.createCategory{
    name = "Sheriff's Department",
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 127, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 210,
}

DarkRP.createCategory{
    name = "Swat",
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 127, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 220,
}

DarkRP.createCategory{
    name = "FBI", 
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 40, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 230,
}

-- DarkRP.createCategory{
--     name = "Secret Service",
--     categorises = "jobs",
--     startExpanded = true,
--     color = Color(0, 127, 255, 255),
--     canSee = function(ply) return true end,
--     sortOrder = 240,
-- }

-- DarkRP.createCategory{
--     name = "US Marshals",
--     categorises = "jobs",
--     startExpanded = true,
--     color = Color(255, 0, 255, 255),
--     canSee = function(ply) return true end,
--     sortOrder = 250,
-- }

-- DarkRP.createCategory{
--     name = "E.M.S.", 
--     categorises = "jobs",
--     startExpanded = true,
--     color = Color(0, 127, 255, 255),
--     canSee = function(ply) return true end,
--     sortOrder = 300,
-- }

-- DarkRP.createCategory{
--     name = "Private Military Contractors", 
--     categorises = "jobs",
--     startExpanded = true,
--     color = Color(255, 0, 255, 255),
--     canSee = function(ply) return true end,
--     sortOrder = 760,
-- }

DarkRP.createCategory{
    name = "The Mafia", 
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 127, 100, 255),
    canSee = function(ply) return true end,
    sortOrder = 770,
}

DarkRP.createCategory{
    name = "Terrorist",
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 127, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 780,
}

DarkRP.createCategory{
    name = "Fire & Rescue",
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 0, 155, 255),
    canSee = function(ply) return true end,
    sortOrder = 790,
}

DarkRP.createCategory{
    name = "VIP",
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 127, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 800,
}

DarkRP.createCategory{
    name = "Elite",
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 127, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 850,
}

DarkRP.createCategory{
    name = "Custom Job", 
    categorises = "jobs",
    startExpanded = true,
    color = Color(255, 0, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 900,
}

DarkRP.createCategory{
    name = "Other",
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 127, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 1000,
}

---
--- AMMO
---
DarkRP.createCategory{
    name = "Ammo", 
    categorises = "entities",
    startExpanded = true,
    color = Color(0, 40, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 1,
}


---
--- ENTITES
---
-- DarkRP.createCategory{
--     name = "Cocaine Supplies", 
--     categorises = "entities",
--     startExpanded = true,
--     color = Color(0, 40, 255, 255),
--     canSee = function(ply) return true end,
--     sortOrder = 100,
-- }
DarkRP.createCategory{
    name = "Printers", 
    categorises = "entities",
    startExpanded = true,
    color = Color(0, 40, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 100,
}
DarkRP.createCategory{
    name = "EMS", 
    categorises = "entities",
    startExpanded = true,
    color = Color(255, 40, 40, 255),
    canSee = function(ply) return true end,
    sortOrder = 100,
}
DarkRP.createCategory{
    name = "Mechanic",
    categorises = "entities",
    startExpanded = true,
    color = Color(12, 107, 15),
    canSee = function(ply) return ply:Team() == TEAM_MECHANIC end,
    sortOrder = 28
}
DarkRP.createCategory{
    name = "Government",
    categorises = "entities",
    startExpanded = true,
    color = Color(12, 15, 107),
    canSee = function(ply) return true end,
    sortOrder = 28
}
DarkRP.createCategory{
    name = "Hacker Equipment",
    categorises = "entities",
    startExpanded = true,
    color = Color(100, 100, 100),
    canSee = function(ply) return true end,
    sortOrder = 28
}
---
--- WEAPONS
---

DarkRP.createCategory{
    name = "Rifles", 
    categorises = "shipments",
    startExpanded = true,
    color = Color(0, 40, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 100,
}

DarkRP.createCategory{
    name = "Sniper", 
    categorises = "shipments",
    startExpanded = true,
    color = Color(0, 40, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 100,
}

DarkRP.createCategory{
    name = "SMG", 
    categorises = "shipments",
    startExpanded = true,
    color = Color(0, 40, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 100,
}

DarkRP.createCategory{
    name = "Pistols", 
    categorises = "shipments",
    startExpanded = true,
    color = Color(0, 40, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 100,
}

DarkRP.createCategory{
    name = "Shotguns", 
    categorises = "shipments",
    startExpanded = true,
    color = Color(0, 40, 255, 255),
    canSee = function(ply) return true end,
    sortOrder = 100,
}
