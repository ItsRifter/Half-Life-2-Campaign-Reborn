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

local nextSpawn = 0

function GM:ShowSpare1(ply)
	if nextSpawn > CurTime() then return end
	
	if ply.vehicle then
		ply:ChatPrint("Your vehicle already exists")
		return
	end
	
	nextSpawn = CurTime() + 5
	
	if AIRBOAT_MAPS[game.GetMap()] then

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
		
		ply.vehicle = boat
		
	elseif AIRBOAT_GUN_MAPS[game.GetMap()] then
	
	elseif JEEP_MAPS[game.GetMap()] then
		
	else
		ply:ChatPrint("Vehicles are disabled in this map")
	end
end

function GM:ShowSpare2(ply)
	if not ply.vehicle then
		ply:ChatPrint("Your vehicle doesn't exist")
		return
	end
	
	ply.vehicle:Remove()
	ply.vehicle = nil
end