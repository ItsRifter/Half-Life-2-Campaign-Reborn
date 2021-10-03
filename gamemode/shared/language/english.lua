translate.AddLanguage("en", "English")
--Scoreboard
LANGUAGE.SCVersion						= "Version: "
LANGUAGE.SCLevel						= "Level: "
LANGUAGE.SCExprience					= "\nXP: "
--HUD
LANGUAGE.HUDPlayerGotLevel				= "User Level is now '"
LANGUAGE.HUDPlayerLeftTheGame			= " has left the server. REASON: "
LANGUAGE.HUDAdminAlert2					= " - has joined the server"
LANGUAGE.HUDSponerAlert					= "The Creator - "
LANGUAGE.HUDAdminAlert					= "An admin - "
LANGUAGE.HUDRareAch1					= " has earned a "
LANGUAGE.HUDRareAch2					= "RARE "
LANGUAGE.HUDRareAch3					= "achievement: "
LANGUAGE.HUDSkillPoints					= "UNUSED SKILL POINTS: "
LANGUAGE.HUDXP							= "XP"
LANGUAGE.HUDDeadPlayer					= "R.I.P: "
LANGUAGE.ReviveMe						= "Revive me!"
LANGUAGE.HUDHealthStatus1				= "Perfect"
LANGUAGE.HUDHealthStatus2				= "Great"
LANGUAGE.HUDHealthStatus3				= "Fine"
LANGUAGE.HUDHealthStatus4				= "Hurt"
LANGUAGE.HUDHealthStatus5				= "Wounded"
LANGUAGE.HUDHealthStatus6				= "Critical"
LANGUAGE.HUDStatus						= "Status: "
LANGUAGE.HUDPlayerHealth				= "HP: "
LANGUAGE.HUDPlayerArmor					= " / Armor: "
LANGUAGE.HUDPlayerPets 					= "'s Pet"

