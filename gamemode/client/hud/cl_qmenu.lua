
local toggleOpen = toggleOpen or false
local timeLastOpen = 0
local qMenuFrame = qMenuFrame or nil

local function CreateMainPanel()
	local mainPnl = vgui.Create("DPanel")
	mainPnl:SetSize(qMenuFrame:GetWide(), qMenuFrame:GetTall() * 0.8612)
	mainPnl:SetPos(0, 50)
	mainPnl.Paint = function(self, w, h) return end

	-- playermodel panel
	local mainPnlPlayer = vgui.Create("DPanel", mainPnl)
	mainPnlPlayer:SetPos(15, mainPnl:GetTall() * 0.0564)
	mainPnlPlayer:SetSize(mainPnl:GetWide() * 0.238, mainPnl:GetTall() - 50)
	mainPnlPlayer.Paint = function(self, w, h)
		draw.RoundedBoxEx(8, 0, 0, w, h, HL2CR.Theme.qMenuPlayer, true, true, false, false)
	end
	
	local mainPnlPlayerModel = vgui.Create("DModelPanel", mainPnlPlayer)
	mainPnlPlayerModel:SetSize(mainPnlPlayer:GetWide(), mainPnlPlayer:GetTall() )
	mainPnlPlayerModel:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
	mainPnlPlayerModel:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
	mainPnlPlayerModel:SetAmbientLight(Vector(-64, -64, -64))
	mainPnlPlayerModel:SetModel( LocalPlayer():GetModel() )

	mainPnlPlayerModel.Angles = Angle(0, 25, 0)

	function mainPnlPlayerModel:DragMousePress()
		self.PressX, self.PressY = input.GetCursorPos()
		self.Pressed = true
	end

	function mainPnlPlayerModel:DragMouseRelease() self.Pressed = false end

	local eyepos = mainPnlPlayerModel.Entity:GetBonePosition(mainPnlPlayerModel.Entity:LookupBone("ValveBiped.Bip01_Head1")) or nil

	if eyepos ~= nil then

		eyepos:Add(Vector(0, 0, -2))

		mainPnlPlayerModel:SetLookAt(eyepos)
		mainPnlPlayerModel.Entity:SetPos(mainPnlPlayerModel.Entity:GetPos() + Vector(0, 0, 2.5))
		mainPnlPlayerModel:SetCamPos(eyepos - Vector(-20, 0, -5))
	end

	function mainPnlPlayerModel:LayoutEntity(ent)
		if self.bAnimated then self:RunAnimation() end

		if self.Pressed then
			local mx, my = input.GetCursorPos()
			self.Angles = self.Angles - Angle(0,((self.PressX or mx) - mx) / 2, 0)

			self.PressX, self.PressY = input.GetCursorPos()
		end

		ent:SetAngles(self.Angles)
	end

	local playerModelCombo = vgui.Create( "DComboBox", mainPnlPlayer )
	playerModelCombo:SetPos( 1, 20 )
	playerModelCombo:SetSize( 100, 20 )
	playerModelCombo:SetValue( "Select Character" )
	for lvl, mdls in ipairs(ClientLevelModels) do
		if LocalPlayer():GetNWInt("hl2cr_stat_level") >= lvl then
			for i, m in ipairs(mdls) do
				playerModelCombo:AddChoice(m)
			end
		end
	end
	playerModelCombo.OnSelect = function( self, index, value )
		net.Start("HL2CR_Model_Update")
			net.WriteString(value)
		net.SendToServer()
	end
	
	local cosmetics = string.Explode("  ", LocalPlayer():GetNWString("hl2cr_items_cosmetics"))

	local playerCosmeticCombo = vgui.Create( "DComboBox", mainPnlPlayer )
	playerCosmeticCombo:SetPos( mainPnlPlayer:GetWide() * 0.671, 20 )
	playerCosmeticCombo:SetSize( 100, 20 )
	playerCosmeticCombo:SetValue( "Select Hat" )
	playerCosmeticCombo:AddChoice("Clear")
	if table.Count(cosmetics) >= 1 then
		for _, c in ipairs(cosmetics) do
			if c == nil then continue end
			playerCosmeticCombo:AddChoice( c )
		end
	end

	playerCosmeticCombo.OnSelect = function( self, index, value )
		if value == "Clear" then
			net.Start("HL2CR_Cosmetic")
				net.WriteString("")
			net.SendToServer()
			return
		end
		
		net.Start("HL2CR_Cosmetic")
			net.WriteString(value)
		net.SendToServer()
	end

	local invPnl = vgui.Create("DPanel", mainPnl) -- for labels
	invPnl:SetSize(mainPnl:GetWide() * 0.667, mainPnl:GetTall() * 0.5)
	invPnl:SetPos(mainPnl:GetWide() * 0.276, mainPnl:GetTall() * 0.0565)
	invPnl.Paint = function(self, w, h)
		draw.RoundedBoxEx(8, 0, 0, w, h, HL2CR.Theme.qMenuPlayer, true, true, true, true)
	end

	local invSlots = vgui.Create("DPanel", mainPnl)
	invSlots:SetSize(mainPnl:GetWide() * 0.643, mainPnl:GetTall() * 0.43)
	invSlots:SetPos(mainPnl:GetWide() * 0.3, mainPnl:GetTall() * 0.125)
	invSlots.Paint = function(self, w, h)
		draw.RoundedBoxEx(8, 0, 0, w, h, HL2CR.Theme.qMenuInvSlots, true, true, true, true)
	end

	local invLbl = vgui.Create("DLabel", invPnl)
	invLbl:SetPos(invPnl:GetWide() * 0.441384, 5)
	invLbl:SetFont("hl2cr_qmenu_class_desc")
	invLbl:SetTextColor(Color(0, 0, 0))
	invLbl:SetText(translate.Get("QMenu_InvTitle") .. string.format("%g/%g", LocalPlayer():GetNWInt("hl2cr_inv_curweight", -1), LocalPlayer():GetNWInt("hl2cr_inv_weight", -1)))
	invLbl:SizeToContents()

	local listLayout = vgui.Create("DIconLayout", invSlots)
	listLayout:SetSpaceX(5)
	listLayout:SetSpaceY(5)
	listLayout:Dock(FILL)

	local items = string.Explode(" ", LocalPlayer():GetNWString("hl2cr_inv_items"))

	for _, p in ipairs(items) do
		if p == "" then continue end
		local itemInfo = nil
		--Grab info about the item using the classname
		for _, i in ipairs(GAMEMODE.ShopItems) do
			if p == i.Class then
				itemInfo = i
				break
			end
		end

		--If we didn't find the item info, stop the loop here and restart
		if itemInfo == nil then continue end

		
		local invBtn = listLayout:Add("DImageButton")
		invBtn:SetSize(64, 64)
		invBtn:SetImage(itemInfo.Icon)
		invBtn:SetToolTip(itemInfo.Name .. "\n" .. itemInfo.Desc)
		invBtn.DoClick = function(self)
			net.Start("HL2CR_Item_Use")
			net.WriteString(itemInfo.Class)
			net.SendToServer()
		end
	end

	return mainPnl
