AddCSLuaFile()

local hl2cr_pet = FindMetaTable("Entity")

if SERVER then
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
                table.Merge(p, statTbl)
                break
            end
        end
    end

    function hl2cr_pet:CheckLevel()
        local stats = self:GetStats()
        
        print(stats.Level)
        print(stats.LevelCap)
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
            updStats.ReqXP = updStats.ReqXP + math.Round(4 * math.pow( updStats.Level + 7, 3 ) / 5);

            notify = true
        end

        if notify then
            self:GetOwner():SetNWInt("hl2cr_petstat_level", updStats.Level)
            self:GetOwner():SetNWInt("hl2cr_petstat_reqxp", updStats.ReqXP)
        end

        self:GetOwner():SetNWInt("hl2cr_petstat_xp", updStats.XP)
        self:UpdateStats(updStats)
    end
end