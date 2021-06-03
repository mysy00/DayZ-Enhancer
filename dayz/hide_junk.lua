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

script_name('Debloat the server')

local sampev = require 'samp.events'
local encoding = require 'encoding'
local u8 = encoding.UTF8

local chatFilters = {
  "^{12afed}%[EpicBot%]",
  "^{00FF00}Started searching for loot, please wait.",
  "^{FF0000}This vehicle has already been looted.",
  "^{00FF00}%[AUTO SAVE%]",
  "^{FF00FE}%[DOUBLE XP%]",
  "^{b13a3a}%[ACHIEVEMENT%]",
  "^{e600e6}%[WEEKEND BONUS%]",
  "^{12afed}%[GANG AD%]",
  "^{00FF00}Helmet has been equipped, headshot damage is now reduced by 50 percent.",
  "^{00FF00}Military Vest has been equipped, body damage is now reduced by 50 percent.",
  "^{00FF00}You can replace your Military Vest using /editvest",
  "^{ffff33}%*%* Press N to pick up item, press Y to open your inventory",
  "^{00FF00}Showing gang member locations has been enabled."
}

function sampev.onCreate3DText(id, color, position, distance, testLOS, attachedPlayerId, attachedVehicleId, text)
  if text:match("Press (.*) to view storage") then
    sampDestroy3dText(id)
    return false
  end

  if text == "Vehicle" then
    sampDestroy3dText(id)
    return false
  end
end

function sampev.onServerMessage(color, msg)
  for _, filter in pairs(chatFilters) do
    if msg:match(u8:decode(filter)) then print("FILTERED: " .. msg) return false end
  end
end