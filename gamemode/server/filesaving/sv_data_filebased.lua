local function InitData(ply)
	-- Create persistent data field in ply
	ply.hl2cr = ply.hl2cr or {}

	-- Set some default settings
	
	--Player's name and model
	ply.hl2cr.Name = ply.hl2cr.Name or ply:Nick()
	ply.hl2cr.Model = ply.hl2cr.Model or "models/player/Group01/male_07.mdl"
	
	--Level
	ply.hl2cr.Level = ply.hl2cr.Level or 0
	
	--Money/Experience
	ply.hl2cr.Resin = ply.hl2cr.Resin or 0
	ply.hl2cr.Essence = ply.hl2cr.Essence or 0
	ply.hl2cr.Exp = ply.hl2cr.Exp or 0
	ply.hl2cr.ReqExp = ply.hl2cr.ReqExp or 3000
	
	--Skills
	ply.hl2cr.Skills = ply.hl2cr.Skills or {
		["Passive"] = {},
		["Medic"] = {},
		["Repair"] = {},
		["Mechanic"] = {},
		["Grenadier"] = {},
		["Dropout"] = {},
	}
	ply.hl2cr.SkillPoints = ply.hl2cr.SkillPoints or 0
	
	--Pets
	ply.hl2cr.Pets = ply.hl2cr.Pets or {}
	ply.hl2cr.Pets.CurrentPet = ply.hl2cr.Pets.CurrentPet or {}
	ply.hl2cr.Pets.Name = ply.hl2cr.Pets.Name or ""
	
	--Statistics
	ply.hl2cr.Kills = ply.hl2cr.Kills or 0
	ply.hl2cr.Deaths = ply.hl2cr.Deaths or 0
	
	--Config
	ply.hl2cr.Config = ply.hl2cr.Config or {}
	ply.hl2cr.Config.PlayerSettings = ply.hl2cr.Config.PlayerSettings or {
		["PlayerDrawDistance"] = 250,
		["ShouldPlayEndMusic"] = true,
		["PlayerFont"] = "Default"
	}
	ply.hl2cr.Config.NPCSettings = ply.hl2cr.Config.NPCSettings or {
		["NPCDrawDistance"] = 150,
		["NPCFont"] = "Default",
		["Colours"] = {
			[1] = Color(0, 255, 0),
			[2] = Color(255, 255, 0),
			[3] = Color(255, 0, 0),
		}
	}
	
	--Inventory
	ply.hl2cr.Inventory = ply.hl2cr.Inventory or {}
	ply.hl2cr.Inventory.Slots = ply.hl2cr.Inventory.Slots or {}
	ply.hl2cr.Inventory.TotalSlots = ply.hl2cr.Inventory.TotalSlots or 15
	ply.hl2cr.Inventory.CurWeaponSlot = ply.hl2cr.Inventory.CurWeaponSlot or ""
	--ply.hl2cr.Inventory.Weight = ply.hl2cr.Inventory.Weight = 0
	
	--Achievement + Progress
	ply.hl2cr.Achievements = ply.hl2cr.Achievements or {}
	ply.hl2cr.ProgressAch = ply.hl2cr.ProgressAch or {}
	
	--Classes
	ply.hl2cr.CurClass = ply.hl2cr.CurClass or {}
	ply.hl2cr.ClassCount = ply.hl2cr.ClassCount or 0

	--Quests
	ply.hl2cr.Quests = ply.hl2cr.Quests or {}
	ply.hl2cr.Quests.Completed = ply.hl2cr.Quests.Completed or 0
	
	--Miscellanous
	ply.hl2cr.Misc = ply.hl2cr.Misc or {}
	
	ply:SetNWInt("stat_level", ply.hl2cr.Level)
	ply:SetNWInt("stat_exp", ply.hl2cr.Exp)
	ply:SetNWInt("stat_reqexp", ply.hl2cr.ReqExp)
	ply:SetNWInt("stat_skillpoints", ply.hl2cr.SkillPoints)
	ply:SetNWInt("stat_curclasses", ply.hl2cr.ClassCount)
	ply:SetNWInt("stat_kills", ply.hl2cr.Kills)
	ply:SetNWInt("stat_deaths", ply.hl2cr.Deaths)
	ply:SetNWInt("stat_quests_completed", ply.hl2cr.Quests.Completed)
	ply:SetNWString("stat_achievements", table.concat(ply.hl2cr.Achievements, " "))
	
	ply:SetNWString("stat_model", ply.hl2cr.Model)
	
	ply:SetNWString("pet_name", ply.hl2cr.Pets.Name)
	
	ply:SetNWInt("currency_resin", ply.hl2cr.Resin)
	ply:SetNWInt("currency_essence", ply.hl2cr.Essence)
	
	ply:SetNWString("inv_slots", table.concat(ply.hl2cr.Inventory.Slots, " "))
	ply:SetNWString("inv_weaponslot", ply.hl2cr.Inventory.CurWeaponSlot)
	ply:SetNWInt("inv_totalslots", ply.hl2cr.Inventory.TotalSlots)
	
	ply:SetNWInt("stat_totalachs", #ply.hl2cr.Achievements)
	
	ply:SetNWInt("config_playerdrawdist", ply.hl2cr.Config.PlayerSettings["PlayerDrawDistance"])
	ply:SetNWBool("config_shouldendmusicplay", ply.hl2cr.Config.PlayerSettings["ShouldPlayEndMusic"])
	ply:SetNWString("config_playerfont", ply.hl2cr.Config.PlayerSettings["PlayerFont"])
	
	ply:SetNWInt("config_npcdrawdist", ply.hl2cr.Config.NPCSettings["NPCDrawDistance"])
	ply:SetNWInt("config_npcfont", ply.hl2cr.Config.NPCSettings["NPCFont"])
	
	ply:SetNWString("config_npccolours_easy", ply.hl2cr.Config.NPCSettings["Colours"][1].r .. " " .. ply.hl2cr.Config.NPCSettings["Colours"][1].g .. " " ..  ply.hl2cr.Config.NPCSettings["Colours"][1].b .. " 255")
	
	ply:SetNWString("config_npccolours_medium", ply.hl2cr.Config.NPCSettings["Colours"][2].r .. " " .. ply.hl2cr.Config.NPCSettings["Colours"][2].g .. " " ..  ply.hl2cr.Config.NPCSettings["Colours"][2].b .. " 255")
	
	ply:SetNWString("config_npccolours_hard", ply.hl2cr.Config.NPCSettings["Colours"][3].r .. " " .. ply.hl2cr.Config.NPCSettings["Colours"][3].g .. " " ..  ply.hl2cr.Config.NPCSettings["Colours"][3].b .. " 255")
end

local function CreateData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")
	
	-- Create and init persistent data fields
	InitData(ply)
	
	-- Store all persistent data as JSON
	file.Write("hl2cr_data/" .. PlayerID .. ".txt", util.TableToJSON(ply.hl2cr, true))
end


local function LoadData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")
	local jsonContent = file.Read("hl2cr_data/" .. PlayerID .. ".txt", "DATA")
	if not jsonContent then return false end

	-- Read persistent data from JSON
	ply.hl2cr = util.JSONToTable(jsonContent)

	-- Init not set fields of persistent data
	InitData(ply)
	
	-- Init player model and other stuff
	ply:SetModel(ply.hl2cr.Model)
	
	return true -- Return true to signal that the settings could be loaded
end

local function SaveData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")

	-- Store all persistent data as JSON
	file.Write("hl2cr_data/" .. PlayerID .. ".txt", util.TableToJSON(ply.hl2cr, true))
	
end

--If there isn't a HL2CR data folder, create one
hook.Add("Initialize", "CreateDataFolder", function()
	if not file.IsDir( "hl2cr_data", "DATA") then
		print("MISSING HL2CR FOLDER: Making new one")
		file.CreateDir("hl2cr_data", "DATA")
	end
end)

--When the player disconnects, save their data
hook.Add("PlayerDisconnected", "HL2CR_SaveDataDisconnect", function(ply) 
	SaveData(ply)

	if ply.pet and ply.pet:IsValid() then
		ply.pet:Remove()
	end
	
	if ply:GetNWEntity("hl2cr_grave") and ply:GetNWEntity("hl2cr_grave"):IsValid() then
		ply:GetNWEntity("hl2cr_grave"):Remove()
	end
end)

--Upon a map change or server shutdown, save everyones progress
hook.Add( "ShutDown", "HL2CR_MapChangeSave", function() 
	for _, ply in ipairs( player.GetAll() ) do
		SaveData(ply)
	end
end)

hook.Add("PlayerInitialSpawn", "HL2CR_NewPlayerCheck", function(ply)
	--If the player is a bot, set model to kleiner and stop there
	if ply:IsBot() then
		ply:SetModel("models/player/kleiner.mdl")
		return
	end

	--If its a new player, create a save file for saving
	if not LoadData(ply) then
		CreateData(ply)

		timer.Simple(3, function()
			GrantAchievement(ply, "Misc", "New_Arrival")
			net.Start("HL2CR_HelpMenu")
			net.Send(ply)
		
		end)
		return
	end
	
	--If its a returning player, load their save file
	LoadData(ply)
end)
