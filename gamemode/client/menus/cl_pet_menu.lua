local REFUSE_NAMES_TBL = {
	["Headcrab"] = true,
	["Fast Headcrab"] = true,
}

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

	local petScroll = vgui.Create("DHorizontalScroller", petsPnl)
	petScroll:Dock(FILL)
	petScroll:SetOverlap( -75 )
		
	local petLayout = vgui.Create("DIconLayout", petScroll)
	petLayout:SetPos(0, petsPnl:GetTall() / 8 )
	petLayout:SetSize(petTabs:GetWide(), petTabs:GetTall())
	petLayout:SetSpaceX(20)
	
	for i, p in ipairs(curPlayerPets) do

		local petPanel = petLayout:Add("DPanel")

		petPanel:SetSize(petTabs:GetWide() / 5.2, petTabs:GetTall() / 3.5)
		petPanel.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.skillFill)
			surface.DrawRect(0, 0, w, h)
		end

		local petNameLabel = vgui.Create("DLabel", petPanel)
		
		petNameLabel:SetText(p.name)
		
		petNameLabel:SetFont("HL2CR_Pets_Name")
		petNameLabel:SetTextColor(Color(0, 0, 0, 255))
		petNameLabel:SetPos(0, 0)
		petNameLabel:SizeToContents()
		
		local petNameDesc = vgui.Create("DLabel", petPanel)
		petNameDesc:SetText("Level: " .. (p.level or 0))
		petNameDesc:SetFont("HL2CR_Pets_Desc")
		petNameDesc:SetTextColor(Color(0, 0, 0, 255))
		petNameDesc:SetPos(0, 25)
		petNameDesc:SizeToContents()
		
		local petModel = vgui.Create("DModelPanel", petPanel)
		petModel:SetSize(petPanel:GetWide(), petPanel:GetWide())
		petModel:SetPos(petPanel:GetWide()/4, -petPanel:GetWide()/1.7368)
		petModel:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
		petModel:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
		petModel:SetAmbientLight(Vector(-64, -64, -64))
		petModel.Angles = Angle(0, 0, 0)
		petModel:SetModel(p.model)
		
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
		
		local petSellBtn = vgui.Create("DButton", petPanel)
		petSellBtn:SetSize(50, 25)
		petSellBtn:SetPos(0, 45)
		petSellBtn:SetText(translate.Get("SellPet"))
		petSellBtn.confirmSell = false
		
		petSellBtn.DoClick = function(self)
			if petSellBtn.confirmSell == false then
				petSellBtn.confirmSell = true
				petSellBtn:SetText(translate.Get("ConfirmSell"))
			else
				net.Start("HL2CR_SellPet")
					net.WriteString(p["class"])
				net.SendToServer()
				petTabs:Remove()
			end
			
		end
	end
	
	
	local adoptionPnl = vgui.Create("DPanel", petTabs)
	adoptionPnl:SetSize(petTabs:GetWide(), petTabs:GetTall())
	adoptionPnl:SetPos(0, 100)

	local adoptionScroll = vgui.Create("DHorizontalScroller", adoptionPnl)
	adoptionScroll:Dock(FILL)
	adoptionScroll:SetOverlap( -75 )
		
	local adoptionLayout = vgui.Create("DIconLayout", adoptionScroll)
	adoptionLayout:SetPos(0, adoptionPnl:GetTall()/8)
	adoptionLayout:SetSize(adoptionPnl:GetWide(), adoptionPnl:GetTall())
	adoptionLayout:SetSpaceX(25)
	
	local resin = LocalPlayer():GetNWInt("currency_resin")
	local skillPoints = curPlayerPets.CurrentPet["skillpoints"] or 0
	
	for i, p in ipairs(GAMEMODE.PlayerPets) do
		if curPlayerPets[i] and curPlayerPets[i].class == p["class"] then continue end
		
		local petPanel = adoptionLayout:Add("DPanel")
		
		petPanel:SetSize(petsPnl:GetWide() / 2.8, petsPnl:GetTall() / 2.5)
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
		petModel:SetSize(petPanel:GetWide(), petPanel:GetWide())
		petModel:SetPos(petPanel:GetWide()/4, -petPanel:GetWide()/1.7368)
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
	
	enchanceSkillLabel:SetText(LocalPlayer():GetNWString("pet_name", "???") .. "'s Skillpoints: " .. skillPoints)
	
	enchanceSkillLabel:SetFont("HL2CR_Pets_Points")
	enchanceSkillLabel:SizeToContents()
	
	if curPlayerPets.CurrentPet then
		for i, s in ipairs(GAMEMODE.PlayerPetSkills) do
			if curPlayerPets.CurrentPet["class"] ~= s["Class"] then continue end
			
			local skillPanel = vgui.Create("DPanel", enhancePnl)
			skillPanel:SetSize(64, 64)
			skillPanel:SetPos(s["Pos"]["x"], s["Pos"]["y"])
			
			local skillBtnIcon = vgui.Create("DImageButton", skillPanel)
			skillBtnIcon:SetImage(s["Icon"])
			skillBtnIcon:SetSize(skillPanel:GetWide(), skillPanel:GetTall())
			skillBtnIcon:SetToolTip(s["Name"] .. "\n" .. s["Desc"])
			
			if table.HasValue(curPlayerPets.CurrentPet["curSkills"], s["Name"]) then
				local skillObtainedTick = vgui.Create("DImage", skillBtnIcon)
				skillObtainedTick:SetImage("icon16/tick.png")
				skillObtainedTick:SetPos(42, 0)
				skillObtainedTick:SetSize(24, 24)
			end
			
			skillBtnIcon.DoClick = function()
				
				if skillPoints <= 0 then
					surface.PlaySound("buttons/button16.wav")
					return
				end
				
				if table.HasValue(curPlayerPets.CurrentPet["curSkills"], s["Name"]) then
					surface.PlaySound("buttons/button16.wav")
					return
				end
			
				if s["SkillReq"] and not table.HasValue(curPlayerPets.CurrentPet["curSkills"], s["SkillReq"]) then
					surface.PlaySound("buttons/button16.wav")
					return
				end
				
				surface.PlaySound("hl2cr/standardbeep.wav")
				
				skillPoints = skillPoints - 1
				enchanceSkillLabel:SetText(LocalPlayer():GetNWString("pet_name", "???") .. "'s Skillpoints: " .. skillPoints)
				
				net.Start("HL2CR_UpdatePetSkill")
					net.WriteString(s["Name"])
				net.SendToServer()
				
				table.insert(curPlayerPets.CurrentPet["curSkills"], s["Name"])
			end
			
		end
	else
		local noPetLabel = vgui.Create("DLabel", enhancePnl)
		noPetLabel:SetFont("HL2CR_Pets_Desc")
		noPetLabel:SetText("You don't have any current pets!")
		noPetLabel:SetTextColor(Color(0, 0, 0, 255))
		noPetLabel:SetPos(enhancePnl:GetWide() / 4 , enhancePnl:GetTall() / 4)
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