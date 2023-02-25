function SetUpLobbyMap()
	
	--GetConVar("hl2cr_survival"):SetInt(0)
	
	--Set each global state to GLOBAL_OFF
	game.SetGlobalState("gordon_invulnerable", GLOBAL_OFF)
	game.SetGlobalState("suit_no_sprint", GLOBAL_OFF)
	game.SetGlobalState("antlion_allied", GLOBAL_OFF)
	game.SetGlobalState("super_phys_gun", GLOBAL_OFF)
	game.SetGlobalState("gordon_precriminal", GLOBAL_OFF)
	game.SetGlobalState("friendly_encounter", GLOBAL_OFF)
	
	--Remove the extended map check so players can't accidently skip maps
	game.SetGlobalState("hl2cr_extendedmap", GLOBAL_DEAD)
	game.SetGlobalState("hl2cr_bringitem_whatbaby", GLOBAL_DEAD)
	game.SetGlobalState("hl2cr_bringitem_rollermine", GLOBAL_DEAD)
	game.SetGlobalState("hl2cr_bringitem_gnome", GLOBAL_DEAD)

	SPAWNING_WEAPONS = {
		"weapon_crowbar",
		"weapon_physcannon"
	}
	
	if game.GetMap() == "hl2cr_lobby_v2" then	--dumb secret lobby achievement
		CreateCustomTrigger(Vector(256,-86,42),Vector(196,-144,63), function(ent)
			if ent:IsPlayer() and ent:Team() == TEAM_ALIVE and !ent:HasAchievement("HL2CR_LAVA") then
				if !ent.lavafloor then 
					ent.lavafloor = 1 
				elseif ent.lavafloor == 4 then
					ent:GiveAchievement("HL2CR","HL2CR_LAVA")
				end
				return true
			end
			return false
		end,0,false)
	
		CreateCustomTrigger(Vector(-849,505,60),Vector(-905,613,60), function(ent)
			if ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
				if ent.lavafloor then
					if ent.lavafloor ==1 then ent.lavafloor = 2 end
					if ent.lavafloor ==3 then ent.lavafloor = 4 end
				end
				return true
			end
			return false
		end,0,false)
		
		CreateCustomTrigger(Vector(185,913,87),Vector(119,1048,59), function(ent)
			if ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
				if ent.lavafloor then
					if ent.lavafloor ==2 then ent.lavafloor = 3 end
				end
				return true
			end
			return false
		end,0,false)
	
		CreateCustomTrigger(Vector(336,-176,1),Vector(-1270,1502,-29), function(ent)
			if ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
				if ent.lavafloor then
					ent.lavafloor = nil
				end
				return true
			end
			return false
		end,0,false)
	
	end
end

function BeginCustom(map)
	RunConsoleCommand("changelevel", map)
end