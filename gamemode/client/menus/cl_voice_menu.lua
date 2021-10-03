local VOICES = {
	[1] = "Medic",
	[2] = "Armor",
	[3] = "Ammo"
}

local lastVoice = lastVoice or 1

function ShowVoiceCMDMenu(shouldOpen)
	if not LocalPlayer():Alive() then return end
	
	if shouldOpen then
		voiceFrame = vgui.Create("DFrame")
		voiceFrame:SetSize(200, 250)
		voiceFrame:SetPos(0, ScrH() / 2.5)
		voiceFrame:SetTitle("")
		voiceFrame:ShowCloseButton(false)
		
		voiceFrame.Paint = function(pnl, w, h)
			surface.SetDrawColor(0, 0, 0, 185)
			surface.DrawRect(0, 0, w, h)
		end
		
		voiceFrame:SetKeyboardInputEnabled( true )
		
		requestLabel = vgui.Create("DLabel", voiceFrame)
		requestLabel:SetText("Voices")
		requestLabel:SetPos(voiceFrame:GetWide() / 4, 0)
		requestLabel:SetFont("HL2CR_VoicesHelp")
		requestLabel:SizeToContents()	
		
		voiceLabel = vgui.Create("DLabel", voiceFrame)
		voiceLabel:SetText("1 = Medic\n2 = Armor\n3 = Ammo")
		voiceLabel:SetFont("HL2CR_Voices")
		voiceLabel:SetPos(0, voiceFrame:GetTall() / 4)
		voiceLabel:SizeToContents()	
	else
		if voiceFrame:IsValid() then
			voiceFrame:Close()
		end
	end
end


function GM:OnContextMenuOpen()
	if LocalPlayer():Team() == TEAM_ALIVE then return end
	ShowVoiceCMDMenu(true)
end

function GM:OnContextMenuClose()
	if LocalPlayer():Team() == TEAM_ALIVE then return end
	ShowVoiceCMDMenu(false)
end

hook.Add("PlayerButtonDown", "HL2CR_ConfirmVoice", function(ply, btn)
	if voiceFrame and voiceFrame:IsValid() and (btn == KEY_1 or btn == KEY_2 or btn == KEY_3)then
		net.Start("HL2CR_HelpNotify")
			net.WriteString(VOICES[btn - 1])
		net.SendToServer()
		ShowVoiceCMDMenu(false)
	end
end)

