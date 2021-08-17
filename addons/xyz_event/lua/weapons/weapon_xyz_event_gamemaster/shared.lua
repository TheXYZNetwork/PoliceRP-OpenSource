SWEP.PrintName = "GameMaster Tool"
SWEP.Author = "Owain Owjo"
SWEP.Category = "XYZ Weapons"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ViewModelFOV = 85
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false
SWEP.Base = "weapon_base"

SWEP.Secondary.Ammo = "none"

SWEP.HoldType = ""

function SWEP:Initialize()
end

function SWEP:PrimaryAttack()
	if SERVER then return end

	if XYZShit.CoolDown.Check("EventSystem:GMTool:Primary", 2) then return end

	EventSystem.Core.AddSpawnPointUI()
end

function SWEP:SecondaryAttack()
	if SERVER then return end

	if XYZShit.CoolDown.Check("EventSystem:GMTool:Secondary", 2) then return end

	EventSystem.Core.SpawnEntity()
end

function SWEP:Reload()
	if SERVER then return end

	if XYZShit.CoolDown.Check("EventSystem:GMTool:Reload", 2) then return end

	EventSystem.Core.WipeSpawnPointUI()
end

function SWEP:Deploy()
	if CLIENT then return end

	local ply = self.Owner
	net.Start("EventSystem:SendSpawnPoints")
		net.WriteTable(EventSystem.Data.spawns)
	net.Send(ply)
end

if CLIENT then
	function SWEP:DrawHUD()
		for k, v in pairs(EventSystem.Spawnpoints) do
			for n, t in pairs(v) do
				local pos = t:ToScreen()

				if not pos.visible then continue end

				draw.NoTexture()
				surface.SetDrawColor(color_black)
				XYZUI.DrawCircle(pos.x, pos.y, 20, 2)
				surface.SetDrawColor(EventSystem.Config.Color)
				XYZUI.DrawCircle(pos.x, pos.y, 19, 2)

				XYZUI.DrawTextOutlined(EventSystem.Config.TeamNames[k] and ("Team "..EventSystem.Config.TeamNames[k]) or "Everyone", 40, pos.x, pos.y + 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, color_black)
			end
		end
	end
end
