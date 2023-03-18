#!/bin/zsh

set -u

has() {
  which "$1" >/dev/null 2>&1
  return $?
}

DOTPATH=~/.dotfiles

git clone --depth=1 --recursive https://github.com/44103/dotfiles.git "$DOTPATH"

setopt EXTENDED_GLOB
for rcfile in "${DOTPATH}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${HOME}/.${rcfile:t}"
done

cd "${DOTPATH}"

for f in .??*; do
  [ "$f" = ".git" ] && continue
  [ "$f" = ".gitconfig.local.template" ] && continue
  [ "$f" = ".gitmodules" ] && continue

  ln -snfv "${DOTPATH}/$f" ~/
done

mkdir -p ~/.config
for f in config/??*; do
  ln -snfv "${DOTPATH}/$f" ~/.config
done

for dir; do
  for f in $dir/??*; do
    ln -snfv "${DOTPATH}/$f" ~/.config
  done
done

exec `which zsh` -l

cd ${HOME}
