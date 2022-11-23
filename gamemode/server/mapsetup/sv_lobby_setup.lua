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
end

function BeginCustom(map)
	RunConsoleCommand("changelevel", map)
end