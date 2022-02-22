function CalculateXP(ply, XP)
	
	local calculation = math.Clamp(XP, 1, ply.hl2cr.ReqExp)
		
	return calculation
end

function AddResin(ply, resin)

	ply.hl2cr.Resin = ply.hl2cr.Resin + resin
	ply.rewards["resin"] = ply.rewards["resin"] + resin

	ply:SetNWInt("currency_resin", ply.hl2cr.Resin)
end

function AddXP(ply, XP)

	ply.hl2cr.Exp = ply.hl2cr.Exp + XP
	
	local notifyLevelUp = false
	
	while ply.hl2cr.Exp >= ply.hl2cr.ReqExp do
			
		ply.hl2cr.Exp = ply.hl2cr.Exp - ply.hl2cr.ReqExp
		ply.hl2cr.Level = ply.hl2cr.Level + 1
		ply.hl2cr.SkillPoints = ply.hl2cr.SkillPoints + 1
		ply.hl2cr.ReqExp = ply.hl2cr.ReqExp + (750 * ply.hl2cr.Level)
		
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
	
	ply.rewards["stats"]["exp"] = ply.rewards["stats"]["exp"] + XP
	ply:SetNWInt("stat_exp", ply.hl2cr.Exp)
end

function AddPetXP(ply, XP)

	if ply.hl2cr.Pets.CurrentPet["level"] >= ply.hl2cr.Pets.CurrentPet["maxLevel"] then return end

	ply.hl2cr.Pets.CurrentPet["xp"] = ply.hl2cr.Pets.CurrentPet["xp"] + XP
	
	local notifyLevelUp = false
	
	while ply.hl2cr.Pets.CurrentPet["xp"] >= ply.hl2cr.Pets.CurrentPet["reqxp"] do
		ply.hl2cr.Pets.CurrentPet["xp"] = ply.hl2cr.Pets.CurrentPet["xp"] - ply.hl2cr.Pets.CurrentPet["xp"]
		ply.hl2cr.Pets.CurrentPet["level"] = ply.hl2cr.Pets.CurrentPet["level"] + 1
		ply.hl2cr.Pets.CurrentPet["skillpoints"] = ply.hl2cr.Pets.CurrentPet["skillpoints"] + 1
		ply.hl2cr.Pets.CurrentPet["reqxp"] = math.ceil(ply.hl2cr.Pets.CurrentPet["reqxp"] + (250 * ply.hl2cr.Pets.CurrentPet["level"]))
		
		notifyLevelUp = true
	end
	
	if notifyLevelUp then	
		ply:SetNWInt("pet_level", ply.hl2cr.Pets.CurrentPet["level"])
		ply:SetNWInt("pet_skillpoints", ply.hl2cr.Pets.CurrentPet["skillpoints"])
		ply:SetNWInt("pet_curxp", ply.hl2cr.Pets.CurrentPet["xp"])
		ply:SetNWInt("pet_curreqxp", ply.hl2cr.Pets.CurrentPet["reqxp"])
		
		if ply.hl2cr.Pets.CurrentPet["level"] >= ply.hl2cr.Pets.CurrentPet["maxLevel"] then
			BroadcastMessage(PET_MAX_LEVEL, ply)
		end
		
		for i, pet in ipairs(ply.hl2cr.Pets) do
			if ply.hl2cr.Pets.CurrentPet.class == ply.hl2cr.Pets[i].class then
				ply.hl2cr.Pets[i].level = ply.hl2cr.Pets.CurrentPet["level"]
			end
		end
	end
	
	ply:SetNWInt("pet_curxp", ply.hl2cr.Pets.CurrentPet["xp"])
end

function SetLevel(ply, lvlToSet)
	ply.hl2cr.Level = lvlToSet
	ply:SetNWInt("HL2CR_Level", lvlToSet)
end

local IMPOSSIBLE_PACIFIST = {
	["d1_eli_01"] = true,
	["d1_eli_02"] = true,
	["d3_c17_01"] = true,
	["ep1_citadel_00"] = true,
	["level_1a"] = true,
	["level_1b"] = true,
	["level_2"] = true,
	["level_3"] = true,
	["level_4a"] = true,
	["level_4b"] = true
}

function ShowMapResults(ply)
	if NO_REWARDS_MAPS[game.GetMap()] then 
		net.Start("HL2CR_ShouldClientSpectate")
			net.WriteBool(true)
			net.WriteBool(false)
			net.WriteInt(0, 8)
			net.WriteBool(false)
		net.Send(ply)
		return
	end
	
	local randStart = math.random(1, 35)
	
	AddResin(ply, randStart * ply.rewards["kills"] * GetConVar("hl2cr_difficulty"):GetInt())
	
	if ply.rewards.bonus["Pacifist"] and not IMPOSSIBLE_PACIFIST[game.GetMap()] then
		AddXP(ply, 250 * GetConVar("hl2cr_difficulty"):GetInt())
		AddResin(ply, 50 * GetConVar("hl2cr_difficulty"):GetInt())
	end
	
	if ply.rewards.bonus["No Deaths"] then
		AddXP(ply, 250 * GetConVar("hl2cr_difficulty"):GetInt())
		AddResin(ply, 50 * GetConVar("hl2cr_difficulty"):GetInt())
	end
	
	if ply.rewards.bonus["Crowbar Only"] then
		AddXP(ply, 1000 * GetConVar("hl2cr_difficulty"):GetInt())
		AddResin(ply, 250 * GetConVar("hl2cr_difficulty"):GetInt())
	end
	
	if ply.rewards.bonus["Teamplayer"] then
		AddXP(ply, 250 * GetConVar("hl2cr_difficulty"):GetInt())
		AddResin(ply, 50 * GetConVar("hl2cr_difficulty"):GetInt())
	end
	
	net.Start("HL2CR_ClientMapResults")
		net.WriteTable(ply.rewards)
	net.Send(ply)
end