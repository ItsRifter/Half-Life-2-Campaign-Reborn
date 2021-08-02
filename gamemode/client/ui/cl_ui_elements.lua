HL2CR = {}

HL2CR.Theme = {
	primary = Color(255, 185, 0, 255),
	secondary = Color(255, 205, 70, 255),
	background = Color(255, 220, 125, 150),
	
	btns = Color(0, 0, 0, 255),
	
	text = {
		h1 = Color(60, 60, 40, 255),
		h2 = Color(200, 175, 0, 255)
	}
}

HL2CR.UISizes = {
	header = {height = 48},
	navbar = {height = 56},
}

local PANEL = {}

function PANEL:Init()
	self.header = self:Add("Panel")
	self.header:Dock(TOP)
	
	self.header.paint = function(self, w, h)
		draw.RoundedBoxEx(6, 0, 0, w, h, HL2CR.Theme.primary, true, true, false, false)
	end
	
	self.header:SetMouseInputEnabled(true)
	self.header:MakePopup()
end

function PANEL:PerformLayout(w, h)
	self.header:SetTall(HL2CR.UISizes.header.height)
end

vgui.Register("HL2CR_Frame", PANEL, "EditablePanel")

local NAVBAR = {}

AccessorFunc(NAVBAR, "m_body", "Body")

function NAVBAR:Init()
	self.buttons = {}
	self.panels = {}
	self.waitNextTab = true
end

function NAVBAR:AddTab(name, panel)
	local i = table.Count(self.buttons) + 1
	self.buttons[i] = self:Add("DButton")
	local btn = self.buttons[i]
	
	btn.id = i
	
	btn:Dock(LEFT)
	btn:DockMargin(0, 2, 0, 0)
	btn:SetText(name)
	btn:SetFont("HL2CR_ButtonText")
	btn:SetTextColor(btns)
	
	btn.Paint = function(pnl, w, h)
		if self.active == pnl.id then
			surface.SetDrawColor(HL2CR.Theme.text.h1)
			surface.DrawRect(0, h - 2, w, 2)
		end
	end
	btn:SizeToContentsX(32)
	btn.DoClick = function(pnl)
		if not self.waitNextTab or self.active == pnl.id then return end
		self.waitNextTab = false
		self.panels[self.active]:AlphaTo(0, 0.10, 0, nil)
		
		timer.Simple(0.3, function()
			self.panels[self.active]:AlphaTo(255, 0.30, 0, nil)
			self:SetActive(pnl.id)
			self.waitNextTab = true
		end)

		surface.PlaySound("buttons/combine_button7.wav")
	end
	
	self.panels[i] = self:GetBody():Add(panel or "DPanel")
	panel = self.panels[i]
	panel:Dock(FILL)
	panel:SetVisible(false)
	panel.Paint = nil
end

function NAVBAR:GetActive()
	return self.panels[self.active]
end

function NAVBAR:SetActive(id)
	local btn = self.buttons[id]
	if !IsValid(btn) then return end
	
	local activePnl = self.panels[self.active]
	if IsValid(activePnl) then
		activePnl:SetVisible(false)
	end
	
	local panel = self.panels[id]
	panel:SetVisible(true)
	
	self.active = id
	
end

function NAVBAR:Paint(w, h)
	surface.SetDrawColor(HL2CR.Theme.secondary)
	surface.DrawRect(0, 0, w, h)
end

vgui.Register("HL2CR_Navigation", NAVBAR)

local PANEL = {}

function PANEL:Init()
	self.navbar = self:Add("HL2CR_Navigation")
	self.navbar:Dock(TOP)
	self.navbar:SetBody(self)
end

function PANEL:PerformLayout(w, h)
	self.BaseClass.PerformLayout(self, w, h)
	
	self.navbar:SetTall(HL2CR.UISizes.navbar.height)
end

vgui.Register("HL2CR_Tab", PANEL, "HL2CR_Frame")