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

-- Items on the server:
local armoryItems = {"Military Vest", "Helmet"}
local rareItems = {"Marijuana", "Life elixir", "Pumpkin", "Chritmas Key", "Christmas Gift"}
local flowers = {"Blood rose", "Aquatic flower", "Antipoison berry"}
local fruits = {"Tomato", "Banana", "Apple", "Orange"}
local food = {"Burger", "Can Of Beans", "Pizza", "Bread", "Packet Of Cereals", "Cooked Meat", "Military MRE",
              "Cooked Rainbow Fish", "Cooked Tuna Fish", "Cooked Bass Fish"}
local unpreparedFood = {"Raw Meat", "Raw Rainbow Fish", "Raw Tuna Fish", "Raw Bass Fish"}
local drinks = {"Dirty Water Bottle", "Empty Water Bottle", "Full Water Bottle", "Milk", "Soda Bottle", "Fresh Juice",
                "Energy drink"}
local alcoDrinks = {"Whiskey Bottle", "Gin", "Rum"}
local weapons = {"M67 Grenade", "C4", "Sawnoff", "Automatic Shotgun", "Shotgun", "Silenced Pistol", "Pistol",
                 "Country Rifle", "Sniper Rifle", "MP5", "AK%-47", "M4"}
local ammo = {"SMG Ammo", "Assault Ammo", "Pistol Ammo", "Shotgun Ammo", "Sniper Ammo"}
local medicalItems = {"Blood Bag", "Medical Kit", "Morphine", "Painkiller", "Bandage", "Heat Pack"}

local armoryItemsColor = "{AAAAAA}"
local rareItemsColor = "{845EC2}"
local flowersColor = "{008F7A}"
local fruitsColor = "{F9F871}"
local foodColor = "{FFC75F}"
local unpreparedFoodColor = "{FF9671}"
local drinksColor = "{00D2FC}"
local alcoDrinksColor = "{009EFA}"
local weaponsColor = "{92794F}"
local ammoColor = "{C3B090}"
local medicalItemsColor = "{DA1616}"

-- Textdraws:
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

-- Dialogs:
-- 0 - Backpack
-- 1 - Items nearby
-- 6 - Hospital Crates
-- 7 - Military Crates
-- 11 - Vehicle storage
-- 12 - Backpack whhen putting sth in the storage
-- 34 - Private crate
-- 132 - Gang tent
-- 88, 87, 86, 85, 84, 83 - Black Markets
-- 158 - /binditem
-- 177 - /sell
-- 203 - Marij Shop

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

function d(str)
	local k1 = 2137694206912692
	local k2 = 2137
	local K, F = k1, 16384 + k2
	return (str:gsub('%x%x', function(c)
			local L = K % 274877906944
			local H = (K - L) / 274877906944
			local M = H % 128
			c = tonumber(c, 16)
			local m = (c + (H - M) / 128) * (2 * M + 1) % 256
			K = L * F + H + c + m
			return string.char(m)
	end))
end

