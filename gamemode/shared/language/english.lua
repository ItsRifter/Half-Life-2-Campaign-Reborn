translate.AddLanguage("en", "English")
--Scoreboard
LANGUAGE.SCVersion						= "Version: "
LANGUAGE.SCLevel						= "Level: "
LANGUAGE.Ping							= "Ping: "
LANGUAGE.SCExprience					= "\nXP: "
LANGUAGE.AlphaTester					= "This player is an alpha tester"
LANGUAGE.SuperAdmin						= "This player is a super admin"
LANGUAGE.Admin							= "This player is an admin"
LANGUAGE.Mod							= "This player is a moderator"

LANGUAGE.Donator						= "This player is a donator"
LANGUAGE.VIP							= "This player is a VIP"
LANGUAGE.VIPExtra						= "This player is a VIP+"
--HUD
LANGUAGE.HUDPlayerGotLevel				= "User Level is now '"
LANGUAGE.HUDPlayerLeftTheGame			= " has left the server. REASON: "
LANGUAGE.HUDAdminAlert2					= " - has joined the server"
LANGUAGE.HUDPlayerAlert					= " is joining the server"
LANGUAGE.HUDRifterAlert					= "The Creator - "
LANGUAGE.HUDLeiftigerAlert				= "Someone very special is joining..."
LANGUAGE.HUDAdminAlert					= "An admin - "
LANGUAGE.HUDRareAch1					= " has earned a "
LANGUAGE.HUDRareAch2					= "RARE "
LANGUAGE.HUDRareAch3					= "achievement: "
LANGUAGE.HUDSkillPoints					= "UNSPENT SKILL POINTS: "
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
LANGUAGE.HUDPlayerHealthUnknown			= "???"
LANGUAGE.HUDPlayerArmor					= " / Armor: "
LANGUAGE.HUDPlayerPets 					= "'s Pet"
LANGUAGE.Respawn						= "Respawn in: "
LANGUAGE.SpecNobody						= "Spectating: Nobody"
LANGUAGE.Spectate						= "Spectating: "
--Help menu
LANGUAGE.Welcome						= "Welcome to 'Half-Life 2- Campaign Reborn'"
LANGUAGE.WelcomeBoard					= "Welcome"
LANGUAGE.UsefulInfoBoard				= "Useful Info"
LANGUAGE.BeginPlayBoard					= "Begin Playing"
LANGUAGE.PlayBoard						= "Start"
LANGUAGE.AlphaWarning 					= "This gamemode is currently in ALPHA Expect bugs and things to change"
LANGUAGE.CreditsHelp					= "Credits Creator: Rifter \n Special Thanks to:\nD3, Nick, Birdman,\nNiik, The Supreme Combine"
LANGUAGE.UsefulInfo						= "In events of map breaking, use !vrm / !restartmap Vehicle spawning on F3, Remove on F4 To get this menu back, use !help Going afk? don't get kicked with !afk Give your buddy a ride in your jeep with !seat Bind important commands with the prefix hl2cr_  (ask staff for full commands) Wanna go back to the lobby? use !lobby Use the Q 'spawnmenu key' to access inventory etc. Don't like how things look/sound? try !config / !settings Someone causing problems? use !kickuser [name]"
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
LANGUAGE.EarnedAchievement 				= " has earned the achievement: "
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
LANGUAGE.ERROR_PET_UNAVAILABLE			= "You aren't ready to own a pet yet"
LANGUAGE.ERROR_PET_NONEXISTS			= "Your pet doesn't exist"
LANGUAGE.ERROR_PET_BRINGING				= "Your pet will be brought to you soon..."
LANGUAGE.VOTE_SUCCESS_MAP				= "Vote Successful, Restarting map"
LANGUAGE.MAPS_HL2_FINISHED				= "Congratulations on finishing Half-Life 2, Returning to lobby in 40 seconds"
LANGUAGE.ERROR_CLASS_ALREADY_ASSIGNED	= "You are already assigned to this class!"
LANGUAGE.VOTE_SUCCESS_HL2				= "Vote Successful, Starting Half-Life 2"
LANGUAGE.VOTE_SUCCESS_CUSTOM			= "Vote Successful, Starting Custom Map"
LANGUAGE.VOTE_FAILED					= "Vote Failed"
LANGUAGE.VOTE_DIFF						= "Vote Succeed, changing difficulty to "
LANGUAGE.VOTE_SURV_ON					= "Vote Succeed, survival mode enabled"
LANGUAGE.VOTE_SURV_OFF					= "Vote Succeed, survival mode disabled"
LANGUAGE.VOTE_FAILED_ADMIN				= "Vote was stopped by admin"
LANGUAGE.VOTE_SUCCESS_LOBBY				= "Vote Successful, Returning to lobby"
LANGUAGE.ERROR_PET_INVALIDMAP			= "Pets are disabled on this map"
LANGUAGE.ERROR_PET_INVALID				= "Your pet doesn't exist!"
LANGUAGE.ERROR_VOTEKICK_MULTINAME		= "There are multiple targets with that name, be more specific"
LANGUAGE.ERROR_VOTEKICK_NONAME			= "There is no target with that name"
LANGUAGE.ERROR_VOTEKICK_INVALID			= "You need to specify a target"
LANGUAGE.ERROR_VOTEKICK_ADMIN			= "That target is an admin"
LANGUAGE.ERROR_VOTEKICK_SELF			= "You cannot votekick yourself"
LANGUAGE.CHECKPOINT_HIT					= " reached a checkpoint"
LANGUAGE.ENABLED_AIRBOAT				= "Airboat is now spawnable Use F3 and F4"
LANGUAGE.ENABLED_AIRBOAT_GUN			= "Airboat with Gun is now spawnable Use F3 and F4"
LANGUAGE.ENABLED_JEEP					= "Jeep is now spawnable Use F3 and F4"
LANGUAGE.PLAYER_FINISHED				= " has finished the map in "
LANGUAGE.PLAYER_FINISHED2				= " (" .. team.NumPlayers(TEAM_COMPLETED_MAP) .. "/" .. #player.GetAll() .. ")"
LANGUAGE.ERROR_JEEP_OWNER				= "This jeep doesn't belong to you"
LANGUAGE.ERROR_JEEP_INVALID				= "You need to be in a Jeep to use this"
LANGUAGE.ERROR_NO_JEEP					= "You aren't in a vehicle"
LANGUAGE.ERROR_JEEP_SEAT_EXIST			= "You already have a passenger seat"
LANGUAGE.ACH_FAILED_SAND				= " stepped on the sand achievement failed"
LANGUAGE.ACH_FAILED_PACIFIST			= " killed a stalker achievement failed"
--Skills
LANGUAGE.LEVEL_LOCKED					= "LOCKED REACH LEVEL "
LANGUAGE.SKILL_REQUIRES					= " REQUIRES: "
LANGUAGE.SKILLS_PASSIVE					= "Passive"
LANGUAGE.SKILLS_MEDIC					= "Field Medic"
LANGUAGE.SKILLS_REPAIRMAN				= "Repairman"
LANGUAGE.SKILLS_SUPPLIER				= "Supplier"
LANGUAGE.SKILLS_ROCKETEER				= "Rocketeer"
LANGUAGE.SKILLS_ROBOT					= "Robot"
LANGUAGE.SKILLS_MECHANIC				= "Mechanic"
LANGUAGE.SpendToUnlock					= "Spend a skill-point to unlock"
--Classes
LANGUAGE.PickClass						= "Pick class"
LANGUAGE.Field_Medic_Desc				= "A field medic here to help the injured during combat"
LANGUAGE.Class_Locked					= "LOCKED: Reach Level 5"
LANGUAGE.ASSIGNED_MESSAGE1				= "You'll be assigned as '"
LANGUAGE.ASSIGNED_MESSAGE2				= "' by next respawn"
--Statistics
LANGUAGE.Kills							= "Kills: "
LANGUAGE.Deaths							= " | Deaths: "
LANGUAGE.Average						= " | Average: "
LANGUAGE.Achievs						= "Total Achievements: "
LANGUAGE.Quests_Done					= "Quests completed: "
--Q Menu
LANGUAGE.Inv_Bar						= "Inventory"
LANGUAGE.Skills_Bar						= "Skills"
LANGUAGE.Shop_Bar						= "Shop"
LANGUAGE.Class_Bar						= "Classes"
LANGUAGE.Statistics_Bar					= "Statistics"
LANGUAGE.Quests_Bar					= "Quests"
LANGUAGE.Achievements_Bar				= "Achievements"
LANGUAGE.Close							= "Close"
LANGUAGE.ArmorPoints					= "Armor Points: "

