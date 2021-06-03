# DayZ Enhancer

DayZ Enhancer is a collection of scripts to enhance the gameplay on a SA:MP DayZ server.

## Dependencies

- Moonloader
  - Samp Events (tick the box to install it during Moonloader installation)
  - Moon Additions (tick the box to install it during Moonloader installation)
- SAMPFUNCS

## Installation

1. Get the scripts by downloading the zip

- Click the "Code" button
- Click "Download ZIP"

or by cloning the repo

```sh
git clone https://github.com/mysy00/DayZ-Enhancer.git
```

2. Copy extracted files to your moonloader directory.

## Usage

- DayzEnhancer.lua
  - Used to load modules (files in dayz folder). If you want to disable a module, you can either remove the whole line with `import` or add `--` in front of it.
- dayz/attached_objects.lua
  - If you want to equip a helmet, it will be placed automatically. It may require a slight change for your skin. If you don't know how to do it, create an issue or just let me know.
  - Custom position for m4 and sniper (aka walkie-talkie)
  - Your backpack is invisible (it may be annoying if you aren't VIP)
- dayz/dmg_informer.lua
  - Whenever your ped deals any damage and server is aware of it, you will see a message on the chat giving you some info about it (who gave you damage, what weapon was it and when (timestamp)). It's useful to catch aimbotters.
- dayz/weather.lua
  - By default on connect your weather is set to id 3 and time to 12:00.
  - Set custom weather by /sw
  - Set custom time by /st
  - Press `-` to check what's the weather on the server (works only if it had been changed when you were online)
- dayz/slots_used.lua
  - Shows number of currently streamed peds and vehicles
  - Press `+` to toggle it
- dayz/extra_blips.lua
  - Whenever you are close to a tree with fruits, searchable bin, coffin, safe, hospital or a military crate, you can see an icon on the map indicating it. If you see it once, you will be able to see it on the map till you leave the game
- dayz/hide_junk.lua
  - DayZ Debloater. Remove useless bloat, such as:
    - "Press key to view storage" on vehicles
    - EpicBot info for new players
    - "Started searching for loot, please wait"
    - "This vehicle has already been loted"
    - auto save
    - double xp
    - achievements
    - weekend bonus
    - gang ads
    - Info about equipping helmet/military vest
    - "Showing gang member locations has been enabled"
    - "Press N to pick up item, press Y to open your inventory" when joining the server
  - dayz/bike_macro.lua
    - Hold left shift to ride your bike quickly. Useful if your roommates are asleep and you want to play samp. It doesn't give you any advantages in terms of speed.

## Contributing

Pull requests are welcome. If you would like for something to get added and you don't know lua, please create an issue.

## License

[GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html)
