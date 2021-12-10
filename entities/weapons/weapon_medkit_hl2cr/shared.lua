
AddCSLuaFile()

SWEP.PrintName = "Medkit"
SWEP.Author = ""
SWEP.Purpose = ""

SWEP.Slot = 5
SWEP.SlotPos = 3

SWEP.Spawnable = true

SWEP.ViewModel = Model( "models/weapons/c_medkit.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_medkit.mdl" )
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 50
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.HealAmount = 10
SWEP.MaxAmmo = 100

local HealSound = Sound( "HealthKit.Touch" )
local DenySound = Sound( "WallHealth.Deny" )

function SWEP:Initialize()

	self:SetHoldType( "slam" )

	if ( CLIENT ) then return end
	timer.Simple(0.1, function()
		local healer = self.Owner
		
		timer.Create( "medkit_ammo" .. self:EntIndex(), 20, 0, function()
			if ( self:Clip1() < self.MaxAmmo ) then self:SetClip1( math.min( self:Clip1() + (5 + healer:GetNWInt("skill_healthrecharge")), self.MaxAmmo ) ) end
		end )
	end)
end

function SWEP:PrimaryAttack()

	if ( CLIENT ) then return end

	if ( self.Owner:IsPlayer() ) then
		self.Owner:LagCompensation( true )
	end

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
		filter = self.Owner
	} )

	if ( self.Owner:IsPlayer() ) then
		self.Owner:LagCompensation( false )
	end

	local ent = tr.Entity
	
	local healer = self.Owner
	
	local need = self.HealAmount
	
	if IsValid(ent) and ent:IsPlayer() and ent.hl2cr.CurClass.Name == "Robot" then
		self.Owner:EmitSound( DenySound )
		return
	elseif IsValid(ent) and (ent:IsPet() or ent:IsHostile()) then
		self.Owner:EmitSound( DenySound )
		return
	end
	
	if ( IsValid( ent ) ) then need = math.min( ent:GetMaxHealth() - ent:Health(), self.HealAmount ) end

	if ( IsValid( ent ) && self:Clip1() >= need && ( ent:IsPlayer() or ent:IsNPC() ) && ent:Health() < ent:GetMaxHealth() ) then

		self:TakePrimaryAmmo( need )

		ent:SetHealth( math.min( ent:GetMaxHealth(), ent:Health() + (need + healer:GetNWInt("skill_healing") )) )
		ent:EmitSound( HealSound )
		
		AddXP(self.Owner, need + self.Owner:GetNWInt("skill_healing") * 2 * GetConVar("hl2cr_difficulty"):GetInt())
			
		net.Start("HL2CR_SpawnIndicators")
			net.WriteInt((need + self.Owner:GetNWInt("skill_healing")) * 2, 32)
			net.WriteVector(tr.Entity:GetPos())
			net.WriteBool(false)
		net.Send(self.Owner)
		
		self.Owner.rewards.bonus["Teamplayer"] = true
		
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() + 1 )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		-- Even though the viewmodel has looping IDLE anim at all times, we need this to make fire animation work in multiplayer
		timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 1, function() if ( IsValid( self ) ) then self:SendWeaponAnim( ACT_VM_IDLE ) end end )

	else

		self.Owner:EmitSound( DenySound )
		self:SetNextPrimaryFire( CurTime() + 0.1 )

	end

end

function SWEP:SecondaryAttack()
	if ( CLIENT ) then return end	
	
	if ( self.Owner:IsPlayer() ) then
		if self.Owner:GetNWBool("CanRevive") == false then return end
		
		self.Owner:LagCompensation( true )
	end

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
		filter = self.Owner
	} )

	if ( self.Owner:IsPlayer() ) then
		self.Owner:LagCompensation( false )
	end
	
	
	local ent = tr.Entity

	if not ent.player then return end

	local healer = self.Owner
	
	local need = 50

	if IsValid( ent.player ) && self:Clip1() >= need then
		
		self.Owner:EmitSound("items/suitchargeok1.wav")
		
		timer.Create("revive_" .. self:EntIndex(), 3, 1, function()
			
			local tr2 = util.TraceLine( {
				start = self.Owner:GetShootPos(),
				endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
				filter = self.Owner
			} )
			
			local checkAim = tr2.Entity.player
			
			if not checkAim then return end
			
			self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			self:TakePrimaryAmmo( need )
			self.Owner:EmitSound("npc/roller/mine/rmine_shockvehicle1.wav")
			ent.player:Spawn()
			ent.player:SetHealth(ent.player:GetMaxHealth() / 2)
			ent.player:SetPos(ent:GetPos())
			ent:Remove()
		
			AddXP(self.Owner, need + self.Owner:GetNWInt("skill_healing") * 2)
		
			net.Start("HL2CR_SpawnIndicators")
				net.WriteInt( need  * 2, 32)
				net.WriteVector(ent.player:GetPos())
			net.Send(self.Owner)
			
		end)
			
		
		self.Owner.rewards.bonus["Teamplayer"] = true
		
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:SetNextSecondaryFire( CurTime() + self:SequenceDuration() + 2.5 )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		-- Even though the viewmodel has looping IDLE anim at all times, we need this to make fire animation work in multiplayer
		timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 1, function() if ( IsValid( self ) ) then self:SendWeaponAnim( ACT_VM_IDLE ) end end )
	end
end

function SWEP:OnRemove()

	timer.Stop( "medkit_ammo" .. self:EntIndex() )
	timer.Stop( "weapon_idle" .. self:EntIndex() )

end

function SWEP:Holster()

	timer.Stop( "weapon_idle" .. self:EntIndex() )

	return true

end

function SWEP:CustomAmmoDisplay()

	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true
	self.AmmoDisplay.PrimaryClip = self:Clip1()

	return self.AmmoDisplay

end
