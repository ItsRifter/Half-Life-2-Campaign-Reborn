HelpMenu = HelpMenu or {}


	
--------------------------------------------------------------------------------------------------------------
--Main Panel for garage---------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	local varH = ScrH() * 0.7
	local varW = varH * 1.4
	self:SetPos( (ScrW()- varW)*0.5, (ScrH()- varH)*0.5)
	self:SetSize( varW, varH )
	
	local Text = vgui.Create( "ThemeText" , self)
	Text:SetSize( 0, 0)
	Text:SetPos( self:GetWide() * 0.425, self:GetTall() * 0.01)
	Text:SetText(translate.Get("HelpMenu_Title"),"Font_Normal",0.5,0)
	
	Text = vgui.Create( "ThemeText" , self)
	Text:SetSize( 0, 0)
	Text:SetPos( self:GetWide() * 0.425, self:GetTall() * 0.08)
	Text:SetText(translate.Get("HelpMenu_Map")..game.GetMap(),"Font_Small",0.5,0)
	
	Text = vgui.Create( "ThemeTextMulti" , self)
	Text:SetSize( 0, 0)
	Text:SetPos( self:GetWide() * 0.425, self:GetTall() * 0.15)
	Text:SetText(translate.Get("HelpMenu_Info"),"Font_Normal",0.5,0, 2)
	--Text:SetText(translate.Get("HelpMenu_Commands"),"Font_Small",0.5,0, 2)
	
	local OpPanel = vgui.Create( "Panel" , self)
	OpPanel:SetSize(self:GetWide() * 0.8, self:GetTall() * 0.7)
	OpPanel:SetPos(self:GetWide() * 0.02 , self:GetTall() * 0.20)
	OpPanel:SetVisible(false)
	
	local CloseButton = vgui.Create( "ThemeButton" , self)
	CloseButton:SetSize( self:GetWide() * 0.15, self:GetTall() * 0.05)
	CloseButton:SetPos( self:GetWide() * 0.85 - self:GetTall() * 0.01, self:GetTall() * 0.01)
	CloseButton:SetText(translate.Get("Basic_Close"),"Font_Normal")
	CloseButton:SetFunc(
		function()
			gui.EnableScreenClicker( false ) 
			self:SetVisible( false )
		end
	)
	
	CloseButton = vgui.Create( "ThemeButton" , self)
	CloseButton:SetSize( self:GetWide() * 0.15, self:GetTall() * 0.05)
	CloseButton:SetPos( self:GetWide() * 0.85 - self:GetTall() * 0.01, self:GetTall() * 0.16)
	CloseButton:SetText(translate.Get("Basic_Help"),"Font_Small")
	CloseButton:SetFunc(
		function()
			Text:SetVisible( true )
			OpPanel:SetVisible(false)
			Text:SetText(translate.Get("HelpMenu_Info"),"Font_Normal",0.5,0, 2)
		end
	)
	
	CloseButton = vgui.Create( "ThemeButton" , self)
	CloseButton:SetSize( self:GetWide() * 0.15, self:GetTall() * 0.05)
	CloseButton:SetPos( self:GetWide() * 0.85 - self:GetTall() * 0.01, self:GetTall() * 0.22)
	CloseButton:SetText(translate.Get("Basic_Cmd"),"Font_Small")
	CloseButton:SetFunc(
		function()
			Text:SetVisible( true )
			OpPanel:SetVisible(false)
			Text:SetText(translate.Get("HelpMenu_Commands"),"Font_Normal",0.5,0, 2)
		end
	)
	
	CloseButton = vgui.Create( "ThemeButton" , self)
	CloseButton:SetSize( self:GetWide() * 0.15, self:GetTall() * 0.05)
	CloseButton:SetPos( self:GetWide() * 0.85 - self:GetTall() * 0.01, self:GetTall() * 0.28)
	CloseButton:SetText(translate.Get("Basic_Pets"),"Font_Small")
	CloseButton:SetFunc(
		function()
			Text:SetVisible( true )
			OpPanel:SetVisible(false)
			Text:SetText(translate.Get("HelpMenu_Pets"),"Font_Normal",0.5,0, 2)
		end
	)
	
	CloseButton = vgui.Create( "ThemeButton" , self)
	CloseButton:SetSize( self:GetWide() * 0.15, self:GetTall() * 0.05)
	CloseButton:SetPos( self:GetWide() * 0.85 - self:GetTall() * 0.01, self:GetTall() * 0.93)
	CloseButton:SetText(translate.Get("Basic_Options"),"Font_Small")
	CloseButton:SetFunc(
		function()
			Text:SetVisible( false )
			OpPanel:SetVisible(true)
		end
	)
	
	local Check = vgui.Create( "ThemeCheckBox" , OpPanel)
	Check:SetSize( self:GetTall() * 0.05, self:GetTall() * 0.05)
	Check:SetPos( OpPanel:GetWide() * 0.4, OpPanel:GetTall() * 0.1)
	Check:SetText(translate.Get("Options_Cross"),"Font_Small")
	Check:SetToggle(Client_Config.NewCross)
	Check:SetFunc(
		function()
			--Crosshair.Enabled = Check:Toggle()
			Client_Config.NewCross = Check:Toggle()
			Config_Changed = true
		end
	)
	
	local Check = vgui.Create( "ThemeCheckBox" , OpPanel)
	Check:SetSize( self:GetTall() * 0.05, self:GetTall() * 0.05)
	Check:SetPos( OpPanel:GetWide() * 0.4, OpPanel:GetTall() * 0.2)
	Check:SetText(translate.Get("Options_HideXp"),"Font_Small")
	Check:SetToggle(Client_Config.HideXP)
	Check:SetFunc(
		function()
			--Crosshair.Enabled = Check:Toggle()
			Client_Config.HideXP = Check:Toggle()
			Config_Changed = true
		end
	)
	

	
	self:SetVisible( true )
end

function PANEL:Paint()

	draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall() * 0.07, Theme.backcol,true, true,false,false)
	
	draw.RoundedBoxEx( 1, 0, self:GetTall() * 0.07, self:GetWide(), self:GetTall() * 0.07, Theme.backcol2,false, false,false,false)
	
	draw.RoundedBoxEx( 8, 0, self:GetTall() * 0.14, self:GetWide(), self:GetTall() * 0.86, Theme.backcol,false,false,true,true)
	
	

	return true
end

function PANEL:ChangeFrame(page)

end
vgui.Register( "HelpMenu", PANEL, "Panel" )
