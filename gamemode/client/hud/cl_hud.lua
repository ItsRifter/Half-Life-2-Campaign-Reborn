local mapCountdown = false

net.Receive("HL2CR_LevelUpSound", function()
	surface.PlaySound("hl2cr/levelup.wav")
end)

net.Receive("HL2CR_MapCountdown", function()
	surface.PlaySound("npc/overwatch/radiovoice/allunitsapplyforwardpressure.wav")
	
	mapCountdown = true
end)

net.Receive("HL2CR_EndCampaign", function()
	surface.PlaySound("hl2cr/ending_triumph.mp3")
end)

net.Receive("HL2CR_AdminJoin", function()
	local adminName = net.ReadString()
	
	if adminName == "SuperSponer" then
		surface.PlaySound("hl2cr/admin/supersponer_join.wav")
		chat.AddText(Color(240, 175, 0), "The Creator - " .. adminName .. " - has joined the server")
	end
end)

gameevent.Listen("player_disconnect")
hook.Add( "player_disconnect", "HL2CR_PlayerDisconnect", function( data )
	local name = data.name
	local steamid = data.networkid
	local id = data.userid
	local bot = data.bot
	local reason = data.reason
	
	chat.AddText(Color(240, 175, 0), steamid .. ": " .. name .. " has left the server REASON: " .. reason)
end)

net.Receive("HL2CR_AchievementNotifyAll", function()
	local achiever = net.ReadString()
	local achName = net.ReadString()
	local isRareAch = net.ReadBool()
	if not isRareAch then
		chat.AddText(Color(240, 175, 0), achiever .. " has earned the achievement: " .. achName)
	else
		chat.AddText(Color(240, 175, 0), achiever .. " has earned a ", Color(255, 238, 0), "RARE ", Color(240, 175, 0), "achievement: " .. achName)
	end
end)

local NOSUIT_MAPS = {
	["d1_trainstation_01"] = true,
	["d1_trainstation_02"] = true,
	["d1_trainstation_03"] = true,
	["d1_trainstation_04"] = true
}
local HL2CR_HideHud = {
	["CHudHealth"] = true,
	["CHudBattery"] = true
}

hook.Add( "HUDShouldDraw", "HL2CR_HideHUD", function( name )
	if HL2CR_HideHud[name] and NOSUIT_MAPS[game.GetMap()] then
		return false
	elseif HL2CR_HideHud[name] and ents.FindByClass("item_suit")[1] then
		return false
	end

end)
local start = 0
local barW = 200
local barH = 25
local animationTime = 0.1
local showTime = 0
local oldXP = LocalPlayer():GetNWInt("HL2CR_XP")
hook.Add("HUDPaint", "HL2CR_HUD", function()
	if mapCountdown then return end
	
	XP = LocalPlayer():GetNWInt("HL2CR_XP")
	if oldXP ~= XP then
		showTime = CurTime() + 6
		oldXP = XP
	end
	start = SysTime()
	if showTime <= CurTime() then return end
	
	if not IsValid(LocalPlayer()) then return end

	local XP = LocalPlayer():GetNWInt("HL2CR_XP")
	local maxXP = LocalPlayer():GetNWInt("HL2CR_ReqXP")

	local smoothXPLerp = Lerp( ( SysTime() - start ) / animationTime, oldXP, XP )

	if maxXP ~= XP then
		if smoothXPLerp ~= maxXP then
			XP = smoothXPLerp
		end
	end
	
	if LocalPlayer():GetNWInt("HL2CR_SP") > 0 then
		draw.DrawText("UNUSED SKILL POINTS: " .. LocalPlayer():GetNWInt("HL2CR_SP"), "HL2CR_Stats", 250, ScrH() - 240, color_white, TEXT_ALIGN_LEFT)
	end

	draw.RoundedBox( 4, 50, ScrH() - 240, barW, barH, color_black )
	draw.RoundedBox( 4, 50, ScrH() - 240, math.max( 0, smoothXPLerp ) / maxXP * barW, barH, Color(235, 180, 52, 255) )
	draw.DrawText("XP", "HL2CR_Stats", 50, ScrH() - 240, color_white, TEXT_ALIGN_LEFT)
	
end)

local CLIENT_FRIENDLY_NPCS = {
	["npc_kleiner"] = true,
	["npc_dog"] = true,
	["npc_monk"] = true,
	["npc_alyx"] = true,
	["npc_barney"] = true,
	["npc_vortigaunt"] = true,
	["npc_fisherman"] = true,
	["npc_mossman"] = true,
	["npc_breen"] = true,
	["npc_gman"] = true,
	["npc_eli"] = true,
	["npc_citizen"] = true,
	["npc_furniture"] = true,
	["npc_crow"] = true,
	["npc_pigeon"] = true,
	["npc_seagull"] = true
}

hook.Add("HUDPaint", "HL2CR_DrawNPCStats", function()
	for k, ent in pairs(ents.FindByClass("npc_*")) do
		if ent:IsNPC() and not CLIENT_FRIENDLY_NPCS[ent:GetClass()] then
			local dist = LocalPlayer():GetPos():Distance(ent:GetPos())
			local pos = ent:GetPos()
			if string.find(ent:GetClass(), "headcrab") then
				pos.z = ent:GetPos().z + 15 + (dist * 0.0325)
			else
				pos.z = ent:GetPos().z + 70 + (dist * 0.0325)
			end
			local ScrPos = pos:ToScreen()
			if ent:GetOwner() and dist <= 150 then
				local levelColour = Color(255, 255, 255, 255)
				if ent:GetNWInt("HL2CR_NPC_Level") <= 7 then
					levelColour = Color(0, 255, 0, 255)
				elseif ent:GetNWInt("HL2CR_NPC_Level") > 7 and ent:GetNWInt("HL2CR_NPC_Level") <= 15 then
					levelColour = Color(255, 255, 0, 255)
				else
					levelColour = Color(255, 0, 0, 255)
				end
				draw.SimpleText(string.sub(string.upper(ent:GetClass()), 5), "HL2CR_NPCStats", ScrPos.x, ScrPos.y, levelColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("LEVEL " .. ent:GetNWInt("HL2CR_NPC_Level"), "HL2CR_NPCStats", ScrPos.x, ScrPos.y + 30, levelColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
	end
end)