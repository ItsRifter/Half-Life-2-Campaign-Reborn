SWEP.Base					= "weapon_base"
SWEP.Category				= "HL2CR"
SWEP.Author					= "" 
SWEP.Contact				= ""
SWEP.Purpose				= "" 
SWEP.Instructions			= ""
SWEP.Spawnable				= true 
SWEP.AdminSpawnable			= true 
SWEP.DrawCrosshair			= false		
SWEP.PrintName				= "Stimshot: Health"
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

SWEP.Primary.Damage = 20

SWEP.Primary.ClipSize				= 1
SWEP.Primary.DefaultClip			= 1	
SWEP.Primary.Ammo					= "hl2cr_medishot_health"					

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
	if timer.Exists("HL2CR_StimHealth_" .. self.Owner:Nick()) then return end
	
	if self:Clip1() <= 0 and self.Owner:HasWeapon(self:GetClass()) then
		self.Owner:StripWeapon(self:GetClass())
	end
end

function SWEP:PrimaryAttack()
	if self:Clip1() > 0 then
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		
		if SERVER then
			if self:GetOwner().hl2cr.CurClass.Name == "Robot" then
				timer.Simple(0.55, function()
					self.Owner:EmitSound("physics/metal/metal_box_impact_bullet" .. math.random(1, 3) .. ".wav")
					self.Owner:StripWeapon(self:GetClass())
					return
				end)
			end
			timer.Simple(0.55, function()
				self.Owner:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random(1, 5) .. ".wav")
				
				self.Owner:EmitSound("items/smallmedkit1.wav")
				self.Owner:SetHealth(math.min(self:GetOwner():GetMaxHealth(), self:GetOwner():Health() + self.Primary.Damage))
				AddStatus(self.Owner, "HealthRegen")
				self:TakePrimaryAmmo(1)
				self.Owner:StripWeapon(self:GetClass())
			end)
		end
		
		self:SetNextPrimaryFire(CurTime() + 4)
	end
end

function SWEP:SecondaryAttack()
end