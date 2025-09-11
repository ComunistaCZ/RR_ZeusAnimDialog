# RR Zeus Animation Dialog - Multiplayer Ready

A Zeus module for Arma 3 that allows game masters to easily apply animations to units through a user-friendly dialog interface.

## Features
- ✅ **Full multiplayer support** - Works on dedicated servers and hosted servers
- ✅ **Client-side UI** - Dialog opens only for the Zeus operator who placed the module
- ✅ **Synchronized animations** - All players see the same animations in real-time
- ✅ **JIP (Join In Progress) compatibility** - Late-joining players see active animations
- ✅ **Multilingual support** - English and Czech localization
- ✅ **Preset animation library** - Quick access to commonly used animations
- ✅ **Custom animation support** - Enter any animation classname manually
- ✅ **First-use reliability** - Dialog opens correctly on first module placement

## Usage

### Basic Usage
1. Open Zeus interface (default key: Y)
2. Navigate to **Modules → [44.RR] Zeus → Play Animation**
3. Place the module on or near the unit(s) you want to animate
4. The dialog will open automatically on your client
5. Either:
   - Select a preset animation from the dropdown menu, OR
   - Enter a custom animation classname in the text field
6. Click **"Start"** to apply the animation to selected units
7. To stop animations, select **"STOP Animation"** and click Start

### Module Placement Options
- **Direct placement on unit**: Animates that specific unit
- **Placement near units**: Animates the nearest unit within 10 meters
- **Synced to units**: Sync the module to multiple units in Zeus

## Preset Animations

| Animation | Description | Requirements |
|-----------|-------------|--------------|
| **STOP Animation** | Stops all animations and returns unit to normal | None |
| **Praying [Loop]** | Unit kneels in prayer position | Western Sahara cDLC |
| **Injured person [Loop]** | Sitting wounded animation | None |
| **Surrender [Loop]** | Hands behind head surrender pose | None |
| **Speech 1-5 [Loop]** | Various speaking/gesturing animations | Arma 2 content |
| **Protest 1-3 [Loop]** | Protest and crowd animations | Arma 2 content |
| **Listening civ** | Civilian listening stance | None |

## Technical Details

### Multiplayer Architecture
- **Module execution**: Server-side with client distribution
- **Dialog handling**: Client-side only (Zeus operator)
- **Animation sync**: RemoteExec to all clients (JIP compatible)
- **Network optimization**: Minimal traffic, commands sent once

### File Structure
```
RR_ZeusAnimDialog/
├── config.cpp              # Main configuration
├── dialogs.hpp            # GUI definitions
├── stringtable.xml        # Localization
├── functions/
│   ├── fn_initFunctions.sqf    # PostInit setup
│   ├── fn_playAnimation.sqf    # Module entry point
│   ├── fn_openDialog.sqf       # Dialog opener
│   ├── fn_fillCombo.sqf        # Populate dropdown
│   ├── fn_doAnimation.sqf      # Process animation
│   └── fn_executeAnim.sqf      # Apply animation
└── readme.md
```

### Compatibility
- **Arma 3**: All versions
- **DLCs**: Optional (some animations require specific DLCs)
- **Mods**: Compatible with ACE3, TFAR, and most common mods
- **Servers**: Dedicated, hosted, and singleplayer

## Troubleshooting

### Dialog doesn't open
- Ensure the mod is loaded on both server and client
- Check that you have Zeus permissions
- Verify no other mods are blocking GUI creation

### Animations not syncing
- Confirm all clients have the mod loaded
- Check that required DLCs are installed for specific animations
- Verify network connectivity between server and clients

### First-use issues (Fixed in v2.1)
- The module now properly initializes on first use
- Global functions are defined at mission start via postInit

## Custom Animations

You can use any valid Arma 3 animation classname. Some examples:
- `AmovPercMstpSnonWnonDnon` - Default standing
- `AmovPsitMstpSnonWnonDnon_ground` - Sitting on ground
- `Acts_listeningToRadio_Loop` - Listening to radio
- `Acts_Kore_IdleNoWeapon_loop` - Casual idle

Find more animations:
- [Arma 3 Animation Viewer](https://community.bistudio.com/wiki/Arma_3:_Animations)
- In-game Animation Viewer (Editor > Tools > Animation Viewer)
- [RR Zeus Animations Expansion](https://steamcommunity.com/sharedfiles/filedetails/?id=3566269019) - Mod for additional animations (APL-SA)

## Planned Features
- **Activation only on selected unit** – the animation can be applied only to the unit where the module is placed  
- **Animation category selection** – dropdown menus for easier filtering and selection of animations  
- **Improved custom animation support** – better support for adding custom animations, likely via CBA settings  
- **Enhanced localization** – more accurate and higher-quality translations (CZ/EN) with the possibility to add more languages  
- **Loop support** – the ability to enable looping even for animations that are not looped by default  
- **Combat Ready mode** – animations are automatically interrupted if the unit switches to combat mode  


## Changelog

### v2.1 (Current)
- Fixed first-use initialization issue
- Added postInit function for reliable setup
- Improved error handling and logging
- Better detection of dedicated vs hosted servers

### v2.0 
- Added full multiplayer support
- Client-side dialog handling
- Improved network synchronization
- JIP compatibility

### v1.0
- Initial release
- Basic animation dialog
- Local functionality only

## Known Issues
- Some DLC animations may not work without owning the respective DLC
- Very complex animations might need manual reset before applying new ones

## Credits
- **Author**: [44.RR] 44. Ravens Regiment (Comunista_CZ)
- **Version**: 2.1.43

## License
This project is licensed under the **Arma Public License - No Derivatives (APL-ND)**.  
See the [Bohemia Interactive Community Wiki](https://www.bohemia.net/community/licenses/arma-public-license-nd) for details.

## Support
For issues, suggestions, or contributions, please contact the 44.RR Regiment team or submit issues through the appropriate channels.

---
*This module is designed for Zeus game masters to enhance roleplay and mission scenarios through easy animation control.*