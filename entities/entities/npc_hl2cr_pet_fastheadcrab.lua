AddCSLuaFile()

ENT.Base 			= "npc_hl2cr_pet_base"
ENT.Spawnable		= true
function ENT:Initialize()

	self:SetModel( "models/headcrab.mdl" )
	
	self.LoseTargetDist	= 200
	self.SearchRadius 	= 250
<<<<<<< Updated upstream
	self.NextAttack 	= 0
	self.AttackDelay 	= 1
	self.followOwner 	= false
=======
	self.NextAttack = 0
	self.followOwner = false
>>>>>>> Stashed changes
	
	self.BaseSpeed = 0
	self.AttackDist = 175
	self.AttackDMG = 0
	
	self:SetHealth(75)
	
	self:AddFlags(FL_NPC)
	self:AddFlags(FL_OBJECT)
	self:SetCollisionGroup(COLLISION_GROUP_NPC)
	self:SetCollisionBounds(Vector(-14, -9, (-6 * 2)), Vector(14, 8, (16 * 2)))
end

list.Set( "NPC", "hl2cr_pet_headcrab", {
	Name = "Headcrab Pet",
	Class = "hl2cr_pet_headcrab",
	Category = "Nextbot"
})