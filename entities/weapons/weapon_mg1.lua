SWEP.AdminSpawnable = false
SWEP.Spawnable = true

SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/v_synergy_mg1.mdl"
SWEP.WorldModel = "models/weapons/w_synergy_mg1.mdl"
SWEP.HoldType = "ar2" 
SWEP.UseHands = false

SWEP.Slot = 3
SWEP.Weight = 5
SWEP.SlotPos = 3
SWEP.base = "weapon_base"

SWEP.Category = "Synergy SWEPS"
SWEP.PrintName = "Combine Pulse Rifle X"
SWEP.Author = "QuickNinjaCat"

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.FiresUnderwater = false
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true
SWEP.DrawWeaponInfoBox	= false					
SWEP.BounceWeaponIcon   = false

SWEP.Primary.Sound = "Weapon_Synergy_MG1.Single"
SWEP.Primary.Damage = 15
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 60
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.DefaultClip = 60
SWEP.Primary.Spread = 0.2
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = .125
SWEP.Primary.Delay = 0.09
SWEP.Primary.Force = .75

SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false	
SWEP.Secondary.Ammo	= "none"

function SWEP:Initialize()
	util.PrecacheSound(self.Primary.Sound)

	self:SetHoldType( self.HoldType )
	
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	local bullet = {}
		bullet.Num = self.Primary.NumberofShots
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
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

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	if self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then

	    self:DefaultReload( ACT_VM_RELOAD )
        local AnimationTime = self.Owner:GetViewModel():SequenceDuration()
        self.ReloadingTime = CurTime() + AnimationTime
        self:SetNextPrimaryFire(CurTime() + AnimationTime)
        self:SetNextSecondaryFire(CurTime() + AnimationTime)
		self.Weapon:EmitSound("Weapon_Synergy_MG1.Reload_Full+0.75sec.silence")
	end
end