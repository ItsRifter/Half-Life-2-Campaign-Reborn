AddCSLuaFile()

SWEP.PrintName =			"Shotgun"
SWEP.AuthorName =			"Niik"
SWEP.Purpose = 				"Rock, paper... SHOTGUN! >:)"
SWEP.Category =				"Nightmare House 2"

SWEP.Spawnable = true
SWEP.AdminOnly = false
SWEP.Weight					= 5

SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 3
SWEP.SlotPos				= 4
SWEP.DrawAmmo				= false
SWEP.DrawCrosshair			= true
SWEP.AccurateCrosshair		= false

SWEP.ShellTime			= .5
SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 39
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Buckshot"

SWEP.Base = "weapon_base"

SWEP.Secondary.Ammo			= "none"
SWEP.DrawAmmo = true
SWEP.HoldType = "pistol"
SWEP.ViewModel = "models/weapons/v_shotgun1.mdl" 
SWEP.WorldModel = "models/weapons/w_shotgun1.mdl"

if(CLIENT)then
	SWEP.BounceWeaponIcon = false
end

function SWEP:Initialize()
	self:SetWeaponHoldType("shotgun")
end

function SWEP:NHShgShoot( num, spread, recoil )
	local vm = self.Owner:GetViewModel()
	if not (self:CanPrimaryAttack()) then return self:Reload() end

	self:SendWeaponAnim(181)
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "shoot" ) )

	if ( self.Owner:IsPlayer() ) then
		self.Owner:ViewPunch( Angle( (recoil * -0.35) ,0 ,(recoil * -0.35) ) ) 
	end

	local bullet = {} 
	bullet.Num = num
	bullet.Src = self.Owner:GetShootPos() 
	bullet.Dir = self.Owner:GetAimVector() 
	bullet.Spread = Vector( spread * 0.1 , spread * 0.1, 0)
	bullet.Tracer = 1
	bullet.TracerName = "Tracer" 
	bullet.Force = 0.5
	bullet.Damage = 12
	bullet.AmmoType = "none" 
 
	self:TakePrimaryAmmo(1)
	self:ShootEffects()
	self.Owner:FireBullets( bullet ) 
end

function SWEP:PrimaryAttack()
	local vm = self.Owner:GetViewModel()
	if not (self:CanPrimaryAttack()) then return end

	if (self.Owner:IsPlayer()) then
		self:EmitSound(Sound("weapons_nh/shotgun/shoot"..math.random(1,3)..".wav") )
	else
		self:EmitSound(Sound("weapons_nh/shotgun/shoot"..math.random(1,3).."_npc.wav") )
	end
	self:NHShgShoot( 8, 0.5, 1 )
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "shoot" ) )
 
	self:SetNextPrimaryFire( CurTime() + 1.25 )
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()

	if not IsValid(self) then return end
	if not IsValid(self.Owner) then return end
	if not self.Owner:IsPlayer() then return end

	local maxcap = self.Primary.ClipSize
	local spaceavail = self.Weapon:Clip1()
	local shellz = (maxcap) - (spaceavail) + 1

	if (timer.Exists("ShotgunReload_" ..  self.Owner:UniqueID())) or (self.Owner.NextReload and self.Owner.NextReload > CurTime()) or maxcap == spaceavail then return end
	
	if self.Owner:IsPlayer() then 

		if self.Weapon:GetNextPrimaryFire() <= (CurTime()+2) then
			self.Weapon:SetNextPrimaryFire(CurTime() + 2)
		end
		
		self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
		self.Owner:SetAnimation( PLAYER_RELOAD )
		
		self.Owner.NextReload = CurTime() + 1
	
		if (SERVER) then
			self.Owner:SetFOV( 0, 0.15 )
		end
	
		if SERVER and self.Owner:Alive() then
			local timerName = "ShotgunReload_" ..  self.Owner:UniqueID()
			timer.Create(timerName, (self.ShellTime + .05), shellz, function() 
				if not IsValid(self) then return end 
				
				if IsValid(self.Owner) and IsValid(self.Weapon) then 
					if self.Owner:Alive() then 
						self:InsertShell()
					end 
				end 
			end)
		end
	
	elseif self.Owner:IsNPC() then
		self.Weapon:DefaultReload(ACT_VM_RELOAD) 
	end
	
end

function SWEP:FireAnimationEvent( pos, ang, event, options )

	-- Disables animation based muzzle event
	if ( event == 21 ) then return true end

	-- Disable thirdperson muzzle flash
	if ( event == 6001 ) then return true end

end

function SWEP:InsertShell()
	local vm = self.Owner:GetViewModel()
	if not IsValid(self) then return end
	if not IsValid(self.Owner) then return end
	if not self.Owner:IsPlayer() then return end
	
	local timerName = "ShotgunReload_" ..  self.Owner:UniqueID()
	if self.Owner:Alive() then
		local curwep = self.Owner:GetActiveWeapon()
		
		
		if (self.Weapon:Clip1() >= self.Primary.ClipSize or self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0) then
		self.Owner:EmitSound("weapons_nh/shotgun/reload_end.wav")
		vm:SendViewModelMatchingSequence( vm:LookupSequence( "reload_end" ) )
			timer.Destroy(timerName)
		elseif (self.Weapon:Clip1() <= self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) >= 0) then
			self.InsertingShell = true
			timer.Simple( .05, function() self:ShellAnimCaller() end)
	
			self.Weapon:SetClip1(self.Weapon:Clip1() + 1)
			self.Owner:RemoveAmmo( 1, self.Weapon:GetPrimaryAmmoType() )
		end
	else
		timer.Destroy(timerName)
	end
	
end

function SWEP:ShellAnimCaller()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "reload_insert" ) )
	self.Owner:EmitSound("weapons/shotgun/shotgun_reload" .. math.random(1, 3) .. ".wav")
end


function SWEP:Equip()
	if (self.Owner:IsNPC()) then
		self:EmitSound("weapons_nh/shotgun/draw.wav")
	end
end

function SWEP:Deploy()
	local vm = self.Owner:GetViewModel()
	if (self.Owner:IsPlayer()) then
		self:EmitSound("weapons_nh/shotgun/draw.wav")
	end
	self:SetDeploySpeed( self.Weapon:SequenceDuration() )
    vm:SendViewModelMatchingSequence( vm:LookupSequence( "draw" ) )
    return true
end


function SWEP:CanBePickedUpByNPCs()
	return false
end