@echo off
set "SOURCE_FILE_1=%appdata%\PrismLauncher\global-config-script\options.txt"
set "SOURCE_FILE_2=%appdata%\PrismLauncher\global-config-script\servers.dat"
set "DEST_DIR=%INST_MC_DIR%"

REM Check if destination directory exists
if not exist "%DEST_DIR%" (
    echo Destination directory does not exist: "%DEST_DIR%"
    exit /b 1
)

if exist "%SOURCE_FILE_1%" (
    echo Merging options.txt with intelligent update...
    powershell -ExecutionPolicy Bypass -File "%appdata%\PrismLauncher\global-config-script\merge-options.ps1" -SourceFile "%SOURCE_FILE_1%" -DestFile "%DEST_DIR%\options.txt"
    if errorlevel 1 (
        echo Failed to merge options.txt, falling back to simple copy
        copy "%SOURCE_FILE_1%" "%DEST_DIR%"
        if errorlevel 1 (
            echo Failed to copy: "%SOURCE_FILE_1%"
            exit /b 1
        )
    )
) else (
    echo Source file does not exist: "%SOURCE_FILE_1%"
)

if exist "%SOURCE_FILE_2%" (
    copy "%SOURCE_FILE_2%" "%DEST_DIR%"
    if errorlevel 1 (
        echo Failed to copy: "%SOURCE_FILE_2%"
        exit /b 1
    )
) else (
    echo Source file does not exist: "%SOURCE_FILE_2%"
)

echo Copy operations completed successfully.
exit /b 0