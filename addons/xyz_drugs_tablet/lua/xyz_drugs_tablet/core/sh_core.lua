function XYZDrugsTable.Core.GetDataByClass(class)
	for k, v in ipairs(XYZDrugsTable.Config.Drugs) do
		if v.ents[class] then
			return v.ents[class]
		end
	end

	return false
end