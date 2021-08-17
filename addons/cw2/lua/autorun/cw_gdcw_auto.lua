--GDCW-----------------------------------------------------------------------------------------------
-- Global autorun lua for any SWep which can use GDCW bullets

local GDCWSettings = {}

CreateClientConVar( "gdcwbulletimpact", "1", FCVAR_REPLICATED + FCVAR_NOTIFY + FCVAR_ARCHIVE )

function GDCWSettings.Panel(CPanel)
	CPanel:AddControl( "Header", { 
		Text = "GDCW Settings", 
		Description = "Adjust the settings for GDCW Weapons" 
		})					
	CPanel:AddControl("Slider", {
		Label = "Bullet Impact Effects",
		Type = "Float",
		Min = 0,
		Max = 3,
		Command = "gdcwbulletimpact",
	})
end

function GDCWSettings.AddPanel()
	spawnmenu.AddToolMenuOption( "Options", "GDCW Settings", "", "Performance", "", "", GDCWSettings.Panel, {} )
end
hook.Add( "PopulateToolMenu", "AddGDCWSettingsPanel", GDCWSettings.AddPanel )

-- Sounds
sound.Add(
{
    name = "Bullet.Concrete",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = SNDLVL_90dB,
    sound = 	{
		"physics/concrete/concrete_impact_bullet1.wav",
		"physics/concrete/concrete_impact_bullet2.wav",
		"physics/concrete/concrete_impact_bullet3.wav",
		"physics/concrete/concrete_impact_bullet4.wav"
		}
})
sound.Add(
{
    name = "Bullet.Flesh",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = SNDLVL_90dB,
    sound = 	{
		"physics/flesh/flesh_impact_bullet1.wav",
		"physics/flesh/flesh_impact_bullet2.wav",
		"physics/flesh/flesh_impact_bullet3.wav",
		"physics/flesh/flesh_impact_bullet4.wav",
		"physics/flesh/flesh_impact_bullet5.wav"
		}
})
sound.Add(
{
    name = "Bullet.Glass",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = SNDLVL_90dB,
    sound = 	{
		"physics/glass/glass_impact_bullet1.wav",
		"physics/glass/glass_impact_bullet2.wav",
		"physics/glass/glass_impact_bullet3.wav",
		"physics/glass/glass_impact_bullet4.wav",
		"physics/glass/glass_largesheet_break1.wav",
		"physics/glass/glass_largesheet_break2.wav",
		"physics/glass/glass_largesheet_break3.wav"
		}
})
sound.Add(
{
    name = "Bullet.Metal",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = SNDLVL_90dB,
    sound = 	{
		"physics/metal/metal_solid_impact_bullet1.wav",
		"physics/metal/metal_solid_impact_bullet2.wav",
		"physics/metal/metal_solid_impact_bullet3.wav",
		"physics/metal/metal_solid_impact_bullet4.wav"
		}
})
sound.Add(
{
    name = "Bullet.Tile",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = SNDLVL_90dB,
    sound = 	{
		"physics/plastic/plastic_box_impact_bullet1.wav",
		"physics/plastic/plastic_box_impact_bullet2.wav",
		"physics/plastic/plastic_box_impact_bullet3.wav",
		"physics/plastic/plastic_box_impact_bullet4.wav",
		"physics/plastic/plastic_box_impact_bullet5.wav"
		}
})
sound.Add(
{
    name = "Bullet.Dirt",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = SNDLVL_90dB,
    sound = 	{
		"physics/surfaces/sand_impact_bullet1.wav",
		"physics/surfaces/sand_impact_bullet2.wav",
		"physics/surfaces/sand_impact_bullet3.wav",
		"physics/surfaces/sand_impact_bullet4.wav"
		}
})
sound.Add(
{
    name = "Bullet.Wood",
    channel = CHAN_STATIC,
    volume = 1.0,
    soundlevel = SNDLVL_90dB,
    sound = 	{
		"physics/wood/wood_solid_impact_bullet1.wav",
		"physics/wood/wood_solid_impact_bullet2.wav",
		"physics/wood/wood_solid_impact_bullet3.wav",
		"physics/wood/wood_solid_impact_bullet4.wav",
		"physics/wood/wood_solid_impact_bullet5.wav"
		}
})
sound.Add(
{
    name = "Explosion.Boom",
    channel = CHAN_EXPLOSION,
    volume = 1.0,
    soundlevel = SNDLVL_150dB,
    sound = 	"GDC/ExplosionBoom.wav"

})