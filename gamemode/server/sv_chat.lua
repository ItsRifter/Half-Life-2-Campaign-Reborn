
-- Usermessage for Content Download
hook.Add( "PlayerSay", "HL2CR_Sites", function( ply, text )
	if string.sub(text, 1, 8) == "!content" then
		ply:SendLua( [[ gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=2067994634") ]] )
		return ""
	end
end)

hook.Add( "PlayerSay", "HL2CR_BringNPC", function( ply, text )
	if ply:IsAdmin() and ( text == "!bringalyx" ) then
		local hit = ply:GetEyeTrace().HitPos
		local offset = Vector( 10, 0, 30 )
		ents.FindByClass("npc_alyx")[1]:SetPos(hit)
	end
	
	if ply:IsAdmin() and ( text == "!bringalyx" ) then
		local hit = ply:GetEyeTrace().HitPos
		local offset = Vector( 10, 0, 30 )
		ents.FindByClass("npc_barney")[1]:SetPos(hit)
	end
end)