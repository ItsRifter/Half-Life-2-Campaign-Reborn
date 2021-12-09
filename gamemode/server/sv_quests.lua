net.Receive("HL2CR_AssignQuest", function(len, ply)
	if not ply then return end
	
	local questIndex = net.ReadInt(8)
	local questToAssign = net.ReadString()
	
	for k, q in pairs(GAMEMODE.QuestsSystem) do
		if q[questIndex].Name == questToAssign and not table.HasValue(ply.hl2cr.Quests, q[questIndex]) then
			table.insert(ply.hl2cr.Quests, q[questIndex])
		end
	end
end)