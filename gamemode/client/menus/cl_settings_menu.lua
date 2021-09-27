function ShowSettingsMenu()
	local settingsFrame = vgui.Create("HL2CR_Tab")
	settingsFrame:SetSize(650, 450)
	settingsFrame:Center()
	settingsFrame:SetVisible(true)
	
	local settingsPnl = vgui.Create("DPanel", settingsFrame)
	settingsPnl:SetPos(0, 55)
	settingsPnl:SetSize(850, 500)
	
	settingsPnl.Paint = function(self, w, h)
		surface.SetDrawColor(Color(75, 75, 75, 255))
		surface.DrawRect(0, 0, w, h)
	end
	
	local playerSettingsPnl = vgui.Create("DPanel", settingsPnl)
	
	local playerDrawLabel = vgui.Create("DLabel", playerSettingsPnl)
	playerDrawLabel:SetText("Player Stat Draw Distance")
	playerDrawLabel:SetFont("HL2CR_Config_Option")
	playerDrawLabel:SizeToContents()
	playerDrawLabel:SetPos(50, 0)
	
	local playerDrawSlider = vgui.Create("DNumSlider", playerSettingsPnl)
	playerDrawSlider:SetPos(-25, -15)
	playerDrawSlider:SetSize(250, 100)
	playerDrawSlider:SetMinMax(50, 500)
	playerDrawSlider:SetValue(LocalPlayer():GetNWInt("config_playerdrawdist"))
	playerDrawSlider:SetDecimals(0)
	
	local playerEndMusicLabel = vgui.Create("DLabel", playerSettingsPnl)
	playerEndMusicLabel:SetText("Enable/Disable End Result Music")
	playerEndMusicLabel:SetFont("HL2CR_Config_Option")
	playerEndMusicLabel:SizeToContents()
	playerEndMusicLabel:SetPos(300, 0)
	
	local playerEndMusicBox = vgui.Create("DCheckBox", playerSettingsPnl)
	playerEndMusicBox:SetChecked(LocalPlayer():GetNWBool("config_shouldendmusicplay", false))
	playerEndMusicBox:SetPos(420, 25)
	playerEndMusicBox:SetSize(50, 50)
	
	local playerFontLabel = vgui.Create("DLabel", playerSettingsPnl)
	playerFontLabel:SetText("Player Font")
	playerFontLabel:SetFont("HL2CR_Config_Option")
	playerFontLabel:SizeToContents()
	playerFontLabel:SetPos(25, 125)
	
	local playerFontChoice = vgui.Create("DComboBox", playerSettingsPnl)
	playerFontChoice:AddChoice("Default")
	--playerFontChoice:AddChoice("Alive in Science Fiction-thin")
	playerFontChoice:AddChoice("FancyShmancy")
	playerFontChoice:AddChoice("EasyHorror")
	playerFontChoice:SetValue(LocalPlayer():GetNWString("config_playerfont", "Default"))
	playerFontChoice:SetPos(25, 150)
	playerFontChoice:SetSize(100, 25)
	
	local npcSettingsPnl = vgui.Create("DPanel", settingsPnl)
	
	local npcDrawLabel = vgui.Create("DLabel", npcSettingsPnl)
	npcDrawLabel:SetText("NPC Stat Draw Distance")
	npcDrawLabel:SetFont("HL2CR_Config_Option")
	npcDrawLabel:SizeToContents()
	npcDrawLabel:SetPos(0, 0)
	
	local npcDrawSlider = vgui.Create("DNumSlider", npcSettingsPnl)
	npcDrawSlider:SetPos(-50, -15)
	npcDrawSlider:SetSize(250, 100)
	npcDrawSlider:SetMinMax(50, 500)
	npcDrawSlider:SetValue(LocalPlayer():GetNWInt("config_npcdrawdist"))
	npcDrawSlider:SetDecimals(0)
	
	local npcColourLabelOne = vgui.Create("DLabel", npcSettingsPnl)
	npcColourLabelOne:SetText("NPC Easy Color \t NPC Medium Color")
	npcColourLabelOne:SetFont("HL2CR_Config_Option")
	npcColourLabelOne:SizeToContents()
	npcColourLabelOne:SetPos(250, 0)
	
	local npcColourLabelTwo = vgui.Create("DLabel", npcSettingsPnl)
	npcColourLabelTwo:SetText("NPC Hard Color")
	npcColourLabelTwo:SetFont("HL2CR_Config_Option")
	npcColourLabelTwo:SizeToContents()
	npcColourLabelTwo:SetPos(250, 175)
	
	local npcColourEasy = vgui.Create("DColorMixer", npcSettingsPnl)
	npcColourEasy:SetPos(250, 25)
	npcColourEasy:SetSize(125, 125)
	npcColourEasy:SetPalette(false)
	npcColourEasy:SetAlphaBar(false)
	npcColourEasy:SetWangs(false)
	npcColourEasy:SetColor(string.ToColor(LocalPlayer():GetNWString("config_npccolours_easy")))	
	
	local npcColourMedium = vgui.Create("DColorMixer", npcSettingsPnl)
	npcColourMedium:SetPos(400, 25)
	npcColourMedium:SetSize(125, 125)
	npcColourMedium:SetPalette(false)
	npcColourMedium:SetAlphaBar(false)
	npcColourMedium:SetWangs(false)
	npcColourMedium:SetColor(string.ToColor(LocalPlayer():GetNWString("config_npccolours_medium")))	
	
	local npcColourHard = vgui.Create("DColorMixer", npcSettingsPnl)
	npcColourHard:SetPos(250, 200)
	npcColourHard:SetSize(125, 125)
	npcColourHard:SetPalette(false)
	npcColourHard:SetAlphaBar(false)
	npcColourHard:SetWangs(false)
	npcColourHard:SetColor(string.ToColor(LocalPlayer():GetNWString("config_npccolours_hard")))	
	
	local npcColorResetBtn = vgui.Create("DButton", npcSettingsPnl)
	npcColorResetBtn:SetText("Reset Colors")
	npcColorResetBtn:SetPos(425, 200)
	npcColorResetBtn:SetSize(75, 50)
	
	npcColorResetBtn.DoClick = function()
		npcColourEasy:SetColor(Color(0, 255, 0, 255))
		npcColourMedium:SetColor(Color(255, 255, 0, 255))
		npcColourHard:SetColor(Color(255, 0, 0, 255))
	end
	
	local npcFontLabel = vgui.Create("DLabel", npcSettingsPnl)
	npcFontLabel:SetText("NPC Font")
	npcFontLabel:SetFont("HL2CR_Config_Option")
	npcFontLabel:SizeToContents()
	npcFontLabel:SetPos(25, 125)
	
	local npcFontChoice = vgui.Create("DComboBox", npcSettingsPnl)
	npcFontChoice:AddChoice("Default")
	--npcFontChoice:AddChoice("Alive in Science Fiction-thin")
	npcFontChoice:AddChoice("FancyShmancy")
	npcFontChoice:AddChoice("EasyHorror")
	npcFontChoice:SetValue(LocalPlayer():GetNWString("config_npcfont", "Default"))
	npcFontChoice:SetPos(25, 150)
	npcFontChoice:SetSize(100, 25)
	
	local applySettingsPnl = vgui.Create("DPanel", settingsPnl)
	
	settingsFrame.navbar:AddTab("Player", playerSettingsPnl)
	settingsFrame.navbar:AddTab("NPC", npcSettingsPnl)
	settingsFrame.navbar:AddTab("Apply", applySettingsPnl)
	
	settingsFrame.navbar:SetActive(1)
	
	settingsFrame.Think = function(pnl)
		if pnl.navbar:GetActive() == applySettingsPnl then
			net.Start("HL2CR_ApplySettings")
				--Player settings
				net.WriteInt(math.Round(playerDrawSlider:GetValue()), 32)
				net.WriteBool(playerEndMusicBox:GetChecked())
				net.WriteString(playerFontChoice:GetSelected() or LocalPlayer():GetNWString("config_playerfont"))
				
				--NPC settings
				net.WriteInt(math.Round(npcDrawSlider:GetValue()), 32)
				net.WriteString(npcFontChoice:GetSelected() or LocalPlayer():GetNWString("config_npcfont"))
				
				local convertColorEasy = npcColourEasy:GetColor().r .. " " .. npcColourEasy:GetColor().g .. " " .. npcColourEasy:GetColor().b .. " 255"
				local convertColorMedium = npcColourMedium:GetColor().r .. " " .. npcColourMedium:GetColor().g .. " " .. npcColourMedium:GetColor().b .. " 255"
				local convertColorHard = npcColourHard:GetColor().r .. " " .. npcColourHard:GetColor().g .. " " .. npcColourHard:GetColor().b .. " 255"
				
				net.WriteString(convertColorEasy)
				net.WriteString(convertColorMedium)
				net.WriteString(convertColorHard)
			net.SendToServer()
			pnl:Remove()
		end
	end
end


net.Receive("HL2CR_SettingsMenu", function()
	ShowSettingsMenu()
end)