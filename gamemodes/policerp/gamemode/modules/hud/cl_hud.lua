--[[---------------------------------------------------------------------------
Display notifications
---------------------------------------------------------------------------]]
local function DisplayNotify()
    local txt = net.ReadString()
    local type, len, consoleOnly = net.ReadInt(16), net.ReadInt(32), net.ReadBool()
    if not consoleOnly then
    	GAMEMODE:AddNotify(txt, type, len)
    	surface.PlaySound("buttons/lightswitch2.wav")
    end
    -- Log to client console
    MsgC(Color(255, 20, 20, 255), "[DarkRP] ", Color(200, 200, 200, 255), txt, "\n")
end
net.Receive('_Notify',DisplayNotify)

--[[---------------------------------------------------------------------------
Disable players' names popping up when looking at them
---------------------------------------------------------------------------]]
function GM:HUDDrawTargetID()
    return false
end