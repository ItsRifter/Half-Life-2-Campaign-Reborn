
-- Usermessage for Content Download
hook.Add( "PlayerSay", "HL2CR_Sites", function( ply, text )
	if string.sub(text, 1, 8) == "!content" then
		ply:SendLua( [[ gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=2067994634") ]] )
		return ""
	end
end)

hook.Add( "PlayerSay", "HL2CR_BringNPC", function( ply, text )
	if ply:IsAdmin() and ( text == "!balyx" ) then
		local hit = ply:GetEyeTrace().HitPos
		local offset = Vector( 10, 0, 30 )
		ents.FindByClass("npc_alyx")[1]:SetPos(hit)
	end
	
	if ply:IsAdmin() and ( text == "!bbarney" ) then
		local hit = ply:GetEyeTrace().HitPos
		local offset = Vector( 10, 0, 30 )
		ents.FindByClass("npc_barney")[1]:SetPos(hit)
	end
end)

hook.Add( "PlayerSay", "HL2CR_Extra", function( ply, text )
	if text[1] == "!" then return end
	
	if game.GetMap() == "d3_breen_01" then
		if !ply:HasAchievement("HL2_BarneyWish") then 
			if string.find( text:lower(), "barney" ) and string.find( text:lower(), "fuck you" ) then
				local breen = ents.FindByClass( "npc_breen" )
				if breen and breen[1]:GetPos():Distance(ply:GetPos()) < 200 then
					ply:GiveAchievement("HL2","HL2_BarneyWish")
				end
			end
		end
	end
end)