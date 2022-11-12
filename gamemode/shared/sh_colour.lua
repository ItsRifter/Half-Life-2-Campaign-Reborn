function GetColour(number, blend)
	local New = Color(255,255,255,blend)	--White
	if number == 1 then New = Color(255,020,020,blend) end	--Red
	if number == 2 then New = Color(020,255,020,blend) end	--Green
	if number == 3 then New = Color(020,020,255,blend) end	--Blue
	if number == 4 then New = Color(255,255,020,blend) end	--Yellow
	if number == 5 then New = Color(255,255,255,blend) end
	if number == 6 then New = Color(255,255,255,blend) end
	if number == 7 then New = Color(255,255,255,blend) end
	if number == 8 then New = Color(255,255,255,blend) end

	if number == 99 then 
		local add360 =  (CurTime() * 180) % 360
		New = HSVToColor( add360, 1, 1 ) 
		New = Color(New.r,New.g,New.b,blend) 
	end
	return New
end