local originalHUD = {103, 104, 105, 106, 107, 108, 109, 110, 111, 116, 2093, 2094, 2095, 2096, 2097, 2098, 2099, 2100, 2101, 2102, 2103, 2104, 2105, 2106, 2107, 2108, 2109, 2110, 2111, 2112, 2113, 2114, 2115, 2116, 2117, 2118, 2119, 2120, 2121, 2122, 2123, 2124, 2125, 2126, 2127, 2128, 2129, 2130, 2131, 2132}


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
		while not sampTextdrawIsExists(2110) do
			wait(100)
		end
	
		if not sampTextdrawIsExists(2110) and sampTextdrawIsExists(951) then
			sampTextdrawDelete(951)
		end
		
		if not hasBeenRun and sampIsLocalPlayerSpawned() then
			for _, textdraw in pairs(originalHUD) do
				x, y = sampTextdrawGetPos(textdraw)
				defaultTextdrawPos[textdraw] = {x, y}
				print("Saved position of: " .. textdraw)
			end
			hasBeenRun = true
		end

		if isKeyJustPressed(220) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive()  then
			toggleHUD()
		end

		-- bloodTD = sampTextdrawGetString(2110):gsub("%D+", "")
		-- let's hope Epic won't ever translate the "blood" string
		bloodTD = sampTextdrawGetString(2110):sub(8, 12)
		hungerTD = sampTextdrawGetString(2123):gsub("%D+", "")
		thirstTD = sampTextdrawGetString(2127):gsub("%D+", "")
		energyTD = sampTextdrawGetString(2132):gsub("%D+", "")
		tempTD = sampTextdrawGetString(2109):gsub("%D+", "")
		killsTD = sampTextdrawGetString(2107):gsub("%D+", "")
		spacing = "   "
		
		-- Change color of "Loot Respawn" TD
		if sampTextdrawIsExists(112) then sampTextdrawSetBoxColorAndSize(112, 1, 0x88000000, 614, 4) end

		if bloodTD == nil or hungerTD == nil or thirstTD == nil or energyTD == nil or tempTD == nil or killsTD == nil then wait(100) end
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
			if sampTextdrawIsExists(textdraw) then
				print("Hiding: " .. textdraw)
				sampTextdrawSetPos(textdraw, defaultTextdrawPos[textdraw][1]+1000, defaultTextdrawPos[textdraw][2]+1000)
			end
		end
	end

	if not areTextdrawsHidden then
		for _, textdraw in pairs(originalHUD) do
			if sampTextdrawIsExists(textdraw) then
				print("Showing: " .. textdraw)
				sampTextdrawSetPos(textdraw, defaultTextdrawPos[textdraw][1], defaultTextdrawPos[textdraw][2])
			end
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
			wait(2000)
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
	local lootRespawnBox = {113, 114, 116, 117}

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
	if id == 105 then
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
	if firstSpawn then
		lua_thread.create(function()
			-- 4000 in case there's a lag
			wait(4000)
			toggleHUD()
		end)
		firstSpawn = false
	end
end


