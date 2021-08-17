print("Loaded Server Bodygroup System")

util.AddNetworkString("XYZBodyGroups_OpenMenu")
util.AddNetworkString("XYZBodyGroups_ApplyGroups")
util.AddNetworkString("XYZBodyGroups_SendPreset")
XYZBodyGroups.ModelCache = {}
function XYZBodyGroups:OpenMenu(ply)
	if !ply:IsElite() then return end

	local bodygroups = ply:GetBodyGroups()
	local skins = ply:SkinCount()

	local subgroups = 0
	for k, v in pairs(bodygroups) do
		local sub = 0
		for k, v in pairs(v.submodels) do
			sub = sub + 1
		end
		
		if (sub <= 1) then
			continue
		end

		subgroups = subgroups + 1
	end

	if (#bodygroups <= 1) and (skins <= 1) and (subgroups <= 0) then 
		XYZShit.Msg("Bodygroup Editor", Color(0, 0, 128), "This model has nothing to change!", ply)
		return
	end

	net.Start("XYZBodyGroups_OpenMenu")
	net.Send(ply)
end

function XYZBodyGroups:StashPreset(ply, model, cskin, groups)
	if not XYZBodyGroups.ModelCache[ply:SteamID64()] then
		XYZBodyGroups.ModelCache[ply:SteamID64()] = {}
	end
	if not XYZBodyGroups.ModelCache[ply:SteamID64()][model] then
		XYZBodyGroups.ModelCache[ply:SteamID64()][model] = {}
	end
	XYZBodyGroups.ModelCache[ply:SteamID64()][model].body = groups
	XYZBodyGroups.ModelCache[ply:SteamID64()][model].skin = cskin
end

hook.Add("PlayerSay", "XYZBodyGroups_PlayerSay", function(ply,text)
	if text == "!body" then
		XYZBodyGroups:OpenMenu(ply)
		return ""
	end
end)

net.Receive("XYZBodyGroups_ApplyGroups", function(len, ply)
	if !ply:IsElite() then return end
	if XYZShit.CoolDown.Check("XYZBodyGroups_ApplyGroups", 5, ply) then return end

	local cskin = net.ReadInt(16)
	local groups = net.ReadTable()

	for k,v in pairs( groups ) do
		if k == 0 then continue end
		ply:SetBodygroup(k,v)
	end

	ply:SetSkin(cskin)

	XYZBodyGroups:StashPreset(ply, ply:GetModel(), cskin, groups)
	XYZShit.Msg("Bodygroup Editor", Color(0, 0, 128), "Your requested changes have been made", ply)
end)

hook.Add("PlayerSpawn", "XYZBodyGroups_PlayerRespawned", function(ply)
	if !ply:IsElite() then return end
	timer.Simple(0.5, function()
		if not IsValid(ply) then return end
		
		if not XYZBodyGroups.ModelCache[ply:SteamID64()] then
			XYZBodyGroups.ModelCache[ply:SteamID64()] = {}
		end
		if not XYZBodyGroups.ModelCache[ply:SteamID64()][ply:GetModel()] then
			XYZBodyGroups.ModelCache[ply:SteamID64()][ply:GetModel()] = {}
		end

		if XYZBodyGroups.ModelCache[ply:SteamID64()][ply:GetModel()].body then
			for k, v in pairs(XYZBodyGroups.ModelCache[ply:SteamID64()][ply:GetModel()].body) do
				if k == 0 then continue end
				--if XYZBodyGroups.Config.BlockedModels[ply:GetModel()][k] then continue end

				ply:SetBodygroup(k,v)
			end
		else
			for k, v in pairs(ply:GetBodyGroups()) do
				ply:SetBodygroup(k, 0)
			end
		end

		if XYZBodyGroups.ModelCache[ply:SteamID64()][ply:GetModel()].skin then
			ply:SetSkin(XYZBodyGroups.ModelCache[ply:SteamID64()][ply:GetModel()].skin)
		end

		XYZShit.Msg("Bodygroup Editor", Color(0, 0, 128), "You can change your bodygroups/skin on some models with !body", ply)
	end)

end)


net.Receive("XYZBodyGroups_SendPreset", function(_, ply)
	if !ply:IsElite() then return end
	if XYZShit.CoolDown.Check("XYZBodyGroups_SendPreset", 5, ply) then return end

	local model = net.ReadString()
	local cskin = net.ReadInt(16)
	local groups = net.ReadTable()

	XYZBodyGroups:StashPreset(ply, model, cskin, groups)
	XYZShit.Msg("Bodygroup Editor", Color(0, 0, 128), "Seems you already have a preset for this job, we've went ahead and applied it for you.", ply)
end)