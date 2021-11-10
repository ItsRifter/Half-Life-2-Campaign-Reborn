AddCSLuaFile()

ENT.Base 			= "npc_hl2cr_pet_base"
ENT.Spawnable		= true

function ENT:Initialize()

	self:SetModel( "models/headcrabclassic.mdl" )
	
	self.LoseTargetDist	= 200
	self.SearchRadius 	= 250
	self.NextAttack 	= 0
	self.AttackDelay 	= 3
	self.followOwner	= false
	
	self.BaseSpeed 		= 0
	self.AttackDist		= 175
	self.AttackDMG 		= 0
	self.BaseHealth 	= 0
	
	if SERVER then
		self.loco:SetStepHeight(20)
	end
	
	self:AddFlags(FL_NPC)
	self:AddFlags(FL_OBJECT)
	self:SetCollisionGroup(COLLISION_GROUP_NPC)
	
	local minBound, maxBound = self:GetCollisionBounds()
	minBound.z = 0
	maxBound.z = maxBound.z * 3
	
	self:SetCollisionBounds(minBound, maxBound)
end

list.Set( "NPC", "hl2cr_pet_headcrab", {
	Name = "Headcrab Pet",
	Class = "hl2cr_pet_headcrab",
	Category = "Nextbot"
})