local function CW20_RenderScene()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()
	
	if IsValid(wep) and wep.CW20Weapon then
		-- this is the weapon's render target func
		if wep.RenderTargetFunc then
			wep.RenderTargetFunc(wep)
		end
		
		-- this is some attachment's render target func
		if wep.renderTargetFunc then
			wep.renderTargetFunc(wep)
		end
		
		-- ...amazing, isn't it?
	end
end

hook.Add("RenderScene", "CW20_RenderScene", CW20_RenderScene)

local function CW20_PostDrawViewModel()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()
	
	if not IsValid(wep) or not wep.CW20Weapon then
		return
	end
	
	render.SetBlend(1)
	
	wep:processBlur()
	wep:performViewmodelMovement()
	wep:drawViewModel()
end

hook.Add("PostDrawViewModel", "CW20_PostDrawViewModel", CW20_PostDrawViewModel)

local function CW20_RenderScreenspaceEffects()
	local ply = LocalPlayer()
	
	-- apply the smoke screen when in a smoke grenade area
	if ply.CW_SmokeScreenIntensity then
		surface.SetDrawColor(100, 100, 100, 255 * ply.CW_SmokeScreenIntensity)
		surface.DrawRect(-1, -1, ScrW() + 2, ScrH() + 2)
	end
	
	-- reset it, no loops or any other dumb shit required this way
	ply.CW_SmokeScreenIntensity = nil
	
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

-- gotta do the sound logic for the client in a different hook, since the Think hook on the weapon acts really fucking weird and is disabled for like a second on the second weapon deploy :/
local function CW20_Think()
	local ply = LocalPlayer()
	
	if ply:Alive() then
		local wep = ply:GetActiveWeapon()
		
		if IsValid(wep) and wep.CW20Weapon then
			if wep.CurSoundTable then
				local t = wep.CurSoundTable[wep.CurSoundEntry]
				local CT = UnPredictedCurTime()
				
				if CT >= wep.SoundTime + t.time / wep.SoundSpeed then
					if t.sound and t.sound ~= "" then
						wep:EmitSound(t.sound, 70, 100)
					end
					
					if t.callback then
						t.callback(wep)
					end
					
					if wep.CurSoundTable[wep.CurSoundEntry + 1] then
						wep.CurSoundEntry = wep.CurSoundEntry + 1
					else
						wep.CurSoundTable = nil
						wep.CurSoundEntry = nil
						wep.SoundTime = nil
					end
				end
			end
		end
	end
end

hook.Add("Think", "CW20_Think", CW20_Think)

local function CW20_Grenade_InitPostEntity()
	local ply = LocalPlayer()
	ply.cwFlashbangDuration = 0
	ply.cwFlashbangIntensity = 0
	ply.cwFlashbangDisplayIntensity = 0
	ply.cwFlashDuration = 0
	ply.cwFlashIntensity = 0
end

hook.Add("InitPostEntity", "CW20_Grenade_InitPostEntity", CW20_Grenade_InitPostEntity)