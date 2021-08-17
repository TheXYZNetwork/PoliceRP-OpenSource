XYZBodyGroups = {}

if SERVER then
	include("bodygroup/sv_bodygroups.lua")
	include("bodygroup/sh_bodygroups_config.lua")
	AddCSLuaFile("bodygroup/cl_bodygroups.lua")
	AddCSLuaFile("bodygroup/sh_bodygroups_config.lua")
end

if CLIENT then
	include("bodygroup/cl_bodygroups.lua")
	include("bodygroup/sh_bodygroups_config.lua")
end