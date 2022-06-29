ENT.Base = "base_brush"
ENT.Type = "brush"
ENT.MapChange = false

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
	
	if ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
		
		ent:SetTeam(TEAM_COMPLETED_MAP)
		
		BroadcastMessageToAll(HL2CR_PlayerColour, ent:Nick(), HL2CR_StandardColour, translate.Get("Player_CompletedMap"), string.FormattedTime(CurTime(), "%02i:%02i"))

		if ent:InVehicle() then
			ent:ExitVehicle()
			if ent.vehicle then
				ent.vehicle:Remove()
			end
		end
	end
end

function ENT:Think()
	
	--If we're already gonna change map, don't update the counting of completers
	if self.MapChange then return end
	
	BroadcastMessageToAll(HL2CR_StandardColour, translate.Get("Map_Finished"))
	
	--If the player count is over 4, check if completers is greater than total players divided
	if #player.GetAll() >= 4 and team.NumPlayers(TEAM_COMPLETED_MAP) > math.ceil((team.NumPlayers(TEAM_ALIVE) / 2) + 1) then		
		self.MapChange = true
		StartMapCountdown()
	--else just check if completers is greater than alive players
	elseif #player.GetAll() < 4 and team.NumPlayers(TEAM_COMPLETED_MAP) > team.NumPlayers(TEAM_ALIVE) then		
		self.MapChange = true
		StartMapCountdown()
	end
	
end