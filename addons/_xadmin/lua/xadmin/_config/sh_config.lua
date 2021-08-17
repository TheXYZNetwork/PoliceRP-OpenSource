--# Group registartion

-- Staff ranks
xAdmin.Core.RegisterGroup("superadmin", 100)
xAdmin.Core.RegisterGroup("developer", 95)
xAdmin.Core.RegisterGroup("staff-supervisor", 93)
xAdmin.Core.RegisterGroup("staff-lead", 92)
xAdmin.Core.RegisterGroup("senior-admin", 90)
xAdmin.Core.RegisterGroup("admin", 80)
xAdmin.Core.RegisterGroup("jr-admin", 70)
xAdmin.Core.RegisterGroup("senior-moderator", 60)
xAdmin.Core.RegisterGroup("moderator", 50)
xAdmin.Core.RegisterGroup("jr-mod", 40)
xAdmin.Core.RegisterGroup("trial-mod", 30)
-- Paid ranks
xAdmin.Core.RegisterGroup("elite", 10)
xAdmin.Core.RegisterGroup("vip", 10)
-- Base rank
xAdmin.Core.RegisterGroup("user", 0)

-- The default group
xAdmin.Config.DefaultGroup = "user"

-- The power level needed to be superadmin/admin
xAdmin.Config.Superadmin = 95
xAdmin.Config.Admin = 80

-- What power-level can see admin chat?
xAdmin.Config.AdminChat = 30

xAdmin.Config.Prefix = "!"

xAdmin.Config.BanFormat = [[

-- Banned --
Banned by: %s
Time left: %s
Reason: %s

Feel you were false banned? Appeal it on the forums at policerp.xyz 
------------]]