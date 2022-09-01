-- Copyright (C) 2022 Mysy00

-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

script_name('Bike macro')

function isKeyCheckAvailable()
	return not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive()
end

local bike = {[481] = true, [509] = true, [510] = true}

function main()
	while true do
	wait(0)
		-- Left shift
		if isCharInAnyCar(PLAYER_PED) then
			if bike[getCarModel(storeCarCharIsInNoSave(playerPed))] and isCharOnAnyBike(playerPed) and isKeyCheckAvailable() and isKeyDown(0xA0) then
					setGameKeyState(16, 255)
					wait(10)
					setGameKeyState(16, 0)
			end
		end
	end
end