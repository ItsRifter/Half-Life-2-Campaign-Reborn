hook.Add("PlayerSay", "HL2CR_UserCmds", function(ply, text, team)
	text = string.lower(text)
	
	--Enables AFK mode on the player
	if text == "!afk" and (ply:Team() ~= TEAM_AFK and ply:Team() ~= TEAM_COMPLETED_MAP) then
		ply:SetTeam(TEAM_AFK)
		BroadcastMessage(ENABLE_AFK, ply)
		EnableSpectateAFK(ply)
		return ""
	--Otherwise disable AFK mode on the player
	elseif text == "!afk" and ply:Team() == TEAM_AFK then
		ply:SetTeam(TEAM_ALIVE)
		BroadcastMessage(DISABLE_AFK, ply)
		DisableSpectate(ply)
		ply:Spawn()
		return ""
	--If they already completed the map, return an message
	elseif text == "!afk" and ply:Team() == TEAM_COMPLETED_MAP then
		BroadcastMessage(ERROR_AFK_FINISHED, ply)
		return ""
	elseif text == "!afk" and ply:Team() == TEAM_DEAD then
		BroadcastMessage(ERROR_AFK_DEAD, ply)
		return ""
	end
	
	if text == "!help" then
		net.Start("HL2CR_HelpMenu")
		net.Send(ply)
		return ""
	end
	
	if text == "!seat" then
		if not ply:InVehicle() then
			ply:ChatPrint("You aren't in a vehicle")
			return ""

		elseif ply:GetVehicle():GetClass() != "prop_vehicle_jeep" then 
			ply:ChatPrint("You need to be in a Jeep to use this")
			return ""
		
		elseif ply.HasSeat then
			ply:ChatPrint("You already have a passenger seat")
			return""
			
		else
			local seat = ents.Create("prop_vehicle_prisoner_pod")
			seat:SetModel("models/nova/jeep_seat.mdl")
			seat:SetPos(ply:GetVehicle():LocalToWorld(Vector(21, -32, 18)))
			seat:SetAngles(ply:GetVehicle():LocalToWorldAngles(Angle(0, -3.5, 0)))
			seat:Spawn()
			seat:SetKeyValue("limitview", "1")
			seat:SetMoveType(MOVETYPE_NONE)
			seat:SetParent(ply:GetVehicle(), -1)
			seat.IsPassengerSeat = true
			
			ply.HasSeat = true
			
			return ""
		end
	end
	
	if text == "!restartmap" or text == "!vrm" then
		
		if HL2CR_Voting.nextVoteTime > CurTime() then
			local ERROR_VOTE_COOLDOWN = {
				["Colour"] = Color(215, 50, 50),
				["Message"] = "You must wait " .. string.FormattedTime(HL2CR_Voting.nextVoteTime - CurTime(), "%02i:%02i") .. " before calling this vote"
			}
			BroadcastMessage(ERROR_VOTE_COOLDOWN, ply)
			return ""
		end
		
		HL2CR_Voting:StartVote(ply, "Restart")
		return ""
	end
	
	--If the player votes to return to lobby...
	if text == "!lobby" then
		--If the timer isn't expired, return how long is left
		if HL2CR_Voting.nextVoteTime > CurTime() then
			local ERROR_VOTE_COOLDOWN = {
				["Colour"] = Color(215, 50, 50),
				["Message"] = "You must wait " .. string.FormattedTime(HL2CR_Voting.nextVoteTime - CurTime(), "%02i:%02i") .. " before calling this vote"
			}
			BroadcastMessage(ERROR_VOTE_COOLDOWN, ply)
			
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
	
	if text == "!petsummon" or text == "!summonpet" then
	
		if ply.pet then
			BroadcastMessage(ERROR_PET_EXISTS, ply)
			return ""
		end
		
		if NO_PETS_MAPS[game.GetMap()] then
			BroadcastMessage(ERROR_PET_INVALIDMAP, ply)
			return ""
		end
		
		if ply.spawnCooldown and ply.spawnCooldown > CurTime() then
			local ERROR_PET_COOLDOWN = {
				["Colour"] = Color(215, 50, 50),
				["Message"] = "Slow down! please wait " .. math.Round(ply.spawnCooldown - CurTime()) .. " seconds"
			}
						
			BroadcastMessage(ERROR_PET_COOLDOWN, ply)
			return ""
		end
		
		local tr = util.TraceHull( {
			start = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ( ply:GetAimVector() * 150 ),
			filter = ply,		
		} )
		
		local pet = ents.Create("hl2cr_pet_headcrab")
		pet:SetPos(tr.HitPos)
		pet:Spawn()
		pet:SetOwner(ply)
		pet:SetCustomCollisionCheck( true )
		
		pet:AddFlags( FL_OBJECT )
		
		ply.pet = pet
		ply.spawnCooldown = 5 + CurTime()
		return ""
	end
	
	if text == "!petfollow" then
		if not ply.pet then
			BroadcastMessage(ERROR_PET_NONEXISTS, ply)
			return ""
		end
		
		if not ply.pet.followOwner then
			ply.pet.followOwner = true
			ply:ChatPrint("Your pet is now following you")
		else
			ply.pet.followOwner = false
			ply:ChatPrint("Your pet has stopped following you")
		end
		
		return ""
	end	
	
	if text == "!petbring" or text == "!bringpet" then
		if ply:Team() == TEAM_COMPLETED_MAP or ply:Team() == TEAM_DEAD then return end
		
		if not ply.pet then
			BroadcastMessage(ERROR_PET_NONEXISTS, ply)
			return ""
		end
		
		if ply.bringCooldown and ply.bringCooldown > CurTime() then
			ply:ChatPrint("You can bring your pet again in " .. math.Round(ply.bringCooldown - CurTime()) .. " seconds")
			return ""
		end	
		
		if not ply.pet.teleport then
			ply.pet.teleport = true
		else
			BroadcastMessage(ERROR_PET_BRINGING, ply)
			return ""
		end
		
		return ""
	end
	
	if text == "!petremove" or text == "!removepet" then
		if not ply.pet then
			BroadcastMessage(ERROR_PET_INVALID, ply)
			return ""
		end
		
		if ply.spawnCooldown > CurTime() then
			local ERROR_PET_COOLDOWN = {
				["Colour"] = Color(215, 50, 50),
				["Message"] = "Slow down! please wait " .. math.Round(ply.spawnCooldown - CurTime()) .. " seconds"
			}
						
			BroadcastMessage(ERROR_PET_COOLDOWN, ply)
			return ""
		end
		
		ply.spawnCooldown = 5 + CurTime()
		if ply.pet:IsValid() then
			ply.pet:Remove()
		end
		ply.pet = nil
		return ""
	end	
end)

