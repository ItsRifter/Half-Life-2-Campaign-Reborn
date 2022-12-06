MapLua = MapLua or nil

MAPS_LOBBY = {
	--Future maps will go here
	["hl2cr_lobby_v2"] = true,
	["hl2cr_lobby_v3"] = true
}

MAPS_HL2 = {
	"d1_trainstation_01",
	"d1_trainstation_02",
	"d1_trainstation_03",
	"d1_trainstation_04",
	"d1_trainstation_05",
	"d1_trainstation_06",
	"d1_canals_01",
	"d1_canals_01a",
	"d1_canals_02",
	"d1_canals_03",
	"d1_canals_05",
	"d1_canals_06",
	"d1_canals_07",
	"d1_canals_08",
	"d1_canals_09",
	"d1_canals_10",
	"d1_canals_11",
	"d1_canals_12",
	"d1_canals_13",
	"d1_eli_01",
	"d1_eli_02",
	"d1_town_01",
	"d1_town_01a",
	"d1_town_02",
	"d1_town_03",
	"d1_town_02",
	"d1_town_02a",
	"d1_town_04",
	"d1_town_05",
	"d2_coast_01",
	"d2_coast_03",
	"d2_coast_04",
	"d2_coast_05",
	"d2_coast_07",
	"d2_coast_08",
	"d2_coast_09",
	"d2_coast_10",
	"d2_coast_11",
	"d2_coast_12",
	"d2_prison_01",
	"d2_prison_02",
	"d2_prison_03",
	"d2_prison_04",
	"d2_prison_05",
	"d2_prison_06",
	"d2_prison_07",
	"d2_prison_08",
	"d3_c17_01",
	"d3_c17_02",
	"d3_c17_03",
	"d3_c17_04",
	"d3_c17_05",
	"d3_c17_06a",
	"d3_c17_06b",
	"d3_c17_07",
	"d3_c17_08",
	"d3_c17_09",
	"d3_c17_10a",
	"d3_c17_10b",
	"d3_c17_11",
	"d3_c17_12",
	"d3_c17_12b",
	"d3_c17_13",
	"d3_citadel_01",
	"d3_citadel_03",
	"d3_citadel_04",
	"d3_citadel_05",
	"d3_breen_01",
}

MAPS_EP1 = {
	"ep1_citadel_00",
	"ep1_citadel_01",
	"ep1_citadel_02",
	"ep1_citadel_02b",
	"ep1_citadel_03",
	"ep1_citadel_04",
	"ep1_c17_00",
	"ep1_c17_00a",
	"ep1_c17_01",
	"ep1_c17_02",
	"ep1_c17_02b",
	"ep1_c17_02a",
	"ep1_c17_05",
	"ep1_c17_06"
}

MAPS_EP2 = {
	"ep2_outland_01",
	"ep2_outland_01a",
	"ep2_outland_02",
	"ep2_outland_03",
	"ep2_outland_04",
	"ep2_outland_05",
	"ep2_outland_06",
	"ep2_outland_06a",
	"ep2_outland_07",
	"ep2_outland_08",
	"ep2_outland_09",
	"ep2_outland_10",
	"ep2_outland_10a",
	"ep2_outland_11",
	"ep2_outland_11a",
	"ep2_outland_11b",
	"ep2_outland_12",
	"ep2_outland_12a",
}

MAPS_COOP_SYNB2 = {
	"level01_synb2_entryway_of_doom",
	"level02_synb2_tricks_and_traps",
	"level03_synb2_underground",
	"level04_synb2_across_the_darkness",
	"level05_synb2_diehard",
	"level06_synb2_base",
	"level07_synb2_scary_dark_house",
	"level08_synb2_a_place_to_die",
	"level09_synb2_choose_your_destiny",
	"level10_synb2_end_of_evil_part1_b1",

}

MAPS_COOP_RND = {
	"level_1a",
	"level_1b",
	"level_2",
	"level_3",
	"level_4a",
	"level_4b"
}

MAPS_COOP_IMPROBABLE = {
	"mimp1",
	"mimp_intermission",
	"mimp2",
	"mimp3"
}


