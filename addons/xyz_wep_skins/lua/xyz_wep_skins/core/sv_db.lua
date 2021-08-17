function WepSkins.Database.LoadUsersSkins(userid, callback)
	XYZShit.DataBase.Query(string.format("SELECT * FROM wep_skins WHERE userid='%s'", XYZShit.DataBase.Escape(userid)), callback)
end

function WepSkins.Database.SetWeaponSkin(userid, wepClass, newSkin)
	XYZShit.DataBase.Query(string.format("INSERT INTO wep_skins(userid, wep, skin) VALUES('%s', '%s', '%s') ON DUPLICATE KEY UPDATE skin='%s'", XYZShit.DataBase.Escape(userid), XYZShit.DataBase.Escape(wepClass), XYZShit.DataBase.Escape(newSkin), XYZShit.DataBase.Escape(newSkin)))
end