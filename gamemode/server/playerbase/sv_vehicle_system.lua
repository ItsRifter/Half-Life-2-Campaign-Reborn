Jeep = {
	Name = "Jeep",
	Class = "prop_vehicle_jeep_old",
	Model = "models/buggy.mdl",
	KeyValues = {
		vehiclescript = "scripts/vehicles/jeep_test.txt",
		EnableGun = 1
	}
}
list.Set( "Vehicles", "Jeep", jeep )

Airboat = {
	Name = "Airboat",
	Class = "prop_vehicle_airboat",
	Category = Category,
	Model = "models/airboat.mdl",
	KeyValues = {
		vehiclescript = "scripts/vehicles/airboat.txt",
		EnableGun = 0
	}
}

list.Set( "Vehicles", "Airboat", airboat )

AirboatGun = {
	Name = "AirboatGun",
	Class = "prop_vehicle_airboat",
	Category = Category,
	Model = "models/airboat.mdl",
	KeyValues = {
		vehiclescript = "scripts/vehicles/airboat.txt",
		EnableGun = 1
	}
}

list.Set( "Vehicles", "AirboatGun", airboatGun )

Jalopy = {
	Name = "Jalopy",
	Class = "prop_vehicle_jeep_old",
	Category = Category,
	Model = "models/vehicle.mdl",
	KeyValues = {
		vehiclescript = "scripts/vehicles/jalopy.txt",
	}
}

list.Set( "Vehicles", "Jalopy", jalopy )

--hl2cr_player = hl2cr_player or FindMetaTable( "Player" )

function hl2cr_player:SpawnAirboat()
    local boat = ents.Create(Airboat.Class)
    boat:SetModel(Airboat.Model)
    boat:SetPos(self:GetPos() + Vector(0, 0, 25) )
    
    for i, key in pairs(Airboat.KeyValues) do
        boat:SetKeyValue(i, key)
    end

    boat:Activate()
    boat:Fire( "addoutput", "targetname airboat" );
    boat:Spawn()
            
    boat:SetAngles(self:EyeAngles() - Angle(0, 90, 0))
	
    boat:SetCustomCollisionCheck( true )
    
    self.vehicle = boat
end

function hl2cr_player:SpawnAirboatWithGun()
    local gunboat = ents.Create(AirboatGun.Class)
    gunboat:SetModel(Airboat.Model)
    gunboat:SetPos(self:GetPos() + Vector(0, 0, 25) )
    
    for i, key in pairs(AirboatGun.KeyValues) do
        gunboat:SetKeyValue(i, key)
    end
    gunboat:Activate()
    gunboat:Fire( "addoutput", "targetname airboat" );
    gunboat:Spawn()
            
    gunboat:SetAngles(self:EyeAngles() - Angle(0, 90, 0))
    gunboat:SetCustomCollisionCheck( true )

    self.vehicle = gunboat
end

function hl2cr_player:SpawnJalopy()
    local jalopy = ents.Create(Jalopy.Class)
    jalopy:SetModel(Jalopy.Model)
    jalopy:SetPos(self:GetPos() + Vector(0, 0, 55) )
    
    for i, key in pairs(Jalopy.KeyValues) do
        jalopy:SetKeyValue(i, key)
    end
    jalopy:Activate()
    jalopy:Fire( "addoutput", "targetname jalopy" );
    jalopy:Spawn()
            
    jalopy:SetAngles(self:EyeAngles() - Angle(0, 90, 0))
    jalopy:SetCustomCollisionCheck( true )
    
    self.vehicle = jalopy
end

function hl2cr_player:SpawnJeep()
    local jeep = ents.Create(Jeep.Class)
    jeep:SetModel(Jeep.Model)
    jeep:SetPos(self:GetPos() + Vector(0, 0, 50)	 )
    jeep:SetAngles(self:EyeAngles() - Angle(0, 90, 0))
    
    for i, key in pairs(Jeep.KeyValues) do
        jeep:SetKeyValue(i, key)
    end
    
    jeep:Activate()
    jeep:Fire( "addoutput", "targetname jeep" );
    jeep:Spawn()
            
    jeep:SetCustomCollisionCheck( true )
    
	jeep.light = ents.Create( "env_projectedtexture" )
	
	jeep.light:SetParent( jeep )
		
	-- The local positions are the offsets from parent..
	jeep.light:SetLocalPos( Vector( 0, 20, 40 ) )
	
		
	-- Looks like only one flashlight can have shadows enabled!
	jeep.light:SetKeyValue( "enableshadows", 0 )
	jeep.light:SetKeyValue( "farz", 1800 )
	jeep.light:SetKeyValue( "nearz", 12 )
	jeep.light:SetKeyValue( "lightfov", 105 )
		
	local c = Color(255,255,255,255)
	local b = 2
	jeep.light:SetKeyValue( "lightcolor", Format( "%i %i %i 255", c.r * b, c.g * b, c.b * b ) )
		
	jeep.light:Spawn() 
	jeep.light:SetLocalAngles( Angle(10,90,0))
	jeep.light:Input( "SpotlightTexture", NULL, NULL, "effects/flashlight001" )

	jeep.light:Input( "TurnOff", NULL, NULL, "" )
	self.jeeplights = false
	
    self.vehicle = jeep
end

