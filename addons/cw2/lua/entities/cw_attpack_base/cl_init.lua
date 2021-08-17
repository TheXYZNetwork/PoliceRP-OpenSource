include("shared.lua")

local baseFont = "CW_HUD72"

ENT.displayDistance = 256 -- the distance within which the contents of the box will be displayed

function ENT:Initialize()
	self:setupAttachmentDisplayData()
end

function ENT:getTopPartColor()
	return CustomizableWeaponry.ITEM_PACKS_TOP_COLOR.r, CustomizableWeaponry.ITEM_PACKS_TOP_COLOR.g, CustomizableWeaponry.ITEM_PACKS_TOP_COLOR.b, CustomizableWeaponry.ITEM_PACKS_TOP_COLOR.a
end

function ENT:setupAttachmentDisplayData()
	-- initialize everything in advance, to not do shit when we're drawing, since there may be lots of these packages and we want the best possible performance
	self.attachmentNames = CustomizableWeaponry:ent_buildAttachmentNameStrings(self:getAttachments())
	
	-- get the largest text size
	surface.SetFont(baseFont)
	
	self.horizontalSize, self.verticalFontSize = surface.GetTextSize(self:getMainText())
	
	for k, v in ipairs(self.attachmentNames) do
		local x = surface.GetTextSize(v.display)
		
		if x > self.horizontalSize then
			self.horizontalSize = x
		end
		
		v.vertPos = (k - 1) * -self.verticalFontSize + 5
	end
	
	-- figure out sizes to draw, positions to draw on
	self.horizontalSize = self.horizontalSize + 20
	self.halfHorizontalSize = self.horizontalSize * 0.5
	
	self.arraySize = #self.attachmentNames
	self.verticalSize = self.arraySize * self.verticalFontSize + 15
	
	self.basePos = (self.verticalSize + 1 * self.verticalFontSize) - self.verticalFontSize * 0.75
	self.blackBarPos = self.basePos - self.verticalFontSize
end

local up = Vector(0, 0, 15)
local white, black, green = Color(255, 255, 255, 255), Color(0, 0, 0, 255), Color(215, 255, 160, 255)
local gray = Color(180, 180, 180, 255)

function ENT:getNoAttachmentColor()
	return gray
end

function ENT:getAttachmentColor()
	return green
end

local drawShadowText = draw.ShadowText
local surfaceSetDrawColor = surface.SetDrawColor
local surfaceDrawRect = surface.DrawRect

function ENT:getMainText()
	return self.PackageText
end

function ENT:Draw()
	self:DrawModel()
	
	self.inRange = not (ply:GetPos():Distance(self:GetPos()) > self.displayDistance)
	
	if not self.halfHorizontalSize then
		return
	end
	
	local ply = LocalPlayer()
	
	if not self.inRange then
		return
	end
	
	local eyeAng = EyeAngles()
	eyeAng.p = 0
	eyeAng.y = eyeAng.y - 90
	eyeAng.r = 90
	
	cam.Start3D2D(self:GetPos() + up, eyeAng, 0.05)
		local r, g, b, a = self:getTopPartColor()
		surfaceSetDrawColor(r, g, b, a)
		surfaceDrawRect(-self.halfHorizontalSize, -self.basePos, self.horizontalSize, self.verticalFontSize)
		
		surfaceSetDrawColor(0, 0, 0, 150)
		surfaceDrawRect(-self.halfHorizontalSize, -self.blackBarPos, self.horizontalSize, self.verticalSize - 10)
		
		drawShadowText(self:getMainText(), baseFont, 0, self.arraySize * -self.verticalFontSize, white, black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		
		for k, v in ipairs(self.attachmentNames) do
			if ply.CWAttachments[v.name] then
				drawShadowText(v.display, baseFont, 0, v.vertPos, self:getNoAttachmentColor(), black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				drawShadowText(v.display, baseFont, 0, v.vertPos, self:getAttachmentColor(), black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
	cam.End3D2D()
end