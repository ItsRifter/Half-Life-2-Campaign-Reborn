function CalculateXP(ply, XP)
	
	local calculation = math.Clamp(XP, 1, ply.hl2cr.ReqExp)
		
	return calculation
end

function AddResin(ply, resin)

	ply.hl2cr.Resin = ply.hl2cr.Resin + resin

	ply:SetNWInt("currency_resin", ply.hl2cr.Resin)
end

function AddXP(ply, XP)

	ply.hl2cr.Exp = ply.hl2cr.Exp + XP
	
	local notifyLevelUp = false
	
	while ply.hl2cr.Exp >= ply.hl2cr.ReqExp do
			
		ply.hl2cr.Exp = ply.hl2cr.Exp - ply.hl2cr.ReqExp
		ply.hl2cr.Level = ply.hl2cr.Level + 1
		ply.hl2cr.SkillPoints = ply.hl2cr.SkillPoints + 1
		ply.hl2cr.ReqExp = math.ceil(ply.hl2cr.ReqExp + (1500 * ply.hl2cr.Level))
		notifyLevelUp = true
	end
		
	if notifyLevelUp then	
		ply:SetNWInt("stat_skillpoints", ply.hl2cr.SkillPoints)
		ply:SetNWInt("stat_level", ply.hl2cr.Level)
		ply:SetNWInt("stat_reqexp", ply.hl2cr.ReqExp)
		net.Start("HL2CR_LevelUpSound")
			net.WriteInt(ply.hl2cr.Level, 16)
		net.Send(ply)
	end
	
	ply:SetNWInt("stat_exp", ply.hl2cr.Exp)
end

function SetLevel(ply, lvlToSet)
	ply.hl2cr.Level = lvlToSet
	ply:SetNWInt("HL2CR_Level", lvlToSet)
end

local IMPOSSIBLE_PACIFIST = {
	["d1_eli_01"] = true,
	["d1_eli_02"] = true,
	["d3_c17_01"] = true
}

function ShowMapResults(ply)
	if NO_REWARDS_MAPS[game.GetMap()] then 
		net.Start("HL2CR_ShouldClientSpectate")
			net.WriteBool(true)
			net.WriteBool(false)
			net.WriteInt(0, 8)
		net.Send(ply)
		return
	end
	
	local randStart = math.random(1, 25)
	
	ply.hl2cr.Resin = ply.hl2cr.Resin + (randStart * ply.rewards["kills"] * GetConVar("hl2cr_difficulty"):GetInt())
	
	ply.rewards["resin"] = (randStart * ply.rewards["kills"] * GetConVar("hl2cr_difficulty"):GetInt())
	
	if ply.rewards.bonus["Pacifist"] and not IMPOSSIBLE_PACIFIST[game.GetMap()] then
		AddXP(ply, 1000 * GetConVar("hl2cr_difficulty"):GetInt())
		AddResin(ply, 250 * GetConVar("hl2cr_difficulty"):GetInt())
	end
	
	if ply.rewards.bonus["No Deaths"] then
		AddXP(ply, 500 * GetConVar("hl2cr_difficulty"):GetInt())
		AddResin(ply, 100 * GetConVar("hl2cr_difficulty"):GetInt())
	end
	
	if ply.rewards.bonus["Crowbar Only"] then
		AddXP(ply, 2000 * GetConVar("hl2cr_difficulty"):GetInt())
		AddResin(ply, 500 * GetConVar("hl2cr_difficulty"):GetInt())
	end
	
	if ply.rewards.bonus["Teamplayer"] then
		AddXP(ply, 500 * GetConVar("hl2cr_difficulty"):GetInt())
		AddResin(ply, 100 * GetConVar("hl2cr_difficulty"):GetInt())
	end
	
	net.Start("HL2CR_ClientMapResults")
		net.WriteTable(ply.rewards)
	net.Send(ply)
end