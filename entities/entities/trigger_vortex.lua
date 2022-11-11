ENT.Base = "base_brush"
ENT.Type = "brush"

ENT.Vortex = nil

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
end

function ENT:StartTouch(ent)
	if ent:IsValid() and ent:IsPlayer() then
		ent:AddXP(500)
		BroadcastMessageToAll(HL2CR_PlayerColour, ent:Nick(), HL2CR_StandardColour, translate.Get("Server_Announce_Vortex_Found"))
		self.Vortex:Remove()
		self.Vortex = nil
		self:Remove()
	end
end