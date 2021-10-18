AddCSLuaFile()

SWEP.PrintName =			"Colt"
SWEP.AuthorName =			"Niik"
SWEP.Purpose = 				""
SWEP.Category =				"Nightmare House 2"

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Weight					= 5

SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 1
SWEP.SlotPos				= 1
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= true
SWEP.AccurateCrosshair		= false

SWEP.Primary.ClipSize		= 9
SWEP.Primary.DefaultClip	= 50
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

SWEP.Secondary.Ammo			= "none"
SWEP.DrawAmmo = true
SWEP.HoldType = "pistol"
SWEP.ViewModel = "models/weapons/v_colt.mdl"
SWEP.WorldModel = "models/weapons/w_colt.mdl"

if(CLIENT)then
	SWEP.BounceWeaponIcon = false
end

function SWEP:Initialize()
	self:SetWeaponHoldType("pistol")
end

function SWEP:PrimaryAttack()

	if not (self:CanPrimaryAttack()) then return self:EmitSound(Sound("weapons_nh/pistol/empty.wav")) end

	self:SendWeaponAnim(181)
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	local bullet = {} 

	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos() 
	bullet.Dir = self.Owner:GetAimVector() 
	bullet.Spread = Vector( 0.031, 0.031, 0)
	bullet.Tracer = 1 
	bullet.TracerName = "Tracer"
	bullet.Force = self.Primary.Force 
	bullet.Damage = 5
	bullet.AmmoType = self.Primary.Ammo 

	self:ShootEffects()

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound("weapons_nh/pistol/shoot"..math.random(1,2)..".wav")) 
	if(self.Owner:IsPlayer())then
		self.Owner:ViewPunch( Angle( math.Rand(-1,0.5),math.Rand(-1,1), 0 ) ) 	
	end
		 
	self:TakePrimaryAmmo(1)
	self:SetNextPrimaryFire( CurTime() + 0.2 )
end 

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	if ( self.Weapon:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then	
		self:DefaultReload(ACT_VM_RELOAD)
		self:EmitSound(Sound("weapons_nh/pistol/reload.wav"))
		return true
	end
end

function SWEP:Equip()
	if (self.Owner:IsNPC()) then
		self:EmitSound("weapons_nh/pistol/draw.wav")
	end
end

function SWEP:Deploy()
	if (self.Owner:IsPlayer()) then
		self:EmitSound("weapons_nh/pistol/draw.wav")
	end
	self:SetDeploySpeed( self.Weapon:SequenceDuration() )
    self.Weapon:SendWeaponAnim( ACT_VM_DEPLOY )
    return true
end

function SWEP:CanBePickedUpByNPCs()
	return false
end