end


local function CreateSkillsPanel()
	local skills = LocalPlayer():GetNWString("hl2cr_stat_skills", "")
	local skillPoints = LocalPlayer():GetNWInt("hl2cr_stat_skillpoints", -1)

	local dragPnl = vgui.Create("HL2CR_DraggablePanel")
	dragPnl:SetSize(qMenuFrame:GetWide(), ScrH() * 0.5391)

	dragPnl.Paint = function(self, w, h) 
		surface.SetDrawColor(HL2CR.Theme.qMenuSkills)
		surface.DrawRect(0, 0, w, h)
	end

	local client_skillinfo = {}

	for i, s in ipairs(HL2CR_Skills) do
		local panel = vgui.Create("DPanel", dragPnl)
		panel:SetSize(160, 128)
		panel:SetPos(s.PosInPanel.XPos, s.PosInPanel.YPos)
		panel.Paint = function() return end

		local skillInfoName = vgui.Create("DLabel", panel)
		skillInfoName:SetText(s.Name)
		skillInfoName:SetFont("hl2cr_qmenu_skill")
		skillInfoName:SetPos(12, -4)
		skillInfoName:SetTextColor(Color(255, 255, 255))
		skillInfoName:SizeToContents()

		table.insert(client_skillinfo, skillInfoName)

		local skillInfoCost = vgui.Create("DLabel", panel)
		skillInfoCost:SetText(translate.Get("QMenu_SkillPnl_SkillCost") .. s.Cost)
		skillInfoCost:SetFont("hl2cr_qmenu_skill")
		skillInfoCost:SetPos(40, 12)
		skillInfoCost:SetTextColor(Color(255, 255, 255))
		skillInfoCost:SizeToContents()

		local skillBtn = vgui.Create("DImageButton", panel)
		skillBtn:SetSize(panel:GetWide() * 0.5, panel:GetTall() * 0.625)
		skillBtn:SetPos(24, 32)
		skillBtn:SetImage(s.Icon)
		skillBtn.DoClick = function(self)
			if string.find(skills, s.Class) then
				surface.PlaySound("items/suitchargeno1.wav")
				return
			elseif s.SkillNeeded and not string.find(skills, s.SkillNeeded) then
				surface.PlaySound("items/suitchargeno1.wav")
				
				client_skillinfo[i-1]:SetTextColor(Color(255, 0, 0))

				timer.Create("HL2CR_QMenu_Error_" .. i, 0.5, 1, function()
					if not qMenuFrame then 
						timer.Remove("HL2CR_QMenu_Error_" .. i)
						return 
					end

					client_skillinfo[i-1]:SetTextColor(Color(255, 255, 255))
				end)
				return
			elseif skillPoints < s.Cost then
				surface.PlaySound("items/suitchargeno1.wav")

				skillInfoCost:SetTextColor(Color(255, 0, 0))

				timer.Create("HL2CR_QMenu_Error_" .. i, 0.5, 1, function()
					if not qMenuFrame then 
						timer.Remove("HL2CR_QMenu_Error_" .. i)
						return 
					end

					skillInfoCost:SetTextColor(Color(255, 255, 255))
				end)

				return
			end
			net.Start("HL2CR_Skills_Purchase")
				net.WriteString(s.Class)
			net.SendToServer()

			skills = skills .. " " .. s.Class
			skillPoints = skillPoints - s.Cost
			local hasSkill = vgui.Create("DImage", panel)
			hasSkill:SetImage("icon16/tick.png")
			hasSkill:SetSize(24, 24)
			hasSkill:SetPos(panel:GetWide() - hasSkill:GetWide(), panel:GetTall() - hasSkill:GetTall())

			surface.PlaySound("items/suitchargeok1.wav")
		end

		if string.find(skills, s.Class) then
			local hasSkill = vgui.Create("DImage", panel)
			hasSkill:SetImage("icon16/tick.png")
			hasSkill:SetSize(24, 24)
			hasSkill:SetPos(panel:GetWide() - hasSkill:GetWide(), panel:GetTall() - hasSkill:GetTall())
		end
	end

	return dragPnl