function StartMapCountdown()
	
	BroadcastMessageToAll(HL2CR_StandardColour, translate.Get("Map_Finished"))
	BroadcastSoundToAll("hl1/fvox/bell.wav")

	timer.Simple(13, function()
		local repsMade = 1

		timer.Create("HL2CR_Countdown_Beep", 1, 5, function()

			BroadcastPitchedSoundToAll("hl1/fvox/beep.wav", 90 + (repsMade * 5))
			repsMade = repsMade + 1
		end)
	end)

	timer.Create("HL2CR_Countdown", 20, 1, function()
				
		--Lost Coast
		if game.GetMap() == "d2_lostcoast" then
			RunConsoleCommand("changelevel", "hl2cr_lobby_v2")
			return
		end
		
		--Half Life 2
		if game.GetMap() == "d1_town_02" then 
			if game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_DEAD then
				RunConsoleCommand("changelevel", "d1_town_03")
				return 
			elseif game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_ON then
				RunConsoleCommand("changelevel", "d1_town_02a")
				return 
			end
		end
		
		if game.GetMap() == "d1_town_03" then
			game.SetGlobalState("hl2cr_extendedmap", GLOBAL_ON)
			RunConsoleCommand("changelevel", "d1_town_02")
			return
		end
				
		if game.GetMap() == "d2_coast_08" then
			game.SetGlobalState("hl2cr_extendedmap", GLOBAL_ON)
			RunConsoleCommand("changelevel", "d2_coast_07")
			return 
		end

		if game.GetMap() == "d2_coast_07" and game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_ON then
			RunConsoleCommand("changelevel", "d2_coast_09")
			return
		end
		
		--Episode 2
		
		if game.GetMap() == "ep2_outland_02" then 
			if game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_DEAD then
				RunConsoleCommand("changelevel", "ep2_outland_03")
				return 
			elseif game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_ON then
				game.SetGlobalState("hl2cr_extendedmap", GLOBAL_DEAD)
				RunConsoleCommand("changelevel", "ep2_outland_05")
				return 
			end
		end
		
		if game.GetMap() == "ep2_outland_04" then
			game.SetGlobalState("hl2cr_extendedmap", GLOBAL_ON)
			RunConsoleCommand("changelevel", "ep2_outland_02")
			return 
		end
		
		for k = 1, #MAPS_HL2 do
			if game.GetMap() == MAPS_HL2[k] then
				if not MAPS_HL2[k+1] then
					RunConsoleCommand("changelevel", "hl2cr_lobby_v2")
					return
				end
				RunConsoleCommand("changelevel", MAPS_HL2[k+1])
				return
			end
		end
		
		for k = 1, #MAPS_EP1 do
			if game.GetMap() == MAPS_EP1[k] then
				if not MAPS_EP1[k+1] then
					RunConsoleCommand("changelevel", "hl2cr_lobby_v2")
					return
				end
				RunConsoleCommand("changelevel", MAPS_EP1[k+1])
				return
			end
		end
		
		for k = 1, #MAPS_EP2 do
			if game.GetMap() == MAPS_EP2[k] then
				if not MAPS_EP2[k+1] then
					RunConsoleCommand("changelevel", "hl2cr_lobby_v2")
					return
				end
				RunConsoleCommand("changelevel", MAPS_EP2[k+1])
				return
			end
		end

		for k = 1, #MAPS_COOP_SYNB2 do
			if game.GetMap() == MAPS_COOP_SYNB2[k] then
				if not MAPS_COOP_SYNB2[k+1] then
					RunConsoleCommand("changelevel", "hl2cr_lobby_v2")
					return
				end
				RunConsoleCommand("changelevel", MAPS_COOP_SYNB2[k+1])
				return
			end
		end
		
		for k = 1, #MAPS_COOP_RND do
			if game.GetMap() == MAPS_COOP_RND[k] then
				if not MAPS_COOP_RND[k+1] then
					RunConsoleCommand("changelevel", "hl2cr_lobby_v2")
					return
				end
				RunConsoleCommand("changelevel", MAPS_COOP_RND[k+1])
				return
			end
		end

		for k = 1, #MAPS_COOP_IMPROBABLE do
			if game.GetMap() == MAPS_COOP_IMPROBABLE[k] then
				if not MAPS_COOP_IMPROBABLE[k+1] then
					RunConsoleCommand("changelevel", "hl2cr_lobby_v2")
					return
				end
				RunConsoleCommand("changelevel", MAPS_COOP_IMPROBABLE[k+1])
				return
			end
		end
	end)
end

function StartFinalMapCountdown()
	timer.Create("HL2CR_Countdown", 60, 1, function()
		RunConsoleCommand("changelevel", "hl2cr_lobby_v2")
	end)
end

//In case the map is reset or cleaned up and hl2cr ents are leftever
//then they should be removed
local function ClearHL2CREntities()
	for _, cp in ipairs(ents.FindByClass("trigger_checkpoint")) do
		cp:Remove()
	end
	
	for _, push in ipairs(ents.FindByClass("trigger_pushback")) do
		push:Remove()
	end
	
end

--On a cleanup or post map start, Initialize the map to support HL2-CR
function GM:PostCleanupMap()
	BroadcastMessageToAll(HL2CR_StandardColour, translate.Get("Admin_Notify_Cleanup"))
	ClearHL2CREntities()
	InitMap()
end

function GM:InitPostEntity()
	ClearHL2CREntities()
	InitMap()
end

local function StartCountdownToLobby()
	timer.Create("HL2CR_LobbyTimer", 9000, 1, function()
		RunConsoleCommand("ChangeLevel", "hl2cr_lobby_v2")
	end)
