# noctty config importer
# Copies config.ghostty from noctty AppData directory back to dotfiles
# Usage: import\main.bat  (recommended — runs all import scripts including this one)
#    or: powershell -ExecutionPolicy Bypass -File import\noctty.ps1

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$dotfilesDir = Split-Path -Parent (Split-Path -Parent $scriptDir)
$src = Join-Path $env:LOCALAPPDATA "noctty\config.ghostty"
$dest = Join-Path $dotfilesDir "config\noctty\config.ghostty"

if (-not (Test-Path $src)) {
    Write-Error "Source file not found: $src"
    exit 1
}

Copy-Item -Path $src -Destination $dest -Force
Write-Host "Imported config.ghostty -> $dest"
