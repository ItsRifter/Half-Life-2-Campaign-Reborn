AddCSLuaFile()
ENT.Base			= "base_ai"
ENT.Type            = "ai"
ENT.Spawnable       = false
ENT.AdminSpawnable  = false

function ENT:Initialize()
	if CLIENT then return end
	self:SetModel("models/props_lab/huladoll.mdl")
	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetOwner(self.Owner)
	self:DropToFloor()

	
	self.npc = ents.Create("npc_zombie")
	self.npc:SetPos(self:GetPos())
	self.npc:SetAngles(self:GetAngles())
	self.npc:Spawn()
	self.npc:Activate()
	self.npc:SetModel("models/nh2zombies/surgeon0" .. math.random(1, 2) .. ".mdl")
	self:SetParent(self.npc)
	
	self.npc:SetHealth(50)
	self.npc:SetMaxHealth(50)
	self.npc:CapabilitiesAdd(CAP_USE)
	self.npc:CapabilitiesAdd(CAP_OPEN_DOORS)
	self.npc:CapabilitiesAdd(CAP_FRIENDLY_DMG_IMMUNE)
	self.npc:CapabilitiesAdd(CAP_DUCK)
	self.npc:CapabilitiesAdd(CAP_SQUAD)
	if IsValid(self.npc) and IsValid(self) then self.npc:DeleteOnRemove(self) end
	
	self:DeleteOnRemove(self.npc)
	
	if( IsValid(self.npc)) then
		local min,max = self.npc:GetCollisionBounds()
		local hull = self.npc:GetHullType()
		self.npc:SetSolid(SOLID_BBOX)
		self.npc:SetPos(self.npc:GetPos()+self.npc:GetUp()*16)
		self.npc:SetHullType(hull)
		self.npc:SetHullSizeNormal()
		self.npc:SetCollisionBounds(min,max)
		self.npc:DropToFloor()
		self.npc:SetModelScale(1)
	end
end

function ENT:Think()
	if CLIENT then return end
	
	if self.npc:Health() <= 0 then
		if ents.FindByClass("npc_headcrab")[1] and ents.FindByClass("npc_headcrab")[1]:IsValid() then
			timer.Simple(0.1, function()
				ents.FindByClass("npc_headcrab")[1]:Remove()
			end)
		end
	end
end