end

--Initialize the map depending on which one is being played
function InitMap()
	if MAPS_LOBBY[game.GetMap()] then
		SetUpLobbyMap()
		return
	elseif string.find(game.GetMap(), "d1_") or string.find(game.GetMap(), "d2_") or string.find(game.GetMap(), "d3_") then
		StartHL2()
	elseif string.find(game.GetMap(), "ep1_") then
		StartEP1()
	elseif string.find(game.GetMap(), "ep2_") then
		StartEP2()
	else
		StartCoop()
	end
	
	StartCountdownToLobby()
end

function FailedMap()
	BroadcastSound("music/hl2_song23_suitsong3.mp3")
	timer.Simple(10, function()
		RunConsoleCommand("ChangeLevel", game.GetMap())
	end)
end

local mapChange = false

function CheckPlayerCompleted()
	if mapChange then return end
	
	if team.NumPlayers(TEAM_COMPLETED_MAP) <= 0 then return end

	--If the player count is over 4, check if completers is greater than total players divided
	if #player.GetAll() >= 4 and team.NumPlayers(TEAM_COMPLETED_MAP) > (math.ceil((team.NumPlayers(TEAM_ALIVE) / 2)) - team.NumPlayers(TEAM_DEAD)) then		
		mapChange = true
		StartMapCountdown()
	--else just check if completers is greater than alive players
	elseif #player.GetAll() < 4 and team.NumPlayers(TEAM_COMPLETED_MAP) > (team.NumPlayers(TEAM_ALIVE) - team.NumPlayers(TEAM_DEAD))  then		
		mapChange = true
		StartMapCountdown()
	end
end

function CreateCheckpoint(Min,Max,TPos,TAngle,func)
	local checkpoint = ents.Create("trigger_checkpoint")
	checkpoint.Min = Min
	checkpoint.Max = Max
	checkpoint.Pos = (Max + Min)/2
	checkpoint.TPPoint = TPos
	checkpoint.TPAngles = TAngle
	checkpoint.PointIndex = 99
	checkpoint:SetPos(checkpoint.Pos)
	checkpoint:Spawn()
	
	if func then
		checkpoint.Func = func
	end
	
	checkpoint.lambdaModel = ents.Create("prop_dynamic")
	checkpoint.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
	checkpoint.lambdaModel:SetPos( checkpoint.TPPoint + Vector(0, 0, 75))
	checkpoint.lambdaModel:Spawn()
	checkpoint.lambdaModel:ResetSequence("idle")
	checkpoint.lambdaModel:SetMaterial(checkpoint.Mat)
end

function RemoveNamedBrushes(toremove)	--Remove func_brushes whos names end with anything in the table listed
	for _, i in ipairs(ents.FindByClass("func_brush")) do
		for _, c in ipairs(toremove) do 
			if string.EndsWith(i:GetName(), c) then 
				--print("removing "..i:GetName())
				i:Remove()
				break
			end
		end
	end
end

local cmd_globalcheck = {
	["superphysgun"] = true,
	["antlionfriendly"] = true,
	["precriminal"] = true,
	["extend"] = true,
	["gnome"] = true,
	["whatbaby"] = true,
	["rollermine"] = true,
	["gnome"] = true,
}

local cmd_globalconvert = {
	["superphysgun"] = "super_phys_gun",
	["antlionfriendly"] = "antlion_allied",
	["precriminal"] = "gordon_precriminal",
	["extend"] = "hl2cr_extendedmap",
	["whatbaby"] = "hl2cr_bringitem_whatbaby",
	["rollermine"] = "hl2cr_bringitem_rollermine",
	["gnome"] = "hl2cr_bringitem_gnome",
}

local cmd_globals = {
	[1] = "superphysgun",
	[2] = "antlionfriendly",
	[3] = "precriminal",
	[4] = "extend",
	[5] = "whatbaby",
	[6] = "rollermine",
	[7] = "gnome",
}

local cmd_valid = {["0"]=true,["1"]=true,["2"]=true}

concommand.Add("hl2cr_admin_setglobal", function(ply, cmd, args)
	if not ply:IsSuperAdmin() then return end

	if not cmd_globalcheck[args[1]] then ply:BroadcastMessage(HL2CR_RedColour, "Global not found") return end
	if not cmd_valid[args[2]] then ply:BroadcastMessage(HL2CR_RedColour, "Invalid value, must be 0=off/1=on/2=dead") return end

	game.SetGlobalState(cmd_globalconvert[args[1]], args[2])
	BroadcastMessageToSupers(HL2CR_GreenColour, args[1], " set to ",args[2])
end)

concommand.Add("hl2cr_admin_getglobals", function(ply, cmd, args)
	if not ply:IsSuperAdmin() then return end

	for _, g in ipairs(cmd_globals) do
		ply:PrintMessage(HUD_PRINTCONSOLE, g)
	end
end)
