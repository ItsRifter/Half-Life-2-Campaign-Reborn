ENT.Base = "base_brush"
ENT.Type = "brush"

ENT.TPSpot = nil

function ENT:Initialize()
		
	--Set width, length and height of the changelevel
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
end

function ENT:StartTouch(ent)
	if ent:IsValid() and ent:IsPlayer() then
		ent:SetPos(self.TPSpot)
	end
end