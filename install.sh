#!/bin/zsh

set -u

# Set locale to suppress warnings in containers
export LC_ALL=C.UTF-8

has() {
  type "$1" >/dev/null 2>&1
  return $?
}

# Parse options
PRESET=""
while getopts "s:" opt; do
  case $opt in
    s)
      PRESET="$OPTARG"
      ;;
    \?)
      echo "Usage: $0 [-s preset]"
      echo "  Presets: wsl, container (default)"
      exit 1
      ;;
  esac
done

DOTPATH=~/.dotfiles

# Clone if not exists
if [ ! -d "$DOTPATH" ]; then
  git clone --depth=1 --recursive https://github.com/44103/dotfiles.git "$DOTPATH"
fi

cd "${DOTPATH}"

# Create symbolic links for dotfiles (excluding .git, .zprezto, etc.)
echo "Linking dotfiles..."
for f in .??*; do
  [ "$f" = ".git" ] && continue
  [ "$f" = ".gitconfig.local.template" ] && continue
  [ "$f" = ".gitmodules" ] && continue
  [ "$f" = ".zprezto" ] && continue

  ln -snfv "${DOTPATH}/$f" ~/
done

# Create symbolic links for configs in ~/.config/
echo "Linking configs..."
mkdir -p ~/.config
for f in config/*; do
  # Link both files and directories under config/ to ~/.config/
  ln -snfv "${DOTPATH}/$f" ~/.config/
done

# Install mise if not exists
if ! has "mise"; then
  echo "Installing mise..."
  curl https://mise.jdx.dev/install.sh | sh
  # Add mise to path for the rest of the script
  export PATH="$HOME/.local/bin:$PATH"
  rehash
fi

# Install tools via mise
if has "mise"; then
  echo "Installing tools via mise..."
  mise use -g starship github:rossmacarthur/sheldon node@lts pnpm@latest
else
  echo "mise not found even after installation attempt."
  exit 1
fi

# Set git commit template
git config --global commit.template "${DOTPATH}/config/git/commit_template"

# Apply preset-specific configurations
case "$PRESET" in
  wsl)
    echo "Applying WSL preset..."
    # Create local.d directory
    mkdir -p "${DOTPATH}/local.d"
    # Write MISE_ENV setting
    echo 'export MISE_ENV="dev,local"' > "${DOTPATH}/local.d/00-env.sh"
    # Symlink WSL-specific env
    ln -snfv "${DOTPATH}/profiles/wsl/env.sh" "${DOTPATH}/local.d/30-wsl-env.sh"
    # Set MISE_ENV for current session and install dev tools
    if has "mise"; then
      echo "Installing dev tools via mise..."
      export MISE_ENV="dev,local"
      mise install
    fi
    ;;
  container|"")
    # Default/container preset: no additional setup needed
    ;;
  *)
    echo "Unknown preset: $PRESET"
    echo "Available presets: wsl, container"
    exit 1
    ;;
esac

echo "Installation complete. Please restart your shell."
