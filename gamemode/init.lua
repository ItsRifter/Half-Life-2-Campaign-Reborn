include("shared.lua")

//Base
include("server/sv_convars.lua")
include("server/sv_chat.lua")
include("server/sv_network.lua")
include("server/sv_message_colours.lua")

//Players
include("server/playerbase/sv_player.lua")
include("server/playerbase/sv_teams.lua")
include("server/playerbase/sv_player_models.lua")
include("server/playerbase/sv_stats.lua")
include("server/playerbase/sv_vehicle_system.lua")

//Maps
include("server/mapsetup/sv_map_manager.lua")
include("server/mapsetup/sv_lobby_setup.lua")
include("server/mapsetup/sv_hl2_setup.lua")

//Data
include("server/datastorage/sv_flatfile_data.lua")

//NPCs
include("server/npcbase/sv_npc.lua")
include("server/npcbase/sv_npc_stats.lua")

//Clients
AddCSLuaFile("client/hud/cl_hud.lua")
AddCSLuaFile("client/interface/cl_fonts.lua")

//Shared
include("shared/sh_language_support.lua")
include("shared/sh_voting.lua")