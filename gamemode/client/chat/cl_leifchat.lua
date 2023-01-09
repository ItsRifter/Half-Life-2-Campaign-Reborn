--CODE FROM LEIFTIGER'S OLD HL2C SERVER
--WITH IMPROVEMENTS (I hope)
Administrator = Administrator or {}
Administrator.Chat = Administrator.Chat or {}
local tblFonts = {}
local oldMsgs = {}

tblFonts[ "TargetID" ] = {
	font = "Trebuchet MS",
	size = 22,
	weight = 900,
	antialias = true
}

tblFonts[ "TargetIDSmall" ] = {
	font = "Trebuchet MS",
	size = 18,
	weight = 900,
	antialias = true
}

for k, v in SortedPairs( tblFonts ) do
	surface.CreateFont( k, tblFonts[ k ] )
end

--[[
hl2c_chat_blue
hl2c_chat_green 
hl2c_chat_red 
hl2c_chat_save
hl2c_chat_size 
]]
-- {"petsummon","now"},
--[ "!pet" ] = { "!pet", "!petsummon", "!petremove", "!petname", "!petfollow", "!petstopfollow" }
Administrator.ClientCommands = {
	["!help"] = { "Opens Help Menu" },
	["!content"] = { "Opens Steam Workshop" },
	["!lobby"] = { "Vote to return to lobby" },
	["!surv"] = { "Vote to enable/disable survival mode" },
	["!survival"] = { "Vote to enable/disable survival mode" },
	["!vrm"] = { "Vote to restart map" },
	["!vnm"] = { "Vote to next map" },
	["!diff"] = { "See current difficuly or vote to change","1 = Normal", "2 = Hard", "3 = Very Hard", "4 = Insane", "5 = True Freeman" },
	["!pet"] = { "Pet menu" },
	["!petsummon"] = { "Spawn pet" },
	["!petremove"] = { "Remove pet" },
	["!petname"] = { "Name your pet" },
	["!petfollow"] = { "Starts/Stops following you" },
	["!seat"] = { "How to use: get in your Buggy", "", "Adds second seat in Buggy" },
	["!lambda"] = { "Lambda Achievement", "", "Shows progress when playing HL2" },
	["!afk"] = { "Sets you in Spectator mode" },
	["!custom"] = { "Opens custom campaign menu" },
}

-- "!petsummon" = {""},
-- "!petremove" = {""},
-- "!petstat" = {""},
-- "!pet" = {""},
-- "!stat" = {""},
-- "!top5" = {""},
-- "!hl2c" = {"vortex"},
-- "!hl2c" = {"cp1"},
-- "!hl2c" = {"cp2"},
-- "!hl2c" = {"cpget"} 
Administrator.chat_AddText_Old = Administrator.chat_AddText_Old or chat.AddText
chat_AddText_Old = chat_AddText_Old or chat.AddText

-- Administrator.GetTranslation(552)
-- Administrator.GetTranslation(229)
function Administrator.Chat.GetTableOfHints( )
	return Administrator.Chat.CurrentHints or { }
end

function Administrator.Chat.SortHints( t, t2 )
	local t3 = { }

	if t2 then
		t3 = t2
	end

	local bK = 0
	local bM = 1000
	local t4 = { }

	if t then
		t4 = table.Copy( t )
	end

	for k, v in pairs( t4 ) do
		if string.len( v ) < bM then
			bK = k
			bM = string.len( v )
		end
	end

	if bK ~= 0 then
		table.insert( t3, t4[ bK ] )
		table.remove( t4, bK )
		Administrator.Chat.SortHints( t4, t3 )
	else
		Administrator.Chat.CurrentHints = t3
	end
end

function Administrator.Chat.SetUpHints( curT )
	local bestMatch = 0
	local bestMatchK
	local left = 0
	local t = table.Copy( curT )

	if #Administrator.Chat.CurrentArgs == 0 then
		for k, v in pairs( t ) do
			if string.sub( v[ 1 ], 1, string.len( Administrator.Chat.CurrentCommand ) ) == Administrator.Chat.CurrentCommand then
				local m = 0

				for i = 1, string.len( v[ 1 ] ) do
					if string.sub( Administrator.Chat.CurrentCommand, i, i ) == string.sub( v[ 1 ], i, i ) then
						m = m + 1
					end
				end

				if m > bestMatch then
					bestMatchK = k
					bestMatch = m
				end

				if m > 0 then
					left = left + 1
				end
			end
		end
	else
		for k, v in pairs( t ) do
			if v[ 1 ] == Administrator.Chat.CurrentCommand then
				bestMatchK = k
				bestMatch = 1000
			end
		end
	end

	if bestMatch ~= 0 then
		table.insert( Administrator.Chat.CurrentHints, t[ bestMatchK ][ 1 ] )
		table.remove( t, bestMatchK )
	end

	if left > 0 then
		Administrator.Chat.SetUpHints( t )
	else
		Administrator.Chat.SortHints( Administrator.Chat.CurrentHints )
	end
end

Administrator.ChatCommandPrefix = "!"

function Administrator.Chat.GetCommandArgs( text )
	for k, v in pairs( Administrator.ClientCommands ) do
		local strCmd = k:sub( string.len( Administrator.ChatCommandPrefix ) + 1 )

		if ( strCmd == text ) then
			local tNewArgs = { }

			for k2, v2 in ipairs( v ) do
				table.insert( tNewArgs, v2 )
			end

			return #tNewArgs, tNewArgs, true
		end
	end

	return 0, { }, false
end

function Administrator.Chat.DrawCommandHint( )
	local t = Administrator.Chat.GetTableOfHints( ) -- returns table that matches the string of commands
	local a, aT = Administrator.Chat.GetCommandArgs( v ) -- Number of arguments, arguments table (for specific types)
