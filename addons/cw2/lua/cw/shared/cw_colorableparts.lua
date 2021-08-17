AddCSLuaFile()

-- this module adds the ability to choose various colors for your reticles/laser sights

CustomizableWeaponry.colorableParts = {}

CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT = 1
CustomizableWeaponry.colorableParts.COLOR_TYPE_BEAM = 2
CustomizableWeaponry.colorableParts.colors = {[CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT] = {},
	[CustomizableWeaponry.colorableParts.COLOR_TYPE_BEAM] = {}}
	
CustomizableWeaponry.colorableParts.colorText = {[CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT] = " (HOLD - change reticle color)",
	[CustomizableWeaponry.colorableParts.COLOR_TYPE_BEAM] = " (HOLD - change beam color)"}

function CustomizableWeaponry.colorableParts:addReticleColor(ret)
	--self.reticleColors[] = ret
	table.insert(self.colors[self.COLOR_TYPE_SIGHT], ret)
end

function CustomizableWeaponry.colorableParts:addLaserColor(laser)
	--self.laserColors[laser.name] = laser
	table.insert(self.colors[self.COLOR_TYPE_BEAM], laser)
end

-- use this function to register new categories for colorable stuff
function CustomizableWeaponry.colorableParts:registerNewColorableCategory(name, enumeration, id)
	CustomizableWeaponry.colorableParts[enumeration] = id
	CustomizableWeaponry.colorableParts.colors[enumeration] = {}
end

function CustomizableWeaponry.colorableParts:cycleColor(data)
	local result
	local colors = CustomizableWeaponry.colorableParts.colors[data.type]
	
	-- if there is another entry in the table, use it
	if colors[data.last + 1] then
		data.last = data.last + 1
		result = colors[data.last]
	else
		-- if there isn't, go back to the beginning of it
		data.last = 1
		result = colors[1]
	end
	
	-- apply the new color
	data.color = result.color
	data.display = CustomizableWeaponry.colorableParts:makeColorDisplayText(result.display)
	
	self.SightColorTarget = nil
	
	if CustomizableWeaponry.playSoundsOnInteract then
		surface.PlaySound("cw/selector.wav")
	end
end

function CustomizableWeaponry.colorableParts:setColor(index, position)
	-- can't load if not enough info is provided
	if not index or not position then
		return
	end
	
	local target = self.SightColors[index]
	local colors = CustomizableWeaponry.colorableParts.colors[target.type]
	
	if not colors then
		return
	end
	
	colors = colors[position]
	
	target.last = position
	target.color = colors.color
	target.display = CustomizableWeaponry.colorableParts:makeColorDisplayText(colors.display)
end

function CustomizableWeaponry.colorableParts:resetColors()
	for k, v in pairs(self.SightColors) do
		CustomizableWeaponry.colorableParts.resetColor(self, v)
	end
end

function CustomizableWeaponry.colorableParts:resetColor(entry)
	local def = CustomizableWeaponry.colorableParts.defaultColors[entry.type]
	
	entry.last = 1
	entry.color = def.color
	entry.display = CustomizableWeaponry.colorableParts:makeColorDisplayText(def.display)
end

function CustomizableWeaponry.colorableParts:makeColorDisplayText(text)
	return " - " .. text
end

local path = "cw/shared/colors/"

-- load colorable part files

for k, v in pairs(file.Find("cw/shared/colors/*", "LUA")) do
	loadFile(path .. v)
end

CustomizableWeaponry.colorableParts.defaultColors = {[CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT] = CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT][1],
[CustomizableWeaponry.colorableParts.COLOR_TYPE_BEAM] = CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_BEAM][1]}