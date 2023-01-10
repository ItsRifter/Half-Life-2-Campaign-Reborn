AddCSLuaFile()

local hl2cr_pet = FindMetaTable("Entity")

if SERVER then
    
    function hl2cr_pet:DoStatLevelUp()
        if not self:CheckLevel() then
            //Do evolving stuff
            return
        end

        local curStats = self:GetStats()
        local newStats = PET_LEVELS[self:GetClass()][curStats.Level]
        
        curStats.Stats.HP = curStats.Stats.HP + newStats.HP
        curStats.Stats.Damage = curStats.Stats.Damage + newStats.Damage

        self:SetMaxHealth(curStats.Stats.HP)
        self:SetHealth(self:GetMaxHealth())

        return curStats
    end
    
    function hl2cr_pet:GetStats()
        local stats = nil
        for _, p in ipairs(self:GetOwner().hl2cr.Pets) do
            if p.Active then
                stats = p
                break
            end
        end

        return stats
    end

    function hl2cr_pet:UpdateStats(statTbl)
        for _, p in ipairs(self:GetOwner().hl2cr.Pets) do
            if p.Active then
                self:SetMaxHealth(statTbl.Stats.HP)
                self:SetHealth(self:GetMaxHealth())

                table.Merge(p, statTbl)
                break
            end
        end
    end

    function hl2cr_pet:CheckLevel()
        local stats = self:GetStats()
        
        if stats.Level >= stats.LevelCap then
            return false
        end

        return true
    end

    function hl2cr_pet:AddXP(XP)
        
        if not self:CheckLevel() then return end
        local updStats = self:GetStats()

        updStats.XP = updStats.XP + XP

        local notify = false 

        while updStats.XP >= updStats.ReqXP do
            updStats.XP = updStats.XP - updStats.ReqXP
            updStats.Level = updStats.Level + 1
            updStats.ReqXP = updStats.ReqXP + math.Round(4 * math.pow( updStats.Level + 4, 3 ) / 5);

            table.Merge(updStats, self:DoStatLevelUp())

            notify = true
        end

        if notify then
            self:GetOwner():SetNWInt("hl2cr_petstat_level", updStats.Level)
            self:GetOwner():SetNWInt("hl2cr_petstat_reqxp", updStats.ReqXP)
            self:UpdateStats(updStats)
        end

        self:GetOwner():SetNWInt("hl2cr_petstat_xp", updStats.XP)
    end
end