-- Cache
local scrW, scrH = ScrW, ScrH
local vgui_create = vgui.Create
local color = Color
local draw_box = draw.RoundedBox
local surface_setdrawcolor = surface.SetDrawColor
local surface_setmaterial = surface.SetMaterial
local surface_drawtexturedrect = surface.DrawTexturedRect
local surface_drawtexturedrectrotated = surface.DrawTexturedRectRotated
local math_floor = math.floor
local math_round = math.Round
local lerp = Lerp

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



function XYZUI.Title(container, title, subTitle, size, subSize, centered)
	if not IsValid(container) then return end

	local titleContainer = vgui_create("DPanel", container)
	if subTitle then
		titleContainer:SetTall(70)
	else
		titleContainer:SetTall(40)
	end
	titleContainer:Dock(TOP)
	titleContainer.headerColor = container.headerColor or headerDefault
	titleContainer.master = container.master
	titleContainer.title = title
	titleContainer.subTitle = subTitle
	titleContainer.titleColor = white
	titleContainer.subTitleColor = white

	local halfSize = subSize
	if centered then
		if subTitle then
			function titleContainer.Paint(self, w, h)
				XYZUI.DrawText(titleContainer.title, size or 50, w/2, 5, titleContainer.titleColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
				XYZUI.DrawText(titleContainer.subTitle, halfSize or 25, w/2, h-5, titleContainer.subTitleColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
			end
		else
			function titleContainer.Paint(self, w, h)
				XYZUI.DrawText(titleContainer.title, size or 50, w/2, 0, titleContainer.titleColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end
		end
	else
		if subTitle then
			function titleContainer.Paint(self, w, h)
				XYZUI.DrawText(titleContainer.title, size or 50, 5, 5, titleContainer.titleColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
				XYZUI.DrawText(titleContainer.subTitle, halfSize or 25, 5, h-5, titleContainer.subTitleColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			end
		else
			function titleContainer.Paint(self, w, h)
				XYZUI.DrawText(titleContainer.title, size or 50, 5, 0, titleContainer.titleColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			end
		end
	end

	return titleContainer
end

function XYZUI.PanelText(container, text, size, locAlign)
	local panel = vgui.Create("DPanel", container)
	panel:SetWide(container:GetWide())
	panel:Dock(TOP)
	panel:SetTall(size or 40)
	panel.text = text
	panel.color = white
	panel.Paint = function(self, w, h)
		XYZUI.DrawText(self.text, size or 40, (locAlign == TEXT_ALIGN_LEFT and 5) or (locAlign == TEXT_ALIGN_RIGHT and w-5) or w/2, h/2, self.color, locAlign or TEXT_ALIGN_CENTER)
	end

	return panel
end

function XYZUI.WrappedText(container, text, size)
	if not IsValid(container) then return end
	if not text then return end

	local textContainer = vgui_create("DLabel", container)
	textContainer:SetFont("xyz_ui_main_font_"..(size or 10))
	textContainer:SetText(text or "Please set the text :(")
	textContainer:Dock(FILL)
	textContainer:SetWrap(true)
	textContainer:SetAutoStretchVertical(true)
	textContainer:SetColor(Color(255, 255, 255))
	textContainer:DockMargin(5, 0, 5, 0)

	textContainer.master = container.master
	textContainer.headerColor = container.headerColor or headerDefault

	return textContainer
end

function XYZUI.Card(container, height)
	--if not IsValid(container) then return end

	local card = vgui_create("DPanel", container or nil)
	card:SetTall(height or 40)
	card:Dock(TOP)

	card.master = container and container.master or nil 
	card.headerColor = container and container.headerColor or headerDefault

	function card.Paint(self, w, h)
		draw_box(0, 0, 0, w, h, background)

		draw_box(0, 0, 0, w, 2, outline)
		draw_box(0, w-2, 0, 2, h, outline)
		draw_box(0, 0, h-2, w, 2, outline)
		draw_box(0, 0, 0, 2, h, outline)
		
		surface_setdrawcolor(0, 0, 0, 255)
		surface_setmaterial(gradientDown)
		surface_drawtexturedrect(2, 2, w-4, gradientSize)
		surface_setmaterial(gradientUp)
		surface_drawtexturedrect(2, h-gradientSize-2, w-4, gradientSize)
		surface_setmaterial(gradientMain)
		surface_drawtexturedrect(2, 2, gradientSize, h-4)
		surface_drawtexturedrectrotated(w-(gradientSize/2)-2, h/2, gradientSize, h-4, 180)
	end

	return card
end

function XYZUI.ExpandableCard(container, name, height)
	if not IsValid(container) then return end

	local mainContainer = vgui_create("DPanel", container)
	mainContainer:Dock(TOP)
	mainContainer:SetTall(height or 40)
	function mainContainer.Paint()
	end

	mainContainer.master = container.master
	mainContainer.headerColor = container.headerColor or headerDefault
	mainContainer.elements = {}

	local card = vgui_create("DButton", mainContainer)
	card:SetTall(height or 40)
	card:Dock(TOP)
	card:SetText("")

	card.master = container.master
	card.headerColor = container.headerColor or headerDefault
	card.name = card.name or name
	card.isDropped = false

	function card.Paint(self, w, h)
		draw_box(0, 0, 0, w, h, self.headerColor)
		draw_box(0, 0, 0, w, 5, headerShader)
		draw_box(0, 0, h-5, w, 5, headerShader)
		draw_box(0, 0, 5, 5, h-10, headerShader)
		draw_box(0, w-5, 5, 5, h-10, headerShader)

		XYZUI.DrawText(card.name or "Want me to reveal myself? :O", 20, 10, h/2, white, TEXT_ALIGN_LEFT)
		if self.isDropped then
			XYZUI.DrawText(title or "▲", 20, w-10, h/2, white, TEXT_ALIGN_RIGHT)
		else
			XYZUI.DrawText(title or "▼", 20, w-10, h/2, white, TEXT_ALIGN_RIGHT)
		end
	end

	local body = XYZUI.Container(mainContainer)
	body:SetTall(0)
	body:Dock(FILL)
	body.master = container.master
	body.headerColor = container.headerColor or headerDefault

	function card.DoClick()
		card.isDropped = not card.isDropped
		
		body:InvalidateLayout(true)
		body:SizeToContents()

		local increase = 2
		for k, v in pairs(mainContainer.elements) do
			increase = increase + v:GetTall()
		end
		mainContainer:SizeTo(mainContainer:GetWide(), (height or 40) + (card.isDropped and increase or 0), 0.6)
	end

	mainContainer.body = body
	mainContainer.card = card

	return body, card, mainContainer
end

function XYZUI.AddToExpandableCardBody(container, panel)
	panel:SetParent(container.body)
	panel:Dock(TOP)
	table.insert(container.elements, panel)
end

function XYZUI.Divider(container, color)
	local panel = vgui.Create("DPanel", container)
	panel:SetWide(container:GetWide())
	panel:Dock(TOP)
	panel:SetTall(2)
	panel:DockMargin(0, 15, 0, 15)
	panel.Paint = function(self, w, h)
		draw_box(0, 5, 0, w-10, h, color or bubble)
	end

	return panel
end