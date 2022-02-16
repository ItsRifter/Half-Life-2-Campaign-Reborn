local GIMME_A_SECRET = {
	[1] = {
		["Colour"] = Color(255, 255, 255),
		["Message"] = "No"
	},
	
	[2] = {
		["Colour"] = Color(255, 255, 255),
		["Message"] = "I said no"
	},
	
	[3] = {
		["Colour"] = Color(255, 255, 255),
		["Message"] = "Again, I said no"
	},
	
	[4] = {
		["Colour"] = Color(255, 255, 255),
		["Message"] = "Can you please stop asking?"
	},
	
	[5] = {
		["Colour"] = Color(255, 0, 0),
		["Message"] = "STOP"
	},
	
	[6] = {
		["Colour"] = Color(255, 0, 0),
		["Message"] = "FOR CHRIST SAKE"
	},
	
	[7] = {
		["Colour"] = Color(255, 0, 0),
		["Message"] = "Do that one more time, I'll kick you"
	},
	
	[8] = {
		["Colour"] = Color(255, 255, 255),
		["Message"] = "Okay I lied, but still please stop"
	},
	
	[9] = {
		["Colour"] = Color(255, 255, 255),
		["Message"] = "..."
	},
	
	[10] = {
		["Colour"] = Color(255, 255, 255),
		["Message"] = "Okay fine, you win, take this achievement"
	},
	
	[11] = {
		["Colour"] = Color(255, 0, 0),
		["Message"] = "YOU'RE STILL ASKING?"
	}
}

local MODEL_GENDER = {
	["models/player/Group01/male_07.mdl"] = true,
}

local REQUEST_AMMO_LIMITS = {
	[1] = 60,
	[3] = 150,
	[4] = 225,
	[5] = 12,
	[6] = 10,
	[7] = 30,
	[8] = 3,
	[10] = 5
}

local DIFF_VOTES = {
	[1] = "VoteVEasy",
	[2] = "VoteEasy",
	[3] = "VoteMedium",
	[4] = "VoteHard",
	[5] = "VoteVHard",
}

