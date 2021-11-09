local mapCountdown = false

local NOTIFY_MESSAGES = {
	[5] = "Classes Unlocked",
	[8] = "Pets Unlocked, use !pet / !petmenu",
	[10] = "Mechanic | Grenadier | Combine Dropout Class Unlocked",
	[20] = "Robot Class Unlocked",
}

net.Receive("HL2CR_LevelUpSound", function()
	surface.PlaySound("hl2cr/levelup.wav")
	local level = net.ReadInt(16)
	
	chat.AddText(Color(240, 175, 0), translate.Get("HUDPlayerGotLevel") .. level .. "'")
	
	if NOTIFY_MESSAGES[level] then
		chat.AddText(Color(240, 175, 0), NOTIFY_MESSAGES[level])
	end
end)

net.Receive("HL2CR_MapCountdown", function()
	
	surface.PlaySound("npc/overwatch/radiovoice/allunitsapplyforwardpressure.wav")

	mapCountdown = true
	TimerScreen()
end)

net.Receive("HL2CR_EndCampaign", function()
	surface.PlaySound("hl2cr/end_game.wav")
end)

gameevent.Listen("player_disconnect")
hook.Add( "player_disconnect", "HL2CR_PlayerDisconnect", function( data )
	local name = data.name
	local steamid = data.networkid
	local id = data.userid
	local bot = data.bot
	local reason = data.reason
	
	chat.AddText(Color(240, 175, 0), steamid .. ": " .. name .. translate.Get("HUDPlayerLeftTheGame") .. reason)
end)

gameevent.Listen("player_connect_client")
hook.Add( "player_connect_client", "HL2CR_PlayerConnect", function( data )
	local name = data.name
	local id = data.networkid
		
	if id == "STEAM_0:0:6009886" then
		surface.PlaySound("hl2cr/admin/supersponer_join.wav")
		chat.AddText(Color(240, 175, 0), translate.Get("HUDRifterAlert") .. name .. translate.Get("HUDAdminAlert2"))
	end
	
	if id == "STEAM_0:1:7832469" then
		surface.PlaySound("hl2cr/admin/birdman_join.wav")
		chat.AddText(Color(240, 175, 0), translate.Get("HUDAdminAlert") .. name .. translate.Get("HUDAdminAlert2"))
	end
	
	if id == "STEAM_0:0:97860967" then
		surface.PlaySound("hl2cr/admin/sarin_join.wav")
		chat.AddText(Color(240, 175, 0), translate.Get("HUDAdminAlert") .. name .. translate.Get("HUDAdminAlert2"))
	end
	
	if id == "STEAM_0:1:19822252" then
		chat.AddText(Color(240, 175, 0), translate.Get("HUDLeiftigerAlert") )
	end
end)

