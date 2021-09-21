local alivePlayers = team.GetPlayers(TEAM_ALIVE)
local specEnt = 1
local specMode = 4
local backupEnt = ents.GetAll()
local playerName = "NIL"


hook.Add("Tick", "AliveTick", function()
	alivePlayers = team.GetPlayers(TEAM_ALIVE)
end)

function EnableSpectate(ply)
	if ply:IsValid() then
		ply:SetNoTarget(true)
		ply:Flashlight(false)
		ply:AllowFlashlight(false)
		ply:StripWeapons()
		ply:Spectate(5)
		if #alivePlayers <= 0 then
			if backupEnt:IsNPC() then
				ply:SpectateEntity(backupEnt)
			end
		end	
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
		net.Send(ply)
		
	end
end

function DisableSpectate(ply)
	ply:SetNoTarget(false)
	ply:UnSpectate()
	ply.afk = false
	
	net.Start("HL2CR_ShouldClientSpectate")
	net.WriteBool(false)
	net.Send(ply)
end

hook.Add("KeyPress", "SpecKey", function(ply, key)
	if ply.afk == true then return end
	if ply:Team() == TEAM_ALIVE then return end
	if #alivePlayers <= 0 then return end
	
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
	
	playerName = alivePlayers[specEnt]:Nick()
	
end)