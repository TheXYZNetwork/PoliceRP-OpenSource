local config = {}
-- ===============
-- START OF CONFIG
-- ===============
-- How long a panic lasts (seconds)
config.panicLast = 40

-- This is the text that is across the top of the interface
config.headerText = "Oh, looks like you're in trouble!"

-- This is the text that is under the header
config.subText = "Want to press your panic button?"

-- This is the text for the button that presses the panic button
config.acceptText = "PRESS IT"

-- This is the text for the button that does not press the panic but and closes the UI
config.denyText = "FALSE ALARM"

-- This is the text for the player who has pressed their panic button.
config.panicPressedText = "%s has pressed their panic button"
config.panicDisatanceText = "They are %sm away"
-- =============
-- END OF CONFIG
-- =============

if SERVER then
	util.AddNetworkString("panicbutton_openmenu")
	util.AddNetworkString("panicbutton_panicbutton")
	util.AddNetworkString("panicbutton_networkply")
	util.AddNetworkString("panicbutton_wipe")

	local function openPanicBtn(ply)
		if not XYZShit.IsGovernment(ply:Team(), true) and not ply.UCOriginalJob then return end
		if ply:XYZIsArrested() or ply:XYZIsZiptied() then return end
		net.Start("panicbutton_openmenu")
		net.Send(ply)
	end

	hook.Add("ShowTeam", "panicbutton_trigger", function(ply)
		openPanicBtn(ply)
	end)

	concommand.Add("xyz_open_panic", function(ply)
	    openPanicBtn(ply)
	end, nil, "Opens the panic button menu")

	hook.Add("OnPlayerChangedTeam", "panicbutton_wipe", function(ply, old, new)
		if XYZShit.IsGovernment(old, true) and not XYZShit.IsGovernment(new, true) then
			net.Start("panicbutton_wipe")
			net.Send(ply)
		end
	end)

	local function PBPlyUpdate(ply, bool)
		for k, v in pairs(player.GetAll()) do
			if not XYZShit.IsGovernment(v:Team(), true) and not v.UCOriginalJob then continue end
			net.Start("panicbutton_networkply")
				net.WriteEntity(ply)
				net.WriteBool(bool)
			net.Send(v)
		end
	end

	net.Receive("panicbutton_panicbutton", function(_, ply)
		if not XYZShit.IsGovernment(ply:Team(), true) and not ply.UCOriginalJob then return end
		if ply:XYZIsArrested() or ply:XYZIsZiptied() then return end

		if ply.activePanic then
			ply.activePanic = false
			PBPlyUpdate(ply, false)
			hook.Call("XYZPanicButtonEnd", nil, ply)
		else
			ply.activePanic = true
			PBPlyUpdate(ply, true)
			hook.Call("XYZPanicButtonStart", nil, ply)
		end
	end)

	hook.Add("PlayerDeath", "panicbutton_trigger", function(ply)
		ply.activePanic = false
		PBPlyUpdate(ply, false)
		hook.Call("XYZPanicButtonEnd", nil, ply)
	end)

	hook.Add("OnPlayerChangedTeam", "panicbutton_trigger", function(ply)
		ply.activePanic = false
		PBPlyUpdate(ply, false)
		hook.Call("XYZPanicButtonEnd", nil, ply)
	end)

end

if CLIENT then
	local panicButtons = {}

	function PanicButtonUI()
		local frame = XYZUI.Frame("Panic Button", PNC.Config.Color)
		frame:SetSize(384, 216)
		frame:Center()

		local shell = XYZUI.Container(frame)
		shell:DockPadding(10, 10, 10, 10)

		local settingDepartments = XYZUI.Title(shell, config.headerText, config.subText, 30, 25, true)

		local triggerPanic = XYZUI.ButtonInput(shell, panicButtons[LocalPlayer()] and "Turn off" or "Turn on", function()
			net.Start("panicbutton_panicbutton")
			net.SendToServer()
			XYZShit.Msg("Panic Button", PNC.Config.Color, panicButtons[LocalPlayer()] and "You have disabled your panic button!" or "You have triggered your panic button!")
			frame:Close()
		end)
		triggerPanic:DockMargin(0, 10, 0, 0)
		triggerPanic:Dock(FILL)
	end
	net.Receive("panicbutton_openmenu", PanicButtonUI)


	hook.Add("HUDPaint", "ROB_GovernmentNotification", function()
		for k, v in pairs(panicButtons) do
			if v then
				if !k:IsValid() then continue end
				local pos = k:GetPos():ToScreen()
				draw.DrawText(string.format(config.panicPressedText, k:Nick()), "xyz_font_20_static", pos.x, pos.y-30, Color(255, 255, 255), TEXT_ALIGN_CENTER)
				draw.DrawText(string.format(config.panicDisatanceText, string.Comma(math.Round(k:GetPos():Distance(LocalPlayer():GetPos())))), "xyz_font_20_static", pos.x, pos.y, Color(255, 255, 255), TEXT_ALIGN_CENTER)
				draw.NoTexture()
				surface.SetDrawColor(0, 0, 0, 255)
				XYZUI.DrawCircle(pos.x, pos.y-45, 20, 2)
				surface.SetDrawColor(200, 0, 0, 255)
				XYZUI.DrawCircle(pos.x, pos.y-45, 18, 2)
			end
		end
	end)

	net.Receive("panicbutton_networkply", function()
		local ply = net.ReadEntity()
		local toggle = net.ReadBool()
		if not IsValid(ply) then return end
		if not ply:IsPlayer() then return end

		if XYZSettings.GetSetting("panic_show_marker", true) then
			if toggle then
				panicButtons[ply] = toggle
			else
				panicButtons[ply] = nil
			end
		end
		if XYZSettings.GetSetting("panic_show_minimap", true) then
			if toggle then
				Minimap.AddWaypoint("panicbutton_"..ply:SteamID64(), "panicbutton_marker",  XYZUI.CharLimit(ply:Name(), 20), Color(200, 0, 0), 1.3, ply:GetPos())
			else
				Minimap.RemoveWaypoint("panicbutton_"..ply:SteamID64())
			end
		end
	end)
	net.Receive("panicbutton_wipe", function()
		Minimap.RemoveWaypointsWithTag("panicbutton")
		panicButtons = {}
	end)

end