end

function Administrator.Chat.WrapText( tab )
	local xPos, chatWidth, t = ScrW( ) * 0.05, ScrW( ) * 0.4, { }
	local curX, curK, limit = xPos + 2, 1, xPos + chatWidth
	t[ curK ] = { }
	surface.SetFont( Administrator.Chat.Chat.Font )

	for k, v in pairs( tab ) do
		if type( v ) == "string" then
			local w = surface.GetTextSize( v )

			if curX + w > limit then
				curX = xPos + 2
				curK = curK + 1
			else
				curX = curX + w
			end

			if not t[ curK ] then
				t[ curK ] = { }
			end

			table.insert( t[ curK ], v )
		else
			table.insert( t[ curK ], v )
		end
	end

	return t
end

function Administrator.Chat.ChatTextChanged( text )
	if not Administrator.Chat.CurrentColor then
		Administrator.Chat.CurrentColor = Color( 255, 0, 0, 255 )
	end

	-- if string.sub(text, 1, 1) != Administrator.CommandPublic && string.sub(text, 1, 1) != Administrator.CommandSilent then
	if ( false ) then
		Administrator.Chat.IsCommand = false
		Administrator.Chat.Chat.Erasable = true
	else
		Administrator.Chat.IsCommand = true
	end

	Administrator.Chat.CurrentText = text
	local explode = string.Explode( " ", text )

	if Administrator.Chat.IsCommand then
		Administrator.Chat.CurrentCommand = string.sub( string.lower( explode[ 1 ] ), 2 )
	else
		Administrator.Chat.CurrentCommand = ""
	end

	Administrator.Chat.Chat.CurrentSentence = { }
	local xPos, chatWidth = ScrW( ) * 0.05, ScrW( ) * 0.4
	surface.SetFont( Administrator.Chat.Chat.Font )
	local txt = LocalPlayer( ):Name( ) .. ":"

	if not Administrator.Chat.Chat.TalkMode then
		txt = "(" .. "" .. ") " .. txt
	end

	local w2, h2 = surface.GetTextSize( txt )
	local curXPos, kV, limit = xPos + w2 + 6, 1, xPos + chatWidth

	for k, v in pairs( explode ) do
		local w = surface.GetTextSize( v .. " " )

		if curXPos + w > limit then
			kV = kV + 1
			curXPos = xPos + w2 + 4 + w
		else
			curXPos = curXPos + w
		end

		if not Administrator.Chat.Chat.CurrentSentence[ kV ] then
			Administrator.Chat.Chat.CurrentSentence[ kV ] = { }
		end

		table.insert( Administrator.Chat.Chat.CurrentSentence[ kV ], v .. " " )
	end

	table.remove( explode, 1 )
	local txt = table.concat( explode, ' ' )
	-- Thanks Lexi, and raBBish for showing me this code C:
	-- http://www.facepunch.com/showthread.php?t=827179
	local quote = txt:sub( 1, 1 ) ~= '"'
	local args = { }

	for chunk in string.gmatch( txt, '[^"]+' ) do
		quote = not quote

		if quote then
			table.insert( args, chunk )
		else
			for chunk in string.gmatch( chunk, '[^"^%s]+' ) do
				table.insert( args, chunk )
			end
		end
	end

	Administrator.Chat.CurrentArgs = args
	Administrator.Chat.CurrentHints = { }

	if string.len( text ) >= 1 then
		local t = { }

		for k, v in pairs( Administrator.ClientCommands ) do
			local tNewArgs = { }

			for k2, v2 in ipairs( v ) do
				table.insert( tNewArgs, v2 )
			end

			table.insert( t, { k:sub( string.len( Administrator.ChatCommandPrefix ) + 1 ), #tNewArgs, tNewArgs } )
		end

		Administrator.Chat.SetUpHints( t )
	end

	if Administrator.Chat.IsCommand then
		if Administrator.Chat.Chat.Erasable then
			Administrator.Chat.Chat.Erasable = false
			Administrator.Chat.Chat.DrawCommands = { }
		end

		local b = #Administrator.Chat.CurrentArgs < 1

		if Administrator.Chat.Chat.DrawCommands[ 1 ] then
			Administrator.Chat.Chat.DrawCommands[ 1 ][ 1 ] = Administrator.Chat.CurrentCommand
			Administrator.Chat.Chat.DrawCommands[ 1 ][ 2 ] = "COMMAND"
			Administrator.Chat.Chat.DrawCommands[ 1 ][ 3 ] = b
			Administrator.Chat.Chat.DrawCommands[ 1 ][ 4 ] = Administrator.Chat.GetTableOfHints( )
		else
			Administrator.Chat.Chat.DrawCommands[ 1 ] = { Administrator.Chat.CurrentCommand, "COMMAND", b, Administrator.Chat.GetTableOfHints( ) }
		end

		local a, aT, b2 = Administrator.Chat.GetCommandArgs( Administrator.Chat.CurrentCommand )

		if a > 0 then
			for i = 1, a do
				local arg = ""

				if Administrator.Chat.CurrentArgs[ i ] then
					arg = Administrator.Chat.CurrentArgs[ i ]
				end

				local t = "argument"

				if aT[ i ] then
					t = aT[ i ]
				end

				if Administrator.Chat.Chat.DrawCommands[ 1 + i ] then
					Administrator.Chat.Chat.DrawCommands[ 1 + i ][ 1 ] = arg
					Administrator.Chat.Chat.DrawCommands[ 1 + i ][ 2 ] = t
					Administrator.Chat.Chat.DrawCommands[ 1 + i ][ 3 ] = #Administrator.Chat.CurrentArgs == i
				else
					Administrator.Chat.Chat.DrawCommands[ 1 + i ] = { arg, t, #Administrator.Chat.CurrentArgs == i }
				end
			end

			if #Administrator.Chat.CurrentArgs > a then
				for i = a + 1, #Administrator.Chat.CurrentArgs do
					if Administrator.Chat.Chat.DrawCommands[ 1 + i ] then
						Administrator.Chat.Chat.DrawCommands[ 1 + i ][ 1 ] = Administrator.Chat.CurrentArgs[ i ]
						Administrator.Chat.Chat.DrawCommands[ 1 + i ][ 2 ] = "optional"
						Administrator.Chat.Chat.DrawCommands[ 1 + i ][ 3 ] = #Administrator.Chat.CurrentArgs == i
					else
						Administrator.Chat.Chat.DrawCommands[ 1 + i ] = { Administrator.Chat.CurrentArgs[ i ], "optional", #Administrator.Chat.CurrentArgs == i }
					end
				end
			end
		end

		if b2 then
			for i = 1, 10 do
				if Administrator.Chat.Chat.DrawCommands[ 1 + i ] and i > a and i > #Administrator.Chat.CurrentArgs then
					Administrator.Chat.Chat.DrawCommands[ 1 + i ][ 7 ] = true
				end
			end
		end
	end
end

-- Administrator.chat_AddText_Old = Administrator.chat_AddText_Old or chat.AddText
function Administrator.Chat.PinChat( um )
	local pl = um:ReadEntity( )
	local text = um:ReadString( )
	chat.AddText( "PIN:", pl, Color( 255, 255, 255 ), ": " .. text )
end

usermessage.Hook( "Administrator.Chat.PinChat", Administrator.Chat.PinChat )

function chat.AddText( ... )

	local arg = { ... }

	chat_AddText_Old( unpack( arg ) )
	local nt = { }

	for k, v in pairs( arg ) do
		if k ~= "n" then
			if type( v ) == "string" then
				local explode = string.Explode( " ", v )

				if #explode > 1 then
					for k2, v2 in pairs( explode ) do
						local m = 20

						if ( string.sub( v2, 1, 7 ) == "http://" or string.sub( v2, 1, 8 ) == "https://" ) then
							m = 60
						end

						if string.len( v2 ) > m then
							local b = false

							for i = 1, string.len( v2 ) do
								b = not b

								if b then
									table.insert( nt, string.sub( v2, i, i + 1 ) )
								end
							end

							if #explode ~= k2 then
								table.insert( nt, " " )
							end
						else
							if #explode == k2 then
								table.insert( nt, v2 )
							else
								table.insert( nt, v2 .. " " )
							end
						end
					end
				else
					local m = 20

					if ( string.sub( v, 1, 7 ) == "http://" or string.sub( v, 1, 8 ) == "https://" ) then
						m = 60
					end

					if string.len( v ) > m then
						local b = false

						for i = 1, string.len( v ) do
							b = not b

							if b then
								table.insert( nt, string.sub( v, i, i + 1 ) )
							end
						end
					else
						table.insert( nt, v )
					end
				end
			elseif type( v ) == "Player" then
				table.insert( nt, Color( 250, 250, 0 ) )
				table.insert( nt, v:Name( ) )
			else
				table.insert( nt, v )
			end
		end
	end

	local t = Administrator.Chat.WrapText( nt )

	for k, v in pairs( t ) do
		local b = false

		for k2, v2 in pairs( v ) do
			if type( v2 ) == "string" and ( string.sub( v2, 1, 7 ) == "http://" or string.sub( v2, 1, 8 ) == "https://" ) then
				b = k2
				break
			end
		end

		table.insert( Administrator.Chat.Chat.Texts, {v, 0, 0, CurTime( ) + 10, CurTime( ) + 0.2, b_flashing, b } )
	end
end

Administrator.CommandPrefix = "hl2cr"
Administrator.Chat.Chat = Administrator.Chat.Chat or {}
Administrator.Chat.Chat.LastClick = { 0, 0 }
Administrator.Chat.Chat.Scroll = 0
Administrator.Chat.Chat.Font = "ChatFont"
Administrator.Chat.Chat.CurrentSentence = { { } }
Administrator.Chat.Chat.Erasable = true
Administrator.Chat.Chat.DrawCommands = { }
Administrator.Chat.Chat.Size = CreateClientConVar( Administrator.CommandPrefix .. "_chat_size", 10, true, false )
Administrator.Chat.Chat.ColorR = CreateClientConVar( Administrator.CommandPrefix .. "_chat_red", 0, true, false )
Administrator.Chat.Chat.ColorG = CreateClientConVar( Administrator.CommandPrefix .. "_chat_green", 0, true, false )
Administrator.Chat.Chat.ColorB = CreateClientConVar( Administrator.CommandPrefix .. "_chat_blue", 0, true, false )
Administrator.Chat.Chat.Expanding = -2
Administrator.Chat.Chat.Enabled = false
Administrator.Chat.Chat.Fade = 0
Administrator.Chat.Chat.Texts = Administrator.Chat.Chat.Texts or {}

function Administrator.Chat.StartChat( bTeam )
	Administrator.Chat.Chat.OpenOnce = true
	Administrator.Chat.Chat.TalkMode = not bTeam
	Administrator.Chat.Chat.Expanding = -2
	Administrator.Chat.Chat.Scroll = 0
	Administrator.Chat.Chat.Enabled = true
	Administrator.Chat.CurrentCommand = ""
	Administrator.Chat.CurrentText = ""
	
	LocalPlayer( ).usingchat = true

	return true
end

function Administrator.Chat.FinishChat( )
	Administrator.Chat.Chat.CurrentSentence = { { } }
	Administrator.Chat.Chat.Enabled = false
	Administrator.Chat.Chat.Scroll = 0

	for k, v in pairs( Administrator.Chat.Chat.Texts ) do
		if ( k < #Administrator.Chat.Chat.Texts - Administrator.Chat.Chat.Scroll - Administrator.Chat.Chat.Size:GetInt( ) + 1 or k > #Administrator.Chat.Chat.Texts - Administrator.Chat.Chat.Scroll ) then
			Administrator.Chat.Chat.Texts[ k ][ 2 ] = 0
		end
	end

	LocalPlayer( ).usingchat = false
end

hook.Add( "StartChat", "Administrator.Chat.StartChat", Administrator.Chat.StartChat )
hook.Add( "FinishChat", "Administrator.Chat.FinishChat", Administrator.Chat.FinishChat )
hook.Add( "ChatTextChanged", "Administrator.Chat.ChatTextChanged", Administrator.Chat.ChatTextChanged )

function Administrator.Chat.GUIMousePressed( c )
	if c == MOUSE_LEFT then
		Administrator.Chat.Chat.LastClick = { gui.MousePos( ) }
	end
end

hook.Add( "GUIMousePressed", "Administrator.Chat.GUIMousePressed", Administrator.Chat.GUIMousePressed )
local sliderTexture = surface.GetTextureID( "VGUI/slider" )

function Administrator.Chat.DrawChatBox( )
	if ( not Administrator.Chat.Chat.Texts ) then
		Administrator.Chat.Chat.Texts = { }
		print( "[CHAT LOAD ERROR] Texts is nil?! - Compensating" )
	end

	if Administrator.Chat.Chat.Enabled then
		Administrator.Chat.Chat.Fade = Administrator.Chat.Chat.Fade + ( ( 175 - Administrator.Chat.Chat.Fade ) * FrameTime( ) * 5 )
	elseif Administrator.Chat.Chat.Expanding < -1 then
		Administrator.Chat.Chat.Fade = Administrator.Chat.Chat.Fade + ( ( 0 - Administrator.Chat.Chat.Fade ) * FrameTime( ) * 5 )
	end

	local xPos, yPos, chatWidth, chatHeight = ScrW( ) * 0.025, ScrH( ) * 0.80, ScrW( ) * 0.4, 0
	local r, g, b = Administrator.Chat.Chat.ColorR:GetInt( ), Administrator.Chat.Chat.ColorG:GetInt( ), Administrator.Chat.Chat.ColorB:GetInt( )
	surface.SetFont( Administrator.Chat.Chat.Font )
	local size = Administrator.Chat.Chat.Size:GetInt( )
	local w, h = surface.GetTextSize( "#" )
	chatHeight = ( h + 2 ) + size * ( h + 2 )
	surface.SetDrawColor( r, g, b, Administrator.Chat.Chat.Fade )
	surface.DrawRect( xPos, yPos - chatHeight, chatWidth, chatHeight - ( h + 2 ) )
	surface.SetDrawColor( r + 10, g + 10, b + 10, Administrator.Chat.Chat.Fade )
	surface.DrawOutlinedRect( xPos, yPos - chatHeight, chatWidth, chatHeight - ( h + 2 ) )
	local text = ""

	if not Administrator.Chat.Chat.TalkMode then
		text = "(" .. "" .. ") " .. text
	end

	local w2, h2 = surface.GetTextSize( text )
	surface.SetDrawColor( r, g, b, Administrator.Chat.Chat.Fade )
	surface.DrawRect( xPos, yPos - ( h + 2 ), w2 + 4, ( h + 2 ) )
	surface.SetDrawColor( r + 10, g + 10, b + 10, Administrator.Chat.Chat.Fade )
	surface.DrawOutlinedRect( xPos, yPos - ( h + 2 ), w2 + 4, ( h + 2 ) )
	surface.SetDrawColor( r, g, b, Administrator.Chat.Chat.Fade )
	surface.DrawRect( xPos + w2 + 4, yPos - ( h + 2 ), chatWidth - ( w2 + 4 ), ( h + 2 ) * #Administrator.Chat.Chat.CurrentSentence )
	surface.SetDrawColor( r + 10, g + 10, b + 10, Administrator.Chat.Chat.Fade )
	surface.DrawOutlinedRect( xPos + w2 + 4, yPos - ( h + 2 ), chatWidth - ( w2 + 4 ), ( h + 2 ) * #Administrator.Chat.Chat.CurrentSentence )
	draw.DrawText( text, Administrator.Chat.Chat.Font, xPos + 2, yPos - ( h + 2 ), Color( 255, 255, 255, Administrator.Chat.Chat.Fade ), TEXT_ALIGN_LEFT )
	local curChatTextColor = Color( 255, 255, 255, Administrator.Chat.Chat.Fade )
	local sentencePos = 0

	for k, v in pairs( Administrator.Chat.Chat.CurrentSentence ) do
		for k2, v2 in pairs( v ) do
			if type( v2 ) ~= "string" then
				curChatTextColor = Color( v2.r, v2.g, v2.b, Administrator.Chat.Chat.Fade )
			else
				local senW = surface.GetTextSize( v2 )
				draw.DrawText( v2, Administrator.Chat.Chat.Font, xPos + w2 + 6 + sentencePos, yPos - ( h + 2 ) + ( ( k - 1 ) * ( h + 2 ) ), curChatTextColor, TEXT_ALIGN_LEFT )
				sentencePos = sentencePos + senW
			end
		end

		sentencePos = 0
	end

	sentencePos = 0
	curChatTextColor = Color( 255, 255, 255, Administrator.Chat.Chat.Fade )

	if #Administrator.Chat.Chat.Texts > 0 then
		for k = math.max( #Administrator.Chat.Chat.Texts - size - Administrator.Chat.Chat.Scroll, 1 ), math.max( #Administrator.Chat.Chat.Texts - Administrator.Chat.Chat.Scroll + 1, 1 ) do
			if Administrator.Chat.Chat.Texts[ k ] then
				local v = Administrator.Chat.Chat.Texts[ k ]

				if v[ 3 ] == 0 then
					Administrator.Chat.Chat.Texts[ k ][ 3 ] = yPos - ( ( h + 2 ) * 2 ) - ( ( math.max( #Administrator.Chat.Chat.Texts - Administrator.Chat.Chat.Scroll, 1 ) - k ) * ( h + 2 ) )
				else
					Administrator.Chat.Chat.Texts[ k ][ 3 ] = v[ 3 ] + ( ( ( yPos - ( ( h + 2 ) * 2 ) - ( ( math.max( #Administrator.Chat.Chat.Texts - Administrator.Chat.Chat.Scroll, 1 ) - k ) * ( h + 2 ) ) ) - v[ 3 ] ) * FrameTime( ) * 10 )
				end

				if ( k < #Administrator.Chat.Chat.Texts - Administrator.Chat.Chat.Scroll - size + 1 or k > #Administrator.Chat.Chat.Texts - Administrator.Chat.Chat.Scroll ) or CurTime( ) > v[ 4 ] and not Administrator.Chat.Chat.Enabled then
					Administrator.Chat.Chat.Texts[ k ][ 2 ] = v[ 2 ] + ( ( 0 - v[ 2 ] ) * FrameTime( ) * 10 )
				elseif CurTime( ) > v[ 5 ] then
					local def = 255

					if v[ 6 ] then
						def = math.abs( math.sin( CurTime( ) * 2 ) * 255 )
					end

					Administrator.Chat.Chat.Texts[ k ][ 2 ] = v[ 2 ] + ( ( def - v[ 2 ] ) * FrameTime( ) * 10 )
				end

				if math.floor( v[ 2 ] ) ~= 0 then
					curChatTextColor.a = v[ 2 ]

					for k2, v2 in pairs( v[ 1 ] ) do
						if type( v2 ) == "string" then
							if v[ 7 ] and v[ 7 ] == k2 then
								draw.DrawText( v2, Administrator.Chat.Chat.Font, xPos + 2 + sentencePos, v[ 3 ], Color( 0, 217, 255, v[ 2 ] ), TEXT_ALIGN_LEFT )
								local senW, senH = surface.GetTextSize( v2 )

								if Administrator.Chat.Chat.LastClick[ 1 ] > xPos + sentencePos and xPos + sentencePos + senW > Administrator.Chat.Chat.LastClick[ 1 ] and Administrator.Chat.Chat.LastClick[ 2 ] > v[ 3 ] and v[ 3 ] + senH > Administrator.Chat.Chat.LastClick[ 2 ] then
									Administrator.Chat.Chat.LastClick = { 0, 0 }
									gui.OpenURL( v2 )
								end

								sentencePos = sentencePos + senW
							else
								local senW = surface.GetTextSize( v2 )
								draw.DrawText( v2, Administrator.Chat.Chat.Font, xPos + 2 + sentencePos, v[ 3 ], curChatTextColor, TEXT_ALIGN_LEFT )
								sentencePos = sentencePos + senW
							end
						elseif ( type( v2 ) == "table" and v2.r ) then
							curChatTextColor = Color( v2.r, v2.g, v2.b, v[ 2 ] )
						end
					end

					sentencePos = 0
				end
			end
		end
	end
end

function Administrator.Chat.DrawChatBoxHint( )
	local xPos, yPos, chatWidth, chatHeight = ScrW( ) * 0.05, ScrH( ) * 0.80, ScrW( ) * 0.4, 0
	local r, g, b = Administrator.Chat.Chat.ColorR:GetInt( ), Administrator.Chat.Chat.ColorG:GetInt( ), Administrator.Chat.Chat.ColorB:GetInt( )
	surface.SetFont( Administrator.Chat.Chat.Font )
	local size = Administrator.Chat.Chat.Size:GetInt( )
	local w, h = surface.GetTextSize( "#" )
	chatHeight = ( h + 2 ) + size * ( h + 2 )

	if Administrator.Chat.CurrentCommand == "" then
		Administrator.Chat.Chat.Expanding = Administrator.Chat.Chat.Expanding + ( ( -2 - Administrator.Chat.Chat.Expanding ) * FrameTime( ) * 10 )
	else
		Administrator.Chat.Chat.Expanding = Administrator.Chat.Chat.Expanding + ( ( ( ( chatWidth / 2 ) - 2 ) - Administrator.Chat.Chat.Expanding ) * FrameTime( ) * 10 )
	end

	if Administrator.Chat.Chat.Expanding > -1 then
		local scissX, scissY = xPos + chatWidth - 2, yPos - chatHeight
		local scissW, scissH = scissX + ( chatWidth / 2 ) + 4, scissY + chatHeight
		render.SetScissorRect( scissX, scissY, scissW, scissH, true )
		surface.SetDrawColor( r, g, b, Administrator.Chat.Chat.Fade )
		surface.DrawRect( xPos + ( chatWidth / 2 ) + Administrator.Chat.Chat.Expanding, yPos - chatHeight, chatWidth / 2, chatHeight )
		surface.SetDrawColor( r + 20, g + 20, b + 20, Administrator.Chat.Chat.Fade )
		surface.DrawOutlinedRect( xPos + ( chatWidth / 2 ) + Administrator.Chat.Chat.Expanding, yPos - chatHeight, chatWidth / 2, chatHeight )
		local y = yPos - chatHeight

		for k, v in pairs( Administrator.Chat.Chat.DrawCommands ) do
			-- v[1] = String v[2] = Type v[3] = Active tab v[4] = Active tab members
			-- v[5] = x position v[6] = y position
			if not v[ 5 ] then
				Administrator.Chat.Chat.DrawCommands[ k ][ 5 ] = xPos + ( chatWidth / 2 )
				Administrator.Chat.Chat.DrawCommands[ k ][ 6 ] = y
			end

			local text = v[ 1 ]

			if text == "" then
				text = v[ 2 ]
			end

			surface.SetFont( "TargetID" )
			local x, y2 = surface.GetTextSize( text )
			y2 = ( y2 + 4 ) / 2
			Administrator.Chat.Chat.DrawCommands[ k ][ 5 ] = math.Min( v[ 5 ] + ( ( ( xPos + ( chatWidth / 2 ) + Administrator.Chat.Chat.Expanding ) - v[ 5 ] ) * FrameTime( ) * 15 ), xPos + ( chatWidth / 2 ) + Administrator.Chat.Chat.Expanding )
			Administrator.Chat.Chat.DrawCommands[ k ][ 6 ] = v[ 6 ] + ( ( y - v[ 6 ] ) * FrameTime( ) * 10 )
			y = y + ( y2 * 2 )
			surface.SetDrawColor( r + 10, g + 10, b + 10, Administrator.Chat.Chat.Fade )
			surface.DrawRect( v[ 5 ], v[ 6 ], chatWidth / 2, y2 )
			surface.SetDrawColor( r, g, b, Administrator.Chat.Chat.Fade )
			surface.DrawRect( v[ 5 ], v[ 6 ] + y2, chatWidth / 2, y2 )

			if v[ 1 ] == "" then
				draw.DrawText( text, "TargetID", v[ 5 ] + 2, v[ 6 ] + 2, Color( 255, 255, 255, 150 ), TEXT_ALIGN_LEFT )
			else
				draw.DrawText( text, "TargetID", v[ 5 ] + 2, v[ 6 ] + 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
			end

			if v[ 3 ] then
				if v[ 4 ] then
					local limit = chatHeight - ( ( y2 * 2 ) * #Administrator.Chat.Chat.DrawCommands )
					local y4 = 0

					for k2, v2 in pairs( v[ 4 ] ) do
						surface.SetFont( "TargetIDSmall" )
						local x, y3 = surface.GetTextSize( v2 )

						if y4 + y3 < limit then
							draw.DrawText( v2, "TargetIDSmall", v[ 5 ] + 2, v[ 6 ] + ( y2 * 2 ) + y4, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
							y = y + y3
							y4 = y4 + y3
						else
							break
						end
					end
				elseif ( v[ 2 ] == "<Player>" or v[ 2 ] == "[Player]" ) then
					local b = true
					local y4 = 0
					local sel = 0
					local lasty3 = 0
					local str = v[ 1 ]
					local ran = false

					if string.sub( str, 1, 1 ) == "!" then
						str = string.sub( str, 2 )
					end

					if string.sub( str, 1, 1 ) == "~" then
						str = string.sub( str, 2 )
						sel = 5
					end

					if str == "@all" then
						sel = 1
					elseif str == "@alive" then
						sel = 2
					elseif str == "@dead" then
						sel = 3
					elseif str == "@self" then
						sel = 4
					elseif str == "@random" then
						sel = 6

						if player.GetCount( ) > 1 then
							local tab = player.GetAll( )

							for k, v in pairs( tab ) do
								if v == LocalPlayer( ) then
									table.remove( tab, k )
								end
							end

							ran = table.Random( tab )
						else
							ran = LocalPlayer( )
						end
					end

					local count, self = 0, false

					for k2, v2 in pairs( player.GetAll( ) ) do
						if string.find( string.lower( v2:Name( ) ), string.lower( str ), 1, true ) then
							if v2 == LocalPlayer( ) then
								self = true
							end

							count = count + 1
						end
					end

					if count == 1 and self then
						sel = 4
					end

					for k2, v2 in pairs( player.GetAll( ) ) do
						b = not b
						surface.SetFont( "TargetIDSmall" )
						local x, y3 = surface.GetTextSize( v2:Name( ) )
						local str2 = v2:Name( )

						if x > chatWidth / 4 then
							str2 = string.sub( v2:Name( ), 1, 14 ) .. "..."
						end

						local r, g, b = Administrator.Chat.Chat.ColorR:GetInt( ), Administrator.Chat.Chat.ColorG:GetInt( ), Administrator.Chat.Chat.ColorB:GetInt( )

						if ( string.find( string.lower( v2:Name( ) ), string.lower( str ), 1, true ) and sel == 0 and v2 ~= LocalPlayer( ) ) or ( not string.find( string.lower( v2:Name( ) ), string.lower( str ), 1, true ) and sel == 5 and v2 ~= LocalPlayer( ) ) or ( v2 ~= LocalPlayer( ) and sel == 1 ) or ( v2 ~= LocalPlayer( ) and v2:Alive( ) and sel == 2 ) or ( v2 ~= LocalPlayer( ) and not v2:Alive( ) and sel == 3 ) or ( v2 == LocalPlayer( ) and sel == 4 ) or ( ran and sel == 6 and ran == v2 ) then
							surface.SetDrawColor( r + 20, g, b, Administrator.Chat.Chat.Fade + 30 )
						else
							surface.SetDrawColor( r, g, b, Administrator.Chat.Chat.Fade + 30 )
						end

						if b then
							surface.DrawRect( v[ 5 ] + ( chatWidth / 4 ), v[ 6 ] + ( y2 * 2 ) + y4, chatWidth / 4, y3 )
							draw.DrawText( str2, "TargetIDSmall", v[ 5 ] + ( chatWidth / 4 ) + 2, v[ 6 ] + ( y2 * 2 ) + y4, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
							y = y + y3
							y4 = y4 + y3
						else
							surface.DrawRect( v[ 5 ], v[ 6 ] + ( y2 * 2 ) + y4, chatWidth / 4, y3 )
							draw.DrawText( str2, "TargetIDSmall", v[ 5 ] + 2, v[ 6 ] + ( y2 * 2 ) + y4, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT )
						end

						lasty3 = y3
					end

					if not b then
						y = y + lasty3
					end
				end
			end
		end

		for i = 1, #Administrator.Chat.Chat.DrawCommands do
			if Administrator.Chat.Chat.DrawCommands[ i ][ 7 ] then
				table.remove( Administrator.Chat.Chat.DrawCommands, i )
				break
			end
		end

		render.SetScissorRect( 0, 0, 0, 0, false )
	end
end

function Administrator.Chat.DrawChatBoxJoin( )
	if ( Administrator.Chat.ShowServers ) then
		if ( Administrator.Chat.ShowServers.StopShowing ) then
			Administrator.Chat.ShowServers.Alpha = Administrator.Chat.ShowServers.Alpha - 300 * FrameTime( )

			if ( Administrator.Chat.ShowServers.Alpha < 0 ) then
				Administrator.Chat.ShowServers.Alpha = 0
				Administrator.Chat.ShowServers = nil

				return
			end
		else
			Administrator.Chat.ShowServers.Alpha = Administrator.Chat.ShowServers.Alpha + 300 * FrameTime( )

			if ( Administrator.Chat.ShowServers.Alpha > 100 ) then
				Administrator.Chat.ShowServers.Alpha = 100
			end

			Administrator.Chat.ShowServers.Height = Administrator.Chat.ShowServers.Height + 100 * FrameTime( )

			if ( Administrator.Chat.ShowServers.Height > 22 ) then
				Administrator.Chat.ShowServers.Height = 22
			end
		end

		local r, g, b = Administrator.Chat.Chat.ColorR:GetInt( ), Administrator.Chat.Chat.ColorG:GetInt( ), Administrator.Chat.Chat.ColorB:GetInt( )
		local cMain = Color( r, g, b, Administrator.Chat.ShowServers.Alpha )
		local xHigh, yLow, width = ScrW( ) * 0.05, ScrH( ) * 0.80, 350
		surface.SetFont( Administrator.Chat.Chat.Font )
		local w, h = surface.GetTextSize( "#" )
		local size = Administrator.Chat.Chat.Size:GetInt( )
		chatHeight = ( h + 2 ) + size * ( h + 2 )
		yLow = yLow - chatHeight
		surface.SetDrawColor( cMain )
		surface.DrawRect( xHigh, yLow - Administrator.Chat.ShowServers.Height, width, Administrator.Chat.ShowServers.Height )
		surface.SetDrawColor( Color( cMain.r + 20, cMain.g + 20, cMain.b + 20, Administrator.Chat.ShowServers.Alpha ) )
		surface.DrawRect( xHigh, yLow - Administrator.Chat.ShowServers.Height, width, Administrator.Chat.ShowServers.Height )
		render.SetScissorRect( xHigh, yLow - 19, xHigh + width, yLow - 1, true )
		local cServers = Color( 255 - cMain.r, 255 - cMain.g, 255 - cMain.b, Administrator.Chat.ShowServers.Alpha )

		for k, v in pairs( Administrator.Chat.ShowServers.Servers ) do
			if ( v.Alpha > 255 ) then
				draw.DrawText( v.Name, "TargetIDSmall", xHigh + 6, yLow - 20 + v.YPos, Color( cServers.r, cServers.g, cServers.b, v.Alpha - 255 ), TEXT_ALIGN_LEFT )
			else
				draw.DrawText( v.Map, "TargetIDSmall", xHigh + 6, yLow - 20 + v.YPos, Color( cServers.r, cServers.g, cServers.b, 255 - v.Alpha ), TEXT_ALIGN_LEFT )
			end

			draw.DrawText( v.Command, Administrator.Chat.Chat.Font, xHigh + width - 4, yLow - 18 + v.YPos, Color( cServers.r, cServers.g, cServers.b, cServers.a + 155 ), TEXT_ALIGN_RIGHT )
			local w, h = surface.GetTextSize( v.Command )
			draw.DrawText( v.Info, "TargetIDSmall", xHigh + 2 + width - 4 - w - 8, yLow - 20 + v.YPos, Color( cServers.r, cServers.g, cServers.b, cServers.a + 155 ), TEXT_ALIGN_RIGHT )
			v.YPos = v.YPos - 80 * FrameTime( )
			local yMax = ( ( k - Administrator.Chat.ShowServers.CurrentK ) * 26 )

			if ( v.YPos < yMax ) then
				v.YPos = yMax

				if ( Administrator.Chat.ShowServers.CurrentK > #Administrator.Chat.ShowServers.Servers ) then
					Administrator.Chat.ShowServers.StopShowing = true
				end

				if ( Administrator.Chat.ShowServers.CurrentK == k and ( RealTime( ) + 7 > Administrator.Chat.ShowServers.Time ) ) then
					v.Alpha = v.Alpha - 350 * FrameTime( )

					if ( v.Alpha < 0 ) then
						v.Alpha = 0
					end
				end
			end
		end

		if ( RealTime( ) > Administrator.Chat.ShowServers.Time ) then
			Administrator.Chat.ShowServers.Time = RealTime( ) + 10
			Administrator.Chat.ShowServers.CurrentK = Administrator.Chat.ShowServers.CurrentK + 1
		end

		render.SetScissorRect( 0, 0, 0, 0, false )
	end
end

function Administrator.Chat.TruncateChat( )
	Administrator.Chat.Chat.Texts = { { { "Chat truncated." }, 0, 0, CurTime( ) + 10, CurTime( ) + 0.2 } }
end

usermessage.Hook( "Administrator.Chat.TruncateChat", Administrator.Chat.TruncateChat )

function Administrator.Chat.Draw( )
	Administrator.Chat.DrawChatBox( )
end

hook.Add( "PostRenderVGUI", "Administrator.Chat.Draw", Administrator.Chat.Draw )

function Administrator.Chat.Chat.ShutDown( )
	LocalPlayer( ).usingchat = false
end

hook.Add( "ShutDown", "Administrator.Chat.Chat.ShutDown", Administrator.Chat.Chat.ShutDown )

function Administrator.Chat.Chat.Think( )
	if ( Administrator.Chat.Chat.Enabled ) then
		-- print("Moused Used",input.WasMousePressed( MOUSE_WHEEL_UP ))
		if input.IsKeyDown( KEY_UP ) and not Administrator.Chat.Chat.Up then
			-- if input.IsMouseDown(MOUSE_WHEEL_UP) && !Administrator.Chat.Chat.Up then
			Administrator.Chat.Chat.Up = true
			Administrator.Chat.Chat.Scroll = math.Clamp( Administrator.Chat.Chat.Scroll + 1, 0, #Administrator.Chat.Chat.Texts )
			-- elseif !input.IsKeyDown(KEY_UP) && Administrator.Chat.Chat.Up then
		elseif not input.IsMouseDown( MOUSE_WHEEL_UP ) and Administrator.Chat.Chat.Up then
			Administrator.Chat.Chat.Up = false
		end

		if input.IsKeyDown( KEY_DOWN ) and not Administrator.Chat.Chat.Down then
			-- if input.IsMouseDown(MOUSE_WHEEL_DOWN) && !Administrator.Chat.Chat.Down then
			Administrator.Chat.Chat.Down = true
			Administrator.Chat.Chat.Scroll = math.Clamp( Administrator.Chat.Chat.Scroll - 1, 0, #Administrator.Chat.Chat.Texts )
		elseif not input.IsKeyDown( KEY_DOWN ) and Administrator.Chat.Chat.Down then
			-- elseif !input.IsMouseDown(MOUSE_WHEEL_DOWN) && Administrator.Chat.Chat.Down then
			Administrator.Chat.Chat.Down = false
		end
	end
end

lastMessage = lastMessage or 60

local randomAutoMessage = {}

function ChatAutoMessage()
	if lastMessage > CurTime() then return end

	if table.IsEmpty(randomAutoMessage) then
		randomAutoMessage = {
			[1]	= translate.Get("Chat_Announce_Difficulty"),
			//[2] = translate.Get("Chat_Announce_Survival"),
			[2]	= translate.Get("Chat_Announce_NotGordon"),
			[3] = translate.Get("Chat_Announce_ReturnLobby"),
			[4] = translate.Get("Chat_Announce_Discord"),
			[5] = translate.Get("Chat_Announce_StuckMap")
		}
	end

	local tab = {}
	table.insert( tab, Color( 255, 174, 0) )
	table.insert( tab, randomAutoMessage[math.random(1, #randomAutoMessage)] )
	chat.AddText( unpack( tab ) )
	
	lastMessage = math.random(120, 300) + CurTime()
end


hook.Add( "Think", "Administrator.Chat.Chat.Think", Administrator.Chat.Chat.Think )

hook.Add("Think", "Chat.AutoAnnounceThink", ChatAutoMessage)


function Administrator.Chat.Chat.HUDShouldDraw( name )
	if not Administrator.Chat.Chat.OpenOnce then return false end
end

hook.Add( "HUDShouldDraw", "Administrator.Chat.Chat.HUDShouldDraw", Administrator.Chat.Chat.HUDShouldDraw )

function Administrator.Chat.DrawPaint( )
	Administrator.Chat.DrawChatBoxHint( )
	Administrator.Chat.DrawChatBoxJoin( )
end

hook.Add( "HUDPaint", "Administrator.Chat.DrawPaint", Administrator.Chat.DrawPaint )

function GM:OnPlayerChat( ply, strText, bTeamOnly, bPlayerIsDead )

	local tab = { }

	table.insert(tab, Color(255, 165, 0))
	table.insert(tab, os.date( "%H:%M - ", os.time() ) )

	if IsValid( ply ) then 
		if ( ply:Team( ) == 3 ) then
			table.insert( tab, Color( 255, 30, 40 ) )
			table.insert( tab, "[DEAD] " )
		elseif ply:Team( ) == 1  then
			table.insert( tab, Color( 30, 255, 40 ) )
			table.insert( tab, "[ALIVE] " )
		elseif ply:Team( ) == 5 then
			table.insert( tab, Color( 165, 165, 165 ) )
			table.insert( tab, "[AFK] " )
		elseif ply:Team( ) == 2 then
			table.insert( tab, Color( 255, 255, 40 ) )
			table.insert( tab, "[COMPLETED MAP] " )
		end

		if ( bTeamOnly ) then
			table.insert( tab, Color( 30, 160, 40 ) )
			table.insert( tab, "(TEAM) " )
		end

		table.insert( tab, ply )
	else 
		table.insert( tab, "Console" )
	end

	table.insert( tab, Color( 255, 255, 255 ) )
	table.insert( tab, ": " .. strText )
	chat.AddText( unpack( tab ) )

	return true
end

net.Receive("HL2CR_ChatHistory", function()
	local message = net.ReadTable()
end)