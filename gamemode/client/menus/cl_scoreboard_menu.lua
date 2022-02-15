
function ToggleBoard(toggle)
	if toggle then
		local convertNumToLanguage = {
			[1] = translate.Get("DiffVEasy"),
			[2] = translate.Get("DiffEasy"),
			[3] = translate.Get("DiffMedium"),
			[4] = translate.Get("DiffHard"),
			[5] = translate.Get("DiffVHard")
		}
		
		local convertNumToSize = {
			[1] = 600,
			[2] = 675,
			[3] = 625,
			[4] = 675,
			[5] = 600,
		}
		
		scoreboard = vgui.Create("HL2CR_Tab")
		scoreboard:SetSize(1000, 650)
		scoreboard:SetPos(ScrW() / 2 - 500, ScrH() / 15)
		scoreboard:SetVisible(true)
		
		scoreboard:SetAlpha(0)
		scoreboard:AlphaTo(255, 0.30, 0, function() end)
		scoreboard:SetKeyboardInputEnabled(false)
		
		local titleLabel = vgui.Create("DLabel", scoreboard)
		titleLabel:SetText(GAMEMODE.ServerName)
		titleLabel:SetPos(0, 55)
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
		versionLabel:SetPos(5, 460)
		versionLabel:SetFont("HL2CR_Title")
		versionLabel:SizeToContents()
		versionLabel:SetTextColor( Color(0, 0, 0) )

		local surv = vgui.Create("DLabel", mainPanel)
		if GetConVar("hl2cr_survival"):GetInt() == 1 then
			surv:SetText(translate.Get("SurvIsOn"))
		else
			surv:SetText(translate.Get("SurvIsOff"))
		end
		
		surv:SetPos(805, 460)
		surv:SetFont("HL2CR_Title")
		surv:SizeToContents()
		surv:SetTextColor( Color(0, 0, 0) )

		local diff = vgui.Create("DLabel", mainPanel)
		diff:SetText(translate.Get("DifficultyLevel") .. convertNumToLanguage[GetConVar("hl2cr_difficulty"):GetInt()])
		diff:SetPos(convertNumToSize[GetConVar("hl2cr_difficulty"):GetInt()], 420)
		diff:SetFont("HL2CR_Title")
		diff:SizeToContents()
		diff:SetTextColor( Color(0, 0, 0) )
		
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
			
			if pl:IsSuperAdmin() then
				local adminBadge = vgui.Create( "DImageButton", panel )
				adminBadge:SetSize(18, 18)
				adminBadge:SetPos(panel:GetWide() - 20, 0)
				adminBadge:SetImage( "icon16/award_star_gold_3.png" )
				adminBadge:SetToolTip(translate.Get("SuperAdmin"))
				
			elseif pl:IsAdmin() then
				local adminBadge = vgui.Create( "DImageButton", panel )
				adminBadge:SetSize(18, 18)
				adminBadge:SetPos(panel:GetWide() - 30, 0)
				adminBadge:SetImage( "icon16/award_star_gold_2.png" )
				adminBadge:SetToolTip(translate.Get("Admin"))
			end
			if pl:GetUserGroup() == "donator" then
				local donatorBadge = vgui.Create( "DImageButton", panel )
				donatorBadge:SetSize(18, 18)
				donatorBadge:SetPos(panel:GetWide() - 30, 0)
				donatorBadge:SetImage( "icon16/medal_bronze_3.png" )
				donatorBadge:SetToolTip(translate.Get("Donator"))
				
			elseif pl:GetUserGroup() == "vip" then
				local vipBadge = vgui.Create( "DImageButton", panel )
				vipBadge:SetSize(18, 18)
				vipBadge:SetPos(panel:GetWide() - 30, 0)
				vipBadge:SetImage( "icon16/medal_silver_3.png" )
				vipBadge:SetToolTip(translate.Get("VIP"))
			
			elseif pl:GetUserGroup() == "vip+" then
				local vipExtraBadge = vgui.Create( "DImageButton", panel )
				vipExtraBadge:SetSize(18, 18)
				vipExtraBadge:SetPos(panel:GetWide() - 30, 0)
				vipExtraBadge:SetImage( "icon16/medal_gold_3.png" )
				vipExtraBadge:SetToolTip(translate.Get("VIPExtra"))
			end
			
			if ALPHA_TESTERS[pl:SteamID()] then
				local testerBadge = vgui.Create( "DImageButton", panel )
				testerBadge:SetSize(18, 18)
				testerBadge:SetPos(panel:GetWide() - 60, 0)
				testerBadge:SetImage( "icon16/bug.png" )
				testerBadge:SetToolTip(translate.Get("AlphaTester"))
			end
			
			if LocalPlayer() != pl then
				local muteBtn = vgui.Create("DImageButton", panel)
				muteBtn:SetSize(32, 32)
				muteBtn:SetPos(panel:GetWide() - 30, 45	)
				
				if pl:IsMuted() then
					muteBtn:SetImage( "icon32/muted.png" )
				else
					muteBtn:SetImage( "icon32/unmuted.png" )
				end

				muteBtn.PaintOver = function( s, w, h )
					if ( !IsValid( pl ) ) then return end
				
					local a = 255 - math.Clamp( CurTime() - ( s.LastTick or 0 ), 0, 3 ) * 255
					if ( a <= 0 ) then return end
					
					draw.RoundedBox( 4, 0, 0, muteBtn:GetSize()/1.05, muteBtn:GetSize()/1.05, Color( 0, 0, 0, a * 0.75 ) )
					draw.SimpleText( math.ceil( pl:GetVoiceVolumeScale() * 100 ) .. "%", "DermaDefault", muteBtn:GetSize()/2, muteBtn:GetSize()/2, Color( 255, 255, 255, a ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end

				muteBtn.OnMouseWheeled = function( s, delta )
					pl:SetVoiceVolumeScale( pl:GetVoiceVolumeScale() + ( delta / 100 * 5 ) )
					s.LastTick = CurTime()
				end
				
				muteBtn.DoClick = function()
					if !pl:IsMuted() then
						pl:SetMuted( true )
						muteBtn:SetImage( "icon32/muted.png" )
					else
						pl:SetMuted( false )
						muteBtn:SetImage( "icon32/unmuted.png" )
					end
				end
			end
			
			local playerPing = vgui.Create("DLabel", panel)
			playerPing:SetPos(80, 57)
			playerPing:SetText(translate.Get("Ping") .. pl:Ping())
			playerPing:SetTextColor( Color( 0, 0, 0) )
			playerPing:SizeToContents()

			playerPing.Think = function(self)
				self:SetText(translate.Get("Ping") .. pl:Ping())	
				self:SizeToContents()
			end

			local playerclass = vgui.Create("DLabel", panel)
			playerclass:SetPos(80, 45)
			playerclass:SetTextColor( Color( 0, 0, 0) )
			playerclass:SetText(translate.Get("PlayerClass") .. pl:GetNWString("stat_curclass"))
			playerclass:SizeToContents()

			local playercountry = vgui.Create("DLabel", panel)
			playercountry:SetPos(210, 63)
			playercountry:SetTextColor( Color( 0, 0, 0) )
			playercountry:SetText(system.GetCountry())
			playercountry:SizeToContents()
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