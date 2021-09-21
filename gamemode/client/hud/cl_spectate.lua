local specUsername = ""
local isSpectating = false
net.Receive("HL2CR_UpdatePlayerName", function()
	specUsername = net.ReadString()
end)

net.Receive("HL2CR_ShouldClientSpectate", function()
	isSpectating = net.ReadBool()
end)

function StartClientSpectate(shouldSpectate)
	isSpectating = shouldSpectate
end