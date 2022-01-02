if SERVER then
	AddCSLuaFile("shared.lua")
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("animations.lua")

	include("animations.lua")
end

SWEP.PrintName = "Armorkit"
SWEP.Author = ""
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
	timer.Create(self.TimerName, 20, 0, function()
		if IsValid(wep) then
			if wep:Clip1() < wep.MaxAmmo then
				wep:SetClip1(math.min(wep:Clip1() + 5 + self.Owner:GetNWInt("skill_repairrate"), wep.MaxAmmo))
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

	local tr = self:GetHitTrace()
	local need = (IsValid(tr.Entity) and tr.Entity:IsPlayer()) and math.min(100-tr.Entity:Armor(),self.ArmorAmount) or self.ArmorAmount
	if self:Clip1() >= need and tr.Hit and IsValid(tr.Entity) and tr.Entity:IsPlayer() and tr.Entity:Armor() < 100 then
		self:SetNextFire(CurTime() + 2)
		self.Owner:SetAnimation(PLAYER_ATTACK1) --DoAttackEvent()
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self.IdleAnimation = CurTime() + self:SequenceDuration()

		if SERVER then
			self:TakePrimaryAmmo(need)
			self.Owner:SetAnimation(PLAYER_ATTACK1)
			
			if tr.Entity.hl2cr.CurClass.Name == "Robot" and tr.Entity:Health() < tr.Entity:GetMaxHealth() then
				tr.Entity:SetHealth(math.min(tr.Entity:GetMaxHealth(), tr.Entity:Health() + need + self.Owner:GetNWInt("skill_repairing") + 15) )
				SendNotificaton(self.Owner:Nick() .. translate.Get("Repaired") .. need + self.Owner:GetNWInt("skill_repairing"), Color(45, 255, 0), tr.Entity)
			else
				tr.Entity:SetArmor(math.min(tr.Entity:GetMaxArmor(), tr.Entity:Armor() + need + self.Owner:GetNWInt("skill_repairing")) )
				SendNotificaton(self.Owner:Nick() .. translate.Get("ArmorCharged") .. need + self.Owner:GetNWInt("skill_repairing"), Color(45, 255, 0), tr.Entity)
			end
			
			tr.Entity:EmitSound("items/battery_pickup.wav")
			
			if self.Owner:GetNWInt("skill_grouprepair") > 0 then
				for i, v in ipairs(ents.FindInSphere(tr.Entity:GetPos(), 250) ) do
					if not v:IsPlayer() or v == tr.Entity then continue end
					v:SetArmor(math.min(v:GetMaxArmor(), v:Armor() + self.Owner:GetNWInt("skill_grouprepair") ) )
					AddXP(self.Owner, self.Owner:GetNWInt("skill_grouprepair") * (10 * GetConVar("hl2cr_difficulty"):GetInt()))
					SendNotificaton(self.Owner:Nick() .. translate.Get("ArmorCharged") .. need + self.Owner:GetNWInt("skill_repairing"), Color(45, 255, 0), v)
				end
			end
			
			AddXP(self.Owner, need + self.Owner:GetNWInt("skill_repairing") * (10 * GetConVar("hl2cr_difficulty"):GetInt()))
			
			net.Start("HL2CR_SpawnIndicators")
				net.WriteInt((need + self.Owner:GetNWInt("skill_repairing")) * (10 * GetConVar("hl2cr_difficulty"):GetInt()), 32)
				net.WriteVector(tr.Entity:GetPos())
				net.WriteBool(false)
			net.Send(self.Owner)
			
			self.Owner.rewards.bonus["Teamplayer"] = true
		end
	elseif SERVER then
		self.Owner:EmitSound("items/suitchargeno1.wav")
		self:SetNextFire(CurTime() + 0.5)
	end
end

function SWEP:SecondaryAttack()
	return false
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
