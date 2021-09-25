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

canSpawnAirboatGlobal = false
canSpawnGlobalGun = false
canSpawnJeepGlobal = false
disableAirboatGlobal = false

local nextSpawn = 0
local antiExploit = 0

function GM:ShowSpare1(ply)
	if ply:Team() == TEAM_DEAD or ply:Team() == TEAM_COMPLETED_MAP then return end

	if ply.nextSpawn and ply.nextSpawn > CurTime() then return end
	
	if ply:InVehicle() or not ply:Alive() then return end
	
	if ply.vehicle then
		BroadcastMessage(ERROR_VEHICLE_EXISTS, ply)
		return
	end
	
	ply.nextSpawn = CurTime() + 5
	ply.antiExploit = CurTime() + 3
	
	if (AIRBOAT_MAPS[game.GetMap()] or canSpawnAirboatGlobal) or (game.GetMap() == "d1_canals_11" and not disableAirboatGlobal) then
		local boat = ents.Create(Airboat.Class)
		boat:SetModel(Airboat.Model)
		boat:SetPos(ply:GetPos() + Vector(0, 0, 25) )
		
		for i, key in pairs(Airboat.KeyValues) do
			boat:SetKeyValue(i, key)
		end
		boat:Activate()
		boat:Fire( "addoutput", "targetname airboat" );
		boat:Spawn()
				
		boat:SetAngles(ply:EyeAngles() - Angle(0, 90, 0))
		boat:SetCustomCollisionCheck( true )
		
		boat:SetOwner(ply)
		
		ply.vehicle = boat
		
	elseif AIRBOAT_GUN_MAPS[game.GetMap()] or canSpawnGlobalGun then
		local gunboat = ents.Create(AirboatGun.Class)
		gunboat:SetModel(Airboat.Model)
		gunboat:SetPos(ply:GetPos() + Vector(0, 0, 25) )
		
		for i, key in pairs(AirboatGun.KeyValues) do
			gunboat:SetKeyValue(i, key)
		end
		gunboat:Activate()
		gunboat:Fire( "addoutput", "targetname airboat" );
		gunboat:Spawn()
				
		gunboat:SetAngles(ply:EyeAngles() - Angle(0, 90, 0))
		gunboat:SetCustomCollisionCheck( true )
		
		gunboat:SetOwner(ply)
		ply.vehicle = gunboat
		
	elseif JEEP_MAPS[game.GetMap()] or canSpawnJeepGlobal then
		local jeep = ents.Create(Jeep.Class)
		jeep:SetModel(Jeep.Model)
		jeep:SetPos(ply:GetPos() + Vector(0, 0, 65)	 )
		jeep:SetAngles(ply:EyeAngles() - Angle(0, 90, 0))
		
		for i, key in pairs(Jeep.KeyValues) do
			jeep:SetKeyValue(i, key)
		end
		jeep:Activate()
		jeep:Fire( "addoutput", "targetname jeep" );
		jeep:Spawn()
				
		jeep:SetCustomCollisionCheck( true )
		
		jeep:SetOwner(ply)
		
		ply.vehicle = jeep
	else
		BroadcastMessage(ERROR_VEHICLE_MAP, ply)
		return
	end
	
	ply:EnterVehicle(ply.vehicle)
end

function GM:ShowSpare2(ply)
	if ply.antiExploit and ply.antiExploit > CurTime() then return end
	
	if not ply.vehicle then
		BroadcastMessage(ERROR_VEHICLE_INVALID, ply)
		return
	end
	
	ply.HasSeat = false
	if ply.vehicle:IsValid() then
		ply.vehicle:Remove()
	end
	ply.vehicle = nil

end

function GM:CanExitVehicle(veh, ply)
	if ply.antiExploit and ply.antiExploit > CurTime() then return false end
	
	return true
end