AddCSLuaFile()

SWEP.PrintName =			"SMG"
SWEP.AuthorName =			"Niik"
SWEP.Purpose = 				""
SWEP.Category =				"Nightmare House 2"

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Weight					= 5

SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 1
SWEP.SlotPos				= 3
SWEP.DrawCrosshair			= true
SWEP.AccurateCrosshair		= false

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.Ammo			= "none"
SWEP.DrawAmmo = true
SWEP.HoldType = "pistol"
SWEP.ViewModel = "models/weapons/v_smg.mdl"
SWEP.WorldModel = "models/weapons/w_smg.mdl"

if(CLIENT)then
	SWEP.BounceWeaponIcon = false
end

function SWEP:Initialize()
	self:SetWeaponHoldType("smg")
end

function SWEP:PrimaryAttack()

	if not (self:CanPrimaryAttack()) then return self:Reload() end

	self:SendWeaponAnim(181)
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	local bullet = {} 

	bullet.Num = 1
	bullet.Src = self.Owner:GetShootPos() 
	bullet.Dir = self.Owner:GetAimVector() 
	bullet.Spread = Vector( 0.04, 0.04, 0)
	bullet.Tracer = 1 
	bullet.TracerName = "Tracer"
	bullet.Force = self.Primary.Force 
	bullet.Damage = 8 
	bullet.AmmoType = self.Primary.Ammo 

	self:ShootEffects()

	self:TakePrimaryAmmo(1)
	self.Owner:FireBullets( bullet ) 
	self:EmitSound(Sound("weapons_nh/smg/shoot"..math.random(1,3)..".wav")) 
	if(self.Owner:IsPlayer())then
		self.Owner:ViewPunch( Angle( math.Rand(-0.5,0.25),math.Rand(-0.5,0.5), 0 ) ) 	
	end
		 
	self:SetNextPrimaryFire( CurTime() + 0.08 )
	self:SetNextSecondaryFire( CurTime() + 0.08 ) 
end 

function SWEP:SecondaryAttack()
end

function SWEP:Reload()		
	if ( self.Weapon:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then		
		self:DefaultReload(ACT_VM_RELOAD)
		self:EmitSound("weapons_nh/smg/reload.wav")
		return true
	end
end

function SWEP:Equip()
	if (self.Owner:IsNPC()) then
		self:EmitSound("weapons_nh/smg/draw.wav")
	end
end

function SWEP:Deploy()
	if (self.Owner:IsPlayer()) then
		self:EmitSound("weapons_nh/smg/draw.wav")
	end
	self:SetDeploySpeed( self.Weapon:SequenceDuration() )
    self.Weapon:SendWeaponAnim( ACT_VM_DEPLOY )
    return true
end


function SWEP:CanBePickedUpByNPCs()
	return false
end