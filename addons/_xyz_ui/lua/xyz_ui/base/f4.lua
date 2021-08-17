-- Cache
local color = Color
local draw_box = draw.RoundedBox
local surface_setdrawcolor = surface.SetDrawColor
local surface_setmaterial = surface.SetMaterial
local surface_drawtexturedrect = surface.DrawTexturedRect
local surface_drawtexturedrectrotated = surface.DrawTexturedRectRotated

-- Color cache
local background = color(18, 18, 18)
local backgroundShaded = color(20, 20, 20)
local white = color(255, 255, 255)
local outline = color(31, 31, 31)
local bubble = color(120, 120, 120)
local headerShader = color(0, 0, 0, 55)
local headerDefault = color(2, 108, 254)

-- Material cache
local gradientDown = Material("gui/gradient_down")
local gradientUp = Material("gui/gradient_up")
local gradientMain = Material("gui/gradient")
local gradientCenter = Material("gui/center_gradient")

local gradientSize = 10


hook.Add("HUDPaint", "f4menu_load_models", function()
	local cacheModels = {}
	local counterTen = 1

	for k, v in pairs(RPExtraTeams) do
		if not cacheModels[counterTen] then cacheModels[counterTen] = {} end
		if #cacheModels[counterTen] == 15 then counterTen = counterTen + 1 end
		if not cacheModels[counterTen] then cacheModels[counterTen] = {} end
		table.insert(cacheModels[counterTen], v.model)
	end

	for k, v in pairs(cacheModels) do
		timer.Simple((1*k)/2, function()
			for n, m in pairs(v) do	
				if istable(m) then
					util.PrecacheModel(m[1])
					--print(m[1])
				else
					util.PrecacheModel(m)
					--print(m)
				end
			end
		end)
	end

	hook.Remove("HUDPaint", "f4menu_load_models")
end)


local function favJob(jobCommand, remove)
	if not sql.TableExists("xyz_fav_jobs") then
		sql.Query("CREATE TABLE xyz_fav_jobs(jobCommand TEXT PRIMARY KEY)")
	end
	if remove then
		print("DELETE FROM xyz_fav_jobs WHERE jobCommand="..sql.SQLStr(jobCommand))
		sql.Query("DELETE FROM xyz_fav_jobs WHERE jobCommand="..sql.SQLStr(jobCommand))
	else
		print("INSERT INTO xyz_fav_jobs VALUES("..sql.SQLStr(jobCommand)..")")
		sql.Query("INSERT INTO xyz_fav_jobs VALUES("..sql.SQLStr(jobCommand)..")")
	end
end
local function getFavJobs()
	if not sql.TableExists("xyz_fav_jobs") then
		sql.Query("CREATE TABLE xyz_fav_jobs(jobCommand TEXT PRIMARY KEY)")
	end
	
	local jobs = sql.Query("SELECT * FROM xyz_fav_jobs")
	if not jobs then print("No data") return {} end

	local jbs = {}

	for k, v in pairs(jobs) do
		jbs[v.jobCommand] = true
	end

	return jbs
end
local favCache = getFavJobs()

