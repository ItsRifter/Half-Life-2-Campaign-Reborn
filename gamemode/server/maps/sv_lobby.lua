ENT_VOTE_HL2 = nil

function StartLobby()
	
	--Set each global state to 0
	game.SetGlobalState("gordon_invulnerable", 0)
	game.SetGlobalState("suit_no_sprint", 0)
	game.SetGlobalState("antlion_allied", 0)
	game.SetGlobalState("super_phys_gun", 0)
	game.SetGlobalState("gordon_precriminal", 0)
	game.SetGlobalState("friendly_encounter", 0)
	
	--Remove the Ravenholm check so players can't accidently skip maps
	if file.Exists("hl2cr_data/ravenholmcheck.txt", "DATA") then
		file.Delete("hl2cr_data/ravenholmcheck.txt", "DATA")
	end
	
	SPAWNING_WEAPONS = {
		"weapon_crowbar",
		"weapon_physcannon"
	}
	
	ENT_VOTE_HL2 = ents.FindByName("hl2_lambda_play_break")[1]
	--Same as above but for the bridge maps
	if file.Exists("hl2cr_data/bridgecheck.txt", "DATA") then
		file.Delete("hl2cr_data/bridgecheck.txt", "DATA")
	end

end

--Called from the map, plays a specific chapter of the map
--TODO: Implement each chapter, Johnny should add each chapter for the new map
function BeginHL2(chapter)
	if chapter == "D1" then
		RunConsoleCommand("changelevel", "d1_trainstation_01")
	elseif chapter == "D2" then
		RunConsoleCommand("changelevel", "d2_coast_01")
	elseif chapter == "D3" then
		RunConsoleCommand("changelevel", "d3_c17_02")
	elseif chapter == "lostcoast" then
		RunConsoleCommand("changelevel", "d2_lostcoast")
	end
end

function BeginCustom(map)
	RunConsoleCommand("changelevel", map)
end