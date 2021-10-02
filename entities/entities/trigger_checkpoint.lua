ENT.Base = "base_brush"
ENT.Type = "brush"

ENT.PointIndex = -1

ENT.Mat = "hl2cr/models/checkpoint.vtf"

local AchTrigger = {}
function ENT:Initialize()
	
	if self.PointIndex < 1 then
		print("CHECKPOINT FAIL: INDEX INVALID")
		return
	end

	--Set width, length and height of the checkpoint
	
	local w = self.Max.x - self.Min.x
	local l = self.Max.y - self.Min.y
	local h = self.Max.z - self.Min.z

	local minPos = Vector(-1 - ( w / 2 ), -1 - ( l / 2 ), -1 - ( h / 2 ))
	local maxPos = Vector(w / 2, l / 2, h / 2)
	
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
		
		BroadcastMessage(CHECKPOINT_HIT)
		BroadcastSound("hl2cr/standardbeep.wav")
		
		for _, p in pairs(player.GetAll()) do
			if not table.IsEmpty(AchTrigger) then
				GrantAchievement(p, AchTrigger[1], AchTrigger[2])
			end
						
			if p:Team() == TEAM_COMPLETED_MAP then break end
						
			if ent ~= p then 
				if p:Team() == TEAM_DEAD then
					p:UnSpectate()
					p:Spawn()
					net.Start("HL2CR_ShouldClientSpectate")
						net.WriteBool(false)
						net.WriteBool(false)
						net.WriteInt(0, 8)
					net.Send(p)
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
					spawn:SetPos(self:GetPointPos(self:GetPointIndex()))
					p:SetPos(self:GetPointPos(self:GetPointIndex()))
				end
			elseif ents.FindByClass("info_player_deathmatch")[1] then
				for l, spawn in pairs(ents.FindByClass("info_player_deathmatch")) do
					spawn:SetPos(self:GetPointPos(self:GetPointIndex()))
					p:SetPos(self:GetPointPos(self:GetPointIndex()))
				end
			end
		end
		
		self:EmitSound("hl1/ambience/port_suckin1.wav", 100, 100)
		self.lambdaModel:Remove()
	end
end

function ENT:GetPointIndex()
	return self.PointIndex
end

function ENT:SetPointIndex(index)
	self.PointIndex = index
end

function ENT:IsTriggered()
	return self.Triggered
end

function ENT:GetPointPos(index)
	return CHECKPOINT_POS[index]
end

function ENT:AddPointPos(vec)
	table.insert(Checkpoints.PointPos, vec)
end
