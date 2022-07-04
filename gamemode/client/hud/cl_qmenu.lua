
local toggleOpen = false
local timeLastOpen = 0
local qMenuFrame = nil

local function CreateMainPanel()
	local mainPnl = vgui.Create("DPanel")
	mainPnl:SetSize(qMenuFrame:GetWide(), qMenuFrame:GetTall() - 100)
	mainPnl:SetPos(0, 50)
	mainPnl.Paint = function(self, w, h) return end

	-- playermodel panel
	local mainPnlPlayer = vgui.Create("DPanel", mainPnl)
	mainPnlPlayer:SetPos(15, -mainPnl:GetTall() / 22 + 200)
	mainPnlPlayer:SetSize(mainPnl:GetWide() / 4.2, mainPnl:GetTall() - 20)
	mainPnlPlayer.Paint = function(self, w, h)
		draw.RoundedBoxEx(8, 0, 0, w, h, HL2CR.Theme.qMenuPlayer, true, true, false, false)
	end
	
	local mainPnlPlayerModel = vgui.Create("DModelPanel", mainPnlPlayer)
	mainPnlPlayerModel:SetSize(mainPnlPlayer:GetWide(), mainPnlPlayer:GetTall())
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

	local eyepos = mainPnlPlayerModel.Entity:GetBonePosition(mainPnlPlayerModel.Entity:LookupBone("ValveBiped.Bip01_Head1"))

	eyepos:Add(Vector(0, 0, -2))

	mainPnlPlayerModel:SetLookAt(eyepos)
	mainPnlPlayerModel.Entity:SetPos(mainPnlPlayerModel.Entity:GetPos() + Vector(0, 0, 10))
	mainPnlPlayerModel:SetCamPos(eyepos - Vector(-20, 0, 0))

	function mainPnlPlayerModel:LayoutEntity(ent)
		if self.bAnimated then self:RunAnimation() end

		if self.Pressed then
			local mx, my = input.GetCursorPos()
			self.Angles = self.Angles - Angle(0,((self.PressX or mx) - mx) / 2, 0)

			self.PressX, self.PressY = input.GetCursorPos()
		end

		ent:SetAngles(self.Angles)
	end

	local playerGenderCombo = vgui.Create( "DComboBox", mainPnlPlayer )
	playerGenderCombo:SetPos( 0, 20 )
	playerGenderCombo:SetSize( 100, 20 )
	playerGenderCombo:SetValue( "Select Gender" )
	playerGenderCombo:AddChoice( "Male" )
	playerGenderCombo:AddChoice( "Female" )
	playerGenderCombo.OnSelect = function( self, index, value )
		net.Start("HL2CR_Model_Update")
			net.WriteString("")
			net.WriteString(string.lower(value))
		net.SendToServer()
	end

	return mainPnl
end


local function CreateSkillsPanel()
	local skills = LocalPlayer():GetNWString("hl2cr_stat_skills", "")
	local skillPoints = LocalPlayer():GetNWInt("hl2cr_stat_skillpoints", -1)

	local dragPnl = vgui.Create("HL2CR_DraggablePanel")
	dragPnl:SetSize(qMenuFrame:GetWide(), qMenuFrame:GetTall())

	dragPnl.Paint = function(self, w, h) 
		surface.SetDrawColor(HL2CR.Theme.qMenuSkills)
		surface.DrawRect(0, 0, w, h)
	end

	local client_skillinfo = {}

	for i, s in ipairs(HL2CR_Skills) do
		local panel = vgui.Create("DPanel", dragPnl)
		panel:SetSize(128, 128)
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
		skillInfoCost:SetPos(36, 12)
		skillInfoCost:SetTextColor(Color(255, 255, 255))
		skillInfoCost:SizeToContents()

		local skillBtn = vgui.Create("DImageButton", panel)
		skillBtn:SetSize(panel:GetWide() - 48, panel:GetTall() - 48)
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

function SetActiveTab(index, tabs)
	for i, t in ipairs(tabs) do
		if i == index then
			t:SetVisible(true)
		else
			t:SetVisible(false)
		end
	end
end

function StartQMenu()
	if LocalPlayer():Team() == 3 then return end
    timeLastOpen = 0.3 + CurTime()

	if toggleOpen then 
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

		qMenuFrame.Think = function()
			if not LocalPlayer():Alive() then
				toggleOpen = false
				qMenuFrame:Remove()
           	 	qMenuFrame = nil
			end
		end

		local qMenuTabHeader = vgui.Create("DPanel", qMenuFrame)
		qMenuTabHeader:SetSize(qMenuFrame:GetWide(), 80)
		qMenuTabHeader.Paint = function(self, w, h)
			draw.RoundedBoxEx(16, 0, 0, w, h, HL2CR.Theme.qMenuTab, true, true, false, false)
		end

		local qMenuTabs = vgui.Create("DPanel", qMenuFrame)
		qMenuTabs:SetSize(qMenuFrame:GetWide(), qMenuFrame:GetTall() - 80)
		qMenuTabs:SetPos(0, 80)
		qMenuTabs.Paint = function() return end

		qMenuTabs:Add(CreateMainPanel())
		qMenuTabs:Add(CreateSkillsPanel())

		local mainPnlBtn = vgui.Create("DButton", qMenuTabHeader)
		mainPnlBtn:SetPos(0, 30)
		mainPnlBtn:SetSize(64, 32)
		mainPnlBtn:SetText(translate.Get("QMenu_Panels_Main"))
		
		mainPnlBtn.DoClick = function(self)
			SetActiveTab(1, qMenuTabs:GetChildren())
		end

		local skillsPnlBtn = vgui.Create("DButton", qMenuTabHeader)
		skillsPnlBtn:SetPos(64, 30)
		skillsPnlBtn:SetSize(64, 32)
		skillsPnlBtn:SetText(translate.Get("QMenu_Panels_Skills"))
		
		skillsPnlBtn.DoClick = function(self)
			SetActiveTab(2, qMenuTabs:GetChildren())
		end

		SetActiveTab(1, qMenuTabs:GetChildren())

	else
		if qMenuFrame and qMenuFrame:IsValid() then
			qMenuFrame:Remove()
            qMenuFrame = nil
		end
	end
end

hook.Add( "PlayerButtonDown", "HL2CR_Q_Press", function(ply, btn)
	if btn == KEY_Q then
        if timeLastOpen > CurTime() then return end
        
        if toggleOpen then
            toggleOpen = false
        else
            toggleOpen = true
        end

        StartQMenu()
    end
end )