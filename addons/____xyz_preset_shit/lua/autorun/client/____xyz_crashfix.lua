-- Safe ParticleEmitter-- 'Handsome' Matt Stevens-- If you use this I won't send you a DMCA takedown notice.
if debug.getinfo(ParticleEmitter).source ~= "=[C]" then return end

local engineParticleEmitter = ParticleEmitter
local emitters = {}

function ParticleEmitter(pos, use3D)
	if not use3D then return engineParticleEmitter(pos, use3D) end
	local emitter = emitters[use3D]
    if not emitter then
        emitter = engineParticleEmitter(pos, use3D)
        emitters[use3D] = emitter
    end
    emitter:SetPos(pos)

    return emitter
end