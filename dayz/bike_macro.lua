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