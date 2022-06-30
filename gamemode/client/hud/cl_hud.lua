local client_maps_no_suit = {
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true
}

local client_hidehud = {
	["CHudHealth"] = true,
	["CHudBattery"] = true
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

net.Receive("HL2CR_MsgSound", function()
	PlayLocalSound(net.ReadString())
end)

net.Receive("HL2CR_MsgPitchSound", function()
	PlayUniqueLocalSound(net.ReadString(), net.ReadInt(32))
end)

net.Receive("HL2CR_ChatMessage", function()
	DisplayChatMessage( net.ReadTable() )
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
	
	chat.AddText(Color(240, 175, 0), steamid .. ": " .. name .. " has joined the server" .. reason)
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
end)