--Afk Kicker by Salamafet, fitted for hl2cr
AFK_WARN_TIME = 8
AFK_TIME = 15

WARNING_AFK = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "WARNING_AFK"
}

WARNING_AFK2 = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "WARNING_AFK2"
}

MovingAfterAFK = {
	["Colour"] = Color(50, 215, 50),
	["Message"] = "MovingAfterAFK"
}

hook.Add("PlayerInitialSpawn", "MakeAFKVar", function(ply)
	ply.NextAFK = CurTime() + AFK_TIME
end)

hook.Add("Think", "HandleAFKPlayers", function()
	for _, ply in pairs (player.GetAll()) do
		if ( ply:IsConnected() and ply:IsFullyAuthenticated() ) then
			if ply:IsAdmin() then return end
			if ply:Team() == TEAM_AFK then return end

			if (!ply.NextAFK) then
				ply.NextAFK = CurTime() + AFK_TIME
			end

			local afktime = ply.NextAFK
			if (CurTime() >= afktime - AFK_WARN_TIME) and (!ply.Warning) and ply:Team() ~= TEAM_AFK then
				BroadcastMessage(WARNING_AFK, ply)
				BroadcastMessage(WARNING_AFK2, ply)
				ply:EmitSound("HL1/fvox/buzz.wav", 100, 100)
				
				ply.Warning = true
			elseif (CurTime() >= afktime) and (ply.Warning) ~= TEAM_AFK then
				ply.Warning = nil
				ply.NextAFK = nil
				ply:Kick("\nKicked for being AFK")
			end
		end
	end
end)

hook.Add("KeyPress", "PlayerMoved", function(ply, key)
	ply.NextAFK = CurTime() + AFK_TIME
	if ply.Warning == true then
		ply.Warning = false
		BroadcastMessage(MovingAfterAFK, ply)
	end
end)