hook.Add("PlayerSay", "HL2CR_UserCmds", function(ply, text, team)
	
	--Enables AFK mode on the player
	if text == "!afk" and (ply:Team() ~= TEAM_AFK and ply:Team() ~= TEAM_COMPLETED_MAP and ply:Team() ~= TEAM_DEAD) then
		ply:SetTeam(TEAM_AFK)
		BroadcastMessage(ENABLE_AFK, ply)
		EnableSpectateAFK(ply)
		ply.hl2cr.Misc.AFK = true
		return ""
	--Otherwise disable AFK mode on the player
	elseif text == "!afk" and ply:Team() == TEAM_AFK then
		ply:SetTeam(TEAM_ALIVE)
		BroadcastMessage(DISABLE_AFK, ply)
		DisableSpectate(ply)
		ply:Spawn()
		ply.hl2cr.Misc.AFK = false
		return ""
	--If they already completed the map, return an message
	elseif text == "!afk" and ply:Team() == TEAM_COMPLETED_MAP then
		BroadcastMessage(ERROR_AFK_FINISHED, ply)
		return ""
	elseif text == "!afk" and ply:Team() == TEAM_DEAD then
		BroadcastMessage(ERROR_AFK_DEAD, ply)
		return ""
	end
	
	if text == "!gimmeasecret" then
		ply.gimmeasecret = (ply.gimmeasecret or 0) + 1
		
		if ply.gimmeasecret == 10 then
			BroadcastMessage(GIMME_A_SECRET[ply.gimmeasecret], ply)
			GrantAchievement(ply, "Misc", "Unpleasant_Secret")
			return "" 
		end
		
		if ply.gimmeasecret > 11 then
			return ""
		end
		
		BroadcastMessage(GIMME_A_SECRET[ply.gimmeasecret], ply)

		return ""
	end
	
	if text == "!discord" then
		ply:SendLua( [[ gui.OpenURL("https://discord.gg/zvvZ2ugHQY") ]] )
		return ""
	end
	
	if text == "!ach" or text == "!achievement" then
		net.Start("HL2CR_OpenAch")
		net.Send(ply)
		return ""
	end
	
	if text == "!pet" or text == "!petmenu" then
		if ply.hl2cr.Level < 8 then 
			ply:ChatPrint("You are too low of a level to have pets!")
			return "" 
		end
		
		net.Start("HL2CR_OpenPets")
			net.WriteTable(ply.hl2cr.Pets)
		net.Send(ply)
		return ""
	end
	
	if text == "!custom" or text == "!coop" then
		if not MAPS_LOBBY[game.GetMap()] then
			ply:ChatPrint("You need to be in the lobby to use this!")
			return ""
		end
		
		net.Start("HL2CR_OpenCustomMap")
		net.Send(ply)
		return ""
	end
	
	if string.find(text, "!kickuser ") then
		local findName = string.sub(text, 11)
		if not findName then
			BroadcastMessage(ERROR_VOTEKICK_INVALID, ply)
			return ""
		end
		local target = nil
		
		for _, v in ipairs(player.GetAll()) do
			if target and string.find(target:Nick(), string.lower(string.sub(v:Nick(), 0, #findName))) then
				BroadcastMessage(ERROR_VOTEKICK_MULTINAME, ply)
				return ""
			end
				
			if string.find(findName, string.lower(string.sub(v:Nick(), 0, #findName))) and not string.find(findName, string.lower(string.sub(ply:Nick(), 0, #findName))) then
				target = v
			elseif string.find(findName, string.lower(string.sub(ply:Nick(), 0, #findName))) then
				BroadcastMessage(ERROR_VOTEKICK_SELF, ply)
				return ""
			end
		end
		
		
		if target then
			if target:IsAdmin() then
				BroadcastMessage(ERROR_VOTEKICK_ADMIN, ply)
				
				local WARN_VOTEKICK_ADMIN = {
					["Colour"] = Color(250, 230, 0),
					["Message"] = ply:Nick() .. " attempted to kick you but failed"
				}
				
				BroadcastMessage(WARN_VOTEKICK_ADMIN, target)
				
				return ""
			end
			HL2CR_Voting:StartKickVote(ply, "KickPlayer", target)
			HL2CR_Voting:PlayerVote(target, false)
		else
			BroadcastMessage(ERROR_VOTEKICK_NONAME, ply)
		end
		
		return ""
	end
	
	if text == "!help" then
		net.Start("HL2CR_HelpMenu")
		net.Send(ply)
		return ""
	end
	
	if text == "!svencoop" then
		GrantAchievement(ply, "Misc", "Sven_Coop")
		
		if ply.hl2cr.Config.PlayerSettings["SvenSecret"] == false then
			ply.hl2cr.Config.PlayerSettings["SvenSecret"] = true
		else
			ply.hl2cr.Config.PlayerSettings["SvenSecret"] = false
		end
		
		return ""
	end
	
	if text == "!diff" then
		local CHECK_DIFF_SETTING = {
			["Colour"] = Color(50, 215, 50),
			["Message"] = "CHECK_DIFF_SETTING",
			["Other"] = {
				["Player"] = "",
				["Time"] = "",
				["CurCompleted"] = "CHECK_DIFF_SETTING_" .. GetConVar("hl2cr_difficulty"):GetInt()
			}
		}
	
		BroadcastMessage(CHECK_DIFF_SETTING, ply)
		return ""
	end
	
	if string.find(text, "!diff ") then
		local diffVote = string.sub(text, 7)
	
		if (HL2CR_Voting.nextVoteTime - 120) > CurTime() then
			local ERROR_VOTE_COOLDOWN = {
				["Colour"] = Color(215, 50, 50),
				["Message"] = "ERROR_VOTE_COOLDOWN1",
				["Other"] = {
					["Player"] = "",
					["Time"] = string.FormattedTime((HL2CR_Voting.nextVoteTime - 120) - CurTime(), "%02i:%02i"),
					["CurCompleted"] = "ERROR_VOTE_COOLDOWN2"
				}
						
			}
			BroadcastMessage(ERROR_VOTE_COOLDOWN, ply)
			return ""
		end
		
		if tonumber(diffVote) == GetConVar("hl2cr_difficulty"):GetInt() then 
			BroadcastMessage(ERROR_VOTE_DIFF_ALREADYON, ply)
			return ""
		end
		
		HL2CR_Voting:StartVote(ply, DIFF_VOTES[tonumber(diffVote)])
		
		return ""
	end
	
	if text == "!surv" or text == "!survival" then
	
		if MAPS_LOBBY[game.GetMap()] then
			BroadcastMessage(ERROR_VOTE_LOBBY, ply)
			return ""
		end
	
		if (HL2CR_Voting.nextVoteTime - 120) > CurTime() then
			local ERROR_VOTE_COOLDOWN = {
				["Colour"] = Color(215, 50, 50),
				["Message"] = "ERROR_VOTE_COOLDOWN1",
				["Other"] = {
					["Player"] = "",
					["Time"] = string.FormattedTime((HL2CR_Voting.nextVoteTime - 120) - CurTime(), "%02i:%02i"),
					["CurCompleted"] = "ERROR_VOTE_COOLDOWN2"
				}
						
			}
			BroadcastMessage(ERROR_VOTE_COOLDOWN, ply)
			return ""
		end

		if GetConVar("hl2cr_survival"):GetInt() == 0 then
			HL2CR_Voting:StartVote(ply, "EnableSurvival")
		else
			HL2CR_Voting:StartVote(ply, "DisableSurvival")
		end
		
		return ""
	end
	
	if text == "!specnpc" or text == "!specialnpcs" then
	
		if MAPS_LOBBY[game.GetMap()] then
			BroadcastMessage(ERROR_VOTE_LOBBY, ply)
			return ""
		end
	
		if (HL2CR_Voting.nextVoteTime - 120) > CurTime() then
			local ERROR_VOTE_COOLDOWN = {
				["Colour"] = Color(215, 50, 50),
				["Message"] = "ERROR_VOTE_COOLDOWN1",
				["Other"] = {
					["Player"] = "",
					["Time"] = string.FormattedTime((HL2CR_Voting.nextVoteTime - 120) - CurTime(), "%02i:%02i"),
					["CurCompleted"] = "ERROR_VOTE_COOLDOWN2"
				}
						
			}
			BroadcastMessage(ERROR_VOTE_COOLDOWN, ply)
			return ""
		end

		if GetConVar("hl2cr_specials"):GetInt() == 0 then
			HL2CR_Voting:StartVote(ply, "EnableSpecials")
		else
			HL2CR_Voting:StartVote(ply, "DisableSpecials")
		end
		
		return ""
	end

	if text == "!config" or text == "!settings" then
		net.Start("HL2CR_SettingsMenu")
		net.Send(ply)
		return ""
	end
	
	if text == "!seat" then
		if not ply:InVehicle() then
			BroadcastMessage(ERROR_NO_JEEP, ply)
			return ""
		
		elseif ply:GetVehicle():GetOwner() != ply then
			BroadcastMessage(ERROR_JEEP_OWNER, ply)
			return ""
		elseif ply:GetVehicle():GetClass() != "prop_vehicle_jeep" then 
			BroadcastMessage(ERROR_JEEP_INVALID, ply)
			return ""
		
		elseif ply.HasSeat then
			BroadcastMessage(ERROR_JEEP_SEAT_EXIST, ply)
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
	
	if text == "!vrm" then
		
		if HL2CR_Voting.nextVoteTime > CurTime() then
			local ERROR_VOTE_COOLDOWN = {
				["Colour"] = Color(215, 50, 50),
				["Message"] = "ERROR_VOTE_COOLDOWN1",
				["Other"] = {
					["Player"] = "",
					["Time"] = string.FormattedTime(HL2CR_Voting.nextVoteTime - CurTime(), "%02i:%02i"),
					["CurCompleted"] = "ERROR_VOTE_COOLDOWN2"
				}
					
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
				["Message"] = "ERROR_VOTE_COOLDOWN1",
				["Other"] = {
					["Player"] = "",
					["Time"] = string.FormattedTime(HL2CR_Voting.nextVoteTime - CurTime(), "%02i:%02i"),
					["CurCompleted"] = "ERROR_VOTE_COOLDOWN2"
				}
					
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
	
	if text == "!vba" or text == "!votebringalyx" then
		if not ents.FindByClass("npc_alyx")[1] then return "" end
		if ply.WaitBring and ply.WaitBring > CurTime() then return "" end
		--if ply.hl2cr.Level < 5 then return "" end

		HL2CR_Voting:StartVoteBring(ply, "BringAlyxVote")

		return ""
	end

	if text == "!vbb" or text == "!votebringbarney" then
		if not ents.FindByClass("npc_barney")[1] then return "" end
		if ply.WaitBring and ply.WaitBring > CurTime() then return "" end
		--if ply.hl2cr.Level < 5 then return "" end

		HL2CR_Voting:StartVoteBring(ply, "BringBarneyVote")

		return ""
	end

	if text == "!petsummon" or text == "!summonpet" then
		if !ply:Alive() or ply:Team() == 2 then return end
		
		if table.IsEmpty(ply.hl2cr.Pets) then
			BroadcastMessage(ERROR_PET_UNAVAILABLE, ply)
			return ""
		end
		
		if table.IsEmpty(ply.hl2cr.Pets.CurrentPet) then
			BroadcastMessage(ERROR_PET_NOPET, ply)
			return ""
		end
	
		if ply.pet and ply.pet:IsValid() then
			BroadcastMessage(ERROR_PET_EXISTS, ply)
			return
		end
		
		if NO_PETS_MAPS[game.GetMap()] then
			BroadcastMessage(ERROR_PET_INVALIDMAP, ply)
			return ""
		end
		
		if ply.petcool and ply.petcool > CurTime() then
			local ERROR_PET_COOLDOWN = {
				["Colour"] = Color(215, 50, 50),
				["Message"] = "Slow down! please wait " .. math.Round(ply.petcool - CurTime()) .. " seconds"
			}
						
			BroadcastMessage(ERROR_PET_COOLDOWN, ply)
			return ""
		end
		
		SpawnPet(ply)
		
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
	
	if string.find(text, "!petname ") or string.find(text, "!namepet ") then
		if not ply.pet then
			BroadcastMessage(ERROR_PET_NONEXISTS, ply)
			return ""
		end
		
		local checkName = string.sub(text, 10)
		
		if string.len(checkName) > 16 then
			BroadcastMessage(ERROR_PET_LONGNAME, ply)
			return ""
		end	
		
		ply.hl2cr.Pets.CurrentPet.name = checkName
				
		ply:SetNWString("pet_name", ply.hl2cr.Pets.CurrentPet.name)
		
		local SET_PET_NAME = {
			["Colour"] = Color(50, 215, 50),
			["Message"] = "Pet renamed to '" .. ply.hl2cr.Pets.CurrentPet.name .. "'"
		}
		
		BroadcastMessage(SET_PET_NAME, ply)
		
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
		
		ply.pet.teleport = true
		ply.pet:SetPos(ply:GetPos())
		ply.pet:SetAngles(ply:GetAngles())
		ply.bringCooldown = CurTime() + 6
	
		return ""
	end
	
	if text == "!petremove" or text == "!removepet" then
		if not ply.pet then
			BroadcastMessage(ERROR_PET_INVALID, ply)
			return ""
		end
		
		if ply.petcool > CurTime() then
			local ERROR_PET_COOLDOWN = {
				["Colour"] = Color(215, 50, 50),
				["Message"] = "Slow down! please wait " .. math.Round(ply.petcool - CurTime()) .. " seconds"
			}
						
			BroadcastMessage(ERROR_PET_COOLDOWN, ply)
			return ""
		end
		
		RemovePet(ply)
		
		return ""
	end
		
	if (text == "barney says fuck you" or text == "barney said fuck you") and game.GetMap() == "d3_breen_01" then
		GrantAchievement(ply, "HL2", "Barney_Wish")
	end
end)

local VOICES = {
	["Medic"] = "RequestMedic",
	["Armor"] = "RequestArmor",
	["Ammo"] = "RequestAmmo"
}

net.Receive("HL2CR_HelpNotify", function(len, ply)
	if not ply then return end 
	
	local helpNeeded = net.ReadString()
		
	if timer.Exists(ply:Nick() .. "_time") then return end

	ply:SetNWString("hl2cr_request", VOICES[helpNeeded])
	
	timer.Create(ply:Nick() .. "_time", 6, 1, function()
		ply:SetNWString("hl2cr_request", "")
	end)
	
	if helpNeeded == "Medic" or helpNeeded == "Armor" then
		if ply.hl2cr.Config.PlayerSettings["SvenSecret"] == true then
			ply:EmitSound("hl2cr/request/medic/classic_medic.mp3")
			return
		end
		
		if string.find(ply:GetModel(), "female") then
			ply:EmitSound("hl2cr/request/medic/female_request_medic_" .. math.random(1, 2) .. ".wav")
		else
			ply:EmitSound("hl2cr/request/medic/male_request_medic_" .. math.random(1, 2) .. ".wav")
		end
		
	elseif helpNeeded == "Ammo" then
		
		if string.find(ply:GetModel(), "female") then
			ply:EmitSound("hl2cr/request/ammo/female_request_ammo_" .. math.random(1, 3) .. ".wav")
		else
			ply:EmitSound("hl2cr/request/ammo/male_request_ammo_" .. math.random(1, 3) .. ".wav")
		end
		
	end
end)

concommand.Add("hl2cr_stopvote", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	HL2CR_Voting:StopVote()
end)

concommand.Add("hl2cr_admin_message", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	local ADMIN_MESSAGE = {
		["Colour"] = string.ToColor(args[2]),
		["Message"] = args[1]
	}
	
	BroadcastMessage(ADMIN_MESSAGE)
end)

concommand.Add("hl2cr_admin_sound", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	BroadcastSound(args[1])
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
	
	ply.pet:SetPos(ply:GetPos())
	ply.pet:SetAngles(ply:GetAngles())
	ply.bringCooldown = CurTime() + 6

	
end)

concommand.Add("hl2cr_petremove", function(ply, cmd, args)
	if not ply.pet then
		BroadcastMessage(ERROR_PET_INVALID, ply)
		return
	end
	
	if ply.petcool and ply.petcool > CurTime() then
		local ERROR_PET_COOLDOWN = {
			["Colour"] = Color(215, 50, 50),
			["Message"] = "Slow down! please wait " .. math.Round(ply.petcool - CurTime()) .. " seconds"
		}
					
		BroadcastMessage(ERROR_PET_COOLDOWN, ply)
		return ""
	end
	
	RemovePet(ply)
	
end)

concommand.Add("hl2cr_petsummon", function(ply, cmd, args)
	if !ply:Alive() or ply:Team() == 2 then return end
	
	if table.IsEmpty(ply.hl2cr.Pets) then
		BroadcastMessage(ERROR_PET_UNAVAILABLE, ply)
		return 
	end
	
	if table.IsEmpty(ply.hl2cr.Pets.CurrentPet) then
		BroadcastMessage(ERROR_PET_NOPET, ply)
		return
	end
	
	if ply.pet and ply.pet:IsValid() then
		BroadcastMessage(ERROR_PET_EXISTS, ply)
		return
	end
	
	if NO_PETS_MAPS[game.GetMap()] then
		BroadcastMessage(ERROR_PET_INVALIDMAP, ply)
		return 
	end
	
	if ply.petcool and ply.petcool > CurTime() then
		local ERROR_PET_COOLDOWN = {
			["Colour"] = Color(215, 50, 50),
			["Message"] = "Slow down! please wait " .. math.Round(ply.petcool - CurTime()) .. " seconds"
		}
					
		BroadcastMessage(ERROR_PET_COOLDOWN, ply)
		return
	end
	
	SpawnPet(ply)
	
end)

concommand.Add("hl2cr_forcevote", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	HL2CR_Voting:StartVote(ply, args[1])
end)

concommand.Add("hl2cr_customvote", function(ply, cmd, args)
	if not ply:IsAdmin() and not (string.find(ply:GetUserGroup(), "vip") or string.find(ply:GetUserGroup(), "vip+")) then return end
	
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

concommand.Add("hl2cr_addpetxp", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	AddPetXP(ply, args[1])
end)

concommand.Add("hl2cr_givexp", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	local target = nil
	
	for _, v in ipairs(player.GetAll()) do
		if target and string.find(target:Nick(), string.lower(string.sub(v:Nick(), 0, #args[1]))) then
			BroadcastMessage(ERROR_VOTEKICK_MULTINAME, ply)
			return
		end
		
		if string.find(string.lower(v:Nick()), string.lower(args[1])) then
			target = v
		end
	end
	
	if target then
		AddXP(target, args[2])
		target:ChatPrint("You were given " .. args[2] .. "XP by an admin")
		ply:ChatPrint(args[2] .. "XP given to " .. target:Nick())
	end
end)

concommand.Add("hl2cr_addresin", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	AddResin(ply, args[1])
end)

concommand.Add("hl2cr_giveresin", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	local target = nil
	
	for _, v in ipairs(player.GetAll()) do
		if target and string.find(target:Nick(), string.lower(string.sub(v:Nick(), 0, #args[1]))) then
			BroadcastMessage(ERROR_VOTEKICK_MULTINAME, ply)
			return
		end
		
		if string.find(string.lower(v:Nick()), string.lower(args[1])) then
			target = v
		end
	end
	
	if target then
		AddResin(target, args[2])
		target:ChatPrint("You were given " .. args[2] .. " Resin by an admin")
		ply:ChatPrint(args[2] .. " Resin given to " .. target:Nick())
	end
end)

concommand.Add("hl2cr_addsp", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	ply.hl2cr.SkillPoints = ply.hl2cr.SkillPoints + args[1]
end)

concommand.Add("hl2cr_givesp", function(ply, cmd, args)
	if not ply:IsAdmin() then return end
	
	local target = nil
	
	for _, v in ipairs(player.GetAll()) do
		if target and string.find(target:Nick(), string.lower(string.sub(v:Nick(), 0, #args[1]))) then
			BroadcastMessage(ERROR_VOTEKICK_MULTINAME, ply)
			return
		end
		
		if string.find(string.lower(v:Nick()), string.lower(args[1])) then
			target = v
		end
	end
	
	if target then
		target.hl2cr.SkillPoints = target.hl2cr.SkillPoints + args[2]
		target:ChatPrint("You were given " .. args[2] .. " Skillpoints by an admin")
		ply:ChatPrint(args[2] .. " Skillpoints given to " .. target:Nick())
	end
end)