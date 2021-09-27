local CONVERT_NAME_TO_IMAGE = {
	["Flare_gun"] = "materials/hl2cr/weapon_flaregun.jpg",
	["Multi_Grenade_Launcher"] = "materials/hl2cr/weapon_grenadelauncher.jpg",
	[".50_BMG_Heavy_Sniper"] = "materials/hl2cr/weapon_bmgsniper.jpg"
}

local CONVERT_NAME_TO_PROPER = {
	["Flare_gun"] = "Flare gun",
	["Multi_Grenade_Launcher"] = "Multiple Grenade Launcher",
	[".50_BMG_Heavy_Sniper"] = ".50 BMG Heavy Sniper"
}

local CONVERT_NAME_TO_DESC = {
	["Flare_gun"] = "Used for emergencies...\nso it was",
	["Multi_Grenade_Launcher"] = "A grenade launcher\nhandle with care",
	[".50_BMG_Heavy_Sniper"] = "A rather heavy sniper\nwith devastating results"
}

local PLAYERMODELS = {
	[0] = {
		[1] = "models/player/Group01/male_01.mdl",
		[2] = "models/player/Group01/male_02.mdl",
		[3] = "models/player/Group01/male_03.mdl",
		[4] = "models/player/Group01/male_04.mdl",
		[5] = "models/player/Group01/male_05.mdl",
		[6] = "models/player/Group01/male_06.mdl",
		[7] = "models/player/Group01/male_07.mdl",
		[8] = "models/player/Group01/male_08.mdl",
		[9] = "models/player/Group01/female_01.mdl",
		[10] = "models/player/Group01/female_02.mdl",
		[11] = "models/player/Group01/female_03.mdl",
		[12] = "models/player/Group01/female_04.mdl",
		[13] = "models/player/Group01/female_05.mdl",
		[14] = "models/player/Group01/female_06.mdl"
	},
	
	[5] = {
		[1] = "models/player/Group03m/male_01.mdl",
		[2] = "models/player/Group03m/male_02.mdl",
		[3] = "models/player/Group03m/male_03.mdl",
		[4] = "models/player/Group03m/male_04.mdl",
		[5] = "models/player/Group03m/male_05.mdl",
		[6] = "models/player/Group03m/male_06.mdl",
		[7] = "models/player/Group03m/male_07.mdl",
		[8] = "models/player/Group03m/female_01.mdl",
		[9] = "models/player/Group03m/female_02.mdl",
		[10] = "models/player/Group03m/female_03.mdl",
		[11] = "models/player/Group03m/female_04.mdl",
		[12] = "models/player/Group03m/female_05.mdl",
		[13] = "models/player/Group03m/female_06.mdl",
	},
	
	[10] = {
		[1] = "models/player/police.mdl",
		[2] = "models/player/police_fem.mdl"
	}
}

