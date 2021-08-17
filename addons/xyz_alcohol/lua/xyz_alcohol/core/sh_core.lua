function Alcohol.Core.Load()
	for k, v in pairs(Alcohol.Config.AlcoholTypes) do
		print("Attempting to register", k)

		local ENT = {}
		ENT.Base = "base_xyz_alcohol"
		ENT.Type = "anim"
		ENT.ClassName = "xyz_alcohol_"..k
		ENT.Category = "Alcohol"
		ENT.Spawnable = true

		ENT.PrintName = "[Alcohol] "..v.name
		ENT.AlcoholUnits = v.units
		ENT.Model = v.model
		ENT.config = v
		
		scripted_ents.Register(ENT, "xyz_alcohol_"..k)
	end
end
