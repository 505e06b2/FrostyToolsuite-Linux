# FrostyToolsuite Linux

## Preface
This guide assumes that you will be running your game through Proton (bought on Steam) and are using Ubuntu 22.04. This is likely to work on most Linux distributions. The paths given are assuming Need for Speed Heat. To use another game, you will need to know the name of the game folder and gameid (this can be seen in the URL on the store page for the game). It will also likely require alternative scripts for execution and setting up the mod folder

## Verified Games
- [1222680] Need for Speed Heat

# Installation

## Prerequisites
- Basic commandline knowledge
- Familiarity with Linux paths
- Familiarity with launching games through Steam
- Download and run your game though Proton at least once to verify it works without modification. You will need to either enable the Compatibility settings under "Properties..." (Proton Experimental, etc) or enable "Steam Play for all titles" globally in your Steam settings. Find the path of your game folder as it will be useful in several steps. By default, this will be `$HOME/.steam/steam/steamapps/common/Need for Speed Heat/`. On an external drive, this will be elsewhere
- Find the location of the `compatdata` folder for this game. By default, this is `$HOME/.steam/steam/steamapps/compatdata/1222680/`. On an external drive, this will be elsewhere
- Download and extract the latest release of [Frosty Editor/Mod Manager](https://github.com/CadeEvs/FrostyToolsuite/releases) to an **empty folder**. The location of this is not particularly important, but it is a good idea to **not** put it in your game folder. Keep a note of this location for the next step
- Download the latest [Release](https://github.com/505e06b2/FrostyToolsuite-Linux/releases) - do not extract this yet

## Add Frosty to your Non-Steam game library
This step seemed to be required for the Frosty Editor to open as expected

1. Open Steam and, at the bottom, click "Add a game" > "Add a Non-Steam Game..."
1. Click "Browse..."
1. At the bottom of the dialog, change the "File Type" to "All Files"
1. Find and select the extracted Frosty executable, either "FrostyEditor.exe" or "FrostyModManager.exe"
1. Click "Open"
1. Open your Steam Library and find this new entry
1. Right click this entry, and open "Properties..."
1. It is likely a good idea to rename this Shortcut: in the textbox at the top, change the "*.exe" text to something more suitable
1. Under Shortcut, paste the following into the "Launch Options" textbox - if using an external drive, this will need to be altered to your custom path: `STEAM_COMPAT_DATA_PATH="$HOME/.steam/steam/steamapps/compatdata/1222680/" %command%`. You cannot use tilde (`~`) in the Steam launch settings, but you can use environment variables.
1. Under Compatibility, enable "Force the use of a specific Steam Play compatibility tool". Select the same Proton version as your game
1. Close the Properties dialog

## Create a ModData folder that works with Frosty
In the game folder, run the following command in the terminal:

*By default, the `[profile_name]` will be "Editor" (FrostyEditor) or "Default" (FrostyModManager) - you will need to know your Profile name ahead of time*

`mkdir -p ModData ModData/[profile_name]/patch ModData/[profile_name]/data`

You can also create these in a File Explorer, with the tree looking like:
```
ModData
    ┗ [profile_name]
        ┣ data
        ┗ patch
```

## Use Frosty to add a mod to your game folder
1. "Play" the Frosty Non-Steam game from your Steam Library
1. **If you attempt to "Scan for games", you will likely crash**
1. At the bottom, click "New"
1. Find your game executable ("NeedForSpeedHeat.exe") from the path noted in the prerequisites, you can follow a UNIX-style path from the `Z:\` drive letter, or on an external drive, you can find the root of it on one of the other drive letters
1. Select this new entry and click "Select", wait for the cache to build
1. Load a single mod into your profile (you can add more later) and Save
1. At the top of the window, click "Launch"
1. Once the dialog at the centre of the screen disappears, close Frosty
1. In Steam in the Library tab, "Stop" the Frosty Non-Steam game
1. If the game attempts to launch, stop it from the Library too

## Prepare the game for execution
1. In Steam, under the Library tab, right click the game and open "Properties..."
1. Under "Launch Options", paste the following into the textbox: `WINEDLLOVERRIDES="bcrypt=n,b" %command%`
1. Extract the contents of the downloaded release of this repo (`~/Downloads/FrostyLinux.tar.gz`) to your game folder (`$HOME/.steam/steam/steamapps/common/Need for Speed Heat/`). The game folder will be elsewhere if installed on an external drive
1. In the game folder, rename your game's executable by prepending "original_": `NeedForSpeedHeat.exe` -> `original_NeedForSpeedHeat.exe`
1. Rename `shim.exe` to the name of your the name that your game's executable had previously: `shim.exe` -> `NeedForSpeedHeat.exe`
1. Open the `setup_linuxmod*.sh` script in a text editor
1. Change the variable `FROSTY_PROFILE_PATH="ModData/Editor"` to the path of your profile. If you are using the Editor, you don't need to change this. If not, for example: `FROSTY_PROFILE_PATH="ModData/Default"` will be the default profile in the Mod Manager. This is case-sensitive
1. Save
1. Run the `setup_linuxmod*.sh` script: `./setup_linuxmod_nfs-heat.sh`. The working directory should not matter as the script `cd`s to the correct folder. As long as all errors look like `ln: failed to create symbolic link 'LinuxMod/patch/*': File exists`, this has succeeded
1. "Play" the game from Steam and cross your fingers :)

# Subsequent usage of Frosty
1. "Play" Frosty from Steam
1. Change the loaded mods in your Profile
1. Click the "Launch" button at the top of the window - after applying the mods, Frosty will crash as it does not have permission to delete `bcrypt.dll`. This is fine :)
1. From the game folder, execute `./setup_linuxmod*.sh` as done previously
1. "Play" your game from Steam

# Game Troubleshooting

## Issues with EA Play (No Steam overlay, crashes)
1. Download [OriginThinSetup](https://www.dm.origin.com/download) - [Forum Post](https://answers.ea.com/t5/Origin-Client-Web-Technical/Downloading-and-installing-Origin-Windows-and-Mac/m-p/11915666)
2. Set the STEAM_COMPAT_DATA_PATH and WINEPREFIX to your version, then execute the install:
```sh
export STEAM_COMPAT_DATA_PATH="$HOME/.steam/steam/steamapps/compatdata/1222680/"
export WINEPREFIX="$HOME/.steam/steam/steamapps/compatdata/1222680/pfx"

export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/steam"

#these 2 paths may be different if you use another Proton runtime or use a different downloads folder
~/.steam/steam/steamapps/common/Proton\ -\ Experimental/proton run ~/Downloads/OriginThinSetup.exe
```

## Controller not working
1. Open the Steam "Properties..." of the game
1. Open to the "Controller" tab
1. Change the dropdown to "Disable Steam Input"
