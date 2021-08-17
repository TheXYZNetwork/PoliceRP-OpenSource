if SERVER then return end
local APP = {}

-- Base data
APP.name = "Snapper"
APP.id = "snapper"
APP.desc = "Take photos" -- Used in the app store
APP.appStore = false -- Can be installed from the app store
APP.show = true -- Show the app on the home

-- Functions
APP.Icon = function(w, h)
	surface.SetMaterial(XYZShit.Image.GetMat("phone_app_snapper"))
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(0, 0, w, h)
end


-- Functionality
local unitSize = math.Clamp(ScrH(), 300, ScrH()*0.3)
unitSize = unitSize/25
local viewW, viewH = unitSize*25, unitSize*48
local offset = Vector(0, 0, 60)
local renderView
local transWhite = Color(255, 255, 255, 55)
local lastPhoto = CurTime()
APP.Function = function(shell)
	if not APP.RenderTarget then
		APP.RenderTarget = GetRenderTarget("phone_snapper_view_", viewW, viewH)
		APP.RenderTargetMaterial = CreateMaterial("phone_snapper_view_", "UnlitGeneric", {
			["$basetexture"] = "phone_snapper_view_",
		    ["$ignorez"] = true
		})
	end

	local view = vgui.Create("DPanel", shell)
	view:Dock(FILL)
	view.Paint = function(self, w, h)
		surface.SetMaterial(APP.RenderTargetMaterial)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
		
		if (lastPhoto + 0.2) > CurTime() then
			draw.RoundedBox(0, 0, 0, w, h, transWhite)
		end
	end

	hook.Add("PreRender", "Phone:UpdateRT", function()
		if not IsValid(view) then return end
		
		renderView = {
			origin = LocalPlayer():GetPos() + offset,
			angles = LocalPlayer():EyeAngles(),
			x = 0, y = 0,
			w = viewW, h = viewH,
			drawviewmodel  = false,
			fov = 30
		}

		render.PushRenderTarget(APP.RenderTarget)
			render.ClearDepth() 
			render.Clear(0, 0, 0, 0)
			render.RenderView(renderView)
		render.PopRenderTarget()
	end)
	
	local snap = vgui.Create("DButton", view)
	snap:SetSize(shell:GetWide()*0.5, shell:GetWide()*0.5)
	snap:SetPos(shell:GetWide()*0.25, shell:GetTall()-(shell:GetWide()*0.5))
	snap:SetText("")
	snap.Paint = function(self, w, h)
		draw.NoTexture()
		surface.SetDrawColor(255, 255, 255, 50)
		XYZUI.DrawCircle(w*0.5, h*0.5, w*0.3, 2)
	end
	snap.DoClick = function()
		if XYZShit.CoolDown.Check("Camera:TakePicture", 1) then return end


    	surface.PlaySound("xyz/phone_camera.mp3")
		lastPhoto = CurTime()
		hook.Add("RenderScene", "Phone:TakePicture", function()
			hook.Remove("RenderScene", "Phone:TakePicture")

			render.PushRenderTarget(APP.RenderTarget, 0, 0, viewW, viewH)
				render.Clear( 0, 0, 0, 255, true, true )
				render.RenderView(renderView)

				render.UpdateScreenEffectTexture()

				local data = render.Capture({
					format = "jpg",
					w = ScrW(),
					h = ScrH(),
					x = 0,
					y = 0,
					alpha = false
				})
			render.PopRenderTarget()

			file.Write("xyz/phone/snapper/"..os.time()..".jpg", data)

			local base64Data = util.Base64Encode(data)

			local chunks = math.ceil(#base64Data/20000)

			net.Start("Phone:Snapper:Take")
				net.WriteUInt(os.time(), 32)
				net.WriteUInt(chunks, 6)
				for i=1, chunks do
					local chunkData = string.sub(base64Data, 20000 * (i-1), (20000 * (i)) - 1)
					net.WriteString(chunkData)
				end
			net.SendToServer()
		end)
	end
end

Phone.App.Register(APP)