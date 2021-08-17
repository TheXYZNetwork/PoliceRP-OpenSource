local APP = {}

-- Base data
APP.name = "Settings"
APP.id = "settings"
APP.desc = "Edit your phone's settings" -- Used in the app store
APP.appStore = false -- Can be installed from the app store
APP.show = true -- Show the app on the home

-- Background
APP.Icon = function(w, h)
	surface.SetMaterial(XYZShit.Image.GetMat("phone_app_settings"))
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(0, 0, w, h)
end

APP.settingsCache = {}
if not sql.TableExists("xyz_phone_settings") then
	sql.Query("CREATE TABLE xyz_phone_settings(name TEXT PRIMARY KEY, value TEXT)")
else
	local settings = sql.Query("SELECT * FROM xyz_phone_settings")
	for k, v in pairs(settings or {}) do
		APP.settingsCache[v.name] = v.value
	end
end


APP.settings = {
	{
		id = "phone_model",
		name = "Phone Model",
		options = {
			{
				n = "Basic",
				val = "phone_frame_basic"
			},
			{
				n = "uPhone",
				val = "phone_frame_uphone"
			},
			{
				n = "SamSings",
				val = "phone_frame_samsings"
			},
			{
				n = "Knockoffia",
				val = "phone_frame_knockoffia"
			}
		}
	},
	{
		id = "phone_background",
		name = "Phone Background",
		options = {
			{
				n = "Basic",
				val = "main_background"
			},
			{
				n = "Fish",
				val = "phone_background_fish"
			},
			{
				n = "Lego",
				val = "phone_background_lego"
			},
			{
				n = "Monkey",
				val = "phone_background_monkey"
			},
			{
				n = "Moon",
				val = "phone_background_moon"
			},
			{
				n = "Space",
				val = "phone_background_space"
			}
		}
	}
}
-- Functionality
local transWhite = Color(255, 255, 255, 170)
APP.Function = function(shell)
	local header = vgui.Create("DPanel", shell)
	header:Dock(TOP)
	header:SetTall(50)
	header:DockMargin(0, 0, 0, 5)
	header.Paint = function(self, w, h)
		XYZUI.DrawScaleText("Settings", 13, w*0.5, h*0.5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.RoundedBox(0, 0, h-2, w, 2, transWhite)
	end

	for k, v in ipairs(APP.settings) do
		local name = vgui.Create("DPanel", shell)
		name:Dock(TOP)
		name:SetTall(45)
		name:DockMargin(5, 0, 5, 0)
		name.Paint = function(self, w, h)
			XYZUI.DrawScaleText(v.name, 9, 0, 0, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		end

		if v.options then
			name.dropdown = vgui.Create("DComboBox", name)
			name.dropdown:Dock(BOTTOM)
			name.dropdown:SetValue("Select Choice")

			name.dropdown.OnSelect = function(self, index, value, data)
				APP.changeSetting(v.id, data)
			end

			for n, m in ipairs(v.options) do
				name.dropdown:AddChoice(m.n, m.val)
			end

		end
	end
end

APP.changeSetting = function(setting, value)
	sql.Query(string.format("INSERT OR REPLACE INTO xyz_phone_settings VALUES(%s, %s);", sql.SQLStr(setting), sql.SQLStr(value)))
	APP.settingsCache[setting] = value
end


APP.getSetting = function(setting)
	return APP.settingsCache[setting]
end

Phone.App.Register(APP)