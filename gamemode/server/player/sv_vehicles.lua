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