net.Receive("HL2CR_AchievementNotifyAll", function()
	local achiever = net.ReadString()
	local achName = net.ReadString()
	local isRareAch = net.ReadBool()
	if not isRareAch then
		chat.AddText(Color(240, 175, 0), achiever .. translate.Get("EarnedAchievement") .. achName)
	else
		chat.AddText(Color(240, 175, 0), achiever .. translate.Get("HUDRareAch1"), Color(255, 238, 0), translate.Get("HUDRareAch2"), Color(240, 175, 0), translate.Get("HUDRareAch3") .. achName)
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
		draw.DrawText(translate.Get("HUDSkillPoints") .. LocalPlayer():GetNWInt("stat_skillpoints"), "HL2CR_Stats", 250, ScrH() - 240, color_white, TEXT_ALIGN_LEFT)
	end

	draw.RoundedBox( 4, 50, ScrH() - 240, barW, barH, color_black )
	draw.RoundedBox( 4, 50, ScrH() - 240, math.max( 0, smoothXPLerp ) / maxXP * barW, barH, Color(235, 180, 52, 255) )
	draw.DrawText(translate.Get("HUDXP"), "HL2CR_Stats", 50, ScrH() - 240, color_white, TEXT_ALIGN_LEFT)
	
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

local CONVERT_TO_NAME_NH2 = {
	["npc_headcrab"] = "Headcrab",
	["npc_headcrab_fast"] = "Fast Headcrab",
	["npc_headcrab_black"] = "Poison Headcrab",
	["npc_headcrab_poison"] = "Poison Headcrab",
	["npc_nh_patient"] = "Brainless Patient",
	["npc_nh_cook"] = "Brainless Cook",
	["npc_zombine"] = "Brainless Riot",
	["npc_zombie"] = "Brainless",
	["npc_fastzombie"] = "Creeper",
	["npc_poisonzombie"] = "Husk",
	["npc_stalker"] = "Nurse",
	["npc_zombie_torso"] = "Torso Zombie",
}
local CONVERT_TO_NAME_STANDARD = {
	["npc_headcrab"] = "Headcrab",
	["npc_headcrab_fast"] = "Fast Headcrab",
	["npc_headcrab_black"] = "Poison Headcrab",
	["npc_headcrab_poison"] = "Poison Headcrab",
	["npc_zombie_torso"] = "Torso Zombie",
	["npc_fastzombie_torso"] = "Fast Torso Zombie",
	["npc_zombine"] = "Zombine",
	["npc_zombie"] = "Zombie",
	["npc_barnacle"] = "Barnacle",
	["npc_fastzombie"] = "Fast Zombie",
	["npc_poisonzombie"] = "Poison Zombie",
	["npc_metropolice"] = "Cop",
	["npc_combine_s"] = "Soldier",
	["npc_manhack"] = "Manhack",
	["npc_cscanner"] = "City Scanner",
	["npc_clawscanner"] = "Shield Scanner",
	["npc_hunter"] = "Hunter",
	["npc_rollermine"] = "Rollermine",
	["npc_turret_floor"] = "Turret",
	["npc_turret_ground"] = "Ground Turret",
	["npc_strider"] = "Strider",
	["npc_combinegunship"] = "Gunship",
	["npc_antlion"] = "Antlion",
	["npc_antlion_worker"] = "Antlion Worker",
	["npc_antlionguard"] = "Antlion Guard",
	["npc_antlionguardian"] = "Antlion Guardian",
	["npc_stalker"] = "Stalker",
}

local FIX_FONT_SPACING = {
	["HL2CR_HoverPlayer"] = 0,
	["HL2CR_EasyHorror"] = 5,
	["HL2CR_FancyShmancy"] = 45,
}

local FIX_AMMO_TYPE = {
	[1] = "AR2",
	[3] = "Pistol",
	[4] = "SMG",
	[5] = ".357",
	[6] = "Bolts",
	[7] = "Buckshot",
	[8] = "RPG",
	[10] = "Frags"
}

hook.Add( "HUDDrawTargetID", "HL2CR_PlayerInfo", function()

	for k, pl in ipairs(player.GetAll()) do
		if LocalPlayer() == pl then 
			continue
		end
		
		if pl:Team() == 2 or pl:Team() == 5 then continue end

		if not pl:Alive() and (pl:GetNWEntity("hl2cr_grave") and pl:GetNWEntity("hl2cr_grave"):IsValid()) then 
			local distGrave = LocalPlayer():GetPos():Distance(pl:GetNWEntity("hl2cr_grave"):GetPos())
			local posGrave = pl:GetNWEntity("hl2cr_grave"):GetPos()
			posGrave.z = pl:GetPos().z + 45 + (distGrave * 0.0325)

			local ScrPosGrave = posGrave:ToScreen()
			
			draw.SimpleText(translate.Get("HUDDeadPlayer") .. pl:Nick(), "HL2CR_HoverPlayer", ScrPosGrave.x, ScrPosGrave.y + 60, Color(240, 168, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			
			if LocalPlayer():GetNWBool("CanRevive") then
				draw.SimpleText(translate.Get("ReviveMe"), "HL2CR_HoverPlayer", ScrPosGrave.x, ScrPosGrave.y + 90, Color(240, 168, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			
			continue 
		end
		
		local dist = LocalPlayer():GetPos():Distance(pl:GetPos())
		local pos = pl:GetPos()
			pos.z = pl:GetPos().z + 45 + (dist * 0.0325)

		local ScrPos = pos:ToScreen()
		
		local hpStatus = "nil"
		local hpColour = Color(255, 255, 255)
		local hpSpacing = 0
		
		if pl:Health() >= pl:GetMaxHealth() then
			hpStatus = translate.Get("HUDHealthStatus1")
			hpColour = Color(10, 210, 0)
			hpSpacing = 50
			
		elseif pl:Health() < pl:GetMaxHealth() and pl:Health() > 75 then
			hpStatus = translate.Get("HUDHealthStatus2")
			hpColour = Color(155, 210, 0)
			hpSpacing = 40
			
		elseif pl:Health() > 50 and pl:Health() <= 75 then
			hpStatus = translate.Get("HUDHealthStatus3")
			hpColour = Color(210, 220, 0)
			hpSpacing = 35
			
		elseif pl:Health() > 25 and pl:Health() <= 50 then
			hpStatus = translate.Get("HUDHealthStatus4")
			hpColour = Color(220, 180, 0)
			hpSpacing = 35
			
		elseif pl:Health() > 10 and pl:Health() <= 25 then
			hpStatus = translate.Get("HUDHealthStatus5")
			hpColour = Color(220, 130, 0)
			hpSpacing = 65
			
		elseif pl:Health() <= 10 then
			hpStatus = translate.Get("HUDHealthStatus6")
			hpColour = Color(220, 0, 0)
			hpSpacing = 50
		end
	
		if dist <= LocalPlayer():GetNWInt("config_playerdrawdist", 250) then
			--Classes
			if pl:GetNWString("class_icon") ~= "" then
				local icon = Material(pl:GetNWString("class_icon"))
				surface.SetMaterial( icon )
				surface.SetDrawColor( 255, 255, 255 )
				surface.DrawTexturedRect(ScrPos.x - 20, ScrPos.y + 75, 48, 48)
			end
			
			local font = "HL2CR_HoverPlayer"
			local fixFontSpacing = FIX_FONT_SPACING[font]
			
			if not string.find(LocalPlayer():GetNWString("config_playerfont"), "Default") then
				font = "HL2CR_" .. LocalPlayer():GetNWString("config_playerfont")
				fixFontSpacing = FIX_FONT_SPACING[font]
			end
			
			if not string.find(translate.Get(pl:GetNWString("hl2cr_request")), "@") then
				draw.SimpleText(translate.Get(pl:GetNWString("hl2cr_request")), font, ScrPos.x, ScrPos.y - 65, HL2CR.Theme.standard, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			
			--Name
			draw.SimpleText(pl:Nick(), font, ScrPos.x, ScrPos.y, HL2CR.Theme.standard, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			
			--Level
			draw.SimpleText(translate.Get("SCLevel") .. pl:GetNWInt("stat_level", -1), font, ScrPos.x, ScrPos.y + 30, Color(240, 168, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			
			--Status
			
			if LocalPlayer():GetNWString("stat_curclass") == "Field Medic" then
				
				if pl:GetNWString("stat_curclass") == "Robot" then
					draw.SimpleText(hpStatus, font, ScrPos.x, ScrPos.y + 60, hpColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					return
				else
					draw.SimpleText(translate.Get("HUDPlayerHealth") .. pl:Health(), font, ScrPos.x, ScrPos.y + 60, hpColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					return
				end
			elseif not pl:GetNWString("stat_curclass") == "Robot" then
				draw.SimpleText(hpStatus, font, ScrPos.x - 50 + hpSpacing, ScrPos.y + 60, hpColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				return
			elseif LocalPlayer():GetNWString("class_icon") == "Supporter" then
				--Niik fix this please
				
			elseif LocalPlayer():GetNWString("stat_curclass") == "Repairman" then
				if pl:GetNWString("stat_curclass") == "Robot" then
					draw.SimpleText("State: " .. pl:Health(), font, ScrPos.x - 50 + hpSpacing, ScrPos.y + 60, hpColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					draw.SimpleText(translate.Get("HUDPlayerArmor") .. pl:Armor(), font, ScrPos.x + 75 + hpSpacing, ScrPos.y + 60, Color(145, 255, 250), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				else
					draw.SimpleText(hpStatus, font, ScrPos.x - 50 + hpSpacing, ScrPos.y + 60, hpColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					draw.SimpleText(translate.Get("HUDPlayerArmor") .. pl:Armor(), font, ScrPos.x + 70 + hpSpacing, ScrPos.y + 60, Color(145, 255, 250), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			else
				draw.SimpleText(hpStatus, font, ScrPos.x - 50 + hpSpacing, ScrPos.y + 60, hpColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
	end
	
	return false
end)

hook.Add("HUDPaint", "HL2CR_DrawStats", function()
	for k, ent in pairs(ents.FindByClass("npc_*")) do
		if (ent:IsNPC() or (ent:IsNextBot() and not ent:IsPet())) and not CLIENT_FRIENDLY_NPCS[ent:GetClass()] then
			local dist = LocalPlayer():GetPos():Distance(ent:GetPos())
			local pos = ent:GetPos()
			if string.find(ent:GetClass(), "headcrab") then
				pos.z = ent:GetPos().z + 15 + (dist * 0.0325)
			else
				pos.z = ent:GetPos().z + 70 + (dist * 0.0325)
			end
			local ScrPos = pos:ToScreen()
			if ent:GetOwner() and dist <= LocalPlayer():GetNWInt("config_npcdrawdist", 150) then
				local levelColour = Color(255, 255, 255, 255)
				
				if ent:GetNWInt("HL2CR_NPC_Level") <= 7 then
					levelColour = string.ToColor(LocalPlayer():GetNWString("config_npccolours_easy"))
				elseif ent:GetNWInt("HL2CR_NPC_Level") > 7 and ent:GetNWInt("HL2CR_NPC_Level") <= 18 then
					levelColour = string.ToColor(LocalPlayer():GetNWString("config_npccolours_medium"))
				else
					levelColour = string.ToColor(LocalPlayer():GetNWString("config_npccolours_hard"))
				end
			
				levelColour.a = math.Clamp((dist * 1.2325), 0, 255)
			
				local font = "HL2CR_NPCStats"
				if not string.find(LocalPlayer():GetNWString("config_npcfont"), "default") then
					font = "HL2CR_" .. LocalPlayer():GetNWString("config_npcfont")
				end
				
				--For strange reasons, this gets set to default despite above string.find
				if font == "HL2CR_Default" then font = "HL2CR_NPCStats" end

				if not ent:GetNWBool("HL2CR_Special") then
					if string.find(game.GetMap(), "nh2") or game.GetMap() == "nh1remake1_fixed" then
						draw.SimpleText(CONVERT_TO_NAME_NH2[ent:GetClass()], font or "HL2CR_NPCStats", ScrPos.x, ScrPos.y, levelColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					else 
						draw.SimpleText(CONVERT_TO_NAME_STANDARD[ent:GetClass()], font or "HL2CR_NPCStats", ScrPos.x, ScrPos.y, levelColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
				else
					draw.SimpleText(ent:GetNWString("HL2CR_NPC_Name"), font, ScrPos.x, ScrPos.y, levelColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
				
				draw.SimpleText("LEVEL " .. ent:GetNWInt("HL2CR_NPC_Level"), font, ScrPos.x, ScrPos.y + 30, levelColour, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
	end
	
	for k, entPet in pairs(ents.FindByClass("npc_hl2cr_pet_*")) do
		if entPet:IsNextBot() and entPet:IsPet() then
			local dist = LocalPlayer():GetPos():Distance(entPet:GetPos())
			local pos = entPet:GetPos()
				pos.z = entPet:GetPos().z + 20 + (dist * 0.0325)
				
			local ScrPos = pos:ToScreen()
			if entPet:GetOwner() and dist <= 250 then
				draw.SimpleText("Level: " .. entPet:GetOwner():GetNWInt("pet_level", -1), "HL2CR_NPCStats", ScrPos.x, ScrPos.y - 35, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(entPet:GetOwner():Nick() .. translate.Get("HUDPlayerPets"), "HL2CR_NPCStats", ScrPos.x, ScrPos.y, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(entPet:GetOwner():GetNWString("pet_name"), "HL2CR_NPCStats", ScrPos.x, ScrPos.y + 35, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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
	local wasPet = net.ReadBool()
	
	if wasPet then
		spawnIndicator("Pet XP: " .. reward, HL2CR.Theme.petKill, pos, Vector(math.Rand(-0.5, 0.5), math.Rand(-0.5, 0.5), math.Rand(0.75, 1) * 1.5), 2)
	else
		spawnIndicator("XP: " .. reward, HL2CR.Theme.playerKill, pos, Vector(math.Rand(-0.5, 0.5), math.Rand(-0.5, 0.5), math.Rand(0.75, 1) * 1.5), 2)
	end
	
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

net.Receive("HL2CR_Message", function()
	local messages = net.ReadTable()
	
	
	if not string.find(translate.Get(messages["Message"]), "@") and not messages["Other"] then
		chat.AddText(messages["Colour"], translate.Get(messages["Message"]))
	elseif messages["Other"] then
		if messages["Other"]["Player"] and not messages["Other"]["Time"] then
			chat.AddText(messages["Colour"], messages["Other"]["Player"] .. translate.Get(messages["Message"]))
		elseif messages["Other"]["CurCompleted"] and translate.Get(messages["Other"]["CurCompleted"]) then
			if messages["Other"]["CurCompleted"]["Total"] then
			
				chat.AddText(messages["Colour"], messages["Other"]["Player"] .. translate.Get(messages["Message"]) .. messages["Other"]["Time"] .. translate.Get(messages["Other"]["CurCompleted"]))
				return
			end

			chat.AddText(messages["Colour"], messages["Other"]["Player"] .. translate.Get(messages["Message"]) .. messages["Other"]["Time"] .. translate.Get(messages["Other"]["CurCompleted"]))
			
		elseif messages["Other"]["Total"] then
			chat.AddText(messages["Colour"], messages["Other"]["Player"] .. translate.Get(messages["Message"]) .. messages["Other"]["Time"] .. messages["Other"]["Total"])
		end
	else
		chat.AddText(messages["Colour"], messages["Message"])
	end
end)

net.Receive("HL2CR_MsgSound", function()
	local sound = net.ReadString()
	
	surface.PlaySound(sound)
end)


--This is temporary
net.Receive("HL2CR_OpenCustomMap", function()
	local customFrame = vgui.Create("DFrame")
	customFrame:SetSize(ScrW() / 1.47, ScrH() / 1.5)
	customFrame:SetTitle("")
	customFrame:Center()
	customFrame:ShowCloseButton(true)
	customFrame:MakePopup()
	
	customFrame.Paint = function(self, w, h)
		surface.SetDrawColor(HL2CR.Theme.qMenu)
		surface.DrawRect(0, 0, w, h)
	end
	
	local mapScroll = vgui.Create("DScrollPanel", customFrame)
	mapScroll:Dock(FILL)
	mapScroll.Paint = function() return end
	
	local rndMapBtn = vgui.Create("DButton", mapScroll)
	rndMapBtn:SetSize(1024, 256)
	rndMapBtn:SetPos(customFrame:GetWide() / 3.74, 50)
	rndMapBtn:SetText("")
	rndMapBtn:SetImage("materials/hl2cr/mapicons/rnd.jpg")
	rndMapBtn.Paint = function() end
	rndMapBtn.DoClick = function()
		net.Start("HL2CR_VoteCustomMap")
			net.WriteString("BeginRND")
		net.SendToServer()
		customFrame:Close()
	end
	
	local pursoupMapBtn = vgui.Create("DButton", mapScroll)
	pursoupMapBtn:SetSize(1024, 256)
	pursoupMapBtn:SetPos(customFrame:GetWide() / 3.74, 50 * 7)
	pursoupMapBtn:SetText("")
	pursoupMapBtn:SetImage("materials/hl2cr/mapicons/pursoup.jpg")
	pursoupMapBtn.Paint = function() end
	pursoupMapBtn.DoClick = function()
		net.Start("HL2CR_VoteCustomMap")
			net.WriteString("BeginPursoups")
		net.SendToServer()
		customFrame:Close()
	end
	
	local nhMapBtn = vgui.Create("DButton", mapScroll)
	nhMapBtn:SetSize(1024, 256)
	nhMapBtn:SetPos(customFrame:GetWide() / 3.74, 50 * 13)
	nhMapBtn:SetText("")
	nhMapBtn:SetImage("materials/hl2cr/mapicons/nh.jpg")
	nhMapBtn.Paint = function() end
	nhMapBtn.DoClick = function()
		net.Start("HL2CR_VoteCustomMap")
			net.WriteString("BeginNightmareHouse")
		net.SendToServer()
		customFrame:Close()
	end
end)

net.Receive("HL2CR_StatusEffect", function()
	local effect = net.ReadString()
	local timeLeft = net.ReadInt(16) + CurTime()
	local isActive = net.ReadBool()
	
	if effect == "HealthRegen" then
		if isActive then
			if IsValid(effectIcon) then
				effectIcon:Remove()
			end
			effectIcon = vgui.Create("DImage")
			effectIcon:SetSize(64, 64)
			effectIcon:SetImage("materials/hl2cr/skill_health.jpg")
			effectIcon:SetPos(ScrW() / 5.65, ScrH() / 1.20)
			
			local effectTimer = vgui.Create("DLabel", effectIcon)
			effectTimer:SetPos(12, 24)
			effectTimer:SetFont("HL2CR_StatusFont")
			effectTimer.Think = function(pnl)
				pnl:SetText(math.Round(timeLeft - CurTime(), 1))
			end
			
		else
			if IsValid(effectIcon) then
				effectIcon:Remove()
			end
		end
	end
end)