
local function GetPlayerTeamColours(player)
	if player:Team() == TEAM_ALIVE then
		--Alive
		return Color(90, 255, 105,160) 
	elseif player:Team() == TEAM_COMPLETED_MAP then
		--Completed Map
		return Color(250, 220, 0,160) 
	elseif player:Team() == TEAM_DEAD then
		--Dead
		return Color(210, 30, 30,160) 
	elseif player:Team() == TEAM_LOYAL then
		--Loyal
		return Color(0, 255, 245,160) 
	elseif player:Team() == TEAM_AFK then
		--AFK
		return Color(120, 120, 120,160) 
	else
		return Color(255, 255, 255,160)
	end
end

local PANEL = {}

function PANEL:Init()
	self:SetVisible( true )
	self.ply = nil
end

function PANEL:SetPlayer(ply)
	self.ply = ply
	
	local tall = self:GetTall()
	local avatar = vgui.Create( "AvatarImage", self )
	avatar:SetSize(tall * 0.7, tall * 0.7)
	avatar:SetPos(tall * 0.05, tall * 0.05)
	avatar:SetPlayer(self.ply, 128)
	self:SetMouseInputEnabled( true )
	avatar.OnMousePressed = function( )
		if input.IsMouseDown( MOUSE_LEFT ) and !self.ply:IsBot() then self.ply:ShowProfile() end
	end
	
	local NameText = New_ThemeText(self,tall * 0.78, tall  * 0.15,self.ply:Nick(),"Font2_Small",0,0.5)
	
	if !self.ply:IsBot() then
	
		local Text = New_ThemeText(self,tall * 0.78, tall  * 0.4,"","Font2_Tiny",0,0.5)
		Text.Think = function()
				local text = translate.Get("Scoreboard_Player_Level") .. self.ply:GetNWInt("hl2cr_stat_level", -1)
				Text:SetText(text,nil,0,0.5)
			end
		local Text = New_ThemeText(self,tall * 0.78, tall  * 0.60,"","Font2_Tiny",0,0.5)
		Text.Think = function()
				local text = translate.Get("Scoreboard_Player_Exp") .. self.ply:GetNWInt("hl2cr_stat_exp", -1) .. "/" .. self.ply:GetNWInt("hl2cr_stat_expreq", 0)
				Text:SetText(text,nil,0,0.5)
			end
		local Text = New_ThemeText(self,tall * 0.05, tall  * 0.96,"","Font2_Small",0,1)
		Text.Think = function()
			local ping = self.ply:Ping()
				local text = translate.Get("Scoreboard_Player_Ping") .. ping
				Text:SetText(text,nil,0,1)
				if ping > 300 then Text:SetColour(Color(255, 100, 100,255),Color(100, 30, 30,255) )
				elseif ping > 100 then Text:SetColour(Color(255, 255, 100,255),Color(100, 100, 30,255) ) 
				else Text:SetColour(Theme.fontcol,Theme.fontcolout )  end
			end
		
			if LocalPlayer() != self.ply then
				local muteBtn = vgui.Create("DImageButton", self)
				muteBtn:SetSize(tall * 0.25, tall * 0.25)
				muteBtn:SetPos(self:GetWide() - tall * 0.27, tall * 0.25	)
				
				if self.ply:IsMuted() then
					muteBtn:SetImage( "icon32/muted.png" )
				else
					muteBtn:SetImage( "icon32/unmuted.png" )
				end
				
				muteBtn.DoClick = function()
					if !self.ply:IsMuted() then
						self.ply:SetMuted( true )
						muteBtn:SetImage( "icon32/muted.png" )
					else
						self.ply:SetMuted( false )
						muteBtn:SetImage( "icon32/unmuted.png" )
					end
				end
			end	
	
			local Badge = vgui.Create( "DImageButton", self )
			Badge:SetSize(tall * 0.25, tall * 0.25)
			Badge:SetPos(self:GetWide() - tall * 0.27, 0)
			
			if self.ply:IsSuperAdmin() then
				Badge:SetImage( "icon16/award_star_gold_3.png" )
				Badge:SetToolTip(translate.Get("Scoreboard_Player_Status_SuperAdmin"))
				NameText.Think = function()
					NameText:SetColour(GetColour(89, 255),Color(50, 50, 50,255) )
				end
			elseif self.ply:IsAdmin() then
				Badge:SetImage( "icon16/award_star_gold_2.png" )
				Badge:SetToolTip(translate.Get("Scoreboard_Player_Status_Admin"))
				NameText:SetColour(GetColour(9, 255),Color(100, 50, 20,255) )
			elseif self.ply:GetUserGroup() == "donator" then
				Badge:SetImage( "icon16/medal_bronze_3.png" )
				Badge:SetToolTip(translate.Get("Scoreboard_Player_Status_Donator"))
			elseif self.ply:GetUserGroup() == "vip" then
				Badge:SetImage( "icon16/medal_silver_3.png" )
				Badge:SetToolTip(translate.Get("Scoreboard_Player_Status_VIP"))
			elseif self.ply:GetUserGroup() == "vip+" then
				Badge:SetImage( "icon16/medal_gold_3.png" )
				Badge:SetToolTip(translate.Get("Scoreboard_Player_Status_VIPExtra"))
			end
			
			
			if self.ply.games then
				local icon = New_ThemeGameIcon(self,self:GetWide() - tall * 0.80,tall * 0.83,tall * 0.15,tall * 0.15,220,self.ply.games[220])	--HL2
				local icon = New_ThemeGameIcon(self,self:GetWide() - tall * 0.64,tall * 0.83,tall * 0.15,tall * 0.15,380,self.ply.games[380])	--EP1
				local icon = New_ThemeGameIcon(self,self:GetWide() - tall * 0.48,tall * 0.83,tall * 0.15,tall * 0.15,420,self.ply.games[420])	--EP2
				local icon = New_ThemeGameIcon(self,self:GetWide() - tall * 0.32,tall * 0.83,tall * 0.15,tall * 0.15,340,self.ply.games[340])	--LostCoast
				local icon = New_ThemeGameIcon(self,self:GetWide() - tall * 0.16,tall * 0.83,tall * 0.15,tall * 0.15,240,self.ply.games[240])	--CSS
				
				if self.ply.games[251110] > 0 then	--Bonus to show if people own INFRA, If you can read this, buy INFRA
					local icon = New_ThemeGameIcon(self,self:GetWide() - tall * 0.96,tall * 0.83,tall * 0.15,tall * 0.15,251110,self.ply.games[251110])
				end
			end
	
	else
		local Text = New_ThemeText(self,tall * 0.05, tall  * 0.96,"Bot","Font2_Small",0,1)
	end
