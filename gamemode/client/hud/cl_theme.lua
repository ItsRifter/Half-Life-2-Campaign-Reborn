surface.CreateFont( "Font_Normal", 
	{
	font    = "Tahoma",
	size    = ScrH() * 0.035,
	weight  = 500,
	antialias = true,
	})
	
surface.CreateFont( "Font_Small", 
	{
	font    = "Tahoma",
	size    = ScrH() * 0.03,
	weight  = 500,
	antialias = true,
	})
	
surface.CreateFont( "Font_Tiny", 
	{
	font    = "Tahoma",
	size    = ScrH() * 0.025,
	weight  = 500,
	antialias = true,
	})
	
Theme = {
	col = Color( 240, 140, 50, 255 ),
	backcol = Color( 200, 140, 50, 180 ),
	backcol2 = Color( 200, 140, 50, 80 ),
	fontcol = Color( 200, 200, 200, 255 ),
	fontcolhi = Color( 250, 250, 250, 255 ),
	fontcolout = Color( 20, 20, 20, 255 ),
	button = Color( 240, 140, 50, 255 ),
	buttonhi = Color( 255, 160, 80, 255 ),
	buttonout = Color( 10, 10, 10, 255 ),
	buttonouthi = Color( 240, 240, 240, 255 ),
}


local tex_tick = Material( "icon16/tick.png", "noclamp smooth" )
local tex_cross = Material( "icon16/cross.png", "noclamp smooth" )

--Basic Theme Button
local PANEL = {}

function PANEL:Init(sizeX)
	self:SetVisible( true )
end

function PANEL:SetText(text , font)
	self.Text = text
	self.font = font
end

function PANEL:SetFunc(func )
	self.Func = func
end

function PANEL:OnMousePressed( keyCode )
	if keyCode == MOUSE_LEFT then
		self.Func()
	end
end

function PANEL:Paint()
	if self:IsHovered() then
		draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Theme.buttonouthi )
		draw.RoundedBox( 8, 1, 1, self:GetWide()-2, self:GetTall()-2, Theme.buttonhi )
	else
		draw.RoundedBox( 8, 0, 0, self:GetWide(), self:GetTall(), Theme.buttonout )
		draw.RoundedBox( 8, 1, 1, self:GetWide()-2, self:GetTall()-2, Theme.button )
	end

	if self.Text then
		if self:IsHovered() then
			draw.SimpleTextOutlined(self.Text , self.font, self:GetWide() * 0.5 , self:GetTall() * 0.5 , Theme.fontcolhi, 1, 1, 1, Theme.fontcolout)	
		else
			draw.SimpleTextOutlined(self.Text , self.font, self:GetWide() * 0.5 , self:GetTall() * 0.5 , Theme.fontcol, 1, 1, 1, Theme.fontcolout)	
		end
	end
	return true
end
vgui.Register( "ThemeButton", PANEL, "Panel" )

--Basic Theme CheckBox
local PANEL = {}

function PANEL:Init(sizeX)
	self:SetVisible( true )
	self.toggle = false
end

function PANEL:SetText(text, font )
	if self.Text then self.Text:Remove() end
	self.Text = vgui.Create( "ThemeText" , self:GetParent())
	self.Text:SetSize( 0, 0)
	self.Text:SetPos( self:GetX()+self:GetWide() * 1.1, self:GetY() +self:GetTall() * 0.5)
	self.Text:SetText(text,font,0,0.5)
end

function PANEL:SetFunc(func )
	self.Func = func
end

function PANEL:Toggle( )
	self.toggle = !self.toggle
	return self.toggle
end

function PANEL:SetToggle(state )
	self.toggle = state
end

function PANEL:OnMousePressed( keyCode )
	if keyCode == MOUSE_LEFT then
		self.Func()
	end
end

function PANEL:Paint()
	if self.toggle then
		surface.SetMaterial( tex_tick )
	else
		surface.SetMaterial( tex_cross )
	end
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( 0, 0, self:GetWide(), self:GetTall() )
	
	return true
end
vgui.Register( "ThemeCheckBox", PANEL, "Panel" )

--Basic Theme Text
local PANEL = {}

function PANEL:Init(sizeX)
	self:SetVisible( true )
	self.toggle = false
	self.width = 0
	self.height = 0
end

function PANEL:SetText(text,font, alignX,alignY )
	self.Text = text
	self.font = font
	surface.SetFont( font )

	self:SetX( self:GetX() + self.width)
	self:SetY( self:GetY() + self.height)

	local width, height = surface.GetTextSize( text )
	self.width =  math.floor(width * alignX)
	self.height =  math.floor(height * alignY)
	self:SetSize( width + 2, height + 2)
	self:SetX( self:GetX() - self.width)
	self:SetY( self:GetY() - self.height)
	
end

function PANEL:Paint()

	if self.Text then
		draw.SimpleTextOutlined(self.Text , self.font, self:GetWide() * 0.5 , self:GetTall() * 0.5 , Theme.fontcolhi, 1, 1, 1, Theme.fontcolout)	
	end
	return true
end
vgui.Register( "ThemeText", PANEL, "Panel" )

--Basic Theme TextMultiLine
--Currently only has middle aligned text currently
local PANEL = {}

function PANEL:Init(sizeX)
	self:SetVisible( true )
	self.toggle = false
	self.width = 0
	self.height = 0
end

function PANEL:SetText(text,font, alignX,alignY, spacing )
	self.Text = text
	self.font = font
	self.spacing = spacing
	surface.SetFont( font )
	
	self:SetX( self:GetX() + self.width)
	self:SetY( self:GetY() + self.height)
	
	self.width = 0
	self.height = 0 
	
	for _, tx in ipairs(self.Text) do
		local width, height = surface.GetTextSize( tx )
		if width > self.width then self.width = width end
		self.height = self.height + height + spacing
	end

	self.spacing = self.height / #self.Text

	self:SetSize( self.width + 2, self.height + 2)
	
	self.width = math.floor(self.width * alignX)
	self.height =  math.floor(self.height * alignY)

	--self:SetSize( self.width + 2, self.height + 2)
	self:SetX( self:GetX() - self.width)
	self:SetY( self:GetY() - self.height)
	
end

function PANEL:Paint()

	if self.Text then
		for i, tx in ipairs(self.Text) do
			draw.SimpleTextOutlined(tx , self.font, self:GetWide() * 0.5 , i * self.spacing - self.spacing * 0.5, Theme.fontcolhi, 1, 1, 1, Theme.fontcolout)
		end
	end
	return true
end
vgui.Register( "ThemeTextMulti", PANEL, "Panel" )