LANGUAGE.AssignQuest					= "Assign Quest"

--Pets Menu
LANGUAGE.Pets_Main						= "Main"
LANGUAGE.PET_MAX_LEVEL					= "Congratulations, your pet is now at max level, your pet will no longer earn xp at this point"
--Other Menu Translations
LANGUAGE.Ach_HL2_Bar					= "Half-Life 2"
LANGUAGE.Ach_EP1_Bar					= "Episode 1"
LANGUAGE.Ach_Misc_Bar					= "Misc"
LANGUAGE.Ach_Custom_Bar					= "Custom Maps"
--Weapon Names
LANGUAGE.Flare_Gun						= "Flare Gun"
LANGUAGE.Multi_Grenade_Launcher			= "Multi Grenade Launcher"
LANGUAGE.BMG_Heavy_Sniper				= "50 BMG Heavy Sniper"
LANGUAGE.Automatic_Pistol				= "Automatic Pistol"
LANGUAGE.Shredding_Assault_Rifle		= "'Shredding' Assault Rifle"
LANGUAGE.Unstable_Electric_Shotgun		= "'Unstable' Electric Shotgun"
LANGUAGE.The_Nailer_Gun					= "The 'Nailer' Gun"

--Item Names
LANGUAGE.Longfall_Boots 				= "Longfall Boots"
LANGUAGE.Metal_Boots 					= "Metal Boots"
LANGUAGE.Light_Vest 					= "Light Vest"
LANGUAGE.Heavy_Vest 					= "Heavy Vest"
LANGUAGE.HECU_Helm 						= "H.E.C.U Helmet"
LANGUAGE.Robo_Helm 						= "Robot Helmet"
LANGUAGE.Exosuit_Shoulders 				= "Exosuit Shoulders"
LANGUAGE.Exosuit_Vest 					= "Exosuit Vest"
LANGUAGE.Exosuit_Boots 					= "Exosuit Boots"
--Item Desc
LANGUAGE.Longfall_Boots_Desc 			= "Stolen from Black Mesa's peers\nRESIST: 0.75"
LANGUAGE.Metal_Boots_Desc				= "Metal and bulky\nRESIST: 0.35"
LANGUAGE.Light_Vest_Desc				= "Lighter alternative than the heavy vest\nRESIST: 0.65"
LANGUAGE.Heavy_Vest_Desc				= "Made to stop a bullet\nRESIST: 0.85"
LANGUAGE.HECU_Helm_Desc					= "Military grade Gasmask\nRESIST: 0.25"
LANGUAGE.Robo_Helm_Desc					= "Disasembled and safe to use for humans\nRESIST: 1"
LANGUAGE.Exosuit_Shoulders 				= "Part of an Exosuit\nRESIST: 0.65"
LANGUAGE.Exosuit_Vest_Desc 				= "Part of an Exosuit\nRESIST: 1.15"
LANGUAGE.Exosuit_Boots_Desc 			= "Part of an Exosuit\nRESIST: 0.45"



