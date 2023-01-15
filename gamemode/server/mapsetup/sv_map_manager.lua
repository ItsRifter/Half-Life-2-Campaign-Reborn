MapLua = MapLua or nil

MAPS_LOBBY = {
	--Future maps will go here
	["hl2cr_lobby_v2"] = true,
	["hl2cr_lobby_v3"] = true
}

--global reference to which map is lobby
Lobby_map = "hl2cr_lobby_v2"

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


--Lets not have duplicate code if we can help it, this function now just handles all changes to next map calls
function ChangeToNextMap()
	--Lost Coast
	if game.GetMap() == "d2_lostcoast" then
		RunConsoleCommand("changelevel", Lobby_map)
		return
	end
	
	--Half Life 2
	if game.GetMap() == "d1_town_02" then 
		if game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_DEAD then
			RunConsoleCommand("changelevel", "d1_town_03")
			return 
		elseif game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_ON then
			game.SetGlobalState("hl2cr_extendedmap", GLOBAL_DEAD)
			RunConsoleCommand("changelevel", "d1_town_02a")
			return 
		end
	end
	
	if game.GetMap() == "d1_town_03" then
		game.SetGlobalState("hl2cr_extendedmap", GLOBAL_ON)
		RunConsoleCommand("changelevel", "d1_town_02")
		return
	end
			
	if game.GetMap() == "d2_coast_07" then 
		if game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_DEAD then
			RunConsoleCommand("changelevel", "d2_coast_08")
			return 
		elseif game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_ON then
			game.SetGlobalState("hl2cr_extendedmap", GLOBAL_DEAD)
			RunConsoleCommand("changelevel", "d2_coast_09")
			return 
		end
	end
			
	if game.GetMap() == "d2_coast_08" then
		game.SetGlobalState("hl2cr_extendedmap", GLOBAL_ON)
		RunConsoleCommand("changelevel", "d2_coast_07")
		return 
	end

	--if game.GetMap() == "d2_coast_07" and game.GetGlobalState("hl2cr_extendedmap") == GLOBAL_ON then
	--	RunConsoleCommand("changelevel", "d2_coast_09")
	--	return
	--end

	
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
	
	--Todo - Think of way to not cycle though entire list looking for value - Though might not be that important since unoticable
	--Plus any new maps can use the custom method and dont need a table then
	for k = 1, #MAPS_HL2 do
		if game.GetMap() == MAPS_HL2[k] then
			if not MAPS_HL2[k+1] then
				RunConsoleCommand("changelevel", Lobby_map)
				return
			end
			RunConsoleCommand("changelevel", MAPS_HL2[k+1])
			return
		end
	end
	
	for k = 1, #MAPS_EP1 do
		if game.GetMap() == MAPS_EP1[k] then
			if not MAPS_EP1[k+1] then
				RunConsoleCommand("changelevel", Lobby_map)
				return
			end
			RunConsoleCommand("changelevel", MAPS_EP1[k+1])
			return
		end
	end
	
	for k = 1, #MAPS_EP2 do
		if game.GetMap() == MAPS_EP2[k] then
			if not MAPS_EP2[k+1] then
				RunConsoleCommand("changelevel", Lobby_map)
				return
			end
			RunConsoleCommand("changelevel", MAPS_EP2[k+1])
			return
		end
	end

	for k = 1, #MAPS_COOP_SYNB2 do
		if game.GetMap() == MAPS_COOP_SYNB2[k] then
			if not MAPS_COOP_SYNB2[k+1] then
				RunConsoleCommand("changelevel", Lobby_map)
				return
			end
			RunConsoleCommand("changelevel", MAPS_COOP_SYNB2[k+1])
			return
		end
	end
	
	for k = 1, #MAPS_COOP_RND do
		if game.GetMap() == MAPS_COOP_RND[k] then
			if not MAPS_COOP_RND[k+1] then
				RunConsoleCommand("changelevel", Lobby_map)
				return
			end
			RunConsoleCommand("changelevel", MAPS_COOP_RND[k+1])
			return
		end
	end

	for k = 1, #MAPS_COOP_IMPROBABLE do
		if game.GetMap() == MAPS_COOP_IMPROBABLE[k] then
			if not MAPS_COOP_IMPROBABLE[k+1] then
				RunConsoleCommand("changelevel", Lobby_map)
				return
			end
			RunConsoleCommand("changelevel", MAPS_COOP_IMPROBABLE[k+1])
			return
		end
	end
	
	if Custom_NextMap then
		RunConsoleCommand("changelevel", Custom_NextMap)
		return
	end
	
	RunConsoleCommand("changelevel", Lobby_map)
end

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
		ChangeToNextMap()
	end)
end

