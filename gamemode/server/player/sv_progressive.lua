function CalculateXP(ply, XP)
	
	local calculation = math.Clamp(XP, 1, ply.hl2cr.ReqExp)
		
	return calculation
end

function AddXP(ply, XP)

	ply.hl2cr.Exp = ply.hl2cr.Exp + XP
	
	local notifyLevelUp = false
	
	while ply.hl2cr.Exp >= ply.hl2cr.ReqExp do
			
		ply.hl2cr.Exp = ply.hl2cr.Exp - ply.hl2cr.ReqExp
		ply.hl2cr.ReqExp = math.Round(ply.hl2cr.ReqExp * 2.5)
		ply.hl2cr.Level = ply.hl2cr.Level + 1
		ply.hl2cr.SkillPoints = ply.hl2cr.SkillPoints + 1
		
		notifyLevelUp = true
	end
		
	if notifyLevelUp then	
		ply:SetNWInt("stat_skillpoints", ply.hl2cr.SkillPoints)
		ply:SetNWInt("stat_level", ply.hl2cr.Level)
		ply:SetNWInt("stat_reqexp", ply.hl2cr.ReqExp)
		net.Start("HL2CR_LevelUpSound")
		net.Send(ply)
	end
	
	ply:SetNWInt("stat_exp", ply.hl2cr.Exp)
end

function SetLevel(ply, lvlToSet)
	ply.hl2cr.Level = lvlToSet
	ply:SetNWInt("HL2CR_Level", lvlToSet)
end

function ShowMapResults(ply)
	if NO_REWARDS_MAPS[game.GetMap()] then 
		net.Start("HL2CR_ShouldClientSpectate")
		net.WriteBool(true)
		net.Send(ply)
		return 
	end
	
	net.Start("HL2CR_ClientMapResults")
		net.WriteTable(ply.rewards)
	net.Send(ply)
end