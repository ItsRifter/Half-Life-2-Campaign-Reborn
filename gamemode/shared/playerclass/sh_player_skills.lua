AddCSLuaFile()

GM.PlayerSkills = {}

function CreateSkill(name, desc, class, level, icon, pos1, pos2)
	
	local skill = {
		["Name"] = name,
		["Desc"] = desc,
		["Class"] = class,
		["LevelReq"] = level,
		["Icon"] = icon,
		["Invested"] = 0,
	}
	
	return skill
end




if SERVER then
	net.Receive("HL2CR_SkillObtain", function(len, ply)
		if not ply then return end
		
		local skillToAdd = net.ReadString()
		local classAssign = net.ReadString()
		
		for i, v in ipairs(GAMEMODE.PlayerSkills) do
			if v.Name == skillToAdd and v.Class == classAssign then

				table.insert(ply.hl2cr.Skills[classAssign], v.Name)
				
				ply:SetNWString("stat_curskills", table.concat(ply.hl2cr.Skills, " "))
				
				ply.hl2cr.SkillPoints = ply.hl2cr.SkillPoints - 1
				ply:SetNWInt("stat_skillpoints", ply.hl2cr.SkillPoints)
			end
		end	
	end)
end