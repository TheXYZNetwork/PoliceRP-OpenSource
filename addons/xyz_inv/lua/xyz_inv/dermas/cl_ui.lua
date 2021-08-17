local draw_box = draw.RoundedBox
local headerShader = Color(0, 0, 0, 55)
local headerDefault = Color(2, 108, 254)
local background = Color(18, 18, 18)

function Inventory.Core.GetFavItems()
	if not sql.TableExists("xyz_fav_inv") then
		sql.Query("CREATE TABLE xyz_fav_inv(class TEXT PRIMARY KEY)")
	end
	
	local results = sql.Query("SELECT * FROM xyz_fav_inv")
	if not results then return {} end

	local items = {}

	for k, v in pairs(results) do
		items[v.class] = true
	end

	return items
end
Inventory.Core.FavItems = Inventory.Core.GetFavItems()

function Inventory.Core.FavItem(class)
	if not sql.TableExists("xyz_fav_inv") then
		sql.Query("CREATE TABLE xyz_fav_inv(class TEXT PRIMARY KEY)")
	end

	sql.Query("INSERT INTO xyz_fav_inv VALUES("..sql.SQLStr(class)..")")

	Inventory.Core.FavItems[class] = true
end
function Inventory.Core.UnfavItem(class)
	if not sql.TableExists("xyz_fav_inv") then
		sql.Query("CREATE TABLE xyz_fav_inv(class TEXT PRIMARY KEY)")
	end

	sql.Query("DELETE FROM xyz_fav_inv WHERE class="..sql.SQLStr(class))

	Inventory.Core.FavItems[class] = false
end


