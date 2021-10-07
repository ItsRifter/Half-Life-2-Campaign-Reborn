net.Receive("HL2CR_OpenAch", function()
		
	local achsSelectionPnl = vgui.Create("HL2CR_Tab")
	achsSelectionPnl:SetSize(ScrW() / 1.5, ScrH() / 1.5)
	achsSelectionPnl:Center()
	achsSelectionPnl.Paint = function(self, w, h)
		surface.SetDrawColor(HL2CR.Theme.qMenu)
		surface.DrawRect(0, 0, w, h)
	end
	
	local hl2Pnl = vgui.Create("DPanel", achsSelectionPnl)
	hl2Pnl.Paint = function() return end

	local hl2ScrollPnl = vgui.Create("DScrollPanel", hl2Pnl)
	hl2ScrollPnl:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall() / 1.40)
		
	local hl2AchList = vgui.Create("DIconLayout", hl2ScrollPnl)
	hl2AchList:SetPos(hl2Pnl:GetWide() - 50, achsSelectionPnl:GetTall() / 26 - (-hl2Pnl:GetTall() + 25))
	hl2AchList:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall())
	hl2AchList:SetSpaceY(10)
	hl2AchList:SetSpaceX(30)
		
	local achIndex = 0
		
	for k, v in pairs(GAMEMODE.Achievements["HL2"]) do
		achIndex = achIndex + 1
			
		local achPnl = hl2AchList:Add("DPanel")
		achPnl:SetSize(250, 75)
		achPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
			
		local achName = vgui.Create("DLabel", achPnl)
		achName:SetPos(75, 0)
		achName:SetFont("HL2CR_AchTitle")
		achName:SetText(translate.Get("Ach_Locked"))
			
		local achDesc = vgui.Create("DLabel", achPnl)
		achDesc:SetPos(75, 20)
		achDesc:SetFont("HL2CR_AchDesc")
		achDesc:SetText("")
			
		local achIcon = vgui.Create("DImage", achPnl)
		achIcon:SetSize(75, 75)
		achIcon:SetImage("vgui/hud/icon_locked.png")
			
		if string.find(LocalPlayer():GetNWString("stat_achievements"), v.Name) then
			achName:SetText(v.Name)
			achDesc:SetText(v.Desc)
			achIcon:SetImage(v.Mat)
		end

		achName:SizeToContents()
		achDesc:SizeToContents()
	end
		
	local miscPnl = vgui.Create("DPanel", achScreenPnl)
	miscPnl.Paint = function() return end
		
	local miscScrollPnl = vgui.Create("DScrollPanel", miscPnl)
	miscScrollPnl:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall() / 1.60 + 10)
		
	local miscAchList = vgui.Create("DIconLayout", miscScrollPnl)
	miscAchList:SetPos(hl2Pnl:GetWide() - 50, achsSelectionPnl:GetTall() / 26 - (-hl2Pnl:GetTall() + 25))
	miscAchList:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall())
	miscAchList:SetSpaceY(10)
	miscAchList:SetSpaceX(30)
		
	achIndex = 0
		
	for k, v in pairs(GAMEMODE.Achievements["Misc"]) do
		achIndex = achIndex + 1
			
		local achPnl = miscAchList:Add("DPanel")
		achPnl:SetSize(250, 75)
		achPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
			
		local achName = vgui.Create("DLabel", achPnl)
		achName:SetPos(75, 0)
		achName:SetFont("HL2CR_AchTitle")
		achName:SetText(translate.Get("Ach_Locked"))
			
		local achDesc = vgui.Create("DLabel", achPnl)
		achDesc:SetPos(75, 20)
		achDesc:SetFont("HL2CR_AchDesc")
		achDesc:SetText("")
			
		local achIcon = vgui.Create("DImage", achPnl)
		achIcon:SetSize(75, 75)
		achIcon:SetImage("vgui/hud/icon_locked.png")

		if string.find(LocalPlayer():GetNWString("stat_achievements"), v.Name) then
			achName:SetText(v.Name)
			achDesc:SetText(v.Desc)
			achIcon:SetImage(v.Mat)
		end
			
		achName:SizeToContents()
		achDesc:SizeToContents()	
	end
		
	local closePnl = vgui.Create("DPanel", achMenuTab)
	closePnl.Paint = function() return end
	
	achsSelectionPnl.navbar:AddTab("Half-Life 2", hl2Pnl)
	achsSelectionPnl.navbar:AddTab("Misc", miscPnl)
	achsSelectionPnl.navbar:AddTab("Close", closePnl)
	achsSelectionPnl.navbar:SetActive(1)
	
	achsSelectionPnl.Think = function(pnl)
		if pnl.navbar:GetActive() == closePnl then
			achsSelectionPnl:Remove()
		end
	end
end)