local CONVERT_NAME_TO_IMAGE = {
	["Flare_gun"] = "materials/hl2cr/weapon_flaregun.jpg",
	["Multi-Grenade_Launcher"] = "materials/hl2cr/weapon_grenadelauncher.jpg",
	[".50_BMG_Heavy_Sniper"] = "materials/hl2cr/weapon_bmgsniper.jpg"
}

local CONVERT_NAME_TO_DESC = {
	["Flare_gun"] = "Used for emergencies...\nso it was",
	["Multi-Grenade_Launcher"] = "A grenade launcher\nhandle with care",
	[".50_BMG_Heavy_Sniper"] = "A rather heavy sniper\nwith devastating results"
}

hook.Add("OnSpawnMenuOpen", "HL2CR_InventoryOpen", function()
	if LocalPlayer():Alive() then
		menuFrame = vgui.Create("HL2CR_Tab")
		menuFrame:SetSize(ScrW() / 2, ScrH() / 2)
		menuFrame:Center()
		menuFrame:MakePopup()
		
		local invPnl = vgui.Create("DPanel", menuFrame)
		invPnl:SetSize(ScrW() / 2, ScrH() / 2)
		invPnl:SetPos(0, 100)
		
		local invPnlBG = vgui.Create("DPanel", invPnl)
		invPnlBG:SetSize(invPnl:GetWide(), invPnl:GetTall())
		
		invPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local invPnlPlayer = vgui.Create("DPanel", invPnl)
		invPnlPlayer:SetPos(invPnl:GetWide() / 1.35 - 50, 5)
		invPnlPlayer:SetSize(invPnl:GetWide() / 3.5, invPnl:GetTall() / 1.35)
		invPnlPlayer.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
		
		local invPnlPlayerModel = vgui.Create( "DModelPanel", invPnlPlayer )
		invPnlPlayerModel:SetSize(invPnlPlayer:GetWide() * 2.75, invPnlPlayer:GetTall() * 2.25)
		invPnlPlayerModel:SetPos(-invPnlPlayer:GetWide() / 1.15, -invPnlPlayer:GetTall() / 2.5)
		invPnlPlayerModel:SetModel( LocalPlayer():GetModel() )
		function invPnlPlayerModel:LayoutEntity( Entity ) return end
		
		local invPnlSlotsPnl = vgui.Create("DPanel", invPnl)
		invPnlSlotsPnl:SetSize(396, 250)
		invPnlSlotsPnl:SetPos(25, 75)
		invPnlSlotsPnl.Paint = function() end
		
		local invLayout = vgui.Create("DIconLayout", invPnlSlotsPnl)
		invLayout:Dock(FILL)
		invLayout:SetSpaceX(10)
		invLayout:SetSpaceY(5)
		
		local weaponSlotPnl = vgui.Create("DPanel", invPnl)
		weaponSlotPnl:SetPos(invPnl:GetWide() / 1.75, 50)
		weaponSlotPnl:SetSize(64, 64)
		
		weaponSlotPnl.Paint = function(pnl, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu2)
			surface.DrawRect(0, 0, w, h)
		end
		
		weaponSlotImage = vgui.Create("DImage", weaponSlotPnl)
		weaponSlotImage:SetSize(64, 64)
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
			
		local skillsPnl = vgui.Create("DPanel", menuFrame)
		skillsPnl:SetSize(ScrW() / 1.45, ScrH() / 2)
		skillsPnl:SetPos(0, 100)
		
		local skillsPnlBG = vgui.Create("DPanel", skillsPnl)
		skillsPnlBG:SetSize(skillsPnl:GetWide(), skillsPnl:GetTall())
		
		local skillsSelectionPnl = vgui.Create("HL2CR_Tab", skillsPnlBG)
		skillsSelectionPnl:SetSize(skillsPnl:GetWide(), skillsPnl:GetTall())
		skillsSelectionPnl:SetPos(0, -35)
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
		
		for i, skill in pairs(GAMEMODE.PlayerSkills) do
			
			local skillBtn
			
			if skill.Class == "Passive" then
				skillBtn = vgui.Create("DImageButton", passiveSkillsPnl)
			elseif skill.Class == "Medic" then
				skillBtn = vgui.Create("DImageButton", medicSkillsPnl)
			elseif skill.Class == "Repair" then
				skillBtn = vgui.Create("DImageButton", repairSkillsPnl)
			end
			
			skillBtn:SetSize(64, 64)
			skillBtn:SetPos(skill["Pos"][1], skill["Pos"][2])
			
			
			if LocalPlayer():GetNWInt("stat_level") < skill.Level then
				skillBtn:SetToolTip("LOCKED\nREACH LEVEL " .. skill.Level)
				skillBtn:SetImage("vgui/hud/icon_locked.png")
				break
			end
			
			skillBtn:SetImage(skill.Icon)
			
			if skill.Requirements == "" then
				skillBtn:SetToolTip(skill.Name .. "\n" .. skill.Desc)
			else
				skillBtn:SetToolTip(skill.Name .. "\n" .. skill.Desc .. "\nREQUIRES: " .. skill.Requirements)
			end
			
			skillBtn.DoClick = function()
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
				
				if LocalPlayer():GetNWInt("stat_skillpoints") <= 0 then
					surface.PlaySound("buttons/button16.wav")
					return
				end
				
				net.Start("HL2CR_SkillObtain")
					net.WriteString(skill.Name)
				net.SendToServer()
				
				surface.PlaySound("buttons/button5.wav")
			end
			
			if string.find(LocalPlayer():GetNWString("stat_curskills"), skill.Name) then
				local skillTick = vgui.Create("DImage", skillBtn)
				skillTick:SetImage("icon16/tick.png")
				skillTick:SetPos(0, 32)
				skillTick:SetSize(32, 32)
			end
		end
			
		skillsSelectionPnl.navbar:AddTab("Passive", passiveSkillsPnl)
		skillsSelectionPnl.navbar:AddTab("Field Medic", medicSkillsPnl)
		skillsSelectionPnl.navbar:AddTab("Repairman", repairSkillsPnl)
		skillsSelectionPnl.navbar:SetActive(1)
		
		local shopPnl = vgui.Create("DPanel", menuFrame)
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
		curResinLabel:SetText("Resin: " .. LocalPlayer():GetNWInt("currency_resin"))
		curResinLabel:SetFont("HL2CR_ShopResin")
		curResinLabel:SizeToContents()
		curResinLabel:SetPos(0, 0)
		curResinLabel:SetTextColor(Color(0, 0, 0))
		
		for i, item in pairs(GAMEMODE.ShopItems) do
			if item.Name == slots[i] then continue end
			
			local itemBtn = weaponsLayout:Add("DImageButton")
			itemBtn:SetSize(64, 64)
			itemBtn:SetImage(item.Icon)
			itemBtn:SetToolTip(item.Name .. "\n\n" .. item.Desc .. "\n\nCOST: " .. item.Cost .. " Resin")
			
			itemBtn.DoClick = function(pnl)			

				if LocalPlayer():GetNWInt("currency_resin") <= item.Cost then
					surface.PlaySound("buttons/button16.wav")
					return
				end
				
				net.Start("HL2CR_PurchaseItem")
					net.WriteString(item.Name)
				net.SendToServer()
				
				pnl:Remove()
				
				surface.PlaySound("buttons/button5.wav")
				curResinLabel:SetText("Resin: " .. LocalPlayer():GetNWInt("currency_resin") - item.Cost)
			end
		end
		
		local petsPnl = vgui.Create("DPanel", menuFrame)
		petsPnl:SetSize(ScrW() / 1.45, ScrH() / 2)
		petsPnl:SetPos(0, 100)
		
		local petsPnlBG = vgui.Create("DPanel", petsPnl)
		petsPnlBG:SetSize(petsPnl:GetWide(), petsPnl:GetTall())
		petsPnlBG.Paint = function(self, w, h)
			surface.SetDrawColor(HL2CR.Theme.qMenu)
			surface.DrawRect(0, 0, w, h)
		end
		
		local classPnl = vgui.Create("DPanel", menuFrame)
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
				classIcon:SetSize(128, 128)
				classIcon:SetPos(classShowPanel:GetWide() / 4, classShowPanel:GetTall() / 3)
				
				local classBtn = vgui.Create("DButton", classShowPanel)
				classBtn:SetText("Pick Class")
				classBtn:SetSize(125, 35)
				classBtn:SetPos(classShowPanel:GetWide() / 4, classShowPanel:GetTall() / 1.5)
				
				classBtn.DoClick = function()
					net.Start("HL2CR_SelectClass")
						net.WriteInt(i, 8)
					net.SendToServer()
					surface.PlaySound("hl2cr/standardbeep.wav")
					menuFrame:Remove()
				end
				
				classHorizontalScroll:AddPanel(classShowPanel)
			end
		else
			local classPnlLocked = vgui.Create("DLabel", classPnl)
			classPnlLocked:SetText("LOCKED: Reach Level 5")
			classPnlLocked:SetFont("HL2CR_Class_TitleFont")
			classPnlLocked:SizeToContents()
			classPnlLocked:SetPos( classPnlBG:GetWide() / 2 - 135, 50)
			classPnlLocked:SetTextColor(Color(0, 0, 0, 255))
		end
		
		local statsPnl = vgui.Create("DPanel", menuFrame)
		statsPnl:SetSize(ScrW() / 3, ScrH() / 2)
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
		statsPnlLabelBasic:SetText("Kills: " .. LocalPlayer():GetNWInt("stat_kills") .. " | Deaths: " .. LocalPlayer():GetNWInt("stat_deaths") .. " | Avg: " .. math.Round(averageStat, 2))
		statsPnlLabelBasic:SetFont("HL2CR_Menu_Stats")
		statsPnlLabelBasic:SetPos(0, 25)
		statsPnlLabelBasic:SizeToContents()
		
		local totalAchs = table.Count(GAMEMODE.Achievements["HL2"]) + table.Count(GAMEMODE.Achievements["Misc"])
		
		statsPnlLabelAch = vgui.Create("DLabel", statsPnl)
		statsPnlLabelAch:SetPos(0, 75)
		statsPnlLabelAch:SetText("Total Achievements: " .. LocalPlayer():GetNWInt("stat_totalachs", -1) .. "/" .. totalAchs)
		statsPnlLabelAch:SetFont("HL2CR_Menu_Stats")
		statsPnlLabelAch:SizeToContents()
		
		
		statsPnlLabelQuest = vgui.Create("DLabel", statsPnl)
		statsPnlLabelQuest:SetPos(0, 125)
		statsPnlLabelQuest:SetText("Quests completed: " .. LocalPlayer():GetNWInt("stat_quests_completed", -1))
		statsPnlLabelQuest:SetFont("HL2CR_Menu_Stats")
		statsPnlLabelQuest:SizeToContents()
		
		menuFrame.navbar:AddTab("Inv", invPnl)
		menuFrame.navbar:AddTab("Skills", skillsPnl)
		menuFrame.navbar:AddTab("Shop", shopPnl)
		menuFrame.navbar:AddTab("Pets", petsPnl)
		menuFrame.navbar:AddTab("Class", classPnl)
		menuFrame.navbar:AddTab("Statistics", statsPnl)
		
		menuFrame.navbar:SetActive(1)
		
		menuFrame.Think = function(pnl)
			if pnl.navbar:GetActive() == invPnl then
				pnl:SetSize(ScrW() / 2, pnl:GetTall())
				pnl:Center()
			end
				
			if pnl.navbar:GetActive() == skillsPnl then
				pnl:SetSize(ScrW() / 1.45, pnl:GetTall())
				pnl:Center()
			end
			
			if pnl.navbar:GetActive() == shopPnl then
				pnl:SetSize(ScrW() / 2, pnl:GetTall())
				pnl:Center()
			end
			
			if pnl.navbar:GetActive() == petsPnl then
				pnl:SetSize(ScrW() / 1.45, pnl:GetTall())
				pnl:Center()
			end
			if pnl.navbar:GetActive() == classPnl then
				pnl:SetSize(ScrW() / 2.15, pnl:GetTall())
				pnl:Center()
			end
			
			if pnl.navbar:GetActive() == statsPnl then
				pnl:SetSize(ScrW() / 3, pnl:GetTall())
				pnl:Center()
			end
		end
	end
end)

hook.Add("OnSpawnMenuClose", "HL2CR_InventoryClose", function()
	if menuFrame and menuFrame:IsValid() then
		menuFrame:Remove()
	end
end)