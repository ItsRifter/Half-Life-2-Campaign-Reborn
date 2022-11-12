AddCSLuaFile()

local colours = {
	[1] = Color(255, 020, 20),
	[2] = Color(20, 255, 20),
	[3] = Color(20, 20, 255),
	[4] = Color(255, 255, 20),
	[5] = Color(255, 255, 255),
	[6] = Color(255, 255, 255),
	[7] = Color(255, 255, 255),
	[8] = Color(255, 255, 255)
}

function GetColour(number, blend)
	local New = Color(255, 255, 255)
	if colours[number] then New = colours[number] end

	New = colours[number]
	New.a = blend
	
	if number == 99 then 
		local add360 = (CurTime() * 180) % 360
		New = HSVToColor( add360, 1, 1 ) 
		New = Color(New.r,New.g,New.b,blend) 
	end

	return New
end