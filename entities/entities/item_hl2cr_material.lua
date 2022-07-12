AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Type = "anim"

ENT.TimeBeforePublicUse = 0
ENT.Obtainer = nil

function ENT:Initialize()
    if SERVER then
        self:SetModel("models/items/item_item_crate.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

        local phys = self:GetPhysicsObject()

        if phys:IsValid() then
            phys:Wake()
        end
    end
end

function ENT:Use(ACTIVATOR)
    if CLIENT then return end
    if self.Obtainer then
        if ACTIVATOR:IsPlayer() and ACTIVATOR == self.Obtainer then
            self:Remove()
        end
    else
        self:Remove()
    end
end


function ENT:Draw()
    if not CLIENT then return end

    self:DrawModel()
end