--Help menu
LANGUAGE.Welcome						= "Welcome to\n'Half-Life 2-\nCampaign Reborn'"
LANGUAGE.AlphaWarning 					= "This gamemode is currently in ALPHA\nExpect bugs and things to change"
LANGUAGE.UsefulInfo 					= "In events of map breaking, use !vrm / !restartmap\nTo get this menu back, use !help\nGoing afk? don't get kicked with !afk\nGive your buddy a ride in your jeep with !seat\nBind important commands with the prefix hl2cr_ \n(ask staff for full commands)\nWanna go back to the lobby? use !lobby\nUse the Q 'spawnmenu key' to access inventory etc.\nDon't like how things look/sound? try !config / !settings\nSomeone causing problems? use !kickuser [name]"
LANGUAGE.EarnedAchievement 				= " has earned the achievement: "
--Ending Results
LANGUAGE.TimeLeft 						= "Time left: "
LANGUAGE.StatKills						= "Total Kills: "
LANGUAGE.StatAchievement				= "Achievements Earned: "
LANGUAGE.StatBonus						= "Bonuses Earned: "
LANGUAGE.StatXP							= "XP Gained: "
LANGUAGE.StatResin						= "Resin Earned: "
LANGUAGE.ResinAmount					= "Resin: "
LANGUAGE.Resin							= " Resin"
--Chat announcements
LANGUAGE.ENABLE_AFK						= "You are now AFK"
LANGUAGE.DISABLE_AFK					= "You are no longer AFK"
LANGUAGE.ERROR_PET_LONGNAME				= "That name is too long!"
LANGUAGE.ERROR_AFK_DEAD					= "You cannot go into AFK mode while you are dead!"
LANGUAGE.ERROR_VEHICLE_MAP				= "Spawning vehicles are currently disabled"
LANGUAGE.ERROR_VEHICLE_INVALID			= "Your vehicle doesn't exist"
LANGUAGE.ERROR_VEHICLE_EXISTS			= "Your vehicle already exists"
LANGUAGE.ERROR_AFK_FINISHED				= "You cannot go into AFK mode while you have completed the map!"
LANGUAGE.ERROR_PET_EXISTS				= "Your pet already exists!"
LANGUAGE.ERROR_PET_NOPET				= "You need to set your current pet before summoning"
LANGUAGE.ERROR_PET_UNAVAILABLE			= "You need to own a pet first before you can summon"
LANGUAGE.ERROR_PET_NONEXISTS			= "Your pet doesn't exist"
LANGUAGE.ERROR_PET_BRINGING				= "Your pet will be brought to you soon..."
LANGUAGE.VOTE_SUCCESS_MAP				= "Vote Successful, Restarting map"
LANGUAGE.MAPS_HL2_FINISHED				= "Congratulations on finishing Half-Life 2, Returning to lobby in 40 seconds"
LANGUAGE.ERROR_CLASS_ALREADY_ASSIGNED	= "You are already assigned to this class!"
LANGUAGE.VOTE_SUCCESS_HL2				= "Vote Successful, Starting Half-Life 2"
LANGUAGE.VOTE_FAILED					= "Vote Failed"
LANGUAGE.VOTE_FAILED_ADMIN				= "Vote was stopped by admin"
LANGUAGE.VOTE_SUCCESS_LOBBY				= "Vote Successful, Returning to lobby"
LANGUAGE.ERROR_PET_INVALIDMAP			= "Pets are disabled on this map"
LANGUAGE.ERROR_PET_INVALID				= "Your pet doesn't exist!"
LANGUAGE.ERROR_VOTEKICK_MULTINAME		= "There are multiple targets with that name, be more specific"
LANGUAGE.ERROR_VOTEKICK_NONAME			= "There is no target with that name"
LANGUAGE.ERROR_VOTEKICK_INVALID			= "You need to specify a target"
LANGUAGE.ERROR_VOTEKICK_ADMIN			= "That target is an admin"
LANGUAGE.ERROR_VOTEKICK_SELF			= "You cannot votekick yourself"
LANGUAGE.CHECKPOINT_HIT					= "Checkpoint Reached"
LANGUAGE.ENABLED_AIRBOAT				= "Airboat is now spawnable\nUse F3 and F4"
LANGUAGE.ENABLED_AIRBOAT_GUN			= "Airboat with Gun is now spawnable\nUse F3 and F4"
LANGUAGE.ENABLED_JEEP					= "Jeep is now spawnable\nUse F3 and F4"
LANGUAGE.PLAYER_FINISHED				= " has finished the map in "
LANGUAGE.PLAYER_FINISHED2				= " (" .. team.NumPlayers(TEAM_COMPLETED_MAP) .. "/" .. #player.GetAll() .. ")"
LANGUAGE.ERROR_JEEP_OWNER				= "This jeep doesn't belong to you"
LANGUAGE.ERROR_JEEP_INVALID				= "You need to be in a Jeep to use this"
LANGUAGE.ERROR_NO_JEEP					= "You aren't in a vehicle"
LANGUAGE.ERROR_JEEP_SEAT_EXIST			= "You already have a passenger seat"
LANGUAGE.ACH_FAILED_SAND				= " stepped on the sand\nachievement failed"
--Skills
LANGUAGE.LEVEL_LOCKED					= "LOCKED\nREACH LEVEL "
LANGUAGE.SKILL_REQUIRES					= "\nREQUIRES: "
LANGUAGE.SKILLS_PASSIVE					= "Passive"
LANGUAGE.SKILLS_MEDIC					= "Field Medic"
LANGUAGE.SKILLS_REPAIRMAN				= "Repairman"
LANGUAGE.SKILLS_MECHANIC				= "Mechanic"
--Classes
LANGUAGE.PickClass						= "Pick class"
LANGUAGE.Class_Locked					= "LOCKED: Reach Level 5"
LANGUAGE.ASSIGNED_MESSAGE1				= "You have been assigned as '"
LANGUAGE.ASSIGNED_MESSAGE2				= "'\nYou will obtain your equipment next respawn"
--Statistics
LANGUAGE.Kills							= "Kills: "
LANGUAGE.Deaths							= " | Deaths: "
LANGUAGE.Average						= " | Average: "
LANGUAGE.Achievs						= "Total Achievements: "
LANGUAGE.Quests_Done					= "Quests completed: "
--Q Menu
LANGUAGE.Inv_Bar						= "Inv"
LANGUAGE.Skills_Bar						= "Skills"
LANGUAGE.Shop_Bar						= "Shop"
LANGUAGE.Pets_Bar						= "Pets"
LANGUAGE.Class_Bar						= "Class"
LANGUAGE.Statistics_Bar					= "Statistics"
LANGUAGE.Achievements_Bar				= "Achievements"
--Weapon Names
LANGUAGE.Flare_Gun						= "Flare Gun"
LANGUAGE.Multi_Grenade_Launcher			= "Multi Grenade Launcher"
LANGUAGE.BMG_Heavy_Sniper				= "50 BMG Heavy Sniper"
LANGUAGE.Automatic_Pistol				= "Automatic Pistol"
LANGUAGE.Shredding_Assault_Rifle		= "'Shredding' Assault Rifle"
LANGUAGE.Unstable_Electric_Shotgun		= "'Unstable' Electric Shotgun"
LANGUAGE.The_Nailer_Gun					= "The 'Nailer' Gun"
--Weapon Descriptions
LANGUAGE.Flare_Gun_desc					= "Used for emergencies...\nso it was"
LANGUAGE.Automatic_Pistol_desc			= "A pistol that is automatic\nno questions"
LANGUAGE.Shredding_Assault_Rifle_desc	= "This thing shreds people"
LANGUAGE.Unstable_Electric_Shotgun_desc	= "Highly unstable\nImmediately throw after use"
LANGUAGE.The_Nailer_Gun_desc			= "Nailed it!"
LANGUAGE.Multi_Grenade_Launcher_desc	= "A grenade launcher\nhandle with care"
LANGUAGE.BMG_Heavy_Sniper_desc			= "A rather heavy sniper\nwith devastating results"
LANGUAGE.WeaponCost						= "\n\nCOST: "
--Achievements
LANGUAGE.Ach_Locked						= "Locked"
--Voting
LANGUAGE.ERROR_VOTE_COOLDOWN1			= "You must wait "
LANGUAGE.ERROR_VOTE_COOLDOWN2			= " before calling this vote"
--Callout menu (C)
LANGUAGE.RequestMedic			= "Needs a medic"
LANGUAGE.RequestArmor			= "Needs armor"
LANGUAGE.RequestAmmo			= "Needs ammo"
