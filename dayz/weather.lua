-- Copyright (C) 2022 Mysy00

-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

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