AddCSLuaFile()

votingTypes = {}
votingTypes["Lobby"] = {
	Description = translate.Get("Vote_Type_Lobby"),
	Callback = function(state)
		local positive, negative = countVotes(state)
		
		if positive > negative then
			BroadcastMessageToAll(HL2CR_GreenColour, translate.Get("Vote_Success_Lobby"))
			timer.Simple(5, function()
				RunConsoleCommand("ChangeLevel", "hl2cr_lobby_v2")
			end)
		else
			BroadcastMessageToAll(HL2CR_RedColour, translate.Get("Vote_Fail_Default"))
		end
	end
}

votingTypes["Restart"] = {
	Description = translate.Get("Vote_Type_RestartMap"),
	Callback = function(state)
		local positive, negative = countVotes(state)
		
		if positive > negative then
			BroadcastMessageToAll(HL2CR_GreenColour, translate.Get("Vote_Success_Map_Restart"))
			
			BroadcastSoundToAll("music/hl2_song23_suitsong3.mp3")
			timer.Simple(5, function()
				RunConsoleCommand("ChangeLevel", game.GetMap())
			end)
		else
			BroadcastMessageToAll(HL2CR_RedColour, translate.Get("Vote_Fail_Default"))
		end
	end
}

votingTypes["DiffNormal"] = {
	Description = translate.Get("Vote_Type_Diff_Normal"),
	Callback = function(state)
		local positive, negative = countVotes(state)
		
		if positive > negative then
			GetConVar("hl2cr_difficulty"):SetInt(1)
			
			for _, ent in ipairs(ents.FindByClass("npc_*")) do
				ent:SetStatsTraits()
			end

			BroadcastMessageToAll(HL2CR_GreenColour, translate.Get("Vote_Success_Difficulty"))
		else
			BroadcastMessageToAll(HL2CR_RedColour, translate.Get("Vote_Fail_Default"))
		end
	end
}

votingTypes["DiffHard"] = {
	Description = translate.Get("Vote_Type_Diff_Hard"),
	Callback = function(state)
		local positive, negative = countVotes(state)
		
		if positive > negative then
			GetConVar("hl2cr_difficulty"):SetInt(2)
			
			for _, ent in ipairs(ents.FindByClass("npc_*")) do
				ent:SetStatsTraits()
			end

			BroadcastMessageToAll(HL2CR_GreenColour, translate.Get("Vote_Success_Difficulty"))
		else
			BroadcastMessageToAll(HL2CR_RedColour, translate.Get("Vote_Fail_Default"))
		end
	end
}

votingTypes["DiffVHard"] = {
	Description = translate.Get("Vote_Type_Diff_VHard"),
	Callback = function(state)
		local positive, negative = countVotes(state)
		
		if positive > negative then
			GetConVar("hl2cr_difficulty"):SetInt(3)
			
			for _, ent in ipairs(ents.FindByClass("npc_*")) do
				ent:SetStatsTraits()
			end
			
			BroadcastMessageToAll(HL2CR_GreenColour, translate.Get("Vote_Success_Difficulty"))
		else
			BroadcastMessageToAll(HL2CR_RedColour, translate.Get("Vote_Fail_Default"))
		end
	end
}

votingTypes["DiffInsane"] = {
	Description = translate.Get("Vote_Type_Diff_Insane"),
	Callback = function(state)
		local positive, negative = countVotes(state)
		
		if positive > negative then
			GetConVar("hl2cr_difficulty"):SetInt(4)
			
			for _, ent in ipairs(ents.FindByClass("npc_*")) do
				ent:SetStatsTraits()
			end

			BroadcastMessageToAll(HL2CR_GreenColour, translate.Get("Vote_Success_Difficulty"))
		else
			BroadcastMessageToAll(HL2CR_RedColour, translate.Get("Vote_Fail_Default"))
		end
	end
}

votingTypes["DiffGF"] = {
	Description = translate.Get("Vote_Type_Diff_GF"),
	Callback = function(state)
		local positive, negative = countVotes(state)
		
		if positive > negative then
			GetConVar("hl2cr_difficulty"):SetInt(5)

			for _, ent in ipairs(ents.FindByClass("npc_*")) do
				ent:SetStatsTraits()
			end

			BroadcastMessageToAll(HL2CR_GreenColour, translate.Get("Vote_Success_Difficulty"))
		else
			BroadcastMessageToAll(HL2CR_RedColour, translate.Get("Vote_Fail_Default"))
		end
	end
}

votingTypes["EnableSurvival"] = {
	Description = translate.Get("Vote_Tyle_Survival_Enable"),
	Callback = function(state)
		local positive, negative = countVotes(state)
		
		if positive > negative then
			GetConVar("hl2cr_survival"):SetInt(1)
			
			
		else
			BroadcastMessageToAll(HL2CR_RedColour, translate.Get("Vote_Fail_Default"))
		end
	end
}

votingTypes["DisableSurvival"] = {
	Description = translate.Get("Vote_Tyle_Survival_Disable"),
	Callback = function(state)
		local positive, negative = countVotes(state)
		
		if positive > negative then
			GetConVar("hl2cr_survival"):SetInt(0)
			
		else
			BroadcastMessageToAll(HL2CR_RedColour, translate.Get("Vote_Fail_Default"))
		end
	end
}

votingTypes["BeginHL2"] = {
	Description = translate.Get("Vote_Type_MapSeries_HL2"),
	Callback = function(state)
		local positive, negative = countVotes(state)
		
		if positive > negative then
			BroadcastMessageToAll(HL2CR_GreenColour, translate.Get("Vote_Success_Map_HL2"))
			BroadcastSoundToAll("hl2cr/begin_game.wav")
			timer.Simple(10, function()
				RunConsoleCommand("changelevel", "d1_trainstation_01")
			end)
		else
			BroadcastMessageToAll(HL2CR_RedColour, translate.Get("Vote_Fail_Default"))
		end
	end
}

votingTypes["BeginEP1"] = {
	Description = translate.Get("Vote_Type_MapSeries_HL2_EP1"),
	Callback = function(state)
		local positive, negative = countVotes(state)
		
		if positive > negative then
			BroadcastMessageToAll(HL2CR_GreenColour, translate.Get("Vote_Success_Map_EP1"))
			BroadcastSoundToAll("hl2cr/begin_game.wav")
			timer.Simple(10, function()
				RunConsoleCommand("changelevel", "ep1_citadel_00")
			end)
		else
			BroadcastMessageToAll(HL2CR_RedColour, translate.Get("Vote_Fail_Default"))
		end
	end
}

votingTypes["BeginLostCoast"] = {
	Description = translate.Get("Vote_Type_MapSeries_HL2_LostCoast"),
	Callback = function(state)
		local positive, negative = countVotes(state)
		
		if positive > negative then
			BroadcastMessageToAll(HL2CR_GreenColour, translate.Get("Vote_Success_Map_HL2_LostCoast"))
			BroadcastSoundToAll("hl2cr/begin_game.wav")
			timer.Simple(10, function()
				RunConsoleCommand("changelevel", "d2_lostcoast")
			end)
		else
			BroadcastMessageToAll(HL2CR_RedColour, translate.Get("Vote_Fail_Default"))
		end
	end
}
