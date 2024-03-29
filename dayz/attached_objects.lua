-- Copyright (C) 2022 Mysy00

-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

script_name('Custom Attached Objects')

local sampev = require 'samp.events'
local tempObject = ""

function isInArray(arr, val)
	for index, value in ipairs(arr) do
			if value == val then
					return true
			end
	end
	return false
end

function sampev.onEditAttachedObject(index)
	print("onEditAttachedObject" .. index)

	-- Helmet
	if index == 9 and tempObject == "" then
		sampSendEditAttachedObject(1, index, 19200, 2, 0.11999989300966, 0, 0, 0, 0, 0, 1, 1, 1)
		setVirtualKeyDown(27, true)
	end
	
	-- Military Vest
	-- It's scalled to 0, so it's invisible and doesn't get in your way while aiming.
	if index == 8 then
		sampSendEditAttachedObject(1, index, 19515, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0)
		setVirtualKeyDown(27, true)
	end
end

function sampev.onSendDialogResponse(dialogId, button, listboxId, input)
	if tostring(dialogId) == "209" then
		lua_thread.create(function()
			tempObject = input
      wait(1000)
      tempObject = ""
		end)
	end
end

function sampev.onSetPlayerAttachedObject(playerId, index, created, data)
	local result, _id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local objectsToRemove = {371, 1550, 3026, 19559}

	if isInArray(objectsToRemove, data.modelId) and playerId == _id then
		return false
	end

	if playerId == _id and isKeyDown(0x02) and isCurrentCharWeapon(PLAYER_PED, 34) then
		data["scale"].x = "0"
		data["scale"].y = "0"
		data["scale"].z = "0"
	end

	-- sniper
	if data.modelId == 358 then
		data["offset"].x = "-0.2110000026226"
		data["offset"].y = "-0.10099991410971"
		data["offset"].z = "-0.21999989056587"

		data["rotation"].x = "0"
		data["rotation"].y = "5"
		data["rotation"].z = "5"
	end

	-- m4
	if data.modelId == 356 then
		data["offset"].x = "-0.09"
		data["offset"].y = "-0.073999996781349"
		data["offset"].z = "0.0230000037513673"

		data["rotation"].x = "0"
		data["rotation"].y = "0"
		data["rotation"].z = "0"
	end

	return {playerId, index, created, data}
end
