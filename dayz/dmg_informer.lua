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

script_name('Info about the last damager')

local sampev = require 'samp.events'

weapons = {
	[0] = "Fist", 
	[1] = "Brass knuckles",
	[2] = "Golf club",
	[3] = "Nitestick",
	[4] = "Knife",
	[5] = "Baseball bat",
	[6] = "Shovel",
	[7] = "Pool cue",
	[8] = "Katana",
	[9] = "Chainsaw",
	[10] = "Dildo",
	[11] = "Dildo 2",
	[12] = "Vibrator",
	[13] = "Vibrator 2",
	[14] = "Flowers",
	[15] = "Cane",
	[16] = "Granade",
	[17] = "Teargas",
	[18] = "Molotov",
	[19] = "Vehicle M4",
	[20] = "Vehicle minigun",
	[21] = "",
	[22] = "Pistol",
	[23] = "Silenced",
	[24] = "Deagle",
	[25] = "Shotgun",
	[26] = "Sawn-off",
	[27] = "Combat shotgun",
	[28] = "Uzi",
	[29] = "MP5",
	[30] = "AK-47",
	[31] = "M4",
	[32] = "Tec9",
	[33] = "Cuntgun",
	[34] = "Sniper rifle",
	[35] = "RPG",
	[36] = "Bazooka",
	[37] = "Flamethrower",
	[38] = "Minigun",
	[39] = "C4",
	[40] = "Detonator",
	[41] = "Spray can",
	[42] = "Fire extinguisher",
	[43] = "Camera",
	[44] = "Nigh vision",
	[45] = "Thermal googles",
	[46] = "Parachute",
	[47] = "Fake pistol",
	[49] = "Vehicle",
	[51] = "Explosion",
	[53] = "Drowned",
	[54] = "Collision",
	[200] = "Connect",
	[201] = "Disconnect",
}

function sampev.onSendTakeDamage(playerID, damage, weaponID, bodypart)
	if playerID ~= 65535 then
    nickname = sampGetPlayerNickname(playerID) .. "({FF6666}" .. playerID .. "{FF0000})"
  else
    nickname = "Server"
  end

	-- Server has a limit of symbols. If player's nickname is too long, the message will be shorten by the server.
  sampAddChatMessage("{FFFFFF}Weapon:{FF0000} " .. weapons[weaponID] .. "({FF6666}" .. weaponID .. "{FF0000})" .. "{FFFFFF}, Player:{FF0000} " .. nickname .. "{FFFFFF}, Damage:{FF0000} " .. damage)
end