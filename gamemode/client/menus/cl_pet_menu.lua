net.Receive("HL2CR_OpenPets", function()
	local petTabs = vgui.Create("HL2CR_Tab")
	petTabs:SetSize(ScrW() / 1.5, ScrH() / 1.5)
	petTabs:Center()
	petTabs.Paint = function(self, w, h)
		surface.SetDrawColor(HL2CR.Theme.qMenu)
		surface.DrawRect(0, 0, w, h)
	end
	
	local petsPnl = vgui.Create("DPanel", petTabs)
	petsPnl:SetSize(petTabs:GetWide(), petTabs:GetTall())
	petsPnl:SetPos(0, 100)
	
	local petsPnlBG = vgui.Create("DPanel", petsPnl)
	petsPnlBG:SetSize(petsPnl:GetWide(), petsPnl:GetTall())
	petsPnlBG.Paint = function(self, w, h)
		surface.SetDrawColor(HL2CR.Theme.qMenu)
		surface.DrawRect(0, 0, w, h)
	end

	local closePnl = vgui.Create("DPanel", petTabs)
	closePnl:SetSize(petTabs:GetWide(), petTabs:GetTall())
	closePnl:SetPos(0, 100)

	petTabs.navbar:AddTab(translate.Get("Pets_Bar"), petsPnl)
	petTabs.navbar:AddTab(translate.Get("Close"), closePnl)
	petTabs.navbar:SetActive(1)
	
	petTabs.Think = function(pnl)
		if pnl.navbar:GetActive() == closePnl then
			petTabs:Remove()
		end
	end
end)

--This is temporary
net.Receive("HL2CR_OpenCustomMap", function()
	local customFrame = vgui.Create("DFrame")
	customFrame:SetSize(ScrW() / 1.47, ScrH() / 1.5)
	customFrame:SetTitle("")
	customFrame:Center()
	customFrame:ShowCloseButton(true)
	customFrame:MakePopup()
	
	customFrame.Paint = function(self, w, h)
		surface.SetDrawColor(HL2CR.Theme.qMenu)
		surface.DrawRect(0, 0, w, h)
	end
	
	local mapScroll = vgui.Create("DScrollPanel", customFrame)
	mapScroll:Dock(FILL)
	mapScroll.Paint = function() return end
	
	local rndMapBtn = vgui.Create("DButton", mapScroll)
	rndMapBtn:SetSize(1024, 256)
	rndMapBtn:SetPos(customFrame:GetWide() / 3.74, 50)
	rndMapBtn:SetText("")
	rndMapBtn:SetImage("materials/hl2cr/mapicons/rnd.jpg")
	rndMapBtn.Paint = function() end
	rndMapBtn.DoClick = function()
		net.Start("HL2CR_VoteCustomMap")
			net.WriteString("BeginRND")
		net.SendToServer()
		customFrame:Close()
	end
	
	local pursoupMapBtn = vgui.Create("DButton", mapScroll)
	pursoupMapBtn:SetSize(1024, 256)
	pursoupMapBtn:SetPos(customFrame:GetWide() / 3.74, 50 * 7)
	pursoupMapBtn:SetText("")
	pursoupMapBtn:SetImage("materials/hl2cr/mapicons/pursoup.jpg")
	pursoupMapBtn.Paint = function() end
	pursoupMapBtn.DoClick = function()
		net.Start("HL2CR_VoteCustomMap")
			net.WriteString("BeginPursoups")
		net.SendToServer()
		customFrame:Close()
	end
	
	local nhMapBtn = vgui.Create("DButton", mapScroll)
	nhMapBtn:SetSize(1024, 256)
	nhMapBtn:SetPos(customFrame:GetWide() / 3.74, 50 * 13)
	nhMapBtn:SetText("")
	nhMapBtn:SetImage("materials/hl2cr/mapicons/nh.jpg")
	nhMapBtn.Paint = function() end
	nhMapBtn.DoClick = function()
		net.Start("HL2CR_VoteCustomMap")
			net.WriteString("BeginNightmareHouse")
		net.SendToServer()
		customFrame:Close()
	end
end)