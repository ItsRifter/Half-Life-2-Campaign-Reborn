

local function SetUpCoop()
    if game.GetMap() == "syn_trials4" then
        ents.FindByName("intro_waiter")[1]:Remove()
        ents.FindByName("intro_stopwaiting")[1]:Fire("trigger")
        ents.FindByName("game_start")[1]:Fire("trigger")

        for _, s in ipairs(ents.FindByClass("info_player_coop")) do
            s:Remove()
        end
    end
end

function StartCoop()
    table.insert(SPAWNING_WEAPONS, "weapon_crowbar")
    table.insert(SPAWNING_WEAPONS, "weapon_physcannon")

    SetUpCoop()
end