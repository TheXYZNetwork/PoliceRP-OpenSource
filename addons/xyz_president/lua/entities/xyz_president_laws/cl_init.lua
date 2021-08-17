include("shared.lua")

local laws = {}

local function buildLawBoard()
    XYZ_LAW_BOARD = XYZUI.Frame("", Color(2, 108, 254), false, true, true)
    XYZ_LAW_BOARD:SetSize(960, 540)
    XYZ_LAW_BOARD:Center()
    XYZUI.Title(XYZ_LAW_BOARD, "Laws", "", 30, 20, true)
    for k, v in ipairs(DarkRP.getLaws()) do
        laws[k] = XYZUI.Title(XYZ_LAW_BOARD, v, nil, 30, 20, true)
    end
    hook.Add("addLaw", "xyzaddlaw", function(i, law)
        laws[i] = XYZUI.Title(XYZ_LAW_BOARD, law, nil, 30, 20, true)
    end)
    hook.Add("removeLaw", "xyzremovelaw", function(i)
        if not i then return end
        laws[i]:Remove()
        table.remove(laws, i)
    end)
    hook.Add("resetLaws", "xyzrestslaws", function(i)
        XYZ_LAW_BOARD:Remove()
        laws = {}
    end)
end

function ENT:Initialize()
    localplayer = LocalPlayer()
end

local offSet = Vector(224, 3, 127)
function ENT:Draw()
    self:DrawModel()
    if self:GetPos():DistToSqr(localplayer:GetPos()) > 750000 then return end

    if not IsValid(XYZ_LAW_BOARD) then buildLawBoard() end

    local DrawPos = self:LocalToWorld(offSet)

    local DrawAngles = self:GetAngles()
    DrawAngles:RotateAroundAxis(self:GetAngles():Forward(), 90)
    DrawAngles:RotateAroundAxis(self:GetAngles():Up(), 180)

    vgui.Start3D2D(DrawPos, DrawAngles, 0.235)
        XYZ_LAW_BOARD:Paint3D2D()
    vgui.End3D2D()
end