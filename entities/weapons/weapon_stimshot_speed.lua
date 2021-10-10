SWEP.Base					= "weapon_base"
SWEP.Category				= "HL2CR"
SWEP.Author					= "" 
SWEP.Contact				= ""
SWEP.Purpose				= "" 
SWEP.Instructions			= ""
SWEP.Spawnable				= true 
SWEP.AdminSpawnable			= true 
SWEP.DrawCrosshair			= false		
SWEP.PrintName				= "Stimshot: Speed"
SWEP.Slot					= 4	
SWEP.SlotPos				= 73
SWEP.DrawAmmo				= false
SWEP.DrawWeaponInfoBox		= false
SWEP.BounceWeaponIcon   	= false
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Weight					= 30

SWEP.AllowSprintAttack = true

SWEP.FiresUnderwater = true

SWEP.TimeExpire = 7



SWEP.Primary.ClipSize				= 1
SWEP.Primary.DefaultClip			= 1	
SWEP.Primary.Ammo					= "hl2cr_medishot_speed"					

SWEP.ViewModel			= "models/weapons/c_healthshot.mdl"
SWEP.ViewModelFOV		= 56
SWEP.ViewModelFlip		= false
SWEP.UseHands = false

SWEP.WorldModel			= "models/weapons/w_healthshot.mdl"

SWEP.HoldType 			= "slam"

DEFINE_BASECLASS(SWEP.Base)

function SWEP:Deploy( ... )
	if self:Clip1() <= 0 then
		if self:Clip1() <= 0 then
			timer.Simple(0, function()
				if CLIENT or not IsValid(self) or not self.Owner:IsValid() then return end
				self.Owner:StripWeapon(self:GetClass())
			end)
		else
			self:TakePrimaryAmmo(1, true)
			self:SetClip1(1)
		end
	end
end

function SWEP:Think()
	if CLIENT then return end
	if self:Clip1() > 0 then return end
	if timer.Exists("HL2CR_StimSpeed_" .. self.Owner:Nick()) then return end
	
	if self:Clip1() <= 0 and self.Owner:HasWeapon(self:GetClass()) then
		self.Owner:StripWeapon(self:GetClass())
	end
end

function SWEP:PrimaryAttack()
	if self:Clip1() > 0 then
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		if SERVER then
			timer.Simple(0.55, function()
				self.Owner:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random(1, 5) .. ".wav")
				self.Owner:EmitSound("player/suit_sprint.wav")
				
				self:TakePrimaryAmmo(1)
				self.Owner:SetWalkSpeed(320)
				self.Owner:SetRunSpeed(450)
				timer.Create("HL2CR_StimSpeed_" .. self.Owner:Nick(), self.TimeExpire, 1, function()
					self.Owner:SetWalkSpeed(200)
					self.Owner:SetRunSpeed(320)
				end)
			end)
		end
		
		self:SetNextPrimaryFire(CurTime() + 4)
	end
end

function SWEP:SecondaryAttack()
end