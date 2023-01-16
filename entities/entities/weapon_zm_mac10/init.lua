ENT.Base = "base_point"
ENT.Type = "point"

function ENT:Initialize ( )
	local weapon = ents.Create("weapon_smg1")
	weapon:SetPos(self:GetPos())
	weapon:SetAngles(self:GetAngles() + Angle(0,90,0))
	
	weapon:Spawn()
	
	--self:Kill()
end

function ENT:KeyValue ( Key, Value )
	if string.lower(Key) == "angles" then
		local ang = string.Explode(" ", Value)
		self.Angles = Angle(ang[1], ang[2], ang[3])
	end
end