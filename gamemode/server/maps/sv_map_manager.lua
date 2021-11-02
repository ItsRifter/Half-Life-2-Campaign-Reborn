MAPS_LOBBY = {
	--Future maps will go here
	["hl2cr_lobby_v2"] = true,
	["hl2cr_lobby_v3"] = true
}

ON_CITADEL_MAPS = false

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

MAPS_NH2 = {
	"nh1remake1_fixed",
	"nh2c1_v2",
	"nh2c2_v2",
	"nh2c3_v2",
	"nh2c4_v2",
	"nh2c5_v2",
	"nh2c6_v2",
	"nh2c7_v2"
}

MAPS_COOP_RND = {
	"level_1a",
	"level_1b",
	"level_2",
	"level_3",
	"level_4a",
	"level_4b"
}

function StartMapCountdown()
	
	timer.Create("HL2CR_Countdown", 20, 1, function()
		if game.GetMap() == "d2_lostcoast" then
			RunConsoleCommand("changelevel", "hl2cr_lobby_v2")
			return
		end
		
		if game.GetMap() == "d1_town_02" and not file.Exists("hl2cr_data/ravenholmcheck.txt", "DATA") then
			RunConsoleCommand("changelevel", "d1_town_03")
			return
		elseif file.Exists("hl2cr_data/ravenholmcheck.txt", "DATA") then
			RunConsoleCommand("changelevel", "d1_town_02a")
			return
		end
		
		if game.GetMap() == "d1_town_03" then
			file.Write("hl2cr_data/ravenholmcheck.txt", "raven check")
			RunConsoleCommand("changelevel", "d1_town_02")
			return
		end
		
		if game.GetMap() == "d2_coast_07" and not file.Exists("hl2cr_data/bridgecheck.txt", "DATA") then
			file.Write("hl2cr_data/bridgecheck.txt", "coast bridge check")
			RunConsoleCommand("changelevel", "d2_coast_08")
			return
		elseif game.GetMap() == "d2_coast_08" and file.Exists("hl2cr_data/bridgecheck.txt", "DATA") then
			RunConsoleCommand("changelevel", "d2_coast_07")
			return
		end
		
		if game.GetMap() == "d2_coast_07" and file.Exists("hl2cr_data/bridgecheck.txt", "DATA") then
			RunConsoleCommand("changelevel", "d2_coast_09")
			return 
		end
		
		for k = 1, #MAPS_HL2 do
			if game.GetMap() == MAPS_HL2[k] then
				if not MAPS_HL2[k+1] then
					RunConsoleCommand("changelevel", "hl2cr_lobby_v2")
				end
				RunConsoleCommand("changelevel", MAPS_HL2[k+1])
			end
		end
		
		for k = 1, #MAPS_EP1 do
			if game.GetMap() == MAPS_EP1[k] then
				if not MAPS_EP1[k+1] then
					RunConsoleCommand("changelevel", "hl2cr_lobby_v2")
				end
				RunConsoleCommand("changelevel", MAPS_EP1[k+1])
			end
		end

		for k = 1, #MAPS_COOP_SYNB2 do
			if game.GetMap() == MAPS_COOP_SYNB2[k] then
				if not MAPS_COOP_SYNB2[k+1] then
					RunConsoleCommand("changelevel", "hl2cr_lobby_v2")
				end
				RunConsoleCommand("changelevel", MAPS_COOP_SYNB2[k+1])
			end
		end
		
		for k = 1, #MAPS_COOP_RND do
			if game.GetMap() == MAPS_COOP_RND[k] then
				if not MAPS_COOP_RND[k+1] then
					RunConsoleCommand("changelevel", "hl2cr_lobby_v2")
				end
				RunConsoleCommand("changelevel", MAPS_COOP_RND[k+1])
			end
		end
		
		for k = 1, #MAPS_NH2 do
			if game.GetMap() == MAPS_NH2[k] then
				if not MAPS_NH2[k+1] then
					RunConsoleCommand("changelevel", "hl2cr_lobby_v2")
				end
				RunConsoleCommand("changelevel", MAPS_NH2[k+1])
			end
		end
	end)
end

function StartFinalMapCountdown()
	timer.Create("HL2CR_Countdown", 40, 1, function()
		RunConsoleCommand("changelevel", "hl2cr_lobby_v2")
	end)
end
--On a cleanup or post map start, Initialize the map to support HL2-CR
function GM:PostCleanupMap()
	InitMap()
end

function GM:InitPostEntity()
	InitMap()
end

--Initialize the map depending on which one is being played
function InitMap()
	if MAPS_LOBBY[game.GetMap()] then
		StartLobby()
	elseif string.find(game.GetMap(), "d1_") or string.find(game.GetMap(), "d2_") or string.find(game.GetMap(), "d3_") then
		StartHL2()
	elseif string.find(game.GetMap(), "ep1_") then
		StartEP1()
	else
		StartCoop()
	end
end

net.Receive("HL2CR_VoteCustomMap", function(len, ply)
	if not ply then return end
	
	local mapToLoad = net.ReadString()
	
	HL2CR_Voting:StartVote(ply, mapToLoad)
end)
