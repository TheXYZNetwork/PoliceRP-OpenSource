AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT.Initialize(self)
	self:SetModel("models/freeman/exhibition_ore_rock.mdl")
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self.isOreNode = true

	self:Deploy()
end

function ENT:Use(activator, caller)
end

function ENT:Deploy()
	local ore = Mining.Core.GetRandomOre()
	local oreData = Mining.Config.Ores[ore]

	self.currentOre = {
		ore = ore,
		life = math.random(oreData.life.min, oreData.life.max)
	}
	self.currentOre.startLife = self.currentOre.life

	self:SetColor(oreData.color)

	self.chunkLife = math.random(Mining.Config.ChunkMin, Mining.Config.ChunkMax)

	-- Reset the bodygroups
	for i=1, 6 do
		self:SetBodygroup(i, 0)
	end

	self.destroyed = false
end


function ENT:Mine(ply)
	if self.destroyed then return end

	-- Chip away at the chunk till it breaks
	if self.chunkLife > 1 then
		self.chunkLife = self.chunkLife - 1
		return
	end

	-- Remove 1 ore life from the node
	self.currentOre.life = self.currentOre.life - 1
	-- Reset the chunk's health
	self.chunkLife = math.random(Mining.Config.ChunkMin, Mining.Config.ChunkMax)

	local chunksLeft = self.currentOre.startLife/6
	for i=1, 6 do
		if (chunksLeft * (i-1)) >= self.currentOre.life then
			self:SetBodygroup(i, 1)
		end
	end

	Mining.Core.MinedOre(ply, self.currentOre.ore)

	if self.currentOre.life == 0 then
		-- Do things to kill the ore for x time
		self.destroyed = true

		timer.Simple(math.random(Mining.Config.NodeRegenMin, Mining.Config.NodeRegenMax), function()
			if not IsValid(self) then return end

			self:Deploy()
		end)
	end

	Quest.Core.ProgressQuest(ply, "minecraft", 2)
end