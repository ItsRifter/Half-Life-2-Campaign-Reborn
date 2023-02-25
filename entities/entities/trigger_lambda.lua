ENT.Base = "base_brush"
ENT.Type = "brush"
ENT.Index = -1
function ENT:Initialize()

	--Set width, length and height of the lambda trigger
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

--When the player touches the lambda trigger
function ENT:StartTouch(ent)

	if ent and ent:IsValid() and ent:IsPlayer() and ent:Team() == TEAM_ALIVE then
		--ent:UpdateLambdaLocator(game.GetMap() .. "_" .. self.Index)
		ent:ProgressAchievement("HL2","HL2_Lambda",game.GetMap() .. "_" .. self.Index)
	end
	
	--timer.Simple(2, function()
	--	self.Triggered = false
	--end)
end
