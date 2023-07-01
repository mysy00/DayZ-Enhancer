# DayZ Enhancer

DayZ Enhancer is a collection of scripts to enhance the gameplay on a SA:MP DayZ server.

## Dependencies

- Moonloader
  - Samp Events (tick the box to install it during Moonloader installation)
  - Moon Additions (tick the box to install it during Moonloader installation)
  - SAMPFUNCS Integration (tick the box to install it during Moonloader installation)
- SAMPFUNCS 5.4.1
- CLEO4
- Asi Loader

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
- dayz/simple_td.lua
  - In the past it used to provide custom HUD (textdraws) for the server. Currently that's been dropped. It requires me to update textdraw IDs each updates and sadly I don't have time for that. I will ship it instead as a server-sided feature in the future.
  - As for now, this mod colorizes items in your inventory, so you can find items easily.
- dayz/attached_objects.lua
  - If you want to equip a helmet or military vest, it will be placed automatically. It may require a slight change for your skin. If you don't know how to do it, create an issue or just let me know.
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

## Common Issues

**I can't download Moonloader**\
Open gtaforums in Firefox. If you want to use a chromium-basec browser (google chrome, edge, brave etc), you can click the download link with RMB and then click on the "Open in a new incognito tab".

**I'm getting "Invalid textdraw position"**\
One of your mods is causing this. I haven't had this issue myself, so I can't narrow it down to a certain mod. All I can say is some Russian lua mods are known to cause such issue. In theory I could fix it by changing the way I hide default textdraws but I'm too busy with other stuff to take care of it.

**It doesn't work, I don't see any error on the chat**\

- You are most likely lacking of a dependency which I've listed above
- It's possible you're using a wrong version of SAMPFUNCS

**Nothing works, not even cleo and some of my asi mods**\
Install: https://www.microsoft.com/en-us/download/details.aspx?id=8109

**I still can't get it to work**\
Open a new issue and upload your `moonloader.log`. You can also send me a DM on Discord - `@mysy00` but GH Issue is the recommended way.

## Contributing

Pull requests are welcome. If you would like for something to get added and you don't know lua, please create an issue.

## License

[Mozilla Public License 2.0](http://mozilla.org/MPL/2.0/)
