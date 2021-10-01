
--Server Files
----Basic
include("shared.lua")
include("server/sv_base_convars.lua")

----Player
include("server/player/sv_player.lua")
include("server/player/sv_teams.lua")
include("server/player/sv_vehicles.lua")
include("server/player/sv_cmds.lua")
include("server/player/sv_spectating.lua")
include("server/player/sv_progressive.lua")

----NPC
include("server/npc/sv_npc.lua")

----Map
include("server/maps/sv_hl2.lua")
include("server/maps/sv_lobby.lua")
include("server/maps/sv_map_manager.lua")

----Resources
include("server/sv_resource.lua")

----Data Saving
include("server/filesaving/sv_data_filebased.lua")

----Miscellanous
include("server/sv_afkhandler.lua")

----Achievements
include("server/ach/sv_ach_base.lua")

--Client
AddCSLuaFile("client/hud/cl_hud.lua")
AddCSLuaFile("client/hud/cl_spectate.lua")
AddCSLuaFile("client/ui/cl_ui_elements.lua")
AddCSLuaFile("client/ui/cl_ui_fonts.lua")
AddCSLuaFile("client/menus/cl_scoreboard_menu.lua")
AddCSLuaFile("client/menus/cl_end_results.lua")
AddCSLuaFile("client/menus/cl_help_menu.lua")
AddCSLuaFile("client/menus/cl_settings_menu.lua")
AddCSLuaFile("client/menus/cl_voice_menu.lua")
AddCSLuaFile("client/menus/cl_qmenu.lua")
AddCSLuaFile("client/hud/cl_hitboxrender.lua")
AddCSLuaFile("client/hud/cl_ach.lua")

--Shared
----Voting
include("shared/misc/sh_voting.lua")

----Classes
include("shared/playerclass/sh_player_classes.lua")
include("shared/playerclass/sh_player_skills.lua")

----Achievements
include("shared/ach/sh_player_ach.lua")

----Shops
include("shared/shop/sh_shop_items.lua")

----Misc
include("shared/sh_translate.lua")

--Networks
util.AddNetworkString("HL2CR_HelpMenu")
util.AddNetworkString("HL2CR_SettingsMenu")
util.AddNetworkString("HL2CR_LevelUpSound")
util.AddNetworkString("HL2CR_MapCountdown")
util.AddNetworkString("HL2CR_AchievementEarned")
util.AddNetworkString("HL2CR_AchievementNotifyAll")
util.AddNetworkString("HL2CR_AchievementUpdate")
util.AddNetworkString("HL2CR_RequestPac")
util.AddNetworkString("HL2CR_SendPac")
util.AddNetworkString("HL2CR_UpdateModel")
util.AddNetworkString("HL2CR_UpdateSkills")
util.AddNetworkString("HL2CR_AdminJoin")
util.AddNetworkString("HL2CR_ClientMapResults")
util.AddNetworkString("HL2CR_AchMenu")
util.AddNetworkString("HL2CR_TakeItemReward")
util.AddNetworkString("HL2CR_CraftItem")
util.AddNetworkString("HL2CR_UseItem")
util.AddNetworkString("HL2CR_EndCampaign")
util.AddNetworkString("HL2CR_StartVote")
util.AddNetworkString("HL2CR_Vote")
util.AddNetworkString("HL2CR_EndVote")
util.AddNetworkString("HL2CR_HelpMenu")
util.AddNetworkString("HL2CR_SpawnIndicators")
util.AddNetworkString("HL2CR_ShouldClientSpectate")
util.AddNetworkString("HL2CR_UpdatePlayerName")
util.AddNetworkString("HL2CR_SelectClass")
util.AddNetworkString("HL2CR_SkillObtain")
util.AddNetworkString("HL2CR_PurchaseItem")
util.AddNetworkString("HL2CR_Message")
util.AddNetworkString("HL2CR_HelpNotify")
util.AddNetworkString("HL2CR_OpenAchs")
util.AddNetworkString("HL2CR_MsgSound")
util.AddNetworkString("HL2CR_UpdateSlot")
util.AddNetworkString("HL2CR_ApplySettings")
util.AddNetworkString("HL2CR_UpdateModel")

