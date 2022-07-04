AddCSLuaFile()

GM.Achievements = {}

for i, filename in pairs(file.Find(GM.FolderName.."/gamemode/shared/achievements/games/*.lua", "LUA")) do
	ACHIEVEMENT = {}

	AddCSLuaFile("games/" .. filename)
	include("games/" .. filename)
	
	for k, v in pairs(ACHIEVEMENT) do
		table.insert(GM.Achievements, v)
	end

	ACHIEVEMENT = nil
end