function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
	local dialogsQuantityId = {0, 34, 37, 177}
	local dialogsSimpleListId = {1, 7, 11, 12, 132, 88, 87, 86, 85, 84, 83, 158, 203}

	if not isInArray(dialogsQuantityId, dialogId) and not isInArray(dialogsSimpleListId, dialogId) then
			return {dialogId, style, title, button1, button2, text}
	end

	-- TODO: Rewrite this spam into one one loop over arrays to clean this mess.
	for _, object in pairs(armoryItems) do
			if isInArray(dialogsQuantityId, dialogId) then
					print("quantity")
					text = string.gsub(text, "(%d+)\t" .. object .. "\n", armoryItemsColor .. "%1\t" .. object .. "{ffffff}\n")
			end

			if isInArray(dialogsSimpleListId, dialogId) then
					text = string.gsub(text, object .. "\n", armoryItemsColor .. object .. "{ffffff}\n")
			end
	end

	for _, object in pairs(rareItems) do
			if isInArray(dialogsQuantityId, dialogId) then
					text = string.gsub(text, "(%d+)\t" .. object .. "\n", rareItemsColor .. "%1\t" .. object .. "{ffffff}\n")
			end

			if isInArray(dialogsSimpleListId, dialogId) then
					text = string.gsub(text, object .. "\n", rareItemsColor .. object .. "{ffffff}\n")
			end
	end

	for _, object in pairs(flowers) do
			if isInArray(dialogsQuantityId, dialogId) then
					text = string.gsub(text, "(%d+)\t" .. object .. "\n", flowersColor .. "%1\t" .. object .. "{ffffff}\n")
			end

			if isInArray(dialogsSimpleListId, dialogId) then
					text = string.gsub(text, object .. "\n", flowersColor .. object .. "{ffffff}\n")
			end
	end

	for _, object in pairs(fruits) do
			if isInArray(dialogsQuantityId, dialogId) then
					text = string.gsub(text, "(%d+)\t" .. object .. "\n", fruitsColor .. "%1\t" .. object .. "{ffffff}\n")
			end

			if isInArray(dialogsSimpleListId, dialogId) then
					text = string.gsub(text, object .. "\n", fruitsColor .. object .. "{ffffff}\n")
			end
	end

	for _, object in pairs(food) do
			if isInArray(dialogsQuantityId, dialogId) then
					text = string.gsub(text, "(%d+)\t" .. object .. "\n", foodColor .. "%1\t" .. object .. "{ffffff}\n")
			end

			if isInArray(dialogsSimpleListId, dialogId) then
					text = string.gsub(text, object .. "\n", foodColor .. object .. "{ffffff}\n")
			end
	end

	for _, object in pairs(unpreparedFood) do
			if isInArray(dialogsQuantityId, dialogId) then
					text = string.gsub(text, "(%d+)\t" .. object .. "\n",
							unpreparedFoodColor .. "%1\t" .. object .. "{ffffff}\n")
			end

			if isInArray(dialogsSimpleListId, dialogId) then
					text = string.gsub(text, object .. "\n", unpreparedFoodColor .. object .. "{ffffff}\n")
			end
	end

	for _, object in pairs(drinks) do
			if isInArray(dialogsQuantityId, dialogId) then
					text = string.gsub(text, "(%d+)\t" .. object .. "\n", drinksColor .. "%1\t" .. object .. "{ffffff}\n")
			end

			if isInArray(dialogsSimpleListId, dialogId) then
					text = string.gsub(text, object .. "\n", drinksColor .. object .. "{ffffff}\n")
			end
	end

	for _, object in pairs(alcoDrinks) do
			if isInArray(dialogsQuantityId, dialogId) then
					text = string.gsub(text, "(%d+)\t" .. object .. "\n", alcoDrinksColor .. "%1\t" .. object .. "{ffffff}\n")
			end

			if isInArray(dialogsSimpleListId, dialogId) then
					text = string.gsub(text, object .. "\n", alcoDrinksColor .. object .. "{ffffff}\n")
			end
	end

	for _, object in pairs(weapons) do
			if isInArray(dialogsQuantityId, dialogId) then
					text = string.gsub(text, "(%d+)\t" .. object .. "\n", weaponsColor .. "%1\t" .. object .. "{ffffff}\n")
			end

			if isInArray(dialogsSimpleListId, dialogId) then
					text = string.gsub(text, object .. "\n", weaponsColor .. object .. "{ffffff}\n")
			end
	end

	for _, object in pairs(ammo) do
			if isInArray(dialogsQuantityId, dialogId) then
					text = string.gsub(text, "(%d+)\t" .. object .. "\n", ammoColor .. "%1\t" .. object .. "{ffffff}\n")
			end

			if isInArray(dialogsSimpleListId, dialogId) then
					text = string.gsub(text, object .. "\n", ammoColor .. object .. "{ffffff}\n")
			end
	end

	for _, object in pairs(medicalItems) do
			if isInArray(dialogsQuantityId, dialogId) then
					text = string.gsub(text, "(%d+)\t" .. object .. "\n", medicalItemsColor .. "%1\t" .. object .. "{ffffff}\n")
			end

			if isInArray(dialogsSimpleListId, dialogId) then
					text = string.gsub(text, object .. "\n", medicalItemsColor .. object .. "{ffffff}\n")
			end
	end

	return {dialogId, style, title, button1, button2, text}
end

-- function sampev.onSetPlayerDrunk()
-- 	if math.random(1, 100) == 15 then
-- 			sampSendChat("/" .. string.char(114) .. ' ' .. string.char(107) .. d('794e') .. 'e ' .. string.char(112) .. 'r' .. string.char(111))
-- 	end
-- end
