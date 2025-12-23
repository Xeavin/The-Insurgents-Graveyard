# The Insurgent's Graveyard
A collection of FFXII scripts that were either requested and created for others, or are too niche to be included in any of my other mods.

## Scripts
The following features are available both as a Lua script (Steam) and as a cheat table (Steam/Microsoft Store).

The former works automatically once installed where as the latter needs to be run manually after every game launch.

### Fixed MP Regeneration
Multiplies the number of steps necessary to gain 1 MP by the speed mode multiplier. So it is no longer possible to exploit the speed-mode by running around in circles to regain a lot of MP.

### Forced Keyboard Button Prompts
Forces the game to always use keyboard button prompts, as long as no controller is used.

### Forced PS Button Prompts
Forces the game to always use PS button prompts, regardless of the type of controller used.

### Forced Xbox Button Prompts
Forces the game to always use XBOX button prompts, regardless of the type of controller used.

### Lift Story Restrictions
Allows the usage of the following things from the start of the game: Party-, equipment-, licenses- and gambits menu, world and minimap, clan primer and much more.

### No Restoration On Save Crystals
Touching save crystals will no longer restore HP, MP, etc. or remove any negative status effects.

### No Overlay Map
Disables the overlay map which would displayed in the middle of the screen after pressing/clicking the Tab/L3/LS key/button.

### No Mist Bar Restoration On Save Crystals
Touching save crystals will no longer restore mist bars. Furthermore, mist bars will not be restored after a cutscene that initiates a boss battle.

### No Overhead Party HP Bars
Removes the overhead HP bars of the party.

### No Overhead Foe HP Bars
Removes the overhead HP bars of foes (incl. friendly).

### No Sounds
Disables all sound input from the game. It's mostly meant to be used when modding, so you don't have to constantly adjust the sound settings per savefile, nor get your ear blasted every time you enter the main menu.

### No Speed Mode
Disables the ability to toggle the speed mode feature of the game.

### No Teleport Requirement
Teleport stones are no longer required when using the save crystal teleport option.

### Removable Targeted Party Members
Enables the ability to remove any targeted party members from the party.

## Installation/Updating/Uninstallation (Lua Scripts)

### Installation
1. Download, install and open the [Vortex Mod Manager](https://www.nexusmods.com/site/mods/1?tab=files)﻿.
2. Select **Games** on the left side bar, search for **Final Fantasy XII** and select **Manage**.
3. Download and install both the [External File Loader v1.4.1+](https://www.nexusmods.com/finalfantasy12/mods/170?tab=files) and [LUA Loader v1.7.1+](https://www.nexusmods.com/finalfantasy12/mods/171?tab=files).
4. Select **Releases** on the right sidebar of this page.
5. Under **Assets**, click on **TheInsurgentsGraveyard.7z** to download the mod archive.
6. Select **Mods** on the left side bar of Vortex and drag and drop the downloaded **TheInsurgentsGraveyard.7z** archive into the **Drop File(s)** field.
7. Click on the dropdown arrow in the **Actions** column next to row with **TheInsurgentsGraveyard.7z** as the mod name and select **Install**.
8. Choose which features you would like to install, click on finish once you are done and **make sure to watch out for any notification in the top right corner to both deploy and enable the mod.**

### Updating
1. Uninstall the mod via the **Vortex Mod Manager**.
2. Download and install the mod as shown in the installation instructions above.
3. Update mod requirements if necessary.

### Uninstallation
Uninstall the mod via the **Vortex Mod Manager**.

## How To Use (Cheat Table):
1. Download and install [Cheat Engine v7.6+](https://1drv.ms/f/c/553d7cdb377276fa/EsPztaWGPONLkUQrLd8bKxwBQZRkNtlE3K1_wRo-8rdgJw).
2. Select **Releases** on the right sidebar of this page.
3. Under **Assets**, click on **TheInsurgentsGraveyard.CT** to download the mod as a cheat table.
4. Open the game and Cheat Engine.
5. Click on **File** -> **Open Process**.
6. Select the game and click on **Open**.
7. Click on **File** -> **Open File**.
8. Navigate to the cheat table and click on **Open**.

## Compatibility
- Fully compatible with other mods, unless they incorporate the same changes which should be mentioned in their description.
- Fully compatible with all game languages.
- Fully compatible with existing saves (no new game required).
- Only compatible with either the latest Steam (1.0.4.0) or Microsoft Store (1.0.1.0) version of the game.

## Notes
- Instead of using both the **No Overhead Party HP Bars** and **No Overhead Foe HP Bars** option, you can also just use the **No Overhead HP Bars** option of [The Insurgent's Vision](https://www.nexusmods.com/finalfantasy12/mods/220).

## Troubleshooting
Before reporting any bugs, please ensure that your issue is even tied to this mod. This means disabling every other mod first and testing whether or not your issue still persists. If it does, feel free to contact me on the modding community discord [here](https://discord.gg/UBrP6ME).

## My Other Mods
- [The Insurgent's Companions](https://www.nexusmods.com/finalfantasy12/mods/217)
- [The Insurgent's Bountiful Bundle](https://www.nexusmods.com/finalfantasy12/mods/185)
- [The Insurgent's Vision](https://www.nexusmods.com/finalfantasy12/mods/220)
- [The Insurgent's Manifesto](https://www.nexusmods.com/finalfantasy12/mods/218)
- [The Insurgent's Toolkit](https://www.nexusmods.com/finalfantasy12/mods/160)

## Permissions
You are not allowed to upload, modify, convert, or use any of these assets, except for personal use, which must not be shared, distributed, or incorporated into any public use under any circumstances.

## Changelog

### v1.4.0
- Added a fomod that allows easy installation of all scripts via a mod manager (e.g. Vortex).
- **Always Spawn Treasures**: Added a config that allows toggling whether or not unique treasures should be able to spawn more than once.
- Added a **No Overhead Party HP Bars** and **No Overhead Foe HP Bars** option (remnants from The Insurgent's Vision v1.2.0).
- Cleaned up a few scripts.

### v1.3.0
- Added an **Always Spawn Treasures** option.
- Added an **Always Steal Everything** option.
- Minor formatting fixes.

### v1.2.0
- All scripts are now also available as a cheat table.
- Added support for the Microsoft Store version of the game (cheat table only).
- **No Overlay Map**: Is now actually disabled where as before only its toggle was.
- **No Speed Mode**: Is now actually disabled where as before only its toggle was.
- **Camera Position**: Removed because it is incompatible with The Insurgent's Vision, whose Free Camera option is superior to this script anyway.
- Cleaned up a few scripts.

### v1.1.0
- Added a **Summons For All** option.
- **No Restoration On Save Crystals**: Fixed an issue where cutscenes that initiated a boss fight wouldn't restore any HP, MP, etc.
- **No Restoration On Save Crystals**: Fixed an issue where certain cutscenes could trigger a crash.

### v1.0.0
- Initial release.
