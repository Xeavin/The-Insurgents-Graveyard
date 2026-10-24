# The Insurgent's Graveyard

A collection of FFXII scripts that were either requested and created for others, or are too niche to be included in any of my other mods.

## Features

### Fixed MP Regeneration

Multiplies the number of steps necessary to gain 1 MP by the speed mode multiplier. So it is no longer possible to exploit the speed-mode by running around in circles to regain a lot of MP.

### Forced Keyboard Button Prompts

Forces the game to always use keyboard button prompts, as long as no controller is used.

### Forced PS Button Prompts

Forces the game to always use PS button prompts, regardless of the type of controller used.

### Forced Xbox Button Prompts

Forces the game to always use XBOX button prompts, regardless of the type of controller used.

### Levelbound LP

Prevents party members from gaining license points when defeating low-level foes.

License points are now only gained if a foe's level is equal to or higher than that of a party member.

The minimum required foe level can be adjusted with an offset to make license point gain easier or harder.

#### Formula

Foe Level ≥ Party Member Level + Offset

#### Examples

| Party Member Level | Offset | Required Foe Level |
| :----------------: | :----: | :----------------: |
| 5                  | 0      | 5 or higher        |
| 5                  | 1      | 6 or higher        |
| 5                  | -1     | 4 or higher        |

### Lift Story Restrictions

Allows the usage of the following things from the start of the game: Party-, equipment-, licenses- and gambits menu, world and minimap, clan primer and much more.

### No Mist Bar Restoration On Save Crystals

Touching save crystals will no longer restore mist bars. Furthermore, mist bars will not be restored after a cutscene that initiates a boss battle.

### No Overhead Party HP Bars

Removes the overhead HP bars of the party.

### No Overhead Foe HP Bars

Removes the overhead HP bars of foes (incl. friendly).

### No Overlay Map

Disables the overlay map which is shown on the middle of the screen after pressing/clicking the Tab/L3/LS key/button.

### No Restoration On Save Crystals

Touching save crystals will no longer restore HP, MP, etc. or remove any negative status effects.

### No Sounds

Disables all sound input from the game. It's mostly meant to be used when modding, so you don't have to constantly adjust the sound settings per savefile, nor get your ear blasted every time you enter the main menu.

### No Speed Mode

Disables the speed mode feature of the game.

### No Teleport Requirement

Teleport stones are no longer required when using the save crystal teleport option.

### Priority Escape

Party members will prioritize following the player party leader and idling over confuse, berserk, gambits, and more when fleeing.

### Removable Targeted Party Members

Enables the ability to remove any targeted party members from the party.

## Usage

These features are available both as a [Lua script](docs/lua-scripts.md) (Steam) and as a [cheat table](docs/cheat-table.md) (Steam/Microsoft Store).

The former works automatically once installed where as the latter needs to be run manually after every game launch.

Follow the links for installation and usage instructions.

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

For a list of my other mods, you can check out the following pages:

- [Nexusmods](https://www.nexusmods.com/finalfantasy12/users/65929636?tab=user+files)
- [Github](https://github.com/Xeavin?tab=repositories)

## Permissions

You are not allowed to upload, modify, convert, or use any of these assets, except for personal use, which must not be shared, distributed, or incorporated into any public use under any circumstances.

## Changelog

See [CHANGELOG](CHANGELOG.md) for a chronologically ordered list of notable changes in each version.