end

function PANEL:Paint()
	if self.ply then
		draw.RoundedBoxEx(8, 0, 0, self:GetWide(), self:GetTall()*0.28, GetPlayerTeamColours(self.ply),true,true,false,false)
		draw.RoundedBoxEx(8, 0, self:GetTall()*0.28, self:GetWide(), self:GetTall()*0.72, Color(50, 50, 50,160) ,false,false,true,true)
	end
	return true
end
vgui.Register( "HL2CR_PlayerPanel", PANEL, "Panel" )

local function New_PlayerPanel(parent,xpos,ypos,wide,tall,ply)
	local element = vgui.Create( "HL2CR_PlayerPanel" , parent)
	element:SetSize( wide, tall)
	element:SetPos( xpos, ypos)
	element:SetPlayer( ply)
	
	return element
end

local PANEL = {}

function PANEL:Init()
	local varH = ScrH() * 0.6
	local varW = varH * 1.8
	self:SetPos( (ScrW()- varW)*0.5, (ScrH()- varH)*0.25)
	self:SetSize( varW, varH )
	
	local wide = math.floor(self:GetWide())
	local tall = math.floor(self:GetTall())
	
	local Text = New_ThemeText(self,wide * 0.02, tall * 0.01,GAMEMODE.ServerName,"Font_Normal",0,0)

	local Text = New_ThemeText(self,wide * 0.02, tall * 0.09,translate.Get("Scoreboard_Version") .. GAMEMODE.Version,"Font_Small",0,0)

	self.PlayerPanel = New_ThemeVertScroll(self,wide * 0.02,tall * 0.18,wide * 0.96,tall * 0.79)
	
	local panW = wide * 0.30
	local panH = tall * 0.22
	local maxy = 0 
	for i, pl in ipairs(player.GetAll()) do
		local panX = wide * 0.01 + ((i-1) % 3) * panW * 1.02
		local panY = wide * 0.01 + math.floor((i-1) / 3) * panH * 1.05
		local PlayerPane = New_PlayerPanel(self.PlayerPanel, panX,panY,panW,panH,pl)
		if maxy < panY + panH then maxy = panY + panH end
	end
	self.PlayerPanel:UpdateMaxY(maxy + wide * 0.01 )
	
	--local Text = New_ThemeText(PlayerPanel,wide * 0.02, tall * 0.02,"hello suckas","Font_Normal",0,0)

	self:SetVisible( true )
end

function PANEL:Paint()

	local wide = math.floor(self:GetWide())
	local tall = math.floor(self:GetTall())

	draw.RoundedBoxEx( 8, 0, 0, self:GetWide(), self:GetTall() * 0.08, Theme.backcol,true, true,false,false)
	
	draw.RoundedBoxEx( 1, 0, self:GetTall() * 0.08, self:GetWide(), self:GetTall() * 0.07, Theme.backcol2,false, false,false,false)
	draw.RoundedBoxEx( 1, 0, self:GetTall() * 0.15, self:GetWide(), self:GetTall() * 0.03, Theme.backcol,false, false,false,false)
	draw.RoundedBoxEx( 1, 0, self.PlayerPanel:GetY(), self.PlayerPanel:GetX(), self.PlayerPanel:GetTall(), Theme.backcol,false, false,false,false)
	draw.RoundedBoxEx( 1, self.PlayerPanel:GetX() + self.PlayerPanel:GetWide(), self.PlayerPanel:GetY(), self.PlayerPanel:GetX()+1, self.PlayerPanel:GetTall(), Theme.backcol,false, false,false,false)
	--draw.RoundedBoxEx( 1, 0, self:GetTall() * 0.15, self:GetWide(), self:GetTall() * 0.85, Theme.backcol,false,false,false,false)
	draw.RoundedBoxEx( 8, 0, self.PlayerPanel:GetTall() + self.PlayerPanel:GetY(), self:GetWide(), tall * 0.03, Theme.backcol,false,false,true,true)
	
	return true
end
vgui.Register( "HL2CR_Scoreboard", PANEL, "Panel" )

function ToggleBoard(toggle)
	if toggle then
		if not toggle and GAMEMODE.scoreboard then
			GAMEMODE.scoreboard:Remove()
			--scoreboard = nil
		end
		
		if ( GAMEMODE.HelpMenu ) then GAMEMODE.HelpMenu:Remove() gui.EnableScreenClicker( false ) end
		
		--if true then 
		GAMEMODE.scoreboard  = vgui.Create("HL2CR_Scoreboard")
		--end
		--[[ old scoreboard
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
		]]--
	elseif GAMEMODE.scoreboard then
		GAMEMODE.scoreboard:Remove()
		--scoreboard = nil
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
	if not IsValid(GAMEMODE.scoreboard) then return end

	if btn == 108 then
		GAMEMODE.scoreboard:MakePopup()
	end
end)