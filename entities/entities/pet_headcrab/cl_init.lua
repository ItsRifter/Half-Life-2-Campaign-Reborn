include("shared.lua")

function ENT:DrawTransulcent()
	self:Draw()
end

function ENT:Draw()
	self:DrawModel()
end