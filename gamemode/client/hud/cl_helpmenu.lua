--HelpMenu = HelpMenu or {}

--------------------------------------------------------------------------------------------------------------
--Help Panel----------- --------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
local PANEL = {}

function PANEL:Init()
	local varH = ScrH() * 0.7
	local varW = varH * 1.4
	self:SetPos( (ScrW()- varW)*0.5, (ScrH()- varH)*0.5)
	self:SetSize( varW, varH )
	
	local wide = self:GetWide()
	local tall = self:GetTall()
	
	local Text = New_ThemeText(self,wide * 0.425, tall * 0.01,translate.Get("HelpMenu_Title"),"Font_Normal",0.5,0)

	local Text = New_ThemeText(self,wide * 0.425, tall* 0.08,translate.Get("HelpMenu_Map")..game.GetMap(),"Font_Small",0.5,0)
	
	local Text = New_ThemeTextMulti(self,wide * 0.425, tall * 0.15,translate.Get("HelpMenu_Info"),"Font_Normal",0.5,0,2)
	
	local OpPanel = vgui.Create( "Panel" , self)
	OpPanel:SetSize(self:GetWide() * 0.8, self:GetTall() * 0.7)
	OpPanel:SetPos(self:GetWide() * 0.02 , self:GetTall() * 0.20)
	OpPanel:SetVisible(false)
	
--------------------------------------------------------------------------------------------------------------
	local Btn = New_ThemeButton(self, wide * 0.85 - tall * 0.01, tall * 0.01,wide* 0.15,tall* 0.05,translate.Get("Basic_Close"),"Font_Normal")
	Btn:SetFunc(
		function()
			gui.EnableScreenClicker( false ) 
			self:SetVisible( false )
		end
	)
--------------------------------------------------------------------------------------------------------------
	local Btn = New_ThemeButton(self, wide * 0.85 - tall * 0.01, tall * 0.16,wide* 0.15,tall* 0.05,translate.Get("Basic_Help"),"Font_Small")
	Btn:SetFunc(
		function()
			Text:SetVisible( true )
			OpPanel:SetVisible(false)
			Text:SetText(translate.Get("HelpMenu_Info"),nil,0.5,0, 2)
		end
	)
	
	local Btn = New_ThemeButton(self, wide * 0.85 - tall * 0.01, tall * 0.22,wide* 0.15,tall* 0.05,translate.Get("Basic_Cmd"),"Font_Small")
	Btn:SetFunc(
		function()
			Text:SetVisible( true )
			OpPanel:SetVisible(false)
			Text:SetText(translate.Get("HelpMenu_Commands"),nil,0.5,0, 2)
		end
	)
	
	local Btn = New_ThemeButton(self, wide * 0.85 - tall * 0.01, tall * 0.28,wide* 0.15,tall* 0.05,translate.Get("Basic_Pets"),"Font_Small")
	Btn:SetFunc(
		function()
			Text:SetVisible( true )
			OpPanel:SetVisible(false)
			Text:SetText(translate.Get("HelpMenu_Pets"),nil,0.5,0, 2)
		end
	)
	
	local Btn = New_ThemeButton(self, wide * 0.85 - tall * 0.01, tall * 0.93,wide* 0.15,tall* 0.05,translate.Get("Basic_Options"),"Font_Small")
	Btn:SetFunc(
		function()
			Text:SetVisible( false )
			OpPanel:SetVisible(true)
		end
	)
--------------------------------------------------------------------------------------------------------------
	local Check = New_ThemeCheck(OpPanel,OpPanel:GetWide() * 0.27, OpPanel:GetTall() * 0.1,OpPanel:GetWide() * 0.3, OpPanel:GetTall() * 0.08,translate.Get("Options_HideXp"),"Font_Small")
	Check:SetToggle(Client_Config.HideXP)
	Check:SetFunc(
		function()
			Client_Config.HideXP = Check:Toggle()
			Config_Changed = true
		end
	)
	
	
	
	local Check = New_ThemeCheck(OpPanel,OpPanel:GetWide() * 0.27, OpPanel:GetTall() * 0.5,OpPanel:GetWide() * 0.3, OpPanel:GetTall() * 0.08,translate.Get("Options_Cross"),"Font_Small")
	Check:SetToggle(Client_Config.NewCross)
	Check:SetFunc(
		function()
			Client_Config.NewCross = Check:Toggle()
			Config_Changed = true
		end
	)
	
	local Check = New_ThemeCheck(OpPanel,OpPanel:GetWide() * 0.63, OpPanel:GetTall() * 0.5,OpPanel:GetWide() * 0.3, OpPanel:GetTall() * 0.08,translate.Get("Options_CrossDy"),"Font_Small")
	Check:SetToggle(Client_Config.DynamicCross)
	Check:SetFunc(
		function()
			Client_Config.DynamicCross = Check:Toggle()
			Config_Changed = true
		end
	)
	
	local MultiBox = vgui.Create( "ThemeMultiBox" , OpPanel)
	MultiBox:SetSize( OpPanel:GetWide() * 0.3, OpPanel:GetTall() * 0.08)
	MultiBox:SetPos( OpPanel:GetWide() * 0.27, OpPanel:GetTall() * 0.6)
	MultiBox:SetText("Type : ","Font_Small",{[1] = "Plus",[2] = "Circle",[3] = "Bar",[4]="None"},1)
	MultiBox:SetValue(Client_Config.CrossType)
	MultiBox:SetFunc(
		function(value)
			Client_Config.CrossType = MultiBox.value
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

vgui.Register( "HelpMenu", PANEL, "Panel" )
