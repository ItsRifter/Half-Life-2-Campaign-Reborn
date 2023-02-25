AddCSLuaFile()

if SERVER then
	resource.AddWorkshop( "493076395" )		--Gabumon player model
	resource.AddWorkshop( "1546376500" )	--3 detective player models
end

HL2CR_PlayerModels = {
--------------------------------------------------------------------------------------------------
-----lvl=lvl required for group/model---index=order displayed, does not need to be sequential-----
	["Citizens"] = {
		group = {
			["Male 1"] = { mdl="models/player/group01/male_01.mdl", 	lvl=0,	index = 0},
			["Male 2"] = { mdl="models/player/group01/male_02.mdl", 	lvl=0,	index = 1},
			["Male 3"] = { mdl="models/player/group01/male_03.mdl", 	lvl=0,	index = 2},
			["Male 4"] = { mdl="models/player/group01/male_04.mdl", 	lvl=0,	index = 3},
			["Male 5"] = { mdl="models/player/group01/male_05.mdl", 	lvl=0,	index = 4},
			["Male 6"] = { mdl="models/player/group01/male_06.mdl", 	lvl=0,	index = 5},
			["Male 7"] = { mdl="models/player/group01/male_07.mdl", 	lvl=0,	index = 6},
			["Male 8"] = { mdl="models/player/group01/male_08.mdl", 	lvl=0,	index = 7},
			["Male 9"] = { mdl="models/player/group01/male_09.mdl", 	lvl=0,	index = 8},
			["Female 1"] = { mdl="models/player/group01/female_01.mdl", 	lvl=0,	index = 10},
			["Female 2"] = { mdl="models/player/group01/female_02.mdl", 	lvl=0,	index = 11},
			["Female 3"] = { mdl="models/player/group01/female_03.mdl", 	lvl=0,	index = 12},
			["Female 4"] = { mdl="models/player/group01/female_04.mdl", 	lvl=0,	index = 13},
			["Female 5"] = { mdl="models/player/group01/female_05.mdl", 	lvl=0,	index = 14},
			["Female 6"] = { mdl="models/player/group01/female_06.mdl", 	lvl=0,	index = 15},
		},
		lvl = 0,
		index = 00
	},
	["Refugees"] = {
		group = {
			["Refugee 1"] = { mdl="models/player/group02/male_02.mdl", 	lvl=0,	index = 1},
			["Refugee 2"] = { mdl="models/player/group02/male_04.mdl", 	lvl=0,	index = 3},
			["Refugee 3"] = { mdl="models/player/group02/male_06.mdl", 	lvl=0,	index = 5},
			["Refugee 4"] = { mdl="models/player/group02/male_08.mdl", 	lvl=0,	index = 7},
		},
		lvl = 2,
		index = 01
	},
	["Medics"] = {
		group = {
			["Male 1"] = { mdl="models/player/Group03m/male_01.mdl", 	lvl=0,	index = 0},
			["Male 2"] = { mdl="models/player/Group03m/male_02.mdl", 	lvl=0,	index = 1},
			["Male 3"] = { mdl="models/player/Group03m/male_03.mdl", 	lvl=0,	index = 2},
			["Male 4"] = { mdl="models/player/Group03m/male_04.mdl", 	lvl=0,	index = 3},
			["Male 5"] = { mdl="models/player/Group03m/male_05.mdl", 	lvl=0,	index = 4},
			["Male 6"] = { mdl="models/player/Group03m/male_06.mdl", 	lvl=0,	index = 5},
			["Male 7"] = { mdl="models/player/Group03m/male_07.mdl", 	lvl=0,	index = 6},
			["Male 8"] = { mdl="models/player/Group03m/male_08.mdl", 	lvl=0,	index = 7},
			["Male 9"] = { mdl="models/player/Group03m/male_09.mdl", 	lvl=0,	index = 8},
			["Female 1"] = { mdl="models/player/Group03m/female_01.mdl", 	lvl=0,	index = 10},
			["Female 2"] = { mdl="models/player/Group03m/female_02.mdl", 	lvl=0,	index = 11},
			["Female 3"] = { mdl="models/player/Group03m/female_03.mdl", 	lvl=0,	index = 12},
			["Female 4"] = { mdl="models/player/Group03m/female_04.mdl", 	lvl=0,	index = 13},
			["Female 5"] = { mdl="models/player/Group03m/female_05.mdl", 	lvl=0,	index = 14},
			["Female 6"] = { mdl="models/player/Group03m/female_06.mdl", 	lvl=0,	index = 15},
		},
		lvl = 5,
		index = 02
	},
	["Rebels"] = {
		group = {
			["Male 1"] = { mdl="models/player/Group03/male_01.mdl", 	lvl=0,	index = 0},
			["Male 2"] = { mdl="models/player/Group03/male_02.mdl", 	lvl=0,	index = 1},
			["Male 3"] = { mdl="models/player/Group03/male_03.mdl", 	lvl=0,	index = 2},
			["Male 4"] = { mdl="models/player/Group03/male_04.mdl", 	lvl=0,	index = 3},
			["Male 5"] = { mdl="models/player/Group03/male_05.mdl", 	lvl=0,	index = 4},
			["Male 6"] = { mdl="models/player/Group03/male_06.mdl", 	lvl=0,	index = 5},
			["Male 7"] = { mdl="models/player/Group03/male_07.mdl", 	lvl=0,	index = 6},
			["Male 8"] = { mdl="models/player/Group03/male_08.mdl", 	lvl=0,	index = 7},
			["Male 9"] = { mdl="models/player/Group03/male_09.mdl", 	lvl=0,	index = 8},
			["Female 1"] = { mdl="models/player/Group03/female_01.mdl", 	lvl=0,	index = 10},
			["Female 2"] = { mdl="models/player/Group03/female_02.mdl", 	lvl=0,	index = 11},
			["Female 3"] = { mdl="models/player/Group03/female_03.mdl", 	lvl=0,	index = 12},
			["Female 4"] = { mdl="models/player/Group03/female_04.mdl", 	lvl=0,	index = 13},
			["Female 5"] = { mdl="models/player/Group03/female_05.mdl", 	lvl=0,	index = 14},
			["Female 6"] = { mdl="models/player/Group03/female_06.mdl", 	lvl=0,	index = 15},
		},
		lvl = 10,
		index = 03
	},

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
	["Half Life 2"] = {
		group = {
			["Kleiner"] = { mdl="models/player/kleiner.mdl", 	lvl=10,	index = 0},
			["Barney"] = { mdl="models/player/barney.mdl", 		lvl=12,	index = 1},
			["Mossman"] = { mdl="models/player/mossman.mdl", 	lvl=14,	index = 2},
			["Eli"] = { mdl="models/player/eli.mdl", 			lvl=17,	index = 3},
			["Alyx"] = { mdl="models/player/alyx.mdl", 			lvl=20,	index = 4},
			["Magusson"] = { mdl="models/player/magnusson.mdl", lvl=23,	index = 5},
			["Gregori"] = { mdl="models/player/monk.mdl", 		lvl=27,	index = 6},
			["Breen"] = { mdl="models/player/breen.mdl", 		lvl=30,	index = 7},
			["Gman"] = { mdl="models/player/gman_high.mdl", 	lvl=35,	index = 8},
			["Mossman 2"] = { mdl="models/player/mossman_arctic.mdl", lvl=40,	index = 9},
		},
		lvl = 10,
		index = 10
	},
	["Counter Strike"] = {
		group = {
			["Hostage 1"] = { mdl="models/player/hostage/hostage_01.mdl", 	lvl=0,	index = 0},
			["Hostage 2"] = { mdl="models/player/hostage/hostage_02.mdl", 	lvl=0,	index = 1},
			["Hostage 3"] = { mdl="models/player/hostage/hostage_03.mdl", 	lvl=0,	index = 2},
			["Hostage 4"] = { mdl="models/player/hostage/hostage_04.mdl", 	lvl=0,	index = 3},
			
			["CT Riot"] = { mdl="models/player/riot.mdl", 		lvl=20,	index = 10},
			["CT Swat"] = { mdl="models/player/swat.mdl", 		lvl=22,	index = 11},
			["CT Urban"] = { mdl="models/player/urban.mdl", 	lvl=25,	index = 12},
			["CT Gasmask"] = { mdl="models/player/gasmask.mdl", lvl=28,	index = 13},
			
			["T Pheonix"] = { mdl="models/player/phoenix.mdl", 		lvl=20,	index = 20},
			["T Arctic"] = { mdl="models/player/arctic.mdl", 	lvl=22,	index = 21},
			["T Guerilla"] = { mdl="models/player/guerilla.mdl",lvl=25,	index = 22},
			["T Leet"] = { mdl="models/player/leet.mdl", 		lvl=28,	index = 23},
		},
		lvl = 15,
		index = 11
	},
	
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
	["Bonus"] = {
		group = {
			["Detective A"] = { mdl="models/detective.mdl", 		lvl=0,	index = 0},
			["Detective B"] = { mdl="models/detective_badass.mdl", 	lvl=0,	index = 1},
			["Detective F"] = { mdl="models/lady_detective.mdl", 	lvl=0,	index = 2},
		},
		lvl = 20,
		index = 21
	},

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
	
	["Super Admin"] = {
		group = {
			["skeleton"] = { mdl="models/player/skeleton.mdl", 			lvl=999,	index = 0},
			["Gabumon"] = { mdl="models/player/gabumon/gabumon.mdl", 	lvl=999,	index = 99},
		},
		lvl = 999,
		index = 99
	},
}

