function ShowHelpMenu()
	local helpFrame = vgui.Create("HL2CR_Tab")
	helpFrame:SetSize(650, 450)
	helpFrame:Center()
	helpFrame:SetVisible(true)
	
	local helpScreenPnl = vgui.Create("DPanel", helpFrame)
	helpScreenPnl:SetPos(0, 55)
	helpScreenPnl:SetSize(850, 500)
	
	helpScreenPnl.Paint = function(self, w, h)
		surface.SetDrawColor(Color(75, 75, 75, 255))
		surface.DrawRect(0, 0, w, h)
	end
	
	local welcomePnl = vgui.Create("DPanel", helpScreenPnl)
	
	local welcomeLabel = vgui.Create("DLabel", welcomePnl)
	welcomeLabel:SetPos(helpFrame:GetWide() / 4, -5)
	welcomeLabel:SetText(translate.Get("Welcome"))
	welcomeLabel:SetFont("HL2CR_GamemodeTitle")
	welcomeLabel:SizeToContents()
	
	local warningLabel = vgui.Create("DLabel", welcomePnl)
	warningLabel:SetPos(helpFrame:GetWide() / 4 - 25, 165)
	warningLabel:SetText("This gamemode is currently in ALPHA\nExpect bugs and things to change")
	warningLabel:SetFont("HL2CR_GamemodeHelp")
	warningLabel:SizeToContents()
	
	local usefulCmdsPnl = vgui.Create("DPanel", helpScreenPnl)
	
	local helpfulLabel = vgui.Create("DLabel", usefulCmdsPnl)
	helpfulLabel:SetPos(usefulCmdsPnl:GetWide() * 1.5, 0)
	helpfulLabel:SetText(language.Get("UsefulInfo"))
	helpfulLabel:SetFont("HL2CR_Help_Useful")
	helpfulLabel:SizeToContents()
	
	local exitPnl = vgui.Create("DPanel", helpScreenPnl)
	
	local creditsLabel = vgui.Create("DLabel", exitPnl)
	creditsLabel:SetPos(helpFrame:GetWide() / 3.25, 25)
	creditsLabel:SetText("Credits\nCreator: SuperSponer\n\nSpecial Thanks to:\nD3, Nick, Birdman, Niik,\nThe Supreme Combine")
	creditsLabel:SetFont("HL2CR_GamemodeHelp")
	creditsLabel:SizeToContents()
	
	local helpCloseBtn = vgui.Create("DButton", exitPnl)
	helpCloseBtn:SetText("Start")
	helpCloseBtn:SetPos(helpFrame:GetWide() / 2 - 50, 250)
	helpCloseBtn:SetFont("HL2CR_GamemodeHelp")
	helpCloseBtn:SetSize(100, 50)
	
	helpCloseBtn.DoClick = function()
		surface.PlaySound("buttons/combine_button2.wav")	
		helpFrame:Remove()
	end
	
	helpFrame.navbar:AddTab("Welcome", welcomePnl)
	helpFrame.navbar:AddTab("Useful Info", usefulCmdsPnl)
	helpFrame.navbar:AddTab("Begin Playing", exitPnl)
	
	helpFrame.navbar:SetActive(1)
end


net.Receive("HL2CR_HelpMenu", function()
	ShowHelpMenu()
end)