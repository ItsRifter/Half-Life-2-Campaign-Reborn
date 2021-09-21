local function InitData(ply)
	-- Create persistent data field in ply
	ply.hl2cr = ply.hl2cr or {}

	-- Set some default settings
	
	--Player's name
	ply.hl2cr.Name = ply.hl2cr.Name or ply:Nick()
	
	--Level
	ply.hl2cr.Level = ply.hl2cr.Level or 0
	
	--Money/Experience
	ply.hl2cr.Money = ply.hl2cr.Money or 0
	ply.hl2cr.Exp = ply.hl2cr.Exp or 0
	ply.hl2cr.ReqExp = ply.hl2cr.ReqExp or 1000
	
	--Skills
	ply.hl2cr.SkillPoints = ply.hl2cr.SkillPoints or 0
	
	--Statistics
	ply.hl2cr.Deaths = ply.hl2cr.Deaths or 0
	ply.hl2cr.Kills = ply.hl2cr.Kills or 0
	
	--Misc
	ply.hl2cr.Model = ply.hl2cr.Model or "models/player/Group01/male_07.mdl"
	
	--Achievement + Progress
	ply.hl2cr.Achievements = ply.hl2cr.Achievements or {}
	ply.hl2cr.ProgressAch = ply.hl2cr.ProgressAch or {}
	
	ply:SetNWInt("stat_level", ply.hl2cr.Level)
	ply:SetNWInt("stat_exp", ply.hl2cr.Exp)
	ply:SetNWInt("stat_reqexp", ply.hl2cr.ReqExp)
	ply:SetNWInt("stat_skillpoints", ply.hl2cr.SkillPoints)

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
		return
	end
	--If its a returning player, load their save file
	LoadData(ply)
end)