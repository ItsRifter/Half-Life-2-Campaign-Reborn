MAPS_LOBBY = {
	--Future maps will go here
	["hl2cr_lobby_v2"] = true
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
	"hl2cr_lobby_v2"
}

function StartMapCountdown()
	for k, p in pairs(player.GetAll()) do
		net.Start("HL2CR_MapCountdown")
		net.Send(p)
	end
	
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
				RunConsoleCommand("changelevel", MAPS_HL2[k+1])
			end
		end
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
	else
		StartCoop()
	end
end
