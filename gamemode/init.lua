include("shared.lua")

//Base
include("server/sv_convars.lua")
include("server/sv_chat.lua")
include("server/sv_network.lua")
include("server/sv_message_colours.lua")
include("server/sv_afkhandler.lua")

//Players
include("server/playerbase/sv_player.lua")
include("server/playerbase/sv_teams.lua")
include("server/playerbase/sv_stats.lua")
include("server/playerbase/sv_vehicle_system.lua")
include("server/playerbase/sv_spectate_mode.lua")
include("server/playerbase/sv_achievements.lua")
include("server/playerbase/commands/sv_chat_cmds.lua")

//Maps
include("server/mapsetup/sv_map_manager.lua")
include("server/mapsetup/sv_lobby_setup.lua")
include("server/mapsetup/sv_hl2_setup.lua")
include("server/mapsetup/sv_map_equipment.lua")
include("server/mapsetup/sv_vortex_setup.lua")

//Data
include("server/datastorage/sv_flatfile_data.lua")

//NPCs
include("server/npcbase/sv_npc.lua")
include("server/npcbase/sv_npc_stats.lua")

//Clients
AddCSLuaFile("client/hud/cl_hud.lua")
AddCSLuaFile("client/hud/cl_scoreboard_menu.lua")
AddCSLuaFile("client/hud/cl_qmenu.lua")
AddCSLuaFile("client/hud/cl_endresults.lua")
AddCSLuaFile("client/interface/cl_fonts.lua")
AddCSLuaFile("client/interface/cl_ui_elements.lua")
AddCSLuaFile("client/interface/cl_ach_notify.lua")
AddCSLuaFile("client/interface/panels/cl_ui_dragpanel.lua")
AddCSLuaFile("client/chat/cl_leifchat.lua")

//Shared
include("shared/sh_language_support.lua")
include("shared/voting/sh_voting.lua")
include("shared/voting/sh_vote_types.lua")

//Cosmetics
include("shared/items/cosmetics/sh_cosmetic_base.lua")
include("shared/items/cosmetics/sh_basic_cosmetics.lua")

//Players
include("shared/playerbase/sh_player_models.lua")

//Classes
include("shared/playerbase/classes/sh_class_base.lua")

//Skills
include("shared/playerbase/skills/sh_skill_base.lua")

//Pets
include("shared/pets/sh_pet_skills.lua")
include("shared/pets/sh_pets.lua")

//Suit
include("shared/playerbase/suit/sh_power.lua")
include("shared/playerbase/suit/modules/sh_flashlight.lua")
include("shared/playerbase/suit/modules/sh_oxygen.lua")
include("shared/playerbase/suit/modules/sh_sprinting.lua")

//Achievements
include("shared/achievements/sh_ach_base.lua")

hook.Add("PrePACConfigApply", "HL2CR_PreventPac3Autoload", function(ply, outfit_data)
    if ply.CanLoadPac3 or ply:IsAdmin() then
        ply.CanLoadPac3 = false
        return true
    end

    return false
end)

hook.Add( "PrePACEditorOpen", "HL2CR_RestrictPac3", function( ply )
	if not ply:IsAdmin() then
		return false
	end
end )