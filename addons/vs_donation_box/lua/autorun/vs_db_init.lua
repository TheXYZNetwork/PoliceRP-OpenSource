VSDB = {}


if CLIENT then
	surface.CreateFont( "VSDB_Font_Main", {
		font = "Calibri",
		size = ScreenScale(15),
		weight = 100
	})
	surface.CreateFont( "VSDB_Font_Money", {
		font = "Calibri",
		size = ScreenScale(13),
		weight = 100
	})
	surface.CreateFont( "VSDB_Font_Name", {
		font = "Calibri",
		size = ScreenScale(14),
		weight = 100
	})
	surface.CreateFont( "VSDB_3d_Static", {
		font = "Calibri",
		size = 30,
		weight = 100
	})

	local PANEL = {}

	function PANEL:Init()
		self:SetText("")
		self.onoff = false
	end
	
	function PANEL:DoClick()
		self:Toggle()
	end
	
	function PANEL:Toggle()
		self:SetToggle(!self:GetToggle())
	end
	
	function PANEL:GetToggle()
		return self.onoff
	end
	
	function PANEL:SetToggle(tog)
		self.onoff = tog
	end
	
	function PANEL:Paint()
		draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(50, 50, 50))
		if self.onoff then
			draw.SimpleText("X", "VSDB_Font_Money", self:GetWide()/2, self:GetTall()/2, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
	
	vgui.Register( 'vs_switch', PANEL, 'DButton' )
end