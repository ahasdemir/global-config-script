@echo off
set "SOURCE_FILE_1=C:\Users\ahmet\AppData\Roaming\PrismLauncher\addons\options.txt"
set "SOURCE_FILE_2=C:\Users\ahmet\AppData\Roaming\PrismLauncher\addons\servers.dat"
set "DEST_DIR=%INST_MC_DIR%"

REM Check if destination directory exists
if not exist "%DEST_DIR%" (
    echo Destination directory does not exist: "%DEST_DIR%"
    exit /b 1
)

if exist "%SOURCE_FILE_1%" (
    copy "%SOURCE_FILE_1%" "%DEST_DIR%"
    if errorlevel 1 (
        echo Failed to copy: "%SOURCE_FILE_1%"
        exit /b 1
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