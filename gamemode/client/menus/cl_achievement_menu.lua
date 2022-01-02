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
		
	for _, v in pairs(GAMEMODE.Achievements["HL2"]) do
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
		achIcon:SetImage("materials/hl2cr/locked.jpg")
			
		if string.find(LocalPlayer():GetNWString("stat_achievements"), v.Name) then
			achName:SetText(translate.Get(v.Name))
			achDesc:SetText(translate.Get(v.Desc))
			achIcon:SetImage(v.Mat)
		end

		achName:SizeToContents()
		achDesc:SizeToContents()
	end
	
	local ep1Pnl = vgui.Create("DPanel", achsSelectionPnl)
	ep1Pnl.Paint = function() return end

	local ep1ScrollPnl = vgui.Create("DScrollPanel", ep1Pnl)
	ep1ScrollPnl:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall() / 1.40)
		
	local ep1AchList = vgui.Create("DIconLayout", ep1ScrollPnl)
	ep1AchList:SetPos(ep1Pnl:GetWide() - 50, achsSelectionPnl:GetTall() / 26 - (-hl2Pnl:GetTall() + 25))
	ep1AchList:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall())
	ep1AchList:SetSpaceY(10)
	ep1AchList:SetSpaceX(30)
		
	local achIndex = 0
		
	for _, v in pairs(GAMEMODE.Achievements["EP1"]) do
		achIndex = achIndex + 1
			
		local achPnl = ep1AchList:Add("DPanel")
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
		achIcon:SetImage("materials/hl2cr/locked.jpg")
			
		if string.find(LocalPlayer():GetNWString("stat_achievements"), v.Name) then
			achName:SetText(translate.Get(v.Name))
			achDesc:SetText(translate.Get(v.Desc))
			achIcon:SetImage(v.Mat)
		end

		achName:SizeToContents()
		achDesc:SizeToContents()
	end
	
	local ep2Pnl = vgui.Create("DPanel", achsSelectionPnl)
	ep2Pnl.Paint = function() return end

	local ep2ScrollPnl = vgui.Create("DScrollPanel", ep2Pnl)
	ep2ScrollPnl:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall() / 1.40)
		
	local ep2AchList = vgui.Create("DIconLayout", ep2ScrollPnl)
	ep2AchList:SetPos(ep1Pnl:GetWide() - 50, achsSelectionPnl:GetTall() / 26 - (-hl2Pnl:GetTall() + 25))
	ep2AchList:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall())
	ep2AchList:SetSpaceY(10)
	ep2AchList:SetSpaceX(30)
		
	local achIndex = 0
		
	for _, v in pairs(GAMEMODE.Achievements["EP2"]) do
		achIndex = achIndex + 1
			
		local achPnl = ep2AchList:Add("DPanel")
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
		achIcon:SetImage("materials/hl2cr/locked.jpg")
			
		if string.find(LocalPlayer():GetNWString("stat_achievements"), v.Name) then
			achName:SetText(translate.Get(v.Name))
			achDesc:SetText(translate.Get(v.Desc))
			achIcon:SetImage(v.Mat)
		end

		achName:SizeToContents()
		achDesc:SizeToContents()
	end
		
	local miscPnl = vgui.Create("DPanel", achsSelectionPnl)
	miscPnl.Paint = function() return end
		
	local miscScrollPnl = vgui.Create("DScrollPanel", miscPnl)
	miscScrollPnl:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall() / 1.60 + 10)
		
	local miscAchList = vgui.Create("DIconLayout", miscScrollPnl)
	miscAchList:SetPos(hl2Pnl:GetWide() - 50, achsSelectionPnl:GetTall() / 26 - (-hl2Pnl:GetTall() + 25))
	miscAchList:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall())
	miscAchList:SetSpaceY(10)
	miscAchList:SetSpaceX(30)
		
	achIndex = 0
		
	for _, v in pairs(GAMEMODE.Achievements["Misc"]) do
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
		achIcon:SetImage("materials/hl2cr/locked.jpg")

		if string.find(LocalPlayer():GetNWString("stat_achievements"), v.Name) then
			achName:SetText(translate.Get(v.Name))
			achDesc:SetText(translate.Get(v.Desc))
			achIcon:SetImage(v.Mat)
		end
			
		achName:SizeToContents()
		achDesc:SizeToContents()	
	end
	
	local customPnl = vgui.Create("DPanel", achsSelectionPnl)
	customPnl.Paint = function() return end

	local customScrollPnl = vgui.Create("DScrollPanel", customPnl)
	customScrollPnl:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall() / 1.40)
		
	local customAchList = vgui.Create("DIconLayout", customScrollPnl)
	customAchList:SetPos(customPnl:GetWide() - 50, achsSelectionPnl:GetTall() / 26 - (-customPnl:GetTall() + 25))
	customAchList:SetSize(achsSelectionPnl:GetWide(), achsSelectionPnl:GetTall())
	customAchList:SetSpaceY(10)
	customAchList:SetSpaceX(30)
		
	local achIndex = 0
		
	for _, v in pairs(GAMEMODE.Achievements["Custom"]) do
		achIndex = achIndex + 1
			
		local achPnl = customAchList:Add("DPanel")
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
		achIcon:SetImage("materials/hl2cr/locked.jpg")
			
		if string.find(LocalPlayer():GetNWString("stat_achievements"), v.Name) then
			achName:SetText(translate.Get(v.Name))
			achDesc:SetText(translate.Get(v.Desc))
			achIcon:SetImage(v.Mat)
		end

		achName:SizeToContents()
		achDesc:SizeToContents()
	end
		
	local closePnl = vgui.Create("DPanel", achMenuTab)
	closePnl.Paint = function() return end
	
	achsSelectionPnl.navbar:AddTab(translate.Get("Ach_HL2_Bar"), hl2Pnl)
	achsSelectionPnl.navbar:AddTab(translate.Get("Ach_EP1_Bar"), ep1Pnl)
	achsSelectionPnl.navbar:AddTab(translate.Get("Ach_EP2_Bar"), ep2Pnl)
	achsSelectionPnl.navbar:AddTab(translate.Get("Ach_Misc_Bar"), miscPnl)
	achsSelectionPnl.navbar:AddTab(translate.Get("Ach_Custom_Bar"), customPnl)
	achsSelectionPnl.navbar:AddTab(translate.Get("Close"), closePnl)
	
	achsSelectionPnl.navbar:SetActive(1)
	
	achsSelectionPnl.Think = function(pnl)
		if pnl.navbar:GetActive() == closePnl then
			achsSelectionPnl:Remove()
		end
	end
end)