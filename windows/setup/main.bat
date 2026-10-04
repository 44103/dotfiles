@echo off
:: Windows setup entry point
:: Add new .ps1 scripts to the list below in the desired execution order
setlocal enabledelayedexpansion

set scripts=scoop.ps1 noctty.ps1

echo === Windows Setup ===
echo.

set i=0
for %%s in (%scripts%) do (
    set /a i+=1
    echo [!i!] %%s...
    powershell -ExecutionPolicy Bypass -File "%~dp0%%s"
    if errorlevel 1 (
        echo ERROR: %%s failed.
        exit /b 1
    )
    echo.
)

echo === Setup complete ===
