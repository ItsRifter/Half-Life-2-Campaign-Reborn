net.Receive("HL2CR_OpenPets", function()
	local curPlayerPets = net.ReadTable()
	
	local petTabs = vgui.Create("HL2CR_Tab")
	petTabs:SetSize(ScrW() / 1.5, ScrH() / 2.5)
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

	local petScroll = vgui.Create("DHorizontalScroller", petsPnl)
	petScroll:Dock(FILL)
	petScroll:SetOverlap( -75 )
		
	local petLayout = vgui.Create("DIconLayout", petScroll)
	petLayout:SetPos(0, 75)
	petLayout:SetSize(petTabs:GetWide(), petTabs:GetTall())
	petLayout:SetSpaceX(25)
	
	for _, p in ipairs(curPlayerPets) do
		local petPanel = petLayout:Add("DPanel")
		
		petPanel:SetSize(petsPnl:GetWide() / 4.55, petsPnl:GetTall() / 2.5)
		petPanel.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.skillFill)
			surface.DrawRect(0, 0, w, h)
		end
		
		local petNameLabel = vgui.Create("DLabel", petPanel)
		petNameLabel:SetText(p["name"])
		petNameLabel:SetFont("HL2CR_Pets_Name")
		petNameLabel:SetTextColor(Color(0, 0, 0, 255))
		petNameLabel:SetPos(0, 0)
		petNameLabel:SizeToContents()
		
		local petNameDesc = vgui.Create("DLabel", petPanel)
		petNameDesc:SetText(p["desc"])
		petNameDesc:SetFont("HL2CR_Pets_Desc")
		petNameDesc:SetTextColor(Color(0, 0, 0, 255))
		petNameDesc:SetPos(0, 25)
		petNameDesc:SizeToContents()
		
		local petModel = vgui.Create("DModelPanel", petPanel)
		petModel:SetSize(350, 350)
		petModel:SetPos(50, -175)
		petModel:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
		petModel:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
		petModel:SetAmbientLight(Vector(-64, -64, -64))
		petModel.Angles = Angle(0, 0, 0)
		petModel:SetModel(p["model"])
		
		function petModel:DragMousePress()
			self.PressX, self.PressY = gui.MousePos()
			self.Pressed = true
		end
		
		function petModel:DragMouseRelease() self.Pressed = false end
		
		function petModel:LayoutEntity(ent)
			if (self.bAnimated) then self:RunAnimation() end

			if (self.Pressed) then
				local mx, my = gui.MousePos()
				self.Angles = self.Angles - Angle(0,((self.PressX or mx) - mx) / 2, 0)

				self.PressX, self.PressY = gui.MousePos()
			end

			ent:SetAngles(self.Angles)
		end
		
		local petUseBtn = vgui.Create("DButton", petPanel)
		petUseBtn:SetSize(125, 50)
		petUseBtn:SetPos(0, petPanel:GetTall() - 50)
		petUseBtn:SetText(translate.Get("EquipPet"))
		
		petUseBtn.DoClick = function(self)
			net.Start("HL2CR_EquipPet")
				net.WriteString(p["name"])
			net.SendToServer()
			petTabs:Remove()
		end
	end
	
	
	local adoptionPnl = vgui.Create("DPanel", petTabs)
	adoptionPnl:SetSize(petTabs:GetWide(), petTabs:GetTall())
	adoptionPnl:SetPos(0, 100)
	
	local adoptionPnlBG = vgui.Create("DPanel", adoptionPnl)
	adoptionPnlBG:SetSize(adoptionPnl:GetWide(), adoptionPnl:GetTall())
	adoptionPnlBG.Paint = function(self, w, h)
		surface.SetDrawColor(HL2CR.Theme.qMenu)
		surface.DrawRect(0, 0, w, h)
	end

	local adoptionScroll = vgui.Create("DHorizontalScroller", adoptionPnl)
	adoptionScroll:Dock(FILL)
	adoptionScroll:SetOverlap( -75 )
		
	local adoptionLayout = vgui.Create("DIconLayout", adoptionScroll)
	adoptionLayout:SetPos(0, 75)
	adoptionLayout:SetSize(adoptionPnl:GetWide(), adoptionPnl:GetTall())
	adoptionLayout:SetSpaceX(25)
	
	local resin = LocalPlayer():GetNWInt("currency_resin")
	
	for i, p in ipairs(GAMEMODE.PlayerPets) do
		if curPlayerPets[i] and curPlayerPets[i].name == p["name"] then continue end
		
		local petPanel = adoptionLayout:Add("DPanel")
		
		petPanel:SetSize(petsPnl:GetWide() / 4.55, petsPnl:GetTall() / 2.5)
		petPanel.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.skillFill)
			surface.DrawRect(0, 0, w, h)
		end
		
		local petNameLabel = vgui.Create("DLabel", petPanel)
		petNameLabel:SetText(p["name"])
		petNameLabel:SetFont("HL2CR_Pets_Name")
		petNameLabel:SetTextColor(Color(0, 0, 0, 255))
		petNameLabel:SetPos(0, 0)
		petNameLabel:SizeToContents()
		
		local petNameDesc = vgui.Create("DLabel", petPanel)
		petNameDesc:SetText(p["desc"])
		petNameDesc:SetFont("HL2CR_Pets_Desc")
		petNameDesc:SetTextColor(Color(0, 0, 0, 255))
		petNameDesc:SetPos(0, 25)
		petNameDesc:SizeToContents()
		
		local petModel = vgui.Create("DModelPanel", petPanel)
		petModel:SetSize(350, 350)
		petModel:SetPos(50, -175)
		petModel:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
		petModel:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
		petModel:SetAmbientLight(Vector(-64, -64, -64))
		petModel.Angles = Angle(0, 0, 0)
		petModel:SetModel(p["model"])
		
		function petModel:DragMousePress()
			self.PressX, self.PressY = gui.MousePos()
			self.Pressed = true
		end
		
		function petModel:DragMouseRelease() self.Pressed = false end
		
		function petModel:LayoutEntity(ent)
			if (self.bAnimated) then self:RunAnimation() end

			if (self.Pressed) then
				local mx, my = gui.MousePos()
				self.Angles = self.Angles - Angle(0,((self.PressX or mx) - mx) / 2, 0)

				self.PressX, self.PressY = gui.MousePos()
			end

			ent:SetAngles(self.Angles)
		end
		
		local petCostLabel = vgui.Create("DLabel", petPanel)
		petCostLabel:SetFont("HL2CR_Pets_Desc")
		petCostLabel:SetText("Cost: " ..  p["cost"])
		petCostLabel:SetTextColor(Color(0, 0, 0, 255))
		petCostLabel:SetPos(0, petPanel:GetTall() - 75)
		petCostLabel:SizeToContents()
		
		local petUseBtn = vgui.Create("DButton", petPanel)
		petUseBtn:SetSize(125, 50)
		petUseBtn:SetPos(0, petPanel:GetTall() - 50)
		petUseBtn:SetText(translate.Get("AdoptPet"))
		
		petUseBtn.DoClick = function(self)
			if resin < p["cost"] then
				surface.PlaySound("buttons/button16.wav")
				return
			end
			
			resin = resin - p["cost"]
			
			net.Start("HL2CR_UpdatePet")
				net.WriteString(p["name"])
			net.SendToServer()
			petTabs:Remove()
		end
	end
	
	local enhancePnl = vgui.Create("DPanel", petTabs)
	enhancePnl:SetSize(petTabs:GetWide(), petTabs:GetTall())
	enhancePnl:SetPos(0, 100)
	
	local enchanceSkillLabel = vgui.Create("DLabel", enhancePnl)
	enchanceSkillLabel:SetText(LocalPlayer():GetNWString("pet_name") .. "'s Skillpoints: " .. curPlayerPets.CurrentPet["skillpoints"])
	enchanceSkillLabel:SetFont("HL2CR_Pets_Points")
	enchanceSkillLabel:SizeToContents()
	
	if curPlayerPets.CurrentPet["class"] then
		for i, s in ipairs(GAMEMODE.PlayerPetSkills) do
			local skillPanel = vgui.Create("DPanel", enhancePnl)
			skillPanel:SetSize(64, 64)
			skillPanel:SetPos(s["Pos"]["x"], s["Pos"]["y"])
			
			local skillBtnIcon = vgui.Create("DImageButton", skillPanel)
			skillBtnIcon:SetImage(s["Icon"])
			skillBtnIcon:SetSize(skillPanel:GetWide(), skillPanel:GetTall())
			
			skillBtnIcon.DoClick = function()
				
			end
			
		end
	else
		local noPetLabel = vgui.Create("DLabel", enhancePnl)
		noPetLabel:SetFont("HL2CR_Pets_Desc")
		noPetLabel:SetText("You don't have any current pets!")
		noPetLabel:SetTextColor(Color(0, 0, 0, 255))
		noPetLabel:SetPos(enhancePnl:GetWide() /4 , enhancePnl:GetTall() / 4)
		noPetLabel:SizeToContents()
	end
	
	local closePnl = vgui.Create("DPanel", petTabs)
	closePnl:SetSize(petTabs:GetWide(), petTabs:GetTall())
	closePnl:SetPos(0, 100)
	
	petTabs.navbar:AddTab(translate.Get("Pets_Bar"), petsPnl)
	petTabs.navbar:AddTab(translate.Get("AdoptPnl"), adoptionPnl)
	petTabs.navbar:AddTab("Enhancement Centre", enhancePnl)
	petTabs.navbar:AddTab(translate.Get("Close"), closePnl)
	petTabs.navbar:SetActive(1)
	
	petTabs.Think = function(pnl)
		if pnl.navbar:GetActive() == closePnl then
			petTabs:Remove()
		end
	end
end)