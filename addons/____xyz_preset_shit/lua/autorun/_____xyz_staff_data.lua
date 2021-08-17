XYZShit = XYZShit or {}
XYZShit.Staff = {}

XYZShit.Staff.All = {}

XYZShit.Staff.All["superadmin"] = true
XYZShit.Staff.All["developer"] = true
XYZShit.Staff.All["staff-supervisor"] = true
XYZShit.Staff.All["staff-lead"] = true
XYZShit.Staff.All["senior-admin"] = true
XYZShit.Staff.All["admin"] = true
XYZShit.Staff.All["jr-admin"] = true
XYZShit.Staff.All["senior-moderator"] = true
XYZShit.Staff.All["moderator"] = true
XYZShit.Staff.All["jr-mod"] = true
XYZShit.Staff.All["trial-mod"] = true


local pMeta = FindMetaTable("Player")

function pMeta:IsStaff()
	return XYZShit.Staff.All[self:GetUserGroup()]
end