end

-- function ShowClass(class, panel)
-- 	for _, old in ipairs(panel:GetChildren()) do
-- 		old:Remove()
-- 	end

-- 	local showcaseText = vgui.Create("DLabel", panel)
-- 	showcaseText:SetText(class.Name)
-- 	showcaseText:SetFont("hl2cr_qmenu_class_title")
-- 	showcaseText:Center()
-- 	showcaseText:SetPos(showcaseText:GetX() - 40, showcaseText:GetY() / 6)
-- 	showcaseText:SizeToContents()
-- 	showcaseText:SetTextColor(Color(0, 0, 0))

-- 	local showcaseDesc = vgui.Create("DLabel", panel)
-- 	showcaseDesc:SetText(class.Desc)
-- 	showcaseDesc:SetFont("hl2cr_qmenu_class_desc")
-- 	showcaseDesc:Center()
-- 	showcaseDesc:SetPos(panel:GetWide() / (string.len(class.Desc) * 8) + 150, panel:GetTall() / 2 - 225)
-- 	showcaseDesc:SizeToContents()
-- 	showcaseDesc:SetTextColor(Color(0, 0, 0))

-- 	local showcaseModel = vgui.Create("DModelPanel", panel)
-- 	showcaseModel:SetSize(panel:GetWide(), panel:GetTall())
-- 	showcaseModel:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
-- 	showcaseModel:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
-- 	showcaseModel:SetAmbientLight(Vector(-64, -64, -64))
-- 	showcaseModel:SetModel( ClientModels[class.Name][math.random(1, #ClientModels[class.Name])] )

-- 	local eyepos = showcaseModel.Entity:GetBonePosition(showcaseModel.Entity:LookupBone("ValveBiped.Bip01_Head1"))

-- 	eyepos:Add(Vector(50, 0, -2))

-- 	showcaseModel:SetLookAt(eyepos)
-- 	showcaseModel.Entity:SetPos(showcaseModel.Entity:GetPos() + Vector(0, 0, 10))
-- 	showcaseModel:SetCamPos(eyepos - Vector(-20, 0, 0))
-- 	function showcaseModel:LayoutEntity(ent) return end

-- 	local showcaseBuffs = vgui.Create("DLabel", panel)
-- 	showcaseBuffs:SetText(translate.Get("Player_Class_Advantages"))
-- 	showcaseBuffs:SetPos(panel:GetWide() / 2 - 200, 150)
-- 	showcaseBuffs:SetFont("hl2cr_qmenu_class_desc")
-- 	showcaseBuffs:SizeToContents()
-- 	showcaseBuffs:SetTextColor(Color(0, 0, 0))

-- 	local buffPanel = vgui.Create("DPanel", panel)
-- 	buffPanel:SetPos(panel:GetWide() / 2 - 250, 175)
-- 	buffPanel:SetSize(256, 250)
-- 	buffPanel.Paint = function() return end

-- 	for i, _ in ipairs(class.Buffs) do 
-- 		local buff = vgui.Create("DLabel", buffPanel)
-- 		buff:SetText(class.Buffs[i])
-- 		buff:SetPos(buffPanel:GetWide() / 2 - 100, (i-1) * 25)
-- 		buff:SetFont("hl2cr_qmenu_class_buffdebuff")
-- 		buff:SetTextColor(Color(0, 0, 0))
-- 		buff:SizeToContents()
-- 	end

-- 	local showcaseDebuffs = vgui.Create("DLabel", panel)
-- 	showcaseDebuffs:SetText(translate.Get("Player_Class_Disadvantages"))
-- 	showcaseDebuffs:SetPos(panel:GetWide() / 2 + 75, 150)
-- 	showcaseDebuffs:SetFont("hl2cr_qmenu_class_desc")
-- 	showcaseDebuffs:SizeToContents()
-- 	showcaseDebuffs:SetTextColor(Color(0, 0, 0))

-- 	local debuffPanel = vgui.Create("DPanel", panel)
-- 	debuffPanel:SetPos(panel:GetWide() / 2 + 50, 175)
-- 	debuffPanel:SetSize(256, 250)
-- 	debuffPanel.Paint = function() return end

-- 	for i, _ in ipairs(class.Debuffs) do 
-- 		local debuff = vgui.Create("DLabel", debuffPanel)
-- 		debuff:SetText(class.Debuffs[i])
-- 		debuff:Center()
-- 		debuff:SetPos(buffPanel:GetWide() / 2 - 125, (i-1) * 25)
-- 		debuff:SetFont("hl2cr_qmenu_class_buffdebuff")
-- 		debuff:SetTextColor(Color(0, 0, 0))
-- 		debuff:SizeToContents()
-- 	end

-- 	local setClassbtn = vgui.Create("DButton", panel)
-- 	setClassbtn:SetText(translate.Get("QMenu_Class_Assign"))
-- 	setClassbtn:SetSize(128, 64)
-- 	setClassbtn:SetPos(panel:GetWide() / 1.25 - 80, panel:GetTall() - 64)
	
-- 	setClassbtn.DoClick = function()
-- 		net.Start("HL2CR_Class_Update")
-- 		net.WriteString(class.Name)
-- 		net.SendToServer()
-- 	end
	
-- 	local classLevelReq = vgui.Create("DLabel", panel)
-- 	classLevelReq:SetText(translate.Get("QMenu_Class_LevelReq") .. class.LevelReq)
-- 	classLevelReq:SetFont("hl2cr_qmenu_class_desc")
-- 	classLevelReq:SetPos(setClassbtn:GetX(), setClassbtn:GetY() - 32)
-- 	classLevelReq:SetTextColor(Color(0, 0, 0))
-- 	classLevelReq:SizeToContents()
-- end

local function CreateShopPanel()
	local mainShopPnl = vgui.Create("DPanel")
	mainShopPnl:SetSize(qMenuFrame:GetWide(), qMenuFrame:GetTall() * 0.8612)
	mainShopPnl:SetPos(0, 0)
	mainShopPnl.Paint = function(self, w, h) return end

	local listPnl = vgui.Create("DPanel", mainShopPnl)
	listPnl:SetSize(mainShopPnl:GetWide() * 0.94141, mainShopPnl:GetTall() * 0.95929)
	listPnl:SetPos(75 / 2, 25)
	listPnl.Paint = function(self, w, h)
		draw.RoundedBox(8, 0, 0, w, h, HL2CR.Theme.classPanel)
	end

	local listLayout = vgui.Create("DIconLayout", listPnl)
	listLayout:SetSpaceX(5)
	listLayout:SetSpaceY(5)
	listLayout:Dock(FILL)

	for i, itm in ipairs(GAMEMODE.ShopItems) do
		local btnIcon = listLayout:Add("DImageButton")
		btnIcon:SetSize(64, 64)
		btnIcon:SetImage(itm.Icon)
		btnIcon:SetToolTip(itm.Name .. "\n" .. itm.Desc)

		btnIcon.DoClick = function(self)
			net.Start("HL2CR_Item_Purchase")
				net.WriteString(itm.Class)
			net.SendToServer()
		end
	end

	return mainShopPnl
end

local function CreateAchPanel()
	local mainAchPanel = vgui.Create("DPanel")
	mainAchPanel:SetSize(qMenuFrame:GetWide(), qMenuFrame:GetTall() * 0.8612)
	mainAchPanel:SetPos(0, 0)
	mainAchPanel.Paint = function(self, w, h) return end

	local listPnl = vgui.Create("DPanel", mainAchPanel)
	listPnl:SetSize(mainAchPanel:GetWide() - 25, mainAchPanel:GetTall())
	listPnl:SetPos(mainAchPanel:GetWide() / 16 - 65, 0)
	listPnl.Paint = function(self, w, h)
		draw.RoundedBox(8, 0, 0, w, h, HL2CR.Theme.classPanel)
	end

	local achs = LocalPlayer():GetNWString("hl2cr_achievements", "")

	local explodeString = string.Explode(" ", achs)
	local tblString = {}

	for _, s in ipairs(explodeString) do
		local removeFixup = string.Replace(s, "_", " ")
		table.insert(tblString, removeFixup)
	end

	local achScroll = vgui.Create( "DScrollPanel", mainAchPanel )
	achScroll:Dock( FILL )

	local achList = vgui.Create("DIconLayout", achScroll)
	achList:DockMargin(16, 0, 0, 0)
	achList:Dock( FILL )
	achList:SetSpaceY(16)
	achList:SetSpaceX(8)

	for _, a in ipairs(GAMEMODE.Achievements) do
		local hasAch = table.HasValue(tblString, a.Name)
		
		local achPnl = vgui.Create("DPanel")
		achPnl:SetSize(192, 96)
		achPnl.Paint = function(self, w, h)
			draw.RoundedBox(8, 0, 0, w, h, HL2CR.Theme.achPnl)
		end

		local achIcon = vgui.Create("DImage", achPnl)

		if hasAch then
			achIcon:SetImage(a.Mat)
		else
			achIcon:SetImage("vgui/hud/icon_locked")
		end

		achIcon:SetSize(64, 64)

		local achLabel = vgui.Create("DLabel", achPnl)

		if hasAch then
			achLabel:SetText(translate.Get("QMenu_Ach_Name") .. a.Name)
		else
			achLabel:SetText(translate.Get("QMenu_Ach_Locked"))
		end

		achLabel:SetPos(64, 0)
		achLabel:SetFont("hl2cr_qmenu_ach_name")
		
		if hasAch then
			achLabel:SetText(translate.Get("QMenu_Ach_Name") .. a.Name)
		else
			achLabel:SetText(translate.Get("QMenu_Ach_Locked"))
		end
		achLabel:SizeToContents()

		local achDesc = vgui.Create("DLabel", achPnl)
		achDesc:SetPos(0, 64)
		achDesc:SetFont("hl2cr_qmenu_ach_desc")
		
		if hasAch then
			achDesc:SetText(a.Desc)
		else
			achDesc:SetText("")
		end

		achDesc:SizeToContents()

		achPnl:SetSize(string.len(a.Desc) * 1.5 + achPnl:GetWide(), achPnl:GetTall())

		achList:Add(achPnl)
	end

	return mainAchPanel
end

function SetActiveTab(index, tabs)
	for i, t in ipairs(tabs) do
		if i == index then
			t:SetVisible(true)
		else
			t:SetVisible(false)
		end
	end
end

function StartQMenu(toggleOpen)

    timeLastOpen = 0.3 + CurTime()

	if toggleOpen then 
		if not LocalPlayer():Alive() then return end -- simple fix w/o using "Think".
		if qMenuFrame and qMenuFrame:IsValid() then
			qMenuFrame:Remove()
            qMenuFrame = nil
		end
		qMenuFrame = vgui.Create("DFrame")
		qMenuFrame:SetSize(ScrW() / 1.5, ScrH() / 1.5)
		qMenuFrame:Center()
		qMenuFrame:MakePopup()
		qMenuFrame:SetTitle("")
		qMenuFrame:SetKeyboardInputEnabled(false)
		qMenuFrame:SetDraggable(false)
		qMenuFrame:ShowCloseButton(false)
        qMenuFrame.Paint = function(self, w, h) 
			draw.RoundedBoxEx(16, 0, 0, w, h, HL2CR.Theme.qMenuFrame, true, true, true, true)
		end

		/*qMenuFrame.Think = function()
			if not LocalPlayer():Alive() then
				toggleOpen = false
				qMenuFrame:Remove()
           	 	qMenuFrame = nil
			end
		end*/

		local qMenuTabHeader = vgui.Create("DPanel", qMenuFrame)
		qMenuTabHeader:SetSize(qMenuFrame:GetWide(), qMenuFrame:GetTall() * 0.112)
		qMenuTabHeader.Paint = function(self, w, h)
			draw.RoundedBoxEx(16, 0, 0, w, h, HL2CR.Theme.qMenuTab, true, true, false, false)
		end

		local qMenuTabs = vgui.Create("DPanel", qMenuFrame)
		qMenuTabs:SetSize(qMenuFrame:GetWide(), qMenuFrame:GetTall() - 80)
		qMenuTabs:SetPos(0, 80)
		qMenuTabs.Paint = function() return end

		qMenuTabs:Add(CreateMainPanel())
		qMenuTabs:Add(CreateSkillsPanel())
		qMenuTabs:Add(CreateShopPanel())
		qMenuTabs:Add(CreateAchPanel())

		local mainPnlBtn = vgui.Create("DButton", qMenuTabHeader)
		mainPnlBtn:Dock(LEFT)
		mainPnlBtn:SetSize(64, 32)
		mainPnlBtn:SetText(translate.Get("QMenu_Panels_Main"))
		
		mainPnlBtn.DoClick = function(self)
			SetActiveTab(1, qMenuTabs:GetChildren())
		end

		local skillsPnlBtn = vgui.Create("DButton", qMenuTabHeader)
		skillsPnlBtn:Dock(LEFT)
		skillsPnlBtn:SetSize(64, 32)
		skillsPnlBtn:SetText(translate.Get("QMenu_Panels_Skills"))
		
		skillsPnlBtn.DoClick = function(self)
			SetActiveTab(2, qMenuTabs:GetChildren())
		end

		local shopPnlBtn = vgui.Create("DButton", qMenuTabHeader)
		shopPnlBtn:SetSize(96, 32)
		shopPnlBtn:Dock(LEFT)
		shopPnlBtn:SetText(translate.Get("QMenu_Panels_Shop"))
		shopPnlBtn.DoClick = function(self)
			SetActiveTab(3, qMenuTabs:GetChildren())
		end

		local achPnlBtn = vgui.Create("DButton", qMenuTabHeader)
		achPnlBtn:SetSize(96, 32)
		achPnlBtn:Dock(LEFT)
		achPnlBtn:SetText(translate.Get("QMenu_Panels_Achievements"))
		
		achPnlBtn.DoClick = function(self)
			SetActiveTab(4, qMenuTabs:GetChildren())
		end

		SetActiveTab(1, qMenuTabs:GetChildren())

	else
		if qMenuFrame and qMenuFrame:IsValid() then
			qMenuFrame:Remove()
            qMenuFrame = nil
		end
	end
end

function GM:OnSpawnMenuOpen()
	StartQMenu(true)
end

function GM:OnSpawnMenuClose()
	StartQMenu(false)
end