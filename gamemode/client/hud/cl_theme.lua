local panel_meta = FindMetaTable( "PANEL" )

surface.CreateFont( "Font_Normal", 
	{
	font    = "Impact",
	size    = ScrH() * 0.035,
	weight  = 100,
	antialias = true,
	})
	
surface.CreateFont( "Font_Small", 
	{
	font    = "Impact",
	size    = ScrH() * 0.03,
	weight  = 100,
	antialias = true,
	})
	
surface.CreateFont( "Font_Tiny", 
	{
	font    = "Impact",
	size    = ScrH() * 0.025,
	weight  = 100,
	antialias = true,
	})
	
Theme = {
	col = Color( 240, 140, 50, 255 ),
	backcol = Color( 255, 140, 20, 80 ),
	backcol2 = Color( 255, 140, 20, 35 ),
	fontcol = Color( 200, 200, 200, 255 ),
	fontcolhi = Color( 250, 250, 250, 255 ),
	fontcolout = Color( 20, 20, 20, 255 ),
	button = Color( 255, 140, 0, 255 ),
	buttonhi = Color( 255, 170, 50, 255 ),
	buttonout = Color( 10, 10, 10, 255 ),
	box = Color( 220, 110, 0, 255 ),
	box2 = Color( 180, 100, 0, 255 ),
	buttonouthi = Color( 240, 240, 240, 255 ),
}


local tex_tick = Material( "icon16/tick.png", "noclamp smooth" )
local tex_cross = Material( "icon16/cross.png", "noclamp smooth" )
local tex_cog = Material( "icon16/cog.png", "noclamp smooth" )

--Basic Theme Button---------------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
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

--Basic Theme CheckBox---------------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetVisible( true )
	self.toggle = false
end

function PANEL:SetText(text, font )
	if self.Text then self.Text:Remove() end
	--self.Text = vgui.Create( "ThemeText" , self:GetParent())
	self.Text = vgui.Create( "ThemeTextLink" , self)
	self.Text:SetSize( 0, 0)
	self.Text:SetPos( self:GetTall() * 1.1, self:GetTall() * 0.5)
	--self.Text:SetPos( self:GetX()+self:GetWide() * 1.1, self:GetY() +self:GetTall() * 0.5)
	self.Text:SetText(text,font,0,0.5)
	--self.Text:SetMouseInputEnabled( false )
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

	if self:IsHovered() then
		draw.RoundedBox( 6, 0, 0, self:GetWide(), self:GetTall(), Theme.buttonouthi )
		draw.RoundedBox( 6, 1, 1, self:GetWide()-2, self:GetTall()-2, Theme.buttonhi )
	else
		draw.RoundedBox( 6, 0, 0, self:GetWide(), self:GetTall(), Theme.buttonout )
		draw.RoundedBox( 6, 1, 1, self:GetWide()-2, self:GetTall()-2, Theme.button )
	end

	if self.toggle then
		surface.SetMaterial( tex_tick )
	else
		surface.SetMaterial( tex_cross )
	end
	surface.SetDrawColor( 255, 255, 255, 255 )
	local tall = self:GetTall() 
	surface.DrawTexturedRect( tall*0.1, tall*0.1, tall*0.85, tall*0.85)
	
	return true
end
vgui.Register( "ThemeCheckBox", PANEL, "Panel" )

--Basic Theme MultiBox---------------------------------------------------------------------------------------
local PANEL = {}
function PANEL:Init()
	self:SetVisible( false )
	self:SetMouseInputEnabled( true )
	btn = nil
	hovering = -1
end

function PANEL:SetText(text,font, btn)
	self.Text = text
	self.font = font
	self.btn = btn
	--self.spacing = spacing
	surface.SetFont( font )
	
	--self:SetX( self:GetX() + self.width)
	--self:SetY( self:GetY() + self.height)
	
	--self.width = 0
	self.height = 0 
	
	for _, tx in ipairs(self.Text) do
		local width, height = surface.GetTextSize( tx )
		--if width > self.width then self.width = width end
		self.height = self.height + height * 1.2
	end
	self.spacing = self.height / #self.Text

	self:SetSize( self:GetWide(), self.height+2)
	
	--self.width = math.floor(self.width * alignX)
	--self.height =  math.floor(self.height * alignY)

	--self:SetSize( self.width + 2, self.height + 2)
	--self:SetX( self:GetX() - self.width)
	--self:SetY( self:GetY() - self.height)
	
end

