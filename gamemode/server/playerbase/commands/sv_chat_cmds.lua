local CMD_TimeWaitVote = 45 + CurTime()

local chat_cmds = {
    ["!vrm"] = function(ply, text)
        if not ply:IsValid() then return end

        if MAPS_LOBBY[game.GetMap()] then return end
        
        if CMD_TimeWaitVote > CurTime() then 
            ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_Vote_TooEarly"), tostring(math.Round(CMD_TimeWaitVote - CurTime()) ) )
            return
        end

        HL2CR_Voting:StartVote(ply, "Restart")
        CMD_TimeWaitVote = 210 + CurTime()
    end,

    ["!lobby"] = function(ply, text)
        if not ply:IsValid() then return end

        if MAPS_LOBBY[game.GetMap()] then return end

        if CMD_TimeWaitVote > CurTime() then 
            ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_Vote_TooEarly"), tostring(math.Round(CMD_TimeWaitVote - CurTime()) ) )
            return
        end

        HL2CR_Voting:StartVote(ply, "Lobby")
        CMD_TimeWaitVote = 210 + CurTime()
    end,

    ["!seat"] = function(ply, text)
        if not ply:IsValid() then return end
        
        if not ply:InVehicle() then
            ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_CMD_No_Jeep"))
            return
        elseif ply:GetVehicle():GetOwner() != ply then
            ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_CMD_Invalid_Owner"))
            return
        elseif ply:GetVehicle():GetClass() != "prop_vehicle_jeep" then 
            ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_CMD_Invalid_Vehicle"))
            return
        elseif ply.HasSeat then
            ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_CMD_Seat_Exists"))
            return
        end

        local seat = ents.Create("prop_vehicle_prisoner_pod")
        seat:SetModel("models/nova/jeep_seat.mdl")
        seat:SetPos(ply:GetVehicle():LocalToWorld(Vector(32, -32, 18)))
        seat:SetAngles(ply:GetVehicle():LocalToWorldAngles(Angle(0, 0, 0)))
        seat:Spawn()
        seat:SetMoveType(MOVETYPE_NONE)
        seat:SetParent(ply:GetVehicle(), -1)
        
        seat.IsPassenger = true
        ply.HasSeat = true
    end,

    ["!diff"] = function(ply, text)
        if not ply:IsValid() then return end

        local diff_check = {
            [1] = translate.Get("CMD_Diff_Check_Normal"),
            [2] = translate.Get("CMD_Diff_Check_Hard"),
            [3] = translate.Get("CMD_Diff_Check_VHard"),
            [4] = translate.Get("CMD_Diff_Check_Insane"),
            [5] = translate.Get("CMD_Diff_Check_GF")
        }

        local diff_setter = {
            [1] = "DiffNormal",
            [2] = "DiffHard",
            [3] = "DiffVHard",
            [4] = "DiffInsane",
            [5] = "DiffGF"
        }

        if string.len(text) == 5 then
            ply:BroadcastMessage(HL2CR_GreenColour, translate.Get("CMD_Diff_Check"), HL2CR_StandardColour, diff_check[GetConVar("hl2cr_difficulty"):GetInt()])
        elseif string.len(text) > 5 and string.len(text) <= 7 then
            if CMD_TimeWaitVote > CurTime() then 
                ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_Vote_TooEarly"), tostring(math.Round(CMD_TimeWaitVote - CurTime()) ) )
                return
            end

            local num = string.sub(text, #text)
            num = tonumber(num)

            if num == GetConVar("hl2cr_difficulty"):GetInt() then
                ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_CMD_DiffSetOn"))
                return
            end

            if isnumber(num) then
                HL2CR_Voting:StartVote(ply, diff_setter[tonumber(num)])
                CMD_TimeWaitVote = 210 + CurTime()
            end
        end
    end,

    ["!pet"] = function(ply, text)

    end,

    ["!petspawn"] = function(ply, text)
        CreatePet(ply)
    end,

    ["!petremove"] = function(ply, text)
        if ply.activePet then
            ply.activePet:RemovePet()
        end
    end,

    ["!petbring"] = function(ply, text)
        BringPetToPlayer(ply)
    end,

    ["!petname"] = function(ply, text)
        local newName = string.sub(text, 9)
        
        for _, p in ipairs(ply.hl2cr.Pets) do
            if p.Active then
                p.Name = newName
                break
            end
        end
        
        ply:SetNWString("hl2cr_petstat_name", newName)
    end,

    ["!lambda"] = function(ply, text)	--Command to help players keep track of lambda_locator
        if not ply:IsValid() then return end
		if not ply.loaded then return end
		 
		if !table.HasValue( MAPS_HL2, game.GetMap() ) then 
			ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_CMD_NotOnHL2"))
			return 
		end
		
		if ply:HasAchievement("Lambda Locator") then 
			ply:BroadcastMessage(HL2CR_GreenColour, translate.Get("Error_CMD_AlreadyAchieved"))
			return 
		end

		if ply.hl2cr.AchProgress["lambda_locator"] == nil then 
			ply.hl2cr.AchProgress["lambda_locator"] = {}
		end
		
		local ach = nil 
        for i, v in ipairs(GAMEMODE.Achievements) do
            if v.Name == "Lambda Locator" then
                ach = v
                break
            end
        end
		
		local achcount = table.Count(ply.hl2cr.AchProgress["lambda_locator"])
		ply:BroadcastMessage(HL2CR_YellowColour, translate.Get("Achievement_Progress") .. achcount.. "/" ..ach.Max)
		PrintTable(ply.hl2cr.AchProgress["lambda_locator"])
		print("debugging")
    end,

    ["!eyes"] = function(ply, text)	--returns eye angles for debug
		if ply:Alive() then
			print(ply:EyeAngles())
			print(ply:GetPos())
		end
    end,

    //["!discord"] = function(ply, text)
    //    ply:SendLua([[gui.OpenURL("https://discord.gg/zvvZ2ugHQY")]])
    //end,
}

hook.Add("PlayerSay", "HL2CR_PlayerSayCMDs", function(ply, text)
    //if the first letter is not an !, stop here
    if text[1] ~= "!" then return end

    local cmd = string.lower(text)
    cmd = string.Split(cmd, " ")[1]

    if chat_cmds[cmd] then
        chat_cmds[cmd](ply, text)
    end

    return ""
end)