AddCSLuaFile()

SWEP.AdminSpawnable = false
SWEP.Spawnable = true

SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/v_axe.mdl"
SWEP.WorldModel = "models/weapons/w_axe.mdl"
SWEP.HoldType = "melee2"
SWEP.UseHands = false

SWEP.Slot = 0
SWEP.SlotPos = 1
SWEP.Weight = 8
SWEP.base = "weapon_base"

SWEP.Category = "HL2CR"
SWEP.PrintName = "Axe"
SWEP.Author = ""

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.FiresUnderwater = false
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true
SWEP.DrawWeaponInfoBox	= false					
SWEP.BounceWeaponIcon   = false

SWEP.Primary.Sound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.Primary.Damage = 15
SWEP.Primary.TakeAmmo = 0
SWEP.Primary.ClipSize = 0
SWEP.Primary.Ammo = ""
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Spread = 0.2
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 2.5
SWEP.Primary.Delay = 0.40
SWEP.Primary.Force = 0

SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo	= "none"

SWEP.MissSound = Sound( "Weapon_Crowbar.Single" )
SWEP.HitSound = Sound( "Weapon_Crowbar.Melee_Hit" )

function SWEP:Initialize() 
	util.PrecacheSound(self.MissSound) 
	util.PrecacheSound(self.HitSound) 
	self:SetWeaponHoldType( self.HoldType )
end 

function SWEP:PrimaryAttack()

	local tr = {}
		tr.start = self.Owner:GetShootPos()
		tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 100 )
		tr.filter = self.Owner
		tr.mask = MASK_SHOT
	
	local trace = util.TraceLine( tr )

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	if ( trace.Hit ) then
		self.Weapon:EmitSound( self.HitSound )	
		if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(), "npc") or string.find(trace.Entity:GetClass(),"prop_ragdoll") then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			if string.find(trace.Entity:GetClass(), "npc_headcrab") then
				bullet.Damage = self.Primary.Damage * 5
			else
				bullet.Damage = self.Primary.Damage
			end
			self.Owner:FireBullets(bullet) 
		else
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 1
			bullet.Damage = self.Primary.Damage
			self.Owner:FireBullets(bullet) 	
		end
	else
		self.Weapon:EmitSound(self.MissSound) 
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER) 
	end
end
	

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end