function PANEL:Paint()
	--if self:IsHovered() then
	draw.RoundedBox( 6, 0, 0, self:GetWide(), self:GetTall(), Theme.buttonout )
	--draw.RoundedBox( 6, 1, 1, self:GetWide()-2, self:GetTall()-2, Theme.button )
	
	local alternate = false
	local col = Theme.box
	local space = math.ceil(self.spacing)
	if self.Text then
		for i, tx in ipairs(self.Text) do
			if i == 1 then draw.RoundedBoxEx( 6, 1, space*(i-1)+1, self:GetWide()-2, space-2, col ,true,true,false,false) 
			elseif i == #self.Text then draw.RoundedBoxEx( 6, 1, space*(i-1)-1, self:GetWide()-2, space-1, col ,false,false,true,true)
			else draw.RoundedBoxEx( 6, 1, space*(i-1)-1, self:GetWide()-2, space, col ,false,false,false,false) end
			if i == self.hovering then
				draw.SimpleTextOutlined(tx , self.font, self:GetWide() * 0.5 , i * self.spacing - self.spacing * 0.5, Theme.fontcolho, 1, 1, 1, Theme.fontcolout)
			else
				draw.SimpleTextOutlined(tx , self.font, self:GetWide() * 0.5 , i * self.spacing - self.spacing * 0.5, Theme.fontcol, 1, 1, 1, Theme.fontcolout)
			end
			
			alternate = !alternate
			if alternate then
				col = Theme.box2
			else
				col = Theme.box
			end
		end
	end
	
	return true
end

function PANEL:OnMousePressed( keyCode )
	if keyCode == MOUSE_LEFT then
		if self.hovering  > 0 and self.hovering <= #self.Text then
			self.btn:SetValue(self.hovering)
			self.btn.Func()
		end
	end
end

function PANEL:Think()
	if !IsValid(self.btn) then return end
	if !self:IsHovered() and !self.btn:IsHovered() then
		if self:IsVisible() then self:SetVisible( false ) end
	else
		local locx, locy = self:ScreenToLocal( 0, gui.MouseY() )
		--print(locy / self.spacing )
		self.hovering = math.Round(locy / self.spacing + 0.5)
	end
end

vgui.Register( "ThemeMultiBox2", PANEL, "Panel" )

local PANEL = {}

function PANEL:Init()
	self:SetVisible( true )
	self.list = nil
	self.value = 0
	self.extended = nil
end

function PANEL:SetText(words,font, list, value)
	if self.Text then self.Text:Remove() end
	self.words = words
	--self.Text = vgui.Create( "ThemeText" , self:GetParent())
	self.Text = vgui.Create( "ThemeTextLink" , self)
	self.list = list
	self.Text:SetSize( 0, 0)
	self.Text:SetPos( self:GetTall() * 1.1, self:GetTall() * 0.5)
	--self.Text:SetPos( self:GetX()+self:GetWide() * 1.1, self:GetY() +self:GetTall() * 0.5)
	self.Text:SetText(words..list[value],font,0,0.5)
	--self.Text:SetMouseInputEnabled( false )
	
	self.extended = vgui.Create( "ThemeMultiBox2" , self:GetParent())
	self.extended:SetSize(self:GetWide() , self:GetTall())
	self.extended:SetPos(self:GetX(), self:GetY() +self:GetTall())
	self.extended:SetText(list, font, self)

	--self.Text:SetPos( self:GetX()+self:GetWide() * 1.1, self:GetY() +self:GetTall() * 0.5)
end

function PANEL:SetFunc(func )
	self.Func = func
end