hook.Add("PrePACConfigApply", "HL2CR_DisablePac3Autoload", function(ply, outfit_data)
	return false
end)

hook.Add("PrePACEditorOpen", "HL2CR_DisablePacEditor", function(ply)
	if not ply:IsAdmin() then
		return false
	end
end)

ENABLE_AFK = {
	["Colour"] = Color(125, 125, 125),
	["Message"] = "ENABLE_AFK"
}

DISABLE_AFK = {
	["Colour"] = Color(125, 125, 125),
	["Message"] = "DISABLE_AFK"
}

ERROR_PET_LONGNAME = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_PET_LONGNAME"
}

ERROR_AFK_DEAD = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_AFK_DEAD"
}

ERROR_VEHICLE_MAP = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_VEHICLE_MAP"
}

ERROR_VEHICLE_INVALID = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_VEHICLE_INVALID"
}

ERROR_VEHICLE_EXISTS = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_VEHICLE_EXISTS"
}

ERROR_AFK_FINISHED = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_AFK_FINISHED"
}

ERROR_PET_EXISTS = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_PET_EXISTS"
}

ERROR_PET_NOPET = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_PET_NOPET"
}

ERROR_PET_UNAVAILABLE = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_PET_UNAVAILABLE"
}

ERROR_PET_NONEXISTS = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_PET_NONEXISTS"
}

ERROR_PET_BRINGING = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_PET_BRINGING"
}

VOTE_SUCCESS_MAP = {
	["Colour"] = Color(50, 215, 50),
	["Message"] = "VOTE_SUCCESS_MAP"
}

VOTE_SUCCESS_KICK = {
	["Colour"] = Color(50, 215, 50),
	["Message"] = "VOTE_SUCCESS_KICK"
}

MAPS_HL2_FINISHED = {
	["Colour"] = Color(250, 230, 45),
	["Message"] = "MAPS_HL2_FINISHED"
}

ERROR_CLASS_ALREADY_ASSIGNED = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_CLASS_ALREADY_ASSIGNED"
}

VOTE_SUCCESS_HL2 = {
	["Colour"] = Color(50, 215, 50),
	["Message"] = "VOTE_SUCCESS_HL2"
}

VOTE_FAILED = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "VOTE_FAILED"
}

VOTE_FAILED_ADMIN = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "VOTE_FAILED_ADMIN"
}

VOTE_SUCCESS_LOBBY = {
	["Colour"] = Color(50, 215, 50),
	["Message"] = "VOTE_SUCCESS_LOBBY"
}

ERROR_PET_INVALIDMAP = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_PET_INVALIDMAP"
}

ERROR_PET_INVALID = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_PET_INVALID"
}

ERROR_VOTEKICK_MULTINAME = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_VOTEKICK_MULTINAME"
}

ERROR_VOTEKICK_NONAME = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_VOTEKICK_NONAME"
}

ERROR_VOTEKICK_INVALID = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_VOTEKICK_INVALID"
}

ERROR_VOTEKICK_ADMIN = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_VOTEKICK_ADMIN"
}

ERROR_VOTEKICK_SELF = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_VOTEKICK_SELF"
}

CHECKPOINT_HIT = {
	["Colour"] = Color(235, 135, 55),
	["Message"] = "CHECKPOINT_HIT"
}

ENABLED_AIRBOAT = {
	["Colour"] = Color(50, 215, 50),
	["Message"] = "ENABLED_AIRBOAT"
}
ENABLED_AIRBOAT_GUN = {
	["Colour"] = Color(50, 215, 50),
	["Message"] = "ENABLED_AIRBOAT_GUN"
}

ENABLED_JEEP = {
	["Colour"] = Color(50, 215, 50),
	["Message"] = "ENABLED_JEEP"
}

ERROR_JEEP_OWNER = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_JEEP_OWNER"
}

ERROR_JEEP_INVALID = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_JEEP_INVALID"
}

ERROR_JEEP_OWNER = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_JEEP_OWNER"
}
ERROR_NO_JEEP = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_NO_JEEP"
}

ERROR_VOTE_COOLDOWN = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "ERROR_VOTE_COOLDOWN"
}