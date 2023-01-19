customloaded = false
local filename = engine.ActiveGamemode().."/gamemode/server/mapsetup/custom/"..game.GetMap()..".lua"
if  file.Exists( filename, "lsv" ) then 
	include(filename) 
	customloaded = true
end

local function SetUpCustom()
	local MapLua = ents.Create("lua_run")
	MapLua:SetName("hl2crlua")
	MapLua:Spawn()
	
	RemoveChangeLevel()	--remove all level changes from custom lua loaded maps
	
    if Custom_Startup then Custom_Startup() end
	if Custom_Equipment then Custom_Equipment() end

    --table.insert(SPAWNING_WEAPONS, "weapon_crowbar")
    --table.insert(SPAWNING_WEAPONS, "weapon_physcannon")
	
	if !Custom_triggers then return end
	
	if Custom_triggers["checkpoints"] then
        for i, t in ipairs(Custom_triggers["checkpoints"]) do
			local Tspot = Vector(Custom_triggers["checkpoint_spot"][i])
			local Tangle = Angle(Custom_triggers["checkpoint_angle"][i]) or nil
			local Tfunc = nil
			if Custom_triggers["checkpoint_functions"] then Tfunc = Custom_triggers["checkpoint_functions"][i] end
			CreateCheckpoint(Vector(t[1]),Vector(t[2]),Tspot,Tangle,Tfunc)
        end
    end
	
	if Custom_triggers["changelevels"] then
		local Tfunc = Custom_triggers["changelevel_func"] or nil
		local TVecs = Custom_triggers["changelevels"]
		CreateLevelChange(Vector(TVecs[1]),Vector(TVecs[2]),Tfunc)	
    end
	
    if Custom_triggers["pushers"] then
        for i, p in ipairs(Custom_triggers["pushers"]) do
			CreatePusher(Vector(p[1]),Vector(p[2]),Custom_triggers["pusher_spot"][i])
        end
    end
	
end

function StartCustom()
    if  file.Exists( filename, "lsv" ) then SetUpCustom() end
end