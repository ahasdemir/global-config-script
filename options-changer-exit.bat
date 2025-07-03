@echo off
set "SOURCE_FILE_1=%INST_MC_DIR%\options.txt"
set "SOURCE_FILE_2=%INST_MC_DIR%\servers.dat"

set "DEST_DIR=C:\Users\ahmet\AppData\Roaming\PrismLauncher\addons\"

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