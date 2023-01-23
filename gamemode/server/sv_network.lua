util.AddNetworkString("HL2CR_ChatMessage")
util.AddNetworkString("HL2CR_MsgSound")
util.AddNetworkString("HL2CR_MsgPitchSound")
util.AddNetworkString("HL2CR_Update_XP")

util.AddNetworkString("HL2CR_AchievementEarned")
util.AddNetworkString("HL2CR_Endresults")

util.AddNetworkString("HL2CR_Model_Update")
util.AddNetworkString("HL2CR_Skills_Purchase")
util.AddNetworkString("HL2CR_Class_Update")

util.AddNetworkString("hl2cr_auxpow_amount")
util.AddNetworkString("hl2cr_auxpow_expenses")
util.AddNetworkString("hl2cr_auxpow_flashlight")
util.AddNetworkString("hl2cr_auxpow_sprint");

util.AddNetworkString("HL2CR_Vote")
util.AddNetworkString("HL2CR_EndVote")

util.AddNetworkString("HL2CR_ChatHistory")
util.AddNetworkString("HL2CR_Player_NotifyKilled")
util.AddNetworkString("HL2CR_TankNPC_Display")

util.AddNetworkString("HL2CR_Cosmetic_Use")
util.AddNetworkString("HL2CR_Cosmetic")
util.AddNetworkString("HL2CR_AchievementUpdate")

util.AddNetworkString("HL2CR_Item_Purchase")
util.AddNetworkString("HL2CR_Item_Use")
util.AddNetworkString("HL2CR_Item_Sell")

util.AddNetworkString("HL2CR_Loaded")
util.AddNetworkString("HL2CR_Indicator")
util.AddNetworkString("HL2CR_HelpMenu")
util.AddNetworkString("HL2CR_GamesList")




net.Receive( "HL2CR_GamesList", function( length, ply )
	if ( IsValid( ply ) and ply:IsPlayer() ) then
		ply.games = net.ReadTable()
		
		net.Start( "HL2CR_GamesList" )
			net.WriteTable(ply.games)
			net.WriteEntity(ply)
		net.Broadcast()
		
		for _, p in ipairs( player.GetAll() ) do
			if p:IsBot() then continue end
			if p == ply then continue end
			net.Start( "HL2CR_GamesList" )
				net.WriteTable(p.games)
				net.WriteEntity(p)
			net.Send(ply)
		end
		
	end
end )