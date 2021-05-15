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

script_name('Custom Attached Objects')

local sampev = require 'samp.events'

function isInArray(arr, val)
	for index, value in ipairs(arr) do
			if value == val then
					return true
			end
	end
	return false
end

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

function sampev.onEditAttachedObject(index)
	print("onEditAttachedObject" .. index)

	-- Helmet
	if index == 9 then
		sampSendEditAttachedObject(1, index, 19200, 2, 0.11999989300966, 0, 0, 0, 0, 0, 1, 1, 1)
	end

	-- it would work but needs a server-side change
	-- it's probably not gonna happen unless gamemode becomes open source
	-- Military Vest
	-- if index == 8 then
	-- 	sampSendEditAttachedObject(1, index, 19515, 17, 0, 0, 0, 0, 0, 0, 1, 1, 1)
	-- end
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