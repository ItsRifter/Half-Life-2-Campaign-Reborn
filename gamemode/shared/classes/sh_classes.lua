AddCSLuaFile()

GM.PlayerClasses = GM.PlayerClasses or {}

local function InsertClassInGame(newClass)
	table.insert(GAMEMODE.PlayerClasses, newClass)
	PrintTable(GAMEMODE.PlayerClasses)
end

local function ClearClasses()
	table.Empty(GAMEMODE.PlayerClasses)
end

function CreateClass(name, desc)
	local class = {
		["name"] = name,
		["desc"] = desc,
	}
	
	print("WORKS")
	InsertClassInGame(class)
end

ClearClasses()

CreateClass("test", "Just a basic test class")

