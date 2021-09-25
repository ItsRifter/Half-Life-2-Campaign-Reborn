local specUsername = "NIL"
local isSpectating = false
local wasKilled = false
local timeForRespawn = 0

function StartClientSpectate(shouldSpectate)
	if shouldSpectate then
		specFrame = vgui.Create("DFrame")
		specFrame:SetSize(ScrW(), ScrH())
		specFrame:SetTitle("")
		specFrame:ShowCloseButton(false)
		specFrame.Paint = function(self, w, h) return end
		
		local specPanel = vgui.Create("DPanel", specFrame)
		specPanel:SetSize(ScrW(), 250)
		specPanel:SetPos(0, ScrH() / 2 + 575)
		specPanel.Paint = function(self, w, h)
			surface.SetDrawColor(0, 0, 0, 175)
			surface.DrawRect(0, 0, w, h)
		end
		
		specPanel:MoveTo(0, ScrH() / 2 + 425, 2, 0, -1, nil )
		
		specUser = vgui.Create("DLabel", specPanel)
		specUser:SetText("Spectating: " .. specUsername)
		specUser:SetFont("HL2CR_SpectatePlayer")
		specUser:SizeToContents()
		specUser:SetPos(0, 50)
		
		specTime = vgui.Create("DLabel", specPanel)
		specTime:SetText("")
		
		if wasKilled then
			specTime:SetText("Respawn in: " .. math.Round(timeForRespawn - CurTime()))
			specTime:SetFont("HL2CR_SpectatePlayer")
			specTime:SizeToContents()
			specTime:SetPos(specPanel:GetWide() - 375, 50)
		end
	else
		if specFrame and specFrame:IsValid() then
			specFrame:Close()
		end
	end
end

hook.Add("Think", "HL2CR_SpectateThink", function()
	if not isSpectating or not specFrame then return end
	
	specUser:SetText("Spectating: " .. specUsername)
	specUser:SizeToContents()
	
	specTime:SetText("Respawn in: " .. math.Round(timeForRespawn - CurTime()))
	specTime:SizeToContents()
	
	if (timeForRespawn - 0.5) < CurTime() then
		specFrame:Close()
		isSpectating = false
	end
	
end)

net.Receive("HL2CR_UpdatePlayerName", function()
	specUsername = net.ReadString()
end)

net.Receive("HL2CR_ShouldClientSpectate", function()
	isSpectating = net.ReadBool()
	wasKilled = net.ReadBool()
	local difficulty = net.ReadInt(8)
	
	if wasKilled then
		timeForRespawn = CurTime() + 10 * difficulty
	end
	
	StartClientSpectate(isSpectating)
	
end)