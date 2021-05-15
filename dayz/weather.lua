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

script_name('Static Weather')

local sampev = require 'samp.events'

local enabled = true
local customWeather = 3
local customHour = 12
local customMinute = 0

local serverWeather = 0
local serverHour = 0
local serverMinute = 0


function main()
	sampRegisterChatCommand("st", cmdSetTime)
	sampRegisterChatCommand("sw", cmdSetWeather)
	while true do
		wait(0)
		if not isPlayerPlaying(PLAYER_HANDLE) then wait(100) end

		-- "-"
		if isKeyJustPressed(189) and not sampIsChatInputActive() and not sampIsDialogActive() then
			enabled = not enabled
		end

		if enabled then
			forceWeatherNow(customWeather)
			setTimeOfDay(customHour, customMinute)
		else
			print("Setting server weather - " .. serverWeather)
			print("Setting server time - " .. serverHour .. ":" .. serverMinute)
			forceWeatherNow(serverWeather)
			setTimeOfDay(serverHour, serverMinute)
		end

		if enabled then
    end

	end
end

function cmdSetTime(param)
  local hour = tonumber(param)
  if hour ~= nil and hour >= 0 and hour <= 23 then
    customHour = hour
  end
end

function cmdSetWeather(param)
  local weatherid = tonumber(param)
  if weatherid ~= nil and weatherid >= 0 then
    customWeather = weatherid
	end
end

function sampev.onSetWeather(weatherId)
	serverWeather = weatherId
end

function sampev.onSetPlayerTime(hour, minute)
	serverHour = hour
	serverMinute = minute
end