function StartQMenu(shouldOpen)
	if shouldOpen then 
		qMenuTabs = vgui.Create("HL2CR_Tab")
		qMenuTabs:SetSize(ScrW() / 2, ScrH() / 2)
		qMenuTabs:Center()
		qMenuTabs:MakePopup()
		qMenuTabs:SetKeyboardInputEnabled(false)
		
		local invPnl = vgui.Create("DPanel", qMenuTabs)
		invPnl:SetSize(ScrW() / 2, ScrH() / 2)
		invPnl:SetPos(0, 100)
		
		local invPnlBG = vgui.Create("DPanel", invPnl)
		invPnlBG:SetSize(invPnl:GetWide(), invPnl:GetTall())
		
		invPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local invPnlPlayer = vgui.Create("DPanel", invPnl)
		invPnlPlayer:SetPos(invPnl:GetWide() / 1.37, 10)
		invPnlPlayer:SetSize(invPnl:GetWide() / 4, ScrH() / 2.6)
		invPnlPlayer.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
		
		local invPnlPlayerModel = vgui.Create( "DModelPanel", invPnlPlayer )
		invPnlPlayerModel:SetSize(ScrW() / 2.905, ScrH() / 1.3)
		invPnlPlayerModel:SetPos(-ScrW() / 9, -ScrH() / 6.505)
		invPnlPlayerModel:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
		invPnlPlayerModel:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
		invPnlPlayerModel:SetAmbientLight(Vector(-64, -64, -64))
		invPnlPlayerModel:SetModel( LocalPlayer():GetModel() )
		invPnlPlayerModel:SetAnimated(false)
		invPnlPlayerModel.Angles = Angle(0, 0, 0)
		function invPnlPlayerModel:DragMousePress()
			self.PressX, self.PressY = gui.MousePos()
			self.Pressed = true
		end
		function invPnlPlayerModel:DragMouseRelease() self.Pressed = false end
		function invPnlPlayerModel:LayoutEntity(ent)
			if (self.bAnimated) then self:RunAnimation() end

			if (self.Pressed) then
				local mx, my = gui.MousePos()
				self.Angles = self.Angles - Angle(0,((self.PressX or mx) - mx) / 2, 0)

				self.PressX, self.PressY = gui.MousePos()
			end

			ent:SetAngles(self.Angles)
		end
		
		local invPnlSlotsPnl = vgui.Create("DPanel", invPnl)
		invPnlSlotsPnl:SetSize(ScrW() * 0.302, 250)
		invPnlSlotsPnl:SetPos(ScrW() * 0.015, ScrH() * 0.015)
		invPnlSlotsPnl.Paint = function() end
		
		local invLayout = vgui.Create("DIconLayout", invPnlSlotsPnl)
		invLayout:Dock(FILL)
		invLayout:SetSpaceX(10)
		invLayout:SetSpaceY(5)
		
		local weaponSlotPnl = vgui.Create("DPanel", invPnl)
		weaponSlotPnl:SetPos(invPnl:GetWide() / 1.6, 50)
		weaponSlotPnl:SetSize(invPnl:GetWide() / 10, invPnl:GetWide() / 10)
		
		weaponSlotPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
		
		weaponSlotImage = vgui.Create("DImage", weaponSlotPnl)
		weaponSlotImage:SetSize(invPnl:GetWide() / 10, invPnl:GetWide() / 10)
		if CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_weaponslot")] then
			weaponSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[LocalPlayer():GetNWString("inv_weaponslot")])
		end
		
		local slots = string.Explode(" ", LocalPlayer():GetNWString("inv_slots"))

		local totalSlots = LocalPlayer():GetNWInt("inv_totalslots")
		
		local pl = LocalPlayer()
		pl.Inv = {}
		
		for i = 1, totalSlots do
			pl.Inv[i] = invLayout:Add("HL2CR_InvSlot")
			pl.Inv[i]:SetSize(52, 52)
			
			if slots[i] and CONVERT_NAME_TO_IMAGE[slots[i]] then
				pl.Inv[i].Icon = vgui.Create("DImageButton", pl.Inv[i])
				pl.Inv[i].Icon:SetImage(CONVERT_NAME_TO_IMAGE[slots[i]])
				pl.Inv[i].Icon:SetToolTip(CONVERT_NAME_TO_DESC[slots[i]])
				pl.Inv[i].Icon:SetSize(pl.Inv[i]:GetWide(), pl.Inv[i]:GetTall())
				pl.Inv[i].Icon.DoClick = function()
					net.Start("HL2CR_UpdateSlot")
						net.WriteString(slots[i])
					net.SendToServer()
					
					surface.PlaySound("hl2cr/standardbeep.wav")
					
					weaponSlotImage:SetImage(CONVERT_NAME_TO_IMAGE[slots[i]])
				end
			end
		end
			
		local skillsPnl = vgui.Create("DPanel", qMenuTabs)
		skillsPnl:SetSize(ScrW() / 1.45, ScrH() / 2)
		skillsPnl:SetPos(0, 100)
		
		local skillsPnlBG = vgui.Create("DPanel", skillsPnl)
		skillsPnlBG:SetSize(skillsPnl:GetWide(), skillsPnl:GetTall())
		
		local skillsSelectionPnl = vgui.Create("HL2CR_Tab", skillsPnlBG)
		skillsSelectionPnl:SetSize(skillsPnl:GetWide(), skillsPnl:GetTall())
		skillsSelectionPnl:SetPos(0, -35)
		skillsSelectionPnl:SetKeyboardInputEnabled(false)

		skillsSelectionPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local passiveSkillsPnl = vgui.Create("DPanel", skillsPnl)
		passiveSkillsPnl:SetSize(skillsSelectionPnl:GetWide(), skillsSelectionPnl:GetTall())
		
		local medicSkillsPnl = vgui.Create("DPanel", skillsPnl)
		medicSkillsPnl:SetSize(skillsSelectionPnl:GetWide(), skillsSelectionPnl:GetTall())
		
		local repairSkillsPnl = vgui.Create("DPanel", skillsPnl)
		repairSkillsPnl:SetSize(skillsSelectionPnl:GetWide(), skillsSelectionPnl:GetTall())
		
		local mechSkillsPnl = vgui.Create("DPanel", skillsPnl)
		mechSkillsPnl:SetSize(skillsSelectionPnl:GetWide(), skillsSelectionPnl:GetTall())
		
		for i, skill in pairs(GAMEMODE.PlayerSkills) do
			
			local skillBtn
			
			if skill.Class == "Passive" then
				skillBtn = vgui.Create("DImageButton", passiveSkillsPnl)
			elseif skill.Class == "Medic" then
				skillBtn = vgui.Create("DImageButton", medicSkillsPnl)
			elseif skill.Class == "Repair" then
				skillBtn = vgui.Create("DImageButton", repairSkillsPnl)
			elseif skill.Class == "Mechanic" then
				skillBtn = vgui.Create("DImageButton", mechSkillsPnl)
			end
			
			skillBtn:SetSize(64, 64)
			skillBtn:SetPos(skill["Pos"][1], skill["Pos"][2])
		
			if LocalPlayer():GetNWInt("stat_level") < skill.Level then
				skillBtn:SetToolTip(translate.Get("LEVEL_LOCKED") .. skill.Level)
				skillBtn:SetImage("vgui/hud/icon_locked.png")
				continue
			end
			
			skillBtn:SetImage(skill.Icon)
			
			if skill.Requirements == "" then
				skillBtn:SetToolTip(skill.Name .. "\n" .. skill.Desc)
			else
				skillBtn:SetToolTip(skill.Name .. "\n" .. skill.Desc .. translate.Get("SKILL_REQUIRES") .. skill.Requirements)
			end
			
			local skillPoints = LocalPlayer():GetNWInt("stat_skillpoints")
			
			skillBtn.DoClick = function(pnl)
				if string.find(LocalPlayer():GetNWString("stat_curskills"), skill.Name) then
					surface.PlaySound("buttons/button16.wav")
					return
				end
				
				if skill.Requirements then
					if not string.find(LocalPlayer():GetNWString("stat_curskills"), skill.Requirements) then
						surface.PlaySound("buttons/button16.wav")
						return
					end
				end
				
				if skillPoints <= 0 then
					surface.PlaySound("buttons/button16.wav")
					return
				end
				
				net.Start("HL2CR_SkillObtain")
					net.WriteString(skill.Name)
				net.SendToServer()
				
				skillPoints = skillPoints - 1
				
				local skillTick = vgui.Create("DImage", pnl)
				skillTick:SetImage("icon16/tick.png")
				skillTick:SetPos(0, 32)
				skillTick:SetSize(32, 32)
				
				surface.PlaySound("buttons/button5.wav")
			end
			
			if string.find(LocalPlayer():GetNWString("stat_curskills"), skill.Name) then
				local skillTick = vgui.Create("DImage", skillBtn)
				skillTick:SetImage("icon16/tick.png")
				skillTick:SetPos(0, 32)
				skillTick:SetSize(32, 32)
			end
		end
			
		skillsSelectionPnl.navbar:AddTab(translate.Get("SKILLS_PASSIVE"), passiveSkillsPnl)
		skillsSelectionPnl.navbar:AddTab(translate.Get("SKILLS_MEDIC"), medicSkillsPnl)
		skillsSelectionPnl.navbar:AddTab(translate.Get("SKILLS_REPAIRMAN"), repairSkillsPnl)
		skillsSelectionPnl.navbar:AddTab(translate.Get("SKILLS_MECHANIC"), mechSkillsPnl)
		skillsSelectionPnl.navbar:SetActive(1)
		
		local shopPnl = vgui.Create("DPanel", qMenuTabs)
		shopPnl:SetSize(ScrW() / 1.45, ScrH() / 2)
		shopPnl:SetPos(0, 100)
		
		local shopPnlBG = vgui.Create("DPanel", shopPnl)
		shopPnlBG:SetSize(shopPnl:GetWide(), shopPnl:GetTall())
		shopPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local shopWeaponsPnl = vgui.Create("DPanel", shopPnlBG)
		shopWeaponsPnl:SetSize(225, 125)
		shopWeaponsPnl:SetPos(25, 50)
		shopWeaponsPnl.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
				
		local shopWeaponsScroll = vgui.Create("DScrollPanel", shopWeaponsPnl)
		shopWeaponsScroll:Dock(FILL)
		
		local weaponsLayout = vgui.Create("DIconLayout", shopWeaponsScroll)
		weaponsLayout:Dock(FILL)
		
		local curResinLabel = vgui.Create("DLabel", shopPnl)
		curResinLabel:SetText(translate.Get("ResinAmount") .. LocalPlayer():GetNWInt("currency_resin"))
		curResinLabel:SetFont("HL2CR_ShopResin")
		curResinLabel:SizeToContents()
		curResinLabel:SetPos(0, 0)
		curResinLabel:SetTextColor(Color(0, 0, 0))
		
		for k, item in pairs(GAMEMODE.ShopItems) do

			if string.find(LocalPlayer():GetNWString("inv_slots"), item.Name) then continue end
			
			
			local itemBtn = weaponsLayout:Add("DImageButton")
			itemBtn:SetSize(64, 64)
			itemBtn:SetImage(item.Icon)
			itemBtn:SetToolTip(CONVERT_NAME_TO_PROPER[item.Name] .. "\n\n" .. item.Desc .. translate.Get("WeaponCost") .. item.Cost .. translate.Get("Resin"))
			
			itemBtn.DoClick = function(pnl)			

				if LocalPlayer():GetNWInt("currency_resin") < item.Cost then
					surface.PlaySound("buttons/button16.wav")
					return
				end
				
				net.Start("HL2CR_PurchaseItem")
					net.WriteString(item.Name)
				net.SendToServer()
				
				pnl:Remove()
				
				surface.PlaySound("buttons/button5.wav")
				curResinLabel:SetText(translate.Get("ResinAmount") .. LocalPlayer():GetNWInt("currency_resin") - item.Cost)
			end
		end
		
		local petsPnl = vgui.Create("DPanel", qMenuTabs)
		petsPnl:SetSize(ScrW() / 1.45, ScrH() / 2)
		petsPnl:SetPos(0, 100)
		
		local petsPnlBG = vgui.Create("DPanel", petsPnl)
		petsPnlBG:SetSize(petsPnl:GetWide(), petsPnl:GetTall())
		petsPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local classPnl = vgui.Create("DPanel", qMenuTabs)
		classPnl:SetSize(ScrW() / 2.15, ScrH() / 2)
		classPnl:SetPos(0, 100)
		
		local classPnlBG = vgui.Create("DPanel", classPnl)
		classPnlBG:SetSize(classPnl:GetWide(), classPnl:GetTall())
		classPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
		end

		local classHorizontalScroll = vgui.Create("DHorizontalScroller", classPnlBG)
		classHorizontalScroll:Dock(FILL)
		classHorizontalScroll:SetOverlap( -40 )

		if LocalPlayer():GetNWInt("stat_level") >= 5 then
			for i, class in pairs(GAMEMODE.PlayStyleClass) do
				if LocalPlayer():GetNWInt("stat_level") < class.LevelReq then break end
				
				local classShowPanel = vgui.Create("DPanel", classHorizontalScroll)
				classShowPanel:SetSize(250, classPnl:GetTall())
				classShowPanel:DockMargin(25, 0, 0, 0)
				classShowPanel:DockPadding(50, 0, 0, 0)
				classShowPanel:Dock(LEFT)
				classShowPanel.Paint = function(pnl, w, h)
					surface.SetDrawColor(225, 160, 0, 255)
					surface.DrawRect(0, 0, w, h)
				end
				
				local classPnlShowcase = vgui.Create("DLabel", classShowPanel)
				classPnlShowcase:SetText(class.Name)
				classPnlShowcase:SetFont("HL2CR_Class_TitleFont")
				classPnlShowcase:DockMargin(10, 0, 0, 0)
				classPnlShowcase:Dock(TOP)
				classPnlShowcase:SizeToContents()
				classPnlShowcase:SetTextColor(Color(0, 0, 0, 255))
				
				local classPnlDesc = vgui.Create("DLabel", classShowPanel)
				classPnlDesc:SetText(class.Desc .. "\n\n" .. class.EquipmentDesc)
				classPnlDesc:SetPos( (classShowPanel:GetWide() / classPnlDesc:GetWide() ) + 25, 50)
				classPnlDesc:SetFont("HL2CR_Class_DescFont")
				classPnlDesc:SizeToContents()
				classPnlDesc:SetTextColor(Color(0, 0, 0, 255))
				
				local classIcon = vgui.Create("DImage", classShowPanel)
				classIcon:SetImage(class.Icon)
				classIcon:SetSize(ScrW() / 15, ScrW() / 15)
				classIcon:SetPos(classShowPanel:GetWide() / 4, ScrH() / 6)
				
				local classBtn = vgui.Create("DButton", classShowPanel)
				classBtn:SetText(translate.Get("PickClass"))
				classBtn:SetSize(125, 35)
				classBtn:SetPos(classShowPanel:GetWide() / 4, classShowPanel:GetTall() / 1.5)
				
				classBtn.DoClick = function()
					net.Start("HL2CR_SelectClass")
						net.WriteInt(i, 8)
					net.SendToServer()
					surface.PlaySound("hl2cr/standardbeep.wav")
					qMenuTabs:Remove()
				end
				
				classHorizontalScroll:AddPanel(classShowPanel)
			end
		else
			local classPnlLocked = vgui.Create("DLabel", classPnl)
			classPnlLocked:SetText(translate.Get("Class_Locked"))
			classPnlLocked:SetFont("HL2CR_Class_TitleFont")
			classPnlLocked:SizeToContents()
			classPnlLocked:SetPos( classPnlBG:GetWide() / 2 - 135, 50)
			classPnlLocked:SetTextColor(Color(0, 0, 0, 255))
		end
		
		local statsPnl = vgui.Create("DPanel", qMenuTabs)
		statsPnl:SetSize(ScrW() / 2.5, ScrH() / 2)
		statsPnl:SetPos(0, 100)
		
		local statsPnlBG = vgui.Create("DPanel", statsPnl)
		statsPnlBG:SetSize(statsPnl:GetWide(), statsPnl:GetTall())
		statsPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local fixInf = 0
		
		if LocalPlayer():GetNWInt("stat_deaths") == 0 then
			fixInf = 1
		end
		
		local averageStat = LocalPlayer():GetNWInt("stat_kills") / (LocalPlayer():GetNWInt("stat_deaths") + fixInf)
		
		statsPnlLabelBasic = vgui.Create("DLabel", statsPnl)
		statsPnlLabelBasic:SetText(translate.Get("Kills") .. LocalPlayer():GetNWInt("stat_kills") .. translate.Get("Deaths") .. LocalPlayer():GetNWInt("stat_deaths") .. translate.Get("Average") .. math.Round(averageStat, 2))
		statsPnlLabelBasic:SetFont("HL2CR_Menu_Stats")
		statsPnlLabelBasic:SetPos(0, 25)
		statsPnlLabelBasic:SizeToContents()
		
		local totalAchs = table.Count(GAMEMODE.Achievements["HL2"]) + table.Count(GAMEMODE.Achievements["Misc"])
		
		statsPnlLabelAch = vgui.Create("DLabel", statsPnl)
		statsPnlLabelAch:SetPos(0, 75)
		statsPnlLabelAch:SetText(translate.Get("Achievs") .. LocalPlayer():GetNWInt("stat_totalachs", -1) .. "/" .. totalAchs)
		statsPnlLabelAch:SetFont("HL2CR_Menu_Stats")
		statsPnlLabelAch:SizeToContents()
		
		statsPnlLabelQuest = vgui.Create("DLabel", statsPnl)
		statsPnlLabelQuest:SetPos(0, 125)
		statsPnlLabelQuest:SetText(translate.Get("Quests_Done") .. LocalPlayer():GetNWInt("stat_quests_completed", -1))
		statsPnlLabelQuest:SetFont("HL2CR_Menu_Stats")
		statsPnlLabelQuest:SizeToContents()
		
		local achsPnl = vgui.Create("DPanel", qMenuTabs)
		achsPnl:SetSize(ScrW() / 2.35, ScrH() / 2.30)
		achsPnl:SetPos(0, 100)
		
		local achsPnlBG = vgui.Create("DPanel", achsPnl)
		achsPnlBG:SetSize(achsPnl:GetWide(), achsPnl:GetTall())
		achsPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local achsSelectionPnl = vgui.Create("HL2CR_Tab", achsPnlBG)
		achsSelectionPnl:SetSize(achsPnl:GetWide(), achsPnl:GetTall())
		achsSelectionPnl:SetPos(0, -35)
		achsSelectionPnl:SetKeyboardInputEnabled(false)
		
		local curAchs = string.Explode(" ", LocalPlayer():GetNWString("stat_achievements"))

		local hl2Pnl = vgui.Create("DPanel", achsSelectionPnl)

		local hl2ScrollPnl = vgui.Create("DScrollPanel", hl2Pnl)
		hl2ScrollPnl:Dock(FILL)
		
		local hl2AchList = vgui.Create("DIconLayout", hl2ScrollPnl)
		hl2AchList:Dock(FILL)
		hl2AchList:SetSpaceY(15)
		hl2AchList:SetSpaceX(50)
		
		local achIndex = 0
		
		for k, v in pairs(GAMEMODE.Achievements["HL2"]) do
			achIndex = achIndex + 1
			local achPnl = hl2AchList:Add("DPanel")
			achPnl:SetSize(225, 75)
			achPnl.Paint = function(pnl, w, h)
				surface.SetDrawColor(HL2CR.Theme.qMenu2)	
				surface.DrawRect(0, 0, w, h)
			end
			
			local achName = vgui.Create("DLabel", achPnl)

			if v.NameServer == curAchs[achIndex] then
				achName:SetText(v.Name)
			else
				achName:SetText("Locked")
			end
			
			achName:SetPos(75, 0)
			achName:SetFont("HL2CR_AchTitle")
			achName:SizeToContents()
			
			local achDesc = vgui.Create("DLabel", achPnl)
	
			if v.NameServer == curAchs[achIndex] then
				achDesc:SetText(v.Desc)
			else
				achDesc:SetText("")
			end
			
			achDesc:SetPos(75, 20)
			achDesc:SetFont("HL2CR_AchDesc")
			achDesc:SizeToContents()
			
			local achIcon = vgui.Create("DImage", achPnl)
			achIcon:SetSize(75, 75)
			if v.NameServer == curAchs[achIndex] then
				achIcon:SetImage(v.Mat)
			else
				achIcon:SetImage("vgui/hud/icon_locked.png")
			end


		end
		
		local miscPnl = vgui.Create("DPanel", achScreenPnl)
		
		local miscScrollPnl = vgui.Create("DScrollPanel", miscPnl)
		miscScrollPnl:Dock(FILL)
		
		local miscAchList = vgui.Create("DIconLayout", miscScrollPnl)
		miscAchList:Dock(FILL)
		miscAchList:SetSpaceY(15)
		miscAchList:SetSpaceX(50)
		achIndex = 0
		for k, v in pairs(GAMEMODE.Achievements["Misc"]) do
			achIndex = achIndex + 1
			local achPnl = miscAchList:Add("DPanel")
			achPnl:SetSize(225, 75)
			achPnl.Paint = function(pnl, w, h)
				surface.SetDrawColor(HL2CR.Theme.qMenu2)
				surface.DrawRect(0, 0, w, h)
			end
			
			local achName = vgui.Create("DLabel", achPnl)
			
			if v.NameServer == curAchs[achIndex] then
				achName:SetText(v.Name)
			else
				achName:SetText("Locked")
			end
			
			achName:SetPos(75, 0)
			achName:SetFont("HL2CR_AchTitle")
			achName:SizeToContents()
			
			local achDesc = vgui.Create("DLabel", achPnl)
			
			if v.NameServer == curAchs[achIndex] then
				achDesc:SetText(v.Desc)
			else
				achDesc:SetText("")
			end
			
			achDesc:SetPos(75, 20)
			achDesc:SetFont("HL2CR_AchDesc")
			achDesc:SizeToContents()
			
			local achIcon = vgui.Create("DImage", achPnl)
			achIcon:SetSize(75, 75)
			if v.NameServer == curAchs[achIndex] then
				achIcon:SetImage(v.Mat)
			else
				achIcon:SetImage("vgui/hud/icon_locked.png")
			end
		end
		
		
		achsSelectionPnl.navbar:AddTab("Half-Life 2", hl2Pnl)
		achsSelectionPnl.navbar:AddTab("Misc", miscPnl)
		achsSelectionPnl.navbar:SetActive(1)
		
		qMenuTabs.navbar:AddTab(translate.Get("Inv_Bar"), invPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Skills_Bar"), skillsPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Shop_Bar"), shopPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Pets_Bar"), petsPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Class_Bar"), classPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Statistics_Bar"), statsPnl)
		qMenuTabs.navbar:AddTab(translate.Get("Achievements_Bar"), achsPnl)
		
		qMenuTabs.navbar:SetActive(1)
		
		qMenuTabs.Think = function(pnl)
			if pnl.navbar:GetActive() == invPnl then
				pnl:SetSize(ScrW() / 2, pnl:GetTall())
				pnl:Center()
			end
				
			if pnl.navbar:GetActive() == skillsPnl then
				pnl:SetSize(ScrW() / 2, pnl:GetTall())
				pnl:Center()
			end
			
			if pnl.navbar:GetActive() == shopPnl then
				pnl:SetSize(ScrW() / 2, pnl:GetTall())
				pnl:Center()
			end
			
			if pnl.navbar:GetActive() == petsPnl then
				pnl:SetSize(ScrW() / 2, pnl:GetTall())
				pnl:Center()
			end
			if pnl.navbar:GetActive() == classPnl then
				pnl:SetSize(ScrW() / 2.15, pnl:GetTall())
				pnl:Center()
			end
			
			if pnl.navbar:GetActive() == statsPnl then
				pnl:SetSize(ScrW() / 2.5, pnl:GetTall())
				pnl:Center()
			end
			
			if pnl.navbar:GetActive() == achsPnl then
				pnl:SetSize(ScrW() / 2.35, pnl:GetTall())
				pnl:Center()
			end
		end
	
	else
		if qMenuTabs and qMenuTabs:IsValid() then
			qMenuTabs:Remove()
		end
	end
end

hook.Add("OnSpawnMenuOpen", "HL2CR_QMenuOpen", function()
	StartQMenu(true)
end)

hook.Add("OnSpawnMenuClose", "HL2CR_QMenuClose", function()
	StartQMenu(false)
end)