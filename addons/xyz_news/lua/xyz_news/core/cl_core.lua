net.Receive("NewsSystem:Stream:State", function()
	local state = net.ReadBool()
	NewsSystem.Data.IsLive = state

	if state then
		NewsSystem.Data.CameraMan = net.ReadEntity()
	else
		NewsSystem.Data.CameraMan = nil
		NewsSystem.Data.Title = nil
		NewsSystem.Data.Desc = nil
	end
end)

net.Receive("NewsSystem:News:Update", function()
	local title = net.ReadString()
	local desc = net.ReadString()
	
	NewsSystem.Data.Title = title
	NewsSystem.Data.Desc = desc
end)


function NewsSystem.Core.GetView()
	if not NewsSystem.Core.RenderTarget then
		NewsSystem.Core.RenderTarget = GetRenderTarget("news_system_view", 800, 463)
		NewsSystem.Core.RenderTargetMaterial = CreateMaterial("news_system_view", "UnlitGeneric", {
			["$basetexture"] = "news_system_view",
		    ["$ignorez"] = true
		})
	end


	return NewsSystem.Core.RenderTargetMaterial
end

local offsetPos = Vector(0, 0, 60)
local offsetCrouching = Vector(0, 0, 30)
function NewsSystem.Core.UpdateView()
	if not NewsSystem.Core.RenderTarget then
		NewsSystem.Core.GetView()
	end

	-- Doing this loop is much more efficient than building rendertargets when no screen is in view but the new is streaming
	local withinView = false
	for k, v in pairs(NewsSystem.ScreenCache) do
		if LocalPlayer():GetPos():DistToSqr(v:GetPos()) < NewsSystem.Config.StartDistance then
			withinView = true
			break
		end
	end

	-- We're not within view to care to render anything
	if not withinView then return end

	local camPos, camAng = NewsSystem.Data.CameraMan:GetPos(), NewsSystem.Data.CameraMan:EyeAngles()

	camPos = camPos + (NewsSystem.Data.CameraMan:Crouching() and offsetCrouching or offsetPos) + (camAng:Forward() * 33)

	render.PushRenderTarget(NewsSystem.Core.RenderTarget)
		render.ClearDepth()
		render.Clear(0, 0, 0, 0)


		render.RenderView({
			origin = camPos,
			angles = camAng,
			x = 0, y = 0,
			w = ScrW(), h = ScrH(),
	
--			drawviewmodel = false
		})
	render.PopRenderTarget()
end

local showUser
hook.Add("ShouldDrawLocalPlayer", "NewsSystem:ShowUserInRT", function()
	if (not NewsSystem.Data.IsLive) or (not IsValid(NewsSystem.Data.CameraMan)) then return end

	-- Used to override the cache
	cam.Start3D()
	cam.End3D()

	return showUser
end)
hook.Add("PreRender", "NewsSystem:UpdateRT", function()
	if (not NewsSystem.Data.IsLive) or (not IsValid(NewsSystem.Data.CameraMan)) then return end

	showUser = true
		NewsSystem.Core.UpdateView()
	showUser = nil
end)
