--[[------------------------------------------

	============================
		NOTIFICATION MODULE
	============================

]]--------------------------------------------

local mod = "notification"

function APG.notify(log, level, target, ... ) -- The most advanced notification function in the world.

	local log = log 							-- Should the message be logged?
	local level = level 						-- The level of the error.
	local target = target 						-- Whos ist this message meant for?
	local msg = {...} 							-- Pack the arguments in a table.

	local outMsg = "" 							-- Concat the message into this variable.
	local isConsole = ( target == "console" ) 	-- Is this message meant for the console 

	if type(level) == "string" then
		level = string.lower( level )
		level = ( level == "notice" and 0 ) or ( level == "warning" and 1 ) or ( level == "alert" and 2 )
	end

	if target then
		if type(target) == "string" then
			(({
				["all"] = function()
					target = player.GetHumans()
				end,
				["admin"] = function()
					local data = player.GetHumans()
					for k, v in next, data do
						if not v:IsAdmin() then
							data[k] = nil
						end
					end
					target = data
				end,
				["superadmin"] = function()
					local data = player.GetHumans()
					for k, v in next, data do
						if not v:IsSuperAdmin() then
							data[k] = nil
						end
					end
					target = data
				end,
				["console"] = function()
					-- Just send it to the logs without actually giving out a message.
				end,
			})[target])()
		else
			if IsEntity( target ) and IsValid( target ) and target:IsPlayer() then
				target = { target }
			end
		end
	end

	local outMsg = ""

	for _, v in next, msg do
		local data = v and tostring(v) or ""
		if string.len( outMsg ) == 0 then
			outMsg = data
		else
			outMsg = outMsg .. " " .. data
		end
	end

	outMsg = string.Trim( outMsg )

	if string.len( outMsg ) > 0 and ( log or isConsole ) then
		ServerLog("[APG] " .. outMsg .. "\n")
		if isConsole then
			MsgC( Color( 72, 216, 41 ), "[APG]", Color( 255, 255, 255 ), outMsg)
			return true
		end
	end

	if type(target) ~= "table" then return false end

	for _, v in next, target do
		if not isentity(v) then continue end
		if not IsValid(v) then continue end
		net.Start("apg_notice_s2c")
			net.WriteUInt(level, 3)
			net.WriteString(outMsg)
		net.Send(v)
	end

	return true

end
