ENT.Base = "base_brush"
ENT.Type = "brush"
ENT.MapChange = false

savedBaby = false
savedRoller = false

local playerCount = 0

local MAPS_ONEPLAYER = {
	["d1_eli_01"] = true,
	["d1_town_05"] = true,
	["d3_citadel_01"] = true,
	["d3_citadel_05"] = true
}

function ENT:Initialize()
	
	if not TRIGGER_CHANGELEVEL then
		return
	end
	--Set width, length and height of the changelevel
	local w = TRIGGER_CHANGELEVEL[2].x - TRIGGER_CHANGELEVEL[1].x
	local l = TRIGGER_CHANGELEVEL[2].y - TRIGGER_CHANGELEVEL[1].y
	local h = TRIGGER_CHANGELEVEL[2].z - TRIGGER_CHANGELEVEL[1].z
	local minPos = Vector(-1 - ( w / 2 ), -1 - ( l / 2 ), -1 - ( h / 2 ))
	local maxPos = Vector(w / 2, l / 2, h / 2)

	self:DrawShadow(false)
	self:SetCollisionBounds(minPos, maxPos)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
end

function ENT:StartTouch(ent)	
	if playerCount > 4 then
		playerCount = playerCount + 1
	end
	
	if self.Func then
		self.Func()
	end
	
	if ent:IsValid() and ent:GetModel() == "models/props_c17/doll01.mdl" then
		file.Write("hl2cr_data/babycheck.txt", "baby check")
		ent:Remove()
		savedBaby = true
	end
	
	if ent:IsValid() and ent:GetModel() == "models/roller.mdl" and not game.GetMap() == "d1_town_04" then
		file.Write("hl2cr_data/ballcheck.txt", "rollermine check")
		ent:Remove()
		savedRoller = true
	elseif ent:IsValid() and ent:GetModel() == "models/roller.mdl" and game.GetMap() == "d1_town_04" then
		for k, v in ipairs(player.GetAll()) do
			GrantAchievement(v, "HL2", "Raven_Ball")
		end
		ent:Remove()
	end

	if ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
		ent:SetTeam(TEAM_COMPLETED_MAP)
		if ent:InVehicle() then
			ent:ExitVehicle()
		end
		EnableSpectate(ent)
		for k, p in pairs(player.GetAll()) do
			p:ChatPrint(ent:Nick() .. " has completed the map in " .. string.FormattedTime(CurTime(), "%02i:%02i") .. " (" .. team.NumPlayers(TEAM_COMPLETED_MAP) .. "/" .. playerCount ..")")
		end
		ShowMapResults(ent)
	end
end

function ENT:Think()
	playerCount = #player.GetAll()
	
	--If we're already gonna change map, don't update the counting of completers
	if self.MapChange then return end
	
	--If the player count is over 4, check if completers is greater than total players divided
	if playerCount >= 4 and team.NumPlayers(TEAM_COMPLETED_MAP) >= math.ceil(team.NumPlayers(TEAM_ALIVE) / 2) then
		StartMapCountdown()
		self.MapChange = true
	--else just check if completers is greater than alive players
	elseif playerCount < 4 and team.NumPlayers(TEAM_COMPLETED_MAP) > team.NumPlayers(TEAM_ALIVE) then
		StartMapCountdown()
		self.MapChange = true
	end
	
end