--I have no clue if anyone else will ever run a server of this but yes, this does let me set my model to max rank value, leave it alone.
--It gives no access other that what models a player can select, DO NOT USE THIS VALUE FOR ANYTHING ELSE, ITS IS NOT DESIGNED TO BE A TRUSTED VALUE!
if CLIENT then 
	function HL2CR_GetLvlAccess()
		if LocalPlayer():SteamID() == "STEAM_0:0:16635137" then return 999 end

		if LocalPlayer():IsSuperAdmin() then return 999 end
		if LocalPlayer():IsAdmin() then return 500 end
		local int = LocalPlayer():GetNWInt("hl2cr_stat_level",0)
		return int
	end
elseif SERVER then
	function HL2CR_GetLvlAccess(ply)
		if ply:SteamID() == "STEAM_0:0:16635137" then return 999 end
	
		if ply:IsSuperAdmin() then return 999 end
		if ply:IsAdmin() then return 500 end
		local int = ply:GetNWInt("hl2cr_stat_level",0)
		return int
	end
end

function HL2CR_GetModelList(lvl)
	modlist = {}
	local i = 1
	for k, v in SortedPairsByMemberValue(HL2CR_PlayerModels, "index", false) do
		if lvl >= v.lvl then
			modlist[i] = k
			i = i + 1
		end
	end

	return modlist
end

function HL2CR_GetModelGroups(group,lvl)
	if !HL2CR_PlayerModels[group] then return nil end
	modlist = {}
	local i = 1
	for k, v in SortedPairsByMemberValue(HL2CR_PlayerModels[group].group, "index", false) do
		if lvl >= v.lvl then
			modlist[i] = k
			i = i + 1
		end
	end

	return modlist
end

function HL2CR_GetModelFromGroup(group)
	if !HL2CR_PlayerModels[group] then return nil end
	for k, v in SortedPairsByMemberValue(HL2CR_PlayerModels[group].group, "index", false) do
		return v.mdl
	end

	return nil
end

function HL2CR_GetModelFromName(group,name,lvl)
	if !HL2CR_PlayerModels[group] then return nil end
	if lvl < HL2CR_PlayerModels[group].lvl then return nil end
	for k, v in pairs(HL2CR_PlayerModels[group].group) do
		if k == name then 
			if lvl >= v.lvl then
				return v.mdl
			end
			return nil
		end
	end
	return nil
end