--Weapon Descriptions
LANGUAGE.Flare_Gun_desc					= "Used for emergencies... so it was"
LANGUAGE.Automatic_Pistol_desc			= "A pistol that is automatic no questions"
LANGUAGE.Shredding_Assault_Rifle_desc	= "This thing shreds people"
LANGUAGE.Unstable_Electric_Shotgun_desc	= "Highly unstable Immediately throw after use"
LANGUAGE.The_Nailer_Gun_desc			= "Nailed it!"
LANGUAGE.Multi_Grenade_Launcher_desc	= "A grenade launcher handle with care"
LANGUAGE.BMG_Heavy_Sniper_desc			= "A rather heavy sniper with devastating results"
LANGUAGE.WeaponCost						= "  COST: "
--Voting
LANGUAGE.ERROR_VOTE_COOLDOWN1			= "You must wait "
LANGUAGE.ERROR_VOTE_COOLDOWN2			= " before calling this vote"
LANGUAGE.ERROR_VOTE_DIFF_ALREADYON		= "The difficulty is already set to this setting"
LANGUAGE.ERROR_VOTE_LOBBY				= "You can't start this vote in the lobby"
--Callout menu (C)
LANGUAGE.RequestMedic			= "Needs a medic"
LANGUAGE.RequestArmor			= "Needs armor"
LANGUAGE.RequestAmmo			= "Needs ammo"
--Pets
LANGUAGE.EquipPet				= "Set Current Pet"
LANGUAGE.ConfirmSell			= "Confirm?"
LANGUAGE.SellPet				= "Sell Pet"
LANGUAGE.AdoptPnl				= "Kleiners Adoption Centre"
LANGUAGE.EnchancePnl			= "Enhancement Centre"
LANGUAGE.AdoptPet				= "Adopt this pet"
LANGUAGE.MissingPetEvolve		= "You should summon your pet first"
--Custom Maps
LANGUAGE.MAPS_RND_FINISHED		= "Congratulations on finishing Research and Development, Returning to lobby in 40 seconds"

