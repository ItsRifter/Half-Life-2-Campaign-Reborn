local PANEL = {}

AccessorFunc(PANEL, "Padding", "Padding")
AccessorFunc(PANEL, "pnlCanvas", "Canvas")

function PANEL:Init()
	self.pnlCanvas = vgui.Create("Panel", self)
	self.pnlCanvas.OnMousePressed = function(self, code) self:GetParent():OnMousePressed(code) end
	self.pnlCanvas:SetMouseInputEnabled(true)

	self:SetPadding(0)
	self:SetMouseInputEnabled(true)

	-- This turns off the engine drawing
	self:SetPaintBackgroundEnabled(true)
	self:SetPaintBorderEnabled(false)
	self:SetPaintBackground(true)
end

function PANEL:AddItem(pnl)
	pnl:SetParent(self:GetCanvas())
end

function PANEL:OnChildAdded(child)
	self:AddItem(child)
end

function PANEL:SizeToContents()
	self:SetSize(self.pnlCanvas:GetSize())
end

function PANEL:GetCanvas()
	return self.pnlCanvas
end

function PANEL:InnerWidth()
	return self:GetCanvas():GetWide()
end

function PANEL:InnerHeight()
	return self:GetCanvas():GetTall()
end

function PANEL:Rebuild()
	local canvas = self:GetCanvas()

	canvas:SizeToChildren(true, true)

	-- Center vertically if the canvas is smaller than this panel.
	local centerX, centerY = (self:GetWide() - canvas:GetWide()) * 0.5, (self:GetTall() - canvas:GetTall()) * 0.5
	if canvas:GetTall() < self:GetTall() then
		-- Canvas is smaller in this direction, just center it.
		canvas:SetY(centerY)
	elseif canvas:GetY() > 0 then
		-- Canvas is outside of the Y+ boundary, move it back.
		canvas:SetY(0)
	elseif canvas:GetY() < self:GetTall() - canvas:GetTall() then
		-- Canvas is outside of the Y- boundary, move it back.
		canvas:SetY(self:GetTall() - canvas:GetTall())
	end
	if canvas:GetWide() < self:GetWide() then
		-- Canvas is smaller in this direction, just center it.
		canvas:SetX(centerX)
	elseif canvas:GetX() > 0 then
		-- Canvas is outside of the X+ boundary, move it back.
		canvas:SetX(0)
	elseif canvas:GetX() < self:GetWide() - canvas:GetWide() then
		-- Canvas is outside of the X- boundary, move it back.
		canvas:SetX(self:GetWide() - canvas:GetWide())
	end
end

function PANEL:OnMousePressed()
	local x, y = self:CursorPos()

	self:MouseCapture(true)
	self.Dragging = true
	self.OldCursorPos = {x, y}
end

function PANEL:OnMouseReleased()
	self.Dragging = false
	self:MouseCapture(false)
end

function PANEL:OnCursorMoved(x, y)
	if not self.Dragging then return end

	local oldPos = self.OldCursorPos
	self.OldCursorPos = {x, y}

	local deltaX, deltaY = x - oldPos[1], y - oldPos[2]

	self:GetCanvas():SetPos(self:GetCanvas():GetX() + deltaX, self:GetCanvas():GetY() + deltaY)
	self:Rebuild()
end

function PANEL:ScrollToChild(PANEL)
	self:InvalidateLayout(true)

	local x, y = self.pnlCanvas:GetChildPosition(PANEL)
	local w, h = PANEL:GetSize()

	x, y = x + w * 0.5, y + h * 0.5
	x, y = x - self:GetWide() * 0.5, y - self:GetTall() * 0.5

	-- TODO: Animate scroll action
	self:GetCanvas():SetPos(x, y)
end

function PANEL:PerformLayout()
	self:Rebuild()
end

function PANEL:Clear()
	return self.pnlCanvas:Clear()
end

derma.DefineControl("HL2CR_DraggablePanel", "", PANEL, "DPanel")
