--Afk Kicker by Salamafet, fitted for hl2cr
AFK_WARN_TIME = 150
AFK_TIME = 300

hook.Add("PlayerInitialSpawn", "MakeAFKVar", function(ply)
	ply.NextAFK = CurTime() + AFK_TIME
end)

hook.Add("Think", "HandleAFKPlayers", function()
	for _, ply in ipairs(player.GetAll()) do
		if ( ply:IsConnected() and ply:IsFullyAuthenticated() ) then
			if ply:IsAdmin() then continue end
			if ply:Team() == TEAM_AFK then continue end

			if (!ply.NextAFK) then
				ply.NextAFK = CurTime() + AFK_TIME
			end

			local afktime = ply.NextAFK
			if (CurTime() >= afktime - AFK_WARN_TIME) and (!ply.Warning) and ply:Team() ~= TEAM_AFK then
				ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Server_Warning_AFK"))
				ply:BroadcastSound("HL1/fvox/buzz.wav")
				
				ply.Warning = true
			elseif (CurTime() >= afktime) and (ply.Warning) ~= TEAM_AFK then
				ply.Warning = nil
				ply.NextAFK = nil
				ply:Kick("Kicked for being AFK too long")
			end
		end
	end
end)

hook.Add("KeyPress", "PlayerMoved", function(ply, key)
	
	ply.NextAFK = CurTime() + AFK_TIME

	if ply.Warning == true then
		ply.Warning = false
		ply:BroadcastMessage(HL2CR_GreenColour, translate.Get("Server_Warning_Returned"))
	end
end)