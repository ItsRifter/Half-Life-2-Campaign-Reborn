
local resultFrame = nil

function DisplayResults(mapStats)
    if resultFrame then
        resultFrame:Remove()
        resultFrame = nil
    end

    resultFrame = vgui.Create("DFrame")
    resultFrame:ShowCloseButton(false)
    resultFrame:SetDraggable(false)
    resultFrame:SetTitle("")
    resultFrame:SetSize(300, 300)
    --ScrW() * 0.2857, ScrH() * 0.545
    resultFrame:SetPos(-resultFrame:GetWide(), 0)
    resultFrame.Paint = function(self, w, h)
        surface.SetDrawColor(HL2CR.Theme.standard)
        surface.DrawRect(0, 0, w, h)
    end

    local resultFG = vgui.Create("DPanel", resultFrame)
    resultFG:SetSize(resultFrame:GetWide() - 40, resultFrame:GetTall() - 40)
    resultFG:Center()
    resultFG.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, HL2CR.Theme.results)
    end

    local resultTitle = vgui.Create("DLabel", resultFG)
    resultTitle:SetText(translate.Get("MapResults_Title"))
    resultTitle:SetPos(resultFG:GetWide() / 12.5, 25)
    resultTitle:SetFont("hl2cr_endresults_title")
    resultTitle:SetTextColor(Color(255, 255, 255))
    resultTitle:SizeToContents()

    local result_kills = vgui.Create("DLabel", resultFG)
    result_kills:SetText(translate.Get("MapResults_Kills") .. mapStats.Kills)
    result_kills:SetPos(resultFG:GetWide() / 4.5, 75)
    result_kills:SetFont("hl2cr_endresults_result")
    result_kills:SizeToContents()
    result_kills:SetTextColor(Color(255, 255, 255))
    result_kills:SetAlpha(0)

    result_kills:AlphaTo(255, 1.25, 1, nil)

    local result_deaths = vgui.Create("DLabel", resultFG)
    result_deaths:SetText(translate.Get("MapResults_Deaths") .. mapStats.Deaths)
    result_deaths:SetPos(resultFG:GetWide() / 4.5, 100)
    result_deaths:SetFont("hl2cr_endresults_result")
    result_deaths:SizeToContents()
    result_deaths:SetTextColor(Color(255, 255, 255))
    result_deaths:SetAlpha(0)

    result_deaths:AlphaTo(255, 1.25, 2, nil)
    
    local result_exp = vgui.Create("DLabel", resultFG)
    result_exp:SetText(translate.Get("MapResults_EXP") .. mapStats.TotalXP)
    result_exp:SetPos(resultFG:GetWide() / 4.5, 125)
    result_exp:SetFont("hl2cr_endresults_result")
    result_exp:SizeToContents()
    result_exp:SetTextColor(Color(255, 255, 255))
    result_exp:SetAlpha(0)

    result_exp:AlphaTo(255, 1.25, 3, nil)

    resultFrame:MoveTo(resultFrame:GetWide() / 5.5, 0, 1.5, 0, 0.5, function()
        resultFrame:MoveTo(-resultFrame:GetWide(), 0, 1.5, 5, 0.5, function()
            --resultFrame:Remove()
            --resultFrame = nil
        end)
    end)

    local resultBGImg = vgui.Create("DImage", resultFG)
    resultBGImg:SetImage("hl2cr/misc/lambda_logo.png")
    resultBGImg:SetSize(resultFG:GetWide(), resultFG:GetTall())
    resultBGImg:Center()

    resultBGImg:MoveToBack()
end

net.Receive("HL2CR_Endresults", function()
    DisplayResults(net.ReadTable())
end)