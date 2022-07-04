ENT.Base = "base_brush"
ENT.Type = "brush"
ENT.MapChange = false

function ENT:Initialize()
	
	self:DrawShadow(false)
	self:SetCollisionBoundsWS(self.Min, self.Max)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
end

function ENT:Touch(ent)	
	
	if self.Func then
		self.Func()
	end
	
	if ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
		
		ent:SetTeam(TEAM_COMPLETED_MAP)
		
		BroadcastMessageToAll(HL2CR_PlayerColour, ent:Nick(), HL2CR_StandardColour, translate.Get("Player_CompletedMap"), string.FormattedTime(CurTime(), "%02i:%02i"))

		ent:DisplayResults()

		if ent:InVehicle() then
			ent:ExitVehicle()
			if ent.vehicle then
				ent.vehicle:Remove()
			end
		end

		ent:ToggleSpectator(true)
	end

	//If we're not changing, check if we should start changing the map
	if not self.MapChange then
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
end