--Todo: consider moving client network fuctions to start here
DataLoaded = false	--unused currently but may need it
net.Receive("HL2CR_Loaded", function()
	--print("Server says you loaded now")
	DataLoaded = true
end)