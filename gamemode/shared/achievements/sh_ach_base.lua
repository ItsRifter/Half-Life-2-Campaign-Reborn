AddCSLuaFile()

GM.Achievements = {}

for i, filename in pairs(file.Find(GM.FolderName.."/gamemode/shared/achievements/games/*.lua", "LUA")) do
	--ACHIEVEMENT = {}

	AddCSLuaFile("games/" .. filename)
	include("games/" .. filename)
	
	--for k, v in pairs(ACHIEVEMENT) do
	--	table.insert(GM.Achievements, v)
	--end

	--ACHIEVEMENT = nil
end


function HL2CR_GetAchievement(group,id)
	if !GAMEMODE.Achievements[group] then return nil end
	if !GAMEMODE.Achievements[group].Achievements[id] then return nil end
	return GAMEMODE.Achievements[group].Achievements[id]
end
--PrintTable(GM.Achievements)

if CLIENT then ------------------------------------------------------------------

	net.Receive( "HL2CR_AchievementSend", function( length)
		local bytes = net.ReadUInt( 16 )
		local compressed = net.ReadData( bytes ) 
		local datajson = util.Decompress( compressed )

		GAMEMODE.AchEarned = util.JSONToTable( datajson )
		--PrintTable(GAMEMODE.AchEarned)
		
		GAMEMODE.AchProgress = {}
	end )

	net.Receive( "HL2CR_AchievementProg", function( length)
		local bytes = net.ReadUInt( 16 )
		local compressed = net.ReadData( bytes ) 
		local datajson = util.Decompress( compressed )

		GAMEMODE.AchProgress = util.JSONToTable( datajson )
	end )

	function HL2CR_HasAchievement(ach)
		return table.HasValue( GAMEMODE.AchEarned,ach)
	end
	
	function HL2CR_GetProgress(ach)
		if GAMEMODE.AchProgress[ach] then return GAMEMODE.AchProgress[ach] end
		return 0
	end

end -----------------------------------------------------------------------------