--Checks
LANGUAGE.CHECK_DIFF_SETTING				= "The difficulty is set to: "
LANGUAGE.CHECK_DIFF_SETTING_1			= "Very Easy"
LANGUAGE.CHECK_DIFF_SETTING_2			= "Easy"
LANGUAGE.CHECK_DIFF_SETTING_3			= "Medium"
LANGUAGE.CHECK_DIFF_SETTING_4			= "Hard"
LANGUAGE.CHECK_DIFF_SETTING_5			= "Very Hard"

--Achievements
LANGUAGE.Ach_Locked						= "Locked"						

---Names
LANGUAGE.Malcontent						= "Malcontent"
LANGUAGE.Submissive						= "Submissive"
LANGUAGE.Defiant						= "Defiant"
LANGUAGE.Barney_Wish					= "Barney Wish"
LANGUAGE.Trusty_Hardware				= "Trusty Hardware"
LANGUAGE.Keep_Off_Sand					= "Keep off the Sand"
LANGUAGE.Warden_Freeman					= "Warden Freeman"
LANGUAGE.Follow_Freeman					= "Follow Freeman"
LANGUAGE.Cubbage						= "Cubbage"
LANGUAGE.Radiation_Levels				= "Radiation Levels"
LANGUAGE.Red_Letter_Baby				= "Red Letter Baby"
LANGUAGE.Zero_Point_Energy				= "Zero Point Energy"
LANGUAGE.Two_Points						= "Two Points"
LANGUAGE.Hallowed_Ground				= "Hallowed Ground"
LANGUAGE.Barnacle_Bowling				= "Barnacle Bowling"
LANGUAGE.Raven_Ball						= "Raven Ball"
LANGUAGE.Flushed						= "Flushed"
LANGUAGE.Hack_Attack					= "Hack Attack!"
LANGUAGE.What_Cat						= "What Cat?"
LANGUAGE.Blast_From_The_Past			= "Blast from the Past"
LANGUAGE.Beat_HL2						= "Singularity Collapse"
LANGUAGE.Giant_Killer					= "Giant Killer"
LANGUAGE.Lambda_Locator					= "Lambda Locator"

LANGUAGE.Citadel_Lift					= "Watch your head!"
LANGUAGE.Containment					= "Containment"
LANGUAGE.Pacifist_Stalkers				= "Pacifist"

LANGUAGE.New_Arrival					= "New Arrival"
LANGUAGE.Leiftiger						= "The return of the Leiftiger"
LANGUAGE.Unpleasant_Secret				= "Unpleasant Secret"
LANGUAGE.Sven_Coop						= "Classic Co-Op"
LANGUAGE.Craft_1						= "Crafted it yourself!"

