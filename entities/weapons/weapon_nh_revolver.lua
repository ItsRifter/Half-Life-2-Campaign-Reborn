AddCSLuaFile()

SWEP.PrintName =			"Revolver"
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

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "357"

SWEP.Secondary.Ammo			= "none"
SWEP.DrawAmmo = true
SWEP.HoldType = "pistol"
SWEP.ViewModel = "models/weapons/v_revolver.mdl"
SWEP.WorldModel = "models/weapons/w_revolver.mdl"

if(CLIENT)then
	SWEP.BounceWeaponIcon = false
end

function SWEP:Initialize()
	self:SetWeaponHoldType("revolver")
end

function SWEP:PrimaryAttack()

	self:SendWeaponAnim(181)
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	if not (self:CanPrimaryAttack()) then return end

	local bullet = {} 

	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos() 
	bullet.Dir = self.Owner:GetAimVector() 
	bullet.Spread = Vector( 0.015, 0.015, 0)
	bullet.Tracer = 1 
	bullet.TracerName = "Tracer"
	bullet.Force = self.Primary.Force 
	bullet.Damage = 85
	bullet.AmmoType = self.Primary.Ammo 

	self:ShootEffects()

	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound("weapons_nh/revolver/shoot"..math.random(1,3)..".wav")) 
	if(self.Owner:IsPlayer())then
		self.Owner:ViewPunch( Angle( math.Rand(-2,1),math.Rand(-2,2), 0 ) ) 	
	end
		 
	self:TakePrimaryAmmo(1)
	self:SetNextPrimaryFire( CurTime() + 0.5 )
end 

function SWEP:SecondaryAttack()
end

function SWEP:Reload()			
	if ( self.Weapon:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then		
		self:DefaultReload(ACT_VM_RELOAD)
		self:EmitSound(Sound("weapons_nh/revolver/reload.wav"))
		return true
	end
end

function SWEP:Equip()
	if (self.Owner:IsNPC()) then
		self:EmitSound(Sound("weapons_nh/revolver/draw.wav"))
	end
end

function SWEP:Deploy()
	if (self.Owner:IsPlayer()) then
		self:EmitSound("weapons_nh/revolver/draw.wav")
	end
	self:SetDeploySpeed( self.Weapon:SequenceDuration() )
    self.Weapon:SendWeaponAnim( ACT_VM_DEPLOY )
    return true
end

function SWEP:CanBePickedUpByNPCs()
	return false
end