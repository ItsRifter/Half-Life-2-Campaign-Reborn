function AddXP(ply, xpToAdd)
	if not ply.hl2cr then return end
	local adjustedXP = math.Clamp(xpToAdd, 1, 1 * math.Round(xpToAdd / (ply.hl2cr.Level / ply.hl2cr.Level)))
	
	ply.hl2cr.Exp = ply.hl2cr.Exp + adjustedXP
	
	ply:SetNWInt("HL2CR_XP", ply.hl2cr.Exp)
	
	local notifyLevelUp = false
	
	while ply.hl2cr.Exp >= ply.hl2cr.ExpReq and ply.hl2cr.ExpReq > 0 do
			
		ply.hl2cr.Exp = ply.hl2cr.Exp - ply.hl2cr.ExpReq
		ply.hl2cr.ExpReq = math.Round(ply.hl2cr.ExpReq * 1.65)
		ply.hl2cr.Level = ply.hl2cr.Level + 1
		ply.hl2cr.SkillPoints = ply.hl2cr.SkillPoints + 1
		
		notifyLevelUp = true
	end
		
	if notifyLevelUp then	
		ply:SetNWInt("HL2CR_SP", 	ply.hl2cr.SkillPoints)
		ply:SetNWInt("HL2CR_Level", ply.hl2cr.Level)
		ply:SetNWInt("HL2CR_XP",	ply.hl2cr.Exp)
		ply:SetNWInt("HL2CR_ReqXP", ply.hl2cr.ExpReq)
		net.Start("HL2CR_LevelUpSound")
		net.Send(ply)
	end
end

function SetLevel(ply, lvlToSet)
	ply.hl2cr.Level = lvlToSet
	ply:SetNWInt("HL2CR_Level", lvlToSet)
end

function ShowMapResults(ply)
	--if NO_REWARDS_MAPS[game.GetMap()] then return end
		
	net.Start("HL2CR_ClientMapResults")
		net.WriteTable(ply.Rewards)
	net.Send(ply)
end