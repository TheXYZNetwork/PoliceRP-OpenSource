function Property.Core.FindProperty(door)
	for k, v in ipairs(Property.Config.Properties) do
		for n, m in ipairs(v.doors) do
			if m:IsEqualTol(door:GetPos(), 1) then
				return v, k
			end
		end
	end

	return false
end
 
function Property.Core.LoadProperties()
	for k, v in ipairs(Property.Config.Properties) do
		-- Make a table of door ents for efficiency
		Property.Config.Properties[k].doorEnts = {}

		-- Loop the door locations
		for n, m in ipairs(v.doors) do
			-- Match them to their door ents
			for o, p in pairs(ents.GetAll()) do
				-- Not a door
				if not p:isDoor() then continue end
				-- Not in the right position
				if not m:IsEqualTol(p:GetPos(), 1) then continue end

				Property.Config.Properties[k].doorEnts[n] = p
				p.propertyData = v
				break
			end
		end
	end
end

hook.Add("InitPostEntity", "Property:LoadDoors", Property.Core.LoadProperties)