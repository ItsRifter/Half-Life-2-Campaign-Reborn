function GrantAchievement(ply, baseList, achName)
	if not ply or ply:IsBot() then return end

	--Grab the list from the achievements unless its an invalid list
	local list = GAMEMODE.Achievements[baseList]
	if not list then return print("ERROR: bad list") end
	
	--Grab the achievement from the list unless its an invalid name
	local ach = list[achName]
	if not ach then return print("ERROR: bad achievement name") end
	
	--If player already has the achievement, stop here
	if table.HasValue(ply.hl2cr.Achievements, ach.Name) then return end
	
	--Insert the achievement to the player's data
	table.insert(ply.hl2cr.Achievements, ach.Name)
	
	--Show the popup achievement similar to steam's achievements
	net.Start("HL2CR_AchievementEarned")
		net.WriteString(ach.Name)
		net.WriteString(ach.Desc)
		net.WriteString(ach.Mat)
		net.WriteInt(ach.Rewards.XP, 64)
		net.WriteBool(ach.IsRare)
	net.Send(ply)

	--Notify everyone of the achiever
	net.Start("HL2CR_AchievementNotifyAll")
		net.WriteString(ply:Nick())
		net.WriteString(ach.Name)
		net.WriteBool(ach.IsRare)
	net.Broadcast()

	if ach.Rewards.XP > 0 then
		AddXP(ply, ach.Rewards.XP)
	end
	
	ply:SetNWInt("stat_totalachs", #ply.hl2cr.Achievements)
end

function UpdateAchievement(ply, baseList, achName)
	if not ply then return end

	local list = GAMEMODE.Achievements[baseList]
	if not list then return print("ERROR: bad update list") end
	local ach = list[achName]
	if not ach then return print("ERROR: bad update achievement name") end
	--[[
	if not table.HasValue(ply.hl2cr.ProgressAch, ach) then
		table.insert(ply.hl2cr.ProgressAch, ach)
	end
	
	for k, prog in ipairs(ply.hl2cr.ProgressAch) do

		print(k)
		PrintTable(prog)
		
		if ply.hl2cr.ProgressAch[k].Name == ach.Name then
			ply.hl2cr.ProgressAch[k].Value = ply.hl2cr.ProgressAch[k].Value + 1		
		
			--Not the cleanest way to do the lambda achievement, but it works
			if ach.Name == "Lambda Locator" then
				local lambdaProgress = ""
				local lambdaTrigger1 = ents.FindByClass("trigger_lambda")[1]
				local lambdaTrigger2 = ents.FindByClass("trigger_lambda")[2]
				local lambdaTrigger3 = ents.FindByClass("trigger_lambda")[3]
				local lambdaTrigger4 = ents.FindByClass("trigger_lambda")[4]
				if lambdaTrigger1:IsValid() and lambdaTrigger1:IsTriggered() then
					lambdaProgress = game.GetMap() .. ": 1"
				elseif lambdaTrigger2:IsValid() and lambdaTrigger2:IsTriggered() then
					lambdaProgress = game.GetMap() .. ": 2"
				elseif lambdaTrigger3:IsValid() and lambdaTrigger3:IsTriggered() then
					lambdaProgress = game.GetMap() .. ": 3"
				elseif lambdaTrigger4:IsValid() and lambdaTrigger4:IsTriggered() then
					lambdaProgress = game.GetMap() .. ": 4"
				end
				
				print(lambdaProgress)
				
				if string.find(table.concat(ply.hl2cr.ProgressAch[k].Maps, "\n"), lambdaProgress) then print("ALREADY HAS LAMBDA") return end
				
				table.insert(ply.hl2cr.ProgressAch[k].Maps, lambdaProgress)
			end
			
			print(ply.hl2cr.ProgressAch[k].Value)
			
			if ply.hl2cr.ProgressAch[k].Value >= ply.hl2cr.ProgressAch[k].Update then
				net.Start("HL2CR_AchievementUpdate")
					net.WriteString(ply.hl2cr.ProgressAch[k].Name)
					net.WriteString(ach.Mat)
					net.WriteInt(ply.hl2cr.ProgressAch[k].Value, 16)
					net.WriteInt(ply.hl2cr.ProgressAch[k].Max, 16)
				net.Send(ply)
			end
			
			if ply.hl2cr.ProgressAch[k].Value >= ply.hl2cr.ProgressAch[k].Max then
				GrantAchievement(ply, baseList, achName)
				table.remove(ply.hl2cr.ProgressAch)
			end
		end
		
	end
	--]]
end

hook.Add("ShutDown", "HL2CR_CheckAchStatus", function()
	if savedBaby == false and file.Exists("hl2cr_data/babycheck.txt", "DATA") then
		file.Delete("hl2cr_data/babycheck.txt")
	end
	if savedRoller == false and file.Exists("hl2cr_dawta/ballcheck.txt", "DATA") then
		file.Delete("hl2cr_data/ballcheck.txt")
	end
end)