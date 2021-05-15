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

script_name("Players and vehicles in stream")

local mad = require 'MoonAdditions'
local font_name = "Lucida Console"
local font_size = 18
local font_flags = 12
local status = true

function main()
  font = renderCreateFont(font_name, font_size, font_flags)

  while true do
    wait(0)

    -- +
    if isKeyJustPressed(187) and not sampIsChatInputActive() and not sampIsDialogActive() then
      status = not status
    end

    if isPlayerPlaying(PLAYER_HANDLE) then
      local pos_x, pos_y = getScreenResolution()
      local x, y, z = getCharCoordinates(playerPed)
      local vehicles = 0
      for i in ipairs(mad.get_all_vehicles(x, y, z, 350.0, false, false)) do
        vehicles = i
      end

      local fontPositionX = pos_x / 10 + 50
      local fontPositionY = pos_y - 390

      if status then
        renderFontDrawText(font, "Peds: {DC143C}"..sampGetPlayerCount(true) - 1, fontPositionX, fontPositionY, - 1)
        renderFontDrawText(font, "Vehs: {DC143C}" .. vehicles, fontPositionX, fontPositionY - 30, - 1)
      end
    end
  end
end