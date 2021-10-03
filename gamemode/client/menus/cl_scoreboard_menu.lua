function ToggleBoard(toggle)
	if toggle then
		scoreboard = vgui.Create("HL2CR_Tab")
		scoreboard:SetSize(1000, 650)
		scoreboard:SetPos(ScrW() / 2 - 500, ScrH() / 15)
		scoreboard:SetVisible(true)
		
		scoreboard:SetAlpha(0)
		scoreboard:AlphaTo(255, 0.30, 0, function() end)
		scoreboard:SetKeyboardInputEnabled(false)
		
		local titleLabel = vgui.Create("DLabel", scoreboard)
		titleLabel:SetText(GAMEMODE.ServerName)
		titleLabel:SetPos(0, 45)
		titleLabel:SetFont("HL2CR_Title")
		titleLabel:SizeToContents()
		titleLabel:SetTextColor( Color(0, 0, 0) )
		
		local mainPanel = vgui.Create("DPanel", scoreboard)
		mainPanel:SetPos(0, 103)
		mainPanel:SetSize(1000, 0)
		
		mainPanel:SizeTo(1000, 500, 0.35, 0.2, -1, function() end)
		
		mainPanel.Paint = function(self, w, h)
			surface.SetDrawColor(Color(250, 184, 12, 255))
			surface.DrawRect(0, 0, w, h)
		end
		
		local versionLabel = vgui.Create("DLabel", mainPanel)
		versionLabel:SetText(translate.Get("SCVersion") .. GAMEMODE.Version)
		versionLabel:SetPos(0, 460)
		versionLabel:SetFont("HL2CR_Title")
		versionLabel:SizeToContents()
		versionLabel:SetTextColor( Color(0, 0, 0) )
		
		local playerList = vgui.Create( "DIconLayout", mainPanel )
		playerList:SetPos(20, 10)
		playerList:SetSize(mainPanel:GetWide(), mainPanel:GetTall())
		playerList:SetSpaceY( 5 )
		playerList:SetSpaceX( 15 )
		
		for _, pl in pairs(player.GetAll()) do
			local statusColours = Color(255, 255, 255)
			
			if pl:Team() == 1 then
				--Alive
				statusColours = Color(90, 255, 105) 
			elseif pl:Team() == 2 then
				--Completed Map
				statusColours = Color(250, 220, 0) 
			elseif pl:Team() == 3 then
				--Dead
				statusColours = Color(185, 0, 0) 
			elseif pl:Team() == 4 then
				--Loyal
				statusColours = Color(0, 255, 245) 
			elseif pl:Team() == 5 then
				--AFK
				statusColours = Color(120, 120, 120) 
			end
			
			local panel = playerList:Add("DPanel")
			panel:SetSize(225, 75)
			panel:SetBackgroundColor(statusColours)
			
			
			local avatar = vgui.Create( "AvatarImage", panel )
			avatar:SetSize(75, 75)
			avatar:SetPos(0, 0)
			avatar:SetPlayer(pl, 92)
			
			local profileBtn = vgui.Create("DButton", avatar)
			profileBtn:SetText("")
			profileBtn:SetSize(75, 75)
			profileBtn.Paint = function() end
			profileBtn.DoClick = function()
				pl:ShowProfile()
			end
			
			local username = vgui.Create("DLabel", panel)
			username:SetPos(75, 0)
			username:SetTextColor( Color( 0, 0, 0) )
			username:SetText(pl:Nick())
			username:SetFont("HL2CR_Player")
			username:SizeToContents()
			
			local playerStats = vgui.Create("DLabel", panel)
			playerStats:SetPos(80, 20)
			playerStats:SetText(translate.Get("SCLevel") .. pl:GetNWInt("stat_level", -1) .. translate.Get("SCExprience") .. pl:GetNWInt("stat_exp", -1) .. "/" .. pl:GetNWInt("stat_reqexp", 0))
			playerStats:SetTextColor( Color( 0, 0, 0) )
			playerStats:SizeToContents()
			
			if LocalPlayer() != pl then
				local muteBtn = vgui.Create("DImageButton", panel)
				muteBtn:SetSize(16, 16)
				muteBtn:SetPos(panel:GetWide() - 20, 60)
				
				if pl:IsMuted() then
					muteBtn:SetImage("icon16/sound_mute.png")
				else
					muteBtn:SetImage("icon16/sound.png")
				end
				
				muteBtn.DoClick = function()
					if !pl:IsMuted() then
						pl:SetMuted( true )
						muteBtn:SetImage("icon16/sound_mute.png")
					else
						pl:SetMuted( false )
						muteBtn:SetImage("icon16/sound.png")
					end
				end
			end
		end
	elseif not toggle and scoreboard:IsValid() then
		scoreboard:Remove()
	end
end

hook.Add("ScoreboardShow", "HL2CR_ScoreboardShow", function()
	ToggleBoard(true)
	return false
end)


hook.Add("ScoreboardHide", "HL2CR_ScoreboardHide", function()
	ToggleBoard(false)
end)