function StartFinalMapCountdown()
	timer.Create("HL2CR_Countdown", 60, 1, function()
		RunConsoleCommand("changelevel", Lobby_map)
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
		RunConsoleCommand("ChangeLevel", Lobby_map)
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
		if customloaded then
			StartCustom()
		else
			StartCoop()
		end
	end
	
	StartCountdownToLobby()
end

function FailedMap()
	BroadcastSoundToAll("music/hl2_song23_suitsong3.mp3")
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

--------------------------------------------------------------------------------------------------------
------------------------------------Creation Functions--------------------------------------------------

--New global checkpoint creator
function CreateCheckpoint(Min,Max,TPos,TAngle,func)
	local checkpoint = ents.Create("trigger_checkpoint")
	checkpoint.Min = Min
	checkpoint.Max = Max
	checkpoint.Pos = (Max + Min)/2
	checkpoint.TPPoint = TPos
	checkpoint.TPAngles = TAngle or checkpoint.TPAngles
	--checkpoint.PointIndex = 99
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

--New global level change creator
function CreateLevelChange(Min,Max,func)
	local changelevel = ents.Create("trigger_changemap")
	changelevel.Min = Min
	changelevel.Max = Max
	changelevel.Pos = (Max + Min)/2
	
	changelevel:SetPos(changelevel.Pos)
	changelevel:Spawn()

	if func then
		changelevel.Func = func
	end

	changelevel.lambdaModel = ents.Create("prop_dynamic")
	changelevel.lambdaModel:SetModel("models/hl2cr_lambda.mdl")
	changelevel.lambdaModel:SetPos(changelevel.Pos)
	changelevel.lambdaModel:Spawn()
	changelevel.lambdaModel:ResetSequence("idle")
	changelevel.lambdaModel:SetMaterial("phoenix_storms/wire/pcb_green")
end

--New global pusher creator
function CreatePusher(Min,Max,Position)
	local pusher = ents.Create("trigger_pushback")
	pusher.Min = Min
	pusher.Max = Max
	pusher.Pos = (Max + Min)/2
	pusher:SetPos(pusher.Pos)
	pusher:Spawn()
	pusher.TPSpot = Position
end



--New Global function for spawning enemy and if they target closest player
function CreateEnemy(class,pos,angle,weapon, search)
	local enemy = ents.Create(class)
	enemy:SetPos(pos)
	enemy:SetAngles(angle)
	if weapon then enemy:Give( weapon ) end
	enemy:Spawn()
	
	if !search then return end
	
	local target = nil
	local distance = 1000
	local enemypos = enemy:GetPos()
	
	local positions = {}	--creating list of alive player positions
	for i, v in ipairs( player.GetAll() ) do	
		if v:Alive() then
			table.insert( positions, v )
		end
	end
	
	for i, v in ipairs( positions ) do	
		local toplayer = enemypos:Distance(v:GetPos())
		if toplayer > 50 and toplayer < distance then
			target = v
			distance = toplayer
		end
	end
	
	if IsValid(target) then
		enemy:SetEnemy( target , true)
		enemy:UpdateEnemyMemory( target, target:GetPos())
		enemy:SetActivity(11)
		enemy:SetArrivalDistance(128)
	end
	
end

--New global custom trigger creator
function CreateCustomTrigger(Min,Max,func, delay,once)
	local trigger = ents.Create("trigger_custom")
	trigger.Min = Min
	trigger.Max = Max
	trigger.Pos = (Max + Min)/2
	trigger:SetPos(trigger.Pos)
	trigger:Spawn()
	trigger.Func = func
	trigger.Delay = delay or 0
	trigger.Once = once or false
end


--Global Ammo Create making function, numbers marked X have wrong look but give that ammo
--0/Pistol 1/smg 2/Ar2Pulse 3/rpg 4/shotgun 5/grenades X-6/357magnum X-7/crossbow X-8/Ar2Balls 9/SmgNades
function CreateAmmoCrate(pos,angle,ammo)
	local AddAmmoCrate = ents.Create("item_ammo_crate")
	AddAmmoCrate:SetPos(pos)
	AddAmmoCrate:SetAngles(angle)
	AddAmmoCrate:SetKeyValue( "ammotype", ammo )
	AddAmmoCrate:Spawn()
end

--------------------------------------------------------------------------------------------------------
-------------------------------------Utility Functions--------------------------------------------------
--Handles moving of spawns and allows parenting
function MoveSpawns(TPPoint,TPAngles, parent)
	local NewPos = TPPoint
	if parent then 
		NewPos = parent:GetPos() +NewPos 
	else
		parent = nil
	end
	for l, spawn in pairs(ents.FindByClass("info_player_start")) do
		spawn:SetPos(NewPos)
		spawn:SetAngles(TPAngles )
		spawn:SetParent(parent)
	end
	for l, spawn in pairs(ents.FindByClass("info_player_deathmatch")) do
		spawn:SetPos(NewPos)
		spawn:SetAngles(TPAngles )
		spawn:SetParent(parent)
	end
end

--Handles teleporting players, can be set to not revive players, skip determins the player to not move
function MovePlayers(TPPoint,TPAngles, revive, skip)
	for _, p in pairs(player.GetAll()) do
		
		if p == skip then continue end

		if p:Team() == TEAM_COMPLETED_MAP then continue end
		
		if p:Team() == TEAM_DEAD and revive then
			p:Spawn()
		end
		
		GAMEMODE:RemoveVehicle(p)
		
		if p:Team() == TEAM_ALIVE then
			p:SetPos(TPPoint)
			p:SetEyeAngles(TPAngles)
		end
	end
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


