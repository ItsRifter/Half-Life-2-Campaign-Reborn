--Client side saved config file
Config_Changed = Config_Changed or false

function Config_Update()	--Ensures config is fully populated with vars
	Client_Config = Client_Config or {}
	Client_Config.NewCross = Client_Config.NewCross or false
end

function Config_Load()
	local jsonContent = file.Read("hl2cr_data/user_config.txt", "DATA")
	if jsonContent then Client_Config = util.JSONToTable(jsonContent) end

	Config_Update()
end
Config_Load()

function Config_Save()
	Config_Update()
	if not file.IsDir( "hl2cr_data", "DATA") then
		file.CreateDir("hl2cr_data", "DATA")
	end
	file.Write("hl2cr_data/user_config.txt", util.TableToJSON(Client_Config, true))
end

if timer.Exists( "Config_Tick" ) then timer.Remove( "Config_Tick" ) end	
timer.Create( "Config_Tick", 2, 0, function() 
	if Config_Changed then
		Config_Save()
		Config_Changed = false
	end
end )