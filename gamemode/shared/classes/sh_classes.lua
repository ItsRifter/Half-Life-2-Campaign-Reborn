AddCSLuaFile()

GM.PlayerClasses = GM.PlayerClasses or {}

local function InsertClassInGame(newClass)
	table.insert(GAMEMODE.PlayerClasses, newClass)
end

local function ClearClasses()
	if table.IsEmpty(GM.PlayerClasses) then return end
	
	table.Empty(GAMEMODE.PlayerClasses)
end

function CreateClass(name, desc)
	local class = {
		["name"] = name,
		["desc"] = desc,
	}
	InsertClassInGame(class)
end

ClearClasses()

CreateClass("test", "Just a basic test class")

