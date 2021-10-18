SWEP.AdminSpawnable = false
SWEP.Spawnable = true

SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/c_synergy_mp5k.mdl"
SWEP.WorldModel = "models/weapons/w_synergy_mp5k.mdl"
SWEP.HoldType = "smg"
SWEP.UseHands = true

SWEP.Slot = 2
SWEP.SlotPos = 3 
SWEP.Weight = 5
SWEP.base = "weapon_base"

//Spawnmenu Related
SWEP.Category = "Synergy SWEPS"
SWEP.PrintName = "MP5K C"
SWEP.Author = "QuickNinjaCat"

//Misc. Settings
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.FiresUnderwater = false
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true
SWEP.DrawWeaponInfoBox	= false					
SWEP.BounceWeaponIcon   = false

SWEP.Primary.Sound = "Weapon_Synergy_MP5K.Single"
SWEP.Primary.Damage = 5
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Spread = 0.375
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

	self:SetWeaponHoldType( self.HoldType )
	
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
		self.Weapon:EmitSound("Weapon_Synergy_MP5K.Reload")
		timer.Create( "Timer_AnimReset", 1.5, 1, function() self.Weapon:SendWeaponAnim( ACT_VM_IDLE ) end );
	end
end

function SWEP:Holster( wep )
	timer.Stop( "Timer_AnimReset" )
	return true
end