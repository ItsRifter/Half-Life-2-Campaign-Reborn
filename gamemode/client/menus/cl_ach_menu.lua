local reveal = false

function ShowAchievements(unlocked, progressing)
	local achMenu = vgui.Create("HL2CR_Tab")
	achMenu:SetSize(850, 750)
	achMenu:SetPos(ScrW() / 2 - 450, 150)
	achMenu:SetVisible(true)
	achMenu:MakePopup()
	
	achMenu:SetAlpha(0)
	achMenu:AlphaTo(255, 0.30, 0, nil)
	
	local achCloseBtn = vgui.Create("DImageButton", achMenu)
	achCloseBtn:SetPos(achMenu:GetWide() - 55, 55)
	achCloseBtn:SetSize(38, 38)
	achCloseBtn:SetImage("hl2cr/ui/lambdaclose")
	
	achCloseBtn.DoClick = function()
		surface.PlaySound("buttons/combine_button2.wav")	
		achMenu:Remove()
	end
	
	local achScreenPnl = vgui.Create("DPanel", achMenu)
	achScreenPnl:SetPos(0, 104)
	achScreenPnl:SetSize(850, 0)
	achScreenPnl:SizeTo(850, 500, 0.35, 0.2, -1, function() reveal = true end)
	
	achScreenPnl.Paint = function(self, w, h)
		surface.SetDrawColor(Color(75, 75, 75, 255))
		surface.DrawRect(0, 0, w, h)
	end
	
	local hl2Pnl = vgui.Create("DPanel", achScreenPnl)
	
	local hl2AchList = vgui.Create("DIconLayout", hl2Pnl)
	hl2AchList:Dock(FILL)
	hl2AchList:SetSpaceY(15)
	hl2AchList:SetSpaceX(50)
	
	for k, v in pairs(GAMEMODE.Achievements["HL2"]) do
		local ach = v.Name
		local desc = v.Desc
		local achPnl = hl2AchList:Add("DPanel")
		achPnl:SetSize(250, 75)
		
		achPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(Color(125, 125, 125, 255))
			surface.DrawRect(0, 0, w, h)
		end
		
		local achName = vgui.Create("DLabel", achPnl)
		
		if table.HasValue(unlocked, ach) then
			achName:SetText(ach)
		else
			achName:SetText("LOCKED")
		end
		achName:SetPos(75, 0)
		achName:SetFont("HL2CR_AchTitle")
		achName:SizeToContents()
		
		local achDesc = vgui.Create("DLabel", achPnl)
		local progress
		local target
		for p, prog in pairs(progressing) do
			if ach == progressing[p].Name then
				progress = progressing[p].Value
				target = progressing[p].Max
			end
		end
		
		if table.HasValue(unlocked, ach) and not v.IsRare and not progress then
			achDesc:SetText(desc)
		elseif v.IsRare then
			achDesc:SetText("Secret, Keep playing to discover this achievement")
		elseif progress and target then
			achDesc:SetText(progress .. "/" .. target)
		else
			achDesc:SetText("???")
		end
		achDesc:SetPos(75, 20)
		achDesc:SetFont("HL2CR_AchDesc")
		achDesc:SizeToContents()
		
		local achIcon = vgui.Create("DImage", achPnl)
		achIcon:SetSize(75, 75)
		if table.HasValue(unlocked, ach) then
			achIcon:SetImage(v.Mat)
		else
			achIcon:SetImage("vgui/hud/icon_locked")
		end
	end
	
	local miscPnl = vgui.Create("DPanel", achScreenPnl)
	
	local miscAchList = vgui.Create("DIconLayout", miscPnl)
	miscAchList:Dock(FILL)
	miscAchList:SetSpaceY(15)
	miscAchList:SetSpaceX(50)
	
	for k, v in pairs(GAMEMODE.Achievements["Misc"]) do
		local ach = v.Name
		local desc = v.Desc
		local achPnl = miscAchList:Add("DPanel")
		achPnl:SetSize(250, 75)
		achPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(Color(125, 125, 125, 255))
			surface.DrawRect(0, 0, w, h)
		end
		local achName = vgui.Create("DLabel", achPnl)
		if table.HasValue(unlocked, ach) then
			achName:SetText(ach)
		else
			achName:SetText("LOCKED")
		end
		achName:SetPos(75, 0)
		achName:SetFont("HL2CR_AchTitle")
		achName:SizeToContents()
		
		local achDesc = vgui.Create("DLabel", achPnl)
		if table.HasValue(unlocked, ach) and not v.IsRare then
			achDesc:SetText(desc)
		elseif v.IsRare then
			achDesc:SetText("Secret, Keep playing to discover this achievement")
		else
			achDesc:SetText("???")
		end
		achDesc:SetPos(75, 20)
		achDesc:SetFont("HL2CR_AchDesc")
		achDesc:SizeToContents()
		
		local achIcon = vgui.Create("DImage", achPnl)
		achIcon:SetSize(75, 75)
		if table.HasValue(unlocked, ach) then
			achIcon:SetImage(v.Mat)
		else
			achIcon:SetImage("vgui/hud/icon_locked")
		end
	end
	
	
	achMenu.navbar:AddTab("Half-Life 2", hl2Pnl)
	achMenu.navbar:AddTab("Misc", miscPnl)
	
	achMenu.navbar:SetActive(1)
	
end

net.Receive("HL2CR_AchMenu", function()
	local achs = net.ReadTable()
	local achInProg = net.ReadTable()
	
	ShowAchievements(achs, achInProg)
end)