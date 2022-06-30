
local hl2cr_player = FindMetaTable( "Player" )

function hl2cr_player:rantAchievement(baseList, achName)
	--Grab the list from the achievements unless its an invalid list
	local list = GAMEMODE.Achievements[baseList]
	if not list then return print("ERROR: bad list") end
	
	--Grab the achievement from the list unless its an invalid name
	local ach = list[achName]
	if not ach then return print("ERROR: bad achievement name") end
	
	--If player already has the achievement, stop here
	if table.HasValue(self.hl2cr.Achievements, ach.Name) then return end
	
	--Insert the achievement to the player's data
	table.insert(self.hl2cr.Achievements, ach.Name)
	
	--Show the popup achievement similar to steam's achievements
	net.Start("HL2CR_AchievementEarned")
		net.WriteTable(ach)
	net.Send(self)

	--Notify everyone of the achiever
	net.Start("HL2CR_AchievementNotifyAll")
		net.WriteString(self:Nick())
		net.WriteString(ach.Name)
		net.WriteBool(ach.IsRare)
	net.Broadcast()

	if ach.Rewards.XP > 0 then
		AddXP(self, ach.Rewards.XP)
	end
end

hook.Add("ShutDown", "HL2CR_CheckAchStatus", function()
	if savedBaby == false and file.Exists("hl2cr_data/babycheck.txt", "DATA") then
		file.Delete("hl2cr_data/babycheck.txt")
	end
	if savedRoller == false and file.Exists("hl2cr_data/ballcheck.txt", "DATA") then
		file.Delete("hl2cr_data/ballcheck.txt")
	end
end)