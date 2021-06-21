-- Copyright (C) 2021  Mysy00

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

script_name('Simpler Textdraws')

local sampev = require 'samp.events'
local pos_x, pos_y = getScreenResolution()
local hasBeenRun = false
local firstSpawn = true -- Toggle HUD on the first spawn
local defaultTextdrawPos =  {}
local areTextdrawsHidden = false
local isPlayerSpecing = false

-- 0, 5, 6, 177, 178, 179 - vehicle monitor
-- 11, 12, 13 - radar
-- 95 - low hunger
-- 96 - low thirst
-- 97 - low temperature
-- 98 - infection
-- 99 - broken leg
-- 100 - low energy
-- 101 - info about who joined, left or died
-- 108, 111 - loot respawn
-- 951 - custom TD
-- 952 custom TD (coins)
-- 2048 - 2054 - box on the left with Information about speced player

function dump(o)
	if type(o) == 'table' then
		 local s = '{ '
		 for k,v in pairs(o) do
				if type(k) ~= 'number' then k = '"'..k..'"' end
				s = s .. '['..k..'] = ' .. dump(v) .. ','
		 end
		 return s .. '} '
	else
		 return tostring(o)
	end
end

local originalHUD = {102, 103, 104, 105, 106, 107, 2093, 2094, 2095, 2096, 2097, 2098, 2099, 2100, 2101, 2102, 2103, 2104, 2105, 2106, 2107, 2108, 2109, 2110, 2111, 2112, 2113, 2114, 2115, 2116, 2117, 2118, 2119, 2120, 2121, 2122, 2123, 2124, 2125, 2126, 2127, 2128, 2129, 2130, 2131}


function isInArray(arr, val)
	for index, value in ipairs(arr) do
			if value == val then
					return true
			end
	end
	return false
end

function main()
	while not isSampAvailable() do wait(100) end
	if not isSampfuncsLoaded() or not isSampLoaded() then
		print("Disabling ".. script_name ..", error loading dependencies")
		sampAddChatMessage("Disabling ".. script_name ..", error loading dependencies")
		return false
	end
	
	while true do
		wait(0)	
		if not sampTextdrawIsExists(2109) then
			wait(100) 
			return false
		end
	
		if not sampTextdrawIsExists(2109) and sampTextdrawIsExists(951) then
			sampTextdrawDelete(951)
		end
		
		if not hasBeenRun and sampIsLocalPlayerSpawned() then
			for _, textdraw in pairs(originalHUD) do
				-- if not sampTextdrawIsExists(textdraw) then return false end
				x, y = sampTextdrawGetPos(textdraw)
				defaultTextdrawPos[textdraw] = {x, y}
				print("Saved position of: " .. textdraw)
			end
			hasBeenRun = true
		end

		if isKeyJustPressed(220) then
			toggleHUD()
		end

		-- bloodTD = sampTextdrawGetString(2109):gsub("%D+", "")
		-- let's hope Epic won't ever translate the "blood" string
		bloodTD = sampTextdrawGetString(2109):sub(8, 12)
		hungerTD = sampTextdrawGetString(2122):gsub("%D+", "")
		thirstTD = sampTextdrawGetString(2126):gsub("%D+", "")
		energyTD = sampTextdrawGetString(2131):gsub("%D+", "")
		tempTD = sampTextdrawGetString(2108):gsub("%D+", "")
		killsTD = sampTextdrawGetString(2106):gsub("%D+", "")
		spacing = "   "
		
		-- Change color of "Loot Respawn" TD
		if sampTextdrawIsExists(108) then sampTextdrawSetBoxColorAndSize(108, 1, 0x88000000, 614, 4) end

		-- Blood Information
		if tonumber(bloodTD) > 99 then
			bloodBar = spacing .. "BLOOD: " .. bloodTD .. spacing
		else
			bloodBar = spacing .. "~r~BLOOD: " .. bloodTD .. "~w~" .. spacing
		end

		-- Hunger Information
		if tonumber(hungerTD) > 75 then
			hungerBar = spacing .. "HUNGER: " .. hungerTD .. spacing
		else
			hungerBar = spacing .. "~r~HUNGER: " .. hungerTD .. "~w~" .. spacing
		end

		-- Thirst Information
		if tonumber(thirstTD) > 50 then
			thirstBar = spacing .. "THIRST: " .. thirstTD .. spacing
		else
			thirstBar = spacing .. "~r~THIRST: " .. thirstTD .. "~w~" .. spacing
		end

		-- Temp Information
		if tonumber(tempTD) > 15 then
			tempBar = ""
		else
			tempBar = spacing .. "~r~TEMP: " .. tempTD .. "~w~" .. spacing
		end

		-- Energy Information
		if tonumber(energyTD) > 20 then
			energyBar = ""
		else
			energyBar = spacing .. "~r~ENERGY: " .. energyTD  .. "~w~" .. spacing
		end

		-- Kills Information
		killsBar =  spacing .. "Kills: " .. killsTD
		
		sampTextdrawCreate(951, bloodBar .. hungerBar .. thirstBar .. tempBar .. energyBar .. killsBar, 310, 433)
		sampTextdrawSetStyle(951,1)
		sampTextdrawSetAlign(951,2)
		sampTextdrawSetBoxColorAndSize(951, 1, 0x88000000, 0, pos_y)
		sampTextdrawSetLetterSizeAndColor(951, 0.3, 1.5, 0xFFFFFFFF)
		sampTextdrawSetOutlineColor(951, 1, 0xFF000000)
	end
