#!/bin/zsh

set -u

has() {
  which "$1" >/dev/null 2>&1
  return $?
}

DOTPATH=~/.dotfiles
if has "git"; then
  git clone --recursive https://github.com/44103/dotfiles.git "$DOTPATH"
  elif has "curl" || has "wget"; then
    tarball="https://github.com/44103/dotfiles/archive/main.tar.gz"
    if has "curl"; then
      curl -L "$tarball"
    elif has "wget"; then
      wget -O - "$tarball"
    fi | tar zxv
    mv -f dotfiles-main "$DOTPATH"
else
  echo "curl or wget required"
fi

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$DOTPATH}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

for f in "$DOTPATH"/.??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitconfig.local.template" ] && continue
    [ "$f" = ".gitmodules" ] && continue

    ln -snfv "$f" ~/
done
