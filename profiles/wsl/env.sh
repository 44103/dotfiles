# WSL-specific environment variables

# WSL home directory
export WINHOME=$(wslpath "$(powershell.exe -c 'echo $env:USERPROFILE')")
