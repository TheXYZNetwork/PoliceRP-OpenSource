local function CW20_Grenade_InitPostEntity()
	local ply = LocalPlayer()
	ply.cwFlashbangDuration = 0
	ply.cwFlashbangIntensity = 0
	ply.cwFlashbangDisplayIntensity = 0
	ply.cwFlashDuration = 0
	ply.cwFlashIntensity = 0
end

hook.Add("InitPostEntity", "CW20_Grenade_InitPostEntity", CW20_Grenade_InitPostEntity)

local function CW20_RenderScreenspaceEffects()
	local ply = LocalPlayer()
	local curTime = CurTime()
	local frameTime = FrameTime()
	
	if curTime > ply.cwFlashbangDuration then
		ply.cwFlashbangIntensity = math.Approach(ply.cwFlashbangIntensity, 0, frameTime)
	end
	
	ply.cwFlashbangDisplayIntensity = math.Approach(ply.cwFlashbangDisplayIntensity, ply.cwFlashbangIntensity, frameTime * 15)
	
	if curTime > ply.cwFlashDuration then
		ply.cwFlashIntensity = math.Approach(ply.cwFlashIntensity, 0, frameTime)
	end
	
	if ply.cwFlashbangDisplayIntensity > 0 then
		DrawMotionBlur(0.01 * (1 - ply.cwFlashbangDisplayIntensity), ply.cwFlashbangDisplayIntensity, 0)
		
		surface.SetDrawColor(255, 255, 255, 255 * ply.cwFlashIntensity * ply.cwFlashbangDisplayIntensity)
		surface.DrawRect(-1, -1, ScrW() + 2, ScrH() + 2)
	end
end

hook.Add("RenderScreenspaceEffects", "CW20_RenderScreenspaceEffects", CW20_RenderScreenspaceEffects)