XYZEMS.RespawnTime = 0
local iconSize = 80
local redish = Color(200, 0, 0)

net.Receive("EMSOnPlayerDeath", function()
	local time = net.ReadInt(32)
	XYZEMS.RespawnTime = os.time() + time
	XYZEMS.DeathMenu()
end)
net.Receive("EMSKillMenu", function()
	if not IsValid(XYZEMS.Frame) then return end
	XYZEMS.Frame:Close()
end)


local cachedReports = {}
net.Receive("EMSBroadcastBodyLocation", function()
	if not XYZSettings.GetSetting("ems_show_marker", true) then return end
	local id = net.ReadString()
	local pos = net.ReadVector()
	cachedReports[id] = pos

	Minimap.AddWaypoint("ems_"..id, "ems_marker", "EMS Call", redish, 1.3, pos)

--	timer.Simple(XYZEMS.Config.BaseRespawn+XYZEMS.Config.EMSRespawn, function()
--		Minimap.RemoveWaypoint("ems_"..id)
--		cachedReports[id] = nil
--	end)
end)


net.Receive("EMSDropOnRespawn", function()
	local id = net.ReadString()
	Minimap.RemoveWaypoint("ems_"..id)
	cachedReports[id] = nil
end)

hook.Add("HUDPaint", "EMSRequestPopup", function()
	for k, v in pairs(cachedReports) do
		local pos = v:ToScreen()
		--draw.SimpleText("EMS Request", "xyz_font_40_static", pos.x, pos.y+6, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		--draw.SimpleText("Respond ASAP", "xyz_font_25_static", pos.x, pos.y+25, redish, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(XYZShit.Image.GetMat("ems_marker"))
		surface.DrawTexturedRect(pos.x -(iconSize*0.5), pos.y -(iconSize*0.5), iconSize, iconSize)
	end
end)

local targetPly
hook.Add("HUDPaint", "EMSPDStabilize", function()
	if not LocalPlayer():isCP() then return end
	if not XYZEMS.Core.EMSOnline() then return end
	targetPly = XYZEMS.Core.GetClosestRagdoll(LocalPlayer())
	if not targetPly then return end

	draw.SimpleText("Stabilize!", "xyz_font_40_static", ScrW()/2, ScrH()/2, Color(0, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	draw.SimpleText("Press E to stabilize "..targetPly:Name(), "xyz_font_25_static", ScrW()/2, ScrH()/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
end)

local cooldown = 0
hook.Add("KeyPress", "EMSRequestStabilize", function(ply, key)
	if key == IN_USE then
		if not LocalPlayer():isCP() then return end
		if cooldown > os.time() then return end
		targetPly = XYZEMS.Core.GetClosestRagdoll(LocalPlayer())
		if not targetPly then return end
		cooldown = os.time() + 2
		net.Start("EMSStabilize")
			net.WriteEntity(targetPly)
		net.SendToServer()
	end
end)

net.Receive("EMSUpdateStabilityTime", function()
	XYZEMS.RespawnTime = XYZEMS.RespawnTime + XYZEMS.Config.EMSStabilize
end)


local cachedBodyBags = {}
net.Receive("EMSBroadcastBodyBagLocation", function()
	if not XYZSettings.GetSetting("ems_show_bodybag_marker", true) then return end
	local ent = net.ReadEntity()
	if not IsValid(ent) then return end
	local id = ent:EntIndex()

	cachedBodyBags[id] = ent:GetPos()
	Minimap.AddWaypoint("bodybag_"..id, "bodybag_marker", "Bodybag Found", redish, 1.3, ent:GetPos())

	timer.Simple(XYZEMS.Config.BodyBagDespawn, function()
		Minimap.RemoveWaypoint("bodybag_"..id)
		cachedBodyBags[id] = nil
	end)
end)

net.Receive("EMSBroadcastBodyBagRemove", function()
	local id = net.ReadInt(32)
	if not id then return end
		
	Minimap.RemoveWaypoint("bodybag_"..id)
	cachedBodyBags[id] = nil
end)

hook.Add("HUDPaint", "EMSBodybagPopup", function()
	for k, v in pairs(cachedBodyBags) do
		local pos = v:ToScreen()
		--draw.SimpleText("Bodybag found!", "xyz_font_40_static", pos.x, pos.y+6, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		--draw.SimpleText("Collect it for a reward", "xyz_font_25_static", pos.x, pos.y+30, redish, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(XYZShit.Image.GetMat("bodybag_marker"))
		surface.DrawTexturedRect(pos.x -(iconSize*0.5), pos.y -(iconSize*0.5), iconSize, iconSize)
	end
end)
