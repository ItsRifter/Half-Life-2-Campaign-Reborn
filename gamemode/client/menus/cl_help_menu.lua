function ShowHelpMenu()
	local helpFrame = vgui.Create("HL2CR_Tab")
	helpFrame:SetSize(650, 450)
	helpFrame:Center()
	helpFrame:SetVisible(true)
	
	local helpCloseBtn = vgui.Create("DImageButton", helpFrame)
	helpCloseBtn:SetPos(helpFrame:GetWide() - 55, 5)
	helpCloseBtn:SetSize(38, 38)
	helpCloseBtn:SetImage("hl2cr/ui/lambdaclose")
	
	helpCloseBtn.DoClick = function()
		surface.PlaySound("buttons/combine_button2.wav")	
		helpFrame:Remove()
	end
	
	local helpScreenPnl = vgui.Create("DPanel", helpFrame)
	helpScreenPnl:SetPos(0, 55)
	helpScreenPnl:SetSize(850, 0)
	helpScreenPnl:SizeTo(850, 500, 0.35, 0.2, -1, function() reveal = true end)
	
	helpScreenPnl.Paint = function(self, w, h)
		surface.SetDrawColor(Color(75, 75, 75, 255))
		surface.DrawRect(0, 0, w, h)
	end
	
	local welcomePnl = vgui.Create("DPanel", helpScreenPnl)
	
	local welcomeLabel = vgui.Create("DLabel", welcomePnl)
	welcomeLabel:SetPos(150, -5)
	welcomeLabel:SetText("        Welcome to\nHalf-Life 2 - Campaign\n      Reconstructed")
	welcomeLabel:SetFont("HL2CR_GamemodeTitle")
	welcomeLabel:SizeToContents()
	
	local warningLabel = vgui.Create("DLabel", welcomePnl)
	warningLabel:SetPos(125, 165)
	warningLabel:SetText("This gamemode is currently in ALPHA\nExpect bugs and things to change")
	warningLabel:SetFont("HL2CR_GamemodeHelp")
	warningLabel:SizeToContents()
	
	helpFrame.navbar:AddTab("Welcome", welcomePnl)
	
	helpFrame.navbar:SetActive(1)
end


net.Receive("HL2CR_HelpMenu", function()
	ShowHelpMenu()
end)