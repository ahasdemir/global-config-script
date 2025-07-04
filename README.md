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
1. Place all files in: `C:\Users\[username]\AppData\Roaming\PrismLauncher\global-config-script\`
2. (Optional, but recommended) 
   - Replace the `C:\Users\[username]\AppData\Roaming\PrismLauncher\global-config-script\options.txt` file with the backup from `C:\Users\[username]\AppData\Roaming\PrismLauncher\global-config-script\backup-original-for-avoid-corruptions\options.txt`.
3. Configure PrismLauncher instance settings:
   - **Pre-launch command**: `"C:\Users\[username]\AppData\Roaming\PrismLauncher\global-config-script\options-changer-startup.bat"`
   - **Post-exit command**: `"C:\Users\[username]\AppData\Roaming\PrismLauncher\global-config-script\options-changer-exit.bat"`

### Environment Variables
The scripts use `%INST_MC_DIR%` which is automatically provided by PrismLauncher pointing to the current instance directory.

## 🔧 Features

### Smart Options Merging
- ✅ **Preserves existing settings** - Your custom configurations stay intact
- ✅ **Updates changed values** - Modified settings are synchronized
- ✅ **Only updates existing options** - New options are not added (prevents Minecraft from deleting unused options)
- ✅ **Excludes protected settings** - Certain settings are never transferred
- ✅ **Alphabetical sorting** - Keeps options.txt organized
- ✅ **Detailed logging** - Shows what was updated/excluded/skipped during merge

### Server List Handling
- ✅ **Direct copy** - `servers.dat` is copied as-is (binary format)
- ✅ **Full synchronization** - Complete server list is maintained

### Error Handling
- ✅ **Fallback mechanism** - If PowerShell merge fails, uses simple copy
- ✅ **Path validation** - Checks if source and destination paths exist
- ✅ **Error reporting** - Clear messages for troubleshooting

## 📊 Merge Logic

### When merging `options.txt`:
```
Existing Setting + Same Value = No Change
Existing Setting + New Value = Update
Missing Setting + New Value = Skip (not added)
Old Setting + Not in New = Keep
Excluded Setting = Never Transfer
```

### Protected Settings
The following settings are **never transferred** between instances:
- `resourcePacks` - Resource pack list (allows different packs per instance)
- `incompatibleResourcePacks` - Incompatible resource pack list

### Example Merge Output:
```
Excluded: resourcePacks (not transferred)
Excluded: incompatibleResourcePacks (not transferred)
Skipped: newModSetting (not present in instance options)
Updated: fov = 0.45 (was: 0.5)
Updated: renderDistance = 16 (was: 12)
Merge completed successfully!
Updated 2 existing settings, excluded 2 settings, skipped 1 new settings
```

## 🎯 Use Cases

### Multi-Instance Gaming
- Play different modpacks with consistent settings
- Switch between Minecraft versions seamlessly
- Maintain personalized controls across all instances
- **Use different resource packs** - Each instance keeps its own resource pack list

### Settings Backup
- Automatic backup of all configuration changes
- Central storage for easy restoration
- Version-safe settings management
- **Protected settings** - Critical instance-specific settings are preserved

### Mod Compatibility
- Handles new mod settings automatically
- Preserves existing mod configurations
- Smart integration of updated mod options
- **Instance-specific exclusions** - Certain mod settings stay per-instance

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
set "DEST_DIR=C:\Users\[your-username]\AppData\Roaming\PrismLauncher\global-config-script\"
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
