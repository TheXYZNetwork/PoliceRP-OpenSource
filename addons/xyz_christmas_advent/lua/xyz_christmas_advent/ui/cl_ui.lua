local PANEL = {}

AccessorFunc(PANEL, "horizontalMargin", "HorizontalMargin", FORCE_NUMBER)
AccessorFunc(PANEL, "verticalMargin", "VerticalMargin", FORCE_NUMBER)
AccessorFunc(PANEL, "columns", "Columns", FORCE_NUMBER)

function PANEL:Init()
	self:SetHorizontalMargin(0)
	self:SetVerticalMargin(0)

	self.Rows = {}
	self.Cells = {}
end

function PANEL:AddCell(pnl)
	local cols = self:GetColumns()
	local idx = math.floor(#self.Cells/cols)+1
	self.Rows[idx] = self.Rows[idx] || self:CreateRow()

	local margin = self:GetHorizontalMargin()
	
	pnl:SetParent(self.Rows[idx])
	pnl:Dock(LEFT)
	pnl:DockMargin(0, 0, #self.Rows[idx].Items+1 < cols && self:GetHorizontalMargin() || 0, 0)
	pnl:SetWide((self:GetWide()-margin*(cols-1))/cols)

	table.insert(self.Rows[idx].Items, pnl)
	table.insert(self.Cells, pnl)
	self:CalculateRowHeight(self.Rows[idx])
end

function PANEL:CreateRow()
	local row = self:Add("DPanel")
	row:Dock(TOP)
	row:DockMargin(0, 0, 0, self:GetVerticalMargin())
	row.Paint = nil
	row.Items = {}
	return row
end

function PANEL:CalculateRowHeight(row)
	local height = 0

	for k, v in pairs(row.Items) do
		height = math.max(height, v:GetTall())
	end

	row:SetTall(height)
end

function PANEL:Skip()
	local cell = vgui.Create("DPanel")
	cell.Paint = nil
	self:AddCell(cell)
end

function PANEL:Clear()
	for _, row in pairs(self.Rows) do
		for _, cell in pairs(row.Items) do
			cell:Remove()
		end
		row:Remove()
	end

	self.Cells, self.Rows = {}, {}
end

PANEL.OnRemove = PANEL.Clear

vgui.Register("ThreeGrid", PANEL, "DScrollPanel")

hook.Add("HUDPaint", "ShowAdventOnJoin", function()
	XYZChristmasAdvent.Core.UI()
	hook.Remove("HUDPaint", "ShowAdventOnJoin")
end)

function XYZChristmasAdvent.Core.UI()
	local frame = XYZUI.Frame("Advent Calendar", Color(246, 70, 99))
	frame:SetSize(ScrH()*0.9, ScrH()*0.9)
	frame:Center()

	local grid = vgui.Create("ThreeGrid", frame)
	grid:Dock(FILL)
	grid:InvalidateParent(true)
	grid:SetColumns(5)
	grid:SetHorizontalMargin(0)
	grid:SetVerticalMargin(0)
	grid.Paint = function(self, w, h)
	--	draw.RoundedBox(0, 0, 0, w, h, Color(255, 0, 0))
	end

	for _, i in pairs(XYZChristmasAdvent.Config.DoorOrder) do
		local door = vgui.Create("DButton")
		door:SetText("")
		door:SetTall(grid:GetTall()/5)
		door.Paint = function(self, w, h)
			if XYZChristmasAdvent.OpenedDoors[i] then
				--Door is open
				draw.RoundedBox(0, 5, 5, w-10, h-10, Color(40, 40, 40))
				if i == XYZChristmasAdvent.CurrentDay then
					draw.RoundedBox(0, w-15, 5, 10, h-10, Color(218, 165, 32))
				else
					draw.RoundedBox(0, w-15, 5, 10, h-10, Color(246, 70, 99))
				end
			else
				--Door is closed
				if i == XYZChristmasAdvent.CurrentDay then
					draw.RoundedBox(0, 5, 5, w-10, h-10, Color(218, 165, 32))
				else
					draw.RoundedBox(0, 5, 5, w-10, h-10, Color(246, 70, 99))
				end
				draw.RoundedBox(0, 10, h/2-20, 15, 40, Color(80, 80, 80))
			end


			XYZUI.DrawText(i, 50, w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		door.DoClick = function()
			if XYZChristmasAdvent.OpenedDoors[i] then return end
			if not (i == XYZChristmasAdvent.CurrentDay) then return end

			net.Start("XYZChristmasAdvent:OpenToday")
			net.SendToServer()

			XYZChristmasAdvent.OpenedDoors[i] = true
		end
		grid:AddCell(door)
	end
end
