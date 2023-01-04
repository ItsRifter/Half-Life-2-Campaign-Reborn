--Todo: consider moving client network fuctions to start here
DataLoaded = false	--unused currently but may need it
net.Receive("HL2CR_Loaded", function()
	--print("Server says you loaded now")
	DataLoaded = true
end)

function GM:PlayerBindPress ( Player, Bind, Pressed )
	if Bind == "impulse 100" then
		if LocalPlayer():InVehicle() then RunConsoleCommand("HL2CR_Lights", ""); end
	end
end