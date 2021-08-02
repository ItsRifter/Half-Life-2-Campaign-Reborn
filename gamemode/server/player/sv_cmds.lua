hook.Add("PlayerSay", "HL2CR_UserCmds", function(ply, text, team)
	text = string.lower(text)
	
	--Enables AFK mode on the player
	if text == "!afk" and (ply:Team() ~= TEAM_AFK and ply:Team() ~= TEAM_COMPLETED_MAP) then
		ply:SetTeam(TEAM_AFK)
		ply:ChatPrint("You are now AFK")
		EnableSpectateAFK(ply)
		return ""
	--Otherwise disable AFK mode on the player
	elseif text == "!afk" and ply:Team() == TEAM_AFK then
		ply:SetTeam(TEAM_ALIVE)
		ply:ChatPrint("You are no longer AFK")
		DisableSpectate(ply)
		ply:Spawn()
		return ""
	--If they already completed the map, return an message
	elseif text == "!afk" and ply:Team() == TEAM_COMPLETED_MAP then
		ply:ChatPrint("You cannot go into AFK mode while you have completed the map!")
		return ""
	end
	
	if text == "!help" then
		net.Start("HL2CR_HelpMenu")
		net.Send(ply)
		return ""
	end
	
	--If the player votes to return to lobby...
	if text == "!lobby" then
		--If the timer isn't expired, return how long is left
		if HL2CR_Voting.nextVoteTime > CurTime() then
			ply:ChatPrint("You must wait " .. string.FormattedTime(HL2CR_Voting.nextVoteTime - CurTime(), "%02i:%02i") .. " before calling this vote")
			return ""
		end
		
		--If on the lobby map, return a message
		if MAPS_LOBBY[game.GetMap()] then
			ply:ChatPrint("You are currently on the lobby map!")
			return ""
		end
		
		--If all is passed, start a lobby vote
		HL2CR_Voting:StartVote(ply, "Lobby")
		return ""
	end
	
end)