function GM:ShowSpare1(ply)
	if ply:Team() == TEAM_DEAD or ply:Team() == TEAM_COMPLETED_MAP then return end

	if disableVehiclesGlobal then
		ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_Player_Vehicle_Disabled"))
		return
	end

	if ply.nextSpawn and ply.nextSpawn > CurTime() then 
		ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_Player_Vehicle_TooFast"), tostring(math.Round(ply.nextSpawn - CurTime())))
		return 
	end
	
	if ply:InVehicle() or not ply:Alive() then return end
	
	if ply.vehicle then
		ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_Player_Vehicle_Exists"))
		return
	end
	
	ply.antiExploit = CurTime() + 3
	
	if AIRBOAT_GUN_MAPS[game.GetMap()] or canSpawnGlobalGun then
		ply:SpawnAirboatWithGun()
	--if (AIRBOAT_MAPS[game.GetMap()] or canSpawnAirboatGlobal) or (game.GetMap() == "d1_canals_11" and not disableAirboatGlobal) then
	elseif AIRBOAT_MAPS[game.GetMap()] or canSpawnAirboatGlobal or game.GetMap() == "d1_canals_11"  then
		ply:SpawnAirboat()
	elseif AIRBOAT_GUN_MAPS[game.GetMap()] or canSpawnGlobalGun then
		ply:SpawnAirboatWithGun()
	--elseif (JALOPY_MAPS[game.GetMap()] or canSpawnJalopyGlobal or game.GetMap() == "mimp1") and not disableJalopyGlobal then
	elseif JALOPY_MAPS[game.GetMap()] or canSpawnJalopyGlobal or game.GetMap() == "mimp1" then
		ply:SpawnJalopy()
	--elseif (JEEP_MAPS[game.GetMap()] or canSpawnJeepGlobal) and not disableJeepGlobal then
	elseif (JEEP_MAPS[game.GetMap()] or canSpawnJeepGlobal) then
		ply:SpawnJeep()
	else
		ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_Player_Vehicle_Disabled"))
		return
	end
	
	ply.nextSpawn = CurTime() + 10
	
	ply.vehicle:SetOwner(ply)
	ply:EnterVehicle(ply.vehicle)
	ply:SetEyeAngles(Angle(0,90,0) )	--Sets players eyes to front of vehicle
end

disableVehiclesGlobal = disableVehiclesGlobal or false
function GM:DisableVehicles(disable)
	if disable then
		for _, v in ipairs(player.GetAll()) do
			GAMEMODE:RemoveVehicle(v)
		end
		BroadcastMessageToAll(HL2CR_WarningColour, translate.Get("Announce_Vehicle_Disabled"))
		disableVehiclesGlobal = true
	else
		BroadcastMessageToAll(HL2CR_WarningColour, translate.Get("Announce_Vehicle_Enabled"))
		disableVehiclesGlobal = false
	end
end

function GM:ShowSpare2(ply)
	if ply.antiExploit and ply.antiExploit > CurTime() then return end
	
	if not ply.nextSpawn then return end

	--if ply.nextSpawn > CurTime() then
	--	ply:BroadcastMessage(HL2CR_RedColour, translate.Get("Error_Player_Vehicle_TooFast"), tostring(math.Round(ply.nextSpawn - CurTime())))
	--	return
	--end
	GAMEMODE:RemoveVehicle(ply)
	--ply.HasSeat = false

	--if ply.vehicle and ply.vehicle:IsValid() then
	--	ply.vehicle:Remove()
	--end

	--ply.vehicle = nil

end

function GM:RemoveVehicle(ply)
	ply.HasSeat = false

	if ply:InVehicle() then ply:ExitVehicle() end

	if ply.vehicle and ply.vehicle:IsValid() then
		ply.vehicle.owner = nil
		ply.vehicle:Remove()
	end

	ply.vehicle = nil
end

function GM:PlayerLeaveVehicle( ply, veh )
	if ply:GetAllowWeaponsInVehicle() then
		ply:SetAllowWeaponsInVehicle(false)
	end
end

function GM:CanExitVehicle(veh, ply)
	if ply.antiExploit and ply.antiExploit > CurTime() then return false end

	if veh.IsPassenger then return true end		--Better fix for allowed player out of !seat
	--if veh:GetParent() then return true end

	--if veh:GetClass() == "prop_vehicle_prisoner_pod" and not veh:GetOwner() then return false end
	if veh:GetClass() == "prop_vehicle_prisoner_pod" then return false end	--Is owner even relevant/needed?
	
	return true
end

hook.Add("PlayerEnteredVehicle", "HL2CR_ToggleVehicleSpawning", function(ply, veh, role)
	if game.GetMap() == "d1_canals_05" and not canSpawnAirboatGlobal then
		canSpawnAirboatGlobal = true	
		
		BroadcastMessageToAll(HL2CR_GreenColour, translate.Get("Map_Enabled_Vehicles_Airboat"))
		BroadcastMessageToAll(HL2CR_StandardColour, translate.Get("Map_Enabled_Vehicles_Tip"))
	end
	
	if game.GetMap() == "d2_coast_01" and not canSpawnJeepGlobal then
		canSpawnJeepGlobal = true
		
		BroadcastMessageToAll(HL2CR_GreenColour, translate.Get("Map_Enabled_Vehicles_Jeep"))
		BroadcastMessageToAll(HL2CR_StandardColour, translate.Get("Map_Enabled_Vehicles_Tip"))
	end
	
	if (game.GetMap() == "ep2_outland_06" or game.GetMap() == "ep2_outland_09" or game.GetMap() == "ep2_outland_12") and not canSpawnJalopyGlobal then
		canSpawnJalopyGlobal = true
		
		BroadcastMessageToAll(HL2CR_GreenColour, translate.Get("Map_Enabled_Vehicles_Jalopy"))
		BroadcastMessageToAll(HL2CR_StandardColour, translate.Get("Map_Enabled_Vehicles_Tip"))
	end
end)