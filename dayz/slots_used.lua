-- Copyright (C) 2022 Mysy00

-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

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