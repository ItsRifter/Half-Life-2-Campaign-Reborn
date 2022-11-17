ENT.Base = "base_brush"
ENT.Type = "brush"

ENT.TPSpot = nil

function ENT:Initialize()
		
	self:DrawShadow(false)
	self:SetCollisionBoundsWS(self.Min, self.Max)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
end

function ENT:StartTouch(ent)
	if ent:IsValid() and ent:IsPlayer() then
		GAMEMODE:RemoveVehicle(ent)
		--if ent:InVehicle() then	--Add functionality to pusher for vehicle skips prevention
		--	ent:ExitVehicle()
		--	if ent.vehicle and ent.vehicle:IsValid() then
		--		ent.vehicle:Remove()
		--		ent.vehicle.owner = nil
		--	end
		--	ent.vehicle = nil
		--	ent.HasSeat = false
		--end
	
		ent:SetPos(self.TPSpot)
	end
end