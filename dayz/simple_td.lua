-- Copyright (C) 2022 Mysy00

-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

script_name('Simpler Textdraws')

local sampev = require 'samp.events'

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
local weapons = {"M67 Grenade", "C4", "Sawnoff", "Automatic Shotgun", "Shotgun", "Silenced Pistol", "Pistol", "Desert Eagle",
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
