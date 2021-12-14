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

script_name('Simpler Textdraws (coins submodule)')

local mem = require("memory")
local sampev = require 'samp.events'
local coins = 0

function renderCoins()
    sampTextdrawCreate(952, "COINS: " .. coins, 553.5, 80)
    sampTextdrawSetStyle(952, 2)
    sampTextdrawSetAlign(952, 2)
    sampTextdrawSetBoxColorAndSize(952, 1, 0x88000000, 0, 121.5)
    sampTextdrawSetLetterSizeAndColor(952, 0.17000000178814, 1.0, 0xFFFFFFFF)
    sampTextdrawSetOutlineColor(952, 1, 0x00000000)
end

function main()
    while not isSampAvailable() do
        wait(100)
    end
    if not isSampfuncsLoaded() or not isSampLoaded() then
        print("Disabling " .. script_name .. ", error loading dependencies")
        sampAddChatMessage("Disabling " .. script_name .. ", error loading dependencies")
        return false
    end

    while true do
        wait(30000)
        if not sampTextdrawIsExists(2109) then
            wait(100)
        end

        sampSendChat("/coins")
        renderCoins()
    end
end

function sampev.onServerMessage(color, msg)
    -- {00FF00}You currently have 19 coins
	if msg:match("{00FF00}You currently have ") or msg:match("{00FF00}Voce tem ") or msg:match("{00FF00}Actualmente tienes ") or msg:match("{00FF00}У вас ") then
        coins = msg:gsub('%{(.*)%}', ""):match('%d+')
        return false
    end

    if msg:match("%{ffff33%}%*%* Welcome to GTA:SA DayZ Remastered") then
        mem.write(0x58F5FC, 0, 1, true) -- hide money

        lua_thread.create(function()
            wait(1000)
            sampSendChat("/coins")
            wait(100)
            renderCoins()
        end)
    end
end
