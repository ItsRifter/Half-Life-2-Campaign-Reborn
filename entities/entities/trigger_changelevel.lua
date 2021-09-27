ENT.Base = "base_brush"
ENT.Type = "brush"
ENT.MapChange = false

savedBaby = false
savedRoller = false

local MAPS_ONEPLAYER = {
	["d1_eli_01"] = true,
	["d1_town_05"] = true,
	["d3_citadel_01"] = true,
	["d3_citadel_05"] = true
}

local FINAL_MAPS = {
	["d3_breen_01"] = true
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
		file.Delete("hl2cr_data/ballcheck.txt")
	end

	if ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
		
		ent:SetTeam(TEAM_COMPLETED_MAP)
		
		if ent:InVehicle() then
			ent:ExitVehicle()
			if ent.vehicle then
				ent.vehicle:Remove()
			end
		end
		
		EnableSpectate(ent)
		
		net.Start("HL2CR_ShouldClientSpectate")
			net.WriteBool(true)
			net.WriteBool(false)
			net.WriteInt(0, 8)
		net.Send(ent)
			
		local PLAYER_FINISHED = {
			["Colour"] = Color(230, 190, 0),
			["Message"] = ent:Nick() .. " has completed the map in " .. string.FormattedTime(CurTime(), "%02i:%02i") .. " (" .. team.NumPlayers(TEAM_COMPLETED_MAP) .. "/" .. #player.GetAll() ..")"
		}
		
		BroadcastMessage(PLAYER_FINISHED)
	
		ShowMapResults(ent)
	end
end

function ENT:Think()
	playerCount = #player.GetAll()
	
	--If we're already gonna change map, don't update the counting of completers
	if self.MapChange then return end
	
	if FINAL_MAPS[game.GetMap()] then self.MapChange = true return end
	
	--If the player count is over 4, check if completers is greater than total players divided
	if playerCount >= 4 and team.NumPlayers(TEAM_COMPLETED_MAP) >= math.ceil(team.NumPlayers(TEAM_ALIVE) / 2) then
		StartMapCountdown()
		net.Start("HL2CR_MapCountdown")
		net.Broadcast()
		
		self.MapChange = true
	--else just check if completers is greater than alive players
	elseif playerCount < 4 and team.NumPlayers(TEAM_COMPLETED_MAP) > team.NumPlayers(TEAM_ALIVE) then
		StartMapCountdown()
		net.Start("HL2CR_MapCountdown")
		net.Broadcast()
		
		self.MapChange = true
	end
	
end