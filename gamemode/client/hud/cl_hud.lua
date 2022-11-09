local client_maps_no_suit = {
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true
}

local client_hidehud = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
}

local client_musthidehud = {
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

	if client_maps_no_suit[game.GetMap()] or (game.GetMap() == "d1_trainstation_05" and not GetGlobalBool("HL2CR_GLOBAL_SUIT")) then return end

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
	draw.RoundedBox( 4, ScrW() / 2.25, ScrH() / 1.075, barW, 45, Color(0, 0, 0, fadeOut) )

	//Fill
	draw.RoundedBox( 4, ScrW() / 2.25, ScrH() / 1.075, math.max( 0, smoothXP ) / reqXP * barW, 45, Color(255, 174, 0, fadeOut) )
	
	local percentage = math.Round((100 * xp) / reqXP, 1) .. "%"

	//Text
	draw.SimpleText(translate.Get("HUD_Stat_XP") .. " " .. percentage, "hl2cr_hud_xp", ScrW() / 2.10, ScrH() / 1.05, Color(255, 200, 0, fadeOut), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

	if LocalPlayer():GetNWInt("hl2cr_stat_skillpoints", -1 ) > 0 then
		draw.SimpleText(LocalPlayer():GetNWInt("hl2cr_stat_skillpoints", -1 ) .. translate.Get("HUD_Notice_UnspentSkills") , "hl2cr_hud_xp", ScrW() / 2.3, ScrH() / 1.105, Color(255, 0, 0, fadeOut), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
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
local xpTotalText = nil 
local xpTotal = 0

net.Receive("HL2CR_Update_XP", function()
	lastUpdate = 6 + CurTime()
	
	newXP = net.ReadInt(32)
	xpTotal = xpTotal + newXP

	local xpText = vgui.Create("DLabel", xpPopup)
	xpText:SetPos(ScrW() / 2.40, ScrH() - 115)
	xpText:SetText(translate.Get("HUD_Stat_XP") .. ": " .. newXP)
	xpText:SetTextColor(Color(255, 200, 0))
	xpText:SetFont("hl2cr_hud_xp")
	xpText:SizeToContents()

	table.insert(curXPNotify, xpText)

	if #curXPNotify > 1 then
		if xpTotalText then
			xpTotalText:Remove()
			xpTotalText = nil
		end
		
		xpTotalText = vgui.Create("DLabel", xpPopup)

		xpTotalText:SetPos(ScrW() / 2.175, ScrH() - 150)
		xpTotalText:SetText(" = " .. xpTotal)
		xpTotalText:SetTextColor(Color(255, 200, 0))
		xpTotalText:SetFont("hl2cr_hud_xp")
		xpTotalText:SizeToContents()

		xpTotalText.Think = function(self)
			if (lastUpdate - CurTime()) <= 4 then
				xpTotalText:AlphaTo( 0, 1.25, 0, function()
					xpTotal = 0
					if not xpTotalText then return end
					xpTotalText:Remove()
					xpTotalText = nil
				end)
			end
			if (lastUpdate - CurTime()) <= 2.85 then
				xpTotal = 0
			end
		end
	end

	xpText:MoveTo( ScrW() / 2.40, ScrH() - 125 - (25 * #curXPNotify), 1, 0, -1, function()
		xpText:AlphaTo( 0, 1, 1, function()
			table.remove(curXPNotify, #curXPNotify)
			xpTotal = 0
			xpText:Remove()
		end)
	end)
end)

local function DisplayDeathNotification(msgTbl)
	if msgTbl.Attacker == nil or msgTbl.Victim == msgTbl.Attacker then
		hook.Run("AddDeathNotice", nil, nil, "suicide", msgTbl.victim:Nick(), nil )
	else
		hook.Run("AddDeathNotice", msgTbl.attacker, nil, msgTbl.inflictor, msgTbl.victim:Nick(), nil )
	end
end

net.Receive("HL2CR_Player_NotifyKilled", function()
	DisplayDeathNotification(net.ReadTable())
end)

hook.Add( "HUDShouldDraw", "HL2CR_HideHUD", function( name )
	if client_musthidehud[name] and not Administrator.Chat.Chat.OpenOnce then
		return false
	end

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

local isDebugging = false

concommand.Add("hl2cr_debugmode", function(ply)
	if not ply:IsAdmin() then return end

	if isDebugging then
		isDebugging = false
	else
		isDebugging = true
	end
end)

hook.Add("PostDrawHUD", "HL2CR_DebugDraw", function()
	if isDebugging == false then return end

	local trace = LocalPlayer():GetEyeTrace()
	local angle = trace.HitNormal:Angle()
				
	surface.SetDrawColor(Color(0, 0, 0, 255))
	surface.SetTextPos( ScrW() / 2.5, ScrH() / 1.90 )
	surface.SetFont("hl2cr_scoreboard_player")
	surface.DrawText( tostring(trace.HitPos) )
end )

hook.Add("HUDPaint", "HL2CR_Respawn_Timer", function()
	if LocalPlayer():Alive() then return end
	
	local resTime = LocalPlayer():GetNWInt("hl2cr_respawntimer")

	if resTime > 0 then
		draw.SimpleText(translate.Get("Respawn_Remain") .. LocalPlayer():GetNWInt("hl2cr_respawntimer"), "hl2cr_respawntimer", ScrW() / 1.15, ScrH() - 50, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	else
		draw.SimpleText(translate.Get("Respawn_Ready"), "hl2cr_respawntimer",  ScrW() / 1.15, ScrH() - 50, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	
end)

hook.Add("HUDPaint", "HL2CR_DrawPetStats", function()
	for _, e in ipairs(ents.FindByClass("npc_*")) do
		if e:IsPet() then
			local pet = e

			local dist = LocalPlayer():GetPos():Distance(pet:GetPos())
			local pos = pet:GetPos()
				pos.z = pet:GetPos().z + 20 + (dist * 0.0325)
				
			local ScrPos = pos:ToScreen()
			if pet:GetOwner() and dist <= 250 then
				//draw.SimpleText(translate.Get("NPCLevel") .. pet:GetOwner():GetNWInt("pet_level", -1), "HL2CR_NPCStats", ScrPos.x, ScrPos.y - 35, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(pet:GetOwner():Nick() .. translate.Get("Pet_Owner"), "hl2cr_hud_pet", ScrPos.x, ScrPos.y, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(pet:GetOwner():GetNWString("hl2cr_petstat_name"), "hl2cr_hud_pet", ScrPos.x, ScrPos.y + 35, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

				//TEMPORARY
				draw.SimpleText(pet:GetOwner():GetNWString("hl2cr_petstat_xp") .. "/" .. pet:GetOwner():GetNWString("hl2cr_petstat_reqxp"), "hl2cr_hud_pet", ScrPos.x, ScrPos.y + 65, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
	end
end)