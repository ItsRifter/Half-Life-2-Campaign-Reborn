if SERVER then
	AddCSLuaFile("shared.lua")
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("animations.lua")

	include("animations.lua")
end

SWEP.PrintName = "Armorkit"
SWEP.Author = "SuperSponer"
SWEP.Purpose = "Repair targets armor"

SWEP.Spawnable = true

SWEP.ViewModel = "models/weapons/c_medkit.mdl"--"models/weapons/c_grenade.mdl"
SWEP.WorldModel = "models/items/battery.mdl" --"models/weapons/w_medkit.mdl"

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 50
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.MaxAmmo = 100
SWEP.ArmorAmount = 10

function SWEP:Initialize()
	self:SetHoldType("slam")

	if CLIENT then
		self:Anim_Initialize()
	end

	if not SERVER then return end

	self.TimerName = "armorkit_ammo" .. self:EntIndex()
	local wep = self
	timer.Create(self.TimerName, 5, 0, function()
		if IsValid(wep) then
			if wep:Clip1() < wep.MaxAmmo then
				wep:SetClip1(math.min(wep:Clip1() + 1, wep.MaxAmmo))
			end
		else
			timer.Remove(wep.TimerName)
		end
	end)
end

function SWEP:Deploy()
	--self:SendWeaponAnim(ACT_VM_DRAW)
	self.IdleAnimation = CurTime() + self:SequenceDuration()
	self:SetHoldType("slam")

	return true
end

function SWEP:Think()
	if self.IdleAnimation and self.IdleAnimation <= CurTime() then
		self.IdleAnimation = nil
		self:SendWeaponAnim(ACT_VM_IDLE)
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
	return false
end

function SWEP:CanAttack()
	if self:Clip1() <= 0 then
		self.Owner:EmitSound("items/suitchargeno1.wav")
		self:SetNextFire(CurTime() + 2)
		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
end

function SWEP:GetHitTrace()
	local shoot = self.Owner:GetShootPos()
	return util.TraceLine({
		start = shoot,
		endpos = shoot + self.Owner:GetAimVector() * 64,
		filter = self.Owner,
	})
end

function SWEP:SetNextFire(time)
	self:SetNextPrimaryFire(time)
	self:SetNextSecondaryFire(time)
end

function SWEP:PrimaryAttack()
	if not self:CanAttack() then return end

	self:SetNextFire(CurTime() + 2)

	local tr = self:GetHitTrace()
	local need = (IsValid(tr.Entity) and tr.Entity:IsPlayer()) and math.min(100-tr.Entity:Armor(),self.ArmorAmount) or self.ArmorAmount
	if self:Clip1() >= need and tr.Hit and IsValid(tr.Entity) and tr.Entity:IsPlayer() and tr.Entity:Armor() < 100 then
		self.Owner:SetAnimation(PLAYER_ATTACK1) --DoAttackEvent()
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self.IdleAnimation = CurTime() + self:SequenceDuration()

		if SERVER then
			self:TakePrimaryAmmo(need)
			self.Owner:SetAnimation(PLAYER_ATTACK1)
			tr.Entity:SetArmor(math.min(100,tr.Entity:Armor()+need))
			tr.Entity:EmitSound("items/battery_pickup.wav")
			
			AddXP(self.Owner, need * 2)
			
			net.Start("HL2CR_SpawnIndicators")
				net.WriteInt(need * 2, 32)
				net.WriteVector(tr.Entity:GetPos())
			net.Send(self.Owner)
			
			self.Owner.rewards.bonus["Teamplayer"] = true
		end
	elseif SERVER then
		self.Owner:EmitSound("items/suitchargeno1.wav")
	end
end

function SWEP:SecondaryAttack()

end

function SWEP:Holster()
	if CLIENT then
		self:Anim_Holster()
	end
	return true
end

function SWEP:OnRemove()
	if not SERVER then return end
	timer.Remove(self.TimerName)
end

function SWEP:CustomAmmoDisplay()
	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true
	self.AmmoDisplay.PrimaryClip = self:Clip1()

	return self.AmmoDisplay
end
