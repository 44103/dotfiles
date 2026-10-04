# noctty config installer
# Copies config.ghostty from dotfiles to the noctty AppData directory
# Usage: setup\main.bat  (recommended — runs all setup scripts including this one)
#    or: powershell -ExecutionPolicy Bypass -File setup\noctty.ps1

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$dotfilesDir = Split-Path -Parent (Split-Path -Parent $scriptDir)
$src = Join-Path $dotfilesDir "config\noctty\config.ghostty"
$destDir = Join-Path $env:LOCALAPPDATA "noctty"
$dest = Join-Path $destDir "config.ghostty"

if (-not (Test-Path $src)) {
    Write-Error "Source file not found: $src"
    exit 1
}

if (-not (Test-Path $destDir)) {
    New-Item -ItemType Directory -Path $destDir | Out-Null
    Write-Host "Created directory: $destDir"
}

Copy-Item -Path $src -Destination $dest -Force
Write-Host "Copied config.ghostty -> $dest"
