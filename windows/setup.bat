@echo off
:: Windows setup entry point
:: Run each setup script in order with ExecutionPolicy Bypass

echo === Windows Setup ===
echo.

echo [1/1] Scoop packages...
powershell -ExecutionPolicy Bypass -File "%~dp0scoop.ps1"
if %errorlevel% neq 0 (
    echo ERROR: scoop.ps1 failed.
    exit /b %errorlevel%
)

echo.
echo === Setup complete ===
