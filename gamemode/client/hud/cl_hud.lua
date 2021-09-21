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
	elseif HL2CR_HideHud[name] and (game.GetMap() == "d1_trainstation_05" and ents.FindByClass("item_suit")[1]) then
		return false
	end

end)
local start = 0
local barW = 200
local barH = 25
local animationTime = 0.1
local showTime = 0
local oldXP = LocalPlayer():GetNWInt("stat_exp")

hook.Add("HUDPaint", "HL2CR_HUD", function()
	if mapCountdown then return end
	
	XP = LocalPlayer():GetNWInt("stat_exp")
	if oldXP ~= XP then
		showTime = CurTime() + 6
		oldXP = XP
	end
	start = SysTime()
	if showTime <= CurTime() then return end
	
	if not IsValid(LocalPlayer()) then return end

	local XP = LocalPlayer():GetNWInt("stat_exp")
	local maxXP = LocalPlayer():GetNWInt("stat_reqexp")

	local smoothXPLerp = Lerp( ( SysTime() - start ) / animationTime, oldXP, XP )

	if maxXP ~= XP then
		if smoothXPLerp ~= maxXP then
			XP = smoothXPLerp
		end
	end
	
	if LocalPlayer():GetNWInt("stat_skillpoints") > 0 then
		draw.DrawText("UNUSED SKILL POINTS: " .. LocalPlayer():GetNWInt("stat_skillpoints"), "HL2CR_Stats", 250, ScrH() - 240, color_white, TEXT_ALIGN_LEFT)
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

local CONVERT_TO_NAME_STANDARD = {
	["npc_headcrab"] = "Headcrab",
	["npc_headcrab_fast"] = "Fast Headcrab",
	["npc_headcrab_black"] = "Poison Headcrab",
	["npc_zombie_torso"] = "Torso Zombie",
	["npc_fastzombie_torso"] = "Fast Torso Zombie",
	["npc_zombine"] = "Zombine",
	["npc_zombie"] = "Zombie",
	["npc_fastzombie"] = "Fast Zombie",
	["npc_poisonzombie"] = "Poison Zombie",
	["npc_metropolice"] = "Cop",
	["npc_combine_s"] = "Soldier",
	["npc_manhack"] = "Manhack",
	["npc_cscanner"] = "City Scanner",
	["npc_clawscanner"] = "Shield Scanner",
	["npc_hunter"] = "Hunter",
	["npc_rollermine"] = "Rollermine",
	["npc_strider"] = "Strider",
	["npc_combinegunship"] = "Gunship",
	["npc_antlion"] = "Antlion",
	["npc_antlion_worker"] = "Antlion Worker",
	["npc_antlionguard"] = "Antlion Guard",
	["npc_antlionguardian"] = "Antlion Guardian",
}

hook.Add( "HUDDrawTargetID", "HidePlayerInfo", function()

	for k, pl in ipairs(player.GetAll()) do
		if LocalPlayer() == pl or LocalPlayer():Team() == TEAM_ALIVE then 
			continue 
		end
		
		local dist = LocalPlayer():GetPos():Distance(pl:GetPos())
		local pos = pl:GetPos()
			pos.z = pl:GetPos().z + 45 + (dist * 0.0325)

		local ScrPos = pos:ToScreen()
		
		local hpStatus = "nil"
		local hpColour = Color(255, 255, 255)
		local hpSpacing = 0
		
		if pl:Health() == pl:GetMaxHealth() then
			hpStatus = "Perfect"
			hpColour = Color(10, 210, 0)
			hpSpacing = 50
			
		elseif pl:Health() < pl:GetMaxHealth() and pl:Health() > 75 then
			hpStatus = "Great"
			hpColour = Color(155, 210, 0)
			hpSpacing = 40
			
		elseif pl:Health() > 50 and pl:Health() <= 75 then
			hpStatus = "Fine"
			hpColour = Color(210, 220, 0)
			hpSpacing = 35
			
		elseif pl:Health() > 25 and pl:Health() <= 50 then
			hpStatus = "Hurt"
			hpColour = Color(220, 180, 0)
			hpSpacing = 35
			
		elseif pl:Health() > 10 and pl:Health() <= 25 then
			hpStatus = "Wounded"
			hpColour = Color(220, 130, 0)
			hpSpacing = 65
			
		elseif pl:Health() <= 10 then
			hpStatus = "Critical"
			hpColour = Color(220, 0, 0)
			hpSpacing = 50
		end
		
		if dist <= 250 then
			--Name
			draw.SimpleText(pl:Nick(), "HL2CR_HoverPlayer", ScrPos.x, ScrPos.y, GAMEMODE.Colours.Standard, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			
			--Level
			draw.SimpleText("Level: " .. pl:GetNWInt("stat_level", -1), "HL2CR_HoverPlayer", ScrPos.x, ScrPos.y + 30, Color(240, 168, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			
			--Health Status
			draw.SimpleText("Status: ", "HL2CR_HoverPlayer", ScrPos.x - 35, ScrPos.y + 60, Color(240, 168, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText(hpStatus, "HL2CR_HoverPlayer", ScrPos.x + hpSpacing, ScrPos.y + 60, hpColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			
		end
	end
	
	return false
end )

hook.Add("HUDPaint", "HL2CR_DrawStats", function()
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
				elseif ent:GetNWInt("HL2CR_NPC_Level") > 7 and ent:GetNWInt("HL2CR_NPC_Level") <= 18 then
					levelColour = Color(255, 255, 0, 255)
				else
					levelColour = Color(255, 0, 0, 255)
				end
				
				if not ent:GetNWBool("HL2CR_Special") then
					draw.SimpleText(CONVERT_TO_NAME_STANDARD[ent:GetClass()], "HL2CR_NPCStats", ScrPos.x, ScrPos.y, levelColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				else
					draw.SimpleText(ent:GetNWString("HL2CR_NPC_Name"), "HL2CR_NPCStats", ScrPos.x, ScrPos.y, levelColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				draw.SimpleText("LEVEL " .. ent:GetNWInt("HL2CR_NPC_Level"), "HL2CR_NPCStats", ScrPos.x, ScrPos.y + 30, levelColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
	end
end)

local indicators = {}
local lastcurtime = 0

local function spawnIndicator(rewardAmt, col, pos, vel, ttl)
	
	local ind = {}
	
	ind.amount = rewardAmt
	ind.pos  = Vector(pos.x, pos.y, pos.z + 50)
	ind.vel  = Vector(vel.x, vel.y, vel.z)
	
	ind.col  = Color(col.r, col.g, col.b)
	
	ind.ttl       = ttl
	ind.life      = ttl
	ind.spawntime = CurTime()
	
	surface.SetFont("HL2CR_Rewards")
	local w, h = surface.GetTextSize(rewardAmt)
	
	ind.widthH  = w/2
	ind.heightH = h/2
	
	table.insert(indicators, ind)
	
end

net.Receive( "HL2CR_SpawnIndicators", function()
	
	local reward = net.ReadInt(32)
	local pos = net.ReadVector()
	
	spawnIndicator("XP: " .. reward, GAMEMODE.Colours.Standard, pos, Vector(math.Rand(-0.5, 0.5), math.Rand(-0.5, 0.5), math.Rand(0.75, 1) * 1.5), 2)
	
end)

-- Update indicators.
hook.Add( "Tick", "hdn_updateInds", function()
	
	local curtime = CurTime()
	local dt      = curtime - lastcurtime
	lastcurtime   = curtime
	
	if #indicators == 0 then return end
	
	local gravity = 1.0 * 0.05
	
	-- Update hit texts.
	local ind
	for i=1, #indicators do
		ind       = indicators[i]
		ind.life  = ind.life - dt
		ind.vel.z = ind.vel.z - gravity
		ind.pos   = ind.pos + ind.vel
	end
	
	local i = 1
	while i <= #indicators do
		if indicators[i].life < 0 then
			table.remove(indicators, i)
		else
			i = i + 1
		end
	end
end)

-- Render the 3D indicators.
hook.Add( "PostDrawTranslucentRenderables", "HL2CR_DrawRewards", function()
	
	if #indicators == 0 then return end
	
	-- Indicators to always face the player.
	local observer = (LocalPlayer():GetViewEntity() or LocalPlayer())
	local ang = observer:EyeAngles()
	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )
	ang = Angle( 0, ang.y, ang.r )
	
	-- Is this even necessary to do anymore?
	local cam_Start3D2D        = cam.Start3D2D
	local cam_End3D2D          = cam.End3D2D
	local surface_SetTextColor = surface.SetTextColor
	local surface_SetTextPos   = surface.SetTextPos
	local surface_DrawText     = surface.DrawText
	
	surface.SetFont("HL2CR_Rewards")
	
	-- Render each indicator.
	local ind
	for i=1, #indicators do
		ind = indicators[i]
		cam_Start3D2D(ind.pos, ang, 0.3)
			surface_SetTextColor(ind.col.r, ind.col.g, ind.col.b, (ind.life / ind.ttl * 255))
			surface_SetTextPos(-ind.widthH, -ind.heightH)
			surface_DrawText(ind.amount)
		cam_End3D2D()
	end
end)