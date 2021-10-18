SWEP.Slot				= 4
SWEP.SlotPos			= 1	
SWEP.Base				= "weapon_base"
SWEP.Category			= "Classic Synergy Weapons"
SWEP.PrintName 			= "SL8"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 55
SWEP.ViewModel			= "models/weapons/v_sl8.mdl"
SWEP.WorldModel			= "models/weapons/w_sl8.mdl"
SWEP.HoldType			= "ar2"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.DrawWeaponInfoBox	= false					
SWEP.BounceWeaponIcon   = false

SWEP.Primary.Sound = "weapons/SL8/SL8-1.wav"
SWEP.Primary.Damage = 15
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.DefaultClip = 30
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = .25
SWEP.Primary.Delay = 0.1
SWEP.Primary.Force = .75

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Initialize()
	self:SetHoldType( self.HoldType )
end

function SWEP:Deploy()
	local AnimationTime = self.Owner:GetViewModel():SequenceDuration()
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + AnimationTime)
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	local bullet = {}
		bullet.Num = self.Primary.NumberofShots
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector( .05, .05, 0)
		bullet.Tracer = 0
		bullet.Force = self.Primary.Force
		bullet.Damage = self.Primary.Damage
		bullet.AmmoType = self.Primary.Ammo
	local rnda = self.Primary.Recoil * -1
	local rndb = self.Primary.Recoil * math.random(-1, 1)
	self:ShootEffects()
	self.Owner:FireBullets( bullet )
	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) )
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
end

function SWEP:CanPrimaryAttack()
	if ( self.Weapon:Clip1() <= 0 ) then
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		self:Reload()
		return false
	end
	return true

end

function SWEP:Reload()
    if self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then

	    self:DefaultReload( ACT_VM_RELOAD )
        local AnimationTime = self.Owner:GetViewModel():SequenceDuration()
        self.ReloadingTime = CurTime() + AnimationTime
        self:SetNextPrimaryFire(CurTime() + AnimationTime)
        self:SetNextSecondaryFire(CurTime() + AnimationTime)

	    timer.Simple(.3, function()
	        self:EmitSound("weapons/SL8/sl8_magout.wav")
	    end)
	    timer.Simple(.85, function()
		    self:EmitSound("weapons/SL8/sl8_2_magin.wav")
	    end)
		timer.Simple(1.45, function()
		    self:EmitSound("weapons/SL8/sl8_boltback.wav")
	    end)
		timer.Simple(1.65, function()
		    self:EmitSound("weapons/SL8/sl8_2_boltforward.wav")
	    end)
    end
end