LANGUAGE.The_Beginning					= "The Beginning"
LANGUAGE.The_End						= "A bad nightmare"
LANGUAGE.Carts_Journey					= "A Carts Journey"
LANGUAGE.Science_Squared				= "Science²"
---Descriptions
LANGUAGE.Malcontent_Desc				= "Escape the apartment block raid"
LANGUAGE.Submissive_Desc				= "Put the can in the trash"
LANGUAGE.Defiant_Desc					= "Hit the trashcan cop with the can"
LANGUAGE.Barney_Wish_Desc				= "Fulfil Barney's request"
LANGUAGE.Trusty_Hardware_Desc			= "Acquire the crowbar"
LANGUAGE.Keep_Off_Sand_Desc				= "Cross the antlion beach without touching the sand"
LANGUAGE.Warden_Freeman_Desc			= "Survive the second turret standoff in Nova Prospekt"
LANGUAGE.Follow_Freeman_Desc			= "Gain command of a squad of rebels in the uprising"
LANGUAGE.Cubbage_Desc					= "Defend Little Odessa from the gunship attack"
LANGUAGE.Radiation_Levels_Desc			= "Get through the toxic tunnel under City 17 in Half-Life 2"
LANGUAGE.Red_Letter_Baby_Desc			= "Take the baby from the playground to Dr.Kleiner's lab"
LANGUAGE.Zero_Point_Energy_Desc			= "Acquire the Gravity Gun in Black Mesa East"
LANGUAGE.Two_Points_Desc				= "Use DOG's ball to make a basket"
LANGUAGE.Hallowed_Ground_Desc			= "Escort Gregori safely through the church cemetery"
LANGUAGE.Barnacle_Bowling_Desc			= "Kill five barnacles with one barrel"
LANGUAGE.Raven_Ball_Desc				= "Escort DOG's ball to the end of Ravenholm's mine"
LANGUAGE.Flushed_Desc					= "Kill an enemy with a toilet"
LANGUAGE.Hack_Attack_Desc				= "Kill five enemies with a Manhack"
LANGUAGE.What_Cat_Desc					= "Break Dr.Kleiner's mini-teleporter"
LANGUAGE.Blast_From_The_Past_Desc		= "Find the old H.E.V suit charger"
LANGUAGE.Beat_HL2_Desc					= "Destroy the Citadel's reactor core"
LANGUAGE.Giant_Killer_Desc				= "Survive the rooftop strider battle in the ruins of City 17"
LANGUAGE.Lambda_Locator_Desc			= "Find all Lambda Caches"

LANGUAGE.Citadel_Lift_Desc				= "Make it to the bottom of the Citadel's main elevator shaft in one piece"
LANGUAGE.Containment_Desc				= "Contain the Citadel core"
LANGUAGE.Pacifist_Stalkers_Desc			= "Contain the Citadel core without killing any stalkers"

LANGUAGE.New_Arrival_Desc				= "Play the gamemode for the first time"
LANGUAGE.Leiftiger_Desc					= "Met the original creator of HL2-C"
LANGUAGE.Unpleasant_Secret_Desc			= "Plot twist: You get nothing!"
LANGUAGE.Sven_Coop_Desc					= "Discover the classic medical voiceline"
LANGUAGE.Craft_1_Desc					= "Craft an item for the first time"

LANGUAGE.The_Beginning_Desc				= "Escape the nightmare... or did you?"
LANGUAGE.The_End_Desc					= "Escape the hospital and the nightmare"
LANGUAGE.Carts_Journey_Desc				= "Successfully ride the cart without dying"
LANGUAGE.Science_Squared_Desc			= "Complete Research and Development"

--Notifications
LANGUAGE.BeingRevived					= " is reviving you"
LANGUAGE.Revived						= " revived you"
LANGUAGE.Healed							= " healed you for "
LANGUAGE.ArmorCharged					= " charged you for "
LANGUAGE.Repaired						= " repaired you for "
LANGUAGE.Restocked						= " supplied you"