end

function toggleHUD()
	areTextdrawsHidden = not areTextdrawsHidden

	if areTextdrawsHidden then
		for _, textdraw in pairs(originalHUD) do
			if not sampTextdrawIsExists(textdraw) then return false end
			print("Hiding: " .. textdraw)
			sampTextdrawSetPos(textdraw, defaultTextdrawPos[textdraw][1]+1000, defaultTextdrawPos[textdraw][2]+1000)
		end
	end

	if not areTextdrawsHidden then
		for _, textdraw in pairs(originalHUD) do
			if not sampTextdrawIsExists(textdraw) then return false end
			print("Showing: " .. textdraw)
			sampTextdrawSetPos(textdraw, defaultTextdrawPos[textdraw][1], defaultTextdrawPos[textdraw][2])
		end
	end
end

function sampev.onTogglePlayerSpectating(state)
  isPlayerSpecing = state
	
	if areTextdrawsHidden and state then
		toggleHUD()
	elseif not areTextdrawsHidden and not state then
		lua_thread.create(function()
			-- laggy players may consider increasing the delay
			wait(1000)
			toggleHUD()
		end)
	end
end

function sampev.onShowTextDraw(id, data)

	--[[ 
	-- Make boxes blend with the new hud
	--]]
	-- Hide useless decorations
	local vehicleMonitorBox = {1, 2, 3, 4, 5, 6}
	local lootRespawnBox = {110, 113, 112, 109}

	if isInArray(vehicleMonitorBox, id) or isInArray(lootRespawnBox, id) then
		sampTextdrawDelete(id)
		return false
	end

	-- Vehicle Monitor	
	if id == 0 then
		data['letterWidth'] = "0.2"
		data['letterHeight'] = "3.7999979972839"
		data['position'].y = 288
	end

	-- 2084 - Box on the left with Information about speced player
	if id == 0 or id == 2084 then
		data['boxColor'] = "2281701376"
	end

	-- Info about who joined, left or died should be a bit higher
	if id == 101 then
		data['position'].y = "417"
	end

	if isInArray(originalHUD, id) and areTextdrawsHidden then
		lua_thread.create(function()
			wait(2000)
			sampTextdrawSetPos(id, defaultTextdrawPos[id][1]+1000, defaultTextdrawPos[id][2]+1000) 
		end)
	end

	return {id, data}
end

function sampev.onSendSpawn() -- latest
	print("onSendSpawn")
	if firstSpawn then
		lua_thread.create(function()
			-- 3000 in case there's a lag
			wait(3000)
			toggleHUD()
		end)
		firstSpawn = false
	end
end

function kuzepro()
	if math.random(1,20) == 15 then
		sampSendChat("/r kuze pro")
	end
end

function sampev.onSetPlayerDrunk()
	kuzepro()
end