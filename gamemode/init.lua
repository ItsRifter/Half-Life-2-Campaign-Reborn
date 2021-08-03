
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
AddCSLuaFile("client/ui/cl_ui_elements.lua")
AddCSLuaFile("client/ui/cl_ui_fonts.lua")
AddCSLuaFile("client/menus/cl_voting_menu.lua")
AddCSLuaFile("client/menus/cl_scoreboard_menu.lua")
AddCSLuaFile("client/menus/cl_end_results.lua")
AddCSLuaFile("client/menus/cl_ach_menu.lua")
AddCSLuaFile("client/menus/cl_help_menu.lua")

--Shared
----Voting
include("shared/misc/sh_voting.lua")

----Achievements
include("shared/ach/sv_player_ach.lua")

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
util.AddNetworkString("HL2CR_Vote")
util.AddNetworkString("HL2CR_VoteEnd")
util.AddNetworkString("HL2CR_HelpMenu")
