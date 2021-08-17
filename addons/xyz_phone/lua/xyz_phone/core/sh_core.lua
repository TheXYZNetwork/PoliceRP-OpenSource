Phone.App.List = Phone.App.List or {}
Phone.App.Mine = Phone.App.Mine or {}

function Phone.App.Register(data)
	if not data.id then return end

	Phone.App.List[data.id] = data
end

function Phone.App.Install(appID)
	Phone.App.Mine[appID] = true
end

function Phone.App.SetApp(appID)
	if not Phone.App.Mine[appID] then return end

	if IsValid(Phone.Menu) then  
		Phone.Menu:SetApp(appID)
	end
end

function Phone.App.GetApp(appID)
	return Phone.App.List[appID]
end

-- Get their phone number
function Phone.Core.GetPhoneNumber(plyID)
	if Phone.Numbers[plyID] then
		return Phone.Numbers[plyID]
	end
	math.randomseed(plyID)
	local phoneNumber = Phone.Config.AreaCode

	for i=1, 9 do
		phoneNumber = phoneNumber..tostring(math.random(0, 9))
	end

	Phone.Numbers[plyID] = phoneNumber

	return phoneNumber
end

-- Get by phone number
function Phone.Core.GetUserByNumber(number)
	for k, v in pairs(Phone.Numbers) do
		if v == number then
			return player.GetBySteamID64(k)
		end
	end
end