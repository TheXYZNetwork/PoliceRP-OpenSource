XYZEMS.Frame = XYZEMS.Frame or nil
function XYZEMS.DeathMenu()
	if IsValid(XYZEMS.Frame) then XYZEMS.Frame:Remove() end
	XYZEMS.Frame = vgui.Create("DFrame")
	XYZEMS.Frame:SetSize(ScrW(), ScrH())
	XYZEMS.Frame:MakePopup()
	XYZEMS.Frame:SetTitle("")
	XYZEMS.Frame:SetDraggable(false)
	XYZEMS.Frame:ShowCloseButton(false)
	XYZEMS.Frame.Paint = function(self, w, h)
		XYZShit.DermaBlurPanel(self, 3)
	end

	local frame = XYZUI.Frame("You Are Dead", Color(155, 0, 0), true)
	frame:SetSize(400, 230)
	frame:Center()
	frame:SetParent(XYZEMS.Frame)
	function frame:Think()
		self:MoveToFront()
	end

	local shell = XYZUI.Container(frame)
	shell:DockPadding(10, 10, 10, 10)
	local info = XYZUI.Title(shell, "Respawn in:", "loading", 40, nil, true)
	info:DockMargin(0, -10, 0, 0)
	info.Think = function()
		local timeLeft = XYZEMS.RespawnTime - os.time()
		if timeLeft <= 0 then
			info.subTitle = "Now!"
			return
		end
		info.subTitle = XYZEMS.RespawnTime - os.time()
	end
	local respawn = XYZUI.ButtonInput(shell, "Respawn", function()
		if XYZEMS.RespawnTime > os.time() then return end
		XYZEMS.Frame:Close()
		net.Start("EMSRequestRespawn")
		net.SendToServer()
	end)
	respawn:Dock(FILL)


	if XYZEMS.Core.EMSOnline() then
		local callEMS = XYZUI.ButtonInput(shell, "Call EMS", function()
			if XYZShit.CoolDown.Check("XYZEMS.DeathMenu", XYZEMS.Config.EMSRespawn) then return end

			net.Start("EMSCallForHelp")
			net.SendToServer()
		end)
		callEMS:DockMargin(0, 5, 0, 0)
		callEMS:Dock(BOTTOM)
		callEMS.headerColor = Color(0, 135, 135)
	end

	local callStaff = XYZUI.ButtonInput(XYZEMS.Frame, "Call Staff", function()
		if XYZShit.CoolDown.Check("XYZEMS.CallStaff", 5) then return end

		XYZUI.PromptInput("Call Staff", Color(0, 135, 135), "Specify the exact reason you require assistance from staff",  function(reason)
			if string.len(reason) < 3 then return end
			LocalPlayer():ConCommand("say !sit "..reason)
		end)
	end)
	callStaff:DockMargin(0, 0, ScrW()-100, 0)
	callStaff:Dock(BOTTOM)


	if LocalPlayer():HasPower(95) then
		local adminRespawn = XYZUI.ButtonInput(XYZEMS.Frame, "Respawn", function()
			LocalPlayer():ConCommand("xadmin revive ^")
		end)
		adminRespawn:DockMargin(0, 0, ScrW()-100, 5)
		adminRespawn:Dock(BOTTOM)
	end
end