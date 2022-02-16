local alivePlayers = team.GetPlayers(TEAM_ALIVE)
local specEnt = 1
local specMode = 4
local backupEnt = {}
local playerName = "NIL"

hook.Add("Tick", "AliveTick", function()
	alivePlayers = team.GetPlayers(TEAM_ALIVE)
end)

function SpectateRandomNPC(ply)
	for _, npc in ipairs(ents.GetAll()) do
		if npc:IsNPC() then
			table.insert(backupEnt, npc)
		end
	end
	
	ply:SpectateEntity(backupEnt[math.random(#backupEnt)])
end

function EnableSpectate(ply)
	if ply:IsValid() then
		ply:SetNoTarget(true)
		ply:Flashlight(false)
		ply:AllowFlashlight(false)
		ply:StripWeapons()
		ply:Spectate(5)
		if #alivePlayers <= 0 then
			SpectateRandomNPC(ply)
		else
			playerName = alivePlayers[1]:Nick() or ""
		end
		
		ply.IsSpectating = true
	end
end
function EnableSpectateAFK(ply)
	if ply:IsValid() then
		ply:Flashlight(false)
		ply:SetNoTarget(true)
		ply:AllowFlashlight(false)
		ply:StripWeapons()
		if #alivePlayers < 0 then
			ply:Lock()
		end
		
		ply:Spectate(5)
		ply.afk = true
		
		net.Start("HL2CR_ShouldClientSpectate")
			net.WriteBool(true)
			net.WriteBool(false)
			net.WriteInt(0, 8)
			net.WriteBool(false)
		net.Send(ply)
		ply.IsSpectating = true
	end
end

function DisableSpectate(ply)
	ply:SetNoTarget(false)
	ply:UnSpectate()
	ply.IsSpectating = false
	ply.afk = false
	
	net.Start("HL2CR_ShouldClientSpectate")
		net.WriteBool(false)
		net.WriteBool(false)
		net.WriteInt(0, 8)
		net.WriteBool(false)
	net.Send(ply)
	
	ply:UnLock()
end

hook.Add("KeyPress", "SpecKey", function(ply, key)
	if ply.afk == true then return end
	if ply:Team() == TEAM_ALIVE then return end
	if #alivePlayers <= 0 then SpectateRandomNPC(ply) return end
	
	if ply:KeyPressed(IN_ATTACK) then
		specEnt = specEnt + 1
		if specEnt > #alivePlayers then
			specEnt = 1
		end
		
		ply:SpectateEntity(alivePlayers[specEnt])
	elseif ply:KeyPressed(IN_ATTACK2) then
		specEnt = specEnt - 1
		if specEnt < 1 then
			specEnt = #team.GetPlayers(TEAM_ALIVE) 
		end
		
		ply:SpectateEntity(alivePlayers[specEnt])
	
	elseif ply:KeyPressed(IN_JUMP) then
		specMode = specMode + 1
		if specMode > 5 then
			specMode = 4
		end
		ply:Spectate(specMode)
	end
		
	net.Start("HL2CR_UpdatePlayerName")
		net.WriteString(alivePlayers[specEnt]:Nick())
	net.Send(ply)

end)