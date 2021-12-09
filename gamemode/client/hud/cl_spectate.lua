local specUsername = nil
local isSpectating = false
local wasKilled = false
local timeForRespawn = 0

function StartClientSpectate(shouldSpectate, isSurvivalOn)
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
		

		specPanel:MoveTo(0, ScrH() / 1.125, 2, 0, -1, nil )
		specUser = vgui.Create("DLabel", specPanel)
		specUser:SetText(translate.Get("Spectate"))
		specUser:SetFont("HL2CR_SpectatePlayer")
		specUser:SizeToContents()
		specUser:SetPos(10, 12.5)
		
		specTime = vgui.Create("DLabel", specPanel)
		specTime:SetText("")
		specTime.Survival = isSurvivalOn
		
		if wasKilled and not isSurvivalOn then
			specTime:SetText(translate.Get("Respawn") .. math.Round(timeForRespawn - CurTime()))
			specTime:SetFont("HL2CR_SpectatePlayer")
			specTime:SizeToContents()
<<<<<<< Updated upstream
			specTime:SetPos(specPanel:GetWide() - 400, 12.5)			
=======
			specTime:SetPos(specPanel:GetWide() - 400, 12.5)
		else
			specTime:SetText("???")
>>>>>>> Stashed changes
		end
	else
		if specFrame and specFrame:IsValid() then
			specFrame:Close()
		end
	end
end

hook.Add("Think", "HL2CR_SpectateThink", function()
	if not isSpectating or not specFrame then return end

	if specUsername == nil then
		specUser:SetText(translate.Get("SpecNobody"))
	else 
		specUser:SetText(translate.Get("Spectate") .. specUsername)
	end
	specUser:SizeToContents()
<<<<<<< Updated upstream
	
	if specTime.Survival == true then return end
	
=======

>>>>>>> Stashed changes
	specTime:SetText(translate.Get("Respawn") .. math.Round(timeForRespawn - CurTime()))
	specTime:SizeToContents()
	
	if (timeForRespawn - 0.5) < CurTime() then
		specFrame:Close()
		isSpectating = false
		specUsername = nil
		if qMenuTabs and !specFrame:IsValid() then
			qMenuTabs:Remove() 
		end 
	end
end)

net.Receive("HL2CR_UpdatePlayerName", function()
	specUsername = net.ReadString()
end)

net.Receive("HL2CR_ShouldClientSpectate", function()
	isSpectating = net.ReadBool()
	wasKilled = net.ReadBool()
	local difficulty = net.ReadInt(8)
	local isSurvival = net.ReadBool()
	
	if wasKilled and not isSurvival then
		timeForRespawn = CurTime() + 10 * difficulty
	end
	
	StartClientSpectate(isSpectating, isSurvival)
	
end)