local cooldown = 0
function XYZUI.BuildF4Menu()
	if cooldown > CurTime() then return end
	cooldown = CurTime() + 5

	local frame = XYZUI.Frame(GetHostName(), color(2, 88, 154))
	frame:SetSize(ScrW()*0.75, ScrH()*0.75)
	frame:Center()
	frame.Think = function()
		if input.IsKeyDown(KEY_F4) then
			if cooldown > CurTime() then return end
			cooldown = cooldown + 2
			frame:Close()
		end
	end

	local navBar = XYZUI.NavBar(frame, true)
	local shell = vgui.Create("DScrollPanel", frame)
	local sbar = shell:GetVBar()
	sbar:SetWide(sbar:GetWide()/2)
	sbar:SetHideButtons(true)
	function sbar:Paint(w, h)
		draw_box(0, 0, 0, w, h, background)
	end
	function sbar.btnGrip:Paint(w, h)
		draw_box(0, 0, 0, w, h, frame.headerColor)
		draw_box(0, 0, 0, w, h, headerShader)
	end

	shell:Dock(FILL)
	shell.Paint = function()
	end
	shell.master = frame.master
	shell.headerColor = frame.headerColor or headerDefault

	-- Dashboard page
	local dashboard = XYZUI.AddNavBarPage(navBar, shell, "Dashboard", function(container)
		container:InvalidateLayout(true)

		local jobStats = XYZUI.Card(container, 75)
		jobStats:InvalidateParent(true)
		jobStats:DockMargin(0, 0, 0, 10)
		jobStats:InvalidateLayout(true)

		local currentGovCount = 0
		for _, ply in pairs(player.GetAll()) do
			if ply:isCP() then
				currentGovCount = currentGovCount + 1
			end
		end

		local plyCount = XYZUI.Title(jobStats, "Player Count", player.GetCount() .. "/" .. game.MaxPlayers(), 40, 30, true)
		plyCount:Dock(LEFT)
		plyCount:SetWide(jobStats:GetWide()/3)

		local govCount = XYZUI.Title(jobStats, "Government Count", currentGovCount, 40, 30, true)
		govCount:Dock(LEFT)
		govCount:SetWide(jobStats:GetWide()/3)

		local civCount = XYZUI.Title(jobStats, "Civilian Count", player.GetCount()-currentGovCount, 40, 30, true)
		civCount:Dock(LEFT)
		civCount:SetWide(jobStats:GetWide()/3)



		local plyStats = XYZUI.Card(container, 75)
		plyStats:InvalidateParent(true)
		plyStats:DockMargin(0, 0, 0, 10)

		local richestPlayer = LocalPlayer()
		local poorestPlayer = LocalPlayer()
		for _, ply in pairs(player.GetAll()) do
			if not IsValid(ply) then continue end
			if not richestPlayer:getDarkRPVar("money") or not ply:getDarkRPVar("money") then continue end
			if richestPlayer:getDarkRPVar("money") < ply:getDarkRPVar("money") then
				richestPlayer = ply
			end
			if poorestPlayer:getDarkRPVar("money") > ply:getDarkRPVar("money") then
				poorestPlayer = ply
			end
		end

		local richestPly = XYZUI.Title(plyStats, "Richest Online Player", XYZUI.CharLimit(richestPlayer:Name())..": "..DarkRP.formatMoney(richestPlayer:getDarkRPVar("money")), 40, 30, true)
		richestPly:Dock(LEFT)
		richestPly:SetWide(plyStats:GetWide()/2)

		local govCount = XYZUI.Title(plyStats, "Poorest Online Player", XYZUI.CharLimit(poorestPlayer:Name())..": "..DarkRP.formatMoney(poorestPlayer:getDarkRPVar("money")), 40, 30, true)
		govCount:Dock(LEFT)
		govCount:SetWide(plyStats:GetWide()/2)



		local staffCard = XYZUI.Card(container, container:GetTall()-plyStats:GetTall()-jobStats:GetTall()-20)
		staffCard:InvalidateParent(true)

		local _, staffList = XYZUI.Lists(staffCard, 1)
		staffList:InvalidateParent(true)

		local title = XYZUI.Title(staffList, "Staff Online", nil, 40, nil, true)
		title:DockMargin(0, 5, 0, 0)

		for k, v in pairs(player.GetAll()) do
			if !v:IsValid() then return end
			if not XYZShit.Staff.All[v:GetUserGroup()] then continue end

			local staffPly = XYZUI.Card(staffList, 50)
			staffPly:InvalidateParent(true)
			staffPly:DockMargin(0, 0, 0, 2)

			local name = XYZUI.PanelText(staffPly, v:Name(), nil, TEXT_ALIGN_LEFT)
			name:Dock(LEFT)
			name:DockMargin(15, 0, 0, 0)
			name:SetWide(staffList:GetWide()/2)
			local rank = XYZUI.PanelText(staffPly, string.upper(v:GetUserGroup()), nil, TEXT_ALIGN_RIGHT)
			rank:Dock(RIGHT)
			rank:DockMargin(0, 0, 15, 0)
			rank:SetWide(staffList:GetWide()/2)
		end

		staffList:SizeToContents()
		staffCard:SizeToContents()
	end, 40)
	-- Jobs page
	local jobs = XYZUI.AddNavBarPage(navBar, shell, "Jobs", function(container)
		local card = XYZUI.Card(container, 40)
		card:InvalidateParent(true)
		card:DockMargin(0, 0, 5, 0)

		local searchTag = XYZUI.Title(card, "Search a specific job:", "", 30)
		local searchInput, searchContainer = XYZUI.TextInput(card)
		searchContainer:SetWide(card:GetWide()/3)
		searchTag:SetWide(400)
		searchTag:Dock(LEFT)
		searchContainer:Dock(RIGHT)

		local function deployJobPanel(parentPnl, jobData)
			local card = XYZUI.Card(parentPnl, 70)
			card:InvalidateParent(true)
			card:DockPadding(7, 5, 2, 2)
	
			local oldPaint = card.Paint
			card.Paint = function(self, w, h)
				if not IsValid(card.mdl) then
					card.mdl = vgui.Create("DModelPanel", card)
					card.mdl:Dock(LEFT)
					card.mdl:SetFOV(30)
			
					if jobData.model[2] == "o" then
						card.mdl:SetModel(jobData.model)
					else
						card.mdl:SetModel(jobData.model[1])
					end
			
					function card.mdl:LayoutEntity( ent )
						if !IsValid(ent) then
							card.mdl:SetModel(jobData.model[1])
						end
			
    					if ent:LookupBone("ValveBiped.Bip01_Head1") != nil then
							local eyepos = ent:GetBonePosition( ent:LookupBone( "ValveBiped.Bip01_Head1" ) )
							card.mdl:SetLookAt( eyepos )
							card.mdl:SetCamPos( eyepos+Vector( 35, 0, -4 ) )
    					else 
    						eyepos = ent:GetPos()+ Vector(0,0,70)
							card.mdl:SetLookAt( eyepos )
							card.mdl:SetCamPos( eyepos+Vector( 35, 0, -4 ) )
    					end
						return
					end
				end

				oldPaint(self, w, h)
				draw_box(0, 2, 2, 4, h-4, jobData.color)
			end

			local jobTag = XYZUI.Title(card, jobData.name, DarkRP.formatMoney(jobData.salary), 35)
			jobTag:Dock(FILL)
			jobTag:DockMargin(5, 0, 5, 0)

			local jobJoin = XYZUI.ButtonInput(card, "Join", function()
				if jobData.vote then
					RunConsoleCommand("say", "/vote"..jobData.command)
				else
					RunConsoleCommand("say", "/"..jobData.command)
				end
				frame:Close()
			end)
			jobJoin:DockMargin(10, 10, 10, 10)
			jobJoin:Dock(RIGHT)

			local starJob = XYZUI.ButtonInput(card, "", function(self)
				local favState = favCache[jobData.command]
				if favState then
					favCache[jobData.command] = nil
					favJob(jobData.command, true)
				else
					favCache[jobData.command] = true
					favJob(jobData.command)
				end
			end)
			starJob:SetWide(100)
			starJob:DockMargin(10, 10, 0, 10)
			starJob.headerColor = Color(155, 115, 0)
			starJob:Dock(RIGHT)
			local oldFavPaint = starJob.Paint
			function starJob.Paint(self, w, h)
				oldFavPaint(self, w, h)

				if favCache[jobData.command] then
					XYZUI.DrawText("Unfavourite", 20, w/2, h/2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				else
					XYZUI.DrawText("Favourite", 20, w/2, h/2, white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			end
		end 


		local toDelete = {}
		local function populate(text)
			for k, v in pairs(toDelete) do
				v:Remove()
			end
			toDelete = {}
			local jobsFound = {}
			for k, v in pairs(RPExtraTeams) do
				if v.name == team.GetName(LocalPlayer():Team()) then continue end
				if text and not (text == "") then
					if not string.find(string.lower(v.name), string.lower(text)) then continue end
				end

				if !jobsFound[v.category] then
					jobsFound[v.category] = {}
					jobsFound[v.category].name = v.category
					jobsFound[v.category].order =  v.team
					jobsFound[v.category].members = {}
				end
				--jobsFound[v.category].members[k] = v
				table.insert(jobsFound[v.category].members, v)
			end

			local favTab, favList, favBody, favHeader, favMainCont
			if not table.IsEmpty(favCache) then
				favBody, favHeader, favMainCont = XYZUI.ExpandableCard(container, "Favourites")
				table.insert(toDelete, favMainCont)
				favMainCont:InvalidateParent(true)
				favMainCont:DockMargin(0, 5, 5, 5)

				favTab, favList = XYZUI.Lists(favBody, 2)
				XYZUI.AddToExpandableCardBody(favMainCont, favList)
			end

			for k, v in pairs(jobsFound) do
				local body, header, mainCont = XYZUI.ExpandableCard(container, k)
				table.insert(toDelete, mainCont)
				mainCont:InvalidateParent(true)
				mainCont:DockMargin(0, 5, 5, 5)
	
				local listTbl, list1 = XYZUI.Lists(body, 1)

				for i, p in pairs(v.members) do
					deployJobPanel(list1, p)

					if favCache[p.command] then
						deployJobPanel(favList, p)
					end
				end

				XYZUI.AddToExpandableCardBody(mainCont, list1)
				list1:SizeToContents()
				if not table.IsEmpty(favCache) then
					favList:SizeToContents()
				end
			end
		end


		function searchInput.OnTextChanged()
			populate(searchInput:GetText())
		end
		populate()
	end, 40)
	-- Store
	local store = XYZUI.AddNavBarPage(navBar, shell, "Store", function(container)
		RunConsoleCommand("xstore_menu")
		frame:Close()
	end, 40)
	-- Entities
	local entities = XYZUI.AddNavBarPage(navBar, shell, "Entities", function(container)
		for k, v in pairs(DarkRP.getCategories()["entities"]) do
			if !v.canSee then continue end
			--if table.Empty(v.members) then continue end

			local body, header, mainCont = XYZUI.ExpandableCard(container, v.name)
			mainCont:InvalidateParent(true)
			mainCont:DockMargin(0, 5, 5, 5)

			local listTbl, list1 = XYZUI.Lists(body, 1)

			for i, p in ipairs(v.members) do
				local card = XYZUI.Card(list1, 70)
				card:InvalidateParent(true)
				card:DockPadding(7, 5, 2, 2)
				local oldPaint = card.Paint
				card.Paint = function(self, w, h)
					if not IsValid(card.mdl) then
						card.mdl = vgui.Create("DModelPanel", card)
						card.mdl:Dock(LEFT)
						card.mdl:SetSize(h, h)
						card.mdl:SetModel(p.model)
			
						-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
						local mn, mx = card.mdl.Entity:GetRenderBounds()
						local size = 0
						size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
						size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
						size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
						card.mdl:SetFOV( 45 )
						card.mdl:SetCamPos( Vector( size+4, size+4, size+4 ) )
						card.mdl:SetLookAt( ( mn + mx ) * 0.5 )
						-- *|*
					end

					oldPaint(self, w, h)
				end

				local itemTag = XYZUI.Title(card, p.name, (p.price == 0 and "Free") or DarkRP.formatMoney(p.price), 35)
				itemTag:Dock(FILL)
				itemTag:DockMargin(5, 0, 5, 0)
	
				local tagPurchase = XYZUI.ButtonInput(card, "Purchase", function()
					RunConsoleCommand("say", "/"..p.cmd)
				end)
				tagPurchase:SetWide(120)
				tagPurchase:Dock(RIGHT)
				tagPurchase:DockMargin(10, 10, 10, 10)
			end

			XYZUI.AddToExpandableCardBody(mainCont, list1)
			list1:InvalidateParent(true)
			list1:SizeToContents()
		end
	end, 40)
	-- Weapons
	local weapon = XYZUI.AddNavBarPage(navBar, shell, "Weapons", function(container)
		for k, v in pairs(DarkRP.getCategories()["shipments"]) do
			if !v.canSee then continue end

			local body, header, mainCont = XYZUI.ExpandableCard(container, v.name.." (Shipments)")
			mainCont:InvalidateParent(true)
			mainCont:DockMargin(0, 5, 5, 5)

			local listTbl, list1 = XYZUI.Lists(body, 1)

			for i, p in ipairs(v.members) do
				local card = XYZUI.Card(list1, 70)
				card:InvalidateParent(true)
				card:DockPadding(7, 5, 2, 2)
				local oldPaint = card.Paint
				card.Paint = function(self, w, h)
					if not IsValid(card.mdl) then
						card.mdl = vgui.Create("DModelPanel", card)
						card.mdl:Dock(LEFT)
						card.mdl:SetSize(h, h)
						card.mdl:SetModel(p.model)
			
						-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
						local mn, mx = card.mdl.Entity:GetRenderBounds()
						local size = 0
						size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
						size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
						size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
						card.mdl:SetFOV( 45 )
						card.mdl:SetCamPos( Vector( size+4, size+4, size+4 ) )
						card.mdl:SetLookAt( ( mn + mx ) * 0.5 )
						-- *|*
					end

					oldPaint(self, w, h)
				end

				local itemTag = XYZUI.Title(card, p.name.." (x10)", (p.price == 0 and "Free") or DarkRP.formatMoney(p.price), 35)
				itemTag:Dock(FILL)
				itemTag:DockMargin(5, 0, 5, 0)
	
				local tagPurchase = XYZUI.ButtonInput(card, "Purchase", function()
					RunConsoleCommand("say", "/buyshipment "..p.name)
				end)
				tagPurchase:SetWide(120)
				tagPurchase:Dock(RIGHT)
				tagPurchase:DockMargin(10, 10, 10, 10)
			end

			XYZUI.AddToExpandableCardBody(mainCont, list1)
			list1:InvalidateParent(true)
			list1:SizeToContents()
		end
		for k, v in pairs(DarkRP.getCategories()["weapons"]) do
			if !v.canSee then continue end

			local body, header, mainCont = XYZUI.ExpandableCard(container, v.name)
			mainCont:InvalidateParent(true)
			mainCont:DockMargin(0, 5, 5, 5)

			local listTbl, list1 = XYZUI.Lists(body, 1)

			for i, p in ipairs(v.members) do
				local card = XYZUI.Card(list1, 70)
				card:InvalidateParent(true)
				card:DockPadding(7, 5, 2, 2)
				local oldPaint = card.Paint
				card.Paint = function(self, w, h)
					if not IsValid(card.mdl) then
						card.mdl = vgui.Create("DModelPanel", card)
						card.mdl:Dock(LEFT)
						card.mdl:SetSize(h, h)
						card.mdl:SetModel(p.model)
			
						-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
						local mn, mx = card.mdl.Entity:GetRenderBounds()
						local size = 0
						size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
						size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
						size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
						card.mdl:SetFOV( 45 )
						card.mdl:SetCamPos( Vector( size+4, size+4, size+4 ) )
						card.mdl:SetLookAt( ( mn + mx ) * 0.5 )
						-- *|*
					end

					oldPaint(self, w, h)
				end

				local itemTag = XYZUI.Title(card, p.name, (p.price == 0 and "Free") or DarkRP.formatMoney(p.pricesep), 35)
				itemTag:Dock(FILL)
				itemTag:DockMargin(5, 0, 5, 0)
	
				local tagPurchase = XYZUI.ButtonInput(card, "Purchase", function()
					RunConsoleCommand("say", "/buy "..p.name)
				end)
				tagPurchase:SetWide(120)
				tagPurchase:Dock(RIGHT)
			end

			XYZUI.AddToExpandableCardBody(mainCont, list1)
			list1:InvalidateParent(true)
			list1:SizeToContents()
		end
	end, 40)
	local quests = XYZUI.AddNavBarPage(navBar, shell, "Quests", function(container)
		local _, shell = XYZUI.Lists(container, 1)
		shell:Dock(FILL)
		shell.Paint = nil

		XYZUI.PanelText(shell, "Active Quests", 50, TEXT_ALIGN_LEFT)
		for k, v in pairs(Quest.Config.Storylines) do
			if (not Quest.Storylines[k]) or (Quest.Storylines[k][#v.quests] == true) then continue end
			
			local card = XYZUI.Card(shell, 65)
			card:InvalidateParent(true)
			card:DockMargin(0, 0, 0, 5)
			card:DockPadding(0, -5, 0, 0)

			local title = XYZUI.Title(card, v.name, v.desc, 40, 30)
			title:DockMargin(5, 0, 0, 0)
			title:Dock(FILL)

			local btn = XYZUI.ButtonInput(card, "Set Active", function()
				Quest.Core.SetActive(k)
			end)
			btn:Dock(RIGHT)
			btn:SetWide(100)
			btn:DockMargin(10, 15, 10, 10)
		end

		XYZUI.PanelText(shell, "Complete Quests", 50, TEXT_ALIGN_LEFT)
		for k, v in pairs(Quest.Config.Storylines) do
			if (not Quest.Storylines[k]) or (Quest.Storylines[k][#v.quests] == nil) then continue end

			local card = XYZUI.Card(shell, 65)
			card:InvalidateParent(true)
			card:DockMargin(0, 0, 0, 5)
			card:DockPadding(0, -5, 0, 0)

			local title = XYZUI.Title(card, v.name, v.desc, 40, 30)
			title:DockMargin(5, 0, 0, 0)
			title:Dock(FILL)
		end
	end, 40)
	local website = XYZUI.AddNavBarPage(navBar, shell, "Website", function(container)
		local html = vgui.Create("DHTML", container)
		html:Dock(FILL)
		html:SetTall(container:GetTall())
		html:OpenURL("https://thexyznetwork.xyz")
	end, 40)
	local content = XYZUI.AddNavBarPage(navBar, shell, "Content", function(container)
		local html = vgui.Create("DHTML", container)
		html:Dock(FILL)
		html:SetTall(container:GetTall())
		html:OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=1331794713")
	end, 40)
	content:SetTall(60)
	-- Rewards
	XYZUI.AddNavBarPage(navBar, shell, "Rewards", function(container)
		RunConsoleCommand("say", "!rewards")
		frame:Close()
	end, 40)
end

timer.Simple(2, function()
	GAMEMODE.ShowSpare2 = XYZUI.BuildF4Menu
end) 

concommand.Add("xyz_f4", function()
	XYZUI.BuildF4Menu()
end)