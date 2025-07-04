# Minecraft Options Synchronization System

This system provides intelligent synchronization of Minecraft settings across different instances in PrismLauncher.

## 📋 Overview

The system consists of three main files that work together to manage Minecraft configurations:
- **Startup Script**: Loads saved settings when Minecraft starts.
- **Exit Script**: Saves current settings when Minecraft closes
- **Merge Script**: Intelligently combines settings without overwriting existing configurations

## 📁 Files

### Core Scripts
- `options-changer-startup.bat` - Pre-launch configuration loader
- `options-changer-exit.bat` - Post-game configuration saver
- `merge-options.ps1` - PowerShell script for intelligent options merging

### Configuration Files
- `options.txt` - Minecraft settings (graphics, controls, gameplay)
- `servers.dat` - Server list (binary format)

## 🚀 How It Works

### Startup Process
1. **Pre-Launch**: `options-changer-startup.bat` runs before Minecraft starts
2. **Smart Merge**: Uses PowerShell script to merge saved settings with existing ones
3. **Preservation**: Keeps existing custom settings while updating changed/new ones
4. **Fallback**: If merge fails, falls back to simple copy operation

### Exit Process
1. **Post-Game**: `options-changer-exit.bat` runs after Minecraft closes
2. **Intelligent Update**: Only saves changed or new settings to central location
3. **Server Sync**: Copies server list normally (binary file)

## 🔨 Installation

### Prerequisites
- Windows with PowerShell support
- PrismLauncher with custom commands enabled

### Setup
1. Place all files in: `C:\Users\[username]\AppData\Roaming\PrismLauncher\addons\`
2. Configure PrismLauncher instance settings:
   - **Pre-launch command**: `"C:\Users\[username]\AppData\Roaming\PrismLauncher\addons\options-changer-startup.bat"`
   - **Post-exit command**: `"C:\Users\[username]\AppData\Roaming\PrismLauncher\addons\options-changer-exit.bat"`

### Environment Variables
The scripts use `%INST_MC_DIR%` which is automatically provided by PrismLauncher pointing to the current instance directory.

## 🔧 Features

### Smart Options Merging
- ✅ **Preserves existing settings** - Your custom configurations stay intact
- ✅ **Updates changed values** - Modified settings are synchronized
- ✅ **Adds new settings** - New options from mods/updates are included
- ✅ **Alphabetical sorting** - Keeps options.txt organized
- ✅ **Detailed logging** - Shows what was added/updated during merge

### Server List Handling
- ✅ **Direct copy** - `servers.dat` is copied as-is (binary format)
- ✅ **Full synchronization** - Complete server list is maintained

### Error Handling
- ✅ **Fallback mechanism** - If PowerShell merge fails, uses simple copy
- ✅ **Path validation** - Checks if source and destination paths exist
- ✅ **Error reporting** - Clear messages for troubleshooting

## 🎯 Use Cases

### Multi-Instance Gaming
- Play different modpacks with consistent settings
- Switch between Minecraft versions seamlessly
- Maintain personalized controls across all instances

### Settings Backup
- Automatic backup of all configuration changes
- Central storage for easy restoration
- Version-safe settings management

### Mod Compatibility
- Handles new mod settings automatically
- Preserves existing mod configurations
- Smart integration of updated mod options

## 🛠️ Troubleshooting

### Common Issues

#### PowerShell Execution Policy
If you get execution policy errors:
```batch
powershell -ExecutionPolicy Bypass -File merge-options.ps1
```

#### Script Not Found
Ensure paths in batch files match your actual file locations:
```batch
set "DEST_DIR=C:\Users\[your-username]\AppData\Roaming\PrismLauncher\addons\"
```

#### Merge Failures
The system automatically falls back to simple copy if merge fails, so your settings are never lost.

### Debug Information
Check console output for detailed information about:
- Which settings were added/updated
- File operation results
- Error messages and fallback actions

### Current Version
- ✅ Intelligent options.txt merging
- ✅ PowerShell-based merge logic
- ✅ Fallback to simple copy
- ✅ Detailed logging
- ✅ Error handling

### Previous Version
- Basic file copying
- No merge intelligence
- Overwrote all settings

## 📞 Support

For issues or improvements:
1. Check console output for error messages
2. Verify file paths and permissions
3. Test with simple copy fallback
4. Check PowerShell execution policy

---

*This system ensures your Minecraft settings are always synchronized intelligently across all your PrismLauncher instances while preserving your custom configurations.*
