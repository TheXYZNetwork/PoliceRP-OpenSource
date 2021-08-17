--Default
Inventory.ItemTypes['default'] = {
	dataFormat = function(entity)
		local entData = duplicator.CopyEntTable(entity)
		if not entData then return false end

		local extract = {}

		-- Type info
		extract.type = {}
		extract.type.isWeapon = false
		extract.type.isShipment = false

		-- General info
		extract.info = {}
		extract.info.displayName = entData.PrintName
		extract.info.displayModel = entData.Model
		extract.info.class = entData.ClassName
		
		-- Data to keep
		extract.data = {}
		extract.data.dataTable = entData.DT
		extract.data.renderGroup = entData.RenderGroup
		extract.data.sID = entData.SID
		extract.data.skin = entData.Skin

		return extract
	end,
	spawn = function(ply, class, formattedData)
		local ent = ents.Create(class)
		
		if formattedData.info and formattedData.info.displayModel then
			ent:SetModel(formattedData.info.displayModel)
		end
		if formattedData.data and formattedData.data.skin then 
			ent:SetSkin(formattedData.data.skin or 0)
		end
		if formattedData.data and formattedData.data.dataTable then
			for k, v in pairs(formattedData.data.dataTable) do
				ent.dt[k] = v
			end
		end

		ent:Spawn()
		ent:Activate()

		ent:SetPos(ply:GetPos()+(ply:GetUp()*50)+(ply:GetForward()*50))
		--ent:Setowning_ent(ply)

		return ent
	end
}
Inventory.ItemTypes['default_weapon'] = {
	dataFormat = function(wep)
		local wepData = weapons.Get(wep)
		if not wepData then return false end

		local extract = {}

		-- Type info
		extract.type = {}
		extract.type.isWeapon = true
		extract.type.isShipment = false

		-- General info
		extract.info = {}
		extract.info.displayName = wepData.ClassName
		extract.info.displayModel = wepData.WorldModel
		extract.info.class = wepData.ClassName
		
		-- Data to keep
		extract.data = {}

		extract.data = {}
		return extract
	end,
	spawn = function(ply, class, formattedData)
		local wepClass = formattedData.info and formattedData.info.class or class
    	local wep = weapons.Get(wepClass)
	
		local gun = ents.Create("spawned_weapon")
    	gun:SetModel(wep and wep.WorldModel or "models/weapons/w_pist_p228.mdl")
    	gun:SetWeaponClass(wepClass)
    	gun.nodupe = true
		gun:Spawn()
		gun:Activate()

		gun:SetPos(ply:GetPos()+(ply:GetUp()*50)+(ply:GetForward()*50))
		return gun
	end,
	equip = function(ply, class, formattedData)
		ply:Give(formattedData.info and formattedData.info.class or class)

		return true
	end
}

--[[
-- Shipments
Inventory.ItemTypes['spawned_shipment'] = {
	dataFormat = function(entity)
		local entData = duplicator.CopyEntTable(entity)
		if not entData then return false end
		local shipmentInfo = CustomShipments[entity:Getcontents()]
		if not shipmentInfo then return false end

		local extract = {}

		-- Type info
		extract.type = {}
		extract.type.isWeapon = false
		extract.type.isShipment = true


		-- General info
		extract.info = {}
		extract.info.displayName = (shipmentInfo.name and shipmentInfo.name.." Shipment") or "Unknown Shipment"
		extract.info.displayModel = shipmentInfo.model or "models/error.mdl"
		extract.info.class = shipmentInfo.entity
		
		-- Data to keep
		extract.data = {}
		extract.data.dataTable = entData.DT
		extract.data.renderGroup = entData.RenderGroup
		extract.data.sID = entData.SID
		extract.data.skin = entData.Skin

		return extract
	end
}
-- Dropped weapons
Inventory.ItemTypes['spawned_weapon'] = {
	dataFormat = function(entity)
		local entData = duplicator.CopyEntTable(entity)
		if not entData then return false end

		local extract = {}

		-- Type info
		extract.type = {}
		extract.type.isWeapon = true
		extract.type.isShipment = false


		-- General info
		extract.info = {}
		local wepTbl = weapons.Get(entData.DT.WeaponClass)
		extract.info.displayName = wepTbl.DisplayName or "Unknown Weapon"
		extract.info.displayModel = entData.Model
		extract.info.class = entData.DT.WeaponClass
		
		-- Data to keep
		extract.data = {}
		extract.data.dataTable = entData.DT
		extract.data.renderGroup = entData.RenderGroup
		extract.data.skin = entData.Skin

		return extract
	end
}

--[[
-- If no specific actions set
Inventory.ItemTypes['default'] = {
	dataFormat = function(data)
		local extract = {}

		-- Type info
		extract.type = {}
		extract.type.isWeapon = false
		extract.type.isShipment = false

		-- General info
		extract.info = {}
		extract.info.displayName = data.PrintName
		extract.info.displayModel = data.Model
		extract.info.class = data.ClassName
		
		-- Data to keep
		extract.data = {}
		extract.data.dataTable = data.DT
		extract.data.renderGroup = data.RenderGroup
		extract.data.sID = data.SID
		extract.data.skin = data.Skin

		return extract
	end
}

-- Dropped weapons
Inventory.ItemTypes['spawned_weapon'] = {
	dataFormat = function(data)
		local extract = {}

		-- Type info
		extract.type = {}
		extract.type.isWeapon = true
		extract.type.isShipment = false


		-- General info
		extract.info = {}

		for k, v in pairs(weapons.GetList()) do
			if v.ClassName == data.DT.WeaponClass then
				extract.info.displayName = v.PrintName
				break
			end
		end
		extract.info.displayName = extract.info.displayName or "Unknown Weapon"

		extract.info.displayModel = data.Model
		extract.info.class = data.DT.WeaponClass
		
		-- Data to keep
		extract.data = {}
		extract.data.dataTable = data.DT
		extract.data.class = data.DT.WeaponClass

		return extract
	end
}

-- Shipments
Inventory.ItemTypes['spawned_shipment'] = {
	dataFormat = function(data)
		local extract = {}

		-- Type info
		extract.type = {}
		extract.type.isWeapon = false
		extract.type.isShipment = true


		-- General info
		extract.info = {}

		for k, v in pairs(weapons.GetList()) do
			if v.ClassName == data.DT.WeaponClass then
				extract.info.displayName = v.PrintName
				break
			end
		end
		if not extract.info.displayName then
			extract.info.displayName = "Unknown Weapon"
		end

		extract.info.displayModel = data.Model
		extract.info.class = data.DT.WeaponClass
		
		-- Data to keep
		extract.data = {}
		extract.data.dataTable = data.DT

		return extract
	end
}
]]--