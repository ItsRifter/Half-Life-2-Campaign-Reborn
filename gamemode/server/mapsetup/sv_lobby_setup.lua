function SetUpLobbyMap()
	
	--GetConVar("hl2cr_survival"):SetInt(0)
	
	--Set each global state to 0
	game.SetGlobalState("gordon_invulnerable", 0)
	game.SetGlobalState("suit_no_sprint", 0)
	game.SetGlobalState("antlion_allied", 0)
	game.SetGlobalState("super_phys_gun", 0)
	game.SetGlobalState("gordon_precriminal", 0)
	game.SetGlobalState("friendly_encounter", 0)
	
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