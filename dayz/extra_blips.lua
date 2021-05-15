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

script_name('Extra blips')

local treeMarker = {}
local safeMarker = {}
local militarycratesMarker = {}
local coffinsMarker = {}
local hospitalsMarker = {}
local campfiresMarker = {}
local binsMarker = {}

function main()
	while true do
		wait(0)
		if not isPlayerPlaying(PLAYER_HANDLE) then return end

		local trees = { -- 21
			{ x = "695.46", y = "358.06", z = "22.56" }, 
			{ x = "1614.47", y = "-645.37", z = "71.22" }, 
			{ x = "-1758.21", y = "-1367.40", z = "71.94" }, 
			{ x = "-1623.87", y = "-1543.67", z = "38.03" },
			{ x = "2057.31", y = "-763.53", z = "117.33" },
			{ x = "2415.48", y = "-768.96", z = "118.31" },
			{ x = "2267.14", y = "-616.55", z = "133.55" },
			{ x = "2450.64", y = "-622.98", z = "120.17" },
			{ x = "2568.04", y = "-430.69", z = "80.38" },
			{ x = "2607.24", y = "-269.38", z = "44.76" },
			{ x = "2614.48", y = "-40.25", z = "43.79" },
			{ x = "2574.63", y = "134.36", z = "31.37" },
			{ x = "2294.95", y = "381.59", z = "28.32" },
			{ x = "2271.35", y = "256.72", z = "19.23" },
			{ x = "2050.15", y = "195.05", z = "16.44" },
			{ x = "1771.05", y = "329.52", z = "19.27" },
			{ x = "1710.41", y = "181.20", z = "27.06" },
			{ x = "1694.49", y = "64.57", z = "29.35" },
			{ x = "1349.43", y = "111.35", z = "24.54" },
			{ x = "1455.49", y = "-61.79", z = "21.29" },
			{ x = "1325.53", y = "-133.59", z = "28.52" },
			{ x = "1052.19", y = "-64.18", z = "87.32" },
			{ x = "1169.15", y = "334.08", z = "22.93" },
			{ x = "796.26", y = "4.48", z = "64.78" },
			{ x = "959.89", y = "-331.93", z = "64.19" },
			{ x = "478.73", y = "-61.17", z = "25.14" },
			{ x = "432.83", y = "91.32", z = "10.08" },
			{ x = "-563.51", y = "195.53", z = "13.24" },
			{ x = "-331.28", y = "-22.17", z = "44.59" },
			{ x = "-670.59", y = "-96.67", z = "64.72" },
			{ x = "-1080.62", y = "-539.84", z = "32.36" },
			{ x = "-838.18", y = "-548.23", z = "37.94" },
			{ x = "-567.40", y = "-447.45", z = "32.39" },
			{ x = "-382.12", y = "-585.17", z = "11.90" },
			{ x = "-822.14", y = "-657.92", z = "127.20" },
			{ x = "-242.71", y = "-861.62", z = "31.59" },
			{ x = "-540.80", y = "-1147.09", z = "27.37" },
			{ x = "134.29", y = "-841.78", z = "21.88" },
			{ x = "0.88", y = "-1051.65", z = "22.30" },
			{ x = "-38.00", y = "-1274.50", z = "6.97" },
			{ x = "-261.18", y = "-1216.55", z = "8.03" },
			{ x = "-393.76", y = "-1474.66", z = "26.07" },
			{ x = "-908.88", y = "-1857.87", z = "88.95" },
			{ x = "-1099.85", y = "-1709.69", z = "76.72" },
			{ x = "-813.88", y = "-1637.35", z = "120.62" },
			{ x = "-875.06", y = "-1387.11", z = "130.09" },
			{ x = "-1044.20", y = "-1092.51", z = "129.57" },
			{ x = "-1184.86", y = "-1082.46", z = "129.57" },
			{ x = "-1303.79", y = "-1101.11", z = "173.30" },
			{ x = "-1393.41", y = "-945.44", z = "199.75" },
			{ x = "-1730.76", y = "-1127.89", z = "64.53" },
			{ x = "-1685.90", y = "-1969.42", z = "102.35" },
			{ x = "-1820.66", y = "-2015.41", z = "78.96" },
			{ x = "-1387.27", y = "-2283.54", z = "39.07" },
			{ x = "-2138.23", y = "-2072.58", z = "63.34" },
			{ x = "-2469.41", y = "-2268.07", z = "21.26" },
			{ x = "-2455.30", y = "-2620.26", z = "68.96" },
			{ x = "-2030.62", y = "-2708.02", z = "66.18" }
		}

		
		local blackmarkets = { -- it already has an icon
			{ x = "1410.5718", y = "2101.4583", z = "0" },
			{ x = "-1681.2639", y = "1048.8179", z = "0" },
			{ x = "1525.6396", y = "-1460.1410", z = "0" },
		}

		local safes = { -- 52
			{ x = "-2400.05518", y = "2356.59546", z = "0" },
			{ x = "-135.23422", y = "1068.15198", z = "0" },
			{ x = "1446.33020", y = "1913.63245", z = "0" },
			{ x = "2576.22388", y = "784.51251", z = "0" },
			{ x = "2795.91284", y = "-1078.04456", z = "0" },
			{ x = "2583.67700", y = "-2054.45898", z = "0" },
			{ x = "1173.54163", y = "-1876.82922", z = "0" },
			{ x = "173.55002", y = "-1763.50549", z = "0" },
			{ x = "-2188.10498", y = "-2419.36426", z = "0" },
			{ x = "-2189.56860", y = "-256.97339", z = "0" },
			{ x = "-2766.53467", y = "375.57330", z = "0" },
			{ x = "-2542.10205", y = "1214.28650", z = "0" }
		}

		local militarycrates = { -- 6
			{ x = "-2182.6394", y = "-2433.3625", z = "0" },
			{ x = "1552.5570", y = "-1638.4117", z = "0" },
			{ x = "2779.3743", y = "-2426.4890", z = "0" },
			{ x = "-2842.9692", y = "2797.2097", z = "0" },
			{ x = "2225.3193", y = "2449.8845", z = "0" },
			{ x = "2591.4163", y = "2800.9719", z = "0" },
			{ x = "-1647.2567", y = "655.0960", z = "0" },
			{ x = "274.4774", y = "1886.9146", z = "0" },
			{ x = "-1929.68", y = "145.79", z = "0" },
			{ x = "-1315.18", y = "509.25", z = "0" },
			{ x = "-1388.0", y = "325.04", z = "0" }
		}

		local coffins = { -- 23
			{ x = "-2220.50269", y = "-2304.04761", z = "0" },
			{ x = "2445.14478", y = "1288.24207", z = "0" },
			{ x = "2500.33423", y = "923.76666", z = "0" },
			{ x = "2257.73145", y = "-1313.48804", z = "0" },
			{ x = "-2473.66211", y = "2404.99609", z = "0" },
			{ x = "-2666.82227", y = "-5.49817", z = "0" }
		}

		local hospitals = { -- 22
			{ x = "-2209.2710", y = "-2311.6926", z = "0" },
			{ x = "2023.5582", y = "-1405.0769", z = "0" },
			{ x = "2036.0295", y = "-1404.5823", z = "0" },
			{ x = "1179.2520", y = "-1327.7645", z = "0" },
			{ x = "1179.0232", y = "-1319.0414", z = "0" },
			{ x = "-1514.4979", y = "2521.6721", z = "0" },
			{ x = "2624.2917", y = "-1360.1255", z = "0" },
			{ x = "-2668.2903", y = "636.6271", z = "0" },
			{ x = "-2639.6472", y = "636.2640", z = "0" },
			{ x = "1615.5638", y = "1817.7030", z = "0" },
			{ x = "1599.5947", y = "1817.7300", z = "0" },
			{ x = "-314.7439", y = "1051.8927", z = "0" },
			{ x = "-325.9240", y = "1051.6086", z = "0" },
			{ x = "1245.3959", y = "326.4455", z = "0" },
			{ x = "1238.7815", y = "328.9627", z = "0" }
		}

		local campfires = { -- 56
			{ x = "-1866.92578", y = "-1566.61060", z = "0" },
			{ x = "-2068.26147", y = "2559.35718", z = "0" },
			{ x = "-1308.20959", y = "2544.43848", z = "0" },
			{ x = "-2479.15308", y = "2491.17944", z = "0" },
			{ x = "-1953.45984", y = "1500.21423", z = "0" },
			{ x = "-2488.47266", y = "-717.38275", z = "0" },
			{ x = "-394.15683", y = "-1149.84558", z = "0" },
			{ x = "2635.29712", y = "-1944.67139", z = "0" },
			{ x = "-1124.43396", y = "-590.22479", z = "0" },
			{ x = "2828.87720", y = "2928.94727", z = "0" },
			{ x = "-631.71472", y = "1449.69055", z = "0" },
			{ x = "-897.29291", y = "1970.34192", z = "0" },
			{ x = "155.24248", y = "-1959.34851", z = "0" },
			{ x = "869.11194", y = "-1067.90540", z = "0" },
			{ x = "-553.05005", y = "-181.28198", z = "0" },
			{ x = "1429.57605", y = "337.41458", z = "0" },
			{ x = "268.89285", y = "2895.24390", z = "0" },
			{ x = "815.02136", y = "855.79755", z = "0" },
			{ x = "2270.65942", y = "59.84597", z = "0" },
			{ x = "1049.0466", y = "2549.5850", z = "0" }
		}

		local bins = { -- 37
			{ x = "-1888.67603", y = "-1595.12341", z = "0" },
			{ x = "-2141.77954", y = "-2445.53003", z = "0" },
			{ x = "-1122.22644", y = "-1615.55627", z = "0" },
			{ x = "-1515.13013", y = "2568.20801", z = "0" },
			{ x = "-2636.58740", y = "2386.86133", z = "0" },
			{ x = "-345.77634", y = "-1035.39819", z = "0" },
			{ x = "-2483.34180", y = "2294.87988", z = "0" },
			{ x = "-866.93127", y = "1534.45227", z = "0" },
			{ x = "-219.39870", y = "2725.22583", z = "0" },
			{ x = "-22.85139", y = "-1121.18262", z = "0" },
			{ x = "1116.93396", y = "-301.95041", z = "0" },
			{ x = "1458.14111", y = "-609.29651", z = "0" },
			{ x = "136.64958", y = "-325.33881", z = "0" },
			{ x = "1426.30579", y = "268.88211", z = "0" },
			{ x = "1254.84802", y = "240.86600", z = "0" },
			{ x = "-17.62310", y = "1224.45874", z = "0" },
			{ x = "590.89642", y = "1231.99341", z = "0" },
			{ x = "1568.76001", y = "16.44603", z = "0" },
			{ x = "206.68097", y = "-5.40676", z = "0" },
			{ x = "2319.78027", y = "1.69281", z = "0" }
		}
		-- Converting it to a huge array would allow to take care of it with only 1 loop
		-- but it would also became a little bit less readable. Something to consider in the future.
		-- It's not like it takes a lot of resources anyway.
		
		for tree in pairs(trees) do
			if not doesBlipExist(treeMarker[tree]) then
				treeMarker[tree] = addShortRangeSpriteBlipForCoord(trees[tree].x, trees[tree].y, trees[tree].z, 21)
			end
		end

		for safe in pairs(safes) do
			if not doesBlipExist(safeMarker[safe]) then
				safeMarker[safe] = addShortRangeSpriteBlipForCoord(safes[safe].x, safes[safe].y, safes[safe].z, 52)
			end
		end

		for militarycrate in pairs(militarycrates) do
			if not doesBlipExist(militarycratesMarker[militarycrate]) then
				militarycratesMarker[militarycrate] = addShortRangeSpriteBlipForCoord(militarycrates[militarycrate].x, militarycrates[militarycrate].y, militarycrates[militarycrate].z, 6)
			end
		end

		for coffin in pairs(coffins) do
			if not doesBlipExist(coffinsMarker[coffin]) then
				coffinsMarker[coffin] = addShortRangeSpriteBlipForCoord(coffins[coffin].x, coffins[coffin].y, coffins[coffin].z, 23)
			end
		end

		for hospital in pairs(hospitals) do
			if not doesBlipExist(hospitalsMarker[hospital]) then
				hospitalsMarker[hospital] = addShortRangeSpriteBlipForCoord(hospitals[hospital].x, hospitals[hospital].y, hospitals[hospital].z, 22)
			end
		end

		for campfire in pairs(campfires) do
			if not doesBlipExist(campfiresMarker[campfire]) then
				campfiresMarker[campfire] = addShortRangeSpriteBlipForCoord(campfires[campfire].x, campfires[campfire].y, campfires[campfire].z, 56)
			end
		end

		for bin in pairs(bins) do
			if not doesBlipExist(binsMarker[bin]) then
				binsMarker[bin] = addShortRangeSpriteBlipForCoord(bins[bin].x, bins[bin].y, bins[bin].z, 37)
			end
		end
	end
end