function PANEL:SetValue(value )
	self.value = math.Clamp(value,1,#self.list)
	self.Text:SetText(self.words..self.list[self.value],nil,0,0.5)
end

function PANEL:GetValue( )
	return self.value
end

function PANEL:OnMousePressed( keyCode )
	if keyCode == MOUSE_LEFT then
		if self.extended then 
			self.extended:SetVisible( true ) 
			self.extended:MoveToFront()
		end
	end
end

function PANEL:Paint()

	if self:IsHovered() then
		draw.RoundedBox( 6, 0, 0, self:GetWide(), self:GetTall(), Theme.buttonouthi )
		draw.RoundedBox( 6, 1, 1, self:GetWide()-2, self:GetTall()-2, Theme.buttonhi )
	else
		draw.RoundedBox( 6, 0, 0, self:GetWide(), self:GetTall(), Theme.buttonout )
		draw.RoundedBox( 6, 1, 1, self:GetWide()-2, self:GetTall()-2, Theme.button )
	end


	surface.SetMaterial( tex_cog )
	surface.SetDrawColor( 255, 255, 255, 255 )
	local tall = self:GetTall() 
	surface.DrawTexturedRect( tall*0.1, tall*0.1, tall*0.85, tall*0.85)
	
	return true
end
vgui.Register( "ThemeMultiBox", PANEL, "Panel" )

--Basic Theme Text---------------------------------------------------------------------------------------
--Normal Text Display -----------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetVisible( true )
	self.width = 0
	self.height = 0
	self:SetMouseInputEnabled( false )
end

function PANEL:SetText(text,font, alignX,alignY )
	self.Text = text
	self.font = font or self.font
	surface.SetFont( self.font )

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
		draw.SimpleTextOutlined(self.Text , self.font, self:GetWide() * 0.5 , self:GetTall() * 0.5 , Theme.fontcol, 1, 1, 1, Theme.fontcolout)	
	end
	return true
end
vgui.Register( "ThemeText", PANEL, "Panel" )

--Basic Theme Text Linked------------------------------------------------------------------------------------
--Text that hilights when parent hovered --------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetVisible( true )
	self.width = 0
	self.height = 0
	self:SetMouseInputEnabled( false )
end

function PANEL:SetText(text,font, alignX,alignY )
	self.Text = text
	self.font = font or self.font
	surface.SetFont( self.font )

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
		--draw.SimpleTextOutlined(self.Text , self.font, self:GetWide() * 0.5 , self:GetTall() * 0.5 , Theme.fontcol, 1, 1, 1, Theme.fontcolout)	
		
		if self:GetParent():IsHovered() then
			draw.SimpleTextOutlined(self.Text , self.font, self:GetWide() * 0.5 , self:GetTall() * 0.5 , Theme.fontcolhi, 1, 1, 1, Theme.fontcolout)	
		else
			draw.SimpleTextOutlined(self.Text , self.font, self:GetWide() * 0.5 , self:GetTall() * 0.5 , Theme.fontcol, 1, 1, 1, Theme.fontcolout)	
		end
	end
	return true
end
vgui.Register( "ThemeTextLink", PANEL, "Panel" )

--Basic Theme TextMultiLine ---------------------------------------------------------------------------------------
--Currently only has middle aligned text currently ----------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetVisible( true )
	self.width = 0
	self.height = 0
	self:SetMouseInputEnabled( false )
end

function PANEL:SetText(text,font, alignX, alignY, spacing)
	self.Text = text
	self.font = self.font or font
	self.spacing = spacing
	surface.SetFont( self.font )
	
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

	self:SetX( self:GetX() - self.width)
	self:SetY( self:GetY() - self.height)
	
end

function PANEL:Paint()
	if self.Text then
		for i, tx in ipairs(self.Text) do
			
			draw.SimpleTextOutlined(tx , self.font, self:GetWide() * 0.5 , i * self.spacing - self.spacing * 0.5, Theme.fontcol, 1, 1, 1, Theme.fontcolout)
		end
	end
	return true
end
vgui.Register( "ThemeTextMulti", PANEL, "Panel" )

---------------------------------------------------------------------------------------
-----------------------------------Creator Functions-----------------------------------
---------------------------------------------------------------------------------------
function New_ThemeText(parent,xpos,ypos,text,font,xalign,yalign)
	local element = vgui.Create( "ThemeText" , parent)
	element:SetPos( xpos, ypos)
	element:SetText(text,font,xalign,yalign)

	return element
end

function New_ThemeTextMulti(parent,xpos,ypos,text,font,xalign,yalign,spacing)
	local element = vgui.Create( "ThemeTextMulti" , parent)
	element:SetPos( xpos, ypos)
	element:SetText(text,font,xalign,yalign,spacing)

	return element
end

function New_ThemeButton(parent,xpos,ypos,wide,tall,text,font)
	local element = vgui.Create( "ThemeButton" , parent)
	element:SetSize( wide, tall)
	element:SetPos( xpos, ypos)
	element:SetText(text,font)

	return element
end

function New_ThemeCheck(parent,xpos,ypos,wide,tall,text,font)
	local element = vgui.Create( "ThemeCheckBox" , parent)
	element:SetSize( wide, tall)
	element:SetPos( xpos, ypos)
	element:SetText(text,font)
	
	return element
end






---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------