function Inventory.Core.OpenInv()
	local frame = XYZUI.Frame("Inventory", Color(2, 108, 254))
	frame:SetSize(ScrH()*0.8, ScrH()*0.406) -- Odd number so that it fits nicely for 1920x1080
	frame:Center()

	local navBar = XYZUI.NavBar(frame)
	local shell = XYZUI.Container(frame)

	for k, v in ipairs(Inventory.Config.Tabs) do
		XYZUI.AddNavBarPage(navBar, shell, v.name, function(shell)
			local items = v.filter(Inventory.SavedInvs)

			local stacks = {}
			for k, v in pairs(items) do
				if not stacks[v.class] then
					stacks[v.class] = {}
					stacks[v.class].count = 0
					stacks[v.class].sample = v
				end
				stacks[v.class].count = stacks[v.class].count + 1
			end
		
			local contList = vgui.Create("ThreeGrid", shell)
			contList:Dock(FILL)
			contList:DockPadding(5, 5, 5, 5)
			contList:SetTall(math.ceil(table.Count(stacks)/8)*100)
			contList:SetWide(shell:GetWide())
			contList:InvalidateParent(true)
			contList:SetColumns(8)
		
				local sbar = contList:GetVBar()
				sbar:SetWide(sbar:GetWide()/2)
				sbar:SetHideButtons(true)
				function sbar:Paint(w, h)
					draw_box(0, 0, 0, w, h, background)
				end
				function sbar.btnGrip:Paint(w, h)
					draw_box(0, 0, 0, w, h, contList.headerColor or headerDefault)
					draw_box(0, 0, 0, w, h, headerShader)
				end
		
			local i = 0
			for k, v in pairs(stacks) do
				if not v.sample then continue end
				i = i + 1
				local card = XYZUI.Card(contList, frame:GetWide()/8)
				card:DockMargin(0, 0, 5, 5)
				contList:AddCell(card)
		
				local model = vgui.Create("DModelPanel", card)
				model:SetSize(card:GetTall(), card:GetTall())
				model:Dock(FILL)
				model:SetModel(v.sample.data.info.displayModel)
				model:DockMargin(0, 0, 2, 0)
		
					-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
					local mn, mx = model.Entity:GetRenderBounds()
					local size = 0
					size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
					size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
					size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
					model:SetFOV(40)
					model:SetCamPos( Vector( size+4, size+4, size+4 ) )
					model:SetLookAt( ( mn + mx ) * 0.5 )
					-- *|*
				model.Think = function(me)
					if IsValid(me.actions) then return end -- Buttons are not targetable while the popup is active :/

					if me:IsHovered() and not IsValid(me.hoverName) then
						me.hoverName = XYZUI.Frame("popup", nil, true, true)
						me.hoverName:SetSize(150, 45)
						local x, y = gui.MousePos()
						y = y - me.hoverName:GetTall() + 5
						x = x + 5
						me.hoverName:SetPos(x, y)
						me.hoverName:DockPadding(0, 0, 0, 0)
						me.hoverName.shell = XYZUI.Container(me.hoverName)
						me.hoverName.shell:DockMargin(0, 0, 0, 0)
						function me.hoverName:Think()
							local x, y = gui.MousePos()
							y = y - self:GetTall() + 5
							x = x + 5
							self:SetPos(x, y)
							if not IsValid(me) then
								self:Remove()
							end
						end

						local title = XYZUI.PanelText(me.hoverName.shell, v.sample.data.info.displayName or "Unknown", 25, TEXT_ALIGN_LEFT)	
						if v.sample.data.type.isWeapon then
							title.text = weapons.Get(v.sample.data.info.displayName).PrintName
						end
						title:DockMargin(0, 0, 0, -5)
						local count = XYZUI.PanelText(me.hoverName.shell, "Count: ".."x"..v.count, 20, TEXT_ALIGN_LEFT)


						surface.SetFont("xyz_ui_main_font_25")
						local titleSize = surface.GetTextSize(title.text)
						surface.SetFont("xyz_ui_main_font_20")
						local countSize = surface.GetTextSize(count.text)
						local newSize = titleSize > countSize and titleSize or countSize

						me.hoverName:SetWide(newSize + 15)
					elseif not me:IsHovered() and IsValid(me.hoverName) then
						me.hoverName:Remove() 
					end
				end
				model.DoClick = function()
					if IsValid(model.hoverName) then model.hoverName:Remove() end

					model.actions = DermaMenu() 
					if v.sample.data.type.isWeapon then
						model.actions:AddOption("Equip", function()
							net.Start("XYZInv:EquipItem")
								net.WriteString(v.sample.class)
							net.SendToServer()
				
							frame:Close()
						end)
						:SetIcon("icon16/status_online.png")
					end

					if XYZShit.InOrg then 
						model.actions:AddSpacer()

						model.actions:AddOption("Send to organization inventory", function()
							net.Start("XYZInv:MoveToOrg")
								net.WriteString(v.sample.class)
							net.SendToServer()
				
							frame:Close()
						end)
						:SetIcon("icon16/brick_go.png")

						model.actions:AddSpacer()
					end

					model.actions:AddOption("Drop", function()
						net.Start("XYZInv:DropItem")
							net.WriteString(v.sample.class)
						net.SendToServer()
			
						frame:Close()
					end)
					:SetIcon("icon16/arrow_undo.png")

					local locker, lockerP = model.actions:AddSubMenu("Move To Locker")
					lockerP:SetIcon("icon16/lock_add.png")
					locker:AddOption("1 Item", function()
						net.Start("XYZInv:MoveToLocker")
							net.WriteString(v.sample.class)
							net.WriteUInt(1, 7)
						net.SendToServer()
			
						frame:Close()
					end)
					locker:AddOption("5 Items", function()
						net.Start("XYZInv:MoveToLocker")
							net.WriteString(v.sample.class)
							net.WriteUInt(5, 7)
						net.SendToServer()
			
						frame:Close()
					end)
					locker:AddOption("10 Items", function()
						net.Start("XYZInv:MoveToLocker")
							net.WriteString(v.sample.class)
							net.WriteUInt(10, 7)
						net.SendToServer()
			
						frame:Close()
					end)
					locker:AddOption("All Items", function()
						net.Start("XYZInv:MoveToLocker")
							net.WriteString(v.sample.class)
							net.WriteUInt(v.count, 7)
						net.SendToServer()
			
						frame:Close()
					end)

					model.actions:AddSpacer()

					if Inventory.Core.FavItems[v.sample.class] then
						model.actions:AddOption("Unfavourite", function()
							Inventory.Core.UnfavItem(v.sample.class)
						end)
						:SetIcon("icon16/star.png")
					else
						model.actions:AddOption("Favourite", function()
							Inventory.Core.FavItem(v.sample.class)
						end)
						:SetIcon("icon16/star.png")
					end
					model.actions:AddOption("Destroy", function()
						XYZUI.Confirm("Destroy Item", Color(200, 0, 0), function()
							net.Start("XYZInv:DestroyItem")
								net.WriteString(v.sample.class)
							net.SendToServer()
					
							if not IsValid(frame) then return end

							frame:Close()
						end)
					end)
					:SetIcon("icon16/bomb.png")
					model.actions:AddOption("Destroy All", function()
						XYZUI.Confirm("Destroy All Of This Item", Color(200, 0, 0), function()
							net.Start("XYZInv:DestroyItem:All")
								net.WriteString(v.sample.class)
							net.SendToServer()
					
							if not IsValid(frame) then return end

							frame:Close()
						end)
					end)
					:SetIcon("icon16/bomb.png")

					model.actions:AddSpacer()

					model.actions:AddOption("Close", function() end) -- The menu will remove itself, we don't have to do anything.
					model.actions:Open()
				end
			end

		end)
	end

	return frame
