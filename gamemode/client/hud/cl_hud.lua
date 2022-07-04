local client_maps_no_suit = {
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true
}

local client_hidehud = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudChat"] = true
}

local function DisplayChatMessage(message)
	chat.AddText(unpack(message))
end

local function PlayLocalSound(soundPath)
	surface.PlaySound(soundPath)
end

local function PlayUniqueLocalSound(soundName, setPitch)
	sound.Add( {
		name = "hl2cr_custom_sound",
		channel = CHAN_STATIC,
		volume = 1.0,
		level = 80,
		pitch = setPitch,
		sound = soundName
	} )

	LocalPlayer():EmitSound("hl2cr_custom_sound")
end

local start, oldXP, newXP = SysTime(), -1, -1
local barW = 200
local animationTime = 1.0
local lastUpdate = 0
local fadeOut = 255

hook.Add( "HUDPaint", "HL2CR_XPBar", function()

	if client_maps_no_suit[game.GetMap()] or (game.GetMap() == "d1_trainstation_05" and not GetGlobalBool("HL2CR_GLOBAL_SUIT")) then
		return 
	end

	if ( !IsValid( LocalPlayer() ) ) then return end

	if ( oldXP == nil and newXP == nil ) then
		oldXP = xp
		newXP = xp
	end
	
	if newXP == nil then return end
	
	if lastUpdate < CurTime() then 
		if fadeOut > 75 then
			fadeOut = fadeOut - 1
		end
	end

	local xp = LocalPlayer():GetNWInt("hl2cr_stat_exp")
	local reqXP = LocalPlayer():GetNWInt("hl2cr_stat_expreq")

	local smoothNewXP = 0
	
	local smoothXP = Lerp( (SysTime() - start) / animationTime, oldXP, newXP )

	if newXP ~= xp then
		fadeOut = 255
		oldXP = newXP
		start = SysTime()
		newXP = xp
	end

	//Empty
	draw.RoundedBox( 4, ScrW() / 2.55, ScrH() - 80, barW, 45, Color(0, 0, 0, fadeOut) )

	//Fill
	draw.RoundedBox( 4, ScrW() / 2.55, ScrH() - 80, math.max( 0, smoothXP ) / reqXP * barW, 45, Color(255, 174, 0, fadeOut) )
	
	//Text
	draw.SimpleText(translate.Get("HUD_Stat_XP"), "hl2cr_hud_xp", ScrW() / 2.55, ScrH() - 55, Color(255, 200, 0, fadeOut), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end )


net.Receive("HL2CR_MsgSound", function()
	PlayLocalSound(net.ReadString())
end)

net.Receive("HL2CR_MsgPitchSound", function()
	PlayUniqueLocalSound(net.ReadString(), net.ReadInt(32))
end)

net.Receive("HL2CR_ChatMessage", function()
	DisplayChatMessage( net.ReadTable() )
end)

local curXPNotify = {}

net.Receive("HL2CR_Update_XP", function()
	lastUpdate = 6 + CurTime()
	
	newXP = net.ReadInt(32)

	local xpText = vgui.Create("DLabel", xpPopup)
	xpText:SetPos(ScrW() / 2.40, ScrH() - 115)
	xpText:SetText(translate.Get("HUD_Stat_XP") .. ": " .. newXP)
	xpText:SetTextColor(Color(255, 200, 0))
	xpText:SetFont("hl2cr_hud_xp")
	xpText:SizeToContents()

	table.insert(curXPNotify, xpText)

	xpText:MoveTo( ScrW() / 2.40, ScrH() - 125 - (25 * #curXPNotify), 1, 0, -1, function()
		xpText:AlphaTo( 0, 1, 0, function()
			table.remove(curXPNotify, #curXPNotify)
			xpText:Remove()
		end)
	end)
end)

hook.Add( "HUDShouldDraw", "HL2CR_HideHUD", function( name )
	if client_hidehud[name] and client_maps_no_suit[game.GetMap()] then
		return false
	elseif client_hidehud[name] and (game.GetMap() == "d1_trainstation_05" and not GetGlobalBool("HL2CR_GLOBAL_SUIT")) then
		return false
	end
	
    return true 
end)

gameevent.Listen("player_disconnect")
hook.Add( "player_disconnect", "HL2CR_PlayerDisconnect", function( data )
	local name = data.name
	local steamid = data.networkid
	local id = data.userid
	local bot = data.bot
	local reason = data.reason
	
	chat.AddText(Color(240, 175, 0), steamid .. ": " .. name .. translate.Get("Chat_Player_Disconnect"), tostring(reason))
end)

gameevent.Listen("player_connect_client")
hook.Add( "player_connect_client", "HL2CR_PlayerConnect", function( data )
	local name = data.name
	local id = data.networkid
		
	if id == "STEAM_0:0:6009886" then
		surface.PlaySound("hl2cr/admin/itsrifter_join.wav")
	elseif id == "STEAM_0:1:7832469" then
		surface.PlaySound("hl2cr/admin/birdman_join.wav")
	elseif id == "STEAM_0:0:97860967" then
		surface.PlaySound("hl2cr/admin/sarin_join.wav")
	end

	chat.AddText(Color(240, 175, 0), name .. translate.Get("Chat_Player_Connect"))

end)