concommand.Add("hl2cr_stopvote", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	HL2CR_Voting:StopVote()
end)

concommand.Add("hl2cr_petbring", function(ply, cmd, args)
	if ply:Team() == TEAM_COMPLETED_MAP or ply:Team() == TEAM_DEAD then return end
		
	if not ply.pet then
		BroadcastMessage(ERROR_PET_NONEXISTS, ply)
		return
	end
	
	if ply.bringCooldown and ply.bringCooldown > CurTime() then
		local ERROR_PET_COOLDOWN = {
			["Colour"] = Color(215, 50, 50),
			["Message"] = "You can bring your pet again in " .. math.Round(ply.bringCooldown - CurTime()) .. " seconds"
		}
		
		BroadcastMessage(ERROR_PET_COOLDOWN, ply)
		return
	end
	
	if not ply.pet.teleport then
		ply.pet.teleport = true
	else
		BroadcastMessage(ERROR_PET_BRINGING, ply)
		return
	end
	
end)

concommand.Add("hl2cr_petremove", function(ply, cmd, args)
	if not ply.pet then
		BroadcastMessage(ERROR_PET_INVALID, ply)
		return
	end
	
	if ply.spawnCooldown and ply.spawnCooldown > CurTime() then
		local ERROR_PET_COOLDOWN = {
			["Colour"] = Color(215, 50, 50),
			["Message"] = "Slow down! please wait " .. math.Round(ply.spawnCooldown - CurTime()) .. " seconds"
		}
					
		BroadcastMessage(ERROR_PET_COOLDOWN, ply)
		return ""
	end
	
	ply.spawnCooldown = CurTime() + 5
	if ply.pet:IsValid() then
		ply.pet:Remove()
	end
	ply.pet = nil
end)

concommand.Add("hl2cr_petsummon", function(ply, cmd, args)
	if ply.pet then
		BroadcastMessage(ERROR_PET_EXISTS, ply)
		return
	end
	
	if NO_PETS_MAPS[game.GetMap()] then
		BroadcastMessage(ERROR_PET_INVALIDMAP, ply)
		return 
	end
	
	if ply.spawnCooldown and ply.spawnCooldown > CurTime() then
		local ERROR_PET_COOLDOWN = {
			["Colour"] = Color(215, 50, 50),
			["Message"] = "Slow down! please wait " .. math.Round(ply.spawnCooldown - CurTime()) .. " seconds"
		}
					
		BroadcastMessage(ERROR_PET_COOLDOWN, ply)
		return
	end
	
	local tr = util.TraceHull( {
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + ( ply:GetAimVector() * 150 ),
		filter = ply,		
	} )
		
	local pet = ents.Create("hl2cr_pet_headcrab")
	pet:SetPos(tr.HitPos)
	pet:Spawn()
	pet:SetOwner(ply)
	
	ply.spawnCooldown = CurTime() + 5
	ply.pet = pet
	
end)

concommand.Add("hl2cr_forcevote", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	HL2CR_Voting:StartVote(ply, args[1])
end)

concommand.Add("hl2cr_customvote", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	HL2CR_Voting:CustomVote(ply, args[1])
end)

concommand.Add("hl2cr_setlevel", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	ply.hl2cr.Level = args[1]
	
	ply:SetNWInt("stat_level", ply.hl2cr.Level)
end)

concommand.Add("hl2cr_addxp", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	AddXP(ply, args[1])
end)

concommand.Add("hl2cr_addresin", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	ply.hl2cr.Resin = ply.hl2cr.Resin + args[1]

	ply:SetNWInt("currency_resin", ply.hl2cr.Resin)
end)