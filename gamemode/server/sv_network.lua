util.AddNetworkString("HL2CR_ChatMessage")
util.AddNetworkString("HL2CR_MsgSound")
util.AddNetworkString("HL2CR_MsgPitchSound")
util.AddNetworkString("HL2CR_Update_XP")

util.AddNetworkString("HL2CR_Endresults")

util.AddNetworkString("HL2CR_Model_Update")			--Client asks to change model
util.AddNetworkString("HL2CR_Skills_Purchase")		--Client asks to buy skill
util.AddNetworkString("HL2CR_Class_Update")	--Being made redundant

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
util.AddNetworkString("HL2CR_Cosmetic")		--Being made redundant

util.AddNetworkString("HL2CR_AchievementSend")		--Send achieved list
util.AddNetworkString("HL2CR_AchievementProg")		--Send progression list
util.AddNetworkString("HL2CR_AchievementEarned")	--Send new earned
util.AddNetworkString("HL2CR_AchievementUpdate")	--Send new update

util.AddNetworkString("HL2CR_Item_Purchase")
util.AddNetworkString("HL2CR_CL_SENDAP")

util.AddNetworkString("HL2CR_Loaded")
util.AddNetworkString("HL2CR_Indicator")			--Indicator notification
util.AddNetworkString("HL2CR_HelpMenu")				--Tells client to open help menu on F1 press if not voting
util.AddNetworkString("HL2CR_GamesList")			--Fun gathering of players game list

util.AddNetworkString("HL2CR_CL_SendSkills")		--Send full skill list
util.AddNetworkString("HL2CR_CL_AddSkill")			--Send new skill

util.AddNetworkString("HL2CR_CL_SendItems")			--Send full item list
util.AddNetworkString("HL2CR_CL_AddItem")			--Send new item

util.AddNetworkString("HL2CR_SendLoadout")

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