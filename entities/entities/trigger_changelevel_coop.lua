ENT.Base = "base_brush"
ENT.Type = "brush"
ENT.MapChange = false

function ENT:Initialize()

	if not TRIGGER_CHANGELEVEL_COOP then
		return
	end
	
	--Set width, length and height of the changelevel
	local w = TRIGGER_CHANGELEVEL_COOP[2].x - TRIGGER_CHANGELEVEL_COOP[1].x
	local l = TRIGGER_CHANGELEVEL_COOP[2].y - TRIGGER_CHANGELEVEL_COOP[1].y
	local h = TRIGGER_CHANGELEVEL_COOP[2].z - TRIGGER_CHANGELEVEL_COOP[1].z
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
			["Message"] = "PLAYER_FINISHED",
			["Other"] = {
				["Player"] = ent:Nick(),
				["Time"] = string.FormattedTime(CurTime(), "%02i:%02i"),
				["Total"] = " (" .. team.NumPlayers(TEAM_COMPLETED_MAP) .. "/" .. #player.GetAll() .. ")"
			}
		}
		
		BroadcastMessage(PLAYER_FINISHED)
	
		ShowMapResults(ent)
	end
end

function ENT:Think()
	playerCount = #player.GetAll()
	
	--If we're already gonna change map, don't update the counting of completers
	if self.MapChange then return end
	
	--If the player count is over 4, check if completers is greater than total players divided
	if playerCount >= 4 and team.NumPlayers(TEAM_COMPLETED_MAP - 1) > math.ceil(team.NumPlayers(TEAM_ALIVE) / 2) then
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