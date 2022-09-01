-- Copyright (C) 2022 Mysy00

-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

script_name('Dayz Enhancer')
script_version("20220830")

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
