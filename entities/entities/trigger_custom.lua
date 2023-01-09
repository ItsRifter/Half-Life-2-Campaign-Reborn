ENT.Base = "base_brush"
ENT.Type = "brush"

ENT.TPPoint = Vector(0, 0, 0)
ENT.TPAngles = Angle(0, 0, 0)
ENT.Mat = "hl2cr/models/checkpoint.vtf"
ENT.Triggered = false
ENT.Once = false
ENT.Delay = 0

function ENT:Initialize()

	self:DrawShadow(false)
	self:SetCollisionBoundsWS(self.Min, self.Max)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
	
	self:SetMaterial(self.Mat)
end

--When an ent starts touching the brush
function ENT:Touch(ent)

	if ent and ent:IsValid() and not self.Triggered then

	 self.Triggered = self.Func(ent)
	 if self.Triggered and not self.Once then

		if self.Delay <=0 then 
			self.Triggered = false
		else
			timer.Simple( self.Delay, function() 
				self.Triggered = false
			end  )
		end
	 end

	end

end

function ENT:IsTriggered()
	return self.Triggered
end