--[[---------------------------------------------------------------------------
Group chats
---------------------------------------------------------------------------
Team chat for when you have a certain job.
e.g. with the default police group chat, police officers, chiefs and mayors can
talk to one another through /g or team chat.

HOW TO MAKE A GROUP CHAT:
Simple method:
GAMEMODE:AddGroupChat(List of team variables separated by comma)

Advanced method:
GAMEMODE:AddGroupChat(a function with ply as argument that returns whether a random player is in one chat group)
This is for people who know how to script Lua.

---------------------------------------------------------------------------]]
-- Example: GAMEMODE:AddGroupChat(TEAM_MOB, TEAM_GANG)
-- Example: GAMEMODE:AddGroupChat(function(ply) return ply:isCP() end)
GAMEMODE:AddGroupChat(function(ply) return ply:isCP() end)

GAMEMODE:AddGroupChat(TEAM_FR_CF, TEAM_FR_JF, TEAM_FR_F, TEAM_FR_SF, TEAM_FR_E, TEAM_FR_SE, TEAM_FR_SUP, TEAM_FR_LT, TEAM_FR_CPT, TEAM_FR_BC, TEAM_FR_DC, TEAM_FR_AC, TEAM_FR_FC)

GAMEMODE:AddGroupChat(TEAM_TERRORIST_RECRUIT, TEAM_TERRORIST_AGITATOR, TEAM_TERRORIST_FANATIC, TEAM_TERRORIST_INS, TEAM_TERRORIST_EXE, TEAM_TERRORIST_GOVNR, TEAM_TERRORIST_CMDR, TEAM_TERRORIST_SNRCMDR, TEAM_TERRORIST_CHIEF, TEAM_TERRORIST_COLEAD, TEAM_TERRORIST_LEAD) 
GAMEMODE:AddGroupChat(TEAM_SCJRASSOCIATE, TEAM_SCASSOCIATE, TEAM_SCSASSOCIATE, TEAM_SCHASSOCIATE, TEAM_SJRSICARIO, TEAM_SPOREGIME, TEAM_SSPOREGIME, TEAM_SCHSPOREGIME, TEAM_SCCAPOREGIME, TEAM_LTBOSS, TEAM_SCUNDERBOSS, TEAM_SCBOSS, TEAM_SCCONSIGLIERE, TEAM_SCGODFATHER)
