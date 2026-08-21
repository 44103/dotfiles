# Scoop installer
# Usage: powershell -ExecutionPolicy Bypass -File scoop.ps1

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# ── Buckets ──────────────────────────────────────────────────────────────────

$buckets = @(
    "main"
    "extras"
    "versions"
    "nerd-fonts"
    "zeldrisho https://github.com/zeldrisho/scoop-bucket"
)

foreach ($bucket in $buckets) {
    $name = $bucket.Split(" ")[0]
    if (-not (scoop bucket list | Select-String -Quiet $name)) {
        Write-Host "Adding bucket: $name"
        scoop bucket add $bucket
    } else {
        Write-Host "Bucket already added: $name"
    }
}

# ── Packages ─────────────────────────────────────────────────────────────────

$packages = @(
    # Dev tools
    "main/git"
    "main/nodejs"
    "main/vim"
    "main/codex"
    "extras/vscode"
    "extras/dbeaver"

    # Terminal
    "extras/alacritty"
    "extras/windows-terminal"
    "main/pwsh"

    # Fonts
    "nerd-fonts/Hack-NF"
    "nerd-fonts/Recursive-NF"

    # Utilities
    "extras/powertoys"
    "main/win32yank"
    "zeldrisho/topnotify"
    "extras/keyviz"

    # Security
    "extras/bitwarden"

    # Media
    "extras/googlechrome"
    "extras/vlc"
    "main/ffmpeg"
    "extras/inkscape"
    "extras/shotcut"
    "extras/screentogif"
    "extras/pdf-xchange-editor"

    # Communication
    "extras/slack"
)

foreach ($pkg in $packages) {
    $name = $pkg.Split("/")[-1]
    if (-not (scoop list | Select-String -Quiet "^$name\s")) {
        Write-Host "Installing: $name"
        scoop install $pkg
    } else {
        Write-Host "Already installed: $name"
    }
}

Write-Host ""
Write-Host "Done."
