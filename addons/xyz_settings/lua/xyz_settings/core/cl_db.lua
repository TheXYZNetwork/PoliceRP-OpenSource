function XYZSettings.Database.Initialize()
	if not sql.TableExists("xyz_settings") then
		sql.Query("CREATE TABLE xyz_settings(setting TEXT PRIMARY KEY, value TEXT);")
	end

	local settings = sql.Query("SELECT * FROM xyz_settings;")

	if not settings or not settings[1] then return end

	print("Loading XYZ Settings:")
	for k, v in pairs(settings) do
		print("	", v.value, type(v.value))
		if v.value == "true" then
			XYZSettings.SettingsCache[v.setting] = true
		elseif v.value == "false" then
			XYZSettings.SettingsCache[v.setting] = false
		else
			XYZSettings.SettingsCache[v.setting] = v.value
		end
	end
end


function XYZSettings.Database.UpdateSetting(setting, value)
	sql.Query(string.format("INSERT INTO xyz_settings(setting, value) VALUES('%s', '%s') ON CONFLICT(setting) DO UPDATE SET value='%s';", setting, value, value))
end

hook.Add("HUDPaint", "XYZSettingsLoadDatabase", function()
	XYZSettings.Database.Initialize()
	hook.Remove("HUDPaint", "XYZSettingsLoadDatabase")
end)