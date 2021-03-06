AddCSLuaFile()

SWEP.Author = "ItsRifter"
SWEP.Base = "weapon_base"
SWEP.PrintName = nil
SWEP.Instructions = nil

SWEP.UseHands = true
SWEP.WorldModel = ""
SWEP.ViewModel = "models/weapons/c_handlooker.mdl"

SWEP.WepSelectIcon = Material("materials/icons/suit.vtf")
SWEP.BounceWeaponIcon = false

SWEP.Slot = -1
SWEP.SlotPos = -1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.ViewModelFOV = 90
SWEP.ViewModelFlip = false
SWEP.Spawnable = false
SWEP.AdminSpawnable = false

SWEP.SetHoldType = "normal"
SWEP.Primary.Damage = -1
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
end

function SWEP:PrimaryAttack()
	return
end

function SWEP:Reload()
	return 
end

function SWEP:SecondaryAttack()
	return
end

function SWEP:Deploy()
	self:SetHoldType("normal")
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "seq_admire" ) )
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	-- Set us up the texture
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( self.WepSelectIcon )
end