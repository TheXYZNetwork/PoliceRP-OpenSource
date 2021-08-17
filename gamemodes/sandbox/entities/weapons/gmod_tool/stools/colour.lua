
TOOL.Category = "Render"
TOOL.Name = "#tool.colour.name"

TOOL.ClientConVar[ "r" ] = 255
TOOL.ClientConVar[ "g" ] = 255
TOOL.ClientConVar[ "b" ] = 255
TOOL.ClientConVar[ "a" ] = 255
TOOL.ClientConVar[ "mode" ] = "0"
TOOL.ClientConVar[ "fx" ] = "0"

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
	{ name = "reload" }
}

local function SetColour( ply, ent, data )

	--
	-- If we're trying to make them transparent them make the render mode
	-- a transparent type. This used to fix in the engine - but made HL:S props invisible(!)
	--
	if ( data.Color && data.Color.a < 255 && data.RenderMode == RENDERMODE_NORMAL ) then
		data.RenderMode = RENDERMODE_TRANSCOLOR
	end

	if ( data.Color ) then ent:SetColor( Color( data.Color.r, data.Color.g, data.Color.b, data.Color.a ) ) end
	if ( data.RenderMode ) then ent:SetRenderMode( data.RenderMode ) end
	if ( data.RenderFX ) then ent:SetKeyValue( "renderfx", data.RenderFX ) end

	if ( SERVER ) then
		duplicator.StoreEntityModifier( ent, "colour", data )
	end

end
duplicator.RegisterEntityModifier( "colour", SetColour )

function TOOL:LeftClick( trace )

	local ent = trace.Entity
	if ( IsValid( ent.AttachedEntity ) ) then ent = ent.AttachedEntity end
	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn
	if ( CLIENT ) then return true end

	local r = self:GetClientNumber( "r", 0 )
	local g = self:GetClientNumber( "g", 0 )
	local b = self:GetClientNumber( "b", 0 )
	local a = self:GetClientNumber( "a", 0 )
	local fx = self:GetClientNumber( "fx", 0 )
	local mode = self:GetClientNumber( "mode", 0 )

	SetColour( self:GetOwner(), ent, { Color = Color( r, g, b, a ), RenderMode = mode, RenderFX = fx } )
	return true

end

function TOOL:RightClick( trace )

	local ent = trace.Entity
	if ( IsValid( ent.AttachedEntity ) ) then ent = ent.AttachedEntity end
	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn

	if ( CLIENT ) then return true end

	local clr = ent:GetColor()
	self:GetOwner():ConCommand( "colour_r " .. clr.r )
	self:GetOwner():ConCommand( "colour_g " .. clr.g )
	self:GetOwner():ConCommand( "colour_b " .. clr.b )
	self:GetOwner():ConCommand( "colour_a " .. clr.a )
	self:GetOwner():ConCommand( "colour_fx " .. ent:GetRenderFX() )
	self:GetOwner():ConCommand( "colour_mode " .. ent:GetRenderMode() )

	return true

end

function TOOL:Reload( trace )

	local ent = trace.Entity
	if ( IsValid( ent.AttachedEntity ) ) then ent = ent.AttachedEntity end

	if ( !IsValid( ent ) ) then return false end -- The entity is valid and isn't worldspawn
	if ( CLIENT ) then return true end

	SetColour( self:GetOwner(), ent, { Color = Color( 255, 255, 255, 255 ), RenderMode = 0, RenderFX = 0 } )
	return true

end

local ConVarsDefault = TOOL:BuildConVarList()

function TOOL.BuildCPanel( CPanel )

	CPanel:AddControl( "Header", { Description = "#tool.colour.desc" } )

	CPanel:AddControl( "ComboBox", { MenuButton = 1, Folder = "colour", Options = { [ "#preset.default" ] = ConVarsDefault }, CVars = table.GetKeys( ConVarsDefault ) } )

	CPanel:AddControl( "Color", { Label = "#tool.colour.color", Red = "colour_r", Green = "colour_g", Blue = "colour_b", Alpha = "colour_a" } )

	CPanel:AddControl( "ListBox", { Label = "#tool.colour.mode", Options = list.Get( "RenderModes" ) } )
	CPanel:AddControl( "ListBox", { Label = "#tool.colour.fx", Options = list.Get( "RenderFX" ) } )

end

list.Set( "RenderModes", "#rendermode.normal", { colour_mode = 0 } )

list.Set( "RenderFX", "#renderfx.none", { colour_fx = 0 } )