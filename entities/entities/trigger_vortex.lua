ENT.Base = "base_brush"
ENT.Type = "brush"

ENT.Vortex = nil

function ENT:Initialize()
	self:DrawShadow(false)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(0)
	self:SetTrigger(true)
	self.plys = {}
end

function ENT:StartTouch(ent)
	if ent:IsValid() and ent:IsPlayer() and !table.HasValue( self.plys, ent ) then
		if #self.plys == 0 then
			ent:AddXP(150)
			BroadcastMessageToAll(HL2CR_PlayerColour, ent:Nick(), HL2CR_StandardColour, translate.Get("Server_Announce_Vortex_Found"))
		else
			ent:AddXP(50)
		end
		ent:ProgressAchievement("HL2CR","HL2CR_VORTEX",1)
		table.insert(self.plys,ent)
	end
end