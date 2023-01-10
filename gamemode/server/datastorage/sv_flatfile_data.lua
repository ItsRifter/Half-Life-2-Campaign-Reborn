local function InitData(ply)
	-- Create persistent data field in ply
	ply.hl2cr = ply.hl2cr or {}

	-- Set some default settings
	
	--Player's name and model
	ply.hl2cr.Name = ply.hl2cr.Name or ply:Nick()
	ply.hl2cr.PMModel = ply.hl2cr.PMModel or "models/player/group01/male_07.mdl"
	
	--Level
	ply.hl2cr.Level = ply.hl2cr.Level or 0
	ply.hl2cr.Skills = ply.hl2cr.Skills or {}

	--Money/Experience
	ply.hl2cr.Resin = ply.hl2cr.Resin or 0
	ply.hl2cr.Exp = ply.hl2cr.Exp or 0
	ply.hl2cr.ReqExp = ply.hl2cr.ReqExp or 500
	ply.hl2cr.SkillPoints = ply.hl2cr.SkillPoints or 0

	--Achievements
	ply.hl2cr.Achievements = ply.hl2cr.Achievements or {}
	ply.hl2cr.AchProgress = ply.hl2cr.AchProgress or {}

	--Inventory
	ply.hl2cr.Inventory = ply.hl2cr.Inventory or {}
	ply.hl2cr.Inventory.Weight = ply.hl2cr.Inventory.Weight or 30.0
	ply.hl2cr.Inventory.CurWeight = ply.hl2cr.Inventory.CurWeight or 0.0
	ply.hl2cr.Inventory.Items = ply.hl2cr.Inventory.Items or {}
	ply.hl2cr.Inventory.Weapons = ply.hl2cr.Inventory.Weapons or {}
	ply.hl2cr.Inventory.Cosmetics = ply.hl2cr.Inventory.Cosmetics or {}
	
	--Cosmetics
	ply.hl2cr.CurCosmetic = ply.hl2cr.CurCosmetic or ""

	--Pets
	ply.hl2cr.Pets = ply.hl2cr.Pets or {}

	//ply.loaded = true --data is always init on load

	net.Start("HL2CR_Loaded")
	net.Send(ply)

	ply:UpdateNetworks()
end

local function CreateData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")
	
	-- Create and init persistent data fields
	InitData(ply)
	
	-- Store all persistent data as JSON
	file.Write("hl2cr_data/" .. PlayerID .. ".txt", util.TableToJSON(ply.hl2cr, true))

	timer.Simple(5, function()
		ply:GrantAchievement("Rise and Shine")
	end)
end


local function LoadData(ply)
    
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")
	local jsonContent = file.Read("hl2cr_data/" .. PlayerID .. ".txt", "DATA")
	if not jsonContent then return false end

	-- Read persistent data from JSON
	ply.hl2cr = util.JSONToTable(jsonContent)

	-- Init not set fields of persistent data
	InitData(ply)
		
	return true -- Return true to signal that the settings could be loaded
end

function SavePlayerData(ply)
	if GetConVar("hl2cr_nosaving"):GetInt() == 1 then return end
	
	//if !ply.loaded then return end
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")

	-- Store all persistent data as JSON
	file.Write("hl2cr_data/" .. PlayerID .. ".txt", util.TableToJSON(ply.hl2cr, true))
	
end

function WipePlayerData(ply)
	local PlayerID = string.Replace(ply:SteamID(), ":", "!")

	file.Delete("hl2cr_data/" .. PlayerID .. ".txt")
end

--If there isn't a HL2CR data folder, create one
hook.Add("Initialize", "CreateDataFolder", function()
	if not file.IsDir( "hl2cr_data", "DATA") then
		MsgC(HL2CR_GreenColour, "MISSING HL2CR FOLDER: Making new one\n")
		file.CreateDir("hl2cr_data", "DATA")
	end
end)

--When the player disconnects, save their data
hook.Add("PlayerDisconnected", "HL2CR_SavePlayerDataDisconnect", function(ply) 
	
	if not ply:IsBot() then
		if GetConVar("hl2cr_save_disconnectwipe"):GetInt() == 1 then
			WipePlayerData(ply)
		else
			SavePlayerData(ply)
		end
	end
	
	if ply.activePet then
		ply.activePet:RemovePet()
	end

	if ply.vehicle then 
		GAMEMODE:RemoveVehicle(ply)
	end

	if ply.Ragdoll ~= nil then
		ply.Ragdoll:Remove()
	end

	table.RemoveByValue(ply.hl2cr.AchProgress, "ZombieChopperActive")
	CheckPlayerCompleted()
end)

--Upon a map change or server shutdown, save everyones progress
hook.Add( "ShutDown", "HL2CR_MapChangeSave", function() 
	for _, ply in ipairs( player.GetAll() ) do
		if ply:IsBot() then continue end

		SavePlayerData(ply)
	end
end)

local function InitPlayer(ply)
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
	--LoadData(ply)
end

hook.Add("PlayerInitialSpawn", "HL2CR_NewPlayerCheck", function(ply)
	InitPlayer(ply)
end)

-- Why do we have this? this just wipes data when we didn't intend it to
-- -ItsRifter

-- local function InitialisePlayers() 
-- 	for k, v in pairs(player.GetAll()) do 
-- 		InitPlayer(v) 
-- 	end
-- end

-- timer.Simple(1, InitialisePlayers);