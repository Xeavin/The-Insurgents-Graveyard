# Lua Scripts

## Installation

1. Download, install and open the [Vortex Mod Manager](https://www.nexusmods.com/site/mods/1?tab=files)﻿.
2. Select **Games** on the left side bar, search for **Final Fantasy XII** and select **Manage**.
3. Download and install both the [External File Loader v1.4.3+](https://www.nexusmods.com/finalfantasy12/mods/170?tab=files) and [LUA Loader v1.7.2+](https://www.nexusmods.com/finalfantasy12/mods/171?tab=files).
4. Select **Releases** on the right sidebar of this page.
5. Under **Assets**, click on **TheInsurgentsGraveyard.7z** to download the mod archive.
6. Select **Mods** on the left side bar of Vortex and drag and drop the downloaded **TheInsurgentsGraveyard.7z** archive into the **Drop File(s)** field.
7. Click on the dropdown arrow in the **Actions** column next to row with **TheInsurgentsGraveyard.7z** as the mod name and select **Install**.
8. Install the features you want and **watch out for notifications to deploy and enable the mod.**

## Updating

1. Uninstall the mod via the **Vortex Mod Manager**.
2. Download and install the mod as shown in the installation instructions above.
3. Update mod requirements if necessary.
4. Reapply any changes done to the configuration files.

## Uninstallation

Uninstall the mod via the **Vortex Mod Manager**.

## Configuration

Some scripts include configurable parameters that are saved into their own configuration file (e.g. **{game}/x64/scripts/config/{script}Config.json**). This configuration file can be modified via any text editor.

### Refresh

A configuration file is loaded when the game launches. If it was modified while the game is open, it will be reloaded without requiring a game restart.

If it couldn't be reloaded (e.g. due to syntax errors), the last one that could be will be used instead, unless there never was one (e.g. on game start) in which case default values will be used until all errors are resolved.
