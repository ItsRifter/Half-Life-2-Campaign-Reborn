--Todo: consider moving client network fuctions to start here
DataLoaded = false	--unused currently but may need it

local gamematch = {	
	[220] = "HL2",
	[240] = "CSS",
	[380] = "EP1",
	[420] = "EP2",
	[340] = "LST",
}

net.Receive("HL2CR_Loaded", function()
	--print("Server says you loaded now")
	DataLoaded = true
end)

timer.Simple( 1, function()
	local list = engine.GetGames()
	local send = {
			[220] = 0,
		[240] = 0,
		[380] = 0,
		[420] = 0,
		[340] = 0,
	}
	print("--Getting Games list--")
	for k, v in pairs( list ) do
		if gamematch[v.depot] then
			if v.mounted then
				send[v.depot] = 2
			elseif v.owned then
				send[v.depot] = 1
			end
		end
	end
	
	
	net.Start( "HL2CR_GamesList" )
		net.WriteTable(send)
	net.SendToServer()
end)

net.Receive( "HL2CR_GamesList", function( length)
	local games = net.ReadTable()
	local ply = net.ReadEntity()
	if IsValid(ply) and ply:IsPlayer() then
		ply.games = games
	end
end )

--Refresh/Open HelpMenu
net.Receive("HL2CR_HelpMenu", function()
	if ( GAMEMODE.HelpMenu ) then GAMEMODE.HelpMenu:Remove()end
	GAMEMODE.HelpMenu = vgui.Create( "HelpMenu" )
	gui.EnableScreenClicker( true ) 
end)

function GM:PlayerBindPress ( Player, Bind, Pressed )
	if Bind == "impulse 100" then
		if LocalPlayer():InVehicle() then RunConsoleCommand("HL2CR_Lights", ""); end
	end
end