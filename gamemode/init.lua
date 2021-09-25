
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
AddCSLuaFile("client/hud/cl_ach.lua")
AddCSLuaFile("client/hud/cl_spectate.lua")
AddCSLuaFile("client/ui/cl_ui_elements.lua")
AddCSLuaFile("client/ui/cl_ui_fonts.lua")
AddCSLuaFile("client/menus/cl_scoreboard_menu.lua")
AddCSLuaFile("client/menus/cl_end_results.lua")
AddCSLuaFile("client/menus/cl_ach_menu.lua")
AddCSLuaFile("client/menus/cl_help_menu.lua")
AddCSLuaFile("client/menus/cl_qmenu.lua")
AddCSLuaFile("client/hud/cl_hitboxrender.lua")

--Shared
----Voting
include("shared/misc/sh_voting.lua")

----Classes
include("shared/playerclass/sh_player_classes.lua")
include("shared/playerclass/sh_player_skills.lua")

----Achievements
include("shared/ach/sh_player_ach.lua")

--Networks
util.AddNetworkString("HL2CR_HelpMenu")
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
util.AddNetworkString("HL2CR_Message")

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
	["Message"] = "You are now AFK"
}

DISABLE_AFK = {
	["Colour"] = Color(125, 125, 125),
	["Message"] = "You are no longer AFK"
}

ERROR_AFK_DEAD = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "You cannot go into AFK mode while you are dead!"
}

ERROR_VEHICLE_MAP = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "Spawning vehicles are currently disabled"
}

ERROR_VEHICLE_INVALID = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "Your vehicle doesn't exist"
}

ERROR_VEHICLE_EXISTS = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "Your vehicle already exists"
}

ERROR_AFK_FINISHED = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "You cannot go into AFK mode while you have completed the map!"
}

ERROR_PET_EXISTS = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "Your pet already exists!"
}

ERROR_PET_NONEXISTS = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "Your pet doesn't exist"
}

VOTE_SUCCESS_MAP = {
	["Colour"] = Color(50, 215, 50),
	["Message"] = "Vote Successful, Restarting map"
}

VOTE_SUCCESS_HL2 = {
	["Colour"] = Color(50, 215, 50),
	["Message"] = "Vote Successful, Starting Half-Life 2"
}

VOTE_FAILED = {
	["Colour"] = Color(50, 215, 50),
	["Message"] = "Vote Failed"
}

VOTE_SUCCESS_LOBBY = {
	["Colour"] = Color(50, 215, 50),
	["Message"] = "Vote Successful, Returning to lobby"
}

ERROR_PET_INVALIDMAP = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "Pets are disabled on this map"
}

ERROR_PET_INVALID = {
	["Colour"] = Color(215, 50, 50),
	["Message"] = "Your pet doesn't exist!"
}