end


function Inventory.Core.OpenLocker()
	local frame = XYZUI.Frame("Bank Locker", Color(2, 108, 254))
	frame:SetSize(ScrH()*0.5, ScrH()*0.8)
	frame:Center()

	local shell = XYZUI.Container(frame)

	local _, contList = XYZUI.Lists(shell, 1)
	contList:DockPadding(5, 5, 5, 5)


	net.Start("XYZInv:RequestLocker")
	net.SendToServer()


	local bankItems = {}
	net.Receive("XYZInv:SendBank", function()
		if not IsValid(frame) then return end
		contList:Clear()
		
		-- Add the new items
		local newItems = net.ReadTable()
		for k, v in pairs(newItems) do
			table.insert(bankItems, v)
		end

		local stacks = {}
		for k, v in pairs(bankItems) do
			if not stacks[v.class] then
				stacks[v.class] = {}
				stacks[v.class].count = 0
				stacks[v.class].sample = v
			end
			stacks[v.class].count = stacks[v.class].count + 1
		end

		for k, v in pairs(stacks) do
			local card = XYZUI.Card(contList, 70)
			card:DockMargin(0, 0, 0, 5)
	
			local model = vgui.Create("DModelPanel", card)
			model:SetSize(card:GetTall(), card:GetTall())
			model:Dock(LEFT)
			model:SetModel(v.sample.data.info.displayModel)
			model:DockMargin(0, 0, 2, 0)
	
				-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
				local mn, mx = model.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
				size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
				size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
				model:SetFOV(40)
				model:SetCamPos( Vector( size+4, size+4, size+4 ) )
				model:SetLookAt( ( mn + mx ) * 0.5 )
				-- *|*
	
			local info = XYZUI.Title(card, v.sample.data.info.displayName or "Unknown", "Count: ".."x"..v.count, 40, 30)
			if v.sample.data.type.isWeapon then
				info.title = weapons.Get(v.sample.data.info.displayName).PrintName
			end
			info:Dock(FILL)

			local transferBtn = XYZUI.ButtonInput(card, "Move To Inv", function()
				v.count = v.count - 1

				net.Start("XYZInv:MoveToInv")
					net.WriteString(v.sample.class)
				net.SendToServer()

				if v.count <= 0 then
					card:Remove()
				else
					info.subTitle = "Count: ".."x"..v.count
				end
			end)
			transferBtn:Dock(RIGHT)
			transferBtn:SetWide(frame:GetWide()*0.2)
			transferBtn:DockMargin(10, 10, 10, 10)
		end
	end)
end


local contextInv = nil
hook.Add("OnContextMenuOpen", "XUZInvHookContextMenu", function()
	if IsValid(contextInv) then
		contextInv:Remove()
	end

	contextInv = Inventory.Core.OpenInv()
	local curX = contextInv:GetPos()
	contextInv:SetTall(ScrH()*0.3058)
	contextInv:SetPos(curX, ScrH()-contextInv:GetTall())
end)
hook.Add("OnContextMenuClose", "XUZInvHookContextMenu", function()
	if IsValid(contextInv) then
		contextInv:Remove()
	end
end)