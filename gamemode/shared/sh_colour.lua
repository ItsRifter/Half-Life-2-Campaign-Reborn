AddCSLuaFile()

local colours = {
	[0] = Color(255, 255, 255),		--White
	[1] = Color(255, 020, 20),		--Red
	[2] = Color(20, 255, 20),		--Green
	[3] = Color(20, 20, 255),		--Blue
	[4] = Color(255, 255, 20),		--Yellow
	[5] = Color(255, 20, 255),		--Magenta
	[6] = Color(20, 255, 255),		--Cyan
	[7] = Color(160, 20, 160),		--Purple
	[8] = Color(255, 255, 255)
}

function GetColour(number, blend)
	local New = colours[0]	--Default White
	if colours[number] then New = colours[number] end

	New.a = blend
	
	if number == 99 then 	--Rainbow blend over time
		local add360 = (CurTime() * 180) % 360
		New = HSVToColor( add360, 1, 1 ) 
		New = Color(New.r,New.g,New.b,blend) 
	end

	return New
end