AddCSLuaFile()

SWEP.PrintName =			"Hatchet"
SWEP.AuthorName =			"Niik"
SWEP.Purpose = 				""
SWEP.Category =				"Nightmare House 2"

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Weight					= 5

SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 1
SWEP.SlotPos				= 4
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= true
SWEP.AccurateCrosshair		= false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.Ammo			= "none"
SWEP.DrawAmmo = true
SWEP.HoldType = "melee2"
SWEP.ViewModel = "models/weapons/v_hatchet.mdl"
SWEP.WorldModel = "models/weapons/w_hatchet.mdl"

if(CLIENT)then
	SWEP.BounceWeaponIcon = false
end

function SWEP:Initialize()
	self:SetWeaponHoldType("melee")
end

function SWEP:NHAxeAttack( time, dmg, anim )
	local vm = self.Owner:GetViewModel()
	local trace = util.TraceLine( {
	start = self.Owner:GetShootPos(),
	endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 90, 
	filter = self.Owner } )

	if ( !IsValid( trace.Entity ) ) then 
		trace = util.TraceHull( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 90,
		filter = self.Owner,
		mins = Vector( -10, -10, -8 ),
		maxs = Vector( 10, 10, 8 ) } )
	end

	if ( trace.HitWorld ) then
		if (anim == 1 ) then
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "swing_hit" ) )
		else
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "heavy_swing_hit" ) )
		end
		timer.Simple( time , function()
			if (anim == 1) then
				self.Weapon:EmitSound(Sound("weapons_nh/hatchet/slash"..math.random(1,2)..".wav"))
			else
				self.Weapon:EmitSound(Sound("weapons_nh/hatchet/heavy_slash"..math.random(1,2)..".wav"))
			end
		end)
	elseif ( IsValid( trace.Entity ) ) then
		if (anim == 1) then
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "swing_hit" ) )
		else
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "heavy_swing_hit" ) )
		end
		timer.Simple( time , function()
			self.Weapon:EmitSound(Sound("weapons_nh/hatchet/stab"..math.random(1,2)..".wav"))
			if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
				local effectdata = EffectData()
				effectdata:SetOrigin(trace.HitPos)
				effectdata:SetEntity(ent)
			end
			if (SERVER) then
				if trace.Entity then
					trace.Entity:TakeDamage( dmg, self.Owner)
				end
			end
		end)
	else
		if ( anim == 1 ) then
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "swing" ) )
		else
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "heavy_swing" ) )
		end
		if (self.Owner:IsPlayer() ) then
			if ( anim == 1 ) then
				timer.Simple( .15 , function()
				self.Weapon:EmitSound(Sound("weapons_nh/hatchet/swing"..math.random(1,2)..".wav"))
				end)
			else
				timer.Simple( 0.385 , function()
					self.Weapon:EmitSound(Sound("weapons_nh/hatchet/heavy_swing"..math.random(1,2)..".wav"))
				end)
			end
		end
	end

	if ( self.Owner:IsPlayer() ) then
		timer.Create("reset_vm_anim"..self:EntIndex(),self.Owner:GetViewModel():SequenceDuration(),1,function()
			if self:IsValid() then
				vm:SendViewModelMatchingSequence( vm:LookupSequence( "idle" ) )
			end
		end)
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
	elseif ( self.Owner:IsNPC() ) then
		self.Owner:SetAnimation( NPC_ATTACK1 )
	end
end

function SWEP:PrimaryAttack()
	self:NHAxeAttack( 0.15, 30, 1 )
	self.Weapon:SetNextPrimaryFire( CurTime() + 1.2 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 1.2 )
end

function SWEP:SecondaryAttack()
	self:NHAxeAttack( 1, 73, 2 )
	self.Weapon:SetNextPrimaryFire( CurTime() + 2.2 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 2.2 )
end

function SWEP:Reload()
end

function SWEP:Equip()
	if (self.Owner:IsNPC()) then
		self:EmitSound("weapons_nh/hatchet/draw.wav")
	end
end

function SWEP:Deploy()
	local vm = self.Owner:GetViewModel()
	if (self.Owner:IsPlayer()) then
		self:EmitSound("weapons_nh/hatchet/draw.wav")
	end
	self:SetDeploySpeed( self.Weapon:SequenceDuration() )
    self.Weapon:SendWeaponAnim( ACT_VM_DEPLOY )
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "draw" ) )
    return true
end


function SWEP:CanBePickedUpByNPCs()
	return false
end