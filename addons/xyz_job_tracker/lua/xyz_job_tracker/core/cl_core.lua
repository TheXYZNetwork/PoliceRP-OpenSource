XYZTracker.Frame = XYZTracker.Frame or nil
--XYZTracker.Frame:Close()
net.Receive("JobTrackerSearchPlayer", function()
	local target = net.ReadString()
	local sessionsData = net.ReadTable() 
	if IsValid(XYZTracker.Frame) then XYZTracker.Frame:Close() end

	XYZTracker.Frame = XYZUI.Frame("Job Tracker", Color(148,0,211))
	XYZTracker.Frame:SetSize(ScrH()*0.7, ScrH()*0.90)
	XYZTracker.Frame:Center()

	local navBar = XYZUI.NavBar(XYZTracker.Frame)
	local shell = XYZUI.Container(XYZTracker.Frame)

	XYZUI.AddNavBarPage(navBar, shell, "Sessions", function(shell)
		local st, sessionsList = XYZUI.Lists(shell, 1)
		local days = {}
		local elements = {}
		local weektime = 0

		local dayOfWeek = os.date("%w")
		for k, v in ipairs(sessionsData) do
			if (os.time() - (60*60*24*(dayOfWeek+1))) <= v.join then
				weektime = weektime + (v.leave or os.time()) - v.join
			end
			local date = os.date("%x", v.join)
			if not days[date] then
				days[date] = {}
				local body, card, mainContainer = XYZUI.ExpandableCard(sessionsList, date, 40)
				elements[date] = {}
				elements[date].titleCard = card
				mainContainer:DockMargin(0, 0, 0, 5)
				elements[date].card = XYZUI.Card(body, 77)
				XYZUI.AddToExpandableCardBody(mainContainer, elements[date].card)
			end
			table.insert(days[date], v)
			local time = string.FormattedTime((v.leave or os.time()) - v.join)
			
			XYZUI.PanelText(elements[date].card, "Job: "..v.job, 24, TEXT_ALIGN_CENTER)
			XYZUI.PanelText(elements[date].card, "Joined: "..os.date("%d/%m/%Y - %H:%M:%S" , v.join), 24, TEXT_ALIGN_CENTER)
			XYZUI.PanelText(elements[date].card, "Session: "..time.h.." hour(s), "..time.m.." minute(s)", 24, TEXT_ALIGN_CENTER):DockMargin(0, 0, 0, 5)
		end
		for k, v in pairs(days) do
			local totaltime = 0
			local height = 0
			for k2, v2 in pairs(v) do
				totaltime = totaltime + (v2.leave or os.time()) - v2.join
				height = height + 77
			end
			elements[k].card:SetTall(height)

			local time = string.FormattedTime(totaltime)
			elements[k].titleCard.name = k .. " ("..time.h.." hour(s), "..time.m.." minute(s) total)"
		end

		local time = string.FormattedTime(weektime)
		XYZUI.PanelText(shell, "This week: "..time.h.." hour(s), "..time.m.." minute(s)", 24, TEXT_ALIGN_CENTER):Dock(TOP)
	end)
	XYZUI.AddNavBarPage(navBar, shell, "Promos/Demos", function(shell)
		net.Start("JobTrackerRequestPlayerWhitelist")
			net.WriteString(target)
		net.SendToServer()
		
		net.Receive("JobTrackerSearchPlayerWhitelist", function()
			local target = net.ReadString()
			local promoData = net.ReadTable()
			if not IsValid(shell) then return end
			local st, sessionsList = XYZUI.Lists(shell, 1)
			local ply = player.GetBySteamID64(target)
			if IsValid(ply) then 
				local _, t2 = next(RPExtraTeams, ply:Team())
				if xWhitelist.Core.CanWhitelist(LocalPlayer(), t2.command) then
					XYZUI.PanelText(sessionsList, "Eligible for promotion", 24, TEXT_ALIGN_CENTER)
				else
					XYZUI.PanelText(sessionsList, "Not eligible for promotion", 24, TEXT_ALIGN_CENTER)
				end
			end
			local days = {}
			local elements = {}
			for k, v in pairs(promoData) do
				local date = os.date("%x", v.time)
				if not days[date] then
					days[date] = {}
					local body, card, mainContainer = XYZUI.ExpandableCard(sessionsList, date, 40)
					elements[date] = {}
					elements[date].titleCard = card
					mainContainer:DockMargin(0, 0, 0, 5)
					elements[date].card = XYZUI.Card(body, 75)
					XYZUI.AddToExpandableCardBody(mainContainer, elements[date].card)
				end
				table.insert(days[date], v)

				XYZUI.PanelText(elements[date].card, v.state, 24, TEXT_ALIGN_CENTER)
				XYZUI.PanelText(elements[date].card, "Job: "..v.job.." | By: "..v.promoter, 24, TEXT_ALIGN_CENTER)
				XYZUI.PanelText(elements[date].card, "Date: "..os.date("%d/%m/%Y - %H:%M:%S" , v.time), 24, TEXT_ALIGN_CENTER):DockMargin(0, 0, 0, 5)
			end
			for k, v in pairs(days) do
				local height = 0
				local promotions = 0
				local demotions = 0
				for k2, v2 in pairs(v) do
					if v2.state == "Promotion" then promotions = promotions + 1 else demotions = demotions + 1 end
					height = height + 77
				end
				elements[k].card:SetTall(height)
				local time = string.FormattedTime(totaltime)
				elements[k].titleCard.name = k .. " ("..promotions.." promotion(s), "..demotions.." demotion(s) total)"
			end
		end)
	end)
end)