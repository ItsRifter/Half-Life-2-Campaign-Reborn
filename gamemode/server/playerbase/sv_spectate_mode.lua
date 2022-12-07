--hl2cr_player = hl2cr_player or FindMetaTable( "Player" )

local alivePlayers = team.GetPlayers(TEAM_ALIVE)
local specEnt = 1
local specMode = 4
local backupEnt = {}
local playerName = "NIL"

hook.Add("Tick", "AliveTick", function()
	alivePlayers = team.GetPlayers(TEAM_ALIVE)
end)

function hl2cr_player:SpectateFriendlyNPC()
	
    if table.IsEmpty(backupEnt) then
        for _, npc in ipairs(ents.GetAll()) do
            if npc:IsNPC() and npc:IsFriendly() then
                table.insert(backupEnt, npc)
            end
        end
	end

	self:SpectateEntity(backupEnt[math.random(#backupEnt)])
end

function hl2cr_player:ToggleSpectator(shouldEnable)
    if shouldEnable then
        if self:IsValid() then
            self:SetNoTarget(true)
            self:Flashlight(false)
            self:AllowFlashlight(false)
            self:StripWeapons()
            self:Spectate(5)
            if #alivePlayers <= 0 then
                self:SpectateRandomNPC()
            else
                playerName = alivePlayers[1]:Nick() or ""
            end
        end
    elseif not shouldEnable then
        self:SetNoTarget(false)
        self:UnSpectate()
        self.IsSpectating = false
        self.afk = false
        
        self:UnLock()
    end
end

hook.Add("KeyPress", "SpecKey", function(ply, key)
	
    if ply.afk then return end

	if ply:Team() == TEAM_ALIVE then return end

	if #alivePlayers <= 0 then ply:SpectateFriendlyNPC() return end
	
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
end)