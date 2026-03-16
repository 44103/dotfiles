#!/bin/zsh

set -u

has() {
  which "$1" >/dev/null 2>&1
  return $?
}

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
  export PATH="$HOME/.local/share/mise/bin:$PATH"
fi

# Install tools via mise
echo "Installing tools via mise..."
# starship is directly supported, sheldon is installed from github releases
mise use -g starship github:rossmacarthur/sheldon node@lts pnpm@latest

# Set git commit template
git config --global commit.template "${DOTPATH}/config/git/commit_template"

echo "Installation complete. Please restart your shell."
