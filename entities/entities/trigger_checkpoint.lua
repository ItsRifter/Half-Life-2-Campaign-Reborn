ENT.Base = "base_brush"
ENT.Type = "brush"

ENT.TPPoint = Vector(0, 0, 0)
ENT.Mat = "hl2cr/models/checkpoint.vtf"
ENT.Triggered = false

local AchTrigger = {}
function ENT:Initialize()
	
	if self.TPPoint == Vector(0, 0, 0) then
		print("CHECKPOINT FAIL: VECTOR INVALID")
		return
	end

	--Set width, length and height of the checkpoint
	
	local w = self.Max.x - self.Min.x
	local l = self.Max.y - self.Min.y
	local h = self.Max.z - self.Min.z

	local minPos = Vector(-1 - ( w / 2 ), -1 - ( l / 2 ), -1 - ( h / 2 ))
	local maxPos = Vector(w / 2, l / 2, h / 2)
	
	self.Triggered = false

	self:DrawShadow(false)
	self:SetCollisionBounds(minPos, maxPos)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
	
	self:SetMaterial(self.Mat)
end

--When the player touches the entity
function ENT:StartTouch(ent)
	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE and not self.Triggered then
		self.Triggered = true
		
		if self.Func then
			self.Func()
		end

		BroadcastMessageToAll(HL2CR_PlayerColour, ent:Nick(), HL2CR_StandardColour, translate.Get("Player_Checkpoint"))

		for _, p in pairs(player.GetAll()) do
						
			if p:Team() == TEAM_COMPLETED_MAP then break end
			
			if ent ~= p then 
				if p:Team() == TEAM_DEAD then
					p:Spawn()
				end
				
				if p:InVehicle() then
					p:ExitVehicle()
					if p.vehicle and p.vehicle:IsValid() then
						p.vehicle:Remove()
						p.vehicle.owner = nil
					end
					p.vehicle = nil
					p.HasSeat = false
				end
				p.vehicleSpawnable = true
			end
			
			if ents.FindByClass("info_player_start")[1] then	
				for l, spawn in pairs(ents.FindByClass("info_player_start")) do
					spawn:SetPos(self.TPPoint)
					p:SetPos(self.TPPoint)
				end
			elseif ents.FindByClass("info_player_deathmatch")[1] then
				for l, spawn in pairs(ents.FindByClass("info_player_deathmatch")) do
					spawn:SetPos(self.TPPoint)
					p:SetPos(self.TPPoint)
				end
			end
		end
		
		self:EmitSound("hl1/ambience/port_suckin1.wav", 100, 100)
		self.lambdaModel:Remove()
	end

end

function ENT:IsTriggered()
	return self.Triggered
end