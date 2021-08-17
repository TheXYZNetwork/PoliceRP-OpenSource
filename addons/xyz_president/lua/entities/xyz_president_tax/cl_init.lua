include("shared.lua")

local white = Color(255,255,255)
local darkblue = Color(3,20,36)
local blue = Color(48,65,93)
local lightblue = Color(142,174,189)
local red = Color(207,103,102)

function ENT:Draw()
	self:DrawModel()
end