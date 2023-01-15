ENT.Base = "base_brush"
ENT.Type = "brush"

ENT.TPPoint = Vector(0, 0, 0)
ENT.TPAngles = Angle(0, 0, 0)
ENT.Mat = "hl2cr/models/checkpoint.vtf"
ENT.Triggered = false

function ENT:Initialize()
	
	if self.TPPoint == Vector(0, 0, 0) then
		print("CHECKPOINT FAIL: VECTOR INVALID")
		return
	end

	self:DrawShadow(false)
	self:SetCollisionBoundsWS(self.Min, self.Max)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
	
	self:SetMaterial(self.Mat)
end

--When the player touches the entity
function ENT:Touch(ent)

	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE and not self.Triggered then
		self.Triggered = true
		
		if self.Func then
			self.Func()
		end

		BroadcastMessageToAll(HL2CR_PlayerColour, ent:Nick(), HL2CR_StandardColour, translate.Get("Player_Checkpoint"))

		MoveSpawns(self.TPPoint,self.TPAngles)

		--if ents.FindByClass("info_player_start")[1]:IsValid() then	
			--for l, spawn in pairs(ents.FindByClass("info_player_start")) do
			--	spawn:SetPos(self.TPPoint)
			--	spawn:SetAngles( self.TPAngles )
			--end
		--elseif ents.FindByClass("info_player_deathmatch")[1]:IsValid() then
			--for l, spawn in pairs(ents.FindByClass("info_player_deathmatch")) do
			--	spawn:SetPos(self.TPPoint)
			--	spawn:SetAngles( self.TPAngles )
			--end
		--end

		--for _, p in pairs(player.GetAll()) do
			
		--	if p == ent then continue end

		--	if p:Team() == TEAM_COMPLETED_MAP then continue end
			
		--	if p:Team() == TEAM_DEAD then
		--		p:Spawn()
		--	end
			
		--	GAMEMODE:RemoveVehicle(p)
			
		--	p:SetPos(self.TPPoint)
		--	p:SetEyeAngles(self.TPAngles)
		--end
		
		MovePlayers(self.TPPoint,self.TPAngles, true, ent)
		
		if false then --debug for checkpoint verifying in solo
			GAMEMODE:RemoveVehicle(ent)
			
			ent:SetPos(self.TPPoint)
			ent:SetEyeAngles(self.TPAngles)
		end
			
		self:EmitSound("hl1/ambience/port_suckin1.wav", 100, 100)
		self.lambdaModel:Remove()
	end

end

function ENT:IsTriggered()
	return self.Triggered
end