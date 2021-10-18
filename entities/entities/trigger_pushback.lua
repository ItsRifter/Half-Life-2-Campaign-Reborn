ENT.Base = "base_brush"
ENT.Type = "brush"

ENT.TPSpot = nil

function ENT:Initialize()
	
	if not TRIGGER_PUSHBACK then
		return
	end
	
	if TRIGGER_PUSHBACK_SPOT then
		self.TPSpot = TRIGGER_PUSHBACK_SPOT[1]
	end
	
	--Set width, length and height of the changelevel
	local w = TRIGGER_PUSHBACK[2].x - TRIGGER_PUSHBACK[1].x
	local l = TRIGGER_PUSHBACK[2].y - TRIGGER_PUSHBACK[1].y
	local h = TRIGGER_PUSHBACK[2].z - TRIGGER_PUSHBACK[1].z
	local minPos = Vector(-1 - ( w / 2 ), -1 - ( l / 2 ), -1 - ( h / 2 ))
	local maxPos = Vector(w / 2, l / 2, h / 2)

	self:DrawShadow(false)
	self:SetCollisionBounds(minPos, maxPos)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
end

function ENT:Touch(ent)	

	if ent:IsValid() and ent:IsPlayer() then
		ent:SetPos(self.TPSpot)
	end
	
end