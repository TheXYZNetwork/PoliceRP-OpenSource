if not file.Exists("xyz/phone", "DATA") then
    file.CreateDir("xyz/phone")
end 
if not file.Exists("xyz/phone/snapper", "DATA") then
    file.CreateDir("xyz/phone/snapper")
end 

net.Receive("Phone:ReceiveText", function()
    local sendingNumber = net.ReadString()
    local text = net.ReadString()

    surface.PlaySound("xyz/phone_notification.mp3")

    -- Save the text
    local bubble = Phone.App.GetApp("bubble")
    bubble.SaveText(sendingNumber, false, text)

    -- Load the text in real time if they're on that contact
    if not Phone.Menu then return end
    if not (Phone.Menu.App == bubble) then return end
    if not Phone.Menu.shell:GetChild(0) then return end
    local currentViewNumber = Phone.Menu.shell:GetChild(0).number
    if not currentViewNumber then return end
    if not (currentViewNumber == sendingNumber) then return end

    Phone.Menu.shell:GetChild(0).loadFeed()
end)

net.Receive("Phone:Call:Send", function()
    local callingNumber = net.ReadString()

    local callApp = Phone.App.GetApp("call")

    callApp.RequestCall(callingNumber)
end)

net.Receive("Phone:Call:Started", function()
    local callApp = Phone.App.GetApp("call")
    local number = net.ReadString()

    callApp.StartCall(number)
end)

net.Receive("Phone:Call:Ended", function()
    local callApp = Phone.App.GetApp("call")
    callApp.EndCall()
end)


net.Receive("Phone:Snapper:Save", function()
    local time = net.ReadUInt(32)
    local code = net.ReadString()

    local data = {}
    data.code = code
    file.Write("xyz/phone/snapper/" .. time .. "_data.txt", util.TableToJSON(data))
end)