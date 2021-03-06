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

script_name('Dayz Enhancer')
script_version("20220104")

local ALLOWED_SERVER_IP = "151.80.47.38"

function loadScripts()
  import "dayz/attached_objects.lua"
  import "dayz/bike_macro.lua"
  import "dayz/dmg_informer.lua"
  import "dayz/extra_blips.lua"
  import "dayz/hide_junk.lua"
  import "dayz/simple_td.lua"
  --import "dayz/simple_td_coins.lua"
  import "dayz/slots_used.lua"
  import "dayz/weather.lua"
end

function main()
	while not isSampAvailable() do wait(100) end
	if not isSampfuncsLoaded() or not isSampLoaded() then
		print("Disabling ".. script_name ..", error loading dependencies")
		sampAddChatMessage("Disabling ".. script_name ..", error loading dependencies")
		return false
	end

  local currentIp, currentPort = sampGetCurrentServerAddress()
  if currentIp == ALLOWED_SERVER_IP then
    lua_thread.create(function()
        while not sampTextdrawIsExists(2109) do wait(100) end
        wait(10 * 1000)
        sampSendChat("/dayzenhancer running " .. thisScript().version)
      end)
    print("Loading scripts")
    loadScripts()
  end
end
