
local scoreboard = scoreboard or nil

local function GetPlayerTeamColours(player)
	if player:Team() == 1 then
		--Alive
		return Color(90, 255, 105) 
	elseif player:Team() == 2 then
		--Completed Map
		return Color(250, 220, 0) 
	elseif player:Team() == 3 then
		--Dead
		return Color(185, 0, 0) 
	elseif player:Team() == 4 then
		--Loyal
		return Color(0, 255, 245) 
	elseif player:Team() == 5 then
		--AFK
		return Color(120, 120, 120) 
	else
		return Color(255, 255, 255)
	end
end

function ToggleBoard(toggle)
	if toggle then
		if not toggle and scoreboard:IsValid() then
			scoreboard:Remove()
			scoreboard = nil
		end
		scoreboard = vgui.Create("DFrame")
		scoreboard:SetSize(1000, 600)
		scoreboard:SetPos(ScrW() / 2 - 500, ScrH() / 15)
		scoreboard:SetVisible(true)
		scoreboard:ShowCloseButton(false)
		scoreboard:SetTitle("")
		scoreboard.Paint = function(self, w, h)
			draw.RoundedBoxEx(16, 0, 0, w, h, HL2CR.Theme.primary, false, false, true, true)
		end

		scoreboard:SetAlpha(0)
		scoreboard:AlphaTo(255, 0.30, 0, function() end)
		scoreboard:SetKeyboardInputEnabled(false)
		
		local titleLabel = vgui.Create("DLabel", scoreboard)
		titleLabel:SetText(GAMEMODE.ServerName)
		titleLabel:SetPos(0, 0)
		titleLabel:SetFont("hl2cr_scoreboard_title")
		titleLabel:SizeToContents()
		titleLabel:SetTextColor( Color(0, 0, 0) )
		
		local versionLabel = vgui.Create("DLabel", scoreboard)
		versionLabel:SetText(translate.Get("Scoreboard_Version") .. GAMEMODE.Version)
		versionLabel:SetPos(0, 70)
		versionLabel:SetFont("hl2cr_scoreboard_version")
		versionLabel:SizeToContents()
		versionLabel:SetTextColor( Color(0, 0, 0) )

		local mainPanel = vgui.Create("DPanel", scoreboard)
		mainPanel:SetPos(0, 100)
		mainPanel:SetSize(1000, 0)
		
		mainPanel:SizeTo(1000, 490, 0.35, 0.2, -1, function() end)
		
		mainPanel.Paint = function(self, w, h)
			draw.RoundedBoxEx(16, 0, 0, w, h, HL2CR.Theme.secondary, false, false, true, true)
		end
				
		local playerList = vgui.Create( "DIconLayout", mainPanel )
		playerList:SetPos(20, 10)
		playerList:SetSize(mainPanel:GetWide(), mainPanel:GetTall())
		playerList:SetSpaceY( 5 )
		playerList:SetSpaceX( 15 )
		
		
		for _, pl in ipairs(player.GetAll()) do
		
			local panel = playerList:Add("DPanel")
			panel:SetSize(225, 100)
			
			panel.Think = function(self)
				local statusColours = GetPlayerTeamColours(pl)
				panel:SetBackgroundColor(statusColours)
			end

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
			username:SetFont("hl2cr_scoreboard_player")
			username:SizeToContents()
			
			local playerStats = vgui.Create("DLabel", panel)
			playerStats:SetPos(80, 30)
			playerStats:SetTextColor( Color( 0, 0, 0) )
			playerStats:SetFont("hl2cr_scoreboard_stats")
			
			playerStats.Think = function()
				playerStats:SetText(translate.Get("Scoreboard_Player_Level") .. pl:GetNWInt("hl2cr_stat_level", -1) .. "\n" .. translate.Get("Scoreboard_Player_Exp") .. pl:GetNWInt("hl2cr_stat_exp", -1) .. "/" .. pl:GetNWInt("hl2cr_stat_expreq", 0))
				playerStats:SizeToContents()
			end

			local badgeXPos, badgeYPos = 30, 0
			local badgeSize = 24 

			if pl:IsSuperAdmin() then
				local adminBadge = vgui.Create( "DImageButton", panel )
				adminBadge:SetSize(badgeSize, badgeSize)
				adminBadge:SetPos(panel:GetWide() - badgeXPos, badgeYPos)
				adminBadge:SetImage( "icon16/award_star_gold_3.png" )
				adminBadge:SetToolTip(translate.Get("Scoreboard_Player_Status_SuperAdmin"))
				
			elseif pl:IsAdmin() then
				local adminBadge = vgui.Create( "DImageButton", panel )
				adminBadge:SetSize(badgeSize, badgeSize)
				adminBadge:SetPos(panel:GetWide() - badgeXPos, badgeYPos)
				adminBadge:SetImage( "icon16/award_star_gold_2.png" )
				adminBadge:SetToolTip(translate.Get("Scoreboard_Player_Status_Admin"))
			elseif pl:GetUserGroup() == "donator" then
				local donatorBadge = vgui.Create( "DImageButton", panel )
				donatorBadge:SetSize(badgeSize, badgeSize)
				donatorBadge:SetPos(panel:GetWide() -badgeXPos30, badgeYPos)
				donatorBadge:SetImage( "icon16/medal_bronze_3.png" )
				donatorBadge:SetToolTip(translate.Get("Scoreboard_Player_Status_Donator"))
				
			elseif pl:GetUserGroup() == "vip" then
				local vipBadge = vgui.Create( "DImageButton", panel )
				vipBadge:SetSize(badgeSize, badgeSize)
				vipBadge:SetPos(panel:GetWide() - badgeXPos, badgeYPos)
				vipBadge:SetImage( "icon16/medal_silver_3.png" )
				vipBadge:SetToolTip(translate.Get("Scoreboard_Player_Status_VIP"))
			
			elseif pl:GetUserGroup() == "vip+" then
				local vipExtraBadge = vgui.Create( "DImageButton", panel )
				vipExtraBadge:SetSize(badgeSize, badgeSize)
				vipExtraBadge:SetPos(panel:GetWide() - badgeXPos, badgeYPos)
				vipExtraBadge:SetImage( "icon16/medal_gold_3.png" )
				vipExtraBadge:SetToolTip(translate.Get("Scoreboard_Player_Status_VIPExtra"))
			end
						
			if LocalPlayer() != pl then
				local muteBtn = vgui.Create("DImageButton", panel)
				muteBtn:SetSize(32, 32)
				muteBtn:SetPos(panel:GetWide() - 30, 25	)
				
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
			playerPing:SetPos(0, 75)
			playerPing:SetText(translate.Get("Scoreboard_Player_Ping") .. pl:Ping())
			playerPing:SetTextColor( Color( 0, 0, 0) )
			playerPing:SetFont("hl2cr_scoreboard_stats")
			playerPing:SizeToContents()

			playerPing.Think = function(self)
				if not pl:IsValid() then
					panel:Remove()
					return
				end
				self:SetText(translate.Get("Scoreboard_Player_Ping") .. pl:Ping())	
				self:SizeToContents()
			end
		end
	elseif not toggle and scoreboard:IsValid() then
		scoreboard:Remove()
		scoreboard = nil
	end
end

hook.Add("ScoreboardShow", "HL2CR_ScoreboardShow", function()
	ToggleBoard(true)
	return false
end)

hook.Add("ScoreboardHide", "HL2CR_ScoreboardHide", function()
	ToggleBoard(false)
end)

hook.Add( "PlayerButtonDown", "HL2CR_Scoreboard_Mouse", function(ply, btn)
	if not scoreboard then return end

	if btn == 108 